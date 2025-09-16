Return-Path: <netdev+bounces-223768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA6B7CE96
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1467A6EF4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5F2EE5FE;
	Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvg20BOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734A2EDD69
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064492; cv=none; b=Hpm43LovDv7wgzwd9dLeA9o/LYWXIOSSPVvUAfGwvT+BOE6LfsbV4h7u8wjgi8GWzS6Tx8LYcOTGpsEoIR+9O8PTxh7yi/pDclhfwSJxFjt2eSX+sTo9Gh/DCBytznRrd6wzzH2xiUjA1VplEwwN3kWhqZ3irbg8l8JDYyL3LJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064492; c=relaxed/simple;
	bh=xhrI9hGY7/fPSfl3MtJ4RNk07hbSHWs0Iclm93kP48M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXRv4eJp48eQQtNDAG2bVuMxROAqPFBwc5Xkbt6mOmugc/bAmjOlnJ+h1UAvBn5KaFbtU6CFVYfP+akLLGzgl16yt883R3GAl0ZhGRhCDJrYiHXtWvlhlZ23rW8obURdd5X0PT7Mv9An18K40iaxOjycMfar9rHyYrGQ7QjfWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvg20BOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085A4C4CEF9;
	Tue, 16 Sep 2025 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064491;
	bh=xhrI9hGY7/fPSfl3MtJ4RNk07hbSHWs0Iclm93kP48M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvg20BOBcCjSLEOvp2suMY8wmrcrlBW4qOR2ef4UOEOCMXsuHGfWwaypokMiZDKsj
	 8Yt7rQVyZbtSt6aZLKnU9kJOkAxYwdTzhzHPUW2bHXzWmbSOCg1giOz4WIuyZQEdOs
	 fmTUu3i92ozY0gViMTB1hk+AMa1mhAQ0fAr0xAwqEz17Rzkeath/kPkauPTbqPCTgn
	 fgap53/FZs18BtxtbHsz5FPTayY2h4PkGiQVeJGUxhT2gZQmUax55LuGp2xv6uyWZP
	 Zcbp6c6vgC4Q/taR7oICh29jvj1QZnB316hbYqTfKJZ5BGO/oqv/LAiU8lPlUwkwwj
	 j1akG/+C8k/iA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	lee@trager.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/9] eth: fbnic: use fw uptime to detect fw crashes
Date: Tue, 16 Sep 2025 16:14:13 -0700
Message-ID: <20250916231420.1693955-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916231420.1693955-1-kuba@kernel.org>
References: <20250916231420.1693955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we only detect FW crashes when it stops responding
to heartbeat messages. FW has a watchdog which will reset it
in case of crashes. Use FW uptime sent in the ownership and
heartbeat messages to detect that the watchdog has fired
(uptime went down).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - include TIME attrs in parsing policies
v2:
 - update commit msg
 - use uptime the entry from OWNERSHIP enum in ownership rsp parsing
 - update comment about heartbeat rsp
v1: https://lore.kernel.org/20250912201428.566190-3-kuba@kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic.h    |  4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  7 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 17 ++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 311c7dda911a..09058d847729 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -84,6 +84,10 @@ struct fbnic_dev {
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
 
+	/* Firmware time since boot in milliseconds */
+	u64 firmware_time;
+	u64 prev_firmware_time;
+
 	struct fbnic_fw_log fw_log;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index ec67b80809b0..be7f2dc88698 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -198,9 +198,16 @@ enum {
 
 enum {
 	FBNIC_FW_OWNERSHIP_FLAG			= 0x0,
+	FBNIC_FW_OWNERSHIP_TIME			= 0x1,
 	FBNIC_FW_OWNERSHIP_MSG_MAX
 };
 
+enum {
+	FBNIC_FW_HEARTBEAT_UPTIME               = 0x0,
+	FBNIC_FW_HEARTBEAT_NUMBER_OF_MESSAGES   = 0x1,
+	FBNIC_FW_HEARTBEAT_MSG_MAX
+};
+
 enum {
 	FBNIC_FW_START_UPGRADE_ERROR		= 0x0,
 	FBNIC_FW_START_UPGRADE_SECTION		= 0x1,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 6e580654493c..9b39a73e4c35 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -495,6 +495,11 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 
 	fbd->last_heartbeat_request = req_time;
 
+	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
+	 * detection until we receive the second uptime in a heartbeat resp.
+	 */
+	fbd->prev_firmware_time = 0;
+
 	/* Set heartbeat detection based on if we are taking ownership */
 	fbd->fw_heartbeat_enabled = take_ownership;
 
@@ -660,6 +665,7 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 }
 
 static const struct fbnic_tlv_index fbnic_ownership_resp_index[] = {
+	FBNIC_TLV_ATTR_U64(FBNIC_FW_OWNERSHIP_TIME),
 	FBNIC_TLV_ATTR_LAST
 };
 
@@ -671,10 +677,14 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
 	/* Count the ownership response as a heartbeat reply */
 	fbd->last_heartbeat_response = jiffies;
 
+	/* Capture firmware time for logging and firmware crash check */
+	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_OWNERSHIP_TIME);
+
 	return 0;
 }
 
 static const struct fbnic_tlv_index fbnic_heartbeat_resp_index[] = {
+	FBNIC_TLV_ATTR_U64(FBNIC_FW_HEARTBEAT_UPTIME),
 	FBNIC_TLV_ATTR_LAST
 };
 
@@ -685,6 +695,9 @@ static int fbnic_fw_parse_heartbeat_resp(void *opaque,
 
 	fbd->last_heartbeat_response = jiffies;
 
+	/* Capture firmware time for logging and firmware crash check */
+	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);
+
 	return 0;
 }
 
@@ -706,6 +719,7 @@ static int fbnic_fw_xmit_heartbeat_message(struct fbnic_dev *fbd)
 		goto free_message;
 
 	fbd->last_heartbeat_request = req_time;
+	fbd->prev_firmware_time = fbd->firmware_time;
 
 	return err;
 
@@ -766,7 +780,8 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
 		return;
 
 	/* Was the last heartbeat response long time ago? */
-	if (!fbnic_fw_heartbeat_current(fbd)) {
+	if (!fbnic_fw_heartbeat_current(fbd) ||
+	    fbd->firmware_time < fbd->prev_firmware_time) {
 		dev_warn(fbd->dev,
 			 "Firmware did not respond to heartbeat message\n");
 		fbd->fw_heartbeat_enabled = false;
-- 
2.51.0



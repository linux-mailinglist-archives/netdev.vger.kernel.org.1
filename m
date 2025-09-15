Return-Path: <netdev+bounces-223160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A7B5814A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E017A29D6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60E22A813;
	Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQRpxcIr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55222A4E5
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951596; cv=none; b=fMqb0334/JdOGBgm1BJCOGUanTaV2XL2wWnUfW7unmL70qsuf6MlVQfh5x53fS3OSlrYZ045ZXzOyuvrubpmGG7O9CIDzCpizCpLlEl54tojeWW+pLLD/8Cpuv85I9XQBCLbG3KsMtBg1/Fu4/+pTMZbccFJ/J12VbThSPTNx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951596; c=relaxed/simple;
	bh=ePbVqM0zbezlKSNpiEe2bCEduDYhvBmDFf8EjThdaOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spFvi4f52Y2q5VH/LFf1Xq8aL0f6AQK/98oyJca3cWjJ6ghomilLEKbq1f9tQqIJjJ7n+g6HZncbTck/IgB9K19Mh1nYA/H1P/oWHHA0r+AvwQ1sOHB+r3Na2ZAV/3TSCsJDpWhou1LJhwzEnyBoIV6AkWHS25210NuyqNLi2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQRpxcIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D955EC4CEFA;
	Mon, 15 Sep 2025 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951596;
	bh=ePbVqM0zbezlKSNpiEe2bCEduDYhvBmDFf8EjThdaOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQRpxcIrCeTmL6kRb7SrDrsuSOy/Wz0fFqYFunt9Nq2A8FbNeAx9kNDgSA3OtvHBl
	 CPw8agD3u1IuY5z9braghEZPcE+2zhIa4pS9UNJV9DLk6OJn1tc58CixjTPrbOsAqI
	 RN2PL1t4B1To9H3yN02liBfEV6R8l11J9qomayXVRHEC1yfmE8wd+6RNrR9OaohANA
	 juaeWKdXe8pss+mfhRlzZ/YODFjYlub63xPPmzPrJ8vq+5kc1qUckBDx/ceDa2AODW
	 D+Kw2E3UGg6UIqHOA0WGlR5GRd8Lcsx+97tQ4+/rIdv8eZOZofrXTV5SY8o2mI53wQ
	 DNXs1768lVBJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/9] eth: fbnic: use fw uptime to detect fw crashes
Date: Mon, 15 Sep 2025 08:53:05 -0700
Message-ID: <20250915155312.1083292-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915155312.1083292-1-kuba@kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - update commit msg
 - use uptime the entry from OWNERSHIP enum in ownership rsp parsing
 - update comment about heartbeat rsp
v1: https://lore.kernel.org/20250912201428.566190-3-kuba@kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic.h    |  4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  7 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index 6e580654493c..e40dfd645414 100644
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
 
@@ -671,6 +676,9 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
 	/* Count the ownership response as a heartbeat reply */
 	fbd->last_heartbeat_response = jiffies;
 
+	/* Capture firmware time for logging and firmware crash check */
+	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_OWNERSHIP_TIME);
+
 	return 0;
 }
 
@@ -685,6 +693,9 @@ static int fbnic_fw_parse_heartbeat_resp(void *opaque,
 
 	fbd->last_heartbeat_response = jiffies;
 
+	/* Capture firmware time for logging and firmware crash check */
+	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);
+
 	return 0;
 }
 
@@ -706,6 +717,7 @@ static int fbnic_fw_xmit_heartbeat_message(struct fbnic_dev *fbd)
 		goto free_message;
 
 	fbd->last_heartbeat_request = req_time;
+	fbd->prev_firmware_time = fbd->firmware_time;
 
 	return err;
 
@@ -766,7 +778,8 @@ void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd)
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



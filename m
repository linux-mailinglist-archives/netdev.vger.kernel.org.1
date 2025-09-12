Return-Path: <netdev+bounces-222706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC25B5577D
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B485677E8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4CC2C159A;
	Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5IBB2dq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7D2C11CB
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708080; cv=none; b=KrVWZ6sYyAOL/aSYrN7uqK12gkfAqBZuJNks1k3G2G16SqrRZaYJ6bU8oR9NCYbJGd5H4ZwB5yrhMGGbR9Qf79WDX/kNo/9RBukWZOhF6is36bxOTi6Vh1kCa3kE2aw/wWtq1FxyhtEUG3EbD+MGEG1TTz96FhQO4lk2NqrEUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708080; c=relaxed/simple;
	bh=fbPjo0K1jVEMC8iPpmxYt9jSNwjsEqjvsi59ZrIJ3qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKrTQQySUBMJA9xy40w0s66GGMiokZr/ynkncNrwFRaa/NcgJYox9tUXyP8O24I6vLC5z+6cyrQ1q//XnBO4ZJtzaATPfVIHHLp2UJFSF+e7VU0OQi6AUMhFpNW3/Uj+iolL1ecuNlflAmp396OfDmgcHjyotbkbUrlEGEp8Bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5IBB2dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C887C4CEF4;
	Fri, 12 Sep 2025 20:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708079;
	bh=fbPjo0K1jVEMC8iPpmxYt9jSNwjsEqjvsi59ZrIJ3qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5IBB2dqC3CxeqqP6dvmlJTMrBj3LqqapcDSOKAdu9ObGY5WZaBExvPy9+EmFvgaf
	 73nkNgks9v/MQZcsiWCW98YXlUuIV4nuRSNUSAlX29SI7iiJ0RLiIf2D5DZ/b6FKOr
	 uYGlKVtS/QkVKNb+gM1j5M9B/4mGeHRWxqnSJqHHe+0XplSCx3ndGqTCq+6P6PJpzS
	 cuFOQTHEEcp1qCeJFkYTGehzT1Wd+73oy6ZCPyBatDgnmLjH/u05DTH0KUIGV1tLvK
	 1NWT9yxKnJNjYb4F6BXVv6kSGqremIz2R4XFLV8rgPoPf7pEop/YtDrj6B7HXTYhPD
	 19l46CMJUyWXg==
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
Subject: [PATCH net-next 2/9] eth: fbnic: use fw uptime to detect fw crashes
Date: Fri, 12 Sep 2025 13:14:21 -0700
Message-ID: <20250912201428.566190-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912201428.566190-1-kuba@kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we only detect FW crashes when it stops responding
to heartbeat messages. FW has a watchdog which will reset it
in case of crashes. Use FW uptime sent in the heartbeat messages
to detect that the watchdog has fired.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h    |  4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  6 ++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index ec67b80809b0..c1de2793fa3d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -201,6 +201,12 @@ enum {
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
index 6e580654493c..72f750eea055 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -495,6 +495,11 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
 
 	fbd->last_heartbeat_request = req_time;
 
+	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
+	 * detection now that we received a response from firmware.
+	 */
+	fbd->prev_firmware_time = 0;
+
 	/* Set heartbeat detection based on if we are taking ownership */
 	fbd->fw_heartbeat_enabled = take_ownership;
 
@@ -671,6 +676,9 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
 	/* Count the ownership response as a heartbeat reply */
 	fbd->last_heartbeat_response = jiffies;
 
+	/* Capture firmware time for logging and firmware crash check */
+	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);
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



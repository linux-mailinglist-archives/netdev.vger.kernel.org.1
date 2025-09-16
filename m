Return-Path: <netdev+bounces-223770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4EB7C879
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48FE3B4661
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0224C2EFDB7;
	Tue, 16 Sep 2025 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcU9DD2m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1C2ED168
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064492; cv=none; b=XHpOs3u6dO7ItD6fTY4Jnikrvg7bE06gD0si0Ps7XVPts2a0qMeCgW7cN3DgLfZvFvr0d8djTOQwxRLArI/zcy+SkMsq/dviLWK4DfSaMF8X9KeLqOR5/RLntqnRqpss0vRYifQDuWaNElItFuhwoiRY30L1fK+Ja0OyJr8khU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064492; c=relaxed/simple;
	bh=iiTXvAWMeiIojkQ4WKrDZT7g+dTt4xtQ7yJwQSsnprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxfxi+jo6moZc3KujPBn9bksBDpbmYxjFMUjUguY5Ih7jLNT5E7JQD3pIrVOcal68u+XeQbeswLOT72CJuDA84Qwt04ly8RVt3yOVV/F/giumvqmBrKnlaqLzzWLCnieAi7amIBQG1S+QnhvyCd5mx5Z3V3Hjg4jxTWllDerwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcU9DD2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFE0C4CEEB;
	Tue, 16 Sep 2025 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758064492;
	bh=iiTXvAWMeiIojkQ4WKrDZT7g+dTt4xtQ7yJwQSsnprs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcU9DD2mtKhb8Hc8yarw+PPJggp5722aoSkT+45Q+KqpwRwDHgbkL2Dpb5mMS2tYH
	 BEX4W6Z29H/SqOHNNqE4OJyV8qzVMgYoMQ2KstRKY7G0YIqqJU365si7/APeuyuBbr
	 37S3WDykEvTz7TJF7Q8JXmGH7c7izIOXh6o+AydVtIMqlnspMugAVphAs/8ceNdRwJ
	 HyzdhOWE/CRspMZBxD+G0mF84utLgcImTO5Gki55DYjinT2k6dQP+1oMqR5IMOS0G3
	 gdwbW7yzq5xmgecJwLqE91SK85dhzo18Q5c7UslSR1IZYFTWWhQdRMtJ1YYhshAleu
	 9fmCcZ3qVlPUQ==
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
Subject: [PATCH net-next v3 4/9] eth: fbnic: reprogram TCAMs after FW crash
Date: Tue, 16 Sep 2025 16:14:15 -0700
Message-ID: <20250916231420.1693955-5-kuba@kernel.org>
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

FW may mess with the TCAM after it boots, to try to restore
the traffic flow to the BMC (it may not be aware that the host
is already up). Make sure that we reprogram the TCAMs after
detecting a crash.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h     |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 23 ++++++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c | 21 +++++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 09058d847729..b364c2f0724b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -191,6 +191,8 @@ void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd);
 void fbnic_dbg_init(void);
 void fbnic_dbg_exit(void);
 
+void fbnic_rpc_reset_valid_entries(struct fbnic_dev *fbd);
+
 void fbnic_csr_get_regs(struct fbnic_dev *fbd, u32 *data, u32 *regs_version);
 int fbnic_csr_regs_len(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index e246c50c8bf3..53690db14d77 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -167,6 +167,20 @@ void fbnic_down(struct fbnic_net *fbn)
 	fbnic_flush(fbn);
 }
 
+static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
+{
+	if (fbnic_fw_xmit_ownership_msg(fbd, true)) {
+		dev_err(fbd->dev, "NIC failed to take ownership\n");
+
+		return -1;
+	}
+
+	fbnic_rpc_reset_valid_entries(fbd);
+	__fbnic_set_rx_mode(fbd);
+
+	return 0;
+}
+
 static void fbnic_health_check(struct fbnic_dev *fbd)
 {
 	struct fbnic_fw_mbx *tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
@@ -182,13 +196,8 @@ static void fbnic_health_check(struct fbnic_dev *fbd)
 	if (tx_mbx->head != tx_mbx->tail)
 		return;
 
-	/* TBD: Need to add a more thorough recovery here.
-	 *	Specifically I need to verify what all the firmware will have
-	 *	changed since we had setup and it rebooted. May just need to
-	 *	perform a down/up. For now we will just reclaim ownership so
-	 *	the heartbeat can catch the next fault.
-	 */
-	fbnic_fw_xmit_ownership_msg(fbd, true);
+	if (fbnic_fw_config_after_crash(fbd))
+		dev_err(fbd->dev, "Firmware recovery failed after crash\n");
 }
 
 static void fbnic_service_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index d944d0fdd3b7..7f31e890031c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -596,6 +596,21 @@ static void fbnic_clear_macda(struct fbnic_dev *fbd)
 	}
 }
 
+static void fbnic_clear_valid_macda(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_VALID) {
+			fbnic_clear_macda_entry(fbd, idx);
+
+			mac_addr->state = FBNIC_TCAM_S_UPDATE;
+		}
+	}
+}
+
 static void fbnic_write_macda_entry(struct fbnic_dev *fbd, unsigned int idx,
 				    struct fbnic_mac_addr *mac_addr)
 {
@@ -1223,3 +1238,9 @@ void fbnic_write_rules(struct fbnic_dev *fbd)
 			fbnic_update_act_tcam(fbd, i);
 	}
 }
+
+void fbnic_rpc_reset_valid_entries(struct fbnic_dev *fbd)
+{
+	fbnic_clear_valid_act_tcam(fbd);
+	fbnic_clear_valid_macda(fbd);
+}
-- 
2.51.0



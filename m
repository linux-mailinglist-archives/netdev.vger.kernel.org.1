Return-Path: <netdev+bounces-222708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E0B55781
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258FB1B20082
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9332DF71D;
	Fri, 12 Sep 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFzhpkWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65E2D130A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708081; cv=none; b=tV7gtLXVgpsaO2v7CC9fCtIeCO5IFxuZ8vsfPhJcrEmrPcQRY8Od/gU9siFqrdZ79QNngWxGpvwhfof3IQWsaL3ClIif8hWlyIfMKnPV/Nuv+8+/ZESF1OpsHC5IRDP89yB7odGh5BxEUcbfey6Kw4eNIXv4uXnaAuyGX65oQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708081; c=relaxed/simple;
	bh=lsL19QOPs81C4miiDeNDbTbsrKu7PHFFSsvNRZE+h/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLzpO82bzV5yfIaHTiMCKPZR3ccADrHiJMddPkXSRJe/ULNc/qsQvwlHA7lH6JjjqpwWunHZCA7l7dTgR+njWR38BE2+1n27FsT0HPteslrWm5r3T5xjSKcjjlxSOEWJFQzmLr9SSz3+eOnONCPHIdw2ITxo26B4lExlr2oGvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFzhpkWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0FEC4CEF8;
	Fri, 12 Sep 2025 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757708080;
	bh=lsL19QOPs81C4miiDeNDbTbsrKu7PHFFSsvNRZE+h/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFzhpkWb625AKm1Sl2xdPFaEasSmL8ucGQGT78MRFasJTrJvKARUTNZsfpNctcIOR
	 qWhQ1EzlcdJK1WHue8GsoFsRsuOMVmHU9vh07RcNkapA2noBnj0LDMTMCYbi9LI0A/
	 1uVcPUvFrsbdG8EkgaP8qS8QUdRBwGynUWDlQCCkRr7A9E1fsERJs/rnCfCNr6e6UQ
	 J4nGgdy5+1SJaJMXbL+I/XtVsi8r0EBWIlRdiD4F8tyL8bWKqY6Fg1l/73SsVL45Rv
	 trVwzYRLJvHXarj4XeQZ/Cuw5MesQjUvXbCabxfh9b7JiruG9krxJy73RIFgQp2rFH
	 5A0DaXMK0m5Xg==
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
Subject: [PATCH net-next 4/9] eth: fbnic: reprogram TCAMs after FW crash
Date: Fri, 12 Sep 2025 13:14:23 -0700
Message-ID: <20250912201428.566190-5-kuba@kernel.org>
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

FW may mess with the TCAM after it boots, to try to restore
the traffic flow to the BMC (it may not be aware that the host
is already up). Make sure that we reprogram the TCAMs after
detecting a crash.

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



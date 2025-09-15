Return-Path: <netdev+bounces-223162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68348B58149
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C14174D47
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999B233155;
	Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgccEuip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6989231A24
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951597; cv=none; b=S9gsOFjLGGETThlTDcwvNMf7b0b859LBdw8KrZA+iSxGdWyuibooGYtYG2pDGYbCUOGG8ag0ij6d34ROASShaeKUbt/1ZKzhvuJ/EOl20PY7qHeOOvuqbWcpjOsOqN5dW0RI+V5bdu4LAopvOF6JQuA3z8vKTjydlpCHs5Sg804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951597; c=relaxed/simple;
	bh=lsL19QOPs81C4miiDeNDbTbsrKu7PHFFSsvNRZE+h/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvsRqDDFKDipgVWuTZ5KG9JeXiX7tQ6qZmdvy2yUGZ89u5aV+0vD+nUcZTwacu+zwZbw0A0r3lerhaXoDDBpvqmpuSljv5QR0lBdsYF23x0SsxzJbEW/+QDuHEfPXTCKzuuKZ/DGLugdKGNpdZr6c1gbYajDts03K3L8GNgosfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgccEuip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF93C4CEFB;
	Mon, 15 Sep 2025 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951597;
	bh=lsL19QOPs81C4miiDeNDbTbsrKu7PHFFSsvNRZE+h/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgccEuipCcBcMmn0/QJnwx1XC2bBBDKqAazDVCK7VA3jze0Eh9LM2C/oDB4hw82ad
	 R6wip+Z8VvEmUz4HxcGh9SlJkxocgQOkIxoq8Xsnmv0IlBQ7/DZTJrXzzbb/2LQba1
	 Sgp9Yor+0BIpbSFw77hgDGyGLwSfUMHQ2AU6zcV7cQcJ+Q3Vu1FdnGiLd/1YSaA4lN
	 7Uxqd6+VklJrzOd+dpmKzyDCTiWmud54RJb3HyPg1B2VmiBCrJ6KHzXsLCZRNjMaBO
	 6LCdmVG8QUxLBLHND0notLZhPcRUz1X2KmBlDTLq+06XV+/7EZl/XlKi5YIBLu+Ccs
	 3FCntW30CfSpA==
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
Subject: [PATCH net-next v2 4/9] eth: fbnic: reprogram TCAMs after FW crash
Date: Mon, 15 Sep 2025 08:53:07 -0700
Message-ID: <20250915155312.1083292-5-kuba@kernel.org>
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



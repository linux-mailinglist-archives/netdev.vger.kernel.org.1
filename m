Return-Path: <netdev+bounces-277597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGO2LlF02WnXpwgAu9opvQ
	(envelope-from <netdev+bounces-277597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:06:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2493DD162
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F741301BEF4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDB3DCD85;
	Fri, 10 Apr 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrEojve5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE7394783
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858767; cv=none; b=D8kFpHj1katB6WAdov0++Um0Wa6u5Ou38c4qH2V+JxwvdlISVwEE/X5TPPI0CDJiXgeMiGNfU2L2G5kq3f+qhjo5Nfb/vTeJiLbJO7MrN8zO2HnL2FtqxlTJaqO6sccysm03m+ZYR1cMrSCxpSwevojX6tfBJygusv9KivpHoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858767; c=relaxed/simple;
	bh=bCcl5UOrdtPlsdetM6cs63vgz5dFlpaseW2DXO7P3bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cu3xWZ0b+4jSoXZeFPGj1CsXk1v9tMQwLpZcXorofy7wZHtUWudE9yclUZzOJVKYVSzEDgamonhHPPbNGOFZLyIpLCwpC7wVR5ZlpgtaNeqxwMC/KvtzTnz2r3LE5Diy5rV5oVxBEa0Gz6ymWNlyg9/nZADbc7eTVMK5BJdl7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrEojve5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C74C19421;
	Fri, 10 Apr 2026 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858767;
	bh=bCcl5UOrdtPlsdetM6cs63vgz5dFlpaseW2DXO7P3bw=;
	h=From:Date:Subject:To:Cc:From;
	b=BrEojve5DwwLPSNPgbpJ6eOfMhJOj3xeERNBKWpfNc8iYz97Gd9UyoCGwhCD9vkuV
	 pFzKbPGBpa3at66hqPPxUnagpX1L9FO4MCude7IX6v/OnQPX+lqkNyh5CJQeIM5jgV
	 upQTKCmdjkCA5RHltjmjeRfHNALwolUmPyyq1+r2AIVfvRnatns5xFsi5+b8JSsVRs
	 fupAw5s6btSa5BGCkRT3mtB+eFNM7QDe3iZ+Ou+hNNPdIc3ytuFOY5YLlhLaP7FeZw
	 P47FOmc9fwGERpxmiMP7IfX8ZOjg0WDwyPD16+Hah9XGfeP6WymGJgASkYE5HXjuOJ
	 S+ejHGwmqHdhw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 11 Apr 2026 00:05:29 +0200
Subject: [PATCH net-next] net: airoha: Wait for TX to complete in
 airoha_dev_stop()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-airoha-fix-ndo_stop-v1-1-caddaa181739@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAQBQFf0X32a21RPkVSYuD+3JXu5uU/LvN4
 zTNPBQRBJH64qGAS6J4zVCVBS2H0x0sa2ayxramqQw7Cf5wvMnNuvopJn8y5nmrl842DoZyeQZ
 k/18HUiRW3InG9/0A47rS0W8AAAA=
X-Change-ID: 20260410-airoha-fix-ndo_stop-ebbf3c724ae0
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277597-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D2493DD162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wait for TX to complete in airoha_dev_stop routine before stopping the
TX DMA and run airoha_qdma_cleanup_tx_queue routine. Moreover,
start/stop TX/RX NAPIs in ndo_open()/ndo_stop() callbacks in order to be
sure the TX NAPIs have completed before stopping the TX DMA engine in
airoha_dev_stop routine.
Please note this patch on the commit 'b1c803d5c816 ("net: airoha: Rework
the code flow in airoha_remove() and in airoha_probe() error path")'
that is available only in net-next tree at the moment.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 44 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8e4b043af4bc..9e40c8f375c1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1662,10 +1662,12 @@ static int airoha_dev_open(struct net_device *dev)
 		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
 		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
+	if (!atomic_fetch_inc(&qdma->users)) {
+		airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
+				GLOBAL_CFG_TX_DMA_EN_MASK |
+				GLOBAL_CFG_RX_DMA_EN_MASK);
+		airoha_qdma_start_napi(qdma);
+	}
 
 	if (port->id == AIROHA_GDM2_IDX &&
 	    airoha_ppe_is_enabled(qdma->eth, 1)) {
@@ -1684,18 +1686,26 @@ static int airoha_dev_stop(struct net_device *dev)
 	struct airoha_qdma *qdma = port->qdma;
 	int i, err;
 
-	netif_tx_disable(dev);
 	err = airoha_set_vip_for_gdm_port(port, false);
 	if (err)
 		return err;
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
-		netdev_tx_reset_subqueue(dev, i);
-
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    FE_PSE_PORT_DROP);
 
+	netif_tx_disable(dev);
 	if (atomic_dec_and_test(&qdma->users)) {
+		u32 val;
+
+		/* Wait for TX to complete */
+		err = read_poll_timeout(airoha_qdma_rr, val,
+					!(val & GLOBAL_CFG_TX_DMA_BUSY_MASK),
+					USEC_PER_MSEC, 100 * USEC_PER_MSEC,
+					false, qdma, REG_QDMA_GLOBAL_CFG);
+		if (err)
+			return err;
+
+		airoha_qdma_stop_napi(qdma);
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
 				  GLOBAL_CFG_RX_DMA_EN_MASK);
@@ -1708,6 +1718,9 @@ static int airoha_dev_stop(struct net_device *dev)
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++)
+		netdev_tx_reset_subqueue(dev, i);
+
 	return 0;
 }
 
@@ -3048,9 +3061,6 @@ static int airoha_probe(struct platform_device *pdev)
 	if (err)
 		goto error_netdev_free;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_start_napi(&eth->qdma[i]);
-
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
 			continue;
@@ -3061,20 +3071,17 @@ static int airoha_probe(struct platform_device *pdev)
 		err = airoha_alloc_gdm_port(eth, np);
 		if (err) {
 			of_node_put(np);
-			goto error_napi_stop;
+			goto error_netdev_unregister;
 		}
 	}
 
 	err = airoha_register_gdm_devices(eth);
 	if (err)
-		goto error_napi_stop;
+		goto error_netdev_unregister;
 
 	return 0;
 
-error_napi_stop:
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_stop_napi(&eth->qdma[i]);
-
+error_netdev_unregister:
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
@@ -3098,9 +3105,6 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_stop_napi(&eth->qdma[i]);
-
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 

---
base-commit: 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7
change-id: 20260410-airoha-fix-ndo_stop-ebbf3c724ae0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



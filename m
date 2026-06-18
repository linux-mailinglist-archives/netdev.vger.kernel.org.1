Return-Path: <netdev+bounces-300326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s+TTFo6MM2owDQYAu9opvQ
	(envelope-from <netdev+bounces-300326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF3469DCE3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:13:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jyN63kAH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300326-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F040C301AF75
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B741331EA5;
	Thu, 18 Jun 2026 06:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BF1A304A
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763211; cv=none; b=SalDLN0cJ2x9d5c2LVTwXO+Bk4yimfcaKaAua3230uepyufaakGFSAjzLawKMFsJeyNsI5jsFeKnqJBPWlSIacLUs/h157AvLNO34JmgyZi7IkzN5yXkuFUea9Fnwv5IdW33pYmKyo4tfqCSuilvPx5/ne06ZZB/zbIIoRloBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763211; c=relaxed/simple;
	bh=s+FMJOZWdlg+5eEdPRB7yz2quBG/fLXp/yKkXK7RHcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GdI9cRC/dydIAglFA2Xs56Uv/aUkZuBC4PvaLX4YltQXCNHdhYbOOehWjLPiGdFNz3FaseDBQVVjSlCt7YGr3mEnd/HANl4Wz6cyC8jOyEgN9jEx7OmocE4p/3UKjMuoCbHEfH0+J5gTRgHrJo/qaeEyFASPrJruHeVAPevrqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyN63kAH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919D11F000E9;
	Thu, 18 Jun 2026 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781763210;
	bh=HkPc/71jgImUZdgRfROJckyG+AOsxAcO+4dgMgHoUDM=;
	h=From:Date:Subject:To:Cc;
	b=jyN63kAHB8NJnjZ2eD77LPsaMR8mKg9QspW3LgscVl8jFFbea/xk7/uKdfdhVd1SQ
	 Obd2IHOMis2D03NHVDxE2qhTVreyYW9pie1LJA4MJmTo7axBqS8uWFSX5267yi1slT
	 EfRVyr8oIf/uwxTMVIahphHrPBFbq8HOowI59CnCIAj7/gOnQsL32xqTWoxzxp5YlG
	 k0aP63YpCHbbHTnv2GwTfmm0fm9D9DrkUeeUSVz1n0OCK/bfGwOp9mGpmMcVIjCVoy
	 B4ixUEAVeaZDFBP5CcgA3Ncym03lBS6GdwrHcYoPCuxDHYKa74qbqDprF8mq6I17Nw
	 /ix7jlMq4KmSw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 18 Jun 2026 08:13:16 +0200
Subject: [PATCH net] net: airoha: fix BQL underflow and UAF in shared QDMA
 TX ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-airoha-bql-fixes-v1-1-ffd2c2089518@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LTQqAIBBA4avErBtQox+6SrTQmmogrDQiEO/e0
 PLj8RJECkwR+iJBoIcjH16gywKmzfqVkGcxGGUa1egOLYdjs+iuHRd+KeJSt87MWnV1W4FsZ6A
 /yDWApxvGnD8aCKhbZwAAAA==
X-Change-ID: 20260618-airoha-bql-fixes-f57b2d108573
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BF3469DCE3

When multiple netdevs share a QDMA TX ring and one device is stopped,
netdev_tx_reset_subqueue() zeroes that device's BQL counters while its
pending skbs remain in the shared HW TX ring. When NAPI later completes
those skbs via netdev_tx_completed_queue(), the already-zeroed
dql->num_queued counter underflows.
Moreover, in the airoha_remove() path, netdevs are unregistered
sequentially while skbs from previously unregistered netdevs may still
reference freed net_device memory via skb->dev, causing a use-after-free
during BQL accounting.
Fix both issues:
- Remove netdev_tx_reset_subqueue() from airoha_dev_stop() so pending
  skbs are completed naturally by NAPI with proper BQL accounting.
- Add netdev_tx_completed_queue() in airoha_qdma_cleanup_tx_queue()
  to properly account for skbs freed during queue teardown.
- Introduce airoha_qdma_tx_disable() to stop TX on all registered
  netdevs for a given QDMA instance under RTNL lock.
- Move DMA engine start/stop into probe/remove and
  airoha_qdma_cleanup(), ensuring TX queues are cleaned up while all
  netdevs are still registered and skb->dev is valid.

Fixes: 6df0488dc9dd ("net: airoha: fix BQL accounting in airoha_qdma_cleanup_tx_queue()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 95 ++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..4d6a061cd779 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1004,6 +1004,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 		e = &q->entry[index];
 		skb = e->skb;
+		e->skb = NULL;
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
@@ -1147,6 +1148,42 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 	return 0;
 }
 
+static void airoha_qdma_tx_disable(struct airoha_qdma *qdma)
+{
+	struct airoha_eth *eth = qdma->eth;
+	int i;
+
+	/* Protect netdev->reg_state and netif_tx_disable() calls. */
+	rtnl_lock();
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!dev)
+				continue;
+
+			if (dev->qdma != qdma)
+				continue;
+
+			netdev = netdev_from_priv(dev);
+			if (netdev->reg_state != NETREG_REGISTERED)
+				continue;
+
+			netif_tx_disable(netdev);
+		}
+	}
+
+	rtnl_unlock();
+}
+
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
 	struct airoha_qdma *qdma = q->qdma;
@@ -1158,13 +1195,20 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 	for (i = 0; i < q->ndesc; i++) {
 		struct airoha_queue_entry *e = &q->entry[i];
 		struct airoha_qdma_desc *desc = &q->desc[i];
+		struct sk_buff *skb = e->skb;
 
 		if (!e->dma_addr)
 			continue;
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
-		dev_kfree_skb_any(e->skb);
+		if (skb) {
+			struct netdev_queue *txq;
+
+			txq = skb_get_tx_queue(skb->dev, skb);
+			netdev_tx_completed_queue(txq, 1, skb->len);
+			dev_kfree_skb_any(skb);
+		}
 		e->dma_addr = 0;
 		e->skb = NULL;
 		list_add_tail(&e->list, &q->tx_list);
@@ -1527,6 +1571,23 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 {
 	int i;
 
+	if (test_bit(DEV_STATE_INITIALIZED, &qdma->eth->state)) {
+		u32 status;
+
+		airoha_qdma_tx_disable(qdma);
+
+		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+				  GLOBAL_CFG_TX_DMA_EN_MASK |
+				  GLOBAL_CFG_RX_DMA_EN_MASK);
+		if (read_poll_timeout(airoha_qdma_rr, status,
+				      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
+						  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
+				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+				      qdma, REG_QDMA_GLOBAL_CFG))
+			dev_warn(qdma->eth->dev,
+				 "QDMA DMA engine busy timeout\n");
+	}
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		if (!qdma->q_rx[i].ndesc)
 			continue;
@@ -1837,9 +1898,6 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
 	qdma->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
@@ -1880,12 +1938,9 @@ static int airoha_dev_stop(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_qdma *qdma = dev->qdma;
-	int i;
 
 	netif_tx_disable(netdev);
 	airoha_set_vip_for_gdm_port(dev, false);
-	for (i = 0; i < netdev->num_tx_queues; i++)
-		netdev_tx_reset_subqueue(netdev, i);
 
 	if (--port->users)
 		airoha_set_port_mtu(dev->eth, port);
@@ -1893,19 +1948,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(qdma->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
-
-	if (!--qdma->users) {
-		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
-				  GLOBAL_CFG_TX_DMA_EN_MASK |
-				  GLOBAL_CFG_RX_DMA_EN_MASK);
-
-		for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
-			if (!qdma->q_tx[i].ndesc)
-				continue;
-
-			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
-		}
-	}
+	qdma->users--;
 
 	return 0;
 }
@@ -3413,8 +3456,12 @@ static int airoha_probe(struct platform_device *pdev)
 	if (err)
 		goto error_netdev_free;
 
-	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
+	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		airoha_qdma_start_napi(&eth->qdma[i]);
+		airoha_qdma_set(&eth->qdma[i], REG_QDMA_GLOBAL_CFG,
+				GLOBAL_CFG_TX_DMA_EN_MASK |
+				GLOBAL_CFG_RX_DMA_EN_MASK);
+	}
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_device_is_compatible(np, "airoha,eth-mac"))
@@ -3440,6 +3487,8 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
 
+	airoha_hw_cleanup(eth);
+
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 		int j;
@@ -3461,7 +3510,6 @@ static int airoha_probe(struct platform_device *pdev)
 		}
 		airoha_metadata_dst_free(port);
 	}
-	airoha_hw_cleanup(eth);
 error_netdev_free:
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
@@ -3477,6 +3525,8 @@ static void airoha_remove(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
 
+	airoha_hw_cleanup(eth);
+
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 		int j;
@@ -3497,7 +3547,6 @@ static void airoha_remove(struct platform_device *pdev)
 		}
 		airoha_metadata_dst_free(port);
 	}
-	airoha_hw_cleanup(eth);
 
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);

---
base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
change-id: 20260618-airoha-bql-fixes-f57b2d108573

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



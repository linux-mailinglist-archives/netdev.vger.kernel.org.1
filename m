Return-Path: <netdev+bounces-300683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GOUB1waNWoknAYAu9opvQ
	(envelope-from <netdev+bounces-300683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:30:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A06A53AA
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:30:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XtoHjbLM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300683-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300683-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4706430048CC
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242B372EEC;
	Fri, 19 Jun 2026 10:30:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758D369D40
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865048; cv=none; b=plRtyrtk+OQdFkGq/VlTKdceTAKqQVcoUpKGS07olZF7VR5vH7ib9ZaeiiQs+xQuNEFvevxzt3rjG4l13SAylcyo2dive9wMZoYHyC5/dYli3/WmOVCpOdRTTN6GfEowJC5xMUibLo5d4ODmziiceZVuHbVv1oe1GalY9rMeRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865048; c=relaxed/simple;
	bh=4K0dglllDz19oyxHnZnh9o8wSYaVxvzLGLnjgrAew2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X9xdEVUSUSZQy8U8rMt3xmCssofJIpR6DiERovPVkas1j8iSYnGfshG3v1XLs2I/8MvwQX8ttXx86OAw33ynJ3XZ459nRVIsl4KCnU4yUS5ahhRUWmFpwTXuOko+r3OWkv1v4hW73nly1oQRtIXWkj+stK7MNkd7IKmOFm63fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtoHjbLM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280201F000E9;
	Fri, 19 Jun 2026 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781865046;
	bh=axhmsIVyXAx+zeh0tLgf+IueV3XZEbuWwxiEovhFxwY=;
	h=From:Date:Subject:To:Cc;
	b=XtoHjbLM8nlm4XVWJekkRKxmgvyiNXeyen0PHsoLIoRPBX9lYJ21ZlT2oWM8QDp5n
	 mbshunc/Siir8Dh4KzKhnzF/Q8HQIiFC+SW0KrBSKXCDEOL/o03i53+bQw7hESayyZ
	 ahF5t8tzCIThCbQAj0RjzwvmXPJFfgouNJkjE34Nb5i6lMmzxTweEXGRTKHHG9kgHD
	 HuC2OiOFZ9MB2S7CbFU/HxrQ+VdYUlSgKk5OSgG1bAUMMlN7l4HAeLkBHE8be+PJNC
	 TawDd8SZGTlIk8rTqdsMOeq/N6DsAk51tsW9ZyXpB37bUX2H18zLx+26a/MRYNPLNU
	 8wsPjoCCkKUWQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 19 Jun 2026 12:30:28 +0200
Subject: [PATCH net v2] net: airoha: fix BQL underflow and UAF in shared
 QDMA TX ring
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-airoha-bql-fixes-v2-1-4351d6a24484@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQrCMBCEX6Xs2ZUk0jZ68j2kh/5smsWS6KYUp
 fTdDbl7nPn4ZnZIJEwJbtUOQhsnjiEHc6pg9H2YCXnKGYwyjWq0xZ4l+h6H94KOP5TQ1e1gJq1
 s3V4gay+hArL1gEArdLn0nNYo33Kz6YL+L24aNTo3mdEoe621vT9JAi3nKDN0x3H8ABbFUnG2A
 AAA
X-Change-ID: 20260618-airoha-bql-fixes-f57b2d108573
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-300683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 762A06A53AA

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
- Introduce airoha_qdma_tx_flush() to stop NAPI and flush BQL counters
  for all pending skbs while skb->dev references are still valid.
- Guard airoha_dev_xmit() with DEV_STATE_FLUSH to drop packets during
  teardown.
- Move DMA engine start into probe and stop into airoha_qdma_cleanup().

Fixes: a9c2ca61fec7 ("net: airoha: Support multiple net_devices for a single FE GDM port")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Introduce airoha_qdma_tx_flush() to account BQL in airoha_remove() or
  airoha_probe() error path.
- Fix possible NULL pointer dereference in airoha_qdma_cleanup().
- Introduce DEV_STATE_FLUSH().
- Move back airoha_hw_cleanup().
- Set proper Fixes tag.
- Link to v1: https://lore.kernel.org/r/20260618-airoha-bql-fixes-v1-1-ffd2c2089518@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 87 +++++++++++++++++++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..e81cd806b57b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1004,6 +1004,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 		e = &q->entry[index];
 		skb = e->skb;
+		e->skb = NULL;
 
 		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
@@ -1523,10 +1524,26 @@ static int airoha_qdma_init(struct platform_device *pdev,
 	return airoha_qdma_hw_init(qdma);
 }
 
-static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
+static void airoha_qdma_cleanup(struct airoha_eth *eth,
+				struct airoha_qdma *qdma)
 {
 	int i;
 
+	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
+		u32 status;
+
+		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
+				  GLOBAL_CFG_TX_DMA_EN_MASK |
+				  GLOBAL_CFG_RX_DMA_EN_MASK);
+		if (read_poll_timeout(airoha_qdma_rr, status,
+				      !(status & (GLOBAL_CFG_TX_DMA_BUSY_MASK |
+						  GLOBAL_CFG_RX_DMA_BUSY_MASK)),
+				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
+				      qdma, REG_QDMA_GLOBAL_CFG))
+			dev_warn(eth->dev,
+				 "QDMA DMA engine busy timeout\n");
+	}
+
 	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		if (!qdma->q_rx[i].ndesc)
 			continue;
@@ -1593,7 +1610,7 @@ static int airoha_hw_init(struct platform_device *pdev,
 	return 0;
 error:
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_cleanup(&eth->qdma[i]);
+		airoha_qdma_cleanup(eth, &eth->qdma[i]);
 
 	return err;
 }
@@ -1603,7 +1620,7 @@ static void airoha_hw_cleanup(struct airoha_eth *eth)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_cleanup(&eth->qdma[i]);
+		airoha_qdma_cleanup(eth, &eth->qdma[i]);
 	airoha_ppe_deinit(eth);
 }
 
@@ -1637,6 +1654,35 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
+static void airoha_qdma_tx_flush(struct airoha_qdma *qdma)
+{
+	int i;
+
+	airoha_qdma_stop_napi(qdma);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		struct airoha_queue *q = &qdma->q_tx[i];
+		int j;
+
+		if (!q->ndesc)
+			continue;
+
+		spin_lock_bh(&q->lock);
+		for (j = 0; j < q->ndesc; j++) {
+			struct airoha_queue_entry *e = &q->entry[j];
+			struct sk_buff *skb = e->skb;
+			struct netdev_queue *txq;
+
+			if (!skb)
+				continue;
+
+			txq = skb_get_tx_queue(skb->dev, skb);
+			netdev_tx_completed_queue(txq, 1, skb->len);
+		}
+		spin_unlock_bh(&q->lock);
+	}
+}
+
 static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
@@ -1837,9 +1883,6 @@ static int airoha_dev_open(struct net_device *netdev)
 	}
 	port->users++;
 
-	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
-			GLOBAL_CFG_TX_DMA_EN_MASK |
-			GLOBAL_CFG_RX_DMA_EN_MASK);
 	qdma->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
@@ -1880,12 +1923,9 @@ static int airoha_dev_stop(struct net_device *netdev)
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
@@ -1893,19 +1933,7 @@ static int airoha_dev_stop(struct net_device *netdev)
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
@@ -2191,6 +2219,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	u16 index;
 	u8 fport;
 
+	if (test_bit(DEV_STATE_FLUSH, &dev->eth->state))
+		goto error;
+
 	qid = airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
 	tag = airoha_get_dsa_tag(skb, netdev);
 
@@ -3413,8 +3444,12 @@ static int airoha_probe(struct platform_device *pdev)
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
@@ -3437,8 +3472,9 @@ static int airoha_probe(struct platform_device *pdev)
 	return 0;
 
 error_napi_stop:
+	set_bit(DEV_STATE_FLUSH, &eth->state);
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_stop_napi(&eth->qdma[i]);
+		airoha_qdma_tx_flush(&eth->qdma[i]);
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
@@ -3474,8 +3510,9 @@ static void airoha_remove(struct platform_device *pdev)
 	struct airoha_eth *eth = platform_get_drvdata(pdev);
 	int i;
 
+	set_bit(DEV_STATE_FLUSH, &eth->state);
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
-		airoha_qdma_stop_napi(&eth->qdma[i]);
+		airoha_qdma_tx_flush(&eth->qdma[i]);
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 41d2e7a1f9fb..f6dce5e74e02 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -92,6 +92,7 @@ enum {
 enum {
 	DEV_STATE_INITIALIZED,
 	DEV_STATE_REGISTERED,
+	DEV_STATE_FLUSH,
 };
 
 enum {

---
base-commit: a887f2c7da66a805a55fd8706d45faec85f646db
change-id: 20260618-airoha-bql-fixes-f57b2d108573

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



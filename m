Return-Path: <netdev+bounces-130369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3225E98A3D2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68D9281418
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3513118E346;
	Mon, 30 Sep 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkmDBejj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB018DF76
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701135; cv=none; b=lq/PUHpjWnUWpAzDlW2/e6xgLTN8R5ulFeucj3c26nSlU76qjFQpxGJXr0XVvyGGJFUXrKHX0k3nQYIpPZ9K4KHJ/Gin1f67UwVN/gmIJQ6Px+KlWnEapzt1VcZsvhHqXt+jCUw8jFDfoM9sQWEcztklDSr/JJYdUc/tr7gOn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701135; c=relaxed/simple;
	bh=2E4v7T24qXp0WYaYw6Eg3YjxMdh70IbNU9K6KfS9QWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QmIibkzyM1bLE2gfvlhQEFF5RTCzce3acIK/RqluN/2svm+thIK1Hf8c1qjtvSZaGUfP1ENKMMZKk7jLvCTCrM8tRkGRXze3PRJvZCW0p4djRhGLCO7/dmI5yPr5+QqrjpHX7NnOmHhKzi8b/uGyVk5Jz+q3Tf1dUx+Fp4yGwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkmDBejj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6EDC4CEC7;
	Mon, 30 Sep 2024 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727701134;
	bh=2E4v7T24qXp0WYaYw6Eg3YjxMdh70IbNU9K6KfS9QWc=;
	h=From:Date:Subject:To:Cc:From;
	b=DkmDBejjC5EV0i5N6yRjDJ7WNH91YSIY5hM5z1Ahd23gx5sWyIF7/7DHH49TRP80h
	 MIXs8AMXqdMkFG/6RlOgAPEui0pAs3JMArT9rjFjNoKADaXp3FjEMHsP4oxWdT/73G
	 UdEwYLGQ3XhPdXpCqxc4ry6PKz1/iHVS6l6b3QFrygnrO0EaDsyqOyzTGmtgbOlIXe
	 l6qmCRyUzy9donyXAUvma3o3jFwrfJsqBRjsVtj6jipjVroRFdsiiJp3UkvdTGtUTo
	 oSsgVD9MFVQ5IjRZ7Zwisb5duG7SM5qFzm5yY3YqR171+WxJ0xNW1sFi6hY09KsTMD
	 ggs8neTCs1K5g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 30 Sep 2024 14:58:35 +0200
Subject: [PATCH net-next] net: airoha: Implement BQL support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-en7581-bql-v1-1-064cdd570068@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHqg+mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3dQ8c1MLQ92kwhxdU1MjUzOzNCMDc4tUJaCGgqLUtMwKsGHRsbW
 1AD70SoFcAAAA
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

Introduce BQL support in the airoha_eth driver to avoid queuing to much
packets into the device hw queues and keep the latency small.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 930f180688e5..6dfde2828d93 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -786,6 +786,7 @@ struct airoha_hw_stats {
 };
 
 struct airoha_qdma {
+	struct airoha_gdm_port *port;
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
@@ -1658,6 +1659,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 	while (irq_q->queued > 0 && done < budget) {
 		u32 qid, last, val = irq_q->q[irq_q->head];
+		u32 bytes = 0, count = 0;
 		struct airoha_queue *q;
 
 		if (val == 0xff)
@@ -1684,7 +1686,6 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 			struct airoha_qdma_desc *desc = &q->desc[q->tail];
 			struct airoha_queue_entry *e = &q->entry[q->tail];
 			u32 desc_ctrl = le32_to_cpu(desc->ctrl);
-			struct sk_buff *skb = e->skb;
 			u16 index = q->tail;
 
 			if (!(desc_ctrl & QDMA_DESC_DONE_MASK) &&
@@ -1700,15 +1701,11 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 			WRITE_ONCE(desc->msg0, 0);
 			WRITE_ONCE(desc->msg1, 0);
 
-			if (skb) {
-				struct netdev_queue *txq;
-
-				txq = netdev_get_tx_queue(skb->dev, qid);
-				if (netif_tx_queue_stopped(txq) &&
-				    q->ndesc - q->queued >= q->free_thr)
-					netif_tx_wake_queue(txq);
+			if (e->skb) {
+				bytes += e->skb->len;
+				count++;
 
-				dev_kfree_skb_any(skb);
+				dev_kfree_skb_any(e->skb);
 				e->skb = NULL;
 			}
 
@@ -1716,6 +1713,16 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 				break;
 		}
 
+		if (qdma->port) {
+			struct netdev_queue *txq;
+
+			txq = netdev_get_tx_queue(qdma->port->dev, qid);
+			netdev_tx_completed_queue(txq, count, bytes);
+			if (netif_tx_queue_stopped(txq) &&
+			    q->ndesc - q->queued >= q->free_thr)
+				netif_tx_wake_queue(txq);
+		}
+
 		spin_unlock_bh(&q->lock);
 	}
 
@@ -2482,6 +2489,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	q->head = index;
 	q->queued += i;
 
+	netdev_tx_sent_queue(txq, skb->len);
 	skb_tx_timestamp(skb);
 	if (q->ndesc - q->queued < q->free_thr)
 		netif_tx_stop_queue(txq);
@@ -2650,6 +2658,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	port->dev = dev;
 	port->id = id;
 	eth->ports[index] = port;
+	qdma->port = port;
 
 	return register_netdev(dev);
 }

---
base-commit: c824deb1a89755f70156b5cdaf569fca80698719
change-id: 20240930-en7581-bql-552566f2078e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



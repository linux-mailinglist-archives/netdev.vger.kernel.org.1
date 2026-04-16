Return-Path: <netdev+bounces-278991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNuAL8u64GmIlAAAu9opvQ
	(envelope-from <netdev+bounces-278991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930440CF3C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D107305F7FC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B5390207;
	Thu, 16 Apr 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axKAaQ/c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3D3A4F59
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335443; cv=none; b=Flk6yYoXbvHnZgKWzF7RiUsz+TcGaXHAVlJluiVkXwRS2h6+8irUAsqSJPTA31g65iFS+QIukq+4bZ/0UAKOW0S612VpJNkj7aYgs2sQZLTaZlyzFDIiFa91SjKyxllyiuwLarofH86I6/sRlr6LvppTtuULWR0bgQCgG3EFMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335443; c=relaxed/simple;
	bh=NPcDG1Ottrtk5BiLjOdCbSSnt84O39ClqPxApC6Xue0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGMiMHmp5vpKGzBxG6F7VPHZlXJlKLqCaULiqV7DoutbuuHM//Xk38Ljx7/oeAzkOuTz3CvgGcZmPJ30zeR6GR6+AjOgxiqBy/g7H+RFRiTsgddZRazsthBRFcmBQxte9cbouvdred1V7R/LOtsmU8Um8ArrAyJtC1dsoG0Q5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axKAaQ/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14229C2BCAF;
	Thu, 16 Apr 2026 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776335442;
	bh=NPcDG1Ottrtk5BiLjOdCbSSnt84O39ClqPxApC6Xue0=;
	h=From:Date:Subject:To:Cc:From;
	b=axKAaQ/cj+oRnXUPg2U9dgZZO6H568/ZDENKG0RSgGEwGz+otgjG8DEeyc37bD370
	 YHZGJ+ZsLvNeAilM/hP+EDvmDR1H9Lzfpfm7BMNqlmf56GCJAOLEHj3lMPI+DDBv7/
	 0uQqU1AQIOzYgzOv7lTR5SI0DbJru4RTODwrOMDaYHelOY2sImomAzsVBnSOPmUkWr
	 yyy47t/pSfJ8ihdKOrABSvRHIuhfKG7JH0nVtgdhUd7FdJEsb44A75EwUzQpeZXCXv
	 y3xR95gB5AHBtU0sDq9tI5Xp9iw0Jnga77xVWoamJUgkRy3RyFZ9hUfPQ/HuaKQ0un
	 3qHUANfOHEesA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Apr 2026 12:30:12 +0200
Subject: [PATCH net v2] net: airoha: Fix possible TX queue stall in
 airoha_qdma_tx_napi_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-airoha-txq-potential-stall-v2-1-42c732074540@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQ6CMBAE4Fche3ZNf/jTk+9hOFRYYWPTYtsQD
 OHdbfDucWaSbzaIFJgiXIsNAi0c2bsc1KmAfjJuJOQhZ1BC1aIUDRoOfjKY1jfOPpFLbCzGZKx
 FM1Sqr7S4lNRCBuZAT14P/A6OEnS5nDgmHz7H4SKP6WdL/c9eJEpsWi10rR+yKvXtRcGRPfswQ
 rfv+xeYqI5cygAAAA==
X-Change-ID: 20260407-airoha-txq-potential-stall-ad52c53094e8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278991-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2930440CF3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since multiple net_device TX queues can share the same hw QDMA TX queue,
there is no guarantee we have inflight packets queued in hw belonging to a
net_device TX queue stopped in the xmit path because hw QDMA TX queue
can be full. In this corner case the net_device TX queue will never be
re-activated. In order to avoid any potential net_device TX queue stall,
we need to wake all the net_device TX queues feeding the same hw QDMA TX
queue in airoha_qdma_tx_napi_poll routine.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Add txq_stopped parameter to avoid any possible corner cases where the
  netdev queue stalls.
- Link to v1: https://lore.kernel.org/r/20260413-airoha-txq-potential-stall-v1-1-7830363b1543@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 37 +++++++++++++++++++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e1ab15f1ee7d..19f67c7dd8e1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -843,6 +843,21 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 	return 0;
 }
 
+static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+
+		if (port && port->qdma == qdma)
+			netif_tx_wake_all_queues(port->dev);
+	}
+	q->txq_stopped = false;
+}
+
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
@@ -919,12 +934,21 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 			txq = netdev_get_tx_queue(skb->dev, queue);
 			netdev_tx_completed_queue(txq, 1, skb->len);
-			if (netif_tx_queue_stopped(txq) &&
-			    q->ndesc - q->queued >= q->free_thr)
-				netif_tx_wake_queue(txq);
-
 			dev_kfree_skb_any(skb);
 		}
+
+		if (q->txq_stopped && q->ndesc - q->queued >= q->free_thr) {
+			/* Since multiple net_device TX queues can share the
+			 * same hw QDMA TX queue, there is no guarantee we have
+			 * inflight packets queued in hw belonging to a
+			 * net_device TX queue stopped in the xmit path.
+			 * In order to avoid any potential net_device TX queue
+			 * stall, we need to wake all the net_device TX queues
+			 * feeding the same hw QDMA TX queue.
+			 */
+			airoha_qdma_wake_netdev_txqs(q);
+		}
+
 unlock:
 		spin_unlock_bh(&q->lock);
 	}
@@ -1984,6 +2008,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	if (q->queued + nr_frags >= q->ndesc) {
 		/* not enough space in the queue */
 		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
 		spin_unlock_bh(&q->lock);
 		return NETDEV_TX_BUSY;
 	}
@@ -2039,8 +2064,10 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
-	if (q->ndesc - q->queued < q->free_thr)
+	if (q->ndesc - q->queued < q->free_thr) {
 		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
+	}
 
 	spin_unlock_bh(&q->lock);
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 95e557638617..87b328cfefb0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -193,6 +193,7 @@ struct airoha_queue {
 	int ndesc;
 	int free_thr;
 	int buf_size;
+	bool txq_stopped;
 
 	struct napi_struct napi;
 	struct page_pool *page_pool;

---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260407-airoha-txq-potential-stall-ad52c53094e8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



Return-Path: <netdev+bounces-301915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oAL4BkL4PGq+vAgAu9opvQ
	(envelope-from <netdev+bounces-301915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847636C4559
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 11:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V9JTsFGA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301915-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301915-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3433038A5A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD02383998;
	Thu, 25 Jun 2026 09:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5183603D9
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380586; cv=none; b=VVwiytuC3Cvp1azaZbvRQ6xrQVF9TPErTl4qrFLB2lXO70ynFNHvLbjuujhVsP2FKztmHaGaTEKzwHTjnZfw1yFGjpoTVEBL8R1W7R91XBDgDGqJgbKxGejagoUeaeOc8M7jMF392rllz69qSBD0lUX2nztilAooZpWAI0uJs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380586; c=relaxed/simple;
	bh=zuLcQOrG5fwrlhqrjBD4m7mqM5rMeLL8Ft5O+LstLoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BArK17dQ+D2ELAVVl9ZrsBNwP1o4a/HdsXXyXuenY/xa9NH/seg3HL5oosr+9djXrH2LLICvURsbuKOZQ1nMRTa2ueHe8Jdjt6LEf73sMw4yH9Kv5vzpEjrZ1lNR/mgEacUvAfeZtV3fs/ac4ajE3Gv+cqO2vma3QVhcB12Wmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9JTsFGA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8C41F000E9;
	Thu, 25 Jun 2026 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782380585;
	bh=kfIRsSw5cLdsaIa2/VNlwqA6JtFDV9at3sJRCJsJesA=;
	h=From:Date:Subject:To:Cc;
	b=V9JTsFGAe6nvw4b4Biz+gtY+fFyZwxOLVcw7gz/RYFPY/5bs28bD6P5erH2wgTMsS
	 1QrF/d/EgD8FMIi2c5Hb7DXwM6uMHIERp+oJ5qW7+LoGvwSMvSy87nYOW2mQtdq+lp
	 /HFTmdnIUi6jd8KydLkLkRDO/sS3dFIBxa7d79uJIUNbMsikfEt0XSFaRX8m4Mx+AN
	 jUzqBB6UFfFmxRV/j9VxixF3nlZAmgr5X+xej3BVKa7MFlXMI3kutW5MV3pSqiqFb6
	 vHnsCSjZWvzbkCGjIj+MV0jzN4gzHKLMtSLK0DQie8HV6LEpO3QORZugt9leo1kfNF
	 IDz/RL9Uqtuuw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 25 Jun 2026 11:42:46 +0200
Subject: [PATCH net] net: airoha: dma map xmit frags with
 skb_frag_dma_map()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-airoha-eth-skb_frag_dma_map-v1-1-31d9e460aae6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAwAwK9Izga0rD34lUVK2kYbFqukIoL49
 y0e5zI3FFbhAmNzg/IpRbZc0bcNhER5YZRYDaYztrNmQBLdEiEfCcvPu1lpcXElt9KOPoQQh2j
 543uow648y/XuX8h8wPQ8fxqovC9yAAAA
X-Change-ID: 20260625-airoha-eth-skb_frag_dma_map-bcccd5d6e4b1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 847636C4559

Map xmit skb fragments using skb_frag_dma_map() instead of
dma_map_single(skb_frag_address()). skb_frag_address() relies on
page_address() to obtain a kernel virtual address, which is not
guaranteed to work for all page types (e.g. highmem pages or
user-pinned pages from MSG_ZEROCOPY).
skb_frag_dma_map() maps the fragment directly via its struct page and
offset through dma_map_page(), avoiding the need for a kernel virtual
address entirely.
Introduce an enum airoha_dma_map_type to track how each queue entry was
mapped (single vs page), so that the matching unmap function is called
on completion and in error paths.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 61 ++++++++++++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 932b3a3df2e5..1caf6766f2c0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -944,6 +944,25 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 	q->txq_stopped = false;
 }
 
+static void airoha_unmap_xmit_buf(struct airoha_eth *eth,
+				  struct airoha_queue_entry *e)
+{
+	switch (e->dma_type) {
+	case AIROHA_DMA_MAP_PAGE:
+		dma_unmap_page(eth->dev, e->dma_addr, e->dma_len,
+			       DMA_TO_DEVICE);
+		break;
+	case AIROHA_DMA_MAP_SINGLE:
+		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
+				 DMA_TO_DEVICE);
+		break;
+	case AIROHA_DMA_UNMAPPED:
+	default:
+		break;
+	}
+	e->dma_type = AIROHA_DMA_UNMAPPED;
+}
+
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
@@ -1006,9 +1025,7 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		skb = e->skb;
 		e->skb = NULL;
 
-		dma_unmap_single(eth->dev, e->dma_addr, e->dma_len,
-				 DMA_TO_DEVICE);
-		e->dma_addr = 0;
+		airoha_unmap_xmit_buf(eth, e);
 		list_add_tail(&e->list, &q->tx_list);
 
 		WRITE_ONCE(desc->msg0, 0);
@@ -1177,12 +1194,10 @@ static void airoha_qdma_tx_cleanup(struct airoha_qdma *qdma)
 			struct airoha_qdma_desc *desc = &q->desc[j];
 			struct sk_buff *skb = e->skb;
 
-			if (!e->dma_addr)
+			if (e->dma_type == AIROHA_DMA_UNMAPPED)
 				continue;
 
-			dma_unmap_single(qdma->eth->dev, e->dma_addr,
-					 e->dma_len, DMA_TO_DEVICE);
-			e->dma_addr = 0;
+			airoha_unmap_xmit_buf(qdma->eth, e);
 			list_add_tail(&e->list, &q->tx_list);
 
 			WRITE_ONCE(desc->ctrl, 0);
@@ -2193,8 +2208,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
 	LIST_HEAD(tx_list);
+	dma_addr_t addr;
 	int i = 0, qid;
-	void *data;
 	u16 index;
 	u8 fport;
 
@@ -2250,24 +2265,22 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
-	len = skb_headlen(skb);
-	data = skb->data;
-
 	e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
 			     list);
+	len = skb_headlen(skb);
+	addr = dma_map_single(netdev->dev.parent, skb->data, len,
+			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
+		goto error_unlock;
+
+	e->dma_type = AIROHA_DMA_MAP_SINGLE;
 	index = e - q->entry;
 
 	while (true) {
 		struct airoha_qdma_desc *desc = &q->desc[index];
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-		dma_addr_t addr;
 		u32 val;
 
-		addr = dma_map_single(netdev->dev.parent, data, len,
-				      DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
-			goto error_unmap;
-
 		list_move_tail(&e->list, &tx_list);
 		e->skb = i == nr_frags - 1 ? skb : NULL;
 		e->dma_addr = addr;
@@ -2291,8 +2304,13 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		if (++i == nr_frags)
 			break;
 
-		data = skb_frag_address(frag);
 		len = skb_frag_size(frag);
+		addr = skb_frag_dma_map(netdev->dev.parent, frag, 0, len,
+					DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
+			goto error_unmap;
+
+		e->dma_type = AIROHA_DMA_MAP_PAGE;
 	}
 	q->queued += i;
 
@@ -2313,11 +2331,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	list_for_each_entry(e, &tx_list, list) {
-		dma_unmap_single(netdev->dev.parent, e->dma_addr, e->dma_len,
-				 DMA_TO_DEVICE);
-		e->dma_addr = 0;
-	}
+	list_for_each_entry(e, &tx_list, list)
+		airoha_unmap_xmit_buf(dev->eth, e);
 	list_splice(&tx_list, &q->tx_list);
 error_unlock:
 	spin_unlock_bh(&q->lock);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d7ff8c5200e2..2765244d937c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -170,12 +170,19 @@ enum trtcm_param {
 #define TRTCM_TOKEN_RATE_MASK			GENMASK(23, 6)
 #define TRTCM_TOKEN_RATE_FRACTION_MASK		GENMASK(5, 0)
 
+enum airoha_dma_map_type {
+	AIROHA_DMA_UNMAPPED,
+	AIROHA_DMA_MAP_SINGLE,
+	AIROHA_DMA_MAP_PAGE,
+};
+
 struct airoha_queue_entry {
 	union {
 		void *buf;
 		struct {
 			struct list_head list;
 			struct sk_buff *skb;
+			enum airoha_dma_map_type dma_type;
 		};
 	};
 	dma_addr_t dma_addr;

---
base-commit: 232c4ca2343d1181cbfc061f9856d9591e397579
change-id: 20260625-airoha-eth-skb_frag_dma_map-bcccd5d6e4b1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



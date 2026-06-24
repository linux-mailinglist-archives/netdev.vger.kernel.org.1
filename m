Return-Path: <netdev+bounces-301541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pBB8AxJNO2o4VwgAu9opvQ
	(envelope-from <netdev+bounces-301541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:20:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D46BB11B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:20:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=PYqvEJ6p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301541-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE4330151E4
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A5830677D;
	Wed, 24 Jun 2026 03:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF752FC00D;
	Wed, 24 Jun 2026 03:20:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271245; cv=none; b=nI8M5bWtUhNkboMdKpGjOAMOCRhpaQw4va88DL9uOswueMawxdxQga57UrQVRBN6C/+daWsFEQhy3vdqvwn5GNyyQA1epC1ERwGSeBwUQ/9NIbgEGK42dj3eq8e6o5077Sf8RloRtvnEAjHqunkuMZFSVD4o0EdHR7AtqVLcTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271245; c=relaxed/simple;
	bh=bVhvdsE7iJId1aAgK5ulMRBNVaslOEgIqNuG9XVudCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+7Wn5dzTqRgzlt+vkDEDIJ6Y5Ucjhbm5c5Kdim1nCsQJSFJ7uKnyx5nPwcldXZ9HobWYE9CAu6D1lxkPfH9Pz6BNb2BA8YgVEWUkwA93b9pxaR1QemhTRVbl5ea0/OFXWi5K50S2+nO4uCJpF8uI9dH/Tncz5v5HSRFbkEEQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PYqvEJ6p; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tr
	IvHLVddtpalXT2naJBvmxYt/zfHGKS5GqixP175wE=; b=PYqvEJ6pUX5QCxbQMs
	RceDVggtxRo7IqZcmS9vR10iIbv9eK1vTlDtQZT/+j4C1l1qvqbZ77P/Y/xoVx8V
	VyfsVMrzVB26JgjoTAT0AUVJrl2L0kyfcHIlmQLNDRBVSv0IRoUqoVQguGNnUKgp
	fONe8wODYMiUUIGGACZkfMlCI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3v5TMTDtqTwEsDQ--.65159S2;
	Wed, 24 Jun 2026 11:19:42 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] net: meth: Fix skb allocation failure handling in RX init
Date: Wed, 24 Jun 2026 11:19:40 +0800
Message-Id: <20260624031940.2690439-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3v5TMTDtqTwEsDQ--.65159S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw43Jry7Xr4rKr4DArWrXwb_yoW8Ar4kpa
	yvy3sYkr97Ar17t3Z5A3W7AFn8ZayFgFyrWFyS9w4FvrnxA345G348KFyj9r43CrWkWF13
	Kw47Zw17CFs8WwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyCJkUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g6vHmo7TM6KPwAA33
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301541-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pavan.chebbi@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 411D46BB11B

meth_init_rx_ring() does not check the return value of alloc_skb().
If the allocation fails, the NULL skb is passed to skb_reserve() and
then dereferenced through skb->head.

Add check for alloc_skb() to prevent potential null pointer dereference.
And unwind the RX entries that were already allocated and DMA-mapped
before returning.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Add error handling to free the resources that were already allocated. Thanks, Pavan.
 - Drop the fixes tag. Thanks, Andrew.
---
 drivers/net/ethernet/sgi/meth.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index f7c3a5a766b7..bf5f47692023 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -228,6 +228,9 @@ static int meth_init_rx_ring(struct meth_private *priv)
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
 		priv->rx_skbs[i] = alloc_skb(METH_RX_BUFF_SIZE, 0);
+		if (!priv->rx_skbs[i])
+			goto err_free_skbs;
+
 		/* 8byte status vector + 3quad padding + 2byte padding,
 		 * to put data on 64bit aligned boundary */
 		skb_reserve(priv->rx_skbs[i],METH_RX_HEAD);
@@ -240,6 +243,17 @@ static int meth_init_rx_ring(struct meth_private *priv)
 	}
         priv->rx_write = 0;
 	return 0;
+
+err_free_skbs:
+	while (i--) {
+		dma_unmap_single(&priv->pdev->dev, priv->rx_ring_dmas[i],
+				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
+		priv->rx_ring[i] = 0;
+		priv->rx_ring_dmas[i] = 0;
+		kfree_skb(priv->rx_skbs[i]);
+		priv->rx_skbs[i] = NULL;
+	}
+	return -ENOMEM;
 }
 static void meth_free_tx_ring(struct meth_private *priv)
 {
-- 
2.25.1



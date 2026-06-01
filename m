Return-Path: <netdev+bounces-293694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHIAEX9tHWrlagkAu9opvQ
	(envelope-from <netdev+bounces-293694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8D61E594
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B702305488C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496323A453B;
	Mon,  1 Jun 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nueDm8qk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GVJ1qbZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D03A16BC;
	Mon,  1 Jun 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313163; cv=none; b=KjHWgEZ2INK609tYppRrUicmYG4HsVkraRKMcMWzLmp6Ffhj/wHnuAxUxE48nsKaRRzvM1VvP7FOg9ACzEcEUL99OZlSMO+tBxZviVhILyBau99Zuig0OrCzUX4acGwb1MexvEPi8tLEDvTfK/y6JayUZByGNDgdJQ0L7lcv4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313163; c=relaxed/simple;
	bh=Zr8RlkOdp4VuIDgDTlIRi6Ybw+5SeUjSTgCBtzg7YJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXZUN+v9C2SkzOuYzx1lSPTVY14WeEj+FO3L4vu5oLLgyiI1XZkd3iINKZThToaV0ZWfllnZHw3iLna8UYGiOGYojokDhSuScDls3BHt3nMzc3hxIGbdan7Pr641xYFXewWLKQDz+mmfcjdBLdUQDfjZsRkv5cN6A4KtfBqBj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nueDm8qk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=GVJ1qbZ9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gTWqV6xJ7z9tZs;
	Mon,  1 Jun 2026 13:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3d7TtMPNMDRpp/XYhEwTFHxIhjwKfcKifDwqMUGWwY=;
	b=nueDm8qktfsTyl9ZOtOHAtxvdCmRw6rmouEFACLxcEORp7OZWdaaOxmIql23GXLzyghdSB
	35FNDbcwa/dFawN7/4sV3vRBjtzSAFXaYXNl132qYamycKh9Rm/i4spJaG0Mlbe5S4h6Xc
	E1cZgduOgLrFl8jc9U4Bgg8fwg64h26zk+I86NaWVxzFBS8ODgCwc3saj2hIi4fmgEsAf+
	7DGqAhdsZI3r9K2zSr4TBT/Tz3szNWd/AtaxBioy4LUvrgjfPgTE/r23oFfy/voP2MYGnn
	lFjHmj/mPQofps6cgexBFS3epxPXc6sKQEpch+Ka9bZ9xOghJ36si9M9bczoug==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3d7TtMPNMDRpp/XYhEwTFHxIhjwKfcKifDwqMUGWwY=;
	b=GVJ1qbZ9Oho1L0Ly0V1j94E0LwF8rdjL/nATx5kx6L+czPAt3Hn+BcrJ7Uv/wTTuaIpwze
	4AOHEpOJ2E0CrhXVwlejcEHFosGgfu6YShqk/qNJsA543wl46j9vOoLM065noth8fzJV/h
	ZJpfj0Db5NcKBRl57+Vp2sl8ab1PpMbROZX/CxcFqpEwMoZMM1g6tLatHmfaGxV8fBsuDM
	H/SrDbX+DCj12yTl28PBYQizqzY4so14n+3x3I57F1WAjQ63d+fd4kfqZjnhFQfaRBCY+u
	bjrAgPQ4dOqmBBg8P/huT3lwzny2U1J8yNQcvzvhcJg2xqxzuoFa4PbUKs2HmQ==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v24 3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Mon,  1 Jun 2026 13:24:32 +0200
Message-ID: <20260601112437.2216043-4-lukasz.majewski@mailbox.org>
In-Reply-To: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
References: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 127ec5b15acdec0166f
X-MBO-RS-META: nx7bjpcwdrgiqe5o315wo45m1niokit7
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: C3F8D61E594
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch provides buffers management funcions' content for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---
Changes for v14:
- New patch - created by excluding some code from large (i.e. v13
  and earlier) MTIP driver

Changes for v15 - v20:
- None

Changes for v21:
- Add check if fep->page[i] is not NULL before returning it to page pool

Changes for v22:
- Add fep->tx_bounce[i] = NULL; in the mtip_free_buffers

Changes for v23-v24:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 1d1005a42306..5b5229ee411d 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -892,11 +892,101 @@ static void mtip_get_drvinfo(struct net_device *dev,
 
 static void mtip_free_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int i;
+
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		if (!fep->page[i])
+			continue;
+
+		page_pool_put_full_page(fep->page_pool,
+					fep->page[i], false);
+		fep->page[i] = NULL;
+	}
+
+	page_pool_destroy(fep->page_pool);
+	fep->page_pool = NULL;
+
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		kfree(fep->tx_bounce[i]);
+		fep->tx_bounce[i] = NULL;
+	}
+}
+
+static int mtip_create_page_pool(struct switch_enet_private *fep, int size)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = size,
+		.nid = dev_to_node(&fep->pdev->dev),
+		.dev = &fep->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = MTIP_SWITCH_RX_FRSIZE,
+	};
+	int ret = 0;
+
+	fep->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(fep->page_pool)) {
+		ret = PTR_ERR(fep->page_pool);
+		fep->page_pool = NULL;
+	}
+
+	return ret;
 }
 
 static int mtip_alloc_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	struct page *page;
+	int i, ret;
+
+	ret = mtip_create_page_pool(fep, RX_RING_SIZE);
+	if (ret < 0) {
+		dev_err(&fep->pdev->dev, "Failed to create page pool\n");
+		return ret;
+	}
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page = page_pool_dev_alloc_pages(fep->page_pool);
+		if (!page) {
+			dev_err(&fep->pdev->dev,
+				"Failed to allocate page for rx buffer\n");
+			goto err;
+		}
+
+		bdp->cbd_bufaddr = page_pool_get_dma_addr(page);
+		fep->page[i] = page;
+
+		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		fep->tx_bounce[i] = kmalloc(MTIP_SWITCH_TX_FRSIZE, GFP_KERNEL);
+		if (!fep->tx_bounce[i])
+			goto err;
+
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
 	return 0;
+
+ err:
+	mtip_free_buffers(dev);
+	return -ENOMEM;
 }
 
 static int mtip_rx_napi(struct napi_struct *napi, int budget)
-- 
2.39.5



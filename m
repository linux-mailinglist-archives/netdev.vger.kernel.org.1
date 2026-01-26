Return-Path: <netdev+bounces-253418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFq7KKxDd2n+dgEAu9opvQ
	(envelope-from <netdev+bounces-253418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F274187146
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D4F0300468D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DF331239;
	Mon, 26 Jan 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hJn/3pKM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aq8JBysJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AF331233;
	Mon, 26 Jan 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423711; cv=none; b=Ouk5Osg28VbPpKjEXqnUP5knh2sTTluD62VtJJ1sevuFeI/Ptfag+hnfkBS63gwu76nRwFpKDXpMcdVYwjCC6MB+U2eG+AGCVchNdABUfTv47GX9fSr8ztTmtqJex/f6d6+wz3JVOnKU97MLRIWLmnHMZJSV75Uhcbe2YXojkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423711; c=relaxed/simple;
	bh=15RooZ7wWwn6Uu3EO0uqqSbSuSeV6CKZ/8ZFlBfNdr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K65vhGPhydzqEiclBgvrZuO1K/bXmFsBVjrUXq812oI942OXuUY1V59XdMLyNoA4kYZDjtM0+xIHAFKy/jf9PM6m+GDejcjVSr8zjEdYnNvfZuvDij2CQf7UFCAyd/GX6eIPCTrOTfT3oWk+M/bMjJD6A0A3eVya3JaWkTgQkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hJn/3pKM; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aq8JBysJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f04ft3prNz9tgV;
	Mon, 26 Jan 2026 11:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9V+YHLZzXu7lKO4j0C/uZezbE72tK+S8TfwmA3z0HY=;
	b=hJn/3pKMHh8qi4s+jwCaKau3aYwOLaH1F/TUp87MvTnsj37q/znvHdibK3l0raIjZH0R4h
	U7jgJHdI6X9H86d1ySVgn7hZDYMCjRhCn4FQ9XMxjms8AoESUfK92kV6pYvERxhGK1rXt8
	/VsbqXmjG4l5VY9RO2d5RumxIF2uErJ8Fkv2eJvxwU9bd6abOnW/8ZhjmHau35ICc4aBWp
	q56pC1lP+A1S3zidVSQ2WcA1bYgmrPeeSwx9D5Mp8P2VW0ak1RSe0Ev5NL3v0JYEGKc97G
	V3X8YkQVamAP/io8q15i4hUva8euXgsfb7Q35nxWX4qhTSQWOebVcQA1KXO59Q==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769423700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9V+YHLZzXu7lKO4j0C/uZezbE72tK+S8TfwmA3z0HY=;
	b=aq8JBysJiIUEB1oFjYjG4zfDT5AYphq5uobIxYbrAedEUNSVU2Ctrteu+q8dSrzRDgUAvH
	9uawb1vwRMu1kz8jaI8aW67SsWvDZz7/LipQf+k7hW0mUdJ4x6lsExHsFME4FbXx4T2uU7
	vdk7mBTACX85C5h0Dxo4vTQUOiBXrN9DLoaOpS2+bcu2n8J6TY+jWfh2Eccl3RdW6BfIQv
	fTiSn2ly6xPp2oFYrzUGRw3588p5k5b90bneTUd5cvvuQeCEsfhx4/4Ffsuwm6wEdsCQ+Z
	+IWwzs+xPlT+4SC5KhNEi6ZMXKL0rBpXsRt2b+YzZ/Ldus0HonxyEUhx+SdjEA==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v20 3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Mon, 26 Jan 2026 11:33:56 +0100
Message-Id: <20260126103400.1683125-4-lukasz.majewski@mailbox.org>
In-Reply-To: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
References: <20260126103400.1683125-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iphz5z8uu7b3jfphxtp8kqete3true6p
X-MBO-RS-ID: ac35ba6a5861ad55e83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-253418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:dkim,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F274187146
X-Rspamd-Action: no action

This patch provides buffers management funcions' content for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---
Changes for v14:
- New patch - created by excluding some code from large (i.e. v13
  and earlier) MTIP driver

Changes for v15 - v20:
- None
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 03c5163d6508..9c21a3d29c1c 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -888,11 +888,96 @@ static void mtip_get_drvinfo(struct net_device *dev,
 
 static void mtip_free_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int i;
+
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page_pool_put_full_page(fep->page_pool,
+					fep->page[i], false);
+		fep->page[i] = NULL;
+	}
+
+	page_pool_destroy(fep->page_pool);
+	fep->page_pool = NULL;
+
+	for (i = 0; i < TX_RING_SIZE; i++)
+		kfree(fep->tx_bounce[i]);
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



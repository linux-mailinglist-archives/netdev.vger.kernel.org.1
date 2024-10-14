Return-Path: <netdev+bounces-135310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8899D81A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B362828C4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290C1D12FE;
	Mon, 14 Oct 2024 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk9abx3I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EB1D0F4D
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937286; cv=none; b=KMMMHK8nFTY1w3vPB1+WrJpIrSTd135PovKgrsslz6K/N9fFqAUqF+9Y8XORhO8L78jt5xpANzF3owd+OCgzNIOxHMJXugreManR42H5qSBrZDvfs0ncAK20/M3oV4agJ8DTpt7x8C9QfMw7SM4sUOVukNzhaEvvVAonZxzNgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937286; c=relaxed/simple;
	bh=bDPRxWLE2erjYAE59syMdkJp8m4krVITgmEnI8ZwRHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rH9Qz4unxkWv+PMAFRDHrr0RLWTlS8uB5gaEZviAkhPj0nc7xZRubVVmFrY1QaIHQgOFrHytyJx/1mDrqi/dCJC2JEVk2bfe64lrGTV7IE1bW36tSbYksmTLfnUl8zHE94ccdR0rLHBf4YT+Q7Kyfsfxsn0G4mgeu8qU0B/sKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk9abx3I; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e46373148so2797033b3a.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728937284; x=1729542084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=coy9TRspwLfh094EnJKxY/+K0whveUSWK78Q8cLFZKg=;
        b=yk9abx3Iftl3gfD2un6b2OIUHdn7RKqjnOx6gQsI3Kow8qzPdVo2RwzbW63dGuGAuY
         66xxZZEN9h1DKaFOKz9aUOgAk/baGEnFFq1zMBrMLDwmzAK+xBzgxMuoRGWNTsI4R57y
         X+5jBkfX99/CKpn575twaIiXTd1rPyRgpmH5MLUbEnWjtKEyBnTkRRaVGzkjgZF1dS5A
         KAaEnS4Hc8be8kCGv2paPurmiLHS/+5TVEBI+II+WFg+1bUrRqxsCXBIeu/nFOgGNdMZ
         MxBcjzGcyEPn7+qfO84xB9vYnDaPcoxfPc8vsdDqT4tO7OofntZvlBgELUUdskH2K27Y
         /ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937284; x=1729542084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coy9TRspwLfh094EnJKxY/+K0whveUSWK78Q8cLFZKg=;
        b=nRw4Ss1pHGjb4edbMHQbul6nA/b4fA0FIVT3A7wh6d9nU2J3kit3UaKdKM9WHzgYXr
         2+mFidjcJ/V6UTRrR4yeOJsJ4n+y6dnzYqqqvupRJNKy59GS4VJDTVl9cg5MNgE7ppnY
         PWdoB1nhNdGItV6FP9c/MIVIZoF0nsv9C3OMDZvUMh08xN1t4gZXuSUOMIVMXwoS8S5Q
         7Oi7fuj2Djl/BEnP+D/pV9b2Fp77RG78cpxHCXAr3aTUAGqElh668Wi++TwLR+I0gTel
         TYQQEDDhQiZYT2q0vCDdas1zHCogOtwPZZA7Ho1WQzHlR0Y3nKIxtB8s/unALMFb6Gu/
         Jj2w==
X-Gm-Message-State: AOJu0YxeynZJxXMq0Z7PusI6mnzc1TSHYzZostZgrOBejQ7NPRNQt48A
	g5d13t116LJUgYGDQnr9DOvjY7GwB4izM336MteQTY9cRMVquoZArNf8iDA2hV4tF+/oGqGBSKT
	lP645eauFAW+WaVvHFA1SOr4+lcc4JELOmbofEX4lVAQiqjiX3HXhOQcKtB1Kzt8x1oEBMYpX0v
	Yl7xAPoF8zeZiTd7dcxo05VlDpOxHQTKd2oB6bCSCH+NYzHzuHv5Qiz8rCy1LgwXBd
X-Google-Smtp-Source: AGHT+IFEmb1WH4+IYn79jgpm81jCi0HfSKU9hOcB6Zeeed+mR+F6nF75JIgjqHas5L7mw5VC0icdWMIH0JB5pzC8nkM=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:1ab8:7f2d:7123:f4fc])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6a00:870b:b0:71e:4ec7:aed8 with
 SMTP id d2e1a72fcca58-71e4ec7afb8mr13213b3a.6.1728937282856; Mon, 14 Oct 2024
 13:21:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:21:08 -0700
In-Reply-To: <20241014202108.1051963-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014202108.1051963-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014202108.1051963-4-pkaligineedi@google.com>
Subject: [PATCH net-next v3 3/3] gve: add support for basic queue stats
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

Implement netdev_stats_ops to export basic per-queue stats.

With page pool support for DQO added in the previous patches,
rx-alloc-fail captures failures in page pool allocations as
well since the rx_buf_alloc_fail stat tracked in the driver
is incremented when gve_alloc_buffer returns error.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v3:
-Add this patch to the series for per queue stats (Jakub Kicinski)

---
 drivers/net/ethernet/google/gve/gve_main.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 294ddcd0bf6c..e171ca248f9a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2561,6 +2561,54 @@ static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
 	.ndo_queue_stop		=	gve_rx_queue_stop,
 };
 
+static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
+				   struct netdev_queue_stats_rx *rx_stats)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&rx->statss);
+		rx_stats->packets = rx->rpackets;
+		rx_stats->bytes = rx->rbytes;
+		rx_stats->alloc_fail = rx->rx_skb_alloc_fail +
+				       rx->rx_buf_alloc_fail;
+	} while (u64_stats_fetch_retry(&rx->statss, start));
+}
+
+static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
+				   struct netdev_queue_stats_tx *tx_stats)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	struct gve_tx_ring *tx = &priv->tx[idx];
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&tx->statss);
+		tx_stats->packets = tx->pkt_done;
+		tx_stats->bytes = tx->bytes_done;
+	} while (u64_stats_fetch_retry(&tx->statss, start));
+}
+
+static void gve_get_base_stats(struct net_device *dev,
+			       struct netdev_queue_stats_rx *rx,
+			       struct netdev_queue_stats_tx *tx)
+{
+	rx->packets = 0;
+	rx->bytes = 0;
+	rx->alloc_fail = 0;
+
+	tx->packets = 0;
+	tx->bytes = 0;
+}
+
+static const struct netdev_stat_ops gve_stat_ops = {
+	.get_queue_stats_rx	= gve_get_rx_queue_stats,
+	.get_queue_stats_tx	= gve_get_tx_queue_stats,
+	.get_base_stats		= gve_get_base_stats,
+};
+
 static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int max_tx_queues, max_rx_queues;
@@ -2616,6 +2664,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->ethtool_ops = &gve_ethtool_ops;
 	dev->netdev_ops = &gve_netdev_ops;
 	dev->queue_mgmt_ops = &gve_queue_mgmt_ops;
+	dev->stat_ops = &gve_stat_ops;
 
 	/* Set default and supported features.
 	 *
-- 
2.47.0.rc1.288.g06298d1525-goog



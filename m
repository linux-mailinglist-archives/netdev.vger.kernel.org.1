Return-Path: <netdev+bounces-246900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6BFCF234E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D133305D986
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B72BEFE8;
	Mon,  5 Jan 2026 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jaxlceq2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B632BD012
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597755; cv=none; b=VulmYV0DWkgL7MWJYiCoHLyDkKSVslCgRqzkko7vnkQzWHxd31wlyv1w8KEi5BlSeP8vFhZxCLeHxdcOlZgOdSpLa9kxlzhepNwl4qIP8ZqASthbFRFpNIRs1praO9LqCJ4DVFIWX0nTyO/p34FDnQS7bw/oQH6RMu3+9DofXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597755; c=relaxed/simple;
	bh=G42HEdK63RMSkNcCPQGCk4X08ncSFrRURRT8K21yxRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZlMsByBlQbnvtE8eMmw0NJy96XKuVZ+aSttxwvKu+JLXx9DGd71pAyyrzPRXkNszVF/l22jl9GdhSSAdC4h6oZBJcv9GQlECqT+XFFvx1M1VZTQ0F+NMPcTVc01d+STG8E5qBYjO/Y7qU25nAEyMiUTKkKzWSSIqP/qUyQxxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jaxlceq2; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-55ab217bb5eso1495989e0c.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597752; x=1768202552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=FZDFwK4w5mIRCHzKJHF7qQnQodUCBNg47DPjKfNDhXH3vgf1AT99QZ+NQwtZwYQvQb
         XNIII4LbXX38eoV/vOvL/xPghDA81eiJ3aPC9tGZe5vD1w9bGkbNT5Y/wqDr6UmYMXTy
         Ck0Y7GH9ijylpCJSA3WDtkwX94YrAVUz20Oqf2IZTxMSblg3+eK3ylE0b/a9nMeHsNzJ
         Ssc6is6mB1qxzc8yTPKlHGtBd4NuPSV5+Byg9ZmHm3sspyIJfWEs+WlCzVa+SWSsdKJQ
         wVB9w8F8OZi94hDS18OKJ3k6veUK3XZuxBGyDtxrn1oj7HzK4fw933KMqY6ORbrdJQkX
         lqnA==
X-Gm-Message-State: AOJu0YzyDD29KSRpsTzX5cNeip+aFkMKvo0hv2jyX4t01AikLaD643GX
	tgM6bYsi37VxicXnwnU5v0nQX3Aht7PJWzEtwh7ZiYOZR4mgAPAiOjwc79dkw2U4gfiwMrZ8k0i
	lN+iM4fr2CdR27g4xIa3+dBeZS9rxYWxdrRYltYj+BkpOmaC/AwEs976wXuGD9tdAEclRueSUoH
	JapAFptvNgz/rM/YOVA4TNWSOSaQC2mrhkkEiMSPPPQtLxADXM8ru7S775q+iitMk+bGZVxu/Vv
	93tME9Cs5J6fVeuz5qO
X-Gm-Gg: AY/fxX7Qwj/pxYJVaD1qxc1jT1nMBb2av7LmJcE62KzYkotEwQ17gf4tTgcShm5HvBk
	YKYO/plBX+mRFz2K6LHv9YQEFHPPP9KVAhEZCL4/Qo4WxiDnkapC33KqXJCtMRCzW76aW88gmBE
	KTPPNNsdY0NDfqNKmbc+yl2lJhhoEqEA+5XDJ0YQ7n14mfjMRtyHtnp6EMJJOUzN058WfNzD27/
	+Cbt/nC/k2KfgR5aus62z8u7NM8k/06jvCZgkHoce90+8oO2uIAAeyUDYwzH8U0VKte2hrG523e
	UOwwEb91i6YiBu1ibqXvmHY4LTyp8/sfp+x2RBDz2mxfsQ9I6uSrPV2+RWqIuVnU7aitJTYsVOt
	mZsR7SK6OY2YkRfpHgspNb2wraOiGZvVQMZdWjO6nVSPimLBIx3nce2R4RXgQhQBfzLRWmwXcPl
	ZmIqOYoxtNVboLpAuj2fWJo2MfoVd2shVKgsUlV9AVT+Z1MaIv
X-Google-Smtp-Source: AGHT+IHC3EZVR/nXkybdoLIfypB878HmSYKzYcVOGygnT4MuUxMFRbqlkKHzuHN1pFmCh5DyVLBQoI0wQBO2
X-Received: by 2002:a05:6122:4594:b0:559:eef7:39f with SMTP id 71dfb90a1353d-5615be1914emr12549720e0c.12.1767597752559;
        Sun, 04 Jan 2026 23:22:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5615cf48388sm7517321e0c.0.2026.01.04.23.22.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:22:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b90740249dso24446881b3a.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767597751; x=1768202551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=Jaxlceq2dDbx8/1b68bqSeOvV6wto8qfR4KVKunN4LGbe5l8AvxT8Z2o0E/cqIvApi
         DYaslqnlAQfONEdz8pRe42WG8AVbAg9DvdiuHNZPfsdg6Mh5EYEyg/48JNz9kNxZt9Kj
         XV3EcdEr9qv9eOpeeXKwGw2IUM+5aiAwX9AVQ=
X-Received: by 2002:a05:6a00:600e:b0:7fb:cf05:93db with SMTP id d2e1a72fcca58-7ff6667cc4emr44478625b3a.59.1767597751041;
        Sun, 04 Jan 2026 23:22:31 -0800 (PST)
X-Received: by 2002:a05:6a00:600e:b0:7fb:cf05:93db with SMTP id d2e1a72fcca58-7ff6667cc4emr44478614b3a.59.1767597750640;
        Sun, 04 Jan 2026 23:22:30 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm47293293b3a.36.2026.01.04.23.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:22:30 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v4, net-next 1/7] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Mon,  5 Jan 2026 12:51:37 +0530
Message-ID: <20260105072143.19447-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add rx-copybreak support in bnge_set_ring_params()

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  5 +++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 832eeb960bd2..8bd019ea55a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/netdev_queues.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 
@@ -2295,7 +2296,6 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
 	ring_size = bn->rx_ring_size;
 	bn->rx_agg_ring_size = 0;
 	bn->rx_agg_nr_pages = 0;
@@ -2334,7 +2334,10 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 		bn->rx_agg_ring_size = agg_ring_size;
 		bn->rx_agg_ring_mask = (bn->rx_agg_nr_pages * RX_DESC_CNT) - 1;
 
-		rx_size = SKB_DATA_ALIGN(BNGE_RX_COPY_THRESH + NET_IP_ALIGN);
+		rx_size = max3(BNGE_DEFAULT_RX_COPYBREAK,
+			       bn->rx_copybreak,
+			       bn->netdev->cfg_pending->hds_thresh);
+		rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 		rx_space = rx_size + NET_SKB_PAD +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	}
@@ -2367,6 +2370,17 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->cp_ring_mask = bn->cp_bit - 1;
 }
 
+static void bnge_init_ring_params(struct bnge_net *bn)
+{
+	u32 rx_size;
+
+	bn->rx_copybreak = BNGE_DEFAULT_RX_COPYBREAK;
+	/* Try to fit 4 chunks into a 4k page */
+	rx_size = SZ_1K -
+		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2456,6 +2470,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
+	bnge_init_ring_params(bn);
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index fb3b961536ba..557cca472db6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -135,7 +135,8 @@ struct bnge_ring_grp_info {
 	u16	nq_fw_ring_id;
 };
 
-#define BNGE_RX_COPY_THRESH     256
+#define BNGE_DEFAULT_RX_COPYBREAK	256
+#define BNGE_MAX_RX_COPYBREAK		1024
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
 		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
@@ -186,7 +187,7 @@ struct bnge_net {
 	u32			rx_buf_size;
 	u32			rx_buf_use_size; /* usable size */
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	u16			rx_nr_pages;
-- 
2.47.3



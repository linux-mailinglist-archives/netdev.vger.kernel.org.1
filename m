Return-Path: <netdev+bounces-209380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BCB0F693
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D08174DEB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A72F2C66;
	Wed, 23 Jul 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky3mPsyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2B2FA635
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282882; cv=none; b=sG2C0ZxWnoUN1zDZQQ7Xd393F83ID22K3jqqe+0T+Il/XJxrk+gT6uxggrOzriCJ6ZBNormnOzKV+xtoJ9MVbJxdirxIEVNxlam8y3S+SvhdTe+j/eSNy3iZISYeW6CQkz0qdknoLPSDHJPtRndSuUkcCwnp4g2XELmfh6lGNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282882; c=relaxed/simple;
	bh=ou1cwMnF5ljnXgD+f7pQe1Xkgf1Y/ywSVOXRFZqTsq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLca15SXopqKvaWANZrlJ854giV6SsiiBElNrfsKP2RVkAs2chH5pNc0qVQEOIbFx1Eii2FF3EhtUPc6h2NaWV9cPef+XEWviOqitSj9hIMjjV06cjMW+vkwI6H7++Nq8nsbI7dIAyWZQGCUKLargWfEfwWBieX3vpw2gDmj7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky3mPsyw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455b00283a5so42058235e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282802; x=1753887602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzi2+M6fmvNHsMJcxwiimrWkLl3jTxCOJwh3C2K2gvY=;
        b=Ky3mPsywSiEmx+6DRl6c0PBkw6TrzB8bAn/G3WLf6wNe58OemsO0nofeIIjaLAWewO
         pjM8YYbg8rGjih53VbV1l6yT0TXVd/kUJNB8nTOrWaNmEeSY6Eoa9jWrPLO4CE8NV9fT
         fqvfoDfXmy6F0IQx6r5dYuz+UPhHJJYOum5Gw6iHLImd5szi0EFj5YvNUJhZmaiXL96s
         3nAiN/Jor/GronbQtRIbx58mqtjLjhsBTpkRMrOxowIPSJO3KTLENaKw/FMAClGYboxM
         DBwZ/FNRg0erISuWojlC3ZoctigXKoa3XoygoNA25V3hzPLrNP/NoABqncO05OKB96Ak
         uN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282802; x=1753887602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzi2+M6fmvNHsMJcxwiimrWkLl3jTxCOJwh3C2K2gvY=;
        b=JJyAZ6Z1WWTMroWKZMIGdfLEcKSpMSrjC9n7sr6KyJ6gUD+oP0W0HsG1f8KzULddxH
         QB5l3ey19ryU6pLsht0wC1w02s6eFRZN4MSIgkw87DrQkqBMWe4tOaoqXrBlB3huYdQ6
         mHckQBr740MBRgIWuDXe9mf9KCLIUcojtcdI8XxODZWN6cUwzoeKk3llTTQZGzCLmzWR
         KwL9Rk4nRGl4SXp9Ylb1vY+NKMSBgB17hDrCDtFO6in12OYwdFeNiFeSyaaR4HPUgGT8
         NqDolSEIXEgFwwd7dmcP1IpIGiAkljcqrY6tTCt/rw5Yss9t6bhunW6e4F61wmyTIf2j
         UgtQ==
X-Gm-Message-State: AOJu0YwBUfshVh/w/5PUtlGASQihCO/HxBpkucozQQjL+dK1iVdYOo6Z
	8yEW0OPAh9ieb5/7VB0zxEACX+9JG15MjTWV2rqs2oS1A3ALNSTZxLMvbctqibPE
X-Gm-Gg: ASbGnctixJcdpZ7M8gVFci5+CtqMbvxOMJpjN1pBjnT5u5L16sGhI3Kx1ZCwl4AXNzV
	DhGOYVavfCqKdHzS1qcM5hAOOQ+vpzLJ/yDNV5Eo0E73Q5NEu7fKvXm2sou3cV4bPCZoUZk6dmS
	pJ5zCrkn1UBR/kaBsiCM9iY8r/gnjB1gHmmVXKvLgnl8BSADsq4dd483mITSKRbXjM4h4JGkKgl
	595ZgbNGfwJBB7bPe0mDzzEvh7WzGEwHk9pSFTOzU4CuLK1TQ1ZeGVuBUhZXNh6FgczHkR76yhk
	catuIrxsHB7f5w202jEbnb1Fk1zqchyu5sthL0Mi83kLIFLEJs2pfFXC9JUojR+wutMyaXfe9TU
	24ZBTjNmqHwl4TSNS/Ko=
X-Google-Smtp-Source: AGHT+IFHYrskopu44xl6lOZcp8XJHTMuYSXUF7QBrydD03WSpMUZyJFnUc40/ZmJ8pscSr8C4LAHbQ==
X-Received: by 2002:a05:600c:6992:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-45868c99c85mr29780625e9.12.1753282801663;
        Wed, 23 Jul 2025 08:00:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca319c0sm16613120f8f.40.2025.07.23.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:01 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 1/9] eth: fbnic: Add support for HDS configuration
Date: Wed, 23 Jul 2025 07:59:18 -0700
Message-ID: <20250723145926.4120434-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring the header data split threshold.
For fbnic, the tcp data split support is enabled all the time.

Fbnic supports a maximum buffer size of 4KB. However, the reservation
for the headroom, tailroom, and padding reduce the max header size
accordingly.

ethtool_hds -g eth0
Ring parameters for eth0:
Pre-set maximums:
...
HDS thresh:		3584
Current hardware settings:
...
HDS thresh:		1536

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 21 ++++++++++++++++---
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  4 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  6 +++++-
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 588da02d6e22..84a0db9f1be0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2,6 +2,7 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <net/ipv6.h>
@@ -160,6 +161,7 @@ static void fbnic_clone_swap_cfg(struct fbnic_net *orig,
 	swap(clone->num_rx_queues, orig->num_rx_queues);
 	swap(clone->num_tx_queues, orig->num_tx_queues);
 	swap(clone->num_napi, orig->num_napi);
+	swap(clone->hds_thresh, orig->hds_thresh);
 }
 
 static void fbnic_aggregate_vector_counters(struct fbnic_net *fbn,
@@ -277,15 +279,21 @@ fbnic_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	ring->rx_mini_pending = fbn->hpq_size;
 	ring->rx_jumbo_pending = fbn->ppq_size;
 	ring->tx_pending = fbn->txq_size;
+
+	kernel_ring->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	kernel_ring->hds_thresh_max = FBNIC_HDS_THRESH_MAX;
+	kernel_ring->hds_thresh = fbn->hds_thresh;
 }
 
 static void fbnic_set_rings(struct fbnic_net *fbn,
-			    struct ethtool_ringparam *ring)
+			    struct ethtool_ringparam *ring,
+			    struct kernel_ethtool_ringparam *kernel_ring)
 {
 	fbn->rcq_size = ring->rx_pending;
 	fbn->hpq_size = ring->rx_mini_pending;
 	fbn->ppq_size = ring->rx_jumbo_pending;
 	fbn->txq_size = ring->tx_pending;
+	fbn->hds_thresh = kernel_ring->hds_thresh;
 }
 
 static int
@@ -316,8 +324,13 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot disable TCP data split");
+		return -EINVAL;
+	}
+
 	if (!netif_running(netdev)) {
-		fbnic_set_rings(fbn, ring);
+		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;
 	}
 
@@ -325,7 +338,7 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	if (!clone)
 		return -ENOMEM;
 
-	fbnic_set_rings(clone, ring);
+	fbnic_set_rings(clone, ring, kernel_ring);
 
 	err = fbnic_alloc_napi_vectors(clone);
 	if (err)
@@ -1678,6 +1691,8 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
 					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
+	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+					  ETHTOOL_RING_USE_HDS_THRS,
 	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 7bd7812d9c06..d039e1c7a0d5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -691,6 +691,10 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	fbn->rx_usecs = FBNIC_RX_USECS_DEFAULT;
 	fbn->rx_max_frames = FBNIC_RX_FRAMES_DEFAULT;
 
+	/* Initialize the hds_thresh */
+	netdev->cfg->hds_thresh = FBNIC_HDS_THRESH_DEFAULT;
+	fbn->hds_thresh = FBNIC_HDS_THRESH_DEFAULT;
+
 	default_queues = netif_get_num_default_rss_queues();
 	if (default_queues > fbd->max_num_queues)
 		default_queues = fbd->max_num_queues;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 86576ae04262..04c5c7ed6c3a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -31,6 +31,8 @@ struct fbnic_net {
 	u32 ppq_size;
 	u32 rcq_size;
 
+	u32 hds_thresh;
+
 	u16 rx_usecs;
 	u16 tx_usecs;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index ac11389a764c..1fc7bd19e7a1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2238,7 +2238,7 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK,
-			      FBNIC_RX_MAX_HDR) |
+			      fbn->hds_thresh) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
 			      FBNIC_RX_PAYLD_OFFSET) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_PG_CL_MASK,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 2e361d6f03ff..4d248f94ec9b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -53,7 +53,6 @@ struct fbnic_net;
 #define FBNIC_RX_HROOM \
 	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
-#define FBNIC_RX_MAX_HDR		(1536 - FBNIC_RX_PAD)
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
 
@@ -61,6 +60,11 @@ struct fbnic_net;
 #define FBNIC_RING_F_CTX		BIT(1)
 #define FBNIC_RING_F_STATS		BIT(2)	/* Ring's stats may be used */
 
+#define FBNIC_HDS_THRESH_MAX \
+	(4096 - FBNIC_RX_HROOM - FBNIC_RX_TROOM - FBNIC_RX_PAD)
+#define FBNIC_HDS_THRESH_DEFAULT \
+	(1536 - FBNIC_RX_PAD)
+
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
-- 
2.47.1



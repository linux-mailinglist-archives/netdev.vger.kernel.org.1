Return-Path: <netdev+bounces-96116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E6A8C4608
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465A01F21897
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0839AEB;
	Mon, 13 May 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kceS75IP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB433080
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621363; cv=none; b=bd4lJUA0riS/HEozv1XELM3sY6YOlN/gtCNcIKs9dyBdhAe21E3iczXJn0ZH51b+avPe6kdpGkKxgeHCy9TZZbRrOvEbSdFv9r1S+iaf+tlfv059T1iMLCqH81dLIdrCfQCI798Qp00RT6LhyC0UTy//rX+OyyZ53o+jrUUGQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621363; c=relaxed/simple;
	bh=P7eM0Il1uySKTqVfADVyGJUrm+o+/vV/0DIs7BEq9P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7+MgNm2V6sYoeRLBUXxrQA+aU2AK2AYBxsnPsmu1v0wBPu/ZyiaWrjkdb+GuR6DQ9u5NOxWjVc8gMXL90W6vkRf0EYkT/Nl5FPCnU1d8zTWeuQogehqiSIXgK1m69Ddtkfi8weEJYxKKr38UJXrQdyW+TSTFTYxFtgatN7Vo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kceS75IP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso3733107a12.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715621360; x=1716226160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fiSNLoSRkIwD2QvYCFkUQj2s7HVJ7QWOwVftlDtmBo=;
        b=kceS75IPicTgOLjCgRQghOqaFadwqxEbiC60Kt5VPsF6QJuvZInA5V7qXLYt6StlsQ
         vGEv//xuTwhoZDJBwCnQb5yoiweatO/KAC0XNsJvl2kCoCd7ovi5m9+u5vDqX1G3hQ3o
         Od+q9P5+DhhGH6cQg/XKMRFedlqL6NVPQJ16k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621360; x=1716226160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fiSNLoSRkIwD2QvYCFkUQj2s7HVJ7QWOwVftlDtmBo=;
        b=k2qiR8rzdpJKPYTg3JQfswEldGm+QvlD6lI4OJs2yVfAyZhjFNKJxUvREJwkwdLMq2
         LmpzSKUOOEsFZnhxYpdSxusD9dBNE16DjbWok8KAne6Ypan3L9CJJAsJIaK9hcrErKui
         BNPTRxEOVKyQKkffp2TSmUVnTCIEitUrTFAtx3/MpWNTVh+ivLptIKWbmtgWObXuAKRL
         AYIyrkoXntos+W2xqmRaUV0kWo89mCtR8BmIO8qQ+pWAdnvkKFNgj/wAf/cDYJchH5S9
         Kqn+LbAJaAHZHDo9HP1zuhDIwJsj80VU0Dpr/UfEYgQF6Qwu5cIFSYdpLGbnkCdOLSTc
         dTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLgVCqZJ1xgjbfGuQkLqWB9tODsla4uqOMAnEIMPK4Y51Zwxtq++uP7w93+8JDOTZRzQr5xJnj6Zuyc2MDIAKJU2u0ybkl
X-Gm-Message-State: AOJu0YzZ+0ItmxNwOxSbsgULixksgyXMzRIm12vKQEqsbO4lxNZgMwTw
	HqJONA38f4L3yRXVkSci5BeQrrrItPdpX74rh2sJiM8QHqX2R2gSPQs+gYE8Giw=
X-Google-Smtp-Source: AGHT+IEga2eM2fy1tMh/mmDwNfv6n9tZBFsKCOIzoHkybl2XuIfRafqS4ONAbNjcK/B8CXawfDm29A==
X-Received: by 2002:a05:6a21:601:b0:1af:cbd3:ab48 with SMTP id adf61e73a8af0-1afde0af528mr8764530637.3.1715621360718;
        Mon, 13 May 2024 10:29:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1663sm81948995ad.6.2024.05.13.10.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:29:20 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v5 3/3] net/mlx4: support per-queue statistics via netlink
Date: Mon, 13 May 2024 17:29:08 +0000
Message-Id: <20240513172909.473066-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513172909.473066-1-jdamato@fastly.com>
References: <20240513172909.473066-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx4 compatible with the newly added netlink queue stats API.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 4d2f8c458346..281b34af0bb4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3100,6 +3101,77 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
 	last_i += NUM_PHY_STATS;
 }
 
+static void mlx4_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+	const struct mlx4_en_rx_ring *ring;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	ring = priv->rx_ring[i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+	stats->alloc_fail = READ_ONCE(ring->alloc_fail);
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static void mlx4_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+	const struct mlx4_en_tx_ring *ring;
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	ring = priv->tx_ring[TX][i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static void mlx4_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct mlx4_en_priv *priv = netdev_priv(dev);
+
+	spin_lock_bh(&priv->stats_lock);
+
+	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
+		goto out_unlock;
+
+	if (priv->rx_ring_num) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+	}
+
+	if (priv->tx_ring_num[TX]) {
+		tx->packets = 0;
+		tx->bytes = 0;
+	}
+
+out_unlock:
+	spin_unlock_bh(&priv->stats_lock);
+}
+
+static const struct netdev_stat_ops mlx4_stat_ops = {
+	.get_queue_stats_rx     = mlx4_get_queue_stats_rx,
+	.get_queue_stats_tx     = mlx4_get_queue_stats_tx,
+	.get_base_stats         = mlx4_get_base_stats,
+};
+
 int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 			struct mlx4_en_port_profile *prof)
 {
@@ -3263,6 +3335,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1



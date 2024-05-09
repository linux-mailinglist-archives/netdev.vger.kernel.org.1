Return-Path: <netdev+bounces-95141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD238C17F1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35421C21D26
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9A86258;
	Thu,  9 May 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jXh2kqeU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAC85620
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287871; cv=none; b=gRJM2FAdmU5zlAsLqX7n9nsi0/LVgR5aXU5un1HU7i/5rsDdOkCntrGMmzEII1BTPzTSXHZfPYMbPbLguGDYoo6+ZnfFajPmBomrldtgYKzcvHYupbTD7CzH9Jx4oGKY4YVAl3kJUEURKPlRO9vy88ZyJVSWdldsIlzIuigMicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287871; c=relaxed/simple;
	bh=jh0q0ulQ5LcPy3XQUg0Ue3n4pGfewvXGaX+N3ICGH+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIUlCYBTIPTgNleRdGU4QhQDfidnfNN+E5H21vYl+09KqrB3AtE0UANLLurUmezuWiGL4/0ZV8QF9EAcJysCCOV+RtgttJ2GIYvVnQVsAfLgZiFz0doil/tH5UNZPoiP7gGrltfA7SnH0cWX7ZvTRRxcWf+jlQDIG8Gr6thMInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jXh2kqeU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso10708685ad.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287869; x=1715892669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No8/jmvB2lIMy6tK61c0Wm+y+Z2VaVEhQDXdDb8ENDg=;
        b=jXh2kqeUaVQ0nhfXGHTIL23aws5KMCR8Yscd7r1sehBwfSwQRHDjCnXqcnG0IRr0oH
         3a+hKH2nHUvzXiXJA9/y/H35CGqSW2LAh6Wx5h13meATPrwl3nalSImdxrrhXHWILNuv
         4JPlAyjSq+MMJEmRPYcZXa80RgNMRcWQWZ1i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287869; x=1715892669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No8/jmvB2lIMy6tK61c0Wm+y+Z2VaVEhQDXdDb8ENDg=;
        b=VaZCNJvRWBT2YqlJDOoQYTht097FqnsCuEhCKKt3TdG5It2is1FvpSME5TSgqh7Ilj
         eX4ZNoIQ5Pvz6He69A+50ID+U3kJzzq6tEi9n4Do+dhniAuZl2BuY5FQXjFXVqphR+xN
         +wSeTPlD+J0b/PaiDzvCgwIncVDHOeLUIzoh5JAsGWPNm2XKKEnQvJJlqqLc1HBPT65R
         lRBfqN7ym55P7OfTffYK4ufokPQhUMd9FBrAnPMGBLlS7JqxBjODEkDSNTUQAgta6fVm
         uSogrZpYpzmg0lGy0Gu1Ed+opCNsbpWzbLuRt0cMgM3tajlTw0UzbWLKTJ6OeUIvKlyq
         OpKA==
X-Forwarded-Encrypted: i=1; AJvYcCVPHOI8DX3LFmWHrtgo8bGa2MlZJoKXDBHKrBbKU1yZ6dKcbbChIJW6Y36bNbMfFPT+Mok1dfcPS8QX9HhSvATuKFCciIaX
X-Gm-Message-State: AOJu0Yxnwi6e/VW4He4EmffnK2JqNsykhaWlHJcwvtq2pZkpKXLNBCLI
	v/C30QXl4ZRGwjFeQ9kA5Lbw1DS+6XXxiNwLbUMoiUzsELDl/JrK145YzJgBaHI=
X-Google-Smtp-Source: AGHT+IFdJzoOlK3+2PZn0yWAVQ5SUDkUUcQQGgjCs9iyqPeiJ5XXgMJqnpVya2oFF/6RdwbW0XGY1w==
X-Received: by 2002:a17:902:f812:b0:1eb:1474:5ef5 with SMTP id d9443c01a7336-1ef43d2ea72mr6154495ad.33.1715287868873;
        Thu, 09 May 2024 13:51:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/3] net/mlx4: support per-queue statistics via netlink
Date: Thu,  9 May 2024 20:50:56 +0000
Message-Id: <20240509205057.246191-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509205057.246191-1-jdamato@fastly.com>
References: <20240509205057.246191-1-jdamato@fastly.com>
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
index 4c089cfa027a..fd79e957b5d8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3099,6 +3100,77 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
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
@@ -3262,6 +3334,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1



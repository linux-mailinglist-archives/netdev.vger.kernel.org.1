Return-Path: <netdev+bounces-98725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF48D231D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B721C232F1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1898174ED3;
	Tue, 28 May 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PDRSplIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA10171069
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919912; cv=none; b=EkpJM1Yrrk8vdfAaVOq3tqJns+TcpEG1nFeZ9NcWRLiTUQnXMpuq3AfWAyIvfv/O5sZ6vGJaNiyhtfYWvZwfNaSevUMtzop9X3v0f3HeUBKBl5beBsogxTGBo6o5b5e9ZYRtsHR7Vli4i9onFHQBSGCSFDe+JG+jtAaC0vNBVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919912; c=relaxed/simple;
	bh=HLbaFyoM4QCM6qCh0lmKblqHhUr5Yb1xPECeS8JhKwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTlfG7aMb9izZsP9YTT8EFuXplYEitNHdAomdPD2pL3tcMx42ws/eh7a6p74OGSidZik27XNpefa98PPBTmya6igWMC++QavaqQVitMDUh2EN4Q4Rxk7UcX2zMkSrIrZG5uWHm470sa+Or3B56VaO4y208qB1dKM9XdQ7bUL2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PDRSplIZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so990877b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716919911; x=1717524711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziTBsOU+7FApePULAU8xAxlPyi/hAcaPSqVXZZ7lGPw=;
        b=PDRSplIZ6oL84i9Tb25O5OnAg29PlP1c1qa9KqWyb0pnw4kOgXrEYj7dd/a8Ww1zhN
         JZfL3n4WoBLjvjs0QdBBiS6vpbN6AMxBGb8EnF2ExRTMO5MuTbpL1P3pPj7ZkNij1AtC
         vTN5GXpiG7lTGQU0SM9ckbEJcgtI2tPmVMD4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716919911; x=1717524711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziTBsOU+7FApePULAU8xAxlPyi/hAcaPSqVXZZ7lGPw=;
        b=sZEKfMIYsZE5Ti2M6F75APe0g2y/t7bxUN9vQOLxnXEsu2DADGAWXxaHlcF51WtveJ
         1FUdJ16kBz5rF14EgIFgXf19rSii6LoX56lir+6yM4Clb+qsxDmcUaT4GVXJ/RDw7e3F
         lfKW9k9Srf2AYCl3mH2pWsXWcKiEcQtzQpaNqyW6bog5e4UAsFQQqEYZ3hMXuziLlV/i
         aDfzfQxx85YvT3nc/hNXi2WASZUDGKhiMufISnCwIeC0130ciYXDQha29wSPZ5rMk1TW
         Lpakj010cIdWuRFoQXFAZP8Y8GOzv201OR2Nkk27qERQfYrWpGq5aQJVluTixsguZoL+
         8cPw==
X-Forwarded-Encrypted: i=1; AJvYcCV8YY7p2QLWNMV2w2+jB5hYBg3kjTspQO7b7jwZ+c2D3xr7mmbDSOXJca9ap+REs6zVHQ3HICIZ1GlR4lCNKgC1wlL1bwPR
X-Gm-Message-State: AOJu0YzC3ByL0vOLNqqOaEwkJMG7bPglfnqa6MW8IdcSAWUw2UoQiZn+
	x5/BDNXFyNBEaN8pnDPK7Nba2DyWB005BG0+eX3s4qTyLWt9pSod47KFvj9A6IA=
X-Google-Smtp-Source: AGHT+IHMsPYMffQSLrHqovP+ORt+JmtPfbEq9itNJo7BWLkpZrL7fRfZti1HbUVDab+SRTYzmrd5+A==
X-Received: by 2002:a05:6a00:1f0f:b0:6f8:d4b8:b200 with SMTP id d2e1a72fcca58-6f8f2c60956mr14567299b3a.1.1716919910707;
        Tue, 28 May 2024 11:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcdebf54sm6718849b3a.112.2024.05.28.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 11:11:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v6 3/3] net/mlx4: support per-queue statistics via netlink
Date: Tue, 28 May 2024 18:11:38 +0000
Message-Id: <20240528181139.515070-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528181139.515070-1-jdamato@fastly.com>
References: <20240528181139.515070-1-jdamato@fastly.com>
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
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
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



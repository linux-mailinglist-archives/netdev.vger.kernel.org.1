Return-Path: <netdev+bounces-93125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E38BA241
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 23:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04E51F21521
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314251C0DD2;
	Thu,  2 May 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nByT/CQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBB1A38CF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685201; cv=none; b=E+JIRpL6gw/XXIsWYNPscpxakEFtSJVfJw6KsqO6QE5bk3FKnvaPrnIidPAO0VhZ5xHRkAwkliq4+GVFTAMRfMy0syeyENLTRILsLeNUi2SIQA8lemm8l3auCnrcDyYGgihnX/Inw6t6L+/2ATYs0syJfzh5gsKGPTrFQR/7tDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685201; c=relaxed/simple;
	bh=1kOXXplUo08+ODJHT/+Uy9/NKKn0D5hOO0fCSI3k7Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PazimenvsRtXHD1cCQW5exrGzjY7SPWsCNXLSHUwDkgt322oJNVSyGNYig0KFsS/rWUTvmDPGER2HA/rbKjVLsv+v99eBu0EpfOsMHRjUoAVF/C3dkTuqkm1N4Y+Zeclz3pOcE3czMdMwHV5DvCewxVFZ6ZauHzpQsyGQ3g5fWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nByT/CQk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f074520c8cso8034801b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714685199; x=1715289999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb3w24YsB4QKt3tkl4FaGZELaW6fLvSslAX1WvIMffs=;
        b=nByT/CQkSZTDQtziivWeY2UPupl+Dxr5VrsKBOEVK42NS+zJKtI0K6k1/kVp2/lN2a
         dib8HqOk7FIv5DS8L7+mIBRe2lZnisWCuhId3t3J4vt0FeJQO7EKjIcRY2R7wZyTub4C
         gJzFRqj3Mm/hLMaVu7d1PhTQBcyLnxyyocqbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685199; x=1715289999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb3w24YsB4QKt3tkl4FaGZELaW6fLvSslAX1WvIMffs=;
        b=Dtg9CrJWf0CUykBpuRQx+BFDRie5LwjM565uKsQKTDZui6/Au+nW8Omz6yogmjx4y2
         cY0SN0J+WYDp/kKcabpUty1tb5GcBUHimDpDxbkW8iRYDfGp7F7jjJl5ETe+iTXQCGe7
         4MkAr6wDvanTi9fu1Ro3JPQNMeEt/mO2GVX0jk5Bim8Q4MLmVrFJTghlmvE7mZSFb8ZP
         HYCKgkjl4FLpORaVYCwRRAeHWfrs2dihMInnwXBpHHcCT3NolAeEuFk9d9iSp7OTbsvc
         FPWak9tGLWQq59gheTMllglPRrL3z1qd29l3k0K72EWkrrSnPsCEjgKZXgq5qQPxMj+2
         mYaw==
X-Forwarded-Encrypted: i=1; AJvYcCWzn1fyGXsxw7LDINo11ir6d3A+rKsnMPXk3BwCGisB5qO9DIUgsgTV10o9scqOhtMLaOekROZCmc/qX8E22goc2FSLNfhP
X-Gm-Message-State: AOJu0YwniIZKji5lmRoZ4ahp4FItjWANspQjhTyj3DduxLwvaCbljoAx
	kayXqmNdKjXq3NyI0Z9vGjoCsnz9o0I5+fea0kyuHa8dX6WPoq6pdcU9B8zPiHg=
X-Google-Smtp-Source: AGHT+IEPo3Y+zOYWFNH/+K23XID3oSDwAiGVF0Rhk4+kI4NT0CfE7SfrogwaZmFO853Jnfkv0aI4ow==
X-Received: by 2002:a05:6a20:ddaa:b0:1a9:5ba1:3713 with SMTP id kw42-20020a056a20ddaa00b001a95ba13713mr1032630pzb.19.1714685199053;
        Thu, 02 May 2024 14:26:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006f4401df6c9sm1371345pfb.113.2024.05.02.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:38 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v3 3/3] net/mlx4: support per-queue statistics via netlink
Date: Thu,  2 May 2024 21:26:27 +0000
Message-Id: <20240502212628.381069-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502212628.381069-1-jdamato@fastly.com>
References: <20240502212628.381069-1-jdamato@fastly.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 5d3fde63b273..6875f8c5103a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -43,6 +43,7 @@
 #include <net/vxlan.h>
 #include <net/devlink.h>
 #include <net/rps.h>
+#include <net/netdev_queues.h>
 
 #include <linux/mlx4/driver.h>
 #include <linux/mlx4/device.h>
@@ -3099,6 +3100,83 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
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
+	if (i < 0 || i >= priv->rx_ring_num)
+		goto out_unlock;
+
+	ring = priv->rx_ring[i];
+	stats->packets = READ_ONCE(ring->packets);
+	stats->bytes   = READ_ONCE(ring->bytes);
+	stats->alloc_fail = READ_ONCE(ring->dropped);
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
+	if (i < 0 || i >= priv->tx_ring_num[TX])
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
@@ -3262,6 +3340,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
 	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
 
+	dev->stat_ops = &mlx4_stat_ops;
 	dev->ethtool_ops = &mlx4_en_ethtool_ops;
 
 	/*
-- 
2.25.1



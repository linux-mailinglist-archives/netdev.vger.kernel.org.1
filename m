Return-Path: <netdev+bounces-166848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD05A378DA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509873A7E1C
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7521AA7BF;
	Sun, 16 Feb 2025 23:32:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBB1AA1C9
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748777; cv=none; b=Fz3ps5Yoo9wHK3lR7mejuhfDkqS2DI6SWQTrupsHH762VpvLWmJFSZWkRePjgRiN+iPCQJ6wHXG+fg8lU3eKiBnGOt/Xdh0d8fk6ua5M4xtrKJxl7S7x1BfUdIFBBZVRqSVdIjUhAkSTVXigvAxOlH8Arw19LK4GqgCVZUaxpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748777; c=relaxed/simple;
	bh=7iuYgQAfrZEgVYbtKNiuUhWnBbAXH6U2LxSrCoXu2MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI8Rvu8rzSfSEsn1P6JBHM2Ez0oHTqABkONhcMtBaXslhENogWk+LXa5u4dXA0yMgTYD/Y8fxWjT1NA/vMVjPzvXwcMVthwDuJBmEZhgskzsRg9BqOur0G1cZN4TSZ5/wR2z4ch+57UT04SPYLrUDnpRuSbiUhhB2jbkScMNQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso4503469a91.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748775; x=1740353575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAE5Kpanqsdfs6wh7P0O4JYhfewGaIxplKFPaFnDd+o=;
        b=HPR1umRdYlEd1Cvbp50MZNjboRGKaT1vd2msCTVT+ea1Np3nCUhL4DRWpZbasKtAJ+
         XMFGyHOgBztLpacHPmiW33ND6gEKi5TxcTUkUepWlkskU5EWbFRNYq1iwJuIh9i/D2Xx
         V+ywfexPis1I83sw7IZAz+x4TXo6W+XAS4hVJ12UQrrM8cTdC10xjcgHt+QxMDMtuFYX
         ALV59titQQCsguuezQti3i02yrDmisjfBhj2GSSBBYTV8HlCw0454doZwlETIVYCGZHC
         /9s3vgHc3M7uynm23o0+cq8B78lzhze8rmOFTYXd2vYrr7e/iJi1vlfG+k4FqmNp1VB+
         xGsw==
X-Gm-Message-State: AOJu0YwIAUd1jtk98J1K9O2OyZBh+1W6QdFUFS9Vgy+v1lGjlHR24evK
	a+i5gGPqgIWKnQmNsaWaKEyPCSpsknne/wWEfwW15YhXHaVoGKX0HLIJ
X-Gm-Gg: ASbGncvmldo/GwhtrrbfmWS99xe2+kPKYLzJrlEOnUIRU3y+z7/2qT2koh6Su51d8WN
	FpMJKAaLlvbzvqHC9Gt9ZEIe8CZwINTyw1foBS9rYSgUuNlYynRSyQ6jrplbL4xicsMSJwGmfvw
	BOsUUQdA9DwQma6yKa0kZdud1uJL8iX5KfUVvghwwAzWxyqcdV9oaXX7D/MJL0Byizy9at8NycV
	2V/BQ5M/cXE3xpRfd1vci6nWqmSN+jJ5U2+k1CDqyWA6jorm05IGFAqQb2bJBcmmSbpO6ZkbOCA
	CqYsR3VJxh+enus=
X-Google-Smtp-Source: AGHT+IHoOtQMYJfqlPR8/pyfbTsxQCdC+kY62MwtmeZrU4su0fbVIYwpz61PR5Vk7kuVCSU/UZAg7g==
X-Received: by 2002:a17:90b:1e4f:b0:2ee:44ec:e524 with SMTP id 98e67ed59e1d1-2fc4116b32dmr11564112a91.35.1739748775302;
        Sun, 16 Feb 2025 15:32:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13ac0d3bsm6682360a91.13.2025.02.16.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:32:54 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v3 07/12] net: hold netdev instance lock during ndo_bpf
Date: Sun, 16 Feb 2025 15:32:40 -0800
Message-ID: <20250216233245.3122700-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216233245.3122700-1-sdf@fomichev.me>
References: <20250216233245.3122700-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover the paths that come via bpf system call and XSK bind.

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h |  1 +
 kernel/bpf/offload.c      |  6 ++++--
 net/core/dev.c            | 13 +++++++++++--
 net/core/dev_api.c        | 12 ++++++++++++
 net/xdp/xsk.c             |  3 +++
 net/xdp/xsk_buff_pool.c   |  2 ++
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ccd41f2fc3db..53fc0d02abc8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4221,6 +4221,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..a10153c3be2d 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -528,10 +528,10 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
 
 	bpf_map_init_from_attr(&offmap->map, attr);
-
 	rtnl_lock();
-	down_write(&bpf_devs_lock);
 	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
+	netdev_lock_ops(offmap->netdev);
+	down_write(&bpf_devs_lock);
 	err = bpf_dev_offload_check(offmap->netdev);
 	if (err)
 		goto err_unlock;
@@ -548,12 +548,14 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 
 	list_add_tail(&offmap->offloads, &ondev->maps);
 	up_write(&bpf_devs_lock);
+	netdev_unlock_ops(offmap->netdev);
 	rtnl_unlock();
 
 	return &offmap->map;
 
 err_unlock:
 	up_write(&bpf_devs_lock);
+	netdev_unlock_ops(offmap->netdev);
 	rtnl_unlock();
 	bpf_map_area_free(offmap);
 	return ERR_PTR(err);
diff --git a/net/core/dev.c b/net/core/dev.c
index 48a621c18d13..ac3713c74bcb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9637,7 +9637,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9657,7 +9657,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9687,6 +9686,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -9919,7 +9920,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10001,10 +10004,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 		goto out_unlock;
 	}
 
+	netdev_lock_ops(xdp_link->dev);
 	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
 	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
 			      xdp_link->flags, new_prog);
+	netdev_unlock_ops(xdp_link->dev);
 	if (err)
 		goto out_unlock;
 
@@ -10790,7 +10795,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		goto err_uninit_notify;
 
+	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
@@ -11745,7 +11752,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
 		dev_tcx_uninstall(dev);
+		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 		dev_memory_provider_uninstall(dev);
 
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 87a62022ef1c..0db20ed086d3 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -317,3 +317,15 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 	return ret;
 }
 EXPORT_SYMBOL(dev_set_mac_address);
+
+int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+{
+	int ret;
+
+	netdev_lock_ops(dev);
+	ret = netif_xdp_propagate(dev, bpf);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_xdp_propagate);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..277c97c58c09 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1178,6 +1178,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		goto out_release;
 	}
 
+	netdev_lock_ops(dev);
+
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -1312,6 +1314,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		smp_wmb();
 		WRITE_ONCE(xs->state, XSK_BOUND);
 	}
+	netdev_unlock_ops(dev);
 out_release:
 	mutex_unlock(&xs->mutex);
 	rtnl_unlock();
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c263fb7a68dc..0e6ca568fdee 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/netdevice.h>
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
 #include <net/xdp_sock_drv.h>
@@ -219,6 +220,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
+	netdev_ops_assert_locked(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
-- 
2.48.1



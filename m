Return-Path: <netdev+bounces-170012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EEA46D23
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8456A3AC3A8
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219425D53E;
	Wed, 26 Feb 2025 21:11:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B625D525
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740604280; cv=none; b=KkjkCI0Fjm4EKfKUQ+SF+Xb+ZJgXI93FLoPkmbVfXZuLxd1Jzy3XUqcasZEnGwatVUF8CCaRaADVjpddhUSC2p12BAMb7mBz1yC7IY3xp1tO63HUmbQg0u71szlgy3GBnLFA8bKgO48X7fiv+Bs7nr8s4QZiHfEGQnmlW04HLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740604280; c=relaxed/simple;
	bh=9tyYhGV4Dg4cv2Np3ckZ/cfXs57cNCDG6p+e3536sZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgr5RGRcGqAQiIzfgqF/Mx3ZoqF25q17ugFkO5s9Jq7KcoeV/0vmJ1Eg7rhnMWgWNrNaburKCF33XfJtYuYaUyzh0p+8CSSm7XeyBhiRTX0xxyIyWuRgRGC9ai1zuDyx+A2VHAdJoEAJohZ3k8qsqRLtBoPH8MHBEGMyjXlX4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2210d92292eso5164915ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740604278; x=1741209078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXTi27RPsnTo6yBdWjQVz7OIVa8kaqIesLzzzJE8Bkg=;
        b=f4rVM31wVuliVzdisR/3ZYKEstsIy4fvBx5Nr1vLDwkiweIPZM49Cvv64iZOgreDlr
         0OFq37RlAi13xKTGRU6QdcU/1OvXkRip0v8pWdsTkgCqD2ENdgg08O8T22r6XN6XHa06
         aC1mrwlj6fsFC/KzUsrNP1nLfBdA8FZpO1T5O9Cj9cLS4h8BDBVt1AgCamOTfuwWlRRR
         3rttD1dvE+4C4eSouA8/RTUIcxGMsGDyBeCjJMpXTDaWb2GAS4f+9kE9i+pnvkCDrOqn
         oUqP2sYRdowBMJLq+3lSkmelVSa+nnf90tdUIKkWO3o250rRMNvaQE7y+HJs9JVrapaB
         tIgg==
X-Gm-Message-State: AOJu0Ywyr1Ao2JwLX63CWD7M+tEwfZAvJqxiCcAl5a9DV53Z+XxbRBs7
	cJyM09dAmW+dKu1gHkhRnibQSAIkWRRRXVdMGQyg4uuegky8WhVZYix2
X-Gm-Gg: ASbGncu9rhd1tWbwVr6rzdYI+igjLvOQyO+6FY7orHdCrsz7WclR14Y/8lD3/nijGKM
	1NIriyrW/NiwznGtbm//RbHCmuJYNlReh8OuIoZNMO3C2pvdoXUSyrdIIgC01iYWxMQqJGPE/9o
	R/GCYihzJq+OYPWGW0K2PRdsfdiDIjmeqUr2iDxLpDGT4w5VUeH5FHUdfqkC+1OkhFpk5jZBfBI
	UnH3ZcsJKwqw8Ie0HpcKJJNNULePyQbJAX8c9ghEzkUTygUfmiwW5de6LT+5gmfeSg+L3mZ37j1
	LH8rtOzO1STaErwqmfZYmxdmZQ==
X-Google-Smtp-Source: AGHT+IFgq585XVh9NmCQqnru7Xs0PZknNG170m4k3SWDXvR5U2KCelwy2M3Uu600vlm6ETBfIpWWEw==
X-Received: by 2002:a17:902:e842:b0:220:ff93:e12e with SMTP id d9443c01a7336-22320082679mr77185215ad.1.1740604278099;
        Wed, 26 Feb 2025 13:11:18 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c603bsm624465ad.121.2025.02.26.13.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:11:17 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v8 07/12] net: hold netdev instance lock during ndo_bpf
Date: Wed, 26 Feb 2025 13:11:03 -0800
Message-ID: <20250226211108.387727-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226211108.387727-1-sdf@fomichev.me>
References: <20250226211108.387727-1-sdf@fomichev.me>
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
index d74c53aab95d..010755121c13 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4241,6 +4241,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
index aa5cb3972441..44766b2d76db 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9726,7 +9726,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9746,7 +9746,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9776,6 +9775,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10008,7 +10009,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10090,10 +10093,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
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
 
@@ -10879,7 +10884,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		goto err_uninit_notify;
 
+	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
@@ -11817,7 +11824,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
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
index 84bf9f1d4bf2..f864e5d70b40 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1181,6 +1181,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 		goto out_release;
 	}
 
+	netdev_lock_ops(dev);
+
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -1315,6 +1317,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
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



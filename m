Return-Path: <netdev+bounces-168647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC66AA4001B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D10242397A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD6253F1B;
	Fri, 21 Feb 2025 19:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDA253B74
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167777; cv=none; b=Xz1Dhs1O9vdMM+3e0VPjlUl/GHKJTBTlFuVYy9VESvE9UFrQ0cjXvyODiNEGdqlSgXmwCamiRhkK7fD2+NYAeNDdBnHjF4zEs7Q3MOaKROhK2U1qWO83t6cbJI59rshhlRXrfahMLpWcKsrslRsGVjpfNVfhXOzvDNEEhzartqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167777; c=relaxed/simple;
	bh=/+M4qXfqaWFQlJXXZRhoevGDL9XwJxoO3lxBrmB8WY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQo3lSo6mMIXeB1ssUHpP0TGIXvTnN7LPXfQvNdrjSWs8Nzua72+pTzKliq/zWqDv+gkP3YCRxSsFnWzUCYmHZB3YxfAK8bUTdME322kPQpfdMFNzZLOJcE/T0xd8M1Hgnd6R5N1cFQuylZ2JhMJV7UKau1k3WlGLgU6FLwV5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f2339dcfdso44981175ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167774; x=1740772574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15QMB35EivZbLJycHw8yMO4NIwOFfncef4Gv8PPRwsA=;
        b=mRGt/Hf0PsF/vm2O6iZW4K/Vyy8+V5ii8uQ7dhhCGtFmmlzxEce15PR/riUwqZO1AE
         OXSn4EAHRGz0RFjkeOWSCIJIQlsx/lpD7nJez3mnjbK9CHB9xZq9HLDVLAc+OfHkzrFJ
         DzTqh63u5UqJsDgTBzBA3wIm7l31zYc9q1LDHGmY9K+3w5fQeN8G/hUdCaUMB0Ew2iZN
         6Aj/fdl7oAPEamAAvBjQ5U4zQ4A6ZdV5k693CqVHmyKRU4ExhIjkhVg6AulNDK8OddrK
         vPP/770oUOFby3xk0QUhPnGDDmqiMPACT4C2UqMtjSiL61rFG+ky7Q3GkDCLWu78klvI
         ywGA==
X-Gm-Message-State: AOJu0Yy5tz47ZnQOJiWF/5ChIDkqMORZE4ecg2lBJMvI57aTwFPgYQNr
	o12QUTJCWZS2O1t9iX7XAW5WeHiVwC/+nmnJF3vT/bnecSrc3eyEF/Po
X-Gm-Gg: ASbGnctTZp3WJIOGHf7k+xv49PyuVVt2KJ9BbjdSGEKI5FWcMl5UoywmUKAAUCBujKM
	pkIGQRx9Yp+XesSAjDCEVefVLBgKfcdIkQ7OsnewicT9PyiIr8CUZb0ToMARV5GFfFT8jps97xn
	dj79iOLxVTAAMw4ChrU9GyffOTSfs2wM8v493G1Q4OxUoWLSZ1YN5T3zNqt1pBlOYnk7VmfJnlq
	nuXi4KANFpcsp8AdNPA6b4I4/0h7Cno+c+OI1V/7xLy+Kwntn5pTFQ38fsIa2HGqH2dX5wzPewx
	UuMTq8Pn8aOCi4hwLpOGfhTYfg==
X-Google-Smtp-Source: AGHT+IFDGAYJS4S4uP4hED4oBvRw8MtKWu0UBmaCFOvDnIuIuwsIR5vXj0qP8my6yvGv+bVDjysPYQ==
X-Received: by 2002:a17:902:eccb:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2218c3f4367mr146822545ad.14.1740167774491;
        Fri, 21 Feb 2025 11:56:14 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d468sm139170445ad.167.2025.02.21.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:56:14 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v6 07/12] net: hold netdev instance lock during ndo_bpf
Date: Fri, 21 Feb 2025 11:55:59 -0800
Message-ID: <20250221195604.2103132-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221195604.2103132-1-sdf@fomichev.me>
References: <20250221195604.2103132-1-sdf@fomichev.me>
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
index 7bf64fd29532..7eabcb203e92 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4239,6 +4239,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
index ca807abd10dd..abbc7603ed5a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9725,7 +9725,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9745,7 +9745,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9775,6 +9774,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -10007,7 +10008,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10089,10 +10092,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
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
 
@@ -10878,7 +10883,9 @@ int register_netdevice(struct net_device *dev)
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
index 0edf25973072..297a1b3ccc68 100644
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



Return-Path: <netdev+bounces-164882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CEA2F87B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA046188A68D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B25257441;
	Mon, 10 Feb 2025 19:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62376257AF2
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215256; cv=none; b=jV4bzkhBgppeNxn5otw1wdc4qhuieOLvhtIB6QjloevIg+dAbhDO2WN3lgM0I1eADBW5Raqo91G8qe5ob4/nRA1tcrECarQM1Epo3sgHKiMxdkp5wml9TLIJHdTkKEeI6bygKgojmH05/rrehcItMj7pSb/wdPnkoyCyCjj6Gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215256; c=relaxed/simple;
	bh=qsxlj/W08ZVX0D+Q+cniJALW1dWcJLp+00HovUdFDJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHKGR71gtRvtf92eQbTLzjCrWxLwQjLj8EWiZFe8kZtsvYHVuqStwalnMHlbc6XoBBPMUDuv4XyJ9QhS7UHiWxZqImlquZV8KMG3S8bAaLIU4EKO3KU4IhsayQnZ556QXkJp5V7VNagwkzuwrEIeecTiU50L1KMn+z1E8u4+740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f4a4fbb35so62235005ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215253; x=1739820053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZQRlyRjK7if+454RNM6TpgJ9dz4GwIthDk612Czvtw=;
        b=VWMPps41WMoRPrDdNPs+9/ZsK1J7Y7+Nd8oE2Ommj/7Wz73hcDc79lPN0iMiIAc7CH
         UQmdg9S1+66NiyXwTOa4VthHnBJCGvNq36uKfFCpkwPvJ40yN5fQ7EmQXRTmeQDmLCAm
         CS2H8EbpsPZj4ymBdyBmbixuYp8+XSJv3EG9VypJZi++3X7PfSxmPNChcaR1+DAEHo4O
         lsqgxTQ+A26//lhYG8HmjsnWXEmAi0kcUl3gh9sFwBuPVmXCRhDnAzUJzrPR+iUI9kJ1
         6FLBqgAdBipIevLXpeY1p0VjprskIzLCeZuW0z4o8L9cwym3lSFRfVoiRgzDXbIvx8eQ
         yOlw==
X-Gm-Message-State: AOJu0YxM4cCG6qK2RO6TmvrTE/FK6jEiu1bZ4Jy7gkzV6ajpewMbycgg
	giAZ+ouVmnXN0PUbzak33MG+h7T0rlsPycRSG8sOx8ILFpqLebmzNlDR
X-Gm-Gg: ASbGncs283GaYEwejyAF1umH0r6mU6j3oaIv5DeaQ90QNlS7ia6eqz5XlJFzxZaXZ7w
	VbIYMgeIOja6N9IndlVhyMNyNtR9yLb6g80D8W7GK5jPDtTTjlu2FGfeHPItIr9XUqUALU3Ow7P
	qWxu2dPpNF75itOyeR+ly1VOTzY50EaraC+AVv9iPRU+xRIIE2cgRxHVmZhMxN0AlC7IT9KQAVN
	CcYqyTG3tNq0+CJjw+f5TzOkwCSK6HwzkEfWNgGvq0xCaFGHChEugHEvYa89El12xHprvn7Dni4
	8lPX2v5Yk2hs2N0=
X-Google-Smtp-Source: AGHT+IHrOmXL4gy+PEV113Lz9u0dNem6aSunL6FvtrXOOmpW27GIg0DOzu0UG+zR7J1OYW6dWMa56A==
X-Received: by 2002:a17:902:f68b:b0:21f:97c3:f885 with SMTP id d9443c01a7336-21fb6f3a562mr8092695ad.18.1739215253336;
        Mon, 10 Feb 2025 11:20:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368cf7fcsm82261885ad.249.2025.02.10.11.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:20:52 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next 07/11] net: hold netdev instance lock during ndo_bpf
Date: Mon, 10 Feb 2025 11:20:39 -0800
Message-ID: <20250210192043.439074-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210192043.439074-1-sdf@fomichev.me>
References: <20250210192043.439074-1-sdf@fomichev.me>
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
 kernel/bpf/offload.c      |  7 ++++++-
 net/core/dev.c            | 13 +++++++++++--
 net/core/dev_api.c        | 12 ++++++++++++
 net/xdp/xsk.c             |  3 +++
 net/xdp/xsk_buff_pool.c   |  2 ++
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c4f182e4563e..675e5dee3219 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4215,6 +4215,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..a9d370c1b135 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -122,6 +122,7 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 {
 	struct netdev_bpf data = {};
 	struct net_device *netdev;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -130,7 +131,11 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
 	/* Caller must make sure netdev is valid */
 	netdev = offmap->netdev;
 
-	return netdev->netdev_ops->ndo_bpf(netdev, &data);
+	netdev_lock_ops(netdev);
+	ret = netdev->netdev_ops->ndo_bpf(netdev, &data);
+	netdev_unlock_ops(netdev);
+
+	return ret;
 }
 
 static void __bpf_map_offload_destroy(struct bpf_offloaded_map *offmap)
diff --git a/net/core/dev.c b/net/core/dev.c
index bc027cc8276a..fac1888c187e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9641,7 +9641,7 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
@@ -9661,7 +9661,6 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
 }
-EXPORT_SYMBOL_GPL(dev_xdp_propagate);
 
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
 {
@@ -9691,6 +9690,8 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
+	netdev_ops_assert_locked(dev);
+
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
@@ -9923,7 +9924,9 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 	 * already NULL, in which case link was already auto-detached
 	 */
 	if (xdp_link->dev) {
+		netdev_lock_ops(xdp_link->dev);
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
+		netdev_unlock_ops(xdp_link->dev);
 		xdp_link->dev = NULL;
 	}
 
@@ -10005,10 +10008,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
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
 
@@ -10794,7 +10799,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		goto err_uninit_notify;
 
+	netdev_lock_ops(dev);
 	__netdev_update_features(dev);
+	netdev_unlock_ops(dev);
 
 	/*
 	 *	Default initial state at registry is that the
@@ -11746,7 +11753,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		/* Shutdown queueing discipline. */
 		dev_shutdown(dev);
 		dev_tcx_uninstall(dev);
+		netdev_lock_ops(dev);
 		dev_xdp_uninstall(dev);
+		netdev_unlock_ops(dev);
 		bpf_dev_bound_netdev_unregister(dev);
 		dev_memory_provider_uninstall(dev);
 
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index d654db36ecc9..8dbeeac8d6e7 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -301,3 +301,15 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
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
index 1f7975b49657..87c337f36e66 100644
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



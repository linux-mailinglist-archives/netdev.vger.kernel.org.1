Return-Path: <netdev+bounces-167181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7FCA390B5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A048E171D52
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE814B086;
	Tue, 18 Feb 2025 02:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6B190068
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844603; cv=none; b=cwygRBaoin/h/cDC2OQ38LCfO/51szDcDkqsnVJS+hmf8gox18Y2j4WWrGa4hNtWZNKf8qoO76sDlG/ykl+9c+EIfNWQyDF9bqOY68qtTIPAc3Heax4fDwluB0V51cTCHf3LtZqR1H8oEJd3Ky836anrwcD0htcn1cBXC1AGhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844603; c=relaxed/simple;
	bh=8qfAnHaF30LhEw8mFF8EMcHbxOr5el3NRwKO9iekA9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/+odK5pyr4ek+FRkTFSxRdZgSes8RtlyPm6PS1x0FYv6fCMxsiBp4slfgQew9YyQeq9uZvyNtmnDvkodeyS2Ess3lIkFdWR6t2w0l9E+RqxhDUbUZPXjQ3745XqLC99obLA5F9k+nOh9QO1D3tKD0iPW7SF1PheAlawOQoWGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso7568213a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 18:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844601; x=1740449401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5s8UwklD/ggUfKC3+A9vKzyZAj11x7E1jhDnZtKEAo=;
        b=wjGTfydYYaX015ztTFXTjxUPbdObNWuDQbOebYmXJUAaVRFeqwgRHyaFc0hyOih8pQ
         Glqai1IIsPxxK5QUQ01CEpyBjNq4UkagpPbs2yFdTijHrZPms9rDhfUVfw/rWK5u/n3S
         c9wRxLZwEnH+xMYXndGbTfh40Vlzoh98zcm7S35Yb2cgsRhhye++yRZaaYpHARBwAfoy
         wqG0ZvPVsghNOH9KkaWo9Fdci9zoosJ3jF+uC+7nHCJszSVD/GsRT12WU+RJl347AnkL
         pHNkY8CrQ9qO4GngQK8Z4WbPp6O9gttR8eCIDsZNRoZ88i6LPCLnZZuYp2yfRWm3Yh1Y
         /zVw==
X-Gm-Message-State: AOJu0YxYKfB/4Tl1wf7oCDynPF5LYcsRDw/OUpaVOV0nTvx3w+Ccq3Dp
	e5jKxIZGucX6IQxZydwEHihn8UpmCvO6o1PBQQJu/WiT/irKR3X8BPAP
X-Gm-Gg: ASbGncvYWT47EwJGamlcAiGOlv907lPLp3z+4OqlIG/CgSdM0fsmQ72a2rRsuLH0Pbs
	7enoLGVq/4XW5QZSkC1LCBh/NYra+gUToMPr4TR7K7z/WvJO27ejVNpTDv17WGDRfjV5UBovV6t
	OR9InCa6Jx0VzdeKBGZjphURTJnZBeL1a0qKeItg0LL0Rk1c8cSRcRgi3+NFivaR+Pai07JWSTW
	zstiqCAiNgTx/LTtASQgXuanEl4r7a96CcsjmKjoFq0F/bUEplrNbgI/jrLTXfgE6DHlWOe4vSB
	92g4wKmIA1w1JKc=
X-Google-Smtp-Source: AGHT+IGB2nBuT2KAs4dlv+bG/BDQjs5++5pCnY87qYt4/CGQ+iJC6s2UVe5nSYKKKHM2DECA8Q6wGw==
X-Received: by 2002:a17:90b:5291:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-2fc0fa4122cmr30756611a91.12.1739844600461;
        Mon, 17 Feb 2025 18:10:00 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13aafa44sm8841359a91.5.2025.02.17.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:09:59 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v4 07/12] net: hold netdev instance lock during ndo_bpf
Date: Mon, 17 Feb 2025 18:09:43 -0800
Message-ID: <20250218020948.160643-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218020948.160643-1-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
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
index cc707b2bbf4b..11873947527d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4238,6 +4238,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
index 25696caa1071..b5a607bbf4a8 100644
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
@@ -11729,7 +11736,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
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



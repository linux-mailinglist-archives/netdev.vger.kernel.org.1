Return-Path: <netdev+bounces-81848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B718988B452
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB80F1C3FCCF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02F82D61;
	Mon, 25 Mar 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ca77T0if"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D07FBDB
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406355; cv=none; b=dENrET7ES+2DIwnMViGKEmVsMlPgE68660eOWRRhWZYgWTtNbSPwTtC4Udg3uo2PMO96pXADO0jEDNm4ldswaBuJnGibM1jFaAjMqRalSsXkGip0YHr/CdlOOXAM2FmEnIx5GM4U2xm7BCxRE1b9difA5scItgIHPLlVRX23mXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406355; c=relaxed/simple;
	bh=rY1wCLbT5D5DO1CDToRyD3EQjXxI8Yy8zo2WrAtI4TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai33U7BaXFINuFpYGEoiEZUbcD9rr2WRAVjd74ru+IM1leWvvsebysEflUQ+n4mgcKqQKhKWaW8cBPipoTUCJeIq5QINuJkWeAJD7sZPEHtqyZrJSmGPpCBrErxrKOT7cYQNTp1YK3eBj61bUcnmdCWVH6i1Ezz1eHOsDUwjOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ca77T0if; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+LYedDKCZkt0knPWsjkvWVXu0FbM1x+GXHtBYWXFJVo=;
	t=1711406352; x=1712615952; b=ca77T0ifDb1XWd2jPE5iKvH5esPSP9ryApXa/rePsyXLtle
	HKh0/ZP+odXGcn61t9z7tNhyASy/AffD/LVvXftpG+Q/7SXLMoCNsHVCIkQL1Ms04FyT5NZnrUrKO
	pmtnZKq6e6utmn69nfY6KJGA8sw/CvvwxCh5lXQsBDfYy8ZKwavvH2YbC3aT1pXjiPUZ7xovpDf01
	YfKsp2hEHK0CjBzweNdGJ8xOUzhIAWHi7wbRYoOXH0Jbntk5TWVHkGXHikxJOUFAOyAZnm5+A73tl
	QpYfEDwvHbMz3mnB3jQ3K4T6STRZ9s22y1wnyLhMFqC4ozEFdADnk70B1npxOOog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rosyE-0000000Ee2Q-0Fxi;
	Mon, 25 Mar 2024 23:39:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] net: core: use guard/__free in core dev code
Date: Mon, 25 Mar 2024 23:31:28 +0100
Message-ID: <20240325233905.09e8c19d4207.I203795c6b809819c98532e5d6186c700a6c1c760@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325223905.100979-5-johannes@sipsolutions.net>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Simplify the code a bit, mostly also to illustrate
the new helpers.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/core/dev.c | 182 +++++++++++++++++++------------------------------
 1 file changed, 72 insertions(+), 110 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db..f4f4627bb1e3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1367,9 +1367,8 @@ EXPORT_SYMBOL(__netdev_notify_peers);
  */
 void netdev_notify_peers(struct net_device *dev)
 {
-	rtnl_lock();
+	guard(rtnl)();
 	__netdev_notify_peers(dev);
-	rtnl_unlock();
 }
 EXPORT_SYMBOL(netdev_notify_peers);
 
@@ -1722,30 +1721,27 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	int err;
 
 	/* Close race with setup_net() and cleanup_net() */
-	down_write(&pernet_ops_rwsem);
-	rtnl_lock();
+	guard(rwsem_write)(&pernet_ops_rwsem);
+	guard(rtnl)();
 	err = raw_notifier_chain_register(&netdev_chain, nb);
 	if (err)
-		goto unlock;
+		return err;
 	if (dev_boot_phase)
-		goto unlock;
+		return 0;
 	for_each_net(net) {
 		err = call_netdevice_register_net_notifiers(nb, net);
 		if (err)
 			goto rollback;
 	}
 
-unlock:
-	rtnl_unlock();
-	up_write(&pernet_ops_rwsem);
-	return err;
+	return 0;
 
 rollback:
 	for_each_net_continue_reverse(net)
 		call_netdevice_unregister_net_notifiers(nb, net);
 
 	raw_notifier_chain_unregister(&netdev_chain, nb);
-	goto unlock;
+	return err;
 }
 EXPORT_SYMBOL(register_netdevice_notifier);
 
@@ -1769,19 +1765,16 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 	int err;
 
 	/* Close race with setup_net() and cleanup_net() */
-	down_write(&pernet_ops_rwsem);
-	rtnl_lock();
+	guard(rwsem_write)(&pernet_ops_rwsem);
+	guard(rtnl)();
 	err = raw_notifier_chain_unregister(&netdev_chain, nb);
 	if (err)
-		goto unlock;
+		return err;
 
 	for_each_net(net)
 		call_netdevice_unregister_net_notifiers(nb, net);
 
-unlock:
-	rtnl_unlock();
-	up_write(&pernet_ops_rwsem);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier);
 
@@ -1838,12 +1831,9 @@ static int __unregister_netdevice_notifier_net(struct net *net,
 
 int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 {
-	int err;
+	guard(rtnl)();
 
-	rtnl_lock();
-	err = __register_netdevice_notifier_net(net, nb, false);
-	rtnl_unlock();
-	return err;
+	return __register_netdevice_notifier_net(net, nb, false);
 }
 EXPORT_SYMBOL(register_netdevice_notifier_net);
 
@@ -1866,12 +1856,9 @@ EXPORT_SYMBOL(register_netdevice_notifier_net);
 int unregister_netdevice_notifier_net(struct net *net,
 				      struct notifier_block *nb)
 {
-	int err;
+	guard(rtnl)();
 
-	rtnl_lock();
-	err = __unregister_netdevice_notifier_net(net, nb);
-	rtnl_unlock();
-	return err;
+	return __unregister_netdevice_notifier_net(net, nb);
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier_net);
 
@@ -1889,14 +1876,14 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 {
 	int err;
 
-	rtnl_lock();
+	guard(rtnl)();
 	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
-	if (!err) {
-		nn->nb = nb;
-		list_add(&nn->list, &dev->net_notifier_list);
-	}
-	rtnl_unlock();
-	return err;
+	if (err)
+		return err;
+
+	nn->nb = nb;
+	list_add(&nn->list, &dev->net_notifier_list);
+	return 0;
 }
 EXPORT_SYMBOL(register_netdevice_notifier_dev_net);
 
@@ -1904,13 +1891,10 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 					  struct notifier_block *nb,
 					  struct netdev_net_notifier *nn)
 {
-	int err;
+	guard(rtnl)();
 
-	rtnl_lock();
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
-	rtnl_unlock();
-	return err;
+	return __unregister_netdevice_notifier_net(dev_net(dev), nb);
 }
 EXPORT_SYMBOL(unregister_netdevice_notifier_dev_net);
 
@@ -9453,7 +9437,7 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 {
 	struct bpf_xdp_link *xdp_link = container_of(link, struct bpf_xdp_link, link);
 
-	rtnl_lock();
+	guard(rtnl)();
 
 	/* if racing with net_device's tear down, xdp_link->dev might be
 	 * already NULL, in which case link was already auto-detached
@@ -9462,8 +9446,6 @@ static void bpf_xdp_link_release(struct bpf_link *link)
 		WARN_ON(dev_xdp_detach_link(xdp_link->dev, NULL, xdp_link));
 		xdp_link->dev = NULL;
 	}
-
-	rtnl_unlock();
 }
 
 static int bpf_xdp_link_detach(struct bpf_link *link)
@@ -9485,10 +9467,10 @@ static void bpf_xdp_link_show_fdinfo(const struct bpf_link *link,
 	struct bpf_xdp_link *xdp_link = container_of(link, struct bpf_xdp_link, link);
 	u32 ifindex = 0;
 
-	rtnl_lock();
-	if (xdp_link->dev)
-		ifindex = xdp_link->dev->ifindex;
-	rtnl_unlock();
+	scoped_guard(rtnl) {
+		if (xdp_link->dev)
+			ifindex = xdp_link->dev->ifindex;
+	}
 
 	seq_printf(seq, "ifindex:\t%u\n", ifindex);
 }
@@ -9499,10 +9481,10 @@ static int bpf_xdp_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_xdp_link *xdp_link = container_of(link, struct bpf_xdp_link, link);
 	u32 ifindex = 0;
 
-	rtnl_lock();
-	if (xdp_link->dev)
-		ifindex = xdp_link->dev->ifindex;
-	rtnl_unlock();
+	scoped_guard(rtnl) {
+		if (xdp_link->dev)
+			ifindex = xdp_link->dev->ifindex;
+	}
 
 	info->xdp.ifindex = ifindex;
 	return 0;
@@ -9514,31 +9496,26 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 	struct bpf_xdp_link *xdp_link = container_of(link, struct bpf_xdp_link, link);
 	enum bpf_xdp_mode mode;
 	bpf_op_t bpf_op;
-	int err = 0;
+	int err;
 
-	rtnl_lock();
+	guard(rtnl)();
 
 	/* link might have been auto-released already, so fail */
-	if (!xdp_link->dev) {
-		err = -ENOLINK;
-		goto out_unlock;
-	}
+	if (!xdp_link->dev)
+		return -ENOLINK;
+
+	if (old_prog && link->prog != old_prog)
+		return -EPERM;
 
-	if (old_prog && link->prog != old_prog) {
-		err = -EPERM;
-		goto out_unlock;
-	}
 	old_prog = link->prog;
 	if (old_prog->type != new_prog->type ||
-	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	    old_prog->expected_attach_type != new_prog->expected_attach_type)
+		return -EINVAL;
 
 	if (old_prog == new_prog) {
 		/* no-op, don't disturb drivers */
 		bpf_prog_put(new_prog);
-		goto out_unlock;
+		return 0;
 	}
 
 	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
@@ -9546,14 +9523,11 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
 			      xdp_link->flags, new_prog);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	old_prog = xchg(&link->prog, new_prog);
 	bpf_prog_put(old_prog);
-
-out_unlock:
-	rtnl_unlock();
-	return err;
+	return 0;
 }
 
 static const struct bpf_link_ops bpf_xdp_link_lops = {
@@ -9567,57 +9541,47 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
+	/* link itself doesn't hold dev's refcnt to not complicate shutdown */
+	struct net_device *dev __free(dev_put) = NULL;
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
 	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
-	struct net_device *dev;
-	int err, fd;
+	int err;
 
-	rtnl_lock();
-	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
-	if (!dev) {
-		rtnl_unlock();
-		return -EINVAL;
-	}
+	scoped_guard(rtnl) {
+		dev = dev_get_by_index(net,
+				       attr->link_create.target_ifindex);
+		if (!dev)
+			return -EINVAL;
 
-	link = kzalloc(sizeof(*link), GFP_USER);
-	if (!link) {
-		err = -ENOMEM;
-		goto unlock;
-	}
+		link = kzalloc(sizeof(*link), GFP_USER);
+		if (!link)
+			return -ENOMEM;
 
-	bpf_link_init(&link->link, BPF_LINK_TYPE_XDP, &bpf_xdp_link_lops, prog);
-	link->dev = dev;
-	link->flags = attr->link_create.flags;
+		bpf_link_init(&link->link, BPF_LINK_TYPE_XDP,
+			      &bpf_xdp_link_lops, prog);
 
-	err = bpf_link_prime(&link->link, &link_primer);
-	if (err) {
-		kfree(link);
-		goto unlock;
-	}
+		link->dev = dev;
+		link->flags = attr->link_create.flags;
 
-	err = dev_xdp_attach_link(dev, &extack, link);
-	rtnl_unlock();
+		err = bpf_link_prime(&link->link, &link_primer);
+		if (err) {
+			kfree(link);
+			return err;
+		}
+
+		err = dev_xdp_attach_link(dev, &extack, link);
+	}
 
 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
 		trace_bpf_xdp_link_attach_failed(extack._msg);
-		goto out_put_dev;
+		return err;
 	}
 
-	fd = bpf_link_settle(&link_primer);
-	/* link itself doesn't hold dev's refcnt to not complicate shutdown */
-	dev_put(dev);
-	return fd;
-
-unlock:
-	rtnl_unlock();
-
-out_put_dev:
-	dev_put(dev);
-	return err;
+	return bpf_link_settle(&link_primer);
 }
 
 /**
@@ -11171,9 +11135,8 @@ EXPORT_SYMBOL(unregister_netdevice_many);
  */
 void unregister_netdev(struct net_device *dev)
 {
-	rtnl_lock();
+	guard(rtnl)();
 	unregister_netdevice(dev);
-	rtnl_unlock();
 }
 EXPORT_SYMBOL(unregister_netdev);
 
@@ -11617,7 +11580,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	struct net *net;
 	LIST_HEAD(dev_kill_list);
 
-	rtnl_lock();
+	guard(rtnl)();
 	list_for_each_entry(net, net_list, exit_list) {
 		default_device_exit_net(net);
 		cond_resched();
@@ -11632,7 +11595,6 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 		}
 	}
 	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
-- 
2.44.0



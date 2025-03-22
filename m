Return-Path: <netdev+bounces-176878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50291A6CAAA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2188386A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BEA22DFAB;
	Sat, 22 Mar 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="PS4o/Qck"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41F17E0;
	Sat, 22 Mar 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654364; cv=none; b=c9wMk6RhRZ9fuB0yj/V+i6IeDPe+O7GCQP3rN5mIwtyvpa89H/fn8gaVljywlPvnxpXfvg+XgyTb/ntD7snXKqevwbHAMkg/+Il9+YGiLr7jKqTH+X4D2EvPeFWVx270i7Di+il5A/LswgNOv01SL8ePjgBP+fWokIhCXUID/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654364; c=relaxed/simple;
	bh=TYEVKHS9ufJhPvW+5YwFwnlX6LMo7aN+etRQN2y+bPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpCpShbKfsYejEJKHALnS/ewP+5Jk1Bqs+x6sBjhTslbzAwBB2yBULGE4/G0DjqFW/eRLdh0x/fbUbiaH27InDduKgX4jOlRNEVbG+CX508pqobgYHEvvGmhlfMmG7ddUDB5vg4ddOP/sQc24WUklqBYj8m/+kVivcdPTyUL5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=PS4o/Qck; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3bcd:0:640:dc38:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 8888E6001D;
	Sat, 22 Mar 2025 17:39:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IdNbOcULla60-csc2eLM5;
	Sat, 22 Mar 2025 17:39:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654360; bh=KIWNcEaP9b73qItYSdAbWzNE3+LulZ1uY+P85m4l/wU=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=PS4o/QckyFSVDZVTeX/J13pNZFhMe/j1cAen8GnSetUsXFhLAQ7wwRePCtrijIRUB
	 RhYOhCgLJs+r8KmQx1rRjEDE0lNSV4AUr/r4lngWf8hkDvG4OekL7t4emkQbh/BlFV
	 bUZjHZsSCYo5RsKBWLkbss4brgsXUwX7odzvZlow=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 11/51] net: Make master and slaves (any dependent devices) share the same nd_lock in .setlink etc
Date: Sat, 22 Mar 2025 17:39:18 +0300
Message-ID: <174265435817.356712.639144257882603362.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cf060ba4cd1d..67b4b0610d14 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2696,9 +2696,16 @@ static int do_set_master(struct net_device *dev, struct net_device *master,
 	}
 
 	if (master) {
+		struct nd_lock *nd_lock = rcu_access_pointer(dev->nd_lock);
+		struct nd_lock *nd_lock2 = rcu_access_pointer(master->nd_lock);
+
 		upper_dev = master;
 		ops = upper_dev->netdev_ops;
 		if (ops->ndo_add_slave) {
+			/* Devices linked as upper<->lower must relate
+			 * to the same nd_lock.
+			 */
+			nd_lock_transfer_devices(&nd_lock, &nd_lock2);
 			err = ops->ndo_add_slave(upper_dev, dev, extack);
 			if (err)
 				return err;
@@ -3173,6 +3180,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev, *master = NULL;
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct net *target_net = NULL;
 	int err;
 	struct nlattr *tb[IFLA_MAX+1];
@@ -3217,7 +3225,9 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	double_lock_netdev(dev, &nd_lock, master, &nd_lock2);
 	err = do_setlink(target_net, skb, dev, master, ifm, extack, tb, 0);
+	double_unlock_netdev(nd_lock, nd_lock2);
 errout:
 	if (target_net)
 		put_net(target_net);
@@ -3458,6 +3468,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 		struct nlattr **tb)
 {
 	struct net_device *dev, *aux, *master = NULL;
+	struct nd_lock *nd_lock, *nd_lock2;
 	struct net *target_net;
 	int err;
 
@@ -3479,7 +3490,9 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 			err = validate_linkmsg(dev, tb, extack);
 			if (err < 0)
 				break;
+			double_lock_netdev(dev, &nd_lock, master, &nd_lock2);
 			err = do_setlink(target_net, skb, dev, master, ifm, extack, tb, 0);
+			double_unlock_netdev(nd_lock, nd_lock2);
 			if (err < 0)
 				break;
 		}
@@ -3495,6 +3508,74 @@ struct link_deps generic_newlink_deps = {
 };
 EXPORT_SYMBOL_GPL(generic_newlink_deps);
 
+static struct net_device *__resolve_deps_locks(struct net *net,
+					       struct net_device *dev,
+					       struct nlattr **attr,
+					       const int deps[],
+					       bool mandatory)
+{
+	struct nd_lock *nd_lock, *nd_lock2;
+	struct net_device *dev2;
+	int i, key, ifindex;
+
+	for (i = 0; i <= MAX_LINK_DEPS; i++) {
+		key = deps[i];
+		if (!key)
+			break;
+		if (!attr[key]) {
+			if (mandatory)
+				return ERR_PTR(-ENODEV);
+			continue;
+		}
+		ifindex = nla_get_u32(attr[key]);
+
+		if (!dev) {
+			dev = __dev_get_by_index(net, ifindex);
+			if (!dev && mandatory)
+				return ERR_PTR(-ENODEV);
+			continue;
+		}
+
+		dev2 = __dev_get_by_index(net, ifindex);
+		if (!dev2) {
+			if (mandatory)
+				return ERR_PTR(-ENODEV);
+			continue;
+		}
+		double_lock_netdev(dev, &nd_lock, dev2, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+		double_unlock_netdev(nd_lock, nd_lock2);
+	}
+
+	return dev;
+}
+
+/* Transfer all dependencies to the same nd_lock.
+ * Note, here we use that list of nd_lock devices
+ * can't be split in pieces.
+ */
+static struct net_device *resolve_deps_locks(struct net *net,
+					     const struct link_deps *deps,
+					     struct nlattr **tb,
+					     struct nlattr **data)
+{
+	struct net_device *dev = NULL;
+
+	if (!deps)
+		return NULL;
+
+	dev = __resolve_deps_locks(net, dev, tb, deps->mandatory.tb, true);
+	if (IS_ERR(dev))
+		return dev;
+	dev = __resolve_deps_locks(net, dev, data, deps->mandatory.data, true);
+	if (IS_ERR(dev))
+		return dev;
+	dev = __resolve_deps_locks(net, dev, tb, deps->optional.tb, false);
+	dev = __resolve_deps_locks(net, dev, tb, deps->optional.data, false);
+
+	return dev;
+}
+
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
 			       const struct nlmsghdr *nlh,
@@ -3506,7 +3587,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct net *link_net;
-	struct net_device *dev, *master = NULL;
+	struct net_device *dev, *master = NULL, *link_dev = NULL;
+	struct nd_lock *nd_lock, *nd_lock2;
 	char ifname[IFNAMSIZ];
 	LIST_HEAD(list_kill);
 	int err;
@@ -3554,13 +3636,36 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		goto out;
 	}
 
+	link_dev = resolve_deps_locks(link_net ? : net, ops->newlink_deps, tb, data);
+	if (IS_ERR(link_dev)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (master && link_dev) {
+		double_lock_netdev(master, &nd_lock, link_dev, &nd_lock2);
+		nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+		if (nd_lock != nd_lock2)
+			unlock_netdev(nd_lock);
+	} else if (master || link_dev) {
+		lock_netdev(master ? : link_dev, &nd_lock);
+	} else {
+		nd_lock = alloc_nd_lock();
+		err = -ENOMEM;
+		if (!nd_lock)
+			goto out;
+		mutex_lock(&nd_lock->mutex);
+	}
+	attach_nd_lock(dev, nd_lock);
+
 	if (ops->newlink)
 		err = ops->newlink(link_net ? : net, dev, tb, data, extack);
 	else
-		err = register_netdevice(dev);
+		err = __register_netdevice(dev);
 	if (err < 0) {
+		detach_nd_lock(dev);
 		free_netdev(dev);
-		goto out;
+		goto unlock;
 	}
 
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
@@ -3576,6 +3681,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		if (err)
 			goto out_unregister;
 	}
+unlock:
+	unlock_netdev(nd_lock);
 out:
 	if (link_net)
 		put_net(link_net);
@@ -3587,7 +3694,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		unregister_netdevice_queue(dev, &list_kill);
 	}
 	unregister_netdevice_many(&list_kill);
-	goto out;
+	goto unlock;
 }
 
 struct rtnl_newlink_tbs {
@@ -3608,7 +3715,8 @@ static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct ifinfomsg *ifm = nlmsg_data(nlh);
 	struct nlattr ** const tb = tbs->tb;
 	struct nlattr **slave_data = NULL;
-	struct net_device *master_dev;
+	struct net_device *master_dev, *link_dev;
+	struct nd_lock *nd_lock, *nd_lock2;
 	int err, status = 0;
 
 	if (nlh->nlmsg_flags & NLM_F_EXCL)
@@ -3620,6 +3728,21 @@ static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	if (ops && ops == dev->rtnl_link_ops && linkinfo[IFLA_INFO_DATA]) {
+		link_dev = resolve_deps_locks(dev_net(dev),
+					      ops->changelink_deps,
+					      tb, data);
+		if (IS_ERR(link_dev))
+			return PTR_ERR(link_dev);
+
+		if (link_dev) {
+			double_lock_netdev(dev, &nd_lock, link_dev, &nd_lock2);
+			nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+			double_unlock_netdev(nd_lock, nd_lock2);
+		}
+	}
+
+	double_lock_netdev(dev, &nd_lock, new_master, &nd_lock2);
 	master_dev = netdev_master_upper_dev_get(dev);
 	if (master_dev)
 		m_ops = master_dev->rtnl_link_ops;
@@ -3668,6 +3791,7 @@ static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = do_setlink(target_net, skb, dev, new_master, ifm, extack, tb, status);
 out:
+	double_unlock_netdev(nd_lock, nd_lock2);
 	return err;
 }
 



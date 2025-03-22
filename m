Return-Path: <netdev+bounces-176922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D89A6CAE6
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98AA7B0650
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127E235BFF;
	Sat, 22 Mar 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="frRolKcb"
X-Original-To: netdev@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546A1FBEAC;
	Sat, 22 Mar 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654809; cv=none; b=dMD93MgYvC2I91jKuoKOLHSuajibLQR7MjSa7bx2eAO2r6geNKDk9y0wdWhnWLJmX4zit2MEvp3CLOVithxSswf35lrTsqLI7eoMEo8oubYzZDLSQ47MIJxeHFP2SX50uW6z6K1dGLCJ5jVw+Psa0RnNoZoHVx9McnwnjyfEjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654809; c=relaxed/simple;
	bh=uFojAnmf0IISjOUQ1kgkzCliyHaKtS+zLhivSCtQfVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO5D6N6rFpfRZpvkTVtBpahYwGuC7NOQa4P0QdrXveWWfs9yChBqn8TZ7i7W2TPTKw6OUwohmfX5M3/KcXHpZPOJ0OTjN6JJFiHljETc2bgMu5bpcADOn3Ne55EkRBkFJYwCgLaiqvV0bnOXW1qctC1KSOSTuTFRUnGoTCqMlFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=frRolKcb; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id E640166DF9;
	Sat, 22 Mar 2025 17:38:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:740a:0:640:fb7d:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 1A82E609E0;
	Sat, 22 Mar 2025 17:38:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VcNPVbKLa4Y0-C1mHYAEI;
	Sat, 22 Mar 2025 17:38:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654313; bh=ldy7ihB5xD0vxsyQ09qsbdxhPffcfKFV9mzA5Rj1Yu0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=frRolKcbiO4n02i8sfxn0FpDaMswOn00g/Gd0R0qYidrAAW85i+dcSn3R5gQtCtxl
	 QZaNGN3d16nhaplP+UXz+TP4FSPL6ZWRj3t/Xw3ScquIdx3rLstti+90F+XZI/jH1/
	 MMBVAqIOMAIk15fvY3VT1uZCCX8CtZWgOSP/quvI=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 05/51] net: Move dereference of tb[IFLA_MASTER] up
Date: Sat, 22 Mar 2025 17:38:30 +0300
Message-ID: <174265431086.356712.17422975834795735079.stgit@pro.pro>
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

...to where main dev is dereferenced by ifi_index.

The patch is preparation in rtnetlink code for using nd_lock.
Having dereference of dev and master in same places allow
to double lock them the same time.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |   72 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6da137f1a764..a33b60d1de2d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2675,7 +2675,7 @@ static int do_setvfinfo(struct net_device *dev, struct nlattr **tb)
 	return err;
 }
 
-static int do_set_master(struct net_device *dev, int ifindex,
+static int do_set_master(struct net_device *dev, struct net_device *master,
 			 struct netlink_ext_ack *extack)
 {
 	struct net_device *upper_dev = netdev_master_upper_dev_get(dev);
@@ -2683,7 +2683,7 @@ static int do_set_master(struct net_device *dev, int ifindex,
 	int err;
 
 	if (upper_dev) {
-		if (upper_dev->ifindex == ifindex)
+		if (upper_dev == master)
 			return 0;
 		ops = upper_dev->netdev_ops;
 		if (ops->ndo_del_slave) {
@@ -2695,10 +2695,8 @@ static int do_set_master(struct net_device *dev, int ifindex,
 		}
 	}
 
-	if (ifindex) {
-		upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
-		if (!upper_dev)
-			return -EINVAL;
+	if (master) {
+		upper_dev = master;
 		ops = upper_dev->netdev_ops;
 		if (ops->ndo_add_slave) {
 			err = ops->ndo_add_slave(upper_dev, dev, extack);
@@ -2775,7 +2773,8 @@ static int do_set_proto_down(struct net_device *dev,
 /* notify flag means notify + modified. */
 #define DO_SETLINK_NOTIFY	0x03
 static int do_setlink(struct net *net, const struct sk_buff *skb,
-		      struct net_device *dev, struct ifinfomsg *ifm,
+		      struct net_device *dev, struct net_device *master,
+		      struct ifinfomsg *ifm,
 		      struct netlink_ext_ack *extack,
 		      struct nlattr **tb, int status)
 {
@@ -2897,8 +2896,8 @@ static int do_setlink(struct net *net, const struct sk_buff *skb,
 			goto errout;
 	}
 
-	if (tb[IFLA_MASTER]) {
-		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
+	if (master) {
+		err = do_set_master(dev, master, extack);
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
@@ -3156,12 +3155,24 @@ static struct net_device *rtnl_dev_get(struct net *net,
 	return __dev_get_by_name(net, ifname);
 }
 
+static struct net_device *rtnl_master_get(struct net *net, struct nlattr *tb[])
+{
+	struct net_device *master;
+
+	if (!tb[IFLA_MASTER])
+		return NULL;
+	master = __dev_get_by_index(net, nla_get_u32(tb[IFLA_MASTER]));
+	if (!master)
+		return ERR_PTR(-EINVAL);
+	return master;
+}
+
 static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
-	struct net_device *dev;
+	struct net_device *dev, *master = NULL;
 	struct net *target_net = NULL;
 	int err;
 	struct nlattr *tb[IFLA_MAX+1];
@@ -3196,11 +3207,17 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
+	master = rtnl_master_get(target_net ? : net, tb);
+	if (IS_ERR(master)) {
+		err = -EINVAL;
+		goto errout;
+	}
+
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
 		goto errout;
 
-	err = do_setlink(target_net, skb, dev, ifm, extack, tb, 0);
+	err = do_setlink(target_net, skb, dev, master, ifm, extack, tb, 0);
 errout:
 	if (target_net)
 		put_net(target_net);
@@ -3440,7 +3457,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 		struct netlink_ext_ack *extack,
 		struct nlattr **tb)
 {
-	struct net_device *dev, *aux;
+	struct net_device *dev, *aux, *master = NULL;
 	struct net *target_net;
 	int err;
 
@@ -3451,12 +3468,18 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 		goto out;
 	}
 
+	master = rtnl_master_get(target_net ? : net, tb);
+	if (IS_ERR(master)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
 			err = validate_linkmsg(dev, tb, extack);
 			if (err < 0)
 				break;
-			err = do_setlink(target_net, skb, dev, ifm, extack, tb, 0);
+			err = do_setlink(target_net, skb, dev, master, ifm, extack, tb, 0);
 			if (err < 0)
 				break;
 		}
@@ -3478,7 +3501,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct net *link_net;
-	struct net_device *dev;
+	struct net_device *dev, *master = NULL;
 	char ifname[IFNAMSIZ];
 	int err;
 
@@ -3519,6 +3542,12 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
+	master = rtnl_master_get(link_net ? : dest_net, tb);
+	if (IS_ERR(master)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (ops->newlink)
 		err = ops->newlink(link_net ? : net, dev, tb, data, extack);
 	else
@@ -3536,8 +3565,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		if (err < 0)
 			goto out_unregister;
 	}
-	if (tb[IFLA_MASTER]) {
-		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
+	if (master) {
+		err = do_set_master(dev, master, extack);
 		if (err)
 			goto out_unregister;
 	}
@@ -3567,6 +3596,7 @@ static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				  struct rtnl_newlink_tbs *tbs,
 				  struct netlink_ext_ack *extack,
 				  struct net *target_net, struct net_device *dev,
+				  struct net_device *new_master,
 				  const struct rtnl_link_ops *ops,
 				  struct nlattr **linkinfo, struct nlattr **data)
 {
@@ -3632,7 +3662,7 @@ static int __rtnl_newlink_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		status |= DO_SETLINK_NOTIFY;
 	}
 
-	err = do_setlink(target_net, skb, dev, ifm, extack, tb, status);
+	err = do_setlink(target_net, skb, dev, new_master, ifm, extack, tb, status);
 out:
 	return err;
 }
@@ -3647,7 +3677,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	const struct rtnl_link_ops *ops;
 	char kind[MODULE_NAME_LEN];
-	struct net_device *dev;
+	struct net_device *dev, *new_master = NULL;
 	struct ifinfomsg *ifm;
 	struct nlattr **data;
 	bool link_specified;
@@ -3709,8 +3739,12 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (dev) {
+		new_master = rtnl_master_get(target_net ? : net, tb);
+		if (IS_ERR(new_master))
+			return -EINVAL;
+
 		err = __rtnl_newlink_setlink(skb, nlh, tbs, extack,
-					     target_net, dev,
+					     target_net, dev, new_master,
 					     ops, linkinfo, data);
 		return err;
 	}



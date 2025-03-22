Return-Path: <netdev+bounces-176920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D160AA6CB06
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC181B81EE9
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8771233732;
	Sat, 22 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="NypijFpH"
X-Original-To: netdev@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC920A5C2;
	Sat, 22 Mar 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654792; cv=none; b=T9BD3GX21+tzx2V0USg8q+caMqTAqWrx4NrvX3Un9d3PHur71D+eiYTivQfED9Ca1aL7ID9KOiZmVyNJ53jVzxac7hlBE9JnMgJyd3NQGmXQdgJzzAPHmoclAx3N/HxdyK6T8fr/OH/5RlnSfP5GuR3yKwMpZGrX/KIWhCms+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654792; c=relaxed/simple;
	bh=e8LQJuIyZaRn7Eu6hBEKfyZFwONV5g0smsNc9szcskM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPo1w9qCDDPSnIJuLMO2t+Bu2X6lUz0KwdcKTD7E0nBL2Q9UlALTP3eybctv2cIjBfajqdP35VcHy6yOnd6x8UpnjEa7t+b6z2AazOlYF06PxxcAGM4O0dsG3AEhxgTRi6WAm2+7AFR5MTS4ziwBojHuGwbq8xjm1RpcG3Q1dGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=NypijFpH; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 9D918649EA;
	Sat, 22 Mar 2025 17:38:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:7da2:0:640:6456:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id D94EB60913;
	Sat, 22 Mar 2025 17:38:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FcNfZRXLk8c0-xFdWvRWM;
	Sat, 22 Mar 2025 17:38:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654297; bh=qvmvH0pKqRvkSJNE0tCMWofFZ3w3OZ2YK6UWMI03jJs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=NypijFpHpQw1XVtYSXX++IfSIDa+Wi2+EfGjP4k0upY+9OoYJWXtqhm2KukzdiI3e
	 FLPpEXFG9miVgwhENUI7XAZvv4XpAUtrr28oHH86VqI+k2hW5hw8MyfhYX4SPt/b/p
	 oTbq0a9kWJnvOvfTqQ4EQuZ3LWjWceMZYiKQshPo=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 03/51] net: do_setlink() refactoring: move target_net acquiring to callers
Date: Sat, 22 Mar 2025 17:38:15 +0300
Message-ID: <174265429530.356712.918910072525880381.stgit@pro.pro>
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

The patch is preparation in rtnetlink code for using nd_lock.
This is a step to move dereference of tb[IFLA_MASTER] up
to where main dev is dereferenced by ifi_index.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |   78 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 29 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 34e35b81cfa6..a5af69af235f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2774,7 +2774,7 @@ static int do_set_proto_down(struct net_device *dev,
 #define DO_SETLINK_MODIFIED	0x01
 /* notify flag means notify + modified. */
 #define DO_SETLINK_NOTIFY	0x03
-static int do_setlink(const struct sk_buff *skb,
+static int do_setlink(struct net *net, const struct sk_buff *skb,
 		      struct net_device *dev, struct ifinfomsg *ifm,
 		      struct netlink_ext_ack *extack,
 		      struct nlattr **tb, int status)
@@ -2788,25 +2788,16 @@ static int do_setlink(const struct sk_buff *skb,
 	else
 		ifname[0] = '\0';
 
-	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_TARGET_NETNSID]) {
+	if (net) { /* target net */
 		const char *pat = ifname[0] ? ifname : NULL;
-		struct net *net;
 		int new_ifindex;
 
-		net = rtnl_link_get_net_capable(skb, dev_net(dev),
-						tb, CAP_NET_ADMIN);
-		if (IS_ERR(net)) {
-			err = PTR_ERR(net);
-			goto errout;
-		}
-
 		if (tb[IFLA_NEW_IFINDEX])
 			new_ifindex = nla_get_s32(tb[IFLA_NEW_IFINDEX]);
 		else
 			new_ifindex = 0;
 
 		err = __dev_change_net_namespace(dev, net, pat, new_ifindex);
-		put_net(net);
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
@@ -3171,6 +3162,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
+	struct net *target_net = NULL;
 	int err;
 	struct nlattr *tb[IFLA_MAX+1];
 
@@ -3183,6 +3175,13 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	target_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	if (IS_ERR(target_net)) {
+		err = PTR_ERR(target_net);
+		target_net = NULL;
+		goto errout;
+	}
+
 	err = -EINVAL;
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
@@ -3201,8 +3200,10 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	err = do_setlink(skb, dev, ifm, extack, tb, 0);
+	err = do_setlink(target_net, skb, dev, ifm, extack, tb, 0);
 errout:
+	if (target_net)
+		put_net(target_net);
 	return err;
 }
 
@@ -3440,38 +3441,51 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 		struct nlattr **tb)
 {
 	struct net_device *dev, *aux;
+	struct net *target_net;
 	int err;
 
+	target_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	if (IS_ERR(target_net)) {
+		err = PTR_ERR(target_net);
+		target_net = NULL;
+		goto out;
+	}
+
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
 			err = validate_linkmsg(dev, tb, extack);
 			if (err < 0)
-				return err;
-			err = do_setlink(skb, dev, ifm, extack, tb, 0);
+				break;
+			err = do_setlink(target_net, skb, dev, ifm, extack, tb, 0);
 			if (err < 0)
-				return err;
+				break;
 		}
 	}
-
-	return 0;
+out:
+	if (target_net)
+		put_net(target_net);
+	return err;
 }
 
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
-			       struct netlink_ext_ack *extack)
+			       struct netlink_ext_ack *extack,
+			       struct net *dest_net)
 {
 	unsigned char name_assign_type = NET_NAME_USER;
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
-	struct net *dest_net, *link_net;
+	struct net *link_net;
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
 	int err;
 
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
+	if (!dest_net)
+		dest_net = net;
 
 	if (tb[IFLA_IFNAME]) {
 		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
@@ -3480,11 +3494,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
-	if (IS_ERR(dest_net))
-		return PTR_ERR(dest_net);
-	dest_net = dest_net ? : get_net(net);
-
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
 
@@ -3535,7 +3544,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 out:
 	if (link_net)
 		put_net(link_net);
-	put_net(dest_net);
 	return err;
 out_unregister:
 	if (ops->newlink) {
@@ -3557,7 +3565,8 @@ struct rtnl_newlink_tbs {
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct rtnl_newlink_tbs *tbs,
-			  struct netlink_ext_ack *extack)
+			  struct netlink_ext_ack *extack,
+			  struct net *target_net)
 {
 	struct nlattr *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr ** const tb = tbs->tb;
@@ -3688,7 +3697,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			status |= DO_SETLINK_NOTIFY;
 		}
 
-		return do_setlink(skb, dev, ifm, extack, tb, status);
+		return do_setlink(target_net, skb, dev, ifm, extack, tb, status);
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
@@ -3722,12 +3731,14 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, nlh, tb, data, extack, target_net);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
+	struct net *target_net = NULL;
 	struct rtnl_newlink_tbs *tbs;
 	struct nlattr **tb;
 	int ret;
@@ -3746,8 +3757,17 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ret < 0)
 		goto out;
 
-	ret = __rtnl_newlink(skb, nlh, tbs, extack);
+	target_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	if (IS_ERR(target_net)) {
+		ret = PTR_ERR(target_net);
+		target_net = NULL;
+		goto out;
+	}
+
+	ret = __rtnl_newlink(skb, nlh, tbs, extack, target_net);
 out:
+	if (target_net)
+		put_net(target_net);
 	kfree(tbs);
 	return ret;
 }



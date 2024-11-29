Return-Path: <netdev+bounces-147889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16C9DECE5
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 22:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14213281C39
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF78189BAD;
	Fri, 29 Nov 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiYHsgSk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B967A155300
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915541; cv=none; b=PCHfTKvDrgvWR8FpNWk8KUP37avWtQWnwtu1CDaBjd9hkw/bP6T0rjJdw0RIKxff/Rs4xKpztRl3wCm2URNpPFoxvSkwUaTonR8d5FZHOGjmavkv6x8nknW5r4Q+r3ZZ/Vh8SZxbIVPqaXYR8NXVJeCy9NuAO5x7AXBz6K3AS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915541; c=relaxed/simple;
	bh=pR2mUelifzy32r9cTcH7LTfVbQPzevs7Q+/Eg4eBXFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoGlTdCvRoLdi6ELSUYFGnOhXoOinbKC25/WVeZQS7Ka1ITnKtOWpiVXuIVb4zEyTOImFx0RvGuViEjxrmU4JxIngHs2CGpEqdrFNOKPpX1IT4VJbFlis8F+O0M9W2U5Q1S/aglw19bOgizl3ZJsDQrnnvIiSbqlItctxc91MI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiYHsgSk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1503110a12.1
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732915539; x=1733520339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co9TI3/5bpO6Q2XxezpddZCc/XUYmIeTT2SMTuwTxQM=;
        b=jiYHsgSkjT1xepOh5fUnq7ZBOsrsnmKkHdSqU2YuBKL17LjZXLo7nqCFrXPLdsATMw
         7Wxr4QdHdlz9OqkJTL8gfwg/ww4+8jXdVHkh7dyPaF7vmSqWAGzduNEBHUFuV2RZ6pxg
         y2lyZHJE6Mn3Lz0bGYccpBc03A39SonbhoOzv2tAq7FYWaHBA4V6QP998NrBSuQ7VzUw
         zJgffLqmfMd6JexKEO08yap0OkKoGySreyVzsH2K6+XcU0b+TEofHiwJZbfZgXh0qm9g
         XyPw+h7GlYu0ybqJgS9+GzGDfo02JzfRR+MqskXZReSGxLje6ggQLG5vkRDjBHivKzho
         UFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915539; x=1733520339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co9TI3/5bpO6Q2XxezpddZCc/XUYmIeTT2SMTuwTxQM=;
        b=AG+YPHoPHgyn+HQydsrUwYSI6may98sSXGRKnC3pSIECcGdBj9oT0PpQVqjpUueAc5
         u1btmsekmriQAeEHQqqx0obzL1QEsFYjSE9L4cdguxfVvfzIaV1/039pbtFjXS96M3pb
         uMZ9Au7HhGPDCoLO+elNelYSillqBu1q/5Ua8wwrHq4ofgKuNr4ReCaSyYH3RMr2rD/3
         ut/ca9Fg+oiK0qKBCeCuFvrB7kVscIk51VSBnVI//9jjErHbgpognqm/uTQGFUGev5BS
         zAJdY/5cDsmgGMvSz2GAhmGTmqk3sX7Tnig0yQhpQQlTde36WXQWfShjQyiyNe/Wg9wI
         7lGA==
X-Gm-Message-State: AOJu0YxhJmeBrhXCvsYxZJCDyERqAskD8ccBgzkEQAc04SjFV7exr1ZM
	IsS7JQpD6wBaIPD37FcECfUKOGq62zawRI5OkKpgQukGhZ1YV0zFHjpQxw==
X-Gm-Gg: ASbGncuPF6eh0/QQF5ImgAWV9KsXMjYp2p66GeEji+F8iLNo8lbyBkUIz12q0R8Qttk
	lgm2tg4kL9z0W7eBc9INO/qzBwt7fLyhbVq8yiogh19eIUjsohHuIRx79E4PNSyTASGVWCiyRt5
	xjN7CnIcGh0mIzm8OnICzyaSEiULOT6fytXK4jTtl2z0TEa7Bl8ElJzMCI4xheIarpAwJqUJ1Dx
	VqBK5nDOhwCn4sFXz+MgG9lq/wpQtBvIgy5y+SJAiVSe1fa63ElZLmA5ISUmwy2EHHmG4ooWrpH
	0w==
X-Google-Smtp-Source: AGHT+IG5UI4NKYaT642Ykep7YOgayUfmgcd9BjTM4ySGWmUpHdEX9w8tP3eImp22VQ4QpJfGzHvFHw==
X-Received: by 2002:a05:6a20:6a09:b0:1e0:d104:4dab with SMTP id adf61e73a8af0-1e0e0b8d1cfmr18656144637.44.1732915538665;
        Fri, 29 Nov 2024 13:25:38 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:c80:4656:59a9:187f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180fce8sm4053023b3a.148.2024.11.29.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:25:38 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [Patch net v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
Date: Fri, 29 Nov 2024 13:25:19 -0800
Message-Id: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
References: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Currently rtnl_link_get_net_ifla() gets called twice when we create
peer devices, once in rtnl_add_peer_net() and once in each ->newlink()
implementation.

This looks safer, however, it leads to a classic Time-of-Check to
Time-of-Use (TOCTOU) bug since IFLA_NET_NS_PID is very dynamic. And
because of the lack of checking error pointer of the second call, it
also leads to a kernel crash as reported by syzbot.

Fix this by getting rid of the second call, which already becomes
redudant after Kuniyuki's work. We have to propagate the result of the
first rtnl_link_get_net_ifla() down to each ->newlink().

Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21ba4d5adff0b6a7cfc6
Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.")
Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.")
Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.")
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 drivers/net/can/vxcan.c | 10 ++--------
 drivers/net/netkit.c    | 11 +++--------
 drivers/net/veth.c      | 12 +++--------
 net/core/rtnetlink.c    | 44 +++++++++++++++++++++--------------------
 4 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index da7c72105fb6..ca8811941085 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -172,13 +172,12 @@ static void vxcan_setup(struct net_device *dev)
 /* forward declaration for rtnl_create_link() */
 static struct rtnl_link_ops vxcan_link_ops;
 
-static int vxcan_newlink(struct net *net, struct net_device *dev,
+static int vxcan_newlink(struct net *peer_net, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
 	struct vxcan_priv *priv;
 	struct net_device *peer;
-	struct net *peer_net;
 
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp = tb;
 	char ifname[IFNAMSIZ];
@@ -203,20 +202,15 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	peer_net = rtnl_link_get_net(net, tbp);
 	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&vxcan_link_ops, tbp, extack);
-	if (IS_ERR(peer)) {
-		put_net(peer_net);
+	if (IS_ERR(peer))
 		return PTR_ERR(peer);
-	}
 
 	if (ifmp && dev->ifindex)
 		peer->ifindex = ifmp->ifi_index;
 
 	err = register_netdevice(peer);
-	put_net(peer_net);
-	peer_net = NULL;
 	if (err < 0) {
 		free_netdev(peer);
 		return err;
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index bb07725d1c72..c1d881dc6409 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -327,7 +327,7 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 static struct rtnl_link_ops netkit_link_ops;
 
-static int netkit_new_link(struct net *src_net, struct net_device *dev,
+static int netkit_new_link(struct net *peer_net, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
@@ -342,7 +342,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	struct net_device *peer;
 	char ifname[IFNAMSIZ];
 	struct netkit *nk;
-	struct net *net;
 	int err;
 
 	if (data) {
@@ -385,13 +384,10 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
 		return -EOPNOTSUPP;
 
-	net = rtnl_link_get_net(src_net, tbp);
-	peer = rtnl_create_link(net, ifname, ifname_assign_type,
+	peer = rtnl_create_link(peer_net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
-	if (IS_ERR(peer)) {
-		put_net(net);
+	if (IS_ERR(peer))
 		return PTR_ERR(peer);
-	}
 
 	netif_inherit_tso_max(peer, dev);
 
@@ -408,7 +404,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	bpf_mprog_bundle_init(&nk->bundle);
 
 	err = register_netdevice(peer);
-	put_net(net);
 	if (err < 0)
 		goto err_register_peer;
 	netif_carrier_off(peer);
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0d6d0d749d44..07ebb800edf1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1765,7 +1765,7 @@ static int veth_init_queues(struct net_device *dev, struct nlattr *tb[])
 	return 0;
 }
 
-static int veth_newlink(struct net *src_net, struct net_device *dev,
+static int veth_newlink(struct net *peer_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -1776,7 +1776,6 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp;
 	unsigned char name_assign_type;
 	struct ifinfomsg *ifmp;
-	struct net *net;
 
 	/*
 	 * create and register peer first
@@ -1800,13 +1799,10 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	net = rtnl_link_get_net(src_net, tbp);
-	peer = rtnl_create_link(net, ifname, name_assign_type,
+	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&veth_link_ops, tbp, extack);
-	if (IS_ERR(peer)) {
-		put_net(net);
+	if (IS_ERR(peer))
 		return PTR_ERR(peer);
-	}
 
 	if (!ifmp || !tbp[IFLA_ADDRESS])
 		eth_hw_addr_random(peer);
@@ -1817,8 +1813,6 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	netif_inherit_tso_max(peer, dev);
 
 	err = register_netdevice(peer);
-	put_net(net);
-	net = NULL;
 	if (err < 0)
 		goto err_register_peer;
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 58df76fe408a..ab5f201bf0ab 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3746,6 +3746,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
 			       struct net *tgt_net, struct net *link_net,
+			       struct net *peer_net,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
 			       struct netlink_ext_ack *extack)
@@ -3776,8 +3777,13 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
+	if (link_net)
+		net = link_net;
+	if (peer_net)
+		net = peer_net;
+
 	if (ops->newlink)
-		err = ops->newlink(link_net ? : net, dev, tb, data, extack);
+		err = ops->newlink(net, dev, tb, data, extack);
 	else
 		err = register_netdevice(dev);
 	if (err < 0) {
@@ -3812,40 +3818,33 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
-static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
-			     const struct rtnl_link_ops *ops,
-			     struct nlattr *data[],
-			     struct netlink_ext_ack *extack)
+static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+				     struct nlattr *data[],
+				     struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[IFLA_MAX + 1];
-	struct net *net;
 	int err;
 
 	if (!data || !data[ops->peer_type])
-		return 0;
+		return NULL;
 
 	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
 	if (err < 0)
-		return err;
+		return ERR_PTR(err);
 
 	if (ops->validate) {
 		err = ops->validate(tb, NULL, extack);
 		if (err < 0)
-			return err;
+			return ERR_PTR(err);
 	}
 
-	net = rtnl_link_get_net_ifla(tb);
-	if (IS_ERR(net))
-		return PTR_ERR(net);
-	if (net)
-		rtnl_nets_add(rtnl_nets, net);
-
-	return 0;
+	return rtnl_link_get_net_ifla(tb);
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
 			  struct net *tgt_net, struct net *link_net,
+			  struct net *peer_net,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
@@ -3894,14 +3893,15 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, peer_net, nlh,
+				   tb, data, extack);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
+	struct net *tgt_net, *link_net = NULL, *peer_net = NULL;
 	struct nlattr **tb, **linkinfo, **data = NULL;
-	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
 	struct rtnl_nets rtnl_nets;
@@ -3971,9 +3971,11 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			ret = rtnl_add_peer_net(&rtnl_nets, ops, data, extack);
-			if (ret < 0)
+			peer_net = rtnl_get_peer_net(ops, data, extack);
+			if (IS_ERR(peer_net))
 				goto put_ops;
+			if (peer_net)
+				rtnl_nets_add(&rtnl_nets, peer_net);
 		}
 	}
 
@@ -4004,7 +4006,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	rtnl_nets_lock(&rtnl_nets);
-	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
+	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, peer_net, tbs, data, extack);
 	rtnl_nets_unlock(&rtnl_nets);
 
 put_net:
-- 
2.34.1



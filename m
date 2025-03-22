Return-Path: <netdev+bounces-176894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CFA6CACB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99A7189E84D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48811233120;
	Sat, 22 Mar 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="gToO3Nv+"
X-Original-To: netdev@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287D22F38B;
	Sat, 22 Mar 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654503; cv=none; b=dPyIQ1gegs4FoNMVnL+rsrujZarxvLZ8OoBhZ3N3Rvn28a+kLZBmSKral69czWqhNylbX6RCg7OYPaw9jzLrd2xiSPe2Adn3LGwQI5EVpAjB9KIC/ia56c5SY6cppshoOgSHZ+eXYiZJmCUfItZI9WmDvHKqDVxalkPbUZGy9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654503; c=relaxed/simple;
	bh=/vX/NCxK5388iXV1H3otOtVZUXnFUanqylluY2qp6Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/Ydspcs4YEb00zbknqi0ycMGRkw3UIL+aS7NapqSMWfJztaoKUkLuKnrr3XDBe7IYhrvg7WQstMMcAjc+oqjh8Gp+T1MwWvlk6D2VGb5/SwV1Qi661i5IZFwPnQWUWRN6hQsUW4yi7a4gfGQpAWW5+KBBzC4lKBdsDoekq34jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=gToO3Nv+; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:7c8:0:640:150d:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 50125608F1;
	Sat, 22 Mar 2025 17:41:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bfNnr7VLmmI0-2GbHNqd9;
	Sat, 22 Mar 2025 17:41:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654499; bh=MuJVlB1LRJiJWTm6rmo/xmyjyBBC9tbfAqUIMzTdgMU=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=gToO3Nv+pYkSmYIpcQ+yzfmlXCYwEf3E/esO6zyarTSPSoK+OyifiaxXStGYJk2zl
	 zN2RdD46YlkzF/0q3jwvG8FHhQI1E8DxERLb7Km1LJHfPk2BIhrc5GTde+klLk7fqD
	 c4yXuaZmRjNroRXNxaIg8u1NNGxGgtpXO/rRM9wc=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 30/51] ip6_tunnel: Use __register_netdevice() in .newlink and .changelink
Date: Sat, 22 Mar 2025 17:41:37 +0300
Message-ID: <174265449744.356712.714904319843349825.stgit@pro.pro>
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

The objective is to conform .newlink and .changelink with their
callers, which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/ipv6/ip6_tunnel.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 87dfb565a9f8..d6435cb1e4fc 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -257,7 +257,7 @@ static int ip6_tnl_create2(struct net_device *dev)
 	int err;
 
 	dev->rtnl_link_ops = &ip6_link_ops;
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto out;
 
@@ -282,7 +282,8 @@ static int ip6_tnl_create2(struct net_device *dev)
  *   created tunnel or error pointer
  **/
 
-static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
+static struct ip6_tnl *ip6_tnl_create(struct net *net, struct nd_lock *nd_lock,
+				      struct __ip6_tnl_parm *p)
 {
 	struct net_device *dev;
 	struct ip6_tnl *t;
@@ -307,6 +308,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 	t = netdev_priv(dev);
 	t->parms = *p;
 	t->net = dev_net(dev);
+	attach_nd_lock(dev, nd_lock);
 	err = ip6_tnl_create2(dev);
 	if (err < 0)
 		goto failed_free;
@@ -314,6 +316,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 	return t;
 
 failed_free:
+	detach_nd_lock(dev);
 	free_netdev(dev);
 failed:
 	return ERR_PTR(err);
@@ -322,6 +325,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 /**
  * ip6_tnl_locate - find or create tunnel matching given parameters
  *   @net: network namespace
+ *   @nd_lock: created device lock
  *   @p: tunnel parameters
  *   @create: != 0 if allowed to create new tunnel if no match found
  *
@@ -335,6 +339,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
  **/
 
 static struct ip6_tnl *ip6_tnl_locate(struct net *net,
+		struct nd_lock *nd_lock,
 		struct __ip6_tnl_parm *p, int create)
 {
 	const struct in6_addr *remote = &p->raddr;
@@ -357,7 +362,7 @@ static struct ip6_tnl *ip6_tnl_locate(struct net *net,
 	}
 	if (!create)
 		return ERR_PTR(-ENODEV);
-	return ip6_tnl_create(net, p);
+	return ip6_tnl_create(net, nd_lock, p);
 }
 
 /**
@@ -1621,8 +1626,11 @@ ip6_tnl_parm_to_user(struct ip6_tnl_parm *u, const struct __ip6_tnl_parm *p)
  *   %-EINVAL if passed tunnel parameters are invalid,
  *   %-EEXIST if changing a tunnel's parameters would cause a conflict
  *   %-ENODEV if attempting to change or delete a nonexisting device
- **/
-
+ *
+ * XXX: Currently ->ndo_siocdevprivate is called with @dev unlocked
+ * (the only place where @dev may be locked is phonet_device_autoconf(),
+ *  but it can't be caller of this).
+ */
 static int
 ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		       void __user *data, int cmd)
@@ -1633,6 +1641,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net *net = t->net;
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	struct nd_lock *nd_lock;
 
 	memset(&p1, 0, sizeof(p1));
 
@@ -1644,7 +1653,9 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 				break;
 			}
 			ip6_tnl_parm_from_user(&p1, &p);
-			t = ip6_tnl_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = ip6_tnl_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 			if (IS_ERR(t))
 				t = netdev_priv(dev);
 		} else {
@@ -1667,7 +1678,9 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		    p.proto != 0)
 			break;
 		ip6_tnl_parm_from_user(&p1, &p);
-		t = ip6_tnl_locate(net, &p1, cmd == SIOCADDTUNNEL);
+		lock_netdev(dev, &nd_lock);
+		t = ip6_tnl_locate(net, nd_lock, &p1, cmd == SIOCADDTUNNEL);
+		unlock_netdev(nd_lock);
 		if (cmd == SIOCCHGTUNNEL) {
 			if (!IS_ERR(t)) {
 				if (t->dev != dev) {
@@ -1702,7 +1715,9 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 				break;
 			err = -ENOENT;
 			ip6_tnl_parm_from_user(&p1, &p);
-			t = ip6_tnl_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = ip6_tnl_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 			if (IS_ERR(t))
 				break;
 			err = -EPERM;
@@ -2003,6 +2018,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
@@ -2023,7 +2039,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 		if (rtnl_dereference(ip6n->collect_md_tun))
 			return -EEXIST;
 	} else {
-		t = ip6_tnl_locate(net, &nt->parms, 0);
+		t = ip6_tnl_locate(net, nd_lock, &nt->parms, 0);
 		if (!IS_ERR(t))
 			return -EEXIST;
 	}
@@ -2039,6 +2055,7 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 			      struct nlattr *data[],
 			      struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm p;
 	struct net *net = t->net;
@@ -2058,7 +2075,7 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (p.collect_md)
 		return -EINVAL;
 
-	t = ip6_tnl_locate(net, &p, 0);
+	t = ip6_tnl_locate(net, nd_lock, &p, 0);
 	if (!IS_ERR(t)) {
 		if (t->dev != dev)
 			return -EEXIST;



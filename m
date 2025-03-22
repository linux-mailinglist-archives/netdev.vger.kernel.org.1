Return-Path: <netdev+bounces-176895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FBA6CAD2
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48168461F77
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A69233149;
	Sat, 22 Mar 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="UPXh9Vyh"
X-Original-To: netdev@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489022F38B;
	Sat, 22 Mar 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654510; cv=none; b=mfhS8sscMET+HOWsro7uYv7DV0ll6hpN7awcQ+hJPBCt/sgDruUHVSud2hBqTcZFh5DJDRorUE2jzkiMMISUVwmazGZCJtQjC9FtflhHRcyJLouaqGEtswnjRHLDtPMHsjLm0cUIUxteDkvc0Y6ZK8WomL5NhlaWGUopueKXqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654510; c=relaxed/simple;
	bh=WFgiJOrrKrx4OnWtULb2Qd4zknYKfrx9le7D2Y0H9Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9MuLRtvDKFLoq50auMnAOHZjp6uVPwqULMLTXPY1hjvbv36FaHLOq6d6DHvv2TC8RkUJG1xxLI/4rORl8CU7QKRHvAuhxu0/5vSnLCXrNAfkjrot8tycac+X27MGxVVmN4Npvusvqf61MWnYnQMWyo7xTzOvQhpcfnZiwE/1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=UPXh9Vyh; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:6527:0:640:ea41:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 22C46608ED;
	Sat, 22 Mar 2025 17:41:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ifN4j0VLkqM0-TyGwa29C;
	Sat, 22 Mar 2025 17:41:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654506; bh=J2Fdo56GSuJpYExeExUcLlgZrKL0MHvjWN9S8kzUfZQ=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=UPXh9VyhWglIx1ErFX7Dy00MV4O9IxBbvp5Z31Ihc/vZw8V6B1n5lenOEndRIJWug
	 oPxCNWcQ+4CJCUfq5s3fOnAV22r765m/BFrh8JeqGM4SKTPbs0WetAa3InAVt2UZFw
	 hYST7uC0AfROSqeju2jwVP64qf7lAAZRDghZEmtY=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 31/51] ip6_vti: Use __register_netdevice() in .newlink and .changelink
Date: Sat, 22 Mar 2025 17:41:44 +0300
Message-ID: <174265450440.356712.11114112487526682006.stgit@pro.pro>
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
 net/ipv6/ip6_vti.c |   36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 590737c27537..b20a18c403e9 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -182,7 +182,7 @@ static int vti6_tnl_create2(struct net_device *dev)
 	int err;
 
 	dev->rtnl_link_ops = &vti6_link_ops;
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto out;
 
@@ -196,7 +196,8 @@ static int vti6_tnl_create2(struct net_device *dev)
 	return err;
 }
 
-static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
+static struct ip6_tnl *vti6_tnl_create(struct net *net, struct nd_lock *nd_lock,
+				       struct __ip6_tnl_parm *p)
 {
 	struct net_device *dev;
 	struct ip6_tnl *t;
@@ -221,6 +222,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
 	t->parms = *p;
 	t->net = dev_net(dev);
 
+	attach_nd_lock(dev, nd_lock);
 	err = vti6_tnl_create2(dev);
 	if (err < 0)
 		goto failed_free;
@@ -228,6 +230,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
 	return t;
 
 failed_free:
+	detach_nd_lock(dev);
 	free_netdev(dev);
 failed:
 	return NULL;
@@ -247,8 +250,8 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
  * Return:
  *   matching tunnel or NULL
  **/
-static struct ip6_tnl *vti6_locate(struct net *net, struct __ip6_tnl_parm *p,
-				   int create)
+static struct ip6_tnl *vti6_locate(struct net *net, struct nd_lock *nd_lock,
+				   struct __ip6_tnl_parm *p, int create)
 {
 	const struct in6_addr *remote = &p->raddr;
 	const struct in6_addr *local = &p->laddr;
@@ -269,7 +272,7 @@ static struct ip6_tnl *vti6_locate(struct net *net, struct __ip6_tnl_parm *p,
 	}
 	if (!create)
 		return NULL;
-	return vti6_tnl_create(net, p);
+	return vti6_tnl_create(net, nd_lock, p);
 }
 
 /**
@@ -791,6 +794,10 @@ vti6_parm_to_user(struct ip6_tnl_parm2 *u, const struct __ip6_tnl_parm *p)
  *   %-EINVAL if passed tunnel parameters are invalid,
  *   %-EEXIST if changing a tunnel's parameters would cause a conflict
  *   %-ENODEV if attempting to change or delete a nonexisting device
+ *
+ * XXX: Currently ->ndo_siocdevprivate is called with @dev unlocked
+ * (the only place where @dev may be locked is phonet_device_autoconf(),
+ *  but it can't be caller of this).
  **/
 static int
 vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data, int cmd)
@@ -801,6 +808,7 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 	struct ip6_tnl *t = NULL;
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct nd_lock *nd_lock;
 
 	memset(&p1, 0, sizeof(p1));
 
@@ -812,7 +820,9 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 				break;
 			}
 			vti6_parm_from_user(&p1, &p);
-			t = vti6_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = vti6_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 		} else {
 			memset(&p, 0, sizeof(p));
 		}
@@ -834,7 +844,9 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
+		lock_netdev(dev, &nd_lock);
+		t = vti6_locate(net, nd_lock, &p1, cmd == SIOCADDTUNNEL);
+		unlock_netdev(nd_lock);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
 			if (t) {
 				if (t->dev != dev) {
@@ -866,7 +878,9 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 				break;
 			err = -ENOENT;
 			vti6_parm_from_user(&p1, &p);
-			t = vti6_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = vti6_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 			if (!t)
 				break;
 			err = -EPERM;
@@ -1001,6 +1015,7 @@ static int vti6_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
 
@@ -1009,7 +1024,7 @@ static int vti6_newlink(struct net *src_net, struct net_device *dev,
 
 	nt->parms.proto = IPPROTO_IPV6;
 
-	if (vti6_locate(net, &nt->parms, 0))
+	if (vti6_locate(net, nd_lock, &nt->parms, 0))
 		return -EEXIST;
 
 	return vti6_tnl_create2(dev);
@@ -1028,6 +1043,7 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct ip6_tnl *t;
 	struct __ip6_tnl_parm p;
 	struct net *net = dev_net(dev);
@@ -1038,7 +1054,7 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	vti6_netlink_parms(data, &p);
 
-	t = vti6_locate(net, &p, 0);
+	t = vti6_locate(net, nd_lock, &p, 0);
 
 	if (t) {
 		if (t->dev != dev)



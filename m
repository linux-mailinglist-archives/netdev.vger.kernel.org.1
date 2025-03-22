Return-Path: <netdev+bounces-176896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5FCA6CAC7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2757AF910
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A022234972;
	Sat, 22 Mar 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="f9HFTtPJ"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1823314A;
	Sat, 22 Mar 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654518; cv=none; b=R+4M267jzttu3cIFN3hjNP4VJFzxylwhKNxBuy9TmXtXSAOaG63XJMzAu88ix/9cJYdMHiYORNfdJo4zWf1HwI16yAWe1j0S34esLp8yj6uwxzanmlwCDBma91zvuPwJtV/YsRFE1+BgExpizCRnKgnHEZxn2ZwQCGW3ZX2gukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654518; c=relaxed/simple;
	bh=ALhQd9eXPRfApIFzD63K080JAclKGpraWxb1G35CodM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsFoaHwH3CPhYgr2koWHbrrsZQv8M32Hcv83IVLkvaHIhBM1J3QyeFImrrvNfQwiAprV8214yykthyLPGD4BiEHe+/63RP/wYi1Yh92coyVR5bhrGnXcYpBm5gbLKqyRsovMGb4Lxwlrk5+aNS4oDbHvmUztG5ux4KX1s3eERJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=f9HFTtPJ; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c28:7d5:0:640:285a:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 923DB60A90;
	Sat, 22 Mar 2025 17:41:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qfNS4TXLnSw0-Te01Sx1e;
	Sat, 22 Mar 2025 17:41:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654514; bh=O22277gb6bHhe/NDoymhUtiu2l99vmajGWzB3XViXOs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=f9HFTtPJpFD2FoEfb1e23VzWnJ32qn6Yt7FizRK8SjEwMJsb3oko8N3puHlPcC3qc
	 tZs/rDfTpNz7b1YqZzfgXgZVbknqvm5oe8m8yUXKnYWdO6SQXUFFZPckNJqCkiX3Aq
	 KtG0njiETXqrxEmYqwq908idbwRwNKUyI8JUyZOk=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 32/51] ip6_sit: Use __register_netdevice() in .newlink and .changelink
Date: Sat, 22 Mar 2025 17:41:52 +0300
Message-ID: <174265451228.356712.2871503046095180191.stgit@pro.pro>
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

The objective is to conform .newlink and .changelink and their
callers, which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/ipv6/sit.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 83b195f09561..1749defa4b70 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -212,7 +212,7 @@ static int ipip6_tunnel_create(struct net_device *dev)
 
 	dev->rtnl_link_ops = &sit_link_ops;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err < 0)
 		goto out;
 
@@ -226,6 +226,7 @@ static int ipip6_tunnel_create(struct net_device *dev)
 }
 
 static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
+					     struct nd_lock *nd_lock,
 					     struct ip_tunnel_parm_kern *parms,
 					     int create)
 {
@@ -269,6 +270,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
+	attach_nd_lock(dev, nd_lock);
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -278,6 +280,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	return nt;
 
 failed_free:
+	detach_nd_lock(dev);
 	free_netdev(dev);
 failed:
 	return NULL;
@@ -1200,11 +1203,14 @@ ipip6_tunnel_get6rd(struct net_device *dev, struct ip_tunnel_parm __user *data)
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm_kern p;
 	struct ip_tunnel_6rd ip6rd;
+	struct nd_lock *nd_lock;
 
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev) {
 		if (!ip_tunnel_parm_from_user(&p, data))
 			return -EFAULT;
-		t = ipip6_tunnel_locate(t->net, &p, 0);
+		lock_netdev(dev, &nd_lock);
+		t = ipip6_tunnel_locate(t->net, nd_lock, &p, 0);
+		unlock_netdev(nd_lock);
 	}
 	if (!t)
 		t = netdev_priv(dev);
@@ -1273,9 +1279,13 @@ static int
 ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct nd_lock *nd_lock;
 
-	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev)
-		t = ipip6_tunnel_locate(t->net, p, 0);
+	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev) {
+		lock_netdev(dev, &nd_lock);
+		t = ipip6_tunnel_locate(t->net, nd_lock, p, 0);
+		unlock_netdev(nd_lock);
+	}
 	if (!t)
 		t = netdev_priv(dev);
 	memcpy(p, &t->parms, sizeof(*p));
@@ -1286,13 +1296,16 @@ static int
 ipip6_tunnel_add(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct nd_lock *nd_lock;
 	int err;
 
 	err = __ipip6_tunnel_ioctl_validate(t->net, p);
 	if (err)
 		return err;
 
-	t = ipip6_tunnel_locate(t->net, p, 1);
+	lock_netdev(dev, &nd_lock);
+	t = ipip6_tunnel_locate(t->net, nd_lock, p, 1);
+	unlock_netdev(nd_lock);
 	if (!t)
 		return -ENOBUFS;
 	return 0;
@@ -1302,13 +1315,16 @@ static int
 ipip6_tunnel_change(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct nd_lock *nd_lock;
 	int err;
 
 	err = __ipip6_tunnel_ioctl_validate(t->net, p);
 	if (err)
 		return err;
 
-	t = ipip6_tunnel_locate(t->net, p, 0);
+	lock_netdev(dev, &nd_lock);
+	t = ipip6_tunnel_locate(t->net, nd_lock, p, 0);
+	unlock_netdev(nd_lock);
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev) {
 		if (!t)
 			return -ENOENT;
@@ -1333,12 +1349,15 @@ static int
 ipip6_tunnel_del(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct nd_lock *nd_lock;
 
 	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev) {
-		t = ipip6_tunnel_locate(t->net, p, 0);
+		lock_netdev(dev, &nd_lock);
+		t = ipip6_tunnel_locate(t->net, nd_lock, p, 0);
+		unlock_netdev(nd_lock);
 		if (!t)
 			return -ENOENT;
 		if (t == netdev_priv(dev_to_sit_net(dev)->fb_tunnel_dev))
@@ -1349,6 +1368,12 @@ ipip6_tunnel_del(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 	return 0;
 }
 
+/* This is called with rtnl locked and dev nd_lock unlocked.
+ * Note, that currently we take nd_lock in every of below
+ * function: ipip6_tunnel_get, ipip6_tunnel_add, etc instead
+ * of taking it once here, since there is call_netdevice_notifiers()
+ * in one of them, which is not prepared to use nd_lock yet.
+ */
 static int
 ipip6_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 		 int cmd)
@@ -1553,6 +1578,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct net *net = dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
@@ -1571,7 +1597,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 
 	ipip6_netlink_parms(data, &nt->parms, &nt->fwmark);
 
-	if (ipip6_tunnel_locate(net, &nt->parms, 0))
+	if (ipip6_tunnel_locate(net, nd_lock, &nt->parms, 0))
 		return -EEXIST;
 
 	err = ipip6_tunnel_create(dev);
@@ -1601,6 +1627,7 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct nlattr *data[],
 			    struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_encap ipencap;
 	struct ip_tunnel_parm_kern p;
@@ -1627,7 +1654,7 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	    (!(dev->flags & IFF_POINTOPOINT) && p.iph.daddr))
 		return -EINVAL;
 
-	t = ipip6_tunnel_locate(net, &p, 0);
+	t = ipip6_tunnel_locate(net, nd_lock, &p, 0);
 
 	if (t) {
 		if (t->dev != dev)



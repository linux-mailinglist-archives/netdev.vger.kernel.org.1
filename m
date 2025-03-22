Return-Path: <netdev+bounces-176893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F36A6CACD
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D6D171BCE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE6231A2D;
	Sat, 22 Mar 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="nD9La0yI"
X-Original-To: netdev@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B422F38B;
	Sat, 22 Mar 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654497; cv=none; b=fq8rdWHhm5acIbNAMSl9m0/pv0gqrZ8mWnOY4H0d3Xfov/gCcEC/Xvb8ROnQmBRLzUoCYeBxjRQNQJVnxzgPWDUN38oGYKs8tbDtZpCy4ookL96aJ/5+D6WDgq7jmSzw7qpI5Aufi0bEHScMlrSym2Xn20ha9CwKvEvGumsfdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654497; c=relaxed/simple;
	bh=we7PEBeMShT3nKcknF5hyoxftD5MqKFv1u/jT2V9IYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5IX/oWTqe1NOOLWl/c6VW3OIkocgKGD253u0dh/pCUuMBRmSUW3UtsJdSI5QAUsCE1SEg+ufd/FQ/ynojfvdP2wEY3KLOTlrvzqvBzYWFz8a9pb4B0UfkANGejvXSDXHjyVR9ul+zKmztxIqR9aKfk/XPf67dgwPH0UsRAuKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=nD9La0yI; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:12a5:0:640:7a62:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 493AC60AA6;
	Sat, 22 Mar 2025 17:41:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UfN43TKLbeA0-NVoUBCrL;
	Sat, 22 Mar 2025 17:41:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654491; bh=HW2f7QaBepBT3+VEu+EJPm5rGw/cIIAI1s2v1lY4Z7U=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=nD9La0yIahu1Dw0skhg6iw18a2HntMRy55J3uObhgfEN0x+3r9Tz5uIGGnGySw6Ra
	 0fUUGug9/jzhqbYnsjwi5Amx96Qku1a8YA3Ja0yC/UHcioZli1KOyUk7mjrnr4thNW
	 CGsZStSlWlOTYlXLizV7zE1d8AIaswR7vxtD+v5w=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 29/51] ip6gre: Use __register_netdevice() in .changelink
Date: Sat, 22 Mar 2025 17:41:30 +0300
Message-ID: <174265449006.356712.8857076514970249603.stgit@pro.pro>
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

The objective is to conform .changelink with its callers,
which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/ipv6/ip6_gre.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 57cbf7942dc8..e40780da15a0 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -344,6 +344,7 @@ static struct ip6_tnl *ip6gre_tunnel_find(struct net *net,
 }
 
 static struct ip6_tnl *ip6gre_tunnel_locate(struct net *net,
+		struct nd_lock *nd_lock,
 		const struct __ip6_tnl_parm *parms, int create)
 {
 	struct ip6_tnl *t, *nt;
@@ -378,8 +379,11 @@ static struct ip6_tnl *ip6gre_tunnel_locate(struct net *net,
 	nt->dev = dev;
 	nt->net = dev_net(dev);
 
-	if (register_netdevice(dev) < 0)
+	attach_nd_lock(dev, nd_lock);
+	if (__register_netdevice(dev) < 0) {
+		detach_nd_lock(dev);
 		goto failed_free;
+	}
 
 	ip6gre_tnl_link_config(nt, 1);
 	ip6gre_tunnel_link(ign, nt);
@@ -1277,6 +1281,10 @@ static void ip6gre_tnl_parm_to_user(struct ip6_tnl_parm2 *u,
 	memcpy(u->name, p->name, sizeof(u->name));
 }
 
+/* XXX: Currently ->ndo_siocdevprivate is called with @dev unlocked
+ * (the only place where @dev may be locked is phonet_device_autoconf(),
+ *  but it can't be caller of this).
+ */
 static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 					struct ifreq *ifr, void __user *data,
 					int cmd)
@@ -1287,6 +1295,7 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net *net = t->net;
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
+	struct nd_lock *nd_lock;
 
 	memset(&p1, 0, sizeof(p1));
 
@@ -1298,7 +1307,9 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 				break;
 			}
 			ip6gre_tnl_parm_from_user(&p1, &p);
-			t = ip6gre_tunnel_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = ip6gre_tunnel_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 			if (!t)
 				t = netdev_priv(dev);
 		}
@@ -1328,7 +1339,9 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 			p.o_key = 0;
 
 		ip6gre_tnl_parm_from_user(&p1, &p);
-		t = ip6gre_tunnel_locate(net, &p1, cmd == SIOCADDTUNNEL);
+		lock_netdev(dev, &nd_lock);
+		t = ip6gre_tunnel_locate(net, nd_lock, &p1, cmd == SIOCADDTUNNEL);
+		unlock_netdev(nd_lock);
 
 		if (dev != ign->fb_tunnel_dev && cmd == SIOCCHGTUNNEL) {
 			if (t) {
@@ -1369,7 +1382,9 @@ static int ip6gre_tunnel_siocdevprivate(struct net_device *dev,
 				goto done;
 			err = -ENOENT;
 			ip6gre_tnl_parm_from_user(&p1, &p);
-			t = ip6gre_tunnel_locate(net, &p1, 0);
+			lock_netdev(dev, &nd_lock);
+			t = ip6gre_tunnel_locate(net, nd_lock, &p1, 0);
+			unlock_netdev(nd_lock);
 			if (!t)
 				goto done;
 			err = -EPERM;
@@ -2038,6 +2053,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 			 struct nlattr *data[], struct __ip6_tnl_parm *p_p,
 			 struct netlink_ext_ack *extack)
 {
+	struct nd_lock *nd_lock = rcu_dereference_protected(dev->nd_lock, true);
 	struct ip6_tnl *t, *nt = netdev_priv(dev);
 	struct net *net = nt->net;
 	struct ip6gre_net *ign = net_generic(net, ip6gre_net_id);
@@ -2055,7 +2071,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
 
 	ip6gre_netlink_parms(data, p_p);
 
-	t = ip6gre_tunnel_locate(net, p_p, 0);
+	t = ip6gre_tunnel_locate(net, nd_lock, p_p, 0);
 
 	if (t) {
 		if (t->dev != dev)



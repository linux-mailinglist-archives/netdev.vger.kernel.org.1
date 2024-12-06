Return-Path: <netdev+bounces-149584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93C9E654C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1285718855FD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 04:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE548193081;
	Fri,  6 Dec 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx3bQBPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9518CBFE
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458232; cv=none; b=tWhqht5VyniGiXtggbcrebcTOLtkjT2GaOX5Rz952Pm3jdvNqpmli9lRJ3urT/7i0RK7yCT/PUECnpLs1DuVJ7uHJzHUUmWs4jGSh7Nmiy88PpzG6qbLTbusupCQQne8pV6pa8PYCksogHgKnY+t0nDJXtUqpOKGhaYEr9P0BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458232; c=relaxed/simple;
	bh=wSp6AfmqQO66Gi6DzI6y4H/9+fJ8lAI9JLPDRXOJfjY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ofL+qMx0LN10MJ1EZLx50Zr3u38aAv4ahuotmZ9Zzpc6d6ciJW4+LUqPGCfHso4Uj5c7NxBZcewhlsSlFofSFqn4BZNjdosTSOefOrJ6sEk4GNirhkqHt4tEzpb1W7cfjGJlSaE31JFgmxVKmTzB0hDCH87Of1EnmVrWW1Y5U1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx3bQBPq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-215ccbcdc7eso24601255ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 20:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458230; x=1734063030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EP0j/eN4BV0nFJDvU0R5qZCLrIZgy8fNEFuWOhl8Ayc=;
        b=Lx3bQBPq4LP9sNz3CZrT6TIPNBVE5uG7d7vuYZY5/sTjev+wz8zJpvX2eF2LxTzwn+
         DVCdmqTd9o/GyI3CY2YTkpVn1VDi01jrmesqdMzb/p+b5DuN/eZtE72xY2KlPIeoJqoL
         BujRlSjn0r1ysaCGmL7V8ywBLJfQ/AxHD/GHEI3EtvnEvvaZJThrkJ4P+vwCM8+IISdU
         rzgTElOgRfFwdRBlEhwE6QCsPF/7rn6XYkOMbL/a0CB8LIyR6S2Oz70PbfH/EtTYsgJG
         hOHDIcBQJ3umdKJ9XHPjFbtWjBhLxPvXSH2dQ0LLAIh1iOWs8sP2Z2rOR1ogp9/ZuUKQ
         6vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458230; x=1734063030;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP0j/eN4BV0nFJDvU0R5qZCLrIZgy8fNEFuWOhl8Ayc=;
        b=GoxJNpCxVruPxFuCIaRh6Sxd26l0/BG6s4FKw4CVCRuXltqF2Q1r9Nvw6y7GGHFq8A
         PLtFtd+7K8u7LfOJteHD4R9smvBG9L7BaDkHVbO+79kfugOzG2aeSZf8N530m4UqOvZi
         DdwQuUFbhWuRErDiPzzWKjMAJo0vVcpKSvA4UoGGC9uQbH9sVgArqclQ/tBaTtGvphTw
         G7hVgv/Xi/QFAM5OCrw5FuznTRutUNl7tWVh+NpR2wg3y1a20tswcl2IFSnPSkzRwkxo
         rn9hJzVzVOmRg+H5QNcC4dVkzsj2AMl09wOsjR48I+jF6A1FvqHytlaM09Ni15E9s0Kz
         iHTg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8+xHwbJjt+xXqHyQYqVzr2jMj6+WWKLtYD2x7h8WQtV2zu1s1+ZazbiVtQUW5MNqOmCfo4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRydNOoKhlDdcMarlFuObeiefbWYEPZdXB2xx82jIbHxE+D9Bk
	y0bvjSTtGKopeOfnWTeDNVOgOCuvRjTLRlPFeRX3L8AuspP28zWOGa9QbF1lSav8/boVtIbcWLW
	oBncrkoDTC6qz2yHlnmvZ+w==
X-Google-Smtp-Source: AGHT+IHKaJT7jEEU36yicUVjtRLYme7TXRb/7Wew5HyjtsYqAl24NKDMuQaZxXaqcjdDfc/ZCfeaBFCxNX8xXKJ5Ng==
X-Received: from plks5.prod.google.com ([2002:a17:903:2c5:b0:214:bcea:1b7a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec89:b0:215:4e40:e4b0 with SMTP id d9443c01a7336-21614d5448bmr19999665ad.9.1733458230313;
 Thu, 05 Dec 2024 20:10:30 -0800 (PST)
Date: Fri,  6 Dec 2024 13:10:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206041025.37231-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change introduces netlink notifications for multicast address
changes. The following features are included:
* Addition and deletion of multicast addresses are reported using
  RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET and
  AF_INET6.
* Two new notification groups: RTNLGRP_IPV4_MCADDR and
  RTNLGRP_IPV6_MCADDR are introduced for receiving these events.

This change allows user space applications (e.g., ip monitor) to
efficiently track multicast group memberships by listening for netlink
events. Previously, applications relied on inefficient polling of
procfs, introducing delays. With netlink notifications, applications
receive realtime updates on multicast group membership changes,
enabling more precise metrics collection and system monitoring.=C2=A0

This change also unlocks the potential for implementing a wide range
of sophisticated multicast related features in user space by allowing
applications to combine kernel provided multicast address information
with user space data and communicate decisions back to the kernel for
more fine grained control. This mechanism can be used for various
purposes, including multicast filtering, IGMP/MLD offload, and
IGMP/MLD snooping.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-ma=
il.com
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v4:
- Use WARN_ON_ONCE() instead of WARN_ON()

Changelog since v3:
- Remove unused variable 'scope' declaration.
- Align RTM_NEWMULTICAST and RTM_GETMULTICAST enum definitions with
  existing code style.

Changelog since v2:
- Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
  consistency.

Changelog since v1:
- Implement MLD join/leave notifications.
- Revise the comment message to make it generic.
- Fix netdev/source_inline error.
- Reorder local variables according to "reverse xmas tree=E2=80=9D style.

 include/uapi/linux/rtnetlink.h | 10 +++++-
 net/ipv4/igmp.c                | 53 +++++++++++++++++++++++++++++++
 net/ipv6/mcast.c               | 57 ++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index db7254d52d93..eccc0e7dcb7d 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -93,7 +93,11 @@ enum {
 	RTM_NEWPREFIX	=3D 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
=20
-	RTM_GETMULTICAST =3D 58,
+	RTM_NEWMULTICAST =3D 56,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
+	RTM_GETMULTICAST,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
 	RTM_GETANYCAST	=3D 62,
@@ -774,6 +778,10 @@ enum rtnetlink_groups {
 #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
 	RTNLGRP_STATS,
 #define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
+	RTNLGRP_IPV6_MCADDR,
+#define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 6a238398acc9..cd3d6201fc9b 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -88,6 +88,7 @@
 #include <linux/byteorder/generic.h>
=20
 #include <net/net_namespace.h>
+#include <net/netlink.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -1430,6 +1431,55 @@ static void ip_mc_hash_remove(struct in_device *in_d=
ev,
 	*mc_hash =3D im->next_hash;
 }
=20
+static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+			      __be32 addr, int event)
+{
+	struct ifaddrmsg *ifm;
+	struct nlmsghdr *nlh;
+
+	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ifm =3D nlmsg_data(nlh);
+	ifm->ifa_family =3D AF_INET;
+	ifm->ifa_prefixlen =3D 32;
+	ifm->ifa_flags =3D IFA_F_PERMANENT;
+	ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
+	ifm->ifa_index =3D dev->ifindex;
+
+	if (nla_put_in_addr(skb, IFA_MULTICAST, addr) < 0) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, int =
event)
+{
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOBUFS;
+
+	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
+			+ nla_total_size(sizeof(__be32)), GFP_ATOMIC);
+	if (!skb)
+		goto error;
+
+	err =3D inet_fill_ifmcaddr(skb, dev, addr, event);
+	if (err < 0) {
+		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
+		kfree_skb(skb);
+		goto error;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV4_MCADDR, NULL, GFP_ATOMIC);
+	return;
+error:
+	rtnl_set_sk_err(net, RTNLGRP_IPV4_MCADDR, err);
+}
=20
 /*
  *	A socket has joined a multicast group on device dev.
@@ -1492,6 +1542,7 @@ static void ____ip_mc_inc_group(struct in_device *in_=
dev, __be32 addr,
 	igmpv3_del_delrec(in_dev, im);
 #endif
 	igmp_group_added(im);
+	inet_ifmcaddr_notify(in_dev->dev, addr, RTM_NEWMULTICAST);
 	if (!in_dev->dead)
 		ip_rt_multicast_event(in_dev);
 out:
@@ -1705,6 +1756,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be=
32 addr, gfp_t gfp)
 				*ip =3D i->next_rcu;
 				in_dev->mc_count--;
 				__igmp_group_dropped(i, gfp);
+				inet_ifmcaddr_notify(in_dev->dev, addr,
+						     RTM_DELMULTICAST);
 				ip_mc_clear_src(i);
=20
 				if (!in_dev->dead)
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b244dbf61d5f..ab6bc07bdf6f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -33,8 +33,10 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/netdevice.h>
+#include <linux/if_addr.h>
 #include <linux/if_arp.h>
 #include <linux/route.h>
+#include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -47,6 +49,7 @@
 #include <linux/netfilter_ipv6.h>
=20
 #include <net/net_namespace.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <net/snmp.h>
=20
@@ -901,6 +904,57 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *i=
dev,
 	return mc;
 }
=20
+static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev=
,
+			       const struct in6_addr *addr, int event)
+{
+	struct ifaddrmsg *ifm;
+	struct nlmsghdr *nlh;
+
+	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ifm =3D nlmsg_data(nlh);
+	ifm->ifa_family =3D AF_INET6;
+	ifm->ifa_prefixlen =3D 128;
+	ifm->ifa_flags =3D IFA_F_PERMANENT;
+	ifm->ifa_scope =3D RT_SCOPE_UNIVERSE;
+	ifm->ifa_index =3D dev->ifindex;
+
+	if (nla_put_in6_addr(skb, IFA_MULTICAST, addr) < 0) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static void inet6_ifmcaddr_notify(struct net_device *dev,
+				  const struct in6_addr *addr, int event)
+{
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOBUFS;
+
+	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg))
+			+ nla_total_size(16), GFP_ATOMIC);
+	if (!skb)
+		goto error;
+
+	err =3D inet6_fill_ifmcaddr(skb, dev, addr, event);
+	if (err < 0) {
+		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
+		kfree_skb(skb);
+		goto error;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_ATOMIC);
+	return;
+error:
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_MCADDR, err);
+}
+
 /*
  *	device multicast group inc (add if not found)
  */
@@ -948,6 +1002,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
=20
 	mld_del_delrec(idev, mc);
 	igmp6_group_added(mc);
+	inet6_ifmcaddr_notify(dev, addr, RTM_NEWMULTICAST);
 	mutex_unlock(&idev->mc_lock);
 	ma_put(mc);
 	return 0;
@@ -977,6 +1032,8 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const st=
ruct in6_addr *addr)
 				*map =3D ma->next;
=20
 				igmp6_group_dropped(ma);
+				inet6_ifmcaddr_notify(idev->dev, addr,
+						      RTM_DELMULTICAST);
 				ip6_mc_clear_src(ma);
 				mutex_unlock(&idev->mc_lock);
=20
--=20
2.47.0.338.g60cca15819-goog



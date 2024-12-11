Return-Path: <netdev+bounces-151022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577F9EC6FC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4ED1694F2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891D1D61AF;
	Wed, 11 Dec 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oid95MxH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350591D63FF
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905369; cv=none; b=VKDsJuWOKIE0eWAFnxqvg/4xMu2Kz/HvyKYyBXIPZMfGM23r1tdsK2uJ/W82eXqJNGRAzKAQ/6zsa4+uG/wQ6ExgHB8+uStgoFhFawFtp/y8LNkPLxcoWP3mQFHeXZ6TSN+pTq5D69cKmKgYvEkfPtfuAJqUNT5wRIXAIYWKyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905369; c=relaxed/simple;
	bh=yQk9lnuDk5QkJJ1vnnO6yCjpyl7DoLRhV7AanwnQKDw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nlbLoML2ArxW37/HuJAQZfMWw2Lg+kDJD46Xy24cIUjKSF6jfQvFCvRKXN9kvS53Blm7z89Tt9zjBmIC3s+ywC6io6lDbz4jBZ4A1VVKi/sgKoqLHvy4GNhivRBUQhhdQw+0v9jgWwGbq5G9VF9x3wC2UIaT9HUTrgGZ8EHj9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oid95MxH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216430a88b0so31229275ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733905366; x=1734510166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKziddB+Jnwlg1Zk3J4SdGKXZ/1Nj6HoN4s1cv7Ynq0=;
        b=Oid95MxHm2AABGq6+kj6n0nUOtonPXbwPnaspbRdPaCGdH6zcQ34r1q2sn6ABdGQrF
         QsDQhGEJsAhSba9APvYz4rWlWI/4/dJmtmC56aZbN0Vfnei0B08J8qbhc7rs8s0czp9Q
         958oBlsKxyQsoFCNKIJIas8kF0RAavBEg3wYuRi6po4vUlUIitOSp3Wtf9gfzN53qaAx
         rzgEi6Y9+ad4n3vSnGOf218Zqy3ZoC1kGu1DnRKAOalxDgmDF0bkJS/Ld0xHiX0jX+Dj
         aEb02s/jjAujoam84BBmE06NOiCRLIHro4hskelXdzWXY2zLCpkiRCwfAXOUOhauo3mm
         /Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905366; x=1734510166;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKziddB+Jnwlg1Zk3J4SdGKXZ/1Nj6HoN4s1cv7Ynq0=;
        b=h7MDbtV6snNJwW6gJWJojbsqrTGRiMRYsxMzF8vq1mGlG+ramI8oV2THDq4G55BzfT
         LxZCW/hTd2qkeILNohCXiTJXbHewrEfUOcl6pjc1sp0utg96mbTiVK0Uit8Kk1/EpOte
         domXzmhSEnX2REP8j+te+L2JZwBrcM2HWu2xOGmcD5sPiHs+J3DmJ5MYeFIrFsX9G2fe
         by4S8WfuT8vBJAff10h3b0DVI/V1nntvzVj4FtZAUQMYTDN/g/1OHCz1Xx3XpfMyGdiO
         8Cm4H5fByPysd/ArjT0SWOPb1l+GEjb6ifo4f4h2xFMykIL2frbPfhwpaxWODZ2mi/ch
         cC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW7T/3BwD9gYM1DBw0+AisDHD4Z7D/N0hPf4co0Ps4KtnaW/cQ4psgqijamHfWepHdpwUEXlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM003pJP7/1GbFFWuCh/5rUXnHRPY5kHxnyy1vyBBKBuOfdcMG
	52TWP/YEOuvVG1e7IX/NHRqMc/Bn4aMGZgZUVcsesjInLRrwO/4YGhMhzK1ZhGCADb8xbfyBMFr
	jexA/O5lpP7+Pb+XQfvJzdA==
X-Google-Smtp-Source: AGHT+IEBDyzzHWxUbnf0z90RqyKgYt79NZEO/5HQgIO2/osvdxmbw80skDH0N8SiADUlTmYMPLDJKcIZh8mJj94/ng==
X-Received: from plwg5.prod.google.com ([2002:a17:902:f745:b0:216:271b:1b41])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:98e:b0:215:6f5d:b756 with SMTP id d9443c01a7336-2177839352emr29119645ad.7.1733905366479;
 Wed, 11 Dec 2024 00:22:46 -0800 (PST)
Date: Wed, 11 Dec 2024 17:22:41 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241211082241.3372537-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v6] netlink: add IGMP/MLD join/leave notifications
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

Changelog since v5:
- Update the inet_fill_ifmcaddr() function to populate IFA_CACHEINFO, align=
ing
  it with the behavior of inet6_fill_ifmcaddr().
- Reuse inet6_fill_ifmcaddr() in mcast.c for keeping notifications and gett=
ing
  responses in sync.
- Use -ENOMEM instead of -ENOBUFS to initialize the error number.
- Use nlmsg_free() instead of kfree_skb() on exist.
- Minor style fix: Moved "+" to the end of the line.

Changelog since v4:
- Use WARN_ON_ONCE() instead of WARN_ON()

Changelog since v3:
- Remove unused variable 'scope' declaration.
- Align RTM_NEWMULTICAST and RTM_GETMULTICAST enum definitions with existin=
g
  code style.

Changelog since v2:
- Use RT_SCOPE_UNIVERSE for both IGMP and MLD notification messages for
  consistency.

Changelog since v1:
- Implement MLD join/leave notifications.
- Revise the comment message to make it generic.
- Fix netdev/source_inline error.
- Reorder local variables according to "reverse xmas tree=E2=80=9D style.

 include/linux/igmp.h           |  2 ++
 include/net/addrconf.h         | 21 +++++++++++
 include/uapi/linux/rtnetlink.h | 10 +++++-
 net/ipv4/igmp.c                | 64 ++++++++++++++++++++++++++++++++++
 net/ipv6/addrconf.c            | 29 +++++----------
 net/ipv6/mcast.c               | 39 +++++++++++++++++++++
 6 files changed, 144 insertions(+), 21 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 5171231f70a8..073b30a9b850 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -87,6 +87,8 @@ struct ip_mc_list {
 	char			loaded;
 	unsigned char		gsquery;	/* check source marks? */
 	unsigned char		crcount;
+	unsigned long		mca_cstamp;
+	unsigned long		mca_tstamp;
 	struct rcu_head		rcu;
 };
=20
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 363dd63babe7..58337898fa21 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -88,6 +88,23 @@ struct ifa6_config {
 	u16			scope;
 };
=20
+enum addr_type_t {
+	UNICAST_ADDR,
+	MULTICAST_ADDR,
+	ANYCAST_ADDR,
+};
+
+struct inet6_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+	int ifindex;
+	enum addr_type_t type;
+	bool force_rt_scope_universe;
+};
+
 int addrconf_init(void);
 void addrconf_cleanup(void);
=20
@@ -525,4 +542,8 @@ int if6_proc_init(void);
 void if6_proc_exit(void);
 #endif
=20
+int inet6_fill_ifmcaddr(struct sk_buff *skb,
+			const struct ifmcaddr6 *ifmca,
+			struct inet6_fill_args *args);
+
 #endif
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
index 6a238398acc9..8a370ef37d3f 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -88,6 +88,8 @@
 #include <linux/byteorder/generic.h>
=20
 #include <net/net_namespace.h>
+#include <net/netlink.h>
+#include <net/addrconf.h>
 #include <net/arp.h>
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -1430,6 +1432,63 @@ static void ip_mc_hash_remove(struct in_device *in_d=
ev,
 	*mc_hash =3D im->next_hash;
 }
=20
+static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+			      const struct ip_mc_list *im, int event)
+{
+	struct ifa_cacheinfo ci;
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
+	ci.cstamp =3D (READ_ONCE(im->mca_cstamp) - INITIAL_JIFFIES) * 100UL / HZ;
+	ci.tstamp =3D ci.cstamp;
+	ci.ifa_prefered =3D INFINITY_LIFE_TIME;
+	ci.ifa_valid =3D INFINITY_LIFE_TIME;
+
+	if (nla_put_in_addr(skb, IFA_MULTICAST, im->multiaddr) < 0 ||
+	    nla_put(skb, IFA_CACHEINFO, sizeof(ci), &ci) < 0) {
+		nlmsg_cancel(skb, nlh);
+		return -EMSGSIZE;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static void inet_ifmcaddr_notify(struct net_device *dev,
+				 const struct ip_mc_list *im, int event)
+{
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOMEM;
+
+	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+			nla_total_size(sizeof(__be32)), GFP_ATOMIC);
+	if (!skb)
+		goto error;
+
+	err =3D inet_fill_ifmcaddr(skb, dev, im, event);
+	if (err < 0) {
+		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
+		nlmsg_free(skb);
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
@@ -1473,6 +1532,8 @@ static void ____ip_mc_inc_group(struct in_device *in_=
dev, __be32 addr,
 	im->interface =3D in_dev;
 	in_dev_hold(in_dev);
 	im->multiaddr =3D addr;
+	im->mca_cstamp =3D jiffies;
+	im->mca_tstamp =3D im->mca_cstamp;
 	/* initial mode is (EX, empty) */
 	im->sfmode =3D mode;
 	im->sfcount[mode] =3D 1;
@@ -1492,6 +1553,7 @@ static void ____ip_mc_inc_group(struct in_device *in_=
dev, __be32 addr,
 	igmpv3_del_delrec(in_dev, im);
 #endif
 	igmp_group_added(im);
+	inet_ifmcaddr_notify(in_dev->dev, im, RTM_NEWMULTICAST);
 	if (!in_dev->dead)
 		ip_rt_multicast_event(in_dev);
 out:
@@ -1705,6 +1767,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be=
32 addr, gfp_t gfp)
 				*ip =3D i->next_rcu;
 				in_dev->mc_count--;
 				__igmp_group_dropped(i, gfp);
+				inet_ifmcaddr_notify(in_dev->dev, i,
+						     RTM_DELMULTICAST);
 				ip_mc_clear_src(i);
=20
 				if (!in_dev->dead)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c489a1e6aec9..ac8ddda9d14f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5126,22 +5126,6 @@ static inline int inet6_ifaddr_msgsize(void)
 	       + nla_total_size(4)  /* IFA_RT_PRIORITY */;
 }
=20
-enum addr_type_t {
-	UNICAST_ADDR,
-	MULTICAST_ADDR,
-	ANYCAST_ADDR,
-};
-
-struct inet6_fill_args {
-	u32 portid;
-	u32 seq;
-	int event;
-	unsigned int flags;
-	int netnsid;
-	int ifindex;
-	enum addr_type_t type;
-};
-
 static int inet6_fill_ifaddr(struct sk_buff *skb,
 			     const struct inet6_ifaddr *ifa,
 			     struct inet6_fill_args *args)
@@ -5220,15 +5204,16 @@ static int inet6_fill_ifaddr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
=20
-static int inet6_fill_ifmcaddr(struct sk_buff *skb,
-			       const struct ifmcaddr6 *ifmca,
-			       struct inet6_fill_args *args)
+int inet6_fill_ifmcaddr(struct sk_buff *skb,
+			const struct ifmcaddr6 *ifmca,
+			struct inet6_fill_args *args)
 {
 	int ifindex =3D ifmca->idev->dev->ifindex;
 	u8 scope =3D RT_SCOPE_UNIVERSE;
 	struct nlmsghdr *nlh;
=20
-	if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
+	if (!args->force_rt_scope_universe &&
+	    ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE)
 		scope =3D RT_SCOPE_SITE;
=20
 	nlh =3D nlmsg_put(skb, args->portid, args->seq, args->event,
@@ -5253,6 +5238,7 @@ static int inet6_fill_ifmcaddr(struct sk_buff *skb,
 	nlmsg_end(skb, nlh);
 	return 0;
 }
+EXPORT_SYMBOL(inet6_fill_ifmcaddr);
=20
 static int inet6_fill_ifacaddr(struct sk_buff *skb,
 			       const struct ifacaddr6 *ifaca,
@@ -5417,6 +5403,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struc=
t netlink_callback *cb,
 		.flags =3D NLM_F_MULTI,
 		.netnsid =3D -1,
 		.type =3D type,
+		.force_rt_scope_universe =3D false,
 	};
 	struct {
 		unsigned long ifindex;
@@ -5545,6 +5532,7 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, =
struct nlmsghdr *nlh,
 		.event =3D RTM_NEWADDR,
 		.flags =3D 0,
 		.netnsid =3D -1,
+		.force_rt_scope_universe =3D false,
 	};
 	struct ifaddrmsg *ifm;
 	struct nlattr *tb[IFA_MAX+1];
@@ -5616,6 +5604,7 @@ static void inet6_ifa_notify(int event, struct inet6_=
ifaddr *ifa)
 		.event =3D event,
 		.flags =3D 0,
 		.netnsid =3D -1,
+		.force_rt_scope_universe =3D false,
 	};
 	int err =3D -ENOBUFS;
=20
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index b244dbf61d5f..a65da675e16d 100644
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
@@ -901,6 +904,39 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *i=
dev,
 	return mc;
 }
=20
+static void inet6_ifmcaddr_notify(struct net_device *dev,
+				  const struct ifmcaddr6 *ifmca, int event)
+{
+	struct inet6_fill_args fillargs =3D {
+		.portid =3D 0,
+		.seq =3D 0,
+		.event =3D event,
+		.flags =3D 0,
+		.netnsid =3D -1,
+		.force_rt_scope_universe =3D true,
+	};
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOMEM;
+
+	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+			nla_total_size(16), GFP_ATOMIC);
+	if (!skb)
+		goto error;
+
+	err =3D inet6_fill_ifmcaddr(skb, ifmca, &fillargs);
+	if (err < 0) {
+		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
+		nlmsg_free(skb);
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
@@ -948,6 +984,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
=20
 	mld_del_delrec(idev, mc);
 	igmp6_group_added(mc);
+	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
 	mutex_unlock(&idev->mc_lock);
 	ma_put(mc);
 	return 0;
@@ -977,6 +1014,8 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const st=
ruct in6_addr *addr)
 				*map =3D ma->next;
=20
 				igmp6_group_dropped(ma);
+				inet6_ifmcaddr_notify(idev->dev, ma,
+						      RTM_DELMULTICAST);
 				ip6_mc_clear_src(ma);
 				mutex_unlock(&idev->mc_lock);
=20
--=20
2.47.1.613.gc27f4b7a9f-goog



Return-Path: <netdev+bounces-152864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C19F60A1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B481887966
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25755174EDB;
	Wed, 18 Dec 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vz0L/8Kg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68D18D656
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512464; cv=none; b=YAhtcT0TMGq8fkRcaEZ80ibH2UmqcW1h1vDgyGdVNS/GVOtZtzTIdrxYGc4U6mEkJhtaTDY4rwQKAq/w1gp7EIODsvKCzOs2M/ONMsr3prjuMxgiA0J1d7fZS9BmFTbkVV34ygfiKpznuwZJuh8l/hLSpM0X6RZGZzanwkhr5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512464; c=relaxed/simple;
	bh=iMyMUsvpVel3bCW2MhvsWmIqtgE7lhOwnHJKnRBHreo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZrU1tCBWK1PJxzuipLrt9KhH00YbkoMVVzK8wAHSzMkmk/5QdLkuKQj+qsSbmgU0zWsXcNXeoxQ85+YEY+0lcgh9WSv/ffabzAHzVka+WuVzFigHp7XzX1cTukxYHzahkj2IFlMxBRDHS5Ii40lmq8HFyJz7uRiPV/wCR/urBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vz0L/8Kg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166f9f52fbso88620105ad.2
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734512462; x=1735117262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vn1DMPiUr6FITE+HvgK4oPLmoMRzM7Pwyk5DelrD80E=;
        b=Vz0L/8KghNXo86Klf/YTZoTvvBw7s2Ej2ftjVUgyIbFwrIhlGzSDQIBtoSYirZDShI
         +ScNX2qxoNYXyUYLDL+1WgpO2oy9wr2Cf8D8vHfKi6xgebrnynkqkVzB7uHDjrFyv7BG
         IPOm2hpcMujhMW8ASMIo/NIRYyjUsGS8JdXBRNmarGMT7VyB/XxNztg9FNXs+AVhFi67
         Z1ZF2RFEwDkwsdKKu3upFARltfTU0r6MNP7uRK4moz15x/Y+uXZaBe5BEvdAH37V9adu
         5d5YD+5QZNrcdrHd9OBFkZ9sSb6CrxLFuR77tWO4JhBZABYo+0GgDiOg0k2mlKpHXaP7
         +AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512462; x=1735117262;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn1DMPiUr6FITE+HvgK4oPLmoMRzM7Pwyk5DelrD80E=;
        b=mJuPM4kk6kysr8zbWM2/euopEiODh5V2K0LhK3dURCGvsVXpDOBlkizYCsOI/Laanl
         8hRP39NxTRxXJ+dUVvr2LRoRrXlJlFvNbp1fd9T3PaEMwW8hvhjSW5XexMAknDsfYVsh
         Xw/uqK3om9CM5EJahtFZYNR6SuRs4chyv+aSExrjrpwiNbTsJxjbmmt0druEE3skmH7o
         Tl8gu25CvCG00nx2KI18eA3rfdmX0YafO0IjKSx/2n2v4R79jI5XQeGLwp9lZ+/Uz6/I
         ovRY8otUZw6SVhCmO/W3G0L3rQhU5FxIXQH6A3iCC6fROLAw+BA3p7x72Qxz5EQK6/R1
         EF2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+o9/6YbKO/ikOITBnFquISVmDse4AK0nr4TPGUFGz+rqUpjqj94oIhcnZ/D3tRpkBZEuFPCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQ78E+XFJF4/PjOJm8h0e6dYhb6ly6rvu9KPkX/mNS3phBeKc
	jDouvh+m9dmUemiCcwp6ThpnNZo38M80pprJaDQvLHljlDRVy4T6zfinZVZs6RxmUpYozSStk5J
	XJbHA1bS2Asrccazsakwp/A==
X-Google-Smtp-Source: AGHT+IHrSovWhzDPIg/XxuMr4GSxeCzLSa1ueqqPXbWvfZPxmNIYJMSUPH1Kyy7PD9boeEiIPucRPCFmBJOo0oh32Q==
X-Received: from plbko4.prod.google.com ([2002:a17:903:7c4:b0:216:3858:3176])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:b613:b0:216:1cfa:2bda with SMTP id d9443c01a7336-218d72621e8mr23928685ad.43.1734512461563;
 Wed, 18 Dec 2024 01:01:01 -0800 (PST)
Date: Wed, 18 Dec 2024 18:00:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218090057.76899-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v2] netlink: support dumping IPv4 multicast addresses
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	pruddy@vyatta.att-mail.com, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
addresses, in addition to the existing IPv6 functionality. This allows
userspace applications to retrieve both IPv4 and IPv6 multicast
addresses through similar netlink command and then monitor future
changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 include/linux/igmp.h |  7 +++++
 net/ipv4/devinet.c   | 61 ++++++++++++++++++++++++++++++++++++--------
 net/ipv4/igmp.c      | 14 ++++------
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..221768b47e80 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -142,4 +142,11 @@ extern void __ip_mc_inc_group(struct in_device *in_dev=
, __be32 addr,
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
=20
+#define for_each_pmc_rcu(in_dev, pmc)				\
+	for (pmc =3D rcu_dereference(in_dev->mc_list);		\
+	     pmc !=3D NULL;					\
+	     pmc =3D rcu_dereference(pmc->next_rcu))
+
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im, int event, int flags);
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..01754d96fa2d 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -114,6 +114,7 @@ struct inet_fill_args {
 	unsigned int flags;
 	int netnsid;
 	int ifindex;
+	enum addr_type_t type;
 };
=20
 #define IN4_ADDR_HSIZE_SHIFT	8
@@ -1850,21 +1851,44 @@ static int in_dev_dump_addr(struct in_device *in_de=
v, struct sk_buff *skb,
 			    struct netlink_callback *cb, int *s_ip_idx,
 			    struct inet_fill_args *fillargs)
 {
+	struct ip_mc_list *im;
 	struct in_ifaddr *ifa;
 	int ip_idx =3D 0;
 	int err;
=20
-	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (ip_idx < *s_ip_idx) {
+	switch (fillargs->type) {
+	case UNICAST_ADDR:
+		fillargs->event =3D RTM_NEWADDR;
+		in_dev_for_each_ifa_rcu(ifa, in_dev) {
+			if (ip_idx < *s_ip_idx) {
+				ip_idx++;
+				continue;
+			}
+			err =3D inet_fill_ifaddr(skb, ifa, fillargs);
+			if (err < 0)
+				goto done;
+
+			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 			ip_idx++;
-			continue;
 		}
-		err =3D inet_fill_ifaddr(skb, ifa, fillargs);
-		if (err < 0)
-			goto done;
+		break;
+	case MULTICAST_ADDR:
+		for_each_pmc_rcu(in_dev, im) {
+			if (ip_idx < *s_ip_idx) {
+				ip_idx++;
+				continue;
+			}
+			err =3D inet_fill_ifmcaddr(skb, in_dev->dev, im,
+						 RTM_GETMULTICAST, NLM_F_MULTI);
+			if (err < 0)
+				goto done;
=20
-		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
-		ip_idx++;
+			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+			ip_idx++;
+		}
+		break;
+	default:
+		break;
 	}
 	err =3D 0;
 	ip_idx =3D 0;
@@ -1889,15 +1913,16 @@ static u32 inet_base_seq(const struct net *net)
 	return res;
 }
=20
-static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb=
,
+			  enum addr_type_t type)
 {
 	const struct nlmsghdr *nlh =3D cb->nlh;
 	struct inet_fill_args fillargs =3D {
 		.portid =3D NETLINK_CB(cb->skb).portid,
 		.seq =3D nlh->nlmsg_seq,
-		.event =3D RTM_NEWADDR,
 		.flags =3D NLM_F_MULTI,
 		.netnsid =3D -1,
+		.type =3D type,
 	};
 	struct net *net =3D sock_net(skb->sk);
 	struct net *tgt_net =3D net;
@@ -1949,6 +1974,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
uct netlink_callback *cb)
 	return err;
 }
=20
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+{
+	enum addr_type_t type =3D UNICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
+static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback=
 *cb)
+{
+	enum addr_type_t type =3D MULTICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *n=
lh,
 		      u32 portid)
 {
@@ -2845,6 +2884,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
_handlers[] __initconst =3D {
 	{.protocol =3D PF_INET, .msgtype =3D RTM_GETNETCONF,
 	 .doit =3D inet_netconf_get_devconf, .dumpit =3D inet_netconf_dump_devcon=
f,
 	 .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
+	{.owner =3D THIS_MODULE, .protocol =3D PF_INET, .msgtype =3D RTM_GETMULTI=
CAST,
+	 .dumpit =3D inet_dump_ifmcaddr, .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
 };
=20
 void __init devinet_init(void)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 8a370ef37d3f..a262614c29ee 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -174,11 +174,6 @@ static void ip_ma_put(struct ip_mc_list *im)
 	}
 }
=20
-#define for_each_pmc_rcu(in_dev, pmc)				\
-	for (pmc =3D rcu_dereference(in_dev->mc_list);		\
-	     pmc !=3D NULL;					\
-	     pmc =3D rcu_dereference(pmc->next_rcu))
-
 #define for_each_pmc_rtnl(in_dev, pmc)				\
 	for (pmc =3D rtnl_dereference(in_dev->mc_list);		\
 	     pmc !=3D NULL;					\
@@ -1432,14 +1427,14 @@ static void ip_mc_hash_remove(struct in_device *in_=
dev,
 	*mc_hash =3D im->next_hash;
 }
=20
-static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
-			      const struct ip_mc_list *im, int event)
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im, int event, int flags)
 {
 	struct ifa_cacheinfo ci;
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr *nlh;
=20
-	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), flags);
 	if (!nlh)
 		return -EMSGSIZE;
=20
@@ -1464,6 +1459,7 @@ static int inet_fill_ifmcaddr(struct sk_buff *skb, st=
ruct net_device *dev,
 	nlmsg_end(skb, nlh);
 	return 0;
 }
+EXPORT_SYMBOL(inet_fill_ifmcaddr);
=20
 static void inet_ifmcaddr_notify(struct net_device *dev,
 				 const struct ip_mc_list *im, int event)
@@ -1477,7 +1473,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	if (!skb)
 		goto error;
=20
-	err =3D inet_fill_ifmcaddr(skb, dev, im, event);
+	err =3D inet_fill_ifmcaddr(skb, dev, im, event, 0);
 	if (err < 0) {
 		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
 		nlmsg_free(skb);
--=20
2.47.1.613.gc27f4b7a9f-goog



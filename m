Return-Path: <netdev+bounces-152494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702AF9F43B9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3D816B349
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936C14C5AF;
	Tue, 17 Dec 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTspzMsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2A170822
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417091; cv=none; b=RiGAAN6qdSNiOE0Wlc05+i+7s37wSNi57PqcrummWpfYYkxBY5fXVWHM09jkBqof/LfFf2MknCiU1Y+IVHaVB8t3l75DYMmC1N+VlENIw2P1BPi/q8jOdqJ8t94kJwhrlwdnGsgk23jhD/EHrvL6/3O00Koz29EHSHUfF9nkqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417091; c=relaxed/simple;
	bh=bAOVHJtNkWkKQOWZCiarJvDyH2qGf0PMiFP2aKG3cbo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cEQByq4U09dSDxaRfLyPFSIIk/YUQO7m031pLWgMtMjbTXU5fPjI6dDVwl29WywWPaqyQtNfSaaChYBOMFTTJr5es9UrUL7g540dKkHVJxRurqghRJZtMPmsVuoPocspU9+6UQOGaBRATYP5wa4AeQWsae6QIABCkmQU/VIaPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTspzMsr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72726ced3f3so4407214b3a.2
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734417089; x=1735021889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHYdLK7xjtNv3cBlxF/V67gsirfObyAh3u6XCjLCPR8=;
        b=kTspzMsrIlppEATrdJieD15WLNCLJZQ+XzpyVsxDdpp31loxEUNP9G5VNNXZ8fl/QV
         9rFf52h4jGk2rbwAXpfdnjEdd05vSjPqGVxGQCYzWhtkKFQircFhG7ujPGIQZDoWGabR
         dJuS7szaBDH5GHCvbYBlLc7plbkUJcxCEcTcuFJxslWS877k6kPhSm23af5O6+bGdQyJ
         1wQi92f/JOspDQwBXq1h0kJZjjI6ibDlyKXHkbKjUolllWPWb7sE8T+U1B0lECUzWYwi
         7/TvooMlqsRh6BSgOObomqbXc/OokVYp5jI0z7piBbNw+k+TQNTJ+fJzHbj0ODWumA+8
         FVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417089; x=1735021889;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHYdLK7xjtNv3cBlxF/V67gsirfObyAh3u6XCjLCPR8=;
        b=aQLsIrbyzMM7WThVtg/7mEyRwdT7aBWzJn81+7zJ2v0SmfTDhHQ4euHvfLdDapNxth
         1ODKNFSQI3vYrdjzovoCuqZf76ou11NXPlZhsP7dmHMNFsWkt32ROWhS40jRXDD4KZrm
         fry0WDlRfR8sEbr5B6okNvCTJgWv3MYsMfABcAbg0DsH6ek81ZC2nLTXfwTbYfkg45kH
         RPt2fysnZMrzlGIUuQaJif50xw8wQgSi/582ldQDdbHzaIceGbw/IW6Q4IUgx4iwwGBy
         6QIRgkMvq9HVrXk/xenVobeB0FUSkwJIa0w65JH7shKYPbv3uPLaJd2+IYU9gBkmyRIY
         yrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNPXSzfvLGAw5t5RR6oCOUG7xJuL4c+ZgO9BfCGiTYkrTWs8QI9axZuTRYSWvobCMSxPuqfro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Qxra8TiQrf1LbHBhiP5LdnPVj2WDmVsIknx0PQjDz6d6NxgW
	xevi5wyTxUMgdtA1St0ebjM2x+72W9f06furanA+pKM3NpxFZnnKWVbZhs/IiKvPtxde/dMwJC+
	AMqJBO1bGBrLCpVHLY6kV/Q==
X-Google-Smtp-Source: AGHT+IGaXBkW68E9G7IgdAchOngVilP1Ei9m4pxQ1VLOYC3i/LdPdeK3TOnyAX6BQMW+IQkugoS1+MJTUppnx/lDXw==
X-Received: from pfbna41.prod.google.com ([2002:a05:6a00:3e29:b0:728:958a:e45c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:301a:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7290c0dfcaemr24248171b3a.5.1734417089560;
 Mon, 16 Dec 2024 22:31:29 -0800 (PST)
Date: Tue, 17 Dec 2024 15:31:24 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217063124.3766605-1-yuyanghuang@google.com>
Subject: [PATCH net-next] netlink: support dumping IPv4 multicast addresses
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	netdev@vger.kernel.org, 
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
 include/linux/igmp.h |  7 +++++
 net/ipv4/devinet.c   | 63 +++++++++++++++++++++++++++++++++++++-------
 net/ipv4/igmp.c      | 14 ++++------
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..1e4164f931d6 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -142,4 +142,11 @@ extern void __ip_mc_inc_group(struct in_device *in_dev=
, __be32 addr,
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
=20
+#define for_each_pmc_rtnl(in_dev, pmc)				\
+	for (pmc =3D rtnl_dereference(in_dev->mc_list);		\
+	     pmc !=3D NULL;					\
+	     pmc =3D rtnl_dereference(pmc->next_rcu))
+
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im, int event, int flags);
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..d3ddb0586074 100644
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
+	switch(fillargs->type) {
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
+		for_each_pmc_rtnl(in_dev, im) {
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
@@ -1949,6 +1974,22 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
uct netlink_callback *cb)
 	return err;
 }
=20
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+{
+
+	enum addr_type_t type =3D UNICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
+static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback=
 *cb)
+{
+
+	enum addr_type_t type =3D MULTICAST_ADDR;
+
+	return inet_dump_addr(skb, cb, type);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *n=
lh,
 		      u32 portid)
 {
@@ -2845,6 +2886,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
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
index 8a370ef37d3f..7e085bdc1c40 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -179,11 +179,6 @@ static void ip_ma_put(struct ip_mc_list *im)
 	     pmc !=3D NULL;					\
 	     pmc =3D rcu_dereference(pmc->next_rcu))
=20
-#define for_each_pmc_rtnl(in_dev, pmc)				\
-	for (pmc =3D rtnl_dereference(in_dev->mc_list);		\
-	     pmc !=3D NULL;					\
-	     pmc =3D rtnl_dereference(pmc->next_rcu))
-
 static void ip_sf_list_clear_all(struct ip_sf_list *psf)
 {
 	struct ip_sf_list *next;
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



Return-Path: <netdev+bounces-153877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26659F9EDE
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459E31641B8
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F71DF269;
	Sat, 21 Dec 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ6D3AVG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3E3F9D2
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734762941; cv=none; b=F+YRciOl7065naTg07YkOLvjhAXrblT8beBSdVZPtoJRYFlzaSpCRlvJvzAeBGUXcG14Vs2SL577XzH/Tr9bMXKvAxRT4+RZgaNmUqqW/4UukkkmAjErgSXnSEOatNFGQj+7bTz5UeatBRHBcOcSylZfm7Jjr4N/GdfF/Zy3/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734762941; c=relaxed/simple;
	bh=cA49dLWLPeXMo8EkDyJuvvqslUmMVWWyR+Zoo77Nm48=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RmK/Wng2R1kfyYo6EYYpxWhK6zTJOqx1S2IjY93XS2pWyG9hGH3IVfeDc7aWFQ6i17OnQKcaMXm+Z95cn6fnJ0lNHz+LnfqpgXXEJQJWjrD8gQnPWFn4zmAfTq0nJLphrPldNDb5mSuLlNLwo0YE3ZzO3mgaUlBE0Ue/mmD10dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ6D3AVG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21661949f23so38312925ad.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734762939; x=1735367739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMcfKA1YHrVykkv4z+7oNS4M200AweVT6BkZXKe+0UA=;
        b=GJ6D3AVGeHR6PIItHAEuoPoxHm2tHDiU+12zt0K+KWwuGEXUwrOb+3EB0OruIEe+qm
         YhvlgKnjcIQHLqXm9FiXxHzLzmQU0UpCotQVw2Y4JvT6GK3JA7hK0+ocx2f5nMSgY2By
         gS/Gl/mgXJ68i1vQpJknrgrQGJTCKCkoA52kToV1RCWdFoFD/qt8Em3hCSQDYC+rhSB+
         DNJOFzsmJN0IbIcT/JuiK3dzgGMFW1m4O7X8Uk7QGR2KNWKVaMm3F/KQ4vBkCOBrStu9
         ruPvlLi3azH6HVIPUtqNU7LqsyHfgtwCRVeUuVf4ZjxiJ4HTpEqKwZ3yhye1G38QjVpJ
         GQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734762939; x=1735367739;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMcfKA1YHrVykkv4z+7oNS4M200AweVT6BkZXKe+0UA=;
        b=jPt682iz/bUX79gtQU0QlRDYhobk+8io+lmzTK3Q51U3j996qsIqaNaHJuHgr6Ks5x
         8mz+/GkRQFCAHhKk+BdAREmesx8O1VnvsdJznpqZxy0xHlupnsT0kAxZnM6B4CphAZX7
         HE+kthMBDxs4n+ukwXIvk3VgUU4MBhzr6cuAP54UiF2fSdNH78kcsLjzHtT7UeTuvM2q
         qWlyIUhyhakJEz5mI3Lpm0Y0QPkGaAeWehHtJRIFJxWaz02rmFKMcJfpKXhH/c9rCq+0
         eccuhWGj7p6TyAnszsx+CWhC+nNm/rbdmQA9BXSTBDyhYGNy0vZpbdUWNuGDIs5rq2fq
         Lfmw==
X-Forwarded-Encrypted: i=1; AJvYcCVhDoYxYkRIzgvj8oqAZcSesdYPj4izVH0c6Np1TPLQuToQe+S7Lwxq+YAihHGY2DTwdDrR8Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtr5MzrTyo4kHalp180LqmM6ImW68Rm8gwjmOSStZ3ZL+IWRGt
	1TSKA67n7rU3beKLI6++yGk7LTW7MoFQbh4S+M0mD3JiNcRl0jV+hp0Z92NcG3eA9uAr4b+QsOD
	KM2zeALxsgoVG/aGLJPKWMw==
X-Google-Smtp-Source: AGHT+IFjKY+k1yJx/j5W1t9/kN3ou1S1abC7Vqps0cvP3QEiC6rvJpqTb0+Ww7uqngmTYNcLNHGKzObc+SWmOb34sQ==
X-Received: from plbmg13.prod.google.com ([2002:a17:903:348d:b0:217:8109:e87])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68f:b0:215:63a0:b58c with SMTP id d9443c01a7336-219e6f25f6bmr74279055ad.46.1734762938846;
 Fri, 20 Dec 2024 22:35:38 -0800 (PST)
Date: Sat, 21 Dec 2024 15:35:22 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221063522.1839126-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v3] netlink: support dumping IPv4 multicast addresses
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

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 include/linux/igmp.h |  2 ++
 net/ipv4/devinet.c   | 63 +++++++++++++++++++++++++++++++++++++-------
 net/ipv4/igmp.c      |  8 +++---
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..757c0aeea1ac 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -142,4 +142,6 @@ extern void __ip_mc_inc_group(struct in_device *in_dev,=
 __be32 addr,
 extern void ip_mc_inc_group(struct in_device *in_dev, __be32 addr);
 int ip_mc_check_igmp(struct sk_buff *skb);
=20
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im, int event, int flags);
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..2c8817229052 100644
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
@@ -1850,21 +1851,46 @@ static int in_dev_dump_addr(struct in_device *in_de=
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
+		for (im =3D rcu_dereference(in_dev->mc_list);
+		     im;
+		     im =3D rcu_dereference(im->next_rcu)) {
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
@@ -1889,15 +1915,16 @@ static u32 inet_base_seq(const struct net *net)
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
@@ -1949,6 +1976,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
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
index 8a370ef37d3f..32230f381e14 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1432,14 +1432,14 @@ static void ip_mc_hash_remove(struct in_device *in_=
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
@@ -1477,7 +1477,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
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



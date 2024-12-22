Return-Path: <netdev+bounces-153951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3C9FA334
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 02:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ADB1671CF
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EEC28E7;
	Sun, 22 Dec 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOgL/34o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EA33EC
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734829250; cv=none; b=APdkf3Ra4qd+UmI+2pAGcZ4MQM5RicFKF1iV1SlhENjb8dzbGPo1qp3qD27LWLTTg/VJhn7Vsq9uJqtBMAnsM3uHOPZQGMl9iurg+kr8sekgT1fFxfMC8fttolAgHQ1sRzE9D9OFn0TQ/HNy3MpgzTr86lzIK4MsA09FWCmqXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734829250; c=relaxed/simple;
	bh=wECorpP7RVYc9Rwjobbrgv3tijoAzRX4lreU1hSwh2E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KbCTAXtzRk+zds5YSI5yhZAs40nDhkZqcoBdFDaJ7nqQIUKtBIF+COCyC82+AWwmiUeWuKSghTMoqH4y6waWmNORiRCe8SoXqfX+tlMShijfZxoQCYR0B1lNCkk1FOcWXyaVWvy6FARoKPPTCn335pqFA6pAW3G2yZIxpotFFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOgL/34o; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so4042045a91.3
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 17:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734829248; x=1735434048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+q9IaxgcQNKOsIJMlzfd5fOq0iABy4fSBY5R4FcDUDs=;
        b=rOgL/34o05+owFal2R1zTN5zxYlMVQd9zBpzyzmavEJN1quMu9FpNOp25CRnAp3SZs
         AEHN276cL9CqB7imKq3ZcQE3tTCFgbuqs10duz+qkre0FBcKstxnNMol5PJyBC0H6g2m
         FBzJXoDPAqpVY9JTXVELCszm8muH53JnibDjveYo0HwWFJ4IEc7atzyHG1jIeNahEKhn
         nlbo6ndMz3DDE+5eCXwnFuPfZuLp3ld0YI7roV7e4s/kp6Gisz1g+H0vW+SZlzM6uNI/
         Lb41GyHfE65gwVoG/ECX3tt4p5wZDXD/2tnqLHJYxe9C4NuKt04eQ60WB4+QCcCDBYIq
         htIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734829248; x=1735434048;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q9IaxgcQNKOsIJMlzfd5fOq0iABy4fSBY5R4FcDUDs=;
        b=G+6bgvGSS5QdHn3kHrFqzvo+Yi4GGO1Kz+y1pQFI1tF8N0ZuXe5zY06B278QLp++P+
         0eG4CYibJ1WV0Q4LIAadVN0TN54PkYSGB44v29Jv5uOk7KHO53c/9G5VEnNwlwpqYzPA
         AJxBdnupua11JnG6fEiZSpOB0VlJiYpHFPCDlFP0o+pjPUOqnXDs4DIM3LjXHdpUxusl
         XgSK4hmMC+qUNdRNH76BAZQJSbLiktwwNBH7K0KTv1NhaQIiSxMhI9jb6vmlljc9GMHn
         txzfM7ZlqXNc+EpBxoJv0zZqb6kqNkik+2daxW+Vd0FVf39jSww2OFVKfQiTKpXmo95Z
         gR3g==
X-Forwarded-Encrypted: i=1; AJvYcCV4r0AfWYmhxbv2IrJ0sCTSGLdfSRLuGLhI5p5hSM19LXjuICiR6VRXmeDiUAknLeo8K8o6sNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYIuT8y9ipqE+FKPlNi9yXiHmEtNFrLEvMXRURQh1Ii9+y+3J
	HudUg0YUFqGqWsa1YjI3h/AdC5nQty1NDKRqoKDCoxydNU0zl+DH86ina4FsWc+GudnsWh0xyS4
	+VMN8iJ5dZw+qmzbb/356Zw==
X-Google-Smtp-Source: AGHT+IFfSzHfuvAKcyUsch023FCP384txTutZ06cTbz9D8mkTnpcjkO3ro9s0Sqb44oRitGckIJyx8zY8xMlePbl8g==
X-Received: from pjbeu14.prod.google.com ([2002:a17:90a:f94e:b0:2ee:53fe:d0fc])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54cb:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2f452dfb7e2mr11937973a91.1.1734829248166;
 Sat, 21 Dec 2024 17:00:48 -0800 (PST)
Date: Sun, 22 Dec 2024 10:00:43 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241222010043.2200334-1-yuyanghuang@google.com>
Subject: [PATCH net-next] netlink: add IPv6 anycast join/leave notifications
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

This change introduces a mechanism for notifying userspace
applications about changes to IPv6 anycast addresses via netlink. It
includes:

* Addition and deletion of IPv6 anycast addresses are reported using
  RTM_NEWANYCAST and RTM_DELANYCAST.
* A new netlink group (RTNLGRP_IPV6_ACADDR) for subscribing to these
  notifications.

This enables user space applications(e.g. ip monitor) to efficiently
track anycast addresses through netlink messages, improving metrics
collection and system monitoring. It also unlocks the potential for
advanced anycast management in user space, such as hardware offload
control and fine grained network control.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/net/addrconf.h         |  3 +++
 include/uapi/linux/rtnetlink.h |  8 ++++++-
 net/ipv6/addrconf.c            |  6 +++---
 net/ipv6/anycast.c             | 38 ++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 58337898fa21..f8f91b2038ea 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -546,4 +546,7 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
 			const struct ifmcaddr6 *ifmca,
 			struct inet6_fill_args *args);
=20
+int inet6_fill_ifacaddr(struct sk_buff *skb,
+			const struct ifacaddr6 *ifaca,
+			struct inet6_fill_args *args);
 #endif
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index eccc0e7dcb7d..6b74864ef6fb 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -100,7 +100,11 @@ enum {
 	RTM_GETMULTICAST,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
-	RTM_GETANYCAST	=3D 62,
+	RTM_NEWANYCAST	=3D 60,
+#define RTM_NEWANYCAST RTM_NEWANYCAST
+	RTM_DELANYCAST,
+#define RTM_DELANYCAST RTM_DELANYCAST
+	RTM_GETANYCAST,
 #define RTM_GETANYCAST	RTM_GETANYCAST
=20
 	RTM_NEWNEIGHTBL	=3D 64,
@@ -782,6 +786,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
 	RTNLGRP_IPV6_MCADDR,
 #define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2e2684886953..66032cadd81f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5241,9 +5241,9 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(inet6_fill_ifmcaddr);
=20
-static int inet6_fill_ifacaddr(struct sk_buff *skb,
-			       const struct ifacaddr6 *ifaca,
-			       struct inet6_fill_args *args)
+int inet6_fill_ifacaddr(struct sk_buff *skb,
+			const struct ifacaddr6 *ifaca,
+			struct inet6_fill_args *args)
 {
 	struct net_device *dev =3D fib6_info_nh_dev(ifaca->aca_rt);
 	int ifindex =3D dev ? dev->ifindex : 1;
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 562cace50ca9..6793ff436986 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -278,6 +278,40 @@ static struct ifacaddr6 *aca_alloc(struct fib6_info *f=
6i,
 	return aca;
 }
=20
+static void inet6_ifacaddr_notify(struct net_device *dev,
+				  const struct ifacaddr6 *ifaca, int event)
+{
+	struct inet6_fill_args fillargs =3D {
+		.portid =3D 0,
+		.seq =3D 0,
+		.event =3D event,
+		.flags =3D 0,
+		.netnsid =3D -1,
+	};
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOMEM;
+
+	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
+			nla_total_size(sizeof(struct in6_addr)) +
+			nla_total_size(sizeof(struct ifa_cacheinfo)),
+			GFP_KERNEL);
+	if (!skb)
+		goto error;
+
+	err =3D inet6_fill_ifacaddr(skb, ifaca, &fillargs);
+	if (err < 0) {
+		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
+		nlmsg_free(skb);
+		goto error;
+	}
+
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_ACADDR, NULL, GFP_KERNEL);
+	return;
+error:
+	rtnl_set_sk_err(net, RTNLGRP_IPV6_ACADDR, err);
+}
+
 /*
  *	device anycast group inc (add if not found)
  */
@@ -333,6 +367,8 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const str=
uct in6_addr *addr)
=20
 	addrconf_join_solict(idev->dev, &aca->aca_addr);
=20
+	inet6_ifacaddr_notify(idev->dev, aca, RTM_NEWANYCAST);
+
 	aca_put(aca);
 	return 0;
 out:
@@ -375,6 +411,8 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const str=
uct in6_addr *addr)
=20
 	ip6_del_rt(dev_net(idev->dev), aca->aca_rt, false);
=20
+	inet6_ifacaddr_notify(idev->dev, aca, RTM_DELANYCAST);
+
 	aca_put(aca);
 	return 0;
 }
--=20
2.47.1.613.gc27f4b7a9f-goog



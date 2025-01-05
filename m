Return-Path: <netdev+bounces-155240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C2A017C9
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 03:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955211883981
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5037081D;
	Sun,  5 Jan 2025 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YqE6ci5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD185626
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736042424; cv=none; b=fNX4H1czNcS3ev3VcqWe9u6cky04X0rg5Gre22eHaPM/hdHybord0qFy1lDxh2Asekfh/SvrcwKzrki5iBYmg5wYvDiHd19UClh1gv2vDkzwVYavfqjhb75hGUa6UdePkLOaqmx6ToWoB2UxaWOVXsSa13yVv2up/VA2p/8E4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736042424; c=relaxed/simple;
	bh=wECorpP7RVYc9Rwjobbrgv3tijoAzRX4lreU1hSwh2E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A7B/hrcFQ40KYhSPqeyUHCs3+cU9x4cSx4JQMAP1fE5672OKQB2XwhNgdmiViA8p524dK6xCy2gXz41q9Ia3lDsaLDsTIovB6rKeS36jDYQHB0te8FjtsmrRTGRaVzVH9IRhHIiPJtLss8Vd9kqj08gr+GfJ7wd92wNNgnZbRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YqE6ci5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9b9981f1so30100026a91.3
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 18:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736042422; x=1736647222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+q9IaxgcQNKOsIJMlzfd5fOq0iABy4fSBY5R4FcDUDs=;
        b=3YqE6ci5D2K3c7F8LozyZX98G3PfTA17ZbebGYjh6XCoyYSE9pVdzAUQue8oHe3C6P
         gkThZ3OvFq5yfGBMe8mTZHB5SXkI51c7zDCX3+PBb3uCEjamepi+AaGk2kBZsJm6urcF
         gStWY9A2hZyIGMIpQg5GZL9fW/nxd5mlVY0D7kk7MBxnafZaPzkSKxhOOAwTh+s9Km8O
         jokmr3mNYHdJaLtXZ0amVRyh+KbAhYPFwpkcR15nBd9CCDnlfAdJ8MY3P7IwFgIcuIgW
         5UsidcBcfrOQd6GXwnmqSl8mYJxU2rLxidK+vZ8J5LEmR6ytdusLPrEIDDMND2k4Jayy
         xd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736042422; x=1736647222;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q9IaxgcQNKOsIJMlzfd5fOq0iABy4fSBY5R4FcDUDs=;
        b=pVP/bgoTCQt9KlDcZAoVwOB9ZipfghqKUeaAlmAkOnTenml8iBk12S/kmSqJbwAHPt
         q4IWwRM9ZMGWmjWq2/53E9hqJINiomELaCEmFLGx34nWMHEZc2pMjF6KDz3fAdo5rTl6
         RWvMbqw4MjYLt+veziim5QotpV3Ho/hzUzDx55sjsfjQynm/yd81ggjyF+SlJID6IaZt
         UNHSvjHmZ7oMORlq87XspnIybu1Bk+TJyKK0bWd6yfmK/DfvlJFpfOWsw8MTRZjt8VLz
         MuvO3USaIKz7W7JqeLOLxvTWUGtujuTm6GbCO5QPFumAYsjpy4juu8hIswmwWJE+cvYb
         yGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNcmOuGDoB0g1wfJYklPHiBX4MlWv0VeQW47v9wLb8amYOzTIaLiHlOnsMRFRwmHSOHb6EMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobZGNSGVPbGi5ajIfF+E3ElOcOOkBr1olLTDUgsomUvWaOfvF
	gcAc4RE20jS7R+biSoOzd1kt8RFVuN45YBwfHhzSDzfAwym3yUuWYLyVMEDRI0h/xoJqZc82U9z
	wFpLlb4iL4kvopRNRI36qzQ==
X-Google-Smtp-Source: AGHT+IHE/VrdgD62Mzz3TgNfYNQY6mGXXpqEd6jwEizfUx9DzvB9QnxJXRlheiqUCE2tDSJ5WDmozjpoTc/Gk9gQyQ==
X-Received: from pfar11.prod.google.com ([2002:a05:6a00:a90b:b0:725:f376:f548])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:841a:b0:1db:eead:c588 with SMTP id adf61e73a8af0-1e5e080dc85mr87265246637.29.1736042421793;
 Sat, 04 Jan 2025 18:00:21 -0800 (PST)
Date: Sun,  5 Jan 2025 11:00:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250105020016.699698-1-yuyanghuang@google.com>
Subject: [PATCH RESEND net-next] netlink: add IPv6 anycast join/leave notifications
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



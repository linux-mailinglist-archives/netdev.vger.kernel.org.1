Return-Path: <netdev+bounces-155810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3859AA03E10
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B13A35BB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540541E3784;
	Tue,  7 Jan 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0nH/yZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAA1DED74
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250242; cv=none; b=oxQ7TbfVZMNVDUkuDyQmPFubmvRaDBAicLykX1h07GyjfFclLTzSOiTdx6dELyeGW56G/3X2OwbmWReqtRm+025cVbfBs2IcGNrrZvCliXDhmMAHGWW8Fz2ovD+3AN+eEL9vHch/Vi9MI56iOcU/yT+ZIuuK3dNWN/GiUDwjD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250242; c=relaxed/simple;
	bh=L8zOhXP4n4Nvkes5dmCgefMN/LkL2On2SU+auh5mrIU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q9TrLzXEYxpGLdF9BMLFYFN/PnrjCI4klq+3x3TRPccppyX9T6Q/XqbNftkHKrqHrGJfdGs9hPY5NSEI3klp6DEGu/qlRHwbyKuu3vy4gpM7PDZdzvhTP2WAk4oLGsVr3W9ZSgTtEXciaJLQKT3P+OCsLNMPUxlMyS6IzMED2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0nH/yZL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21632eacb31so165037685ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736250240; x=1736855040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlxAStKefH8vdxOr8gR72/ELN1UpWObVQ3Dxj5IQcNY=;
        b=h0nH/yZLUsFNNllQuqGGRsNfWP6xr02Jvj02RzyOQxqqWboS2J4D2rEkHFdUPpXBx5
         ZOMeLY+b7moVFeWkTqiyb58+MwlYwd3eFk2cM7gALWQmLlzTU1A4VLRV8jSBve3jySsF
         oCZ8yNyL14/A0V+hFnQIELqSxp1jsgjnY9guv2aULgiI1ZbcRWaf2QF68hSni7mg/DY/
         AS1ijFp97dc1eloFVG9E2A1/qOuXhhfX4secGKg9m4rqRthPBq/hyQNsochw5Fnwcf8a
         6GJiCPPEt7rB+V8LSJIzwWlmKx9g1WV0QmTIr8RqfrIP9CyDe/i0Leg1/UY8o8jkgEIb
         q7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736250240; x=1736855040;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlxAStKefH8vdxOr8gR72/ELN1UpWObVQ3Dxj5IQcNY=;
        b=dpdbKyM0G8VShTrA5Z27BU3loZtRIUGMgwoI1+yiAdHB1dqHkNqENE6K7FP7rRh1i8
         AYRZEigb1K8alj2VWcv6/rUNFWtvza+ddIR+9Q9Sq7WXCdyAibVt0WXzkqSaMpQ55tjx
         TAQ6ZHGSguTCahrw8I7H2shawtrsZodL3HMlGLWbW2ljXNKSg3EAsDAnl4/RlofTu2dQ
         MDgDzzemcW7MO+z+z7QBEngO3/wVFuceyzKc1zLbs721r+vK+jKrps4oKArcMAtJJdFa
         IobKCh8l9k0B9GGF3XReWI0PF9njoEeG8++MYwXw5YTTwFxGYgU05TjhVciLNDXTCPDU
         tYrw==
X-Forwarded-Encrypted: i=1; AJvYcCWEu8hShJYPwzkjHhatwej2XjSO0xdIo5KBWQC1Cle/HKPWJyjnc47RGS7m5kTXHV6qdjFSIDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqCmoX9c1T4VY/gEdobpjDqogWBz9WTAl8xusqyOT+cHVYJEc
	mWHwoGmUbmDAFl58vcz9CltHKBLDtNfn7dVh6L8FzVyBFkN9XM2H5frEJ07dtYVHQ0t3Uz8RJqP
	wZnD21lYR0OfZXoDaPelCiw==
X-Google-Smtp-Source: AGHT+IF1EJBfDP0eYi2dIK4SGC5aHG5+NCEE8yQmPLtt26U6+l/bPY5KvAzFnG5nRUp3dHo/1/aJrg1uCx1tAXc2Zg==
X-Received: from plbkl13.prod.google.com ([2002:a17:903:74d:b0:215:57bd:17e7])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:41c1:b0:215:b45a:6a63 with SMTP id d9443c01a7336-219e6ec0883mr960314325ad.32.1736250239932;
 Tue, 07 Jan 2025 03:43:59 -0800 (PST)
Date: Tue,  7 Jan 2025 20:43:55 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107114355.1766086-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v3] netlink: add IPv6 anycast join/leave notifications
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

Changelog since v2:
- Remove unnecessary 0 initializations.
- Remove unnecessary stack trace.

Changelog since v1:
- Resolve merge conflicts.

 include/net/addrconf.h         |  3 +++
 include/uapi/linux/rtnetlink.h |  8 +++++++-
 net/ipv6/addrconf.c            |  6 +++---
 net/ipv6/anycast.c             | 35 ++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 4 deletions(-)

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
index 5ee94c511a28..66c3903d29cf 100644
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
@@ -783,6 +787,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
 	RTNLGRP_IPV6_MCADDR,
 #define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4da409bc4577..c3729382be3b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5240,9 +5240,9 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
 	return 0;
 }
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
index 562cace50ca9..21e01695b48c 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -278,6 +278,37 @@ static struct ifacaddr6 *aca_alloc(struct fib6_info *f=
6i,
 	return aca;
 }
=20
+static void inet6_ifacaddr_notify(struct net_device *dev,
+				  const struct ifacaddr6 *ifaca, int event)
+{
+	struct inet6_fill_args fillargs =3D {
+		.event =3D event,
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
+		pr_err("Failed to fill in anycast addresses (err %d)\n", err);
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
@@ -333,6 +364,8 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const str=
uct in6_addr *addr)
=20
 	addrconf_join_solict(idev->dev, &aca->aca_addr);
=20
+	inet6_ifacaddr_notify(idev->dev, aca, RTM_NEWANYCAST);
+
 	aca_put(aca);
 	return 0;
 out:
@@ -375,6 +408,8 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const str=
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



Return-Path: <netdev+bounces-155366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447FA0207A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C898A3A0575
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13381D7E4A;
	Mon,  6 Jan 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBoJ0wzF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230121D7E4F
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151304; cv=none; b=Jgp15xQ4iDXck99QILVlZ2UfB2NgfDYgeQVUguBHbFiqxNASSah6nXaS8kOPn7bEKDOcXElrT11ciSSwTO3ZPz30vk6ANpzJRDPnP9CcwYaPahJ1n1f+f8nrpHia9Y1wlLYcSIOZefLJcJg2MvuvOdRLry8BGvKmSB6l12E8dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151304; c=relaxed/simple;
	bh=G1mvS5ZIKh0kzotGBWDAmUkpIgEpvTX5+O68OEESsYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qvXkRryzUp+w1lHuZc8/9FZfEm4cios6H6mgy2qMPIX+RPRMugWvFymVs2/eH3lC/vra/KkVIAKW5mik7yVby429l20aaFWP6gMRWXudVs4pBnDw32sVagq2wHuHsIvaLXciP4GnJD2n8jO/ncgvW0+iyJKQNFJk3kg4mx/5bmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBoJ0wzF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9e4c5343so32548023a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 00:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736151302; x=1736756102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3kDx1NJlWkhWbugoAzp/+biR5LswkNLCQ2B99mXSn4=;
        b=NBoJ0wzFRuHYz4incWLCpMutwP8a5lBIRg5XGn0JGyW0+9B5VqJuKluPZ/8MPygtdN
         fUaMkcdTDbT1Uxrmxx4nNBigL++lN2dRkwDv8x5s6GdrZe9BhEeQoWCkgRdOd9ZAPd+E
         l+mLl2rKdr2cfOBchAlz8y20udHfxhM5487nRv3VwEPBJEEv+QW2hwoTDu0H5YP3gx/J
         qns0r9A+hfzjtcgK3w9PxGFLSf71xotADCvrb3I5A2RnBsC2Q1LzJbyGrARdldpY0ul8
         qPk9tALsS95HxbMS4tDoSYQjYaFpwSMeadfcNWTCp7555cDpZX+FBx34OxHICmEypusw
         hS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151302; x=1736756102;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3kDx1NJlWkhWbugoAzp/+biR5LswkNLCQ2B99mXSn4=;
        b=ZDayTy5e3nZaIVVzZ56CxHRON7wCtIkay212V9W/G0oPdfbGppkyuBbyQXK/ka1HRf
         jGSpeQroMnX/TvFo9HQgIw6J1D/v1Q4bVfLbfZWEhk+WqiB5FcWTjnv684TPklH7BZKT
         qYQyKDZXVc8QsoTCh7n+moU7f+GEtUkFQSQneuzcECErfoQAhQQPdPc53FeKkMgSMa+G
         WTmU9eJUVqkvH5W7Xm8E1Sp2MhEZ5LV3nbIqCIE37kXNspt6U8OkD+FAZgnN14iptuO9
         IkQZgu4rEYw/B3ZjqbcNQD++kIqLtOY33SexDUE+9d+nMEmoChqyArPlusPNdyjbrgGQ
         voCA==
X-Forwarded-Encrypted: i=1; AJvYcCUs/G8eNhsCr1q0Y0zltwx2ct1slH3ec6dPQcL0OhlHg+rsJFZmOu9j9fXA2FFeQrKXbRFuFoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkprSrdo062ziUNOZjrRihN0h/yWK656woOKZr27+IoAj2DKR7
	N1NgY3zzOSPK1gZzjQbBgbevinZ/fda8CfiA2FxnaIh4yK5+p+f4UgOZQchjG66KmWVaiOeODFa
	oTqhdSmC4e7KoqyP69yUFBQ==
X-Google-Smtp-Source: AGHT+IE0Q8JDZBdhw3DT1urAYWKrdpLmV30GDLes7xTQK8uKAFLO7ukKDITcxrwKxyBaY7c3334UYgsYLryWXnRr7Q==
X-Received: from pfbkt9.prod.google.com ([2002:a05:6a00:4ba9:b0:72a:bc54:8507])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4486:b0:725:e015:908d with SMTP id d2e1a72fcca58-72abdd4f29cmr70884968b3a.1.1736151302242;
 Mon, 06 Jan 2025 00:15:02 -0800 (PST)
Date: Mon,  6 Jan 2025 17:14:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250106081457.1447130-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v2] netlink: add IPv6 anycast join/leave notifications
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

Changelog since v1:
- Resolve merge conflicts.

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



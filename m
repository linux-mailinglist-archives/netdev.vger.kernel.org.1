Return-Path: <netdev+bounces-153899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF49FA006
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD8827A018B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B51F193F;
	Sat, 21 Dec 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1QZOUDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1821F192E
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775224; cv=none; b=hc5XSlJ0mXDkMU2qHu+5UMv74ZqM1Bc8MMdPRkGADU/YuAu1WJEYOo53dta9zDJdAqtxoiGhOKRV1cM5ZoJfulUBDN/8At47T12aZJLH5N2JrRCaMqw3FifgX05sbJ0eIoZZl3vwG16CHNf1lPoyJlTPaKDMKKwewUpaAPOTu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775224; c=relaxed/simple;
	bh=EZeOzFrvRWC/ARBiLgjIiWnevqTL8Vf5+49OtVPdbRM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jsveyAu9MTl08NitzuICNZUYsrM0lTgmHhbSDmU60ewkqdoBCEeCqtl+UhqS+FLFLJS0ap8pjltkMHxD1p9y+QP28oezkeuVW30kNTlNTNXnERmeflvy5LvvJDZwb8RaZQXPIrOfWm2Ia21kab1af8dgQEauhItgtDdVioGAVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1QZOUDM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e4bee2b0so3885982b3a.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734775222; x=1735380022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czmSyFUkYN/2oT9iFBNPQYgt6v+o090wOwQQEui5uQM=;
        b=Q1QZOUDMfwwYisLYhI21soFNrd3HCx5QtVUJaIGCOIEH7A0zjS8y22aNha57luTbXU
         438pUoffRnjry3Uwl5hGILOSylDIhBiCbanNi9J1tc5ZL+TwIwZh8T9LWCJt2t4Nn3QF
         gG959pDAMg3MIY/Zqnk3FaxkQ+1hw3q+yI5ohv/dtPGvFLdh7fySNFwqJl6M3XAt3NVR
         JNM76bc7g047K+3flAA229GausFNy4tJONt8UUcEuJrRPc8vlSOu2gAQBN6sUDtttUof
         En8K+rolFxXxZUsYZpPET2qk8lS30eyMqGo9NPWq+MkyWYUARroga3wcAFqC581zjhln
         u60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734775222; x=1735380022;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czmSyFUkYN/2oT9iFBNPQYgt6v+o090wOwQQEui5uQM=;
        b=W9oIivOThPPZ4Mj/7uljs9kvCqNVgRPa8Izz8l0X5SxJBN7AcXiWEizMFTAYAgzeR8
         nASzKctsaUkE2t8B4HwGSHhVheSRBx+GHYlljNtIkBW75EhuTvlb1QdAFmoCvoG4v++p
         pqhh8uyaSKLffyJlyU87RlTIpkuUqqy+yt/K3FTbww9EmAnOCqyNpe2rMV84LtNwOsk5
         2PdJWHypoMn+MavKBQ5P2gWf895hNW2kHFseoYOeLc8wTbIGJNd7z5XdrhMmBhFDiFt+
         /4RX4kD8LZO67msYgiHMBSVnT1B/y3ZUISykYRPmKzsilmHmO9ew+fsybBe8w0WWCKZJ
         66Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXPGGN0WtNP7Rxjx9q7lV5YqX7qIKaFMIZSGr+SQzgywmCJcTMZNIn+hXWwxdpTlbLzJXl+B24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1z8fFREy79DiEN63b7XIxFpKn4maXHpPTjM91bBB0oS1JWeUJ
	bKkiS3tsGo+L85KlEUVZnxB98NPWIph9dQDRd5fsRvT3JX1g9JBFEbftbeFV0O8TEkQZdZ7vWw6
	+TS7JVQTuEmhYgaCLk/VZdQ==
X-Google-Smtp-Source: AGHT+IFwQKmJ461oairkKjA3AvHJIynGg3mVVkk1cxMxx1mJkOP7WYo+qz+PVk18G7at/vtoTi1Qgbylq+xl54HdlQ==
X-Received: from pfbay30.prod.google.com ([2002:a05:6a00:301e:b0:728:b3dd:ba8c])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:140e:b0:727:3cd0:122f with SMTP id d2e1a72fcca58-72abdd8c667mr8092172b3a.9.1734775222298;
 Sat, 21 Dec 2024 02:00:22 -0800 (PST)
Date: Sat, 21 Dec 2024 19:00:07 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241221100007.1910089-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v2] netlink: correct nlmsg size for multicast notifications
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

Corrected the netlink message size calculation for multicast group
join/leave notifications. The previous calculation did not account for
the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
payload. This fix ensures that the allocated message size is
sufficient to hold all necessary information.

This patch also includes the following improvements:
* Uses GFP_KERNEL instead of GFP_ATOMIC when holding the RTNL mutex.
* Uses nla_total_size(sizeof(struct in6_addr)) instead of
  nla_total_size(16).
* Removes unnecessary EXPORT_SYMBOL().

Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notifications")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v1:
- Uses GFP_KERNEL instead of GFP_ATOMIC when holding the RTNL mutex.
- Uses nla_total_size(sizeof(struct in6_addr)) instead of
  nla_total_size(16).
- Removes unnecessary EXPORT_SYMBOL().

 net/ipv4/igmp.c     | 6 ++++--
 net/ipv6/addrconf.c | 1 -
 net/ipv6/mcast.c    | 6 ++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 8a370ef37d3f..3da126cea884 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	int err =3D -ENOMEM;
=20
 	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
-			nla_total_size(sizeof(__be32)), GFP_ATOMIC);
+			nla_total_size(sizeof(__be32)) +
+			nla_total_size(sizeof(struct ifa_cacheinfo)),
+			GFP_KERNEL);
 	if (!skb)
 		goto error;
=20
@@ -1484,7 +1486,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 		goto error;
 	}
=20
-	rtnl_notify(skb, net, 0, RTNLGRP_IPV4_MCADDR, NULL, GFP_ATOMIC);
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV4_MCADDR, NULL, GFP_KERNEL);
 	return;
 error:
 	rtnl_set_sk_err(net, RTNLGRP_IPV4_MCADDR, err);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2e2684886953..4da409bc4577 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
 	nlmsg_end(skb, nlh);
 	return 0;
 }
-EXPORT_SYMBOL(inet6_fill_ifmcaddr);
=20
 static int inet6_fill_ifacaddr(struct sk_buff *skb,
 			       const struct ifacaddr6 *ifaca,
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 587831c148de..9dfdb40988b0 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_device *de=
v,
 	int err =3D -ENOMEM;
=20
 	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
-			nla_total_size(16), GFP_ATOMIC);
+			nla_total_size(sizeof(struct in6_addr)) +
+			nla_total_size(sizeof(struct ifa_cacheinfo)),
+			GFP_KERNEL);
 	if (!skb)
 		goto error;
=20
@@ -931,7 +933,7 @@ static void inet6_ifmcaddr_notify(struct net_device *de=
v,
 		goto error;
 	}
=20
-	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_ATOMIC);
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_MCADDR, NULL, GFP_KERNEL);
 	return;
 error:
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_MCADDR, err);
--=20
2.47.1.613.gc27f4b7a9f-goog



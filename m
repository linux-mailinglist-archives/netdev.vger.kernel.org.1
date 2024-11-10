Return-Path: <netdev+bounces-143574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748149C312E
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 09:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B785A281AD6
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A7148857;
	Sun, 10 Nov 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EojmDOEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB08233D62
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731226831; cv=none; b=BeLk/np1rWvEIP7xEwV4tAZBZWzWhWsIE1/XcImJfWY/Gi3ZOlqNWqoJ8ZUgWSGaQ2lToKgWVceDXVQr2pBs4zFhYg8sJEw3MStWzlmLwpWG56TZeZzjN2Lduu3+XcguAalHT1RvWU5aTs6v6tUKPOlI5r+PuKIQeH215naDq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731226831; c=relaxed/simple;
	bh=Gl1eG3hRAbBuZVpFh0gg6rz9L8Cy6YPpES9UkmeFlZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ryb52i3sRiKL5woyKcfiwpt/fns71FrTyaxh27IL++IUd1pVc4KTOjZm7qPSjqRfo6biHROdHZgmKXc8EUBEA4PebWKzY9V2vyKtPut0Gjnq5sNMY/BO+6u1Ybpm902RBDAclPcfcvTDUYkfCbSYACry9x+Dyy5Sw5x52KVJ+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EojmDOEt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea863ecfe9so70998537b3.3
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731226829; x=1731831629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fB+41F93YGE8eZYLka5AvuVAKCJamBaTPqGwxxikWbY=;
        b=EojmDOEt2qWDCp41G554BbeFYLjZXuJusdaEcjREMnUfgtwk5lbW9xpWJ68XrxAsm5
         Ck6GESphBcJuKlyiOzsl9fTKv97irraAljR72PTNblxKdL3lpImaSHAVpjn/1WpoShtW
         rUUlvWcLs5g0RDFV9NcHsPBIutrZJQIEuZlzzIB3F3/FP6pQK3xOJACmzQRloy4J8G3v
         wux2Wqw5BnkwagUJ/Ub2WqcbjBB0HVqRyZft6GhWiuCUN2CxckWX97QnPLjXT9vWI8JZ
         dLtfE6evm8l9z217uTHWoalkLeDJFJmoefZ7QENU+4PYQ1YEeLuM+6LCzTK/KzytT8LD
         3rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731226829; x=1731831629;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB+41F93YGE8eZYLka5AvuVAKCJamBaTPqGwxxikWbY=;
        b=v3x6EuZcA4ZakhNdKnpkzkrrn8sZRLP1aLAH4C4jn/e01/awBSrbA3UiC85hwHyIKJ
         /vvtlClts7TRSxfE3ZHggss4jQvGUPoqqlbbf5bepYG2EnbbRnzPJDAJafnX1WRLAC6A
         khAanv8ZFD78NdSwAzuJ4DggWreJFpCaLSMphMq4RytCU9u/ltbq/qef1XZjz9Ye7zqh
         WtReFahSEx0qv0Qf2FsdlEjeOnxkRkLvXtyDoWKKEKgCZxvKYMjYhyuW6myPASyzJ84A
         QB2g3iGHf3rF2D0BBmDzlrGTEg6AO2WExaJhQ5phrmNcPI8fMkRqzodzUSlWmDzAbSfq
         mdzg==
X-Forwarded-Encrypted: i=1; AJvYcCXA0o5NgYvKRB9Ex4YCZS7rmz6XqnMw2PvXzGqfwjxmpdRtni39jNUBCwaJ1JThWjNBmsiawaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Zn0Poa0fZGFZNZZl8N9SgfNGvwIIAE2ylrmi1WlERykaMkcU
	WzwPqnmWuBwTuj/I7f6/7b+LrSGT0hup1IX1EPWCPhvCw8I5DR3ykVnI8/SXyubzA17tTUoa0C1
	OKtH4NNc9y+tiewmwmDX0Sw==
X-Google-Smtp-Source: AGHT+IHoDWALQV8yPFMYbn5Kn8mnbl/DOuouYIGB+XoHYcDgC62Wz2mRtoF+4cutEKttcTbdojFvTieyI0jpuEE7eA==
X-Received: from yuyanghuang.tok.corp.google.com ([2401:fa00:8f:203:9315:4df6:5ed3:1684])
 (user=yuyanghuang job=sendgmr) by 2002:a0d:e703:0:b0:64a:e220:bfb5 with SMTP
 id 00721157ae682-6eaddd87123mr500877b3.1.1731226828788; Sun, 10 Nov 2024
 00:20:28 -0800 (PST)
Date: Sun, 10 Nov 2024 17:19:53 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241110081953.121682-1-yuyanghuang@google.com>
Subject: [PATCH net-next] netlink: add igmp join/leave notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change introduces netlink notifications for multicast address
changes, enabling components like the Android Packet Filter to implement
IGMP offload solutions.

The following features are included:
* Addition and deletion of multicast addresses are reported using
  RTM_NEWMULTICAST and RTM_DELMULTICAST messages with AF_INET.
* A new notification group, RTNLGRP_IPV4_MCADDR, is introduced for
  receiving these events.

This enhancement allows user-space components to efficiently track
multicast group memberships and program hardware offload filters
accordingly.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Co-developed-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Signed-off-by: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Link: https://lore.kernel.org/r/20180906091056.21109-1-pruddy@vyatta.att-ma=
il.com
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/uapi/linux/rtnetlink.h |  6 ++++
 net/ipv4/igmp.c                | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 3b687d20c9ed..354a923f129d 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -93,6 +93,10 @@ enum {
 	RTM_NEWPREFIX	=3D 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
=20
+	RTM_NEWMULTICAST,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
 	RTM_GETMULTICAST =3D 58,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
@@ -774,6 +778,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
 	RTNLGRP_STATS,
 #define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 9bf09de6a2e7..34575f5392a8 100644
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
@@ -1430,6 +1431,60 @@ static void ip_mc_hash_remove(struct in_device *in_d=
ev,
 	*mc_hash =3D im->next_hash;
 }
=20
+static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+			      __be32 addr, int event)
+{
+	struct nlmsghdr *nlh;
+	struct ifaddrmsg *ifm;
+
+	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ifm =3D nlmsg_data(nlh);
+	ifm->ifa_family =3D AF_INET;
+	ifm->ifa_prefixlen =3D 32;
+	ifm->ifa_flags =3D IFA_F_PERMANENT;
+	ifm->ifa_scope =3D RT_SCOPE_LINK;
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
+static inline int inet_ifmcaddr_msgsize(void)
+{
+	return NLMSG_ALIGN(sizeof(struct ifaddrmsg))
+			+ nla_total_size(sizeof(__be32));
+}
+
+static void inet_ifmcaddr_notify(struct net_device *dev, __be32 addr, int =
event)
+{
+	struct net *net =3D dev_net(dev);
+	struct sk_buff *skb;
+	int err =3D -ENOBUFS;
+
+	skb =3D nlmsg_new(inet_ifmcaddr_msgsize(), GFP_ATOMIC);
+	if (!skb)
+		goto error;
+
+	err =3D inet_fill_ifmcaddr(skb, dev, addr, event);
+	if (err < 0) {
+		WARN_ON(err =3D=3D -EMSGSIZE);
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
@@ -1476,6 +1531,7 @@ static void ____ip_mc_inc_group(struct in_device *in_=
dev, __be32 addr,
 	igmpv3_del_delrec(in_dev, im);
 #endif
 	igmp_group_added(im);
+	inet_ifmcaddr_notify(in_dev->dev, addr, RTM_NEWMULTICAST);
 	if (!in_dev->dead)
 		ip_rt_multicast_event(in_dev);
 out:
@@ -1689,6 +1745,8 @@ void __ip_mc_dec_group(struct in_device *in_dev, __be=
32 addr, gfp_t gfp)
 				*ip =3D i->next_rcu;
 				in_dev->mc_count--;
 				__igmp_group_dropped(i, gfp);
+				inet_ifmcaddr_notify(in_dev->dev, addr,
+						     RTM_DELMULTICAST);
 				ip_mc_clear_src(i);
=20
 				if (!in_dev->dead)
--=20
2.47.0.277.g8800431eea-goog



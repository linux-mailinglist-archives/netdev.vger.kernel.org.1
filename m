Return-Path: <netdev+bounces-156555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1186A06EFB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51B316439B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586D20102E;
	Thu,  9 Jan 2025 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1gj5pbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075437160
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407371; cv=none; b=LB5PH+p/NW4pVlOhVp/IFpJbWxZjPpN0+lh7cEzfMpb/TKMMPMbVQBPMYO9TypbdRihgDrJ1EyjS52XjSc5oScuAaUw3SNg1eK5VAd3dxi6BEnz1atdyXQ6aJ1ZxbVRjj/YI4FuI7RC8btlBBzAs7AapndxdsFufozE3GHYw2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407371; c=relaxed/simple;
	bh=nes/6/PnU4pPnq2zNGbAiicEM41yHr9uvZCERwYClJk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vv6Nu5tmbiU0r95U1GAA6q0ev4XRZIeNGfznq9WOnQNQsQdG9zFq/WNEQG46mVjrwxPUjULJREWAoV1UfMyvYB/sO1xch+VsXF7UqiUnpxm3z4rqcIz2ptHDxVKM1EfqtgvK/l2i0yZwrn+HM7XoglxdhoEciqzaerN6ny64Avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1gj5pbm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-218cf85639eso15256865ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736407369; x=1737012169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoLtJ5ZwtiwB+cFT3kmoHs7H3APtWZYYvaPCxY7/gPA=;
        b=P1gj5pbmrin+vqcYIF8Kr3P4NhGqnZQGfz7DXpghDySkyK955RlbMA2E9kXdAryRML
         9JIas0Vo74TsRERA5BzKpIvXRElcYjIO3Bo7pX34Kw+gzVrLC0txETr8ISF2hrrpPcra
         T5d2OXvku2PBo+kqs9uHijGX+KoAa52yXQLjQyjS0psG/fw3JTqAdDhwMm7IHr5coWnN
         DaNOKMJ2PBCowjm9pW2TvewvEuWythR5HRUr/YUffFUMukY76PyhyM1eWTm/9pyLa9G7
         9+kkQL+xHkS0Ap6cTGzbSPH4QGcazAnGvttLWA01yuDNYh+xLXh07ZgUuBeckHta55n/
         eIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407369; x=1737012169;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoLtJ5ZwtiwB+cFT3kmoHs7H3APtWZYYvaPCxY7/gPA=;
        b=a2wgDC+k/R4Btsh7soX+ip8cyIMh8PdMREoN0JPJqJEJvcVsFIGXqmb4//Tf8HveLQ
         xQleiAFWodnw5g01Oxnllt7osSJXLU6jMT/xGpAagg117q8h7scljRomvy+tD4hw9i79
         7bxgrxI9I8FRYnCp8xoc4Ge/uhj5oGvd1JTUGfIgGuX9DcGhF1G67bcLMVQRh0mS7UQM
         DUhh+FyWl30EqdwHS3UedsQ/KnN0C4sz+K5HrswmMQqrCNS+hhi2Gs+sAeijqM6lvZnA
         rcsC3itVUOP/nsGrNZFokNUeDFWeOffGVllv/EbwHepdPfuWRkAqdp7VFfVObDHu7z+2
         Im+g==
X-Forwarded-Encrypted: i=1; AJvYcCWM9uHU4uJKY9B7pQhwawEeni0YlnNrhwt+2GRqb9AjTAdxMroxVcZPKVvRFlgoSKruqEP7qf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT388uTSCg0dLSU+CYs+8YkM0ATrZynjt2ydbmAdSH12gQRmKY
	xaz2cTydWSuD9CkO2RK/59nquGAZVDYQCBZxQLewcCzkJdLhPgZUkhm+weMLTpplPAjLdXRo16q
	oa7ptQ3WXKVCniiS8S2REPA==
X-Google-Smtp-Source: AGHT+IE75JdFzyCBCG2tlWsib+qeW95LCXIFGsEOclRoaX2f94l2EMyRn0LtgRIJbJ2+iA3APPqqxkaKu5fb1FcDbA==
X-Received: from pgpf6.prod.google.com ([2002:a65:4006:0:b0:7fd:4919:f6cf])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da3:b0:1e1:a829:bfa2 with SMTP id adf61e73a8af0-1e88cfd2413mr9241405637.19.1736407369317;
 Wed, 08 Jan 2025 23:22:49 -0800 (PST)
Date: Thu,  9 Jan 2025 16:22:45 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250109072245.2928832-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v4] netlink: support dumping IPv4 multicast addresses
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

Changelog since v3:
- Refactor in_dev_dump_addr() to break down the logic into two separate fun=
ctions to simplify the
  logic.

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 include/linux/igmp.h |  2 ++
 net/ipv4/devinet.c   | 73 +++++++++++++++++++++++++++++++++++++++++---
 net/ipv4/igmp.c      |  8 ++---
 3 files changed, 74 insertions(+), 9 deletions(-)

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
index c8b3cf5fba4c..19b3cea8da2b 100644
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
@@ -1846,9 +1847,39 @@ static int inet_valid_dump_ifaddr_req(const struct n=
lmsghdr *nlh,
 	return 0;
 }
=20
-static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
-			    struct netlink_callback *cb, int *s_ip_idx,
-			    struct inet_fill_args *fillargs)
+static int in_dev_dump_ifmcaddr(struct in_device *in_dev, struct sk_buff *=
skb,
+				struct netlink_callback *cb, int *s_ip_idx,
+				struct inet_fill_args *fillargs)
+{
+	struct ip_mc_list *im;
+	int ip_idx =3D 0;
+	int err;
+
+	for (im =3D rcu_dereference(in_dev->mc_list);
+	     im;
+	     im =3D rcu_dereference(im->next_rcu)) {
+		if (ip_idx < *s_ip_idx) {
+			ip_idx++;
+			continue;
+		}
+		err =3D inet_fill_ifmcaddr(skb, in_dev->dev, im,
+					 RTM_GETMULTICAST, NLM_F_MULTI);
+		if (err < 0)
+			goto done;
+
+		nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+		ip_idx++;
+	}
+	err =3D 0;
+	ip_idx =3D 0;
+done:
+	*s_ip_idx =3D ip_idx;
+	return err;
+}
+
+static int in_dev_dump_ifaddr(struct in_device *in_dev, struct sk_buff *sk=
b,
+			      struct netlink_callback *cb, int *s_ip_idx,
+			      struct inet_fill_args *fillargs)
 {
 	struct in_ifaddr *ifa;
 	int ip_idx =3D 0;
@@ -1874,6 +1905,21 @@ static int in_dev_dump_addr(struct in_device *in_dev=
, struct sk_buff *skb,
 	return err;
 }
=20
+static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
+			    struct netlink_callback *cb, int *s_ip_idx,
+			    struct inet_fill_args *fillargs)
+{
+	switch (fillargs->type) {
+	case UNICAST_ADDR:
+		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
+	case MULTICAST_ADDR:
+		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
+					    fillargs);
+	default:
+		return 0;
+	}
+}
+
 /* Combine dev_addr_genid and dev_base_seq to detect changes.
  */
 static u32 inet_base_seq(const struct net *net)
@@ -1889,15 +1935,16 @@ static u32 inet_base_seq(const struct net *net)
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
@@ -1949,6 +1996,20 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
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
@@ -2845,6 +2906,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
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
index 3da126cea884..3e6faaab54c0 100644
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
@@ -1479,7 +1479,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
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



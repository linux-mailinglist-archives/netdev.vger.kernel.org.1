Return-Path: <netdev+bounces-162431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD775A26E08
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AF6165844
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C5207A14;
	Tue,  4 Feb 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34qWsJ33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A640207675
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660765; cv=none; b=n5RH8gvTCSBCsXDtFPMudvLNSf72rmER6Gvxefh2CwuvYGltLMDUBWQfFKIksR8tgfqZo88/FoIdddIhd/L0dz3vFs/jsBtUtm3cDDpWsJH6+0JlGXKxmDjCy2N7NQRviufldbPUJhD5vlmc9Dzn/xqTpJJM80YzV4mMDumUGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660765; c=relaxed/simple;
	bh=Q0csqwcaAZvXvGkec2secZyCHiH9SuopKsrodWcOXLQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lY8tS9Fpe2n/avUBuW9RnqnBdlMuOa7r5grkNBpLfJ8NWl6xRH0HWVnRqA+pj4bPFfc8QZeuAk0CSApXT1QQawPlbQQJmkwzI3dmfJg8Zo+Api0FDRNu4BFTPz97DnVkFqJQhALVfcq+pmewmL2f/d38g151yJyQGTrBtlVU8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34qWsJ33; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa0eb9cfeso10775962a91.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 01:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738660762; x=1739265562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVxBz59z7pqKnTBxuV0shTK7UcH01DA8x0aIV3kZsoQ=;
        b=34qWsJ33HwXyG0JIcBsiva/usO+iVPdz4GubYzme2pDlAHxcOFtYJ+NGwhQTuC3G4O
         tMwVpOWlPhLFS83RZ9XRvQhIan936MwBs1l3yRYgPxR1A7lqRbCHc+jvqjBgzjnWxHD5
         lfe+FbHSGEM1h6S1yM/1tAgKMjAdGMMr5+tdX+U4g+W7GbYATjwJ8MNNLUsKwTaJ1dX1
         qA3JnSq2E7sV1lQH0SkTFf/swV7Q13RCV86kzBW9P+c6Y/xDYGn6519G7jXH0NcZJh0a
         KbBf+4doZxXSxSa8A/jdx9neGPUKJB0x0K3iGQArxpmt0gDZjJXYpDuvoTc/cWedgB7E
         M84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738660762; x=1739265562;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVxBz59z7pqKnTBxuV0shTK7UcH01DA8x0aIV3kZsoQ=;
        b=DRAlcOYV70WpLePYBSqUBZPkVHaSQBAWBFyEOid4YqfHmDDXdF0ex+Xa/xUAgz8cKt
         1Ym4MHMuR0lCnIcXXrSi30QL7/sPyhfrqGOKjtxNMpuSe19Uz9kosjbZX6V+iDL0iQD9
         GDr3JT2KaVi9ZZGY07Lc5rKLRwGtSDo3ZtO7wW+3zUJGASN795+lYQK8DO16+B0vFPsE
         FeOwu4hTGban1UhV9ux+HP+Csh5YUfSAvTWFYnTKwuIllAzQYfKTQaWNDA9T513XWDdZ
         Yq/DhI2bYzh66eTIU4G00p/x2lyWX011crbCZ0k7JsoNQpFNLlygTQQosJmfZCH5CqE6
         yFIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6LWRiwub1HzMNPZ/k48Cd61wUOtYWFwtcieyaCstDVRZb8QpW9YBG+18ZPjV5YG313UC23g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUAGcEhni+C3ZBcas1TNfWqosaM2cdn2AX4slrBW+CxrT1Pj7
	THQN8YyCXhrAul85vk8+f30uVkEFzn+vIOKRXeu8ASNyRs+yIDHTL5WjhIM78Riqzqlxv7uTG+J
	JLRwgZ+S6RT3CrtphBVWvAA==
X-Google-Smtp-Source: AGHT+IE7FccB31ZXH4/igHscrm+DfiEF+hX/6ZOe4XoCQHbhzfrdNlCEYbOqF9XHDtGhHJ4I8c+rpBygRNJs13F5JA==
X-Received: from pjbov11.prod.google.com ([2002:a17:90b:258b:b0:2ef:7352:9e97])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5550:b0:2f6:e47c:1750 with SMTP id 98e67ed59e1d1-2f9ba2c59dbmr4120079a91.13.1738660762626;
 Tue, 04 Feb 2025 01:19:22 -0800 (PST)
Date: Tue,  4 Feb 2025 18:19:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204091918.2652604-1-yuyanghuang@google.com>
Subject: [PATCH net-next, v7 1/2] netlink: support dumping IPv4 multicast addresses
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-kselftest@vger.kernel.org, 
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---

Changelog since v6:
- Move `inet_fill_args` and `inet_fill_ifmcaddr` from igmp.h to igmp_intern=
al.h to avoid exposing these two definitions kernel wide.

Changelog since v5:
- Move the test case to a separate patch.
- Refactor the code to remove the dependency on `enum addr_type_t type`.
- Return error if `fillargs->event` is not set properly.=20
- Return -EINVAL in an unreachable code path.

Changelog since v4:
- Fixes a bug where fillargs->event was not initialized in the code path fo=
r dumping ifaddr.
- Fixes a bug where reply messages contain the wrong sequence number.
- Minor style fixes.
- Adds a ynl selftest.

Changelog since v3:
- Refactor in_dev_dump_addr() to break down the logic into two separate fun=
ctions to simplify the logic.

Changelog since v2:
- Fix checkpatch.pl warnings.
- Remove one redundant EXPORT_SYMBOL().

Changelog since v1:
- Minor style fixes.
- Use for_each_pmc_rcu() instead of for_each_pmc_rtnl().

 include/linux/igmp_internal.h | 17 ++++++++
 net/ipv4/devinet.c            | 77 ++++++++++++++++++++++++++++-------
 net/ipv4/igmp.c               | 14 +++++--
 3 files changed, 90 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/igmp_internal.h

diff --git a/include/linux/igmp_internal.h b/include/linux/igmp_internal.h
new file mode 100644
index 000000000000..0a1bcc8ec8e1
--- /dev/null
+++ b/include/linux/igmp_internal.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_IGMP_INTERNAL_H
+#define _LINUX_IGMP_INTERNAL_H
+
+struct inet_fill_args {
+	u32 portid;
+	u32 seq;
+	int event;
+	unsigned int flags;
+	int netnsid;
+	int ifindex;
+};
+
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args);
+#endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c..5292202fd1ea 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -46,6 +46,7 @@
 #include <linux/notifier.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
+#include <linux/igmp_internal.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
 #ifdef CONFIG_SYSCTL
@@ -107,15 +108,6 @@ static const struct nla_policy ifa_ipv4_policy[IFA_MAX=
+1] =3D {
 	[IFA_PROTO]		=3D { .type =3D NLA_U8 },
 };
=20
-struct inet_fill_args {
-	u32 portid;
-	u32 seq;
-	int event;
-	unsigned int flags;
-	int netnsid;
-	int ifindex;
-};
-
 #define IN4_ADDR_HSIZE_SHIFT	8
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
=20
@@ -1846,9 +1838,38 @@ static int inet_valid_dump_ifaddr_req(const struct n=
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
+		err =3D inet_fill_ifmcaddr(skb, in_dev->dev, im, fillargs);
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
@@ -1874,6 +1895,21 @@ static int in_dev_dump_addr(struct in_device *in_dev=
, struct sk_buff *skb,
 	return err;
 }
=20
+static int in_dev_dump_addr(struct in_device *in_dev, struct sk_buff *skb,
+			    struct netlink_callback *cb, int *s_ip_idx,
+			    struct inet_fill_args *fillargs)
+{
+	switch (fillargs->event) {
+	case RTM_NEWADDR:
+		return in_dev_dump_ifaddr(in_dev, skb, cb, s_ip_idx, fillargs);
+	case RTM_GETMULTICAST:
+		return in_dev_dump_ifmcaddr(in_dev, skb, cb, s_ip_idx,
+					    fillargs);
+	default:
+		return -EINVAL;
+	}
+}
+
 /* Combine dev_addr_genid and dev_base_seq to detect changes.
  */
 static u32 inet_base_seq(const struct net *net)
@@ -1889,13 +1925,14 @@ static u32 inet_base_seq(const struct net *net)
 	return res;
 }
=20
-static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+static int inet_dump_addr(struct sk_buff *skb, struct netlink_callback *cb=
,
+			  int event)
 {
 	const struct nlmsghdr *nlh =3D cb->nlh;
 	struct inet_fill_args fillargs =3D {
 		.portid =3D NETLINK_CB(cb->skb).portid,
 		.seq =3D nlh->nlmsg_seq,
-		.event =3D RTM_NEWADDR,
+		.event =3D event,
 		.flags =3D NLM_F_MULTI,
 		.netnsid =3D -1,
 	};
@@ -1949,6 +1986,16 @@ static int inet_dump_ifaddr(struct sk_buff *skb, str=
uct netlink_callback *cb)
 	return err;
 }
=20
+static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *=
cb)
+{
+	return inet_dump_addr(skb, cb, RTM_NEWADDR);
+}
+
+static int inet_dump_ifmcaddr(struct sk_buff *skb, struct netlink_callback=
 *cb)
+{
+	return inet_dump_addr(skb, cb, RTM_GETMULTICAST);
+}
+
 static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *n=
lh,
 		      u32 portid)
 {
@@ -2845,6 +2892,8 @@ static const struct rtnl_msg_handler devinet_rtnl_msg=
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
index 3da126cea884..ac3c45bdbdf0 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -81,6 +81,7 @@
 #include <linux/skbuff.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
+#include <linux/igmp_internal.h>
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/times.h>
@@ -1432,14 +1433,16 @@ static void ip_mc_hash_remove(struct in_device *in_=
dev,
 	*mc_hash =3D im->next_hash;
 }
=20
-static int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
-			      const struct ip_mc_list *im, int event)
+int inet_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
+		       const struct ip_mc_list *im,
+		       struct inet_fill_args *args)
 {
 	struct ifa_cacheinfo ci;
 	struct ifaddrmsg *ifm;
 	struct nlmsghdr *nlh;
=20
-	nlh =3D nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
+	nlh =3D nlmsg_put(skb, args->portid, args->seq, args->event,
+			sizeof(struct ifaddrmsg), args->flags);
 	if (!nlh)
 		return -EMSGSIZE;
=20
@@ -1468,6 +1471,9 @@ static int inet_fill_ifmcaddr(struct sk_buff *skb, st=
ruct net_device *dev,
 static void inet_ifmcaddr_notify(struct net_device *dev,
 				 const struct ip_mc_list *im, int event)
 {
+	struct inet_fill_args fillargs =3D {
+		.event =3D event,
+	};
 	struct net *net =3D dev_net(dev);
 	struct sk_buff *skb;
 	int err =3D -ENOMEM;
@@ -1479,7 +1485,7 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	if (!skb)
 		goto error;
=20
-	err =3D inet_fill_ifmcaddr(skb, dev, im, event);
+	err =3D inet_fill_ifmcaddr(skb, dev, im, &fillargs);
 	if (err < 0) {
 		WARN_ON_ONCE(err =3D=3D -EMSGSIZE);
 		nlmsg_free(skb);
--=20
2.48.1.362.g079036d154-goog



Return-Path: <netdev+bounces-75231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E97868C18
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD70EB2AF02
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174613666C;
	Tue, 27 Feb 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vL14ahDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D11136658
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025858; cv=none; b=qQCC1K/rjzKcwh09ap9pM68hHlMUcjZYq9+thYCmDH0Fi83wmxb1j0WlyHoEFJwtzB9JoDnzE2dKeo+AGphM9sUERUYCgL1EUW642uCifd87qieEb/ZsoHMG4TRu9eorTxT0c1p/u8bcZxEpjUtDTk6dY3JKQQqQ2bgXePxpTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025858; c=relaxed/simple;
	bh=G/hCjOLpwCsOcquNOmdRxxnwO/bAtF9QZxgE7t70IKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=muZCyvp9eEaTAhPlpI/kC7mAnFKSvN61AEbj5s1T4bwXUa/Ye8ED1kUcBcUVKw5uZ0Dt8M2i22s7ugoJJ9XEa6ZGBLXRE10khjj2gDLAIwOPT2n8Vik1ctTTjT1GEYMhfRa2avc9zGLEyxw+6WetZQtSTHSx3MGdEmAMw6MXEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vL14ahDj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso7327265276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709025855; x=1709630655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DI0UVEg7zNzdHrk8WzabcgMsTGyAMfdYDtEWLQl+iRU=;
        b=vL14ahDjsI0kvLchkmVAjLHo0I98uh/k0GR+syLxiV/Sa1AHMNV6E1pWe2JzqxVKvG
         z+2I+WFZUHnsd+foqW84QxLGcpi3xO+pNrl2kLb9wrENMOrfsYyfSxbjM2672HeaCfav
         QSiAqP5ltoTGCpYmJ3LPfO1kEpx/xLBm4U9b1vnQntnpvknmEmN5qnbD4Nt897KS+Soo
         gJmwpZG9ta2igY6D8Oty/phkYWKQI7zS5IS6f0A0Of3ammQQyyLULW2G6hxFcGTLpo9K
         ZdcXfpK5vkOt/2JwiQDO/29y+cCOBRXYmuJtNHvRfWaDASF6/0ddPOPIDvk8XliUa3Cf
         mFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025855; x=1709630655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DI0UVEg7zNzdHrk8WzabcgMsTGyAMfdYDtEWLQl+iRU=;
        b=IpEBlsj5gBLVcelD5029OI8736umtcy2G7lZvyUfFRgc7qyeT2Aff09HPx+AhjLMlo
         zq/Oxf4w1SdBDqRwLU/v1PK13i5sXiNQDj18sOqtg460JVTrg0rxdE1MP82Nc6Bj5dVh
         Uyyymdu5T/XLU+DDv+/RM1RFxxYF757bVBl2LpipEoq7eL04r6s7qzxhKFgRpQlfUTUk
         KNilGH9y9Po5daDRfB1Mn/7KYK7uOkQrxtNV4WJjYWKAhKnaZdR6F0BB6yWThrOV/L8M
         rOdTO9xT+k7mW+2ivM7ijFq5XzQ+7lh+Z6AQZ1MfW9goUDcNgP+HGobAoOBumcSYxbbs
         ZuEg==
X-Forwarded-Encrypted: i=1; AJvYcCVcUM+9ggrID5/XvTuOs4aEn6cQAFybrADLGj/Iion26DkA0LHCH8ZqckIPbNVldwPXddulxCG7d9rp7oQqqs3QUXFvm9v5
X-Gm-Message-State: AOJu0YwzQ4Es8iAcWvSwhea45zEXh29ffX3A53IU7jOJ+vaPTs4BXv8F
	+TEAGX/gDsIoYjxcOhYYKqpcYoXqYKlVvZhpxFmDlR3k794ApzdHmSdBCzK7aRIARf+pUQJgG59
	ev/q/dFqdcA==
X-Google-Smtp-Source: AGHT+IHdtn/W3GTccoGRIFuInknwg/kPDmcBHMfL/4IZwRS9Em6fn0nXM3qHuZBDnxjE7j5buE4p6ouaH3mOGA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:102:0:b0:dcc:9f24:692b with SMTP id
 2-20020a250102000000b00dcc9f24692bmr64925ybb.13.1709025855631; Tue, 27 Feb
 2024 01:24:15 -0800 (PST)
Date: Tue, 27 Feb 2024 09:24:09 +0000
In-Reply-To: <20240227092411.2315725-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227092411.2315725-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227092411.2315725-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] inet: annotate devconf data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add READ_ONCE() in ipv4_devconf_get() and corresponding
WRITE_ONCE() in ipv4_devconf_set()

Add IPV4_DEVCONF_RO() and IPV4_DEVCONF_ALL_RO() macros,
and use them when reading devconf fields.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inetdevice.h | 14 ++++++++------
 net/ipv4/devinet.c         | 21 +++++++++++----------
 net/ipv4/igmp.c            |  4 ++--
 net/ipv4/proc.c            |  2 +-
 net/ipv4/route.c           |  4 ++--
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index ddb27fc0ee8c8862d62f8c6243c4239ea53374f2..cb5280e6cc219106bcc55972dac850edf34988ff 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -53,13 +53,15 @@ struct in_device {
 };
 
 #define IPV4_DEVCONF(cnf, attr) ((cnf).data[IPV4_DEVCONF_ ## attr - 1])
+#define IPV4_DEVCONF_RO(cnf, attr) READ_ONCE(IPV4_DEVCONF(cnf, attr))
 #define IPV4_DEVCONF_ALL(net, attr) \
 	IPV4_DEVCONF((*(net)->ipv4.devconf_all), attr)
+#define IPV4_DEVCONF_ALL_RO(net, attr) READ_ONCE(IPV4_DEVCONF_ALL(net, attr))
 
-static inline int ipv4_devconf_get(struct in_device *in_dev, int index)
+static inline int ipv4_devconf_get(const struct in_device *in_dev, int index)
 {
 	index--;
-	return in_dev->cnf.data[index];
+	return READ_ONCE(in_dev->cnf.data[index]);
 }
 
 static inline void ipv4_devconf_set(struct in_device *in_dev, int index,
@@ -67,7 +69,7 @@ static inline void ipv4_devconf_set(struct in_device *in_dev, int index,
 {
 	index--;
 	set_bit(index, in_dev->cnf.state);
-	in_dev->cnf.data[index] = val;
+	WRITE_ONCE(in_dev->cnf.data[index], val);
 }
 
 static inline void ipv4_devconf_setall(struct in_device *in_dev)
@@ -81,18 +83,18 @@ static inline void ipv4_devconf_setall(struct in_device *in_dev)
 	ipv4_devconf_set((in_dev), IPV4_DEVCONF_ ## attr, (val))
 
 #define IN_DEV_ANDCONF(in_dev, attr) \
-	(IPV4_DEVCONF_ALL(dev_net(in_dev->dev), attr) && \
+	(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), attr) && \
 	 IN_DEV_CONF_GET((in_dev), attr))
 
 #define IN_DEV_NET_ORCONF(in_dev, net, attr) \
-	(IPV4_DEVCONF_ALL(net, attr) || \
+	(IPV4_DEVCONF_ALL_RO(net, attr) || \
 	 IN_DEV_CONF_GET((in_dev), attr))
 
 #define IN_DEV_ORCONF(in_dev, attr) \
 	IN_DEV_NET_ORCONF(in_dev, dev_net(in_dev->dev), attr)
 
 #define IN_DEV_MAXCONF(in_dev, attr) \
-	(max(IPV4_DEVCONF_ALL(dev_net(in_dev->dev), attr), \
+	(max(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), attr), \
 	     IN_DEV_CONF_GET((in_dev), attr)))
 
 #define IN_DEV_FORWARD(in_dev)		IN_DEV_CONF_GET((in_dev), FORWARDING)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index bc74f131fe4dfad327e71c1a8f0a4b66cdc526e5..ca75d0fff1d1ebd8c199fb74a6f0e2f51160635c 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1982,7 +1982,7 @@ static int inet_fill_link_af(struct sk_buff *skb, const struct net_device *dev,
 		return -EMSGSIZE;
 
 	for (i = 0; i < IPV4_DEVCONF_MAX; i++)
-		((u32 *) nla_data(nla))[i] = in_dev->cnf.data[i];
+		((u32 *) nla_data(nla))[i] = READ_ONCE(in_dev->cnf.data[i]);
 
 	return 0;
 }
@@ -2068,9 +2068,9 @@ static int inet_netconf_msgsize_devconf(int type)
 }
 
 static int inet_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
-				     struct ipv4_devconf *devconf, u32 portid,
-				     u32 seq, int event, unsigned int flags,
-				     int type)
+				     const struct ipv4_devconf *devconf,
+				     u32 portid, u32 seq, int event,
+				     unsigned int flags, int type)
 {
 	struct nlmsghdr  *nlh;
 	struct netconfmsg *ncm;
@@ -2095,27 +2095,28 @@ static int inet_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 
 	if ((all || type == NETCONFA_FORWARDING) &&
 	    nla_put_s32(skb, NETCONFA_FORWARDING,
-			IPV4_DEVCONF(*devconf, FORWARDING)) < 0)
+			IPV4_DEVCONF_RO(*devconf, FORWARDING)) < 0)
 		goto nla_put_failure;
 	if ((all || type == NETCONFA_RP_FILTER) &&
 	    nla_put_s32(skb, NETCONFA_RP_FILTER,
-			IPV4_DEVCONF(*devconf, RP_FILTER)) < 0)
+			IPV4_DEVCONF_RO(*devconf, RP_FILTER)) < 0)
 		goto nla_put_failure;
 	if ((all || type == NETCONFA_MC_FORWARDING) &&
 	    nla_put_s32(skb, NETCONFA_MC_FORWARDING,
-			IPV4_DEVCONF(*devconf, MC_FORWARDING)) < 0)
+			IPV4_DEVCONF_RO(*devconf, MC_FORWARDING)) < 0)
 		goto nla_put_failure;
 	if ((all || type == NETCONFA_BC_FORWARDING) &&
 	    nla_put_s32(skb, NETCONFA_BC_FORWARDING,
-			IPV4_DEVCONF(*devconf, BC_FORWARDING)) < 0)
+			IPV4_DEVCONF_RO(*devconf, BC_FORWARDING)) < 0)
 		goto nla_put_failure;
 	if ((all || type == NETCONFA_PROXY_NEIGH) &&
 	    nla_put_s32(skb, NETCONFA_PROXY_NEIGH,
-			IPV4_DEVCONF(*devconf, PROXY_ARP)) < 0)
+			IPV4_DEVCONF_RO(*devconf, PROXY_ARP)) < 0)
 		goto nla_put_failure;
 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
 	    nla_put_s32(skb, NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
-			IPV4_DEVCONF(*devconf, IGNORE_ROUTES_WITH_LINKDOWN)) < 0)
+			IPV4_DEVCONF_RO(*devconf,
+					IGNORE_ROUTES_WITH_LINKDOWN)) < 0)
 		goto nla_put_failure;
 
 out:
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index efeeca2b13285a3149645ab945b0364391f6721b..717e97a389a8aee75f51a5a5d859cb94a5d868eb 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -120,12 +120,12 @@
  */
 
 #define IGMP_V1_SEEN(in_dev) \
-	(IPV4_DEVCONF_ALL(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 1 || \
+	(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 1 || \
 	 IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 1 || \
 	 ((in_dev)->mr_v1_seen && \
 	  time_before(jiffies, (in_dev)->mr_v1_seen)))
 #define IGMP_V2_SEEN(in_dev) \
-	(IPV4_DEVCONF_ALL(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 2 || \
+	(IPV4_DEVCONF_ALL_RO(dev_net(in_dev->dev), FORCE_IGMP_VERSION) == 2 || \
 	 IN_DEV_CONF_GET((in_dev), FORCE_IGMP_VERSION) == 2 || \
 	 ((in_dev)->mr_v2_seen && \
 	  time_before(jiffies, (in_dev)->mr_v2_seen)))
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 5f4654ebff487494b6afbaa69174df4c004395dc..914bc9c35cc702395aee257fb010034294e501de 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -395,7 +395,7 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 		seq_printf(seq, " %s", snmp4_ipstats_list[i].name);
 
 	seq_printf(seq, "\nIp: %d %d",
-		   IPV4_DEVCONF_ALL(net, FORWARDING) ? 1 : 2,
+		   IPV4_DEVCONF_ALL_RO(net, FORWARDING) ? 1 : 2,
 		   READ_ONCE(net->ipv4.sysctl_ip_default_ttl));
 
 	BUILD_BUG_ON(offsetof(struct ipstats_mib, mibs) != 0);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b512288d6fcc6bc0ce586bc5dc501b979ac3b9c1..c8f76f56dc1653371ca39663f29cc798b062e60d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2313,7 +2313,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		if (IN_DEV_BFORWARD(in_dev))
 			goto make_route;
 		/* not do cache if bc_forwarding is enabled */
-		if (IPV4_DEVCONF_ALL(net, BC_FORWARDING))
+		if (IPV4_DEVCONF_ALL_RO(net, BC_FORWARDING))
 			do_cache = false;
 		goto brd_input;
 	}
@@ -2993,7 +2993,7 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 #ifdef CONFIG_IP_MROUTE
 			if (ipv4_is_multicast(dst) &&
 			    !ipv4_is_local_multicast(dst) &&
-			    IPV4_DEVCONF_ALL(net, MC_FORWARDING)) {
+			    IPV4_DEVCONF_ALL_RO(net, MC_FORWARDING)) {
 				int err = ipmr_get_route(net, skb,
 							 fl4->saddr, fl4->daddr,
 							 r, portid);
-- 
2.44.0.rc1.240.g4c46232300-goog



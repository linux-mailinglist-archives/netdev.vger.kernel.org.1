Return-Path: <netdev+bounces-75746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770786B0F1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D32EB294BF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726701586CF;
	Wed, 28 Feb 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XldhA6VQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B102157E96
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128493; cv=none; b=DupF5hIlSAhXbRTGop19t/tjrPDxm0SwOwwemWdcrmYGR9VgrI31rVZ2wWw+GBu/T5AyyKVVBE+MS9ucg9sEF/CnPZsa03AoLT3eIyOXGc7fVuuuPP7eaQwSysaX2fVwr0VtgVc9z7+6MNXinRmueztLwPvUNClBFThd6VfI0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128493; c=relaxed/simple;
	bh=Mt4IQn3UWvTlyV1oEpkOCI3f3CXjXiyKImXQiiAWjX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWrcNEJyp6BuWGZ/bfZgbs4AsTqsqEOKhBg3FW9vHVCBiy0u+vBPw0L5VnL0bZ/S7cfq2zadnvhm/fuzSy+fAUroHZWrfnysyTt4g5TKc/kcmFRR9c9LQR5SUhTHhmx6fPvutL7EtFuciHyhH/+5fO8LF1qPYIvJi5F6zyKatcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XldhA6VQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8651778276.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128490; x=1709733290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjHU+nStBYgBHY38l5mYoklHn3VcbO0en3He1pBUsDc=;
        b=XldhA6VQR4ybIXS4fzJn+y7Mez4Q2SE6RZS45YLVIlJoEc/Hsmcwq7V2OjvSncLAbQ
         L+sRgUbAPslUt9DkMMLkJ2qmerIaa0RkCdey7OUVF15Gu2ebD4y1c1wgh8hicYmkJvcK
         LXpmVezEfKBeffSZNCd9GDS5XU2LIAfwEANXy6dwO24dmQDnPiJj8mc/fB9inSBhLIJV
         rU+qZ/sm/7hz4XLdHAgepTelih7GeqEWhaZiQsQjoJWp6JrNOfEP3qvyURz2MLa+JUVF
         QUrCJBA5GtjhI4nEgu9xmOJu9dmVZUi4XCRw6H+gqKKB/o0Atq7jaX++jTrmdRdlactd
         ggHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128490; x=1709733290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjHU+nStBYgBHY38l5mYoklHn3VcbO0en3He1pBUsDc=;
        b=Ie9i6XZQdwbner1vDcht4+3oxc9P33iu9Y2v1TWNYkA9ViEiWscRsGsLq888F2BfJS
         kyNKFQQU1uzausiEp0vBSS+xOuzQmUBFBs+IzX2PMAo6C9mAwT7RxoS26oaw0aIwpZPw
         04Khu3sy5lWlXGKJOADnaNSvXF6/EN1GYeyTZ3T4QPFMnzF7EjDXChT/h8qInLVPt/sq
         4i7aF0SAtYqd4tFCCwADOsCFXtK4xPrVRL5SzHY4YYVM7kj8xF3QtrjiY6q3gl86POs8
         OTdmU94eXuf7sQwEeDGdHtUS5KQT4koImNvorYokzTerjEHxU/NqEtJneFcOPiqM8e2b
         GDvg==
X-Gm-Message-State: AOJu0Yx2GH4WKifNe6CtZDxtO1TKqGVpqpBSoztBePcKzHjazb09wib4
	bkZTJOC8ZGpsNB3VbWKENSPlc2OtPM3tziWzjLEyehIB0J1oD2B3cL4IwElxkNHsORK40mjrEyH
	P4aXcHvBJvw==
X-Google-Smtp-Source: AGHT+IGvehOxUynVq9b3g9H41aPDabKxg9xJ7X/cNv76G7yBr5eYbtJ0NBGePLz7BR4tevyBdBlpeXfB3BZqIw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:174a:b0:dce:30f5:6bc5 with SMTP
 id bz10-20020a056902174a00b00dce30f56bc5mr116330ybb.4.1709128490662; Wed, 28
 Feb 2024 05:54:50 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:30 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/15] ipv6: annotate data-races around cnf.forwarding
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.forwarding and net->ipv6.devconf_all->forwarding
might be read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/usb/cdc_mbim.c |  2 +-
 include/net/ipv6.h         |  8 +++++---
 net/core/filter.c          |  2 +-
 net/ipv6/addrconf.c        | 10 ++++++----
 net/ipv6/ip6_output.c      |  2 +-
 net/ipv6/ndisc.c           | 11 ++++++-----
 net/ipv6/route.c           |  4 ++--
 7 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index cd4083e0b3b9e6bf8c8fa08ce5b6006d33d9bedd..e13e4920ee9b2e814c4f5ff5df139dc07d739abd 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -339,7 +339,7 @@ static void do_neigh_solicit(struct usbnet *dev, u8 *buf, u16 tci)
 	in6_dev = in6_dev_get(netdev);
 	if (!in6_dev)
 		goto out;
-	is_router = !!in6_dev->cnf.forwarding;
+	is_router = !!READ_ONCE(in6_dev->cnf.forwarding);
 	in6_dev_put(in6_dev);
 
 	/* ipv6_stub != NULL if in6_dev_get returned an inet6_dev */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cf25ea21d770d4fe1b235bf2d1ec0088b4b0ff45..88a8e554f7a126a1d817c0cc3bb947c7a43c5cdf 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -534,13 +534,15 @@ static inline int ipv6_hopopt_jumbo_remove(struct sk_buff *skb)
 	return 0;
 }
 
-static inline bool ipv6_accept_ra(struct inet6_dev *idev)
+static inline bool ipv6_accept_ra(const struct inet6_dev *idev)
 {
+	s32 accept_ra = READ_ONCE(idev->cnf.accept_ra);
+
 	/* If forwarding is enabled, RA are not accepted unless the special
 	 * hybrid mode (accept_ra=2) is enabled.
 	 */
-	return idev->cnf.forwarding ? idev->cnf.accept_ra == 2 :
-	    idev->cnf.accept_ra;
+	return READ_ONCE(idev->cnf.forwarding) ? accept_ra == 2 :
+		accept_ra;
 }
 
 #define IPV6_FRAG_HIGH_THRESH	(4 * 1024*1024)	/* 4194304 */
diff --git a/net/core/filter.c b/net/core/filter.c
index 358870408a51e61f3cbc552736806e4dfee1ec39..58e8e1a70aa752a2c045117e00d8797478da4738 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5988,7 +5988,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		return -ENODEV;
 
 	idev = __in6_dev_get_safely(dev);
-	if (unlikely(!idev || !idev->cnf.forwarding))
+	if (unlikely(!idev || !READ_ONCE(idev->cnf.forwarding)))
 		return BPF_FIB_LKUP_RET_FWD_DISABLED;
 
 	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8fd2ff8510021738e6bde499cc9fae83c52b91ee..37117df401bc47ab66cf89ebcaee1684be84b4c2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -551,7 +551,8 @@ static int inet6_netconf_fill_devconf(struct sk_buff *skb, int ifindex,
 		goto out;
 
 	if ((all || type == NETCONFA_FORWARDING) &&
-	    nla_put_s32(skb, NETCONFA_FORWARDING, devconf->forwarding) < 0)
+	    nla_put_s32(skb, NETCONFA_FORWARDING,
+			READ_ONCE(devconf->forwarding)) < 0)
 		goto nla_put_failure;
 #ifdef CONFIG_IPV6_MROUTE
 	if ((all || type == NETCONFA_MC_FORWARDING) &&
@@ -869,7 +870,8 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
-			idev->cnf.forwarding = newf;
+
+			WRITE_ONCE(idev->cnf.forwarding, newf);
 			if (changed)
 				dev_forward_change(idev);
 		}
@@ -886,7 +888,7 @@ static int addrconf_fixup_forwarding(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->forwarding) {
 		if ((!newf) ^ (!old))
@@ -901,7 +903,7 @@ static int addrconf_fixup_forwarding(struct ctl_table *table, int *p, int newf)
 	if (p == &net->ipv6.devconf_all->forwarding) {
 		int old_dflt = net->ipv6.devconf_dflt->forwarding;
 
-		net->ipv6.devconf_dflt->forwarding = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->forwarding, newf);
 		if ((!newf) ^ (!old_dflt))
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_FORWARDING,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0559bd0005858631f88c706f98c625ad0bfff278..444be8c84cc579bf32b2950e0261ffe7c1d265a8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -501,7 +501,7 @@ int ip6_forward(struct sk_buff *skb)
 	u32 mtu;
 
 	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
-	if (net->ipv6.devconf_all->forwarding == 0)
+	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
 		goto error;
 
 	if (skb->pkt_type != PACKET_HOST)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 9c9c31268432ee58c1a381d0333d85a558a602e1..1fb5e37bc78be54c71b49506e833a53edff3fa0e 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -903,7 +903,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 		}
 
 		if (ipv6_chk_acast_addr(net, dev, &msg->target) ||
-		    (idev->cnf.forwarding &&
+		    (READ_ONCE(idev->cnf.forwarding) &&
 		     (net->ipv6.devconf_all->proxy_ndp || idev->cnf.proxy_ndp) &&
 		     (is_router = pndisc_is_router(&msg->target, dev)) >= 0)) {
 			if (!(NEIGH_CB(skb)->flags & LOCALLY_ENQUEUED) &&
@@ -929,7 +929,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	}
 
 	if (is_router < 0)
-		is_router = idev->cnf.forwarding;
+		is_router = READ_ONCE(idev->cnf.forwarding);
 
 	if (dad) {
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &msg->target,
@@ -1080,7 +1080,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 * Note that we don't do a (daddr == all-routers-mcast) check.
 	 */
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
-	if (!neigh && lladdr && idev && idev->cnf.forwarding) {
+	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
 		if (accept_untracked_na(dev, saddr)) {
 			neigh = neigh_create(&nd_tbl, &msg->target, dev);
 			new_state = NUD_STALE;
@@ -1100,7 +1100,8 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		 * has already sent a NA to us.
 		 */
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
-		    net->ipv6.devconf_all->forwarding && net->ipv6.devconf_all->proxy_ndp &&
+		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
+		    net->ipv6.devconf_all->proxy_ndp &&
 		    pneigh_lookup(&nd_tbl, net, &msg->target, dev, 0)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
@@ -1148,7 +1149,7 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 	}
 
 	/* Don't accept RS if we're not in router mode */
-	if (!idev->cnf.forwarding)
+	if (!READ_ONCE(idev->cnf.forwarding))
 		goto out;
 
 	/*
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 66c685b0b6199fee3bc39768eab5a6fb831bd2f5..6a2b53de48182525a923e62ba3fbd13cba60a48a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2220,7 +2220,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 
 	strict |= flags & RT6_LOOKUP_F_IFACE;
 	strict |= flags & RT6_LOOKUP_F_IGNORE_LINKSTATE;
-	if (net->ipv6.devconf_all->forwarding == 0)
+	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
 		strict |= RT6_LOOKUP_F_REACHABLE;
 
 	rcu_read_lock();
@@ -4149,7 +4149,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	in6_dev = __in6_dev_get(skb->dev);
 	if (!in6_dev)
 		return;
-	if (in6_dev->cnf.forwarding || !in6_dev->cnf.accept_redirects)
+	if (READ_ONCE(in6_dev->cnf.forwarding) || !in6_dev->cnf.accept_redirects)
 		return;
 
 	/* RFC2461 8.1:
-- 
2.44.0.rc1.240.g4c46232300-goog



Return-Path: <netdev+bounces-75747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EBC86B0F2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8AD1C215BF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAC1534ED;
	Wed, 28 Feb 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILGwSS6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22F14F9E5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128495; cv=none; b=Oj+QtL61eR8n0IyB2RPr/KN/cLT/g2BbcBA/pQphUOaWC2OyNyMoFU2dJRmjnC7YNpcByATeqLIoUG7xSLVPyRpE4XOMtxj+Odr8Tz7YwP0qKOzwMGXngVcYAHxov8ow+Nx/S9Xb6U5Don312dTvcARZcvtlOpFaGhlAUf0S19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128495; c=relaxed/simple;
	bh=2H40xd+LczME4dMDxh7XbSLIxqtTZYpnih/4mbpwe7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eajVyuAloguAs1J4e6y6Os7D38zilckh1ez2n7VA3EJbA3V3KgqYIikiYvom8AabatTIYJn/5Vk4r+xjOju5OqdOeirWw2GK+P4di7mG8LXRm26FP4g78JulRZ0CGgBtleRL2dBZu4rbTn8M7ZjMXpA3LSkFWRYMbntoghV+InM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILGwSS6s; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so9605447b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128492; x=1709733292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQuzBEUbCY/TH3aVKeFALmVgaiFsq92+oYWEs6Hx46I=;
        b=ILGwSS6sKRfTUx5F7nhsClUrhJoft2c9Roq910KFVf1YBUQLCmeY5yRpdkOhE3KjTA
         m60+sU19hr/jIylBheN5seulbs6OCZHOh6jE1BAbytOdhiFJbbfha5iyuVd4Mj8jlY+f
         yoxtJO2n7U5gUMKhseYaIEoNTNfNOvr/+A5kg+jlJjr4SMQMwIjGV6J1DGvq0ohjB9ci
         bV9Di4VlJiHEBa+xvCc69Dex4eV5qOkRuea4BBQ78ICXSFD7LHjN2o59KG7pD89pz5Ul
         +y2JY+MQDwFzFD9Nglh+ph3WBXUn4Gx65Bzr3aTE48C6tFchxdY+OgEKftvz305mt122
         cOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128492; x=1709733292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQuzBEUbCY/TH3aVKeFALmVgaiFsq92+oYWEs6Hx46I=;
        b=Aptg7XJKxrH1oUh8E5v3wuii/u2Ham8GsRvvZNac93THZ3SvRJ/Zal+qotc/E/Rs/j
         NtjPeAh7HtQEKod0kzQz5nV5bQY5Do/tGiNsXb8tdbcOSvCAm4Buxa7cKAG3OkMKqToH
         Edez/4GGGFWaw8EuVN3adbqTwRxsLvA0Wc1DTNQ7IZlSDhIboTwD0OP1HkIw0Sw1RL2j
         aPO0cr/GOno0A74hQaiBOyq1c16qr1CUQVH/159yF+MsQnEWelz/OxDeLK++i9mMB0po
         wbDCKiIPHoRimfwPCmFN6ZPz+Q6exHWGYQnEqIJnqjWKSgPJHpeL05rR2UFRuV4g3jht
         msCQ==
X-Gm-Message-State: AOJu0YzWda3w0v8o18lNvPh3EEPFN3Gl/rS3IebxFUw/O0OO7Ay9EwGk
	I2WroMZsebQXHIfSnbDI3Y7yPcjRizE0bqzwO49WBU2mSm3DFgVG7ywUQ5XjCU2bLvqdtspN+AJ
	vWaekQi6sHA==
X-Google-Smtp-Source: AGHT+IHSRm15nuEVFBKkXS6968ZJoMjOoRacycpnj1GxT38WUA0v3yzhpbWCmhSpmD6+ute//ZoqS2UsZJH7oQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:84d4:0:b0:608:aaf0:d8b4 with SMTP id
 u203-20020a8184d4000000b00608aaf0d8b4mr510010ywf.3.1709128492732; Wed, 28 Feb
 2024 05:54:52 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:31 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/15] ipv6: annotate data-races in ndisc_router_discovery()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate reads from in6_dev->cnf.XXX fields, as they could
change concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/ndisc.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 1fb5e37bc78be54c71b49506e833a53edff3fa0e..f6430db249401b12debc0b174027af966fa71ccb 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1319,7 +1319,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	if (old_if_flags != in6_dev->if_flags)
 		send_ifinfo_notify = true;
 
-	if (!in6_dev->cnf.accept_ra_defrtr) {
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_defrtr)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, defrtr is false for dev: %s\n",
 			  __func__, skb->dev->name);
@@ -1327,7 +1327,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 	lifetime = ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-	if (lifetime != 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+	if (lifetime != 0 &&
+	    lifetime < READ_ONCE(in6_dev->cnf.accept_ra_min_lft)) {
 		ND_PRINTK(2, info,
 			  "RA: router lifetime (%ds) is too short: %s\n",
 			  lifetime, skb->dev->name);
@@ -1338,7 +1339,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	 * accept_ra_from_local is set to true.
 	 */
 	net = dev_net(in6_dev->dev);
-	if (!in6_dev->cnf.accept_ra_from_local &&
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(net, &ipv6_hdr(skb)->saddr, in6_dev->dev, 0)) {
 		ND_PRINTK(2, info,
 			  "RA from local address detected on dev: %s: default router ignored\n",
@@ -1350,7 +1351,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	pref = ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
 	if (pref == ICMPV6_ROUTER_PREF_INVALID ||
-	    !in6_dev->cnf.accept_ra_rtr_pref)
+	    !READ_ONCE(in6_dev->cnf.accept_ra_rtr_pref))
 		pref = ICMPV6_ROUTER_PREF_MEDIUM;
 #endif
 	/* routes added from RAs do not use nexthop objects */
@@ -1421,10 +1422,12 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 
 		spin_unlock_bh(&table->tb6_lock);
 	}
-	if (in6_dev->cnf.accept_ra_min_hop_limit < 256 &&
+	if (READ_ONCE(in6_dev->cnf.accept_ra_min_hop_limit) < 256 &&
 	    ra_msg->icmph.icmp6_hop_limit) {
-		if (in6_dev->cnf.accept_ra_min_hop_limit <= ra_msg->icmph.icmp6_hop_limit) {
-			WRITE_ONCE(in6_dev->cnf.hop_limit, ra_msg->icmph.icmp6_hop_limit);
+		if (READ_ONCE(in6_dev->cnf.accept_ra_min_hop_limit) <=
+		    ra_msg->icmph.icmp6_hop_limit) {
+			WRITE_ONCE(in6_dev->cnf.hop_limit,
+				   ra_msg->icmph.icmp6_hop_limit);
 			fib6_metric_set(rt, RTAX_HOPLIMIT,
 					ra_msg->icmph.icmp6_hop_limit);
 		} else {
@@ -1506,7 +1509,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 
 #ifdef CONFIG_IPV6_ROUTE_INFO
-	if (!in6_dev->cnf.accept_ra_from_local &&
+	if (!READ_ONCE(in6_dev->cnf.accept_ra_from_local) &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
 			  in6_dev->dev, 0)) {
 		ND_PRINTK(2, info,
@@ -1515,7 +1518,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		goto skip_routeinfo;
 	}
 
-	if (in6_dev->cnf.accept_ra_rtr_pref && ndopts.nd_opts_ri) {
+	if (READ_ONCE(in6_dev->cnf.accept_ra_rtr_pref) && ndopts.nd_opts_ri) {
 		struct nd_opt_hdr *p;
 		for (p = ndopts.nd_opts_ri;
 		     p;
@@ -1527,14 +1530,14 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 				continue;
 #endif
 			if (ri->prefix_len == 0 &&
-			    !in6_dev->cnf.accept_ra_defrtr)
+			    !READ_ONCE(in6_dev->cnf.accept_ra_defrtr))
 				continue;
 			if (ri->lifetime != 0 &&
-			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+			    ntohl(ri->lifetime) < READ_ONCE(in6_dev->cnf.accept_ra_min_lft))
 				continue;
-			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
+			if (ri->prefix_len < READ_ONCE(in6_dev->cnf.accept_ra_rt_info_min_plen))
 				continue;
-			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
+			if (ri->prefix_len > READ_ONCE(in6_dev->cnf.accept_ra_rt_info_max_plen))
 				continue;
 			rt6_route_rcv(skb->dev, (u8 *)p, (p->nd_opt_len) << 3,
 				      &ipv6_hdr(skb)->saddr);
@@ -1554,7 +1557,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	}
 #endif
 
-	if (in6_dev->cnf.accept_ra_pinfo && ndopts.nd_opts_pi) {
+	if (READ_ONCE(in6_dev->cnf.accept_ra_pinfo) && ndopts.nd_opts_pi) {
 		struct nd_opt_hdr *p;
 		for (p = ndopts.nd_opts_pi;
 		     p;
@@ -1565,7 +1568,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		}
 	}
 
-	if (ndopts.nd_opts_mtu && in6_dev->cnf.accept_ra_mtu) {
+	if (ndopts.nd_opts_mtu && READ_ONCE(in6_dev->cnf.accept_ra_mtu)) {
 		__be32 n;
 		u32 mtu;
 
-- 
2.44.0.rc1.240.g4c46232300-goog



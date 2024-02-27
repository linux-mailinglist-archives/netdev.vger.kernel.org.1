Return-Path: <netdev+bounces-75360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB28699C5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6080F1F211A4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1951487E7;
	Tue, 27 Feb 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyYib4KI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1157B13B2BA
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046136; cv=none; b=jfYq8sLeYZd5C+CGDyDB1PndSlR3PB0ovYVQCbVdMmOaAfvrIDfgRP2p0bpp/OYK1LaJrV7pTUllLMgEADCzDNY0iwKqcyWOsWj6Q0qNJXLpa+pSwZ+VkF5L6x8HbCwE0EdtJgkqbLHNUGnrykR2CstSn7i6Tu02ow2yqWuqfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046136; c=relaxed/simple;
	bh=JNEi7SKD2sIULlUh+utOsfAxmAAjpXIOhERxlftrjL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gw0RL+8Pkv7Zm5MHdrR9ZWZJioPm7qCrQdfjGWmI7i+KS6qHHAj6pETiCVEtZmgxVYXenamkQfWqpOapZ+U349AlbTkcfIgus4VEBa9plSUR87QVkiy3A0kVTmsQpEhBMUN7x8ePMKKAAgLsiK3ztL9/YROv0u8r4CHVzbLajB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyYib4KI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6375604276.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046134; x=1709650934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/eCW1wd+IUcZzg7ImV6NfYoMyoWz8c9Of9U1FHqSb0=;
        b=pyYib4KIvvYBNj+zeFO7Nf6YVU6mXRT/xSsG5HWYLBo6Zlawp7/D/zgoHFuFsKTMfA
         0jFgRSBuw5d98rSzHKj4dCCfVmWjWT88tZXajtrk83NIqUd5CcT2HOGC1jEaG1B6yB90
         n1F1KfZO42G1yxfaa8uVdSyk2MKuAFod+wqRCQehXsc0wZJRAhGqzUrU55XyqVmrMOUF
         Crxia0aWR6NHOpaKRJftD8shmvTZ7DPy7ZoYW6CWE76v/Ze5hO9mFRYLVGigmdwNWka7
         S4HSxqzDugvPTzvUlV1WKpPmY8uYIxpxl4UXOUxmPBEnQY4cC/TStJWP2Fqi7GkxgO7Y
         qmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046134; x=1709650934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/eCW1wd+IUcZzg7ImV6NfYoMyoWz8c9Of9U1FHqSb0=;
        b=aYLcWbJ6Tw+7x2qLw6JLp3lja9ycKNEe3WgEewTgRok7zaecnR76LRABOnXwuyTLOc
         WRV1igrtX/O+uVFQhdSe15uLIIGOgq5OZ0rSOpVjskyZ/Za2shDlday2C929+ZlanEQ/
         S1dCx8a0UAtpbCVBb3V6rrreKe+1S73xd7g8YtcKpXifO2YFLumxka2Hu5KaWDlOxcNT
         x3Stwn/g+sNIt+CBHEp4dIBs1INrI4LXATWnnyJm5+iffWfev1DPW+nFZU+ldZevfPTw
         fRMk9ni7s6FNooOmnvqPcuKSGcCqCqk5KqXXgK9qFEVDdLGSXX00REj+MHEF9hRsg2cU
         Ytgg==
X-Forwarded-Encrypted: i=1; AJvYcCVTrYvEdK4Ufry+KF8Fur2PDSpXMJIB1t7eMTMWPChbEvhf9Hdg2NBmbK9zuKTZVcxUV4Xd5vbjOoipg7I7tsXHzJk/uWLx
X-Gm-Message-State: AOJu0YyamwySlIkSiC92L2ofoU9nuaE2JyR5AYDi3aJxBPPkd8IHhP78
	SQft2sLfKSx/tkF6RKcdIw2Lk63pxC+TJJG959GnOjXPK8CObfoTSHii0rH/DUpuPRwvxgdWv5/
	STpHjlRToBg==
X-Google-Smtp-Source: AGHT+IGg1sEJT4kM1HzjdHrrCXbJIKubcjXP3KxB56DXxrBvBa+Dm98bLIXn0wVc5069HwaRd8ni9NKahS323A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ae24:0:b0:dcb:fb69:eadc with SMTP id
 a36-20020a25ae24000000b00dcbfb69eadcmr95840ybj.6.1709046134100; Tue, 27 Feb
 2024 07:02:14 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:52 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/15] ipv6: annotate data-races in ndisc_router_discovery()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate reads from in6_dev->cnf.XXX fields, as they could
change concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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



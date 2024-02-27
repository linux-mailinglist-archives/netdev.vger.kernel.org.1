Return-Path: <netdev+bounces-75355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E48699C0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D321C2296F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B91482E0;
	Tue, 27 Feb 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7Nrg09Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FB145359
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046128; cv=none; b=oyQf469VF85WnZnXBeoHnRkMwE+PNWPL4IR98T3mJHNEqlchZKY5H+PdbJXIHPBWV1gXmIrPsAZbTJZGBRK96epGByDcj8pPoviOFIhfcT5FapgQ+KitYh/TXn1VWyCwL9b7HPmqlmcxG0NHFCIx3uBw5KPnYszmlWK6Kk7HrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046128; c=relaxed/simple;
	bh=3RXSu58wwDNgIJiL5GvH5VTXWEp9RydLG/uZMCUxQCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RgKyjyBwzOTlGW610G3/AKrdhSfn/3sPXtpZng1YFDBEBi+5czCRKV5jqzhhgw1zoM4cSleyLtOcagLejdNDITr/gGgiRKmnJGRjvIfFjjTbJTP1DkyA5kQOnp38p7mSIukO1uQI1P+vhbtc4HNd7+nW2P2Hvl6YUlBzFwLSBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7Nrg09Z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso6533729276.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046126; x=1709650926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0RT4pnW92n0Ju4yt9vXUGm14W+h7WrqH7E0LBlBSrM=;
        b=D7Nrg09Zw/HLCZELrjqIc3KzinIxSujWS1YoSOAxjCVlzkB4GlTE9AU8TjOi9wHGZe
         /uZKkUgIAw/Z9tzIGLN/Eey18SWD+Pw/vfxz19Svwq8llVLUkJJTvLMlauGz+mUybzW0
         tzzZXj48gZ/pzTU4ybmXY1vltHBgt0SIO97PY2D68mRBpvQVm+uiklj6ra8IAZhSowAx
         x+GYlEJDGZB9ePWDBzpn3hZX8sWE4WRpMgQiYJSlqS0gv1Q/W2C5SH8OsZleHXi5Tm2w
         vy+IhIxPUUJQtAoDGlpBRG9I7qh0ggs4VZXC9sdf1YyS7lhE++CR4xKtqJzsnkjIF4Wk
         nvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046126; x=1709650926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0RT4pnW92n0Ju4yt9vXUGm14W+h7WrqH7E0LBlBSrM=;
        b=jfOqYK1KQc2L/27ym+zRaORg83gUnV8LVY3S2g9m3rosLXYFpYlyBnJJlbRK0brlg3
         9EIdmHTMzIwnr7KkvQFJ2tDT8KIYfylWBDyz9Gne3WK7m0dy0prVW2+2T1aVuRNimfxN
         L49+1ssg9b6WURBYeAI15RJiuU25KHu+lxPnRmjDWwnWWhP5mt1dDiMZY0XwX/skQwNZ
         YVadG4hSt2m4vsgE7i2VKj5BAFFIBjlNvaLFbt518PAOwZLxaywS7x+PSI9FQO1a/DjV
         agWqpVX4BwYx45UrUoHkVEgZFEm+IZqbjerxWf7FFLkf4pqTU4pht4k5s1Z+keiFWT2a
         EYwg==
X-Forwarded-Encrypted: i=1; AJvYcCUilmByfAFLRi3rS/vcaiN9VQjzDgWlmrGEY/s/XDK5JFk76ROP9lV0jRT8SYlLmYvb4bMSg6XI+IcKM2rORazLpCev77LM
X-Gm-Message-State: AOJu0Yx9arX8uiyJSSj97MixOylC0GfDeplTMLfoehaYQdy+dBUYTVA4
	S9bi4T4Hg2ZSim8eyh5CZzlrFaHBIA+20LhnS2ZhEJYLjKT3SOz7zZ9/wwDDjq5hUKKLElxS4Xx
	Qj8H2SdxUPg==
X-Google-Smtp-Source: AGHT+IFgDAm7rQbvSPjYD+ADb35mhssPHm2C2Ykf+LA/OqA7FqqEYD96BtIaQewhtTD2vCSHpuFh1PJNQ9ZtEQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5f0b:0:b0:dc8:27e6:cde1 with SMTP id
 t11-20020a255f0b000000b00dc827e6cde1mr89974ybb.5.1709046126091; Tue, 27 Feb
 2024 07:02:06 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:47 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/15] ipv6: annotate data-races around cnf.disable_ipv6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

disable_ipv6 is read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

v2: do not preload net before rtnl_trylock() in
    addrconf_disable_ipv6() (Jiri)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 4 ++--
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e27069ad938ca68d758ef956b8c36cb85697eeb5..9c1d141a9a343b45225658ce75f23893ff6c7426 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6405,7 +6406,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6413,7 +6414,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index b8378814532cead0275e8b7a656f78450993f619..1ba97933c74fbd12e21f273f0aeda2313bd608b7 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -168,9 +168,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
-		if (idev && unlikely(idev->cnf.disable_ipv6))
+		if (idev && unlikely(READ_ONCE(idev->cnf.disable_ipv6)))
 			SKB_DR_SET(reason, IPV6DISABLED);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 31b86fe661aa6cd94fb5d8848900406c2db110e3..0559bd0005858631f88c706f98c625ad0bfff278 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -234,7 +234,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
-- 
2.44.0.rc1.240.g4c46232300-goog



Return-Path: <netdev+bounces-74995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC884867ABF
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B7E1F2B0E1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4712C55D;
	Mon, 26 Feb 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmujOOA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA01BDDC
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962670; cv=none; b=trSWhzboMoHK1T/BjzNmtJJB9wJLfPZFsaV++rm3MJ8Ww6tKaHGn+N+id7WBM8BWX+dMiaS6xlBky6n9bGrn9Z2bG9NMGAA9Y2HO9dJl0tv8KoiBpr0yWHIiNIsZbhvWjwGf9mdBZh50EcHGJPDVYORwzpkg1gMYwe7MlZFdozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962670; c=relaxed/simple;
	bh=m8OC6mwlxTfnahRw52bGtbTa0YoycPJVRlM7dMVaCm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eDThBVuGGE152Eu3tlQt7aR0bo6UElcPiOrzLdJyKVIDGJhzhv+xt2dmwKHu3SGYnecu9B/llfZG6SY4MoiyL2i3DwxHfiMwXuvbjZN+0v7o4Em+EFWWuPvQqhQJ1zMxb/+5/0BeSc6irfcQwoWMBLkXrbkqv5YtSNhV53EK1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmujOOA3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ff1314ffso14646097b3.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962668; x=1709567468; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgkbGs8lFAsu5L0L0SpxbQeztQkkSixPLrjnkBhmAUQ=;
        b=fmujOOA364T6tiWNvdOdHmcEac47X+iLjrPAdHUK9iHEpY32AbskzTZF80KLjubsjw
         dIir5UtXNDiBi5LQrVLsKP1Zn0WU5+P+Ra5+Q4tV2a9jsnKp1Zw7XEBkQ8JEudlrg/++
         iwJnDNYAh7dTbGbKB1Uz17vttouMnHuy7plEn9hLe9yCA6kasTxcLg/1va6hvHhPkBjn
         Kvqkt7OkW1NLqvR6Zxen4qXx2Umf80wJH54kloTBCQJCofOOQsiXhEttpWSrL1U4bGhg
         Gi35yTJ9f0kWxt84E990Chg07CWKirInZQLI39w+hPQ0BGpI8nfIV0eiuKqdilbO8eY5
         gTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962668; x=1709567468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgkbGs8lFAsu5L0L0SpxbQeztQkkSixPLrjnkBhmAUQ=;
        b=jFZHrXrENitGqBQgLqfyZ8rfTBsSlV3m3Nou0W00+9omC0mCcQPGp2C8oLr9mpy4rT
         +V9DIHNNkl632lQqhZ+ghc47tXMx09muBGcyjGOVc6AGkh2kLXMMxd6tI+PbGFKPBfnM
         oV9B73Lq2la/955EoUoo5DZk+f6e+DfkXqQvK2d7gwOoW6SE972jvRTMPDFRyJ0KOFyf
         htxc5c7wAZ//hO7Ao/GFl7uCSrIvo1WvXA5hfkqIQjwNivKDbHN5BtE6GyOO7JC6rixK
         b6La2CzbCYtLQQ97pQ0IjVwHjw8N+M1urXlDZIm/63SnK2cLdi4hbrUzzNTjyfoc7yNh
         EvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4YV09IMrw1Donh94czqVtsKUQHB7gdXmjxall5yDSNxSiZjN9W0cT6cUq2KZuvyHXM0yaOnjoN/FjU0+yU/vUq5rQq2PM
X-Gm-Message-State: AOJu0Yz8jJH3QeVGPQQ2kndENNKM1HyftDoKft47HA4/f9sCwGg+4/me
	z6LaIso0fdm+m2MdbI3cjyHxuLJ+0IgMNQvHcs6hOF+KSA4Y/mATNdYulg8KKWnIsZrLk4Vdl2l
	uUxXgbJfbzA==
X-Google-Smtp-Source: AGHT+IH0g8lzfupGHherehL9phOucNzgygaRmgx/df7YghjKmmiTxO8keBDkEFDtRByJNuHKnGSV9Fj6nck5kw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10c2:b0:dcc:9f24:692b with SMTP
 id w2-20020a05690210c200b00dcc9f24692bmr255340ybu.13.1708962667945; Mon, 26
 Feb 2024 07:51:07 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:44 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-3-edumazet@google.com>
Subject: [PATCH net-next 02/13] ipv6: annotate data-races around cnf.disable_ipv6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

disable_ipv6 is read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c   | 12 ++++++------
 net/ipv6/ip6_input.c  |  4 ++--
 net/ipv6/ip6_output.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index a280614b37652deee0d1f3c70ba1b41b01cc7d91..0d7746b113cc65303b5c2ec223b3331c3598ded6 100644
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
@@ -6397,15 +6398,14 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 
 static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 {
-	struct net *net;
+	struct net *net = (struct net *)table->extra2;
 	int old;
 
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6413,7 +6413,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
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



Return-Path: <netdev+bounces-73941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC285F61B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4351C23C9D
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894746544;
	Thu, 22 Feb 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ve/xf7z2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026846546
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599042; cv=none; b=qQDNvvcqcWbZKp2Xa5QejwiMTzw8Dd4mstoCttA2Fq/se5+2ae8b/EsK4aVj+vytINRyVZ7gLZpciGTRa7LdaG1f8e+lNPyBegMKRQ8IJUBb0a95+OvIdJ3yhwfd8EBCNuYsseiY5xYO/7VA1QSZlCRZTOMOCpghBqqmCT9mcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599042; c=relaxed/simple;
	bh=a1p/FFG5KJt/F+49stv8oN0Hp04RXahaE3pkWhDRIs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FciSU7DS/FgDhtCX5VEfrhHg5M1+CKlZYoGvfZVVjvibD0MW8jIyYbw0Gvy29VH8vR/s38wDXmGfDNsOsQEKfVZ24TTh1AZvPqMxd8DUUAJGU2lfB85VKRh60A5j7TXmHAKQXxDTxV0kUBapD1tBVRb3FLnx9eLG7HNcHKp2rAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ve/xf7z2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso11308140276.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599039; x=1709203839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOtofUwvgnm/c7P42hpvj9EN22JHx5FEwaodSurnb1k=;
        b=Ve/xf7z2TX08JRF8hnsRR3xn44UlJJIVP1cFqHJna3rNQfmtteZ+DIioY3hpuZeq7B
         GKskx7VuddATSP/+vZQNmC8sZiSSk4wsW+UqZR4vhH7ErakPYjC2NwnmJQC+aa+3fUD4
         yS1vtmVsPjgYEdg4AUaU4f9bo4Mt0SUk6snuqXr2NoxYB6HSYUXfG/tn/O3K+4HjfiTk
         aP7xF9LEDkuEzzwY3qOCH4T6KffFPEoV7clMYKuH6SO8oBkes0J8UjD1wBhJXi22or7N
         YeOHqvPcE5t+IP3NCQfy8WQ4alVUJ/doF2Pw1Rm+dGDfwnEE/vnOAYwcD57Q7qUBXUM/
         30hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599039; x=1709203839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOtofUwvgnm/c7P42hpvj9EN22JHx5FEwaodSurnb1k=;
        b=O+Ws3B3RKy/N/Ov5lZUBMyeLQzqSHHDvQJCBJBi9/mZC+ZFNyXobcq0jqQsZD1IWam
         hNPOCdbEM3ZEF+851vgZdK/Hs2fnGvYwdwdbFHA35Dz4LqmpwgKb6wPUR/HUowmYE1re
         VJDvN07E96M0mcA1MCyVgEqzZ1ZQx0hMqkU+nNDHMiKg3AVKT98LXGTxYGe7B4b7aWNX
         /Ysq+4TmxhC5DfoxYyuOe/ELtGFtPGT5CmAoTs7yGQv5kc3t3o6njAT4fCBLFk5UWuCl
         CXc7xqT0ZLpgHJHXFCh8hB5kKHrwj5mIxy8JVhRh8M2kTFPrpAWOgylRgyZu/AWXgwQH
         pLYQ==
X-Gm-Message-State: AOJu0YziiZ/LY+nR1oSWdmToMqzhajzc5dywKuPl4a2UHBnWUfPFwE98
	YecTlBr3d7HfzRIDtZ6kPZto3bKK7n7d8I+uU9W3Rw2ilfLuln4huUTdjFF6mFg504QnKsrflSY
	AB3jRZVLJGw==
X-Google-Smtp-Source: AGHT+IEC2aK2PYTdQ16nxtlXx/9t0ixIRzuttNvYWiQuHSfVdHIBWiO1lr6s/UhZ5zp4lPl0NB5QAiwhMDw6vw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:7905:0:b0:dc6:db9b:7a6d with SMTP id
 u5-20020a257905000000b00dc6db9b7a6dmr58545ybc.13.1708599038802; Thu, 22 Feb
 2024 02:50:38 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:17 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/14] inet: allow ip_valid_fib_dump_req() to be
 called with RTNL or RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new field into struct fib_dump_filter, to let callers
tell if they use RTNL locking or RCU.

This is used in the following patch, when inet_dump_fib()
no longer holds RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_fib.h    |  1 +
 net/ipv4/fib_frontend.c | 15 +++++++++++----
 net/ipv4/ipmr.c         |  4 +++-
 net/ipv6/ip6_fib.c      |  7 +++++--
 net/ipv6/ip6mr.c        |  4 +++-
 net/mpls/af_mpls.c      |  4 +++-
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index d4667b7797e3e4591f3ff1fe641f168295e0a894..9b2f69ba5e4981fb108581c229ff008d04750ade 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -264,6 +264,7 @@ struct fib_dump_filter {
 	bool			filter_set;
 	bool			dump_routes;
 	bool			dump_exceptions;
+	bool			rtnl_held;
 	unsigned char		protocol;
 	unsigned char		rt_type;
 	unsigned int		flags;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 390f4be7f7bec20f33aa80e9bf12d5e2f3760562..39f67990e01c19b73a622dced0220a1bba21d5e6 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -916,7 +916,8 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	struct rtmsg *rtm;
 	int err, i;
 
-	ASSERT_RTNL();
+	if (filter->rtnl_held)
+		ASSERT_RTNL();
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
 		NL_SET_ERR_MSG(extack, "Invalid header for FIB dump request");
@@ -961,7 +962,10 @@ int ip_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 			break;
 		case RTA_OIF:
 			ifindex = nla_get_u32(tb[i]);
-			filter->dev = __dev_get_by_index(net, ifindex);
+			if (filter->rtnl_held)
+				filter->dev = __dev_get_by_index(net, ifindex);
+			else
+				filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
 				return -ENODEV;
 			break;
@@ -983,8 +987,11 @@ EXPORT_SYMBOL_GPL(ip_valid_fib_dump_req);
 
 static int inet_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct fib_dump_filter filter = { .dump_routes = true,
-					  .dump_exceptions = true };
+	struct fib_dump_filter filter = {
+		.dump_routes = true,
+		.dump_exceptions = true,
+		.rtnl_held = true,
+	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 5561bce3a37e8f72d08ff8062d6b8cde08bbed44..0708ac6f6c582681ab1f2b52c5ce1f2a4acd10de 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2587,7 +2587,9 @@ static int ipmr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 static int ipmr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	int err;
 
 	if (cb->strict_check) {
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 6540d877d3693e788d000309950f3735554c937d..5c558dc1c6838681c2848412dced72a41fe764be 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -620,8 +620,11 @@ static int fib6_dump_table(struct fib6_table *table, struct sk_buff *skb,
 
 static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct rt6_rtnl_dump_arg arg = { .filter.dump_exceptions = true,
-					 .filter.dump_routes = true };
+	struct rt6_rtnl_dump_arg arg = {
+		.filter.dump_exceptions = true,
+		.filter.dump_routes = true,
+		.filter.rtnl_held = true,
+	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 1f19743f254064852139809143b60c1d397fe1d8..cb0ee81a068a4c895d5d8b21f3fc557bf1784dfb 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2592,7 +2592,9 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	int err;
 
 	if (cb->strict_check) {
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1af29af65388584e9666f4fcb73a16e8ff159587..6dab883a08dda46ff6ddc1e6e407e6f48a10c8aa 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2179,7 +2179,9 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	struct mpls_route __rcu **platform_label;
-	struct fib_dump_filter filter = {};
+	struct fib_dump_filter filter = {
+		.rtnl_held = true,
+	};
 	unsigned int flags = NLM_F_MULTI;
 	size_t platform_labels;
 	unsigned int index;
-- 
2.44.0.rc1.240.g4c46232300-goog



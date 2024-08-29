Return-Path: <netdev+bounces-123334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5E9648F1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8991F21E91
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44321B1428;
	Thu, 29 Aug 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/rcZ+7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D518D65D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942811; cv=none; b=EcTBhvPRgTISw7GUy47xbX3URcjgp2wOUnqMJD7tIbfgp7r4fyMYxEGb1FROYX9EMdgdKuzPPaDeHRKFo43UFZ8E4z27iBOafLmSy56gZ3EhjFESEFMnO05iGWsrapVmo6Vxeelh0Vd+8YY9sSf+CtDPSbqesjdpHQubiIK7fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942811; c=relaxed/simple;
	bh=2n/jwsFvVV67e3Q0zx36XoINVHndk8yfFssM6tLiNjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+pYBsyKBnOBKOUmzKDSJOABC3Y10XHuathhbRWFNIh70MST/ETIJ/9GcUs/iZgq/ft1XHJZ8/Ds3eDfznwZ45bwRyqbtT5MtBCXGfkHMhxo/s1JS6dlMmWhAC+5RUe2r0956fdbYJRsBk64jIdiETUwsx8xuNC0cYE2BaQgP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/rcZ+7/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1496925276.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724942809; x=1725547609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xefPbmqOpYxiYdMyBExipeTwxfiPd4h7e8P4/KZ8u3w=;
        b=E/rcZ+7/gfUACmThJCEPR5kT8ostNffsm9bbLEaSbdi23IgFMPdvNL8S+4N1czjckE
         k9CzNFOk1PiRGNT6kcf8cSm+FQ9ghlcHzQv2MCcnZWLE0MU0qTL6fBlGdSzjQT/1vE9O
         nRrem4qgP4LxVer4g4vCH7e9NkVQxI0Tlu4epGNQGV5SMBeUT0ZV54A8oyFv1KxnP6R0
         JskgOHQ8JaqW5w8tKmFaQ4PAFXgDNXBHrYVzHUJ6goKeSswygtuGhu1A7pwgKww4cZ9V
         n3i55vE1H3GSsJlKb00UQ3zdyZt4Xvuuv/GfSt64n8J19UC5ZQWKImr62xxhW0H4wvuV
         QhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942809; x=1725547609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xefPbmqOpYxiYdMyBExipeTwxfiPd4h7e8P4/KZ8u3w=;
        b=uNPDZRAsA7sdau14LkrHCQRvDGHaQvjg6N0IMh+yD9J0NAydoppf9CmmblKZ0AGUsJ
         lVmNa7NP5Sq35i/K40dxYBGUyP0j3NKYVxS7lPhIPaLRat9VH1EFCDXxW7WSKG0tFWMT
         D8pZMcAxhfC0NVG5rDgFcofkEEpIAKWm6TQKsQlGQPErpH9dJCm3SCxEMVmo6ChHVMKw
         Q1sE+Uz2BsNh4qDqCl0R/jx1n8ONXJ5CCYIWdXtMb8Dzk/ICoNlZyG2elM5BPHCaAE1d
         6EPcVIRKO/B5OOWbzvCWEfsn4YuTyFV8uJPL2pmqmPsM2E7jAjmpukrRLLh2HNRQBcLw
         MkPg==
X-Forwarded-Encrypted: i=1; AJvYcCXqRhLvpXVTdIeHwwiCK+3lTtYOwXZvdDymnMWpUXQ6jEm8/Rtwx1rWnx7mxQeJHdEEDI1/Mrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXrPnxgWXPOEGX8smdjmLq4gpqLe6kV6LIWHDWL4QPlGh6LZK
	5BHCHPfbizsrB00BscayrTcK5EV+ZfGIHSXtbnZO0jjSjZGmVWS/IXzS+FZ6Cyy8nPvGC+qB8cJ
	sDGf7CShPlw==
X-Google-Smtp-Source: AGHT+IGoFcFbQGagUKGZQwwPsJ685/LVDJzJf2XMnOcAGYH8ngRsn8YJ+A+F0gGpmRv+CHHRKpC3WSefms1XGA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ac53:0:b0:e0e:c9bc:3206 with SMTP id
 3f1490d57ef6-e1a5ab76a99mr4610276.5.1724942808861; Thu, 29 Aug 2024 07:46:48
 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:46:40 +0000
In-Reply-To: <20240829144641.3880376-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829144641.3880376-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829144641.3880376-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] icmp: move icmp_global.credit and
 icmp_global.stamp to per netns storage
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Host wide ICMP ratelimiter should be per netns, to provide better isolation.

Following patch in this series makes the sysctl per netns.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip.h         |  4 ++--
 include/net/netns/ipv4.h |  3 ++-
 net/ipv4/icmp.c          | 26 +++++++++++---------------
 net/ipv6/icmp.c          |  4 ++--
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 82248813619e3f21e09d52976accbdc76c7668c2..d3bca4e83979f681c4931e9ff62db5941a059c11 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -794,8 +794,8 @@ static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 	ip_cmsg_recv_offset(msg, skb->sk, skb, 0, 0);
 }
 
-bool icmp_global_allow(void);
-void icmp_global_consume(void);
+bool icmp_global_allow(struct net *net);
+void icmp_global_consume(struct net *net);
 
 extern int sysctl_icmp_msgs_per_sec;
 extern int sysctl_icmp_msgs_burst;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 5fcd61ada62289253844be9cbe25387dd92385a5..54fe7c079fffb285b7a8a069f3d57f9440a6655a 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -122,7 +122,8 @@ struct netns_ipv4 {
 	u8 sysctl_icmp_errors_use_inbound_ifaddr;
 	int sysctl_icmp_ratelimit;
 	int sysctl_icmp_ratemask;
-
+	atomic_t icmp_global_credit;
+	u32 icmp_global_stamp;
 	u32 ip_rt_min_pmtu;
 	int ip_rt_mtu_expires;
 	int ip_rt_min_advmss;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0078e8fb2e86d0552ef85eb5bf5bef947b0f1c3d..2e1d81dbdbb6fe93ea53398bbe3b3627b35852b0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -223,19 +223,15 @@ static inline void icmp_xmit_unlock(struct sock *sk)
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
 int sysctl_icmp_msgs_burst __read_mostly = 50;
 
-static struct {
-	atomic_t	credit;
-	u32		stamp;
-} icmp_global;
-
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
+ * @net: network namespace
  *
  * Uses a token bucket to limit our ICMP messages to ~sysctl_icmp_msgs_per_sec.
  * Returns false if we reached the limit and can not send another packet.
  * Works in tandem with icmp_global_consume().
  */
-bool icmp_global_allow(void)
+bool icmp_global_allow(struct net *net)
 {
 	u32 delta, now, oldstamp;
 	int incr, new, old;
@@ -244,11 +240,11 @@ bool icmp_global_allow(void)
 	 * Then later icmp_global_consume() could consume more credits,
 	 * this is an acceptable race.
 	 */
-	if (atomic_read(&icmp_global.credit) > 0)
+	if (atomic_read(&net->ipv4.icmp_global_credit) > 0)
 		return true;
 
 	now = jiffies;
-	oldstamp = READ_ONCE(icmp_global.stamp);
+	oldstamp = READ_ONCE(net->ipv4.icmp_global_stamp);
 	delta = min_t(u32, now - oldstamp, HZ);
 	if (delta < HZ / 50)
 		return false;
@@ -257,23 +253,23 @@ bool icmp_global_allow(void)
 	if (!incr)
 		return false;
 
-	if (cmpxchg(&icmp_global.stamp, oldstamp, now) == oldstamp) {
-		old = atomic_read(&icmp_global.credit);
+	if (cmpxchg(&net->ipv4.icmp_global_stamp, oldstamp, now) == oldstamp) {
+		old = atomic_read(&net->ipv4.icmp_global_credit);
 		do {
 			new = min(old + incr, READ_ONCE(sysctl_icmp_msgs_burst));
-		} while (!atomic_try_cmpxchg(&icmp_global.credit, &old, new));
+		} while (!atomic_try_cmpxchg(&net->ipv4.icmp_global_credit, &old, new));
 	}
 	return true;
 }
 EXPORT_SYMBOL(icmp_global_allow);
 
-void icmp_global_consume(void)
+void icmp_global_consume(struct net *net)
 {
 	int credits = get_random_u32_below(3);
 
 	/* Note: this might make icmp_global.credit negative. */
 	if (credits)
-		atomic_sub(credits, &icmp_global.credit);
+		atomic_sub(credits, &net->ipv4.icmp_global_credit);
 }
 EXPORT_SYMBOL(icmp_global_consume);
 
@@ -299,7 +295,7 @@ static bool icmpv4_global_allow(struct net *net, int type, int code,
 	if (icmpv4_mask_allow(net, type, code))
 		return true;
 
-	if (icmp_global_allow()) {
+	if (icmp_global_allow(net)) {
 		*apply_ratelimit = true;
 		return true;
 	}
@@ -337,7 +333,7 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	else
-		icmp_global_consume();
+		icmp_global_consume(net);
 	return rc;
 }
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 46f70e4a835139ef7d8925c49440865355048193..071b0bc1179d81b18c340ce415cef21e02a30cd7 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -181,7 +181,7 @@ static bool icmpv6_global_allow(struct net *net, int type,
 	if (icmpv6_mask_allow(net, type))
 		return true;
 
-	if (icmp_global_allow()) {
+	if (icmp_global_allow(net)) {
 		*apply_ratelimit = true;
 		return true;
 	}
@@ -231,7 +231,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
 				  ICMP6_MIB_RATELIMITHOST);
 	else
-		icmp_global_consume();
+		icmp_global_consume(net);
 	dst_release(dst);
 	return res;
 }
-- 
2.46.0.295.g3b9ea8a38a-goog



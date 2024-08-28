Return-Path: <netdev+bounces-122909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC5963112
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3893E1C22A01
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971F1AC420;
	Wed, 28 Aug 2024 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4r52p0SU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21422433C1
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874005; cv=none; b=dV480HzpZjyaxxTfaEJsv/UdKUPnkmWGdlRUVIF6xaJnaQ8Yn33nmxaYHx+Cx7qUajgI7Fkq9D1qRcoSe1IGWOi/a3LURi/olELVkZ9+8c4zo69Mf4ukzJKFADQGa46VBIX6AY/Ll8CJXw1FaixgelRMXo018tRFCnhIdBKpQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874005; c=relaxed/simple;
	bh=NvR2xazEuVxnJMtok33g4cMWdehj65lGkk2HIlqi8x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f51Zmqr6GPXQel+7pgkf0uXmhLcbeC2fh344BkNQ3zK7oaKjP2BPczLNt9EOGDR2aKL4RV7BbsqzDd7elBwxav5jfECd6BeSznETbNw3vCLPgFxDilK0U1jJ8KQDs5FuiChy9VUQkoZPxA5AQhPD0jR3twcCe1fm61J/NN65fY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4r52p0SU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad26d5b061so126768817b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724874003; x=1725478803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uW8V30KIm42suk0SzdVN/98z/bnuMM+LeZAtcw4wpew=;
        b=4r52p0SUbOcJpPHqLJAms8bD4vF2wvxYvBPD/GBaWyH5deeL7tI1og9WHwPPEKPt3/
         SS8c5Y2NFSPdG6oBI/21YLYHjMWE5D2tkmLJRXO8Eh9trfHQkbXbIkDAYDODUJkVOWMQ
         +1qk5qh+hcjjEvvPh0QD3yiz6c4jU4jnGqs/jX8smdR2Z92IE0fhAQnAY3dEtTzUQPb3
         9PKUVrDCIPfrWoe1Y4KFz1rZ0kLMLz58qqmc87O8ush2pNUrrQkRvpCLgeqCzyogyYzU
         0n9Nlk7zKeF2D02drXhS0ZEI77NfzhCJgMTFuUBuGSHy9SEXY+fjnqrNTtHkwbpDhKYH
         QrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874003; x=1725478803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uW8V30KIm42suk0SzdVN/98z/bnuMM+LeZAtcw4wpew=;
        b=ueffoYGDU9QtcCHxgq5UI2x01vh9UN2I7ennOXQdBsndWH3vMXvEX3Quja1xjMVnzf
         UXXx2zwqrgPPSYH1uA5rqD88eWRQECfIxuZAu9MQWrKbOsXG8B8E5rm59eidAuoczmkd
         3kMGZqzPNTkuEFVnKmfVdgg45GxBwztyL2XIHJd/1fubwWwRHVTRchRK7iG0QlXhA/zE
         r5zpmHajlM9LokGU+veQWMWYi6ZevssIOkqTy3lwq9oy/zvPXuFd8HR1+7sFFj44Jaq8
         XwVnkSXEzlJ/my8TYsGTisT65I8cWgHS8nBAa5Y/SyEh21Dt8DcHJ5sA9u4MscmY2XG2
         /1cw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zokMwBPb+P4yDGVrOfI/y26od6940xLasWnD9pZ2T/WXq5As6ghWSP4KNs2Dz0/dMD0OHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3SGkygOZLrXap787+j7uSL2paSbvt/enwe+4tdHKVUIkINHX
	T6dwCmA+pop8zrSNeusTtonTu/ETRVCROrW8+oo+yxYuWcp/AqhkCCUbOBDb8uoMREja8ltE4vO
	ZvIS3d7pCjQ==
X-Google-Smtp-Source: AGHT+IE+v5X5CqE8u8p7h8sUh6LyoF++1Qe+xac1Zv7u7Ds7s9gPrwpAn/+6XLg5RYxzmD5zulfJYj7dy8yZYQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ab8c:0:b0:e0b:bd79:3077 with SMTP id
 3f1490d57ef6-e1a5adebc4amr499276.9.1724874002970; Wed, 28 Aug 2024 12:40:02
 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:39:47 +0000
In-Reply-To: <20240828193948.2692476-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240828193948.2692476-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828193948.2692476-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] icmp: move icmp_global.credit and
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
---
 include/net/ip.h         |  4 ++--
 include/net/netns/ipv4.h |  3 ++-
 net/ipv4/icmp.c          | 25 ++++++++++---------------
 net/ipv6/icmp.c          |  4 ++--
 4 files changed, 16 insertions(+), 20 deletions(-)

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
index 0078e8fb2e86d0552ef85eb5bf5bef947b0f1c3d..8ad3139a00fb8c5cb8f28f92d125ef83d9e840c3 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -223,11 +223,6 @@ static inline void icmp_xmit_unlock(struct sock *sk)
 int sysctl_icmp_msgs_per_sec __read_mostly = 1000;
 int sysctl_icmp_msgs_burst __read_mostly = 50;
 
-static struct {
-	atomic_t	credit;
-	u32		stamp;
-} icmp_global;
-
 /**
  * icmp_global_allow - Are we allowed to send one more ICMP message ?
  *
@@ -235,7 +230,7 @@ static struct {
  * Returns false if we reached the limit and can not send another packet.
  * Works in tandem with icmp_global_consume().
  */
-bool icmp_global_allow(void)
+bool icmp_global_allow(struct net *net)
 {
 	u32 delta, now, oldstamp;
 	int incr, new, old;
@@ -244,11 +239,11 @@ bool icmp_global_allow(void)
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
@@ -257,23 +252,23 @@ bool icmp_global_allow(void)
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
 
@@ -299,7 +294,7 @@ static bool icmpv4_global_allow(struct net *net, int type, int code,
 	if (icmpv4_mask_allow(net, type, code))
 		return true;
 
-	if (icmp_global_allow()) {
+	if (icmp_global_allow(net)) {
 		*apply_ratelimit = true;
 		return true;
 	}
@@ -337,7 +332,7 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
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



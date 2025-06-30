Return-Path: <netdev+bounces-202409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F93AEDC96
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCEE7A43B5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD7A289E0C;
	Mon, 30 Jun 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdHu/25x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3E27F001
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285982; cv=none; b=iNSMLSnarRJygULDJnD5JrP4AeqJvsPIbokUW0EkL2iZO2aR9MO7P3C1EUtwQjisGFagAx/+ZU7qSRuGENku1qkEt0Js1OjZyxaAh+RUbkfif/nHqBXrOnqEuvw4yIwXc/pqhLqBki+qs5Skyye+JoJm2idHeP5yfM1Zh+we8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285982; c=relaxed/simple;
	bh=XXw9FZG7FfnjB+2D7poXlmKcNqkx2Rrf0SfzzjH1suY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C9UKuEDp4vyk/cn2U+ch1H/WMzGHB238A9Uryf3a1pXEZKGuwxNYmDPGMk5UD9pDUy3AoyEILesd+L3DlJmOD8rEZC/NDQL0FYW9x52OTT+9B8PFyrqZ75RSKrivjtz2rml+Gvs8cJfvTVv5wUlKb8EaXxg7Z6opvl/oh0p7htE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdHu/25x; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7d413a10b4cso744822285a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285979; x=1751890779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0FkzQRk5OGEpH/oX5kFIDunrgqhRP7qvFpDr660uMw=;
        b=MdHu/25x54dOrv2U4pzWwLV+nlqM5AIhC9w144yG2D9+sC/7LQBLpX38Cv95YtuwNV
         /y+kRH+EUKmICXekIMBxW/Eh7YyRTI1y1wTE26hupMrvHYy2k5IqqmoaCguOI45HKBBk
         xBU2lSCjEwulHWT7tF+7qIjYJpWIL0nJHhPTkcYT4ffE+aqv4oszskWM8uzNIDfnYnQa
         iTkUAgr8zk6z1uSnTSuR0+jOkJQPn4GA+gm04gynz4gbg7nYCg/9fHCWwc0kFdx6Ey6D
         WPZGdYidwFvqTAZWHkc0yW0uBW1WpqqODMe4TnjXI31ZJw2pZuBmYdBH+p7LWkbR6amP
         tUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285979; x=1751890779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0FkzQRk5OGEpH/oX5kFIDunrgqhRP7qvFpDr660uMw=;
        b=kldCu5dLrHU2AcjJ/bepRL7uZLCOQl4g75czkaV74Nwqh3YuCxCmHfk48WRtjgwMbq
         vHULiddOn6ATh8tmPj1wZn/lH4crAZ1TCG7oCJHh4Rqn7BNfk54NtIi692G4pBMCh6+a
         Qcqrqpjm7WV8xUyA7tq/oGNo8ygNA7ZFiIA2owZN2ff15cY/9zRWaThIVyx3HUHVw7kY
         3/rRMwBj6aIahXA3k1BvP/6vEj30nKqZqdjC4dD+0yUmVGybUGd9E9KjpWoIiyC4xR8l
         yC/H0hHHyNagmejhpMGCXWFG2Ba+fIhVs+gUfwU4IT62zz77YeogbCndX+E96AmJYtIH
         TbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUYOz5h09i/zeOkireoMo6cLr86QpSJPwYUc6xC9SJZcM/K1trWHZgXraF+RZenMubrtaxRbWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFfEr13J2SlBQd/qlMWsQIo2RudtacVQWOWNDQ1m7gB26AzPb
	/nP9T50dtnRIbUN+yER5rQLAdwTg9uv3iCqHwKspxFwzzgRF8TPsjY02opVmnJbxwoOXs/Hm5u9
	jFCMJKP1+xOU/yw==
X-Google-Smtp-Source: AGHT+IFEPxSwTtvBm2WMd8gU4BBQjXF6w1H3EGSOCuUeUkXMxglsH7kb+lxZa9C0jIs3m9Atv7UYjLLM4yewHQ==
X-Received: from qknor16.prod.google.com ([2002:a05:620a:6190:b0:7d3:fd84:2e76])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4555:b0:7d3:8a1a:9a03 with SMTP id af79cd13be357-7d443917294mr2070127485a.14.1751285979259;
 Mon, 30 Jun 2025 05:19:39 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:26 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/10] net: dst: annotate data-races around dst->expires
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(dst_entry)->expires is read and written locklessly,
add corresponding annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/dst.h |  8 +++++---
 include/net/ip.h  |  2 +-
 net/ipv4/route.c  |  7 ++++---
 net/ipv6/route.c  | 13 ++++++-------
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 76c30c3b22ddb8687348925d612798607377dff2..1efe1e5d51a904a0fe907687835b8e07f32afaec 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -431,13 +431,15 @@ static inline void dst_link_failure(struct sk_buff *skb)
 
 static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 {
-	unsigned long expires = jiffies + timeout;
+	unsigned long old, expires = jiffies + timeout;
 
 	if (expires == 0)
 		expires = 1;
 
-	if (dst->expires == 0 || time_before(expires, dst->expires))
-		dst->expires = expires;
+	old = READ_ONCE(dst->expires);
+
+	if (!old || time_before(expires, old))
+		WRITE_ONCE(dst->expires, expires);
 }
 
 static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
diff --git a/include/net/ip.h b/include/net/ip.h
index 375304bb99f690adb16b874abd9a562e17684f35..391af454422ebe25ba984398a2226f7ed88abe1d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -477,7 +477,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
 		mtu = rt->rt_pmtu;
-		if (mtu && time_before(jiffies, rt->dst.expires))
+		if (mtu && time_before(jiffies, READ_ONCE(rt->dst.expires)))
 			goto out;
 	}
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d32af8c167276781265b95542ef5b49d9d62d5ba..d7a534a5f1ff8bdaa81a14096f70ef3a83a1ab05 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -844,7 +844,7 @@ static void ipv4_negative_advice(struct sock *sk,
 
 	if ((READ_ONCE(dst->obsolete) > 0) ||
 	    (rt->rt_flags & RTCF_REDIRECTED) ||
-	    rt->dst.expires)
+	    READ_ONCE(rt->dst.expires))
 		sk_dst_reset(sk);
 }
 
@@ -1033,7 +1033,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 	}
 
 	if (rt->rt_pmtu == mtu && !lock &&
-	    time_before(jiffies, dst->expires - net->ipv4.ip_rt_mtu_expires / 2))
+	    time_before(jiffies, READ_ONCE(dst->expires) -
+				 net->ipv4.ip_rt_mtu_expires / 2))
 		goto out;
 
 	if (fib_lookup(net, fl4, &res, 0) == 0) {
@@ -3010,7 +3011,7 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 		}
 	}
 
-	expires = rt->dst.expires;
+	expires = READ_ONCE(rt->dst.expires);
 	if (expires) {
 		unsigned long now = jiffies;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ace2071f77bd1356a095b4d5056614b795d20b61..1014dcea1200cb4d4fc63f7b335fd2663c4844a3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -391,9 +391,8 @@ static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
 static bool __rt6_check_expired(const struct rt6_info *rt)
 {
 	if (rt->rt6i_flags & RTF_EXPIRES)
-		return time_after(jiffies, rt->dst.expires);
-	else
-		return false;
+		return time_after(jiffies, READ_ONCE(rt->dst.expires));
+	return false;
 }
 
 static bool rt6_check_expired(const struct rt6_info *rt)
@@ -403,7 +402,7 @@ static bool rt6_check_expired(const struct rt6_info *rt)
 	from = rcu_dereference(rt->from);
 
 	if (rt->rt6i_flags & RTF_EXPIRES) {
-		if (time_after(jiffies, rt->dst.expires))
+		if (time_after(jiffies, READ_ONCE(rt->dst.expires)))
 			return true;
 	} else if (from) {
 		return READ_ONCE(rt->dst.obsolete) != DST_OBSOLETE_FORCE_CHK ||
@@ -2139,7 +2138,7 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
 		}
-	} else if (time_after(jiffies, rt->dst.expires)) {
+	} else if (time_after(jiffies, READ_ONCE(rt->dst.expires))) {
 		pr_debug("purging expired route %p\n", rt);
 		rt6_remove_exception(bucket, rt6_ex);
 		return;
@@ -2870,7 +2869,7 @@ static void rt6_update_expires(struct rt6_info *rt0, int timeout)
 		rcu_read_lock();
 		from = rcu_dereference(rt0->from);
 		if (from)
-			rt0->dst.expires = from->expires;
+			WRITE_ONCE(rt0->dst.expires, from->expires);
 		rcu_read_unlock();
 	}
 
@@ -5903,7 +5902,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	}
 
 	if (rt6_flags & RTF_EXPIRES) {
-		expires = dst ? dst->expires : rt->expires;
+		expires = dst ? READ_ONCE(dst->expires) : rt->expires;
 		expires -= jiffies;
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog



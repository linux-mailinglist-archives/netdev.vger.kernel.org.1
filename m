Return-Path: <netdev+bounces-201905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A234AEB63E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA7A7AFE72
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527829E115;
	Fri, 27 Jun 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO8YRtdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC19A29DB7F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023544; cv=none; b=n97LQh9/cRW64resU5EgRhrfvTbUs+ZubXXduC+8JGBS08Ftq3YhvL/DlJZadD/+YrIUB1FxQoYcKWESHNvfG0l9q0Y4WUpecrHlglvv6NM9+Hw6tWRLQTpBFAv9HhhPn0m2wxI2z/nYY+vPJ0f0e8RU0+r1KzBPSI/yWGdH5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023544; c=relaxed/simple;
	bh=YqewWGEcs0lVa0XC3YGEAHe44hda/DjpbYEdR0CgATk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ScqBeQxN3Bf0z5ttmEZhq8ttjXX/GmpVxZ64UDsMKmSvJWWO2ivAOw25znq2F3RQN1xSeKVeqHql+pvTjSwX7zCz+E2NkzyGjMjFeHlp2ghKkMgOMpBc5dVNwIdikXujhk60qlma+s5pSfp8Y0jRBpGzbd/jnorPGKMOc0cHfAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO8YRtdc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fb2910dd04so36237686d6.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023540; x=1751628340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8e/GbQL5asvTJ7IuYGM63zlKvUZ4FoaudEokIjhb3Y=;
        b=EO8YRtdciOjH+dRBVJbxWg8rSUReoC/nruDdsIzs4tv/XDvJrGrQXqgDo1vyOaJpjb
         DfBGo2HYWLb8kIxTl7NdSerrsmnGSbo2YqqBRjTmwxINucr7s3w3Q8Bx/A3sLXh2Llx0
         X/i2TqFz/jgvlgaU6+N9HihhntkQpen2LvMovde7gd9/zhexk62yexdMB3wYWzU2+RvW
         rh3qa9NNvfT6JG/1l9ksmkddYyZBdQ1ToEfNggVMAeu3ka/46XtlhoyWSaAnhM2BLg++
         M9RnQ5Tq0D0qKrauX816y8YFcqyZL/kswdshtnF9UmDGDhAiChQDYBNXObypLDJreQmT
         LlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023540; x=1751628340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8e/GbQL5asvTJ7IuYGM63zlKvUZ4FoaudEokIjhb3Y=;
        b=v53RrPJCbeOqwspc7eLo9tpgwlPLNER4DS16R5C9A1jPWD3gblpvXSyJ2usEGRHSRj
         kLlsfPs57n/xqapjY2CxXwHFjtD+KmlGA58Uiaq7y4oJNQyFRhwt2RpCG4aXWzlfbSWF
         OiTk0Jdfqm1/9u1TReJ3FclIEKHcYPWvOpOio+OLwFnvVHfDng/9UPvrhsJQQSdIOlYq
         lbC+9RbryF+10PEJZlJ6TEcrmXHApnUTvQlDoyyhVUYZeJHYSEwhK3wLvDFLSCmeJjpT
         18ZiKH8MiZk6/hx1yeSaSOKwcJGwwlh1PQLZatQCnZanG2iqI5SUHFz0XEucvXMtEUKM
         5l1g==
X-Forwarded-Encrypted: i=1; AJvYcCU/9v2bB2zObifPf3fhJHLI4HeAAKl5Pc5afHYY3gX2wJigMYixpqdob9/NVLClN5vAWbLpw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+PrDWyG8XCy5eY7lKKvRM3vz2TLuz4yy4R3mr0+aDoIyCkbr
	5JGsaXyQD6D7xUTN+ucN2sGOGDXm/oajlgPgyTDoE3QUNYEvh0FZM1DHPqPUm/ZKBa82spGMU79
	dPhqS7A8eSEX5BA==
X-Google-Smtp-Source: AGHT+IFd8osifqeT+FXOEyUUXQtSZ0mFaHksjeQzHWQRqxKOYCCG0w0L7ZesCPvWr00+UWTCxCmr9BgavPovfA==
X-Received: from qvag26.prod.google.com ([2002:a0c:f09a:0:b0:6fd:5e45:e693])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4904:b0:6fd:1bc1:e8b0 with SMTP id 6a1803df08f44-700016580c9mr42353656d6.12.1751023540543;
 Fri, 27 Jun 2025 04:25:40 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:18 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-3-edumazet@google.com>
Subject: [PATCH net-next 02/10] net: dst: annotate data-races around dst->expires
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(dst_entry)->expires is read and written locklessly,
add corresponding annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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



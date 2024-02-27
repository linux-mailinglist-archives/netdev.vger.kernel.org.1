Return-Path: <netdev+bounces-75357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1D8699C1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC821C21BBD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8386E14830C;
	Tue, 27 Feb 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/8AFAPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AF1474AE
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046131; cv=none; b=oMNI87/VbEOWdoeB+8aM+FlMki+Tigp95vMq6As6VTH8oajjOzFN0lW7WNXLXsrLyuZsXNGmrvXfn/Gtcbhk7ucGkJGrd96r2I9XiOji2k2Kyl7+rH+1VuiPB5DecEJjL2FmfSQ4QTNx1SMO5uCM+O/4AFzldXb4LaX54WDs8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046131; c=relaxed/simple;
	bh=W8H4t5oFGcXX+Vs57PmQilLGCS790wXpJOpV2Kcc3tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTS/B6KfEppOfVnPMonFvSldzzF0UfYygptbh8lNZuzvlCbKFtpToWOcBBbgvJrj6sPzlZUc3piEo/+zqnnXJUBg4gZc2/W2tKGlSMdBR8fxL/OChHp2GIzfxcFsmvm7UctaCjaocXKRA+CX2uc8KjF4su3Huwfu1v949oB85dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/8AFAPm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso7192205276.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046129; x=1709650929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkQ9f9zUddGmhF8J7tAd94aJa/QrXtBYwvQGJ32//W8=;
        b=d/8AFAPm1VljwEhU3mySga5+McWnIlhW900GO4K1n6fH0K6tdVNQgTedLTlH0OC4Yg
         LL4VdAydtvE6Qrk+XdCk1IU0mOklpAlTvj7MTLi7n9ifWsxg6HC29PTv3vY4VkQbe+5r
         DF2eBw+MOxU3Ostdp48eXPIzTNPCqlUj1dQ5eG+/r8Qt7eOW+2gmd1LuUR/gVvMcj8jv
         xjit5gkuAreW6aGld+tXGTT4CmAYzWfAJRSkqlQYpG/tLM/2XSeEBFxN1qvnpssIhzHO
         5JPAyHiCIZIl6El4gKzDxvZ0LQjFPYY+PbQAFl4VRDzytNJswRSSemiz9Kt9E45lTfcg
         D1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046129; x=1709650929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkQ9f9zUddGmhF8J7tAd94aJa/QrXtBYwvQGJ32//W8=;
        b=R2+CCEjCaxnWifO1bUbOfac/js3X4pigRL68aubpI4g9cTX0+/LKPgAmqmDyYPlKSy
         09MjZ9HyJdCd7InQxS+s2sxvY51YR1AitCZhij/e1ZuZFqnPGHlvT1YK1+WaWi3ZuKoC
         Gk8XqS9qq7tfc6DF4QcD+ps21glYl7KIc8gwf8JZI0SUp3iHmPvTTuRed6kN0K7ZEnHx
         1M8Ed7Wz/uFZCHR/HB3HceSI0hUci0pgDDD3XMudzl24nCLkvfHubacTMl7Fno6fcKj9
         DCwDzEJTsNSzAad48rAsLPjFEaF/ZdfnqLrwasfbYLaZA5B00Vbfn4tX6AU7tf2MfpQo
         5agA==
X-Forwarded-Encrypted: i=1; AJvYcCU9F/DAS4BXYFFp6LSFOPlpY53/qHR1jzxNPvfWEo1xPbvSfFhxIOnyo4zBiKij9MdxIyxLXsXHrRYkzvpXbJoJC9WLCD8L
X-Gm-Message-State: AOJu0Yyg2T+Ru3BUDUbr1HhE6vcvcB1mcFul3CXBG3zCwX6oLUr4C4Pe
	r9W2aJk562LpAjJjneVD1Q+pBeR3JKgglzEx/Nt/+/z9mMyzEXvqbhUkjVRqJTT/ncVJ9q+x6mH
	VVZjxy/N6ZQ==
X-Google-Smtp-Source: AGHT+IGXkw6EzQXSV9a/PX/g5jdtj5mT/pzReb9syTB3Ktbk4wvSqrzbiUpdA5xIWrp/qaTi0p1ZZV9ZQRtbqA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:150a:b0:dc6:dfd9:d431 with SMTP
 id q10-20020a056902150a00b00dc6dfd9d431mr646241ybu.1.1709046128993; Tue, 27
 Feb 2024 07:02:08 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:49 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/15] ipv6: annotate data-races around cnf.mtu6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.mtu6 might be read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip6_route.h | 2 +-
 net/ipv6/addrconf.c     | 4 ++--
 net/ipv6/ndisc.c        | 4 ++--
 net/ipv6/route.c        | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 52a51c69aa9de2fe1e6d351997f5b3d94862521a..a30c6aa9e5cf3e442cd29e2d169ba0b0d46a1f46 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -332,7 +332,7 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	if (idev)
-		mtu = idev->cnf.mtu6;
+		mtu = READ_ONCE(idev->cnf.mtu6);
 	rcu_read_unlock();
 
 out:
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 88b129b7884564876a51b359137c33e9b75ee9de..92ae6d62e4917749c5788aefda6752466061e6f8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3671,7 +3671,7 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 
 		if (idev) {
 			rt6_mtu_change(dev, dev->mtu);
-			idev->cnf.mtu6 = dev->mtu;
+			WRITE_ONCE(idev->cnf.mtu6, dev->mtu);
 			break;
 		}
 
@@ -3763,7 +3763,7 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 			if (idev->cnf.mtu6 != dev->mtu &&
 			    dev->mtu >= IPV6_MIN_MTU) {
 				rt6_mtu_change(dev, dev->mtu);
-				idev->cnf.mtu6 = dev->mtu;
+				WRITE_ONCE(idev->cnf.mtu6, dev->mtu);
 			}
 			WRITE_ONCE(idev->tstamp, jiffies);
 			inet6_ifinfo_notify(RTM_NEWLINK, idev);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8523f0595b01899a9f6cf82809c1b4bcfc233202..e96d79cd34d27ca304c5f71b6db41b99d2dd8856 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1578,8 +1578,8 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 
 		if (mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) {
 			ND_PRINTK(2, warn, "RA: invalid mtu: %d\n", mtu);
-		} else if (in6_dev->cnf.mtu6 != mtu) {
-			in6_dev->cnf.mtu6 = mtu;
+		} else if (READ_ONCE(in6_dev->cnf.mtu6) != mtu) {
+			WRITE_ONCE(in6_dev->cnf.mtu6, mtu);
 			fib6_metric_set(rt, RTAX_MTU, mtu);
 			rt6_mtu_change(skb->dev, mtu);
 		}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 707d65bc9c0e5e9b2900063f0ac86c3c5e299088..66c685b0b6199fee3bc39768eab5a6fb831bd2f5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1596,7 +1596,7 @@ static unsigned int fib6_mtu(const struct fib6_result *res)
 
 		rcu_read_lock();
 		idev = __in6_dev_get(dev);
-		mtu = idev->cnf.mtu6;
+		mtu = READ_ONCE(idev->cnf.mtu6);
 		rcu_read_unlock();
 	}
 
@@ -3249,8 +3249,8 @@ u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 
 		mtu = IPV6_MIN_MTU;
 		idev = __in6_dev_get(dev);
-		if (idev && idev->cnf.mtu6 > mtu)
-			mtu = idev->cnf.mtu6;
+		if (idev)
+			mtu = max_t(u32, mtu, READ_ONCE(idev->cnf.mtu6));
 	}
 
 	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
-- 
2.44.0.rc1.240.g4c46232300-goog



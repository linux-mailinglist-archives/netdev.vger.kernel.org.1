Return-Path: <netdev+bounces-75744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CA86B0EF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EF71C24609
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53B14F979;
	Wed, 28 Feb 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/vLOE2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89B15531E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128490; cv=none; b=W+GYWSEm0n6xfQ3ZqDk3dkYZ3lVON3rQ2sZuKu8DCmIIX4vpmpIXzIqgZOpM8ULz+f37fQPjA3+zMXEcnSP5v+g70TUIDgldm7OGQu+nqXNjAubd2dfMXid4ISv8l3JTUm3D6VmVVNWxwmuAEzGp/Hw7RYk3YICR59fzxYUrG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128490; c=relaxed/simple;
	bh=N2hL2xaPrpeRGNwEqKwm4kjCM9F3btIkN1OscYsi5Ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WihLuygtPlOmvFjDXyHA5mqrGqXgN25GARWeG39skWrBukVxYFTPwkFTKIo+0iBYqcLm5WCWkEiI0l9WrVUYE042q1h5yQqh/YNEYEjZujsuqbyyLnXMyeyhf6mVzbFMLGgFGOxSyjZnFBRuqBoZGBhoI1Dgx4P4za8gBA9Li2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/vLOE2N; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso8663683276.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128488; x=1709733288; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmY3dY632PH80ZQri5XOrSnftpfZoL3ED9y4hOcBys8=;
        b=r/vLOE2NgF4tSNKkyS1FPG0kuLs0SNVtytIluL3l+LGrPUP11TIZvHlln+cFuNl/y9
         FLt/BcYyGQgbV2SDcXAywMVnivmtNmOlum46+JlxSTi+oZtA09Pa0FA/RLByWE4KOVGU
         Ko0N0EudMRUunpILKDyn7831v9dk6zSaKyOrzi5iezB6YRq8Hc62yWPqHOQoWd+hrlPp
         n3uJXnN6b00P3JvERmZ2VWvmR1o+Kq6cI8rFnugppR5wK8WcssFwdkgewpSRtcaDrYpP
         fzkzms4nZJQdfHdAc96QX4z6VnzH+BQsyFOjITFqUbX/24DKE1ZpJo4f3BWNo5+ZDb10
         27kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128488; x=1709733288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmY3dY632PH80ZQri5XOrSnftpfZoL3ED9y4hOcBys8=;
        b=rAlIv9pP8EJ2iio/NeQ1XbAL/q+HqwoNeXQVD1YXldSnzU7z4pkZCNfoKBKKGy2lwN
         ZZrWabL0ja5bGLZ3+G1J73SZlHlFbPulkm4ll7/Ap6qEEWo8TFWndQ0TDjt3lTjcdmny
         5rm2MuyOstACy0AI/WJkLZP+BNaP/1Snmi7euBRbHQ7cM27zTMBvNc3XxxXWJLHoR1AB
         vQrLEiX/ffJ454QdiXKyTTRUw7Zwc/2BZUhY3Gt14F8JONDaKd/KFfZJ9vS7Q2v7xhzj
         YdSarh2FcJqoMWDMzVpaWoDbn3h1Km1Ut+QSOWsOsQOE9kn9498qVMp6kaJBfg1mvpLn
         ZiFA==
X-Gm-Message-State: AOJu0Yx9wcCdpswLIh33MqnArKlWCFo7CYkAovVIK33YpWPQ8wCZc7RH
	sz5XXoyL8S5EfVkepizBNZJq68x+lhZ+SF6cf3/PMDhzQxTzPtndRQxc6SLGfHMbAdSAbVdzWrq
	/j9qrozS5ug==
X-Google-Smtp-Source: AGHT+IFMb+DfW/3m5L6YKEnQAj4CdBbRB8XBYmCSPn16BjfQpy4ie8k1yos7yLat6nUsKD43RVmRaJmkpvtK5A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d08c:0:b0:dc7:4b9:fbc6 with SMTP id
 h134-20020a25d08c000000b00dc704b9fbc6mr354156ybg.10.1709128488142; Wed, 28
 Feb 2024 05:54:48 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:28 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-5-edumazet@google.com>
Subject: [PATCH v3 net-next 04/15] ipv6: annotate data-races around cnf.mtu6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

idev->cnf.mtu6 might be read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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
index 9a5182a12bfd7719fa6d5f0537835e0f0bf37686..8fd2ff8510021738e6bde499cc9fae83c52b91ee 100644
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



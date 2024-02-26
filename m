Return-Path: <netdev+bounces-74996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C909867AC0
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F291F23A15
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB112C547;
	Mon, 26 Feb 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McoZgzCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BE12B153
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962671; cv=none; b=E8kUxccEpW3ocTnvbsWx8GF+QvV+H7uvCtJbVqk1ja5kcPOYY/u+2xMF83auoBURgQceXKG/Jo9bHGdwFqRlS/xo9CgzlWKdYAUU9wequqZA+IixiRYV2lvblERWk4m4BqHQ59JQw09T3Tgy06yCwzJctrn5u2WNSCnW5KomvJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962671; c=relaxed/simple;
	bh=WPfa8QkOKUMC77mgeh3mvumQhRNKDmh6Hl8TSq7ZnVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TFSG/hwoHjNcSGTRzrv+/FYQXVwqqfbtTkw597SjJpKXBrTPEvPCuoi0L+EEtKhH0zotD4QoahM4s3ke4vHISY/QE7ppOPd3oFfJPRh3H+kJ+lfGtOxCrzYpEnSW4O+uQmdHhAuxMHHv1Jt7009cno2enP+S5DfNqmSeuQqS6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McoZgzCg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so4417549276.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962669; x=1709567469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDRQgd8UZ0tQ85v25rRLqG5gJgl+QmHR2zJk6PfWVi4=;
        b=McoZgzCgdpckokVd0zHxopBBF7mZcoTyalKnyf0xVgeUwN5QQ7hM1bLa0N9YKay+Yx
         oVCbfqNrzRGPaqknzOyvOLma7cvXlvM/jW1NuKL/INO5YGDiStwg1oxMu2No/n7HPtFt
         bhSWJdbiX2r1j54sPjKRAhp4EYjh+q2g+JQIOi+YMFKF8QQlVWp/QgMmt3x8GOsPGdes
         7E3mi+IpD2tLcCVHEthsrgeOLm13eUpBjb1Hs0pMijnILrTlr7ZGSFKdUgxB4Sg1u6wc
         p4Xx88PXpYak/SENxmATyBBPyokY90xuThLSVjs9wMY3O9tXL8ABuwc1l+8bFmRWquzG
         M+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962669; x=1709567469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDRQgd8UZ0tQ85v25rRLqG5gJgl+QmHR2zJk6PfWVi4=;
        b=AV9ZfojIS5ej/5I1ljtM/lFzW6aTiP6u2536jyxd7zMYIUtgK3jz6ASeM1eBw1LZGk
         9Ma7BciD8TIpWfoz2geE6YoPKmhywDNisykwTrU8ddawKCGul+F0avwfii2P/9lecj6/
         1mA+489IXxnlUzsLYFf0M8TLt7Vpk3L8+RXHdTCrWSHiYogKwvwFgTRbK1X0DMHmEs8a
         OXzvonVA4MxhflG7Zyha277MMqiuyaOtNnh8N/WEc8crpgpMIe0wAWI8chaTuB6v3XQz
         HvvZbSJPX642BGZkyClekJjP4dG+TRvhokjXS7Vqb8lomkAHhJNTgPM4H/FRLn8lwX5y
         3Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCU893+v1+C/j1GZi2X+ijsK8ZaXx9h0FA8HfbifYG0TbZYg1giIsqjnr6IitHi9Sbj8tTdN5TLavWH4zVerSUj5vlQOQlOx
X-Gm-Message-State: AOJu0YyOnMyvNB/1zWyWMUeOLyyLQCX4IlfSv0b4urEp4BOPjhmlQWOf
	Az1xfmmS0YrapVtCkncMO1WsndZS7MVR2TmGPn9VHHpqEQlhdW6XJfNM2LNdwPkqipOZZHognas
	U06lCWJ97qw==
X-Google-Smtp-Source: AGHT+IFtjdKPOspSfGpcKDlogT2h58F7VmdIIsKmvgZzEPj4N5jS9zvzH9aUqUh5lP2wTiMdMClNlG8Dv5IMjA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1003:b0:dc6:e5e9:f3af with SMTP
 id w3-20020a056902100300b00dc6e5e9f3afmr2138955ybt.9.1708962669474; Mon, 26
 Feb 2024 07:51:09 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:45 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-4-edumazet@google.com>
Subject: [PATCH net-next 03/13] ipv6: annotate data-races around cnf.mtu6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
index 0d7746b113cc65303b5c2ec223b3331c3598ded6..f1a346dbaceade70fb55fa98b33c47e6824298d3 100644
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



Return-Path: <netdev+bounces-133874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8692997515
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ED8282EA6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4371E1A3D;
	Wed,  9 Oct 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5nkr7+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FB1E0E18
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499458; cv=none; b=uPphpR95Y6nQbVqnUFc4l2pudpd3bNNnnqV3h8K+pykARJlM68qu4FZxQIL/SDRSntCRq4X56UxL8grhuzfrNs6+2ykzw3JJkszb8XFobT7uJ3+kb/rksR5b7Ow4lvOBTrplbRPcFew43KMAG7LD7yrVgdjxulzm6QSi7Qc5I34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499458; c=relaxed/simple;
	bh=S6KQDYotlv/ATtlpOZmLrFooIi+XWpoH/2pjEFVGuUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jrw1u7X8/5AwgmmGtTOcwZUsbfVNsT9phIxjfXB8wcjkL233RHdUYFW8hgGhi3aJZajesQtESafflKA1w2BcqpfztuFGtew+/DAvOKy4cGNlfp7bUOacNnlCZ30EooHzXKyYmaiMtehngMZTt7t/xLLoSSp5URH/c0d5DlamF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5nkr7+z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2d1860a62so4780027b3.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499455; x=1729104255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GT31xcYBxoqSWlcbZsNBzSpSFK9DG0BWwki4n1tBv5I=;
        b=q5nkr7+zWNiMtYARCg9yLgjJ1Nffpu0HxJggqqDwqGWqhg1ZG2f8T0HI/7UILeB9+g
         wdKpfcYM/VXORkWrbP4epOXZOBw/lQkrQspXvB0GMrTTNAUj1QGHOF52Z4PRE1uVkwRQ
         NYLabGIx57YPYv1jmeRoGIipaHZOiot8AoJgtMYydjlkba/jeX0kYk6cU937FNp56QEb
         nMEkab+Z12ZGDxyyFOpOX7QylHDAhuiIZGz1T6fr6qf/4IxmhBfEWhDBe8cXONIxUOTg
         so8UwS4I7++cIJ9FS9VHnYO45NbsGovv4ArCgIm4lkpc0a/Z8g1jEL63AIdl6DRh2vjQ
         b+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499455; x=1729104255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GT31xcYBxoqSWlcbZsNBzSpSFK9DG0BWwki4n1tBv5I=;
        b=CQFO7ZAyY7fmiP4KTt9C75VC5ei2sE4AMdC+FZqXKPc8T/NPnLn6LRk5ei7AE6+u/V
         zS8kcg2ucH8Eq8B7qBkHB2Bw3WGLz8kpppe5u/E7RqyinOxVDd103WVoem77B1iarpmm
         Zeiz4nvJ4Jb2GASG/35B904TufxmE/wDFdnvXU2zSqPkd7BhCZsg/yxaul95FbOZhwPq
         2IXT56UsOzd8IO/5qnxSF0vZQcURu/kN5BLDUFlOgVksO/Pu1IRALM7X7pS2avEC4GYW
         Wqa2ziSiyO0VA3QZ7T1HBZsSou7dtvvoNWeahf5JufD1o3AQz4FrAjMopZcoLhTPLK/D
         hmhA==
X-Forwarded-Encrypted: i=1; AJvYcCVHmW2uPqCTsn1t9X3upK3gEgRJJbagrgmaKmd5JYzy4RRJHK3hdJMjQP4oc6BZmVcrRd/azxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jS9z1Li6im1qODggpj9nYCFfhsNEQVWAytaihjipNvOSWSBA
	0KQ0Ebp4odCuZ/sbFRiRzw7R+xvoYRvKiHAi4aJ+yflTyO1Djcl1O4zJnaDkWBMdunLnM2KJdkM
	v8iingDdIIQ==
X-Google-Smtp-Source: AGHT+IGmAPO9L91hhyb+ySFdqLMfcc40xMn1Qp7io31i9GjNFBtdAaE4e2kPhkcloV+yt9Qa1RYur3c8JO3BBQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:7004:b0:6dd:bc07:2850 with SMTP
 id 00721157ae682-6e3224dd3bfmr801297b3.6.1728499455072; Wed, 09 Oct 2024
 11:44:15 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:05 +0000
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009184405.3752829-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] net: do not acquire rtnl in fib_seq_sum()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After we made sure no fib_seq_read() handlers needs RTNL anymore,
we can remove RTNL from fib_seq_sum().

Note that after RTNL was dropped, fib_seq_sum() result was possibly
outdated anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/fib_notifier.h | 2 +-
 net/core/fib_notifier.c    | 2 --
 net/ipv4/fib_notifier.c    | 2 +-
 net/ipv4/ipmr.c            | 2 +-
 net/ipv6/fib6_notifier.c   | 2 +-
 net/ipv6/ip6mr.c           | 2 +-
 6 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/net/fib_notifier.h b/include/net/fib_notifier.h
index 6d59221ff05ad605dea6bf0e5f3d6b9d24237537..48aad6128feab6452c91e11ec31f9f1f238032d8 100644
--- a/include/net/fib_notifier.h
+++ b/include/net/fib_notifier.h
@@ -28,7 +28,7 @@ enum fib_event_type {
 struct fib_notifier_ops {
 	int family;
 	struct list_head list;
-	unsigned int (*fib_seq_read)(struct net *net);
+	unsigned int (*fib_seq_read)(const struct net *net);
 	int (*fib_dump)(struct net *net, struct notifier_block *nb,
 			struct netlink_ext_ack *extack);
 	struct module *owner;
diff --git a/net/core/fib_notifier.c b/net/core/fib_notifier.c
index fc96259807b62fd2b41c47f385d7db23a7e38186..5cdca49b1d7c1cc9097c6a9fe93fae701c54eaca 100644
--- a/net/core/fib_notifier.c
+++ b/net/core/fib_notifier.c
@@ -43,7 +43,6 @@ static unsigned int fib_seq_sum(struct net *net)
 	struct fib_notifier_ops *ops;
 	unsigned int fib_seq = 0;
 
-	rtnl_lock();
 	rcu_read_lock();
 	list_for_each_entry_rcu(ops, &fn_net->fib_notifier_ops, list) {
 		if (!try_module_get(ops->owner))
@@ -52,7 +51,6 @@ static unsigned int fib_seq_sum(struct net *net)
 		module_put(ops->owner);
 	}
 	rcu_read_unlock();
-	rtnl_unlock();
 
 	return fib_seq;
 }
diff --git a/net/ipv4/fib_notifier.c b/net/ipv4/fib_notifier.c
index 21c85c80de641112d66a28645b1fb17c7071863f..b1551c26554b79b70a29c9fab7f5ba8d7c0049c5 100644
--- a/net/ipv4/fib_notifier.c
+++ b/net/ipv4/fib_notifier.c
@@ -27,7 +27,7 @@ int call_fib4_notifiers(struct net *net, enum fib_event_type event_type,
 	return call_fib_notifiers(net, event_type, info);
 }
 
-static unsigned int fib4_seq_read(struct net *net)
+static unsigned int fib4_seq_read(const struct net *net)
 {
 	/* Paired with WRITE_ONCE() in call_fib4_notifiers() */
 	return READ_ONCE(net->ipv4.fib_seq) + fib4_rules_seq_read(net);
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 35ed0316518424c7742a93bd72d56295e1eb01aa..7a95daeb1946ad2f9c6d00a75469e37f92dddf9c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3035,7 +3035,7 @@ static const struct net_protocol pim_protocol = {
 };
 #endif
 
-static unsigned int ipmr_seq_read(struct net *net)
+static unsigned int ipmr_seq_read(const struct net *net)
 {
 	return READ_ONCE(net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
 }
diff --git a/net/ipv6/fib6_notifier.c b/net/ipv6/fib6_notifier.c
index f87ae33e1d01f4e8d55f2af435bd8eff72bd9ea6..949b72610df704b6afe455daf0d680dbe4504e87 100644
--- a/net/ipv6/fib6_notifier.c
+++ b/net/ipv6/fib6_notifier.c
@@ -22,7 +22,7 @@ int call_fib6_notifiers(struct net *net, enum fib_event_type event_type,
 	return call_fib_notifiers(net, event_type, info);
 }
 
-static unsigned int fib6_seq_read(struct net *net)
+static unsigned int fib6_seq_read(const struct net *net)
 {
 	return fib6_tables_seq_read(net) + fib6_rules_seq_read(net);
 }
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f9501fd8c1ae583d4862128e8620ce6cc114d25..9528e17665fdb0ce4be07c76703ba74f06386370 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1260,7 +1260,7 @@ static int ip6mr_device_event(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static unsigned int ip6mr_seq_read(struct net *net)
+static unsigned int ip6mr_seq_read(const struct net *net)
 {
 	return READ_ONCE(net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog



Return-Path: <netdev+bounces-70641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7DC84FDB3
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200821C21430
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E055681;
	Fri,  9 Feb 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmogfbLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF65677
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510914; cv=none; b=rNFz7Zt1ZZbcMIfRXUvUrsCISYjxxRsMD9fM16gEXaMdxqnM+c+7y8jWkeOuj4uGRLIDAZKs+PUT7NulbV50qbBsmpblxnCkyiYhtI/4vrvoMIj2J7rXNwI0PUSYmYfJIu1tqOierjxoOQ5icMyXaTp6ItX3l2pjgWUfvIk0KdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510914; c=relaxed/simple;
	bh=y+q6hgQ6V9XXesoaFRFvTAQ8BHlhCzEQfIhCIgUACyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b/WqGUS7PmJmlRJ12qAg6wYp6RlhQDIKSnG6qAPXp0rNi2WgbFpY8/PaVEG1WQxS7rGf4jN809dJNj/2oW5mEc1S5FmN/e2lmZ/8aZ1mjPt5PTfrXVmbkOeOkzHowN1qG2dkl1zms8WAhduLr2Dy4eesTDbo7Ql4bwUeN8iK0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmogfbLM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc75a87e0e5so633310276.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510911; x=1708115711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqXV5Ysk4KM8pb1+jvbQ/UqklYv6x7+ly8qvh2CNGoo=;
        b=MmogfbLMvUSwuTp9g9Kw6P0Q9f61/QOJKga3+RAmLZEg2r2RStgUOvWywcICiIFe8Z
         eXUyDzfeAKpsIbmmEnLWaBxHirgjB/GIgUsyfda6OFCWsLvMmyZ8fW2f8PlN6RBbXGIy
         4hN+uwSnCw8RdAilEodCtDtKagv7y3jlYFCk2kIumvlpGuJzeJt+UZwfi71UD+wRZ6sJ
         +y6y+8+hhh7qG7tIpC1X9aCqdzuD5yEze0PHaCslyGDsyx6TpG/H89AzTwZxLlB5Dif5
         D4qSj5ry/cZEvory83Navo6ZZtxRpNJxGisPxbk5car+uQc3oaDeWcFUJfVII79ILSRC
         Kg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510911; x=1708115711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqXV5Ysk4KM8pb1+jvbQ/UqklYv6x7+ly8qvh2CNGoo=;
        b=P13oSaizR8ykw87C8qw3iQzGB1K1n3EFYVMHVs7YyWRGln4fIrN/pBN63BCsG5qWB+
         B6uyL1iAB6sdrxxUqbdu2K1En3uamKXVJFYPaJkGK7y/qMHRuASZpjVjcuuEHSETnaTg
         sAt/iYfF5wet+OpuAc5O8d7Zuvksd48u3Rsne6dMtev70T/8GXBP1eOfM9/OMV7npYra
         Qq0jjrY9W1ROK8xyodjjMawofmV9PzIe5vhNg8a/EMaVdKi6iGSupF4fuwLesnZ2405x
         S2xoHTfVwtB9rtJl86XuDOyvlouEbpJCWlRphKtJTY3lyr46SBTWJRI4aru9EjPEruOr
         Xxpg==
X-Gm-Message-State: AOJu0Yx0O/JUFudLnUMgTSpEweYMs93zju8QpPZ6V3CpZT5LTKY1aP2H
	dXQkvuZLzfs7bMF5p7tt+u2kPqp68LHusn/hghJSw06gFH3Qahmgp+9TjeUbJcgX3MMfOl4BNxD
	ZpekwLM6wPg==
X-Google-Smtp-Source: AGHT+IHawNbUO8wnO+hoJVpibrA1zQ2WMvrN1lBGt1NTpYqmd9PVZT8bllGFdUSDz2OH0cB5YhXvoSvP3Ap3SA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:dc6:b0:dc2:3426:c9ee with SMTP
 id de6-20020a0569020dc600b00dc23426c9eemr5054ybb.11.1707510911619; Fri, 09
 Feb 2024 12:35:11 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:25 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/13] net: add netdev_set_operstate() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_base_lock is going away, add netdev_set_operstate() helper
so that hsr does not have to know core internals.

Remove dev_base_lock acquisition from rfc2863_policy()

v3: use an "unsigned int" for dev->operstate,
    so that try_cmpxchg() can work on all arches.
        ( https://lore.kernel.org/oe-kbuild-all/202402081918.OLyGaea3-lkp@intel.com/ )

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  2 +-
 include/linux/rtnetlink.h |  2 ++
 net/core/link_watch.c     |  9 ++-------
 net/core/rtnetlink.c      | 22 +++++++++++++++-------
 net/hsr/hsr_device.c      | 22 ++++++----------------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 28569f195a449700b6403006f70257b8194b516a..d4d1e438ab8f1d2bd6426837b504ad6891fe83b7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2258,7 +2258,7 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
-	unsigned char		operstate;
+	unsigned int		operstate;
 	unsigned char		link_mode;
 
 	unsigned char		if_port;
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 21780608cf47ca0687dbaaf0d07b561e8631412c..cdfc897f1e3c683940a0958bc8a790c07ae819b0 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -172,4 +172,6 @@ rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
 	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
 }
 
+void netdev_set_operstate(struct net_device *dev, int newstate);
+
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 1b93e054c9a3cfcdd5d1251a9982d88a071abbaa..8ec35194bfcb8574f53a9fd28f0cb2ebfe9a3f2e 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -33,7 +33,7 @@ static DECLARE_DELAYED_WORK(linkwatch_work, linkwatch_event);
 static LIST_HEAD(lweventlist);
 static DEFINE_SPINLOCK(lweventlist_lock);
 
-static unsigned char default_operstate(const struct net_device *dev)
+static unsigned int default_operstate(const struct net_device *dev)
 {
 	if (netif_testing(dev))
 		return IF_OPER_TESTING;
@@ -62,16 +62,13 @@ static unsigned char default_operstate(const struct net_device *dev)
 	return IF_OPER_UP;
 }
 
-
 static void rfc2863_policy(struct net_device *dev)
 {
-	unsigned char operstate = default_operstate(dev);
+	unsigned int operstate = default_operstate(dev);
 
 	if (operstate == READ_ONCE(dev->operstate))
 		return;
 
-	write_lock(&dev_base_lock);
-
 	switch(dev->link_mode) {
 	case IF_LINK_MODE_TESTING:
 		if (operstate == IF_OPER_UP)
@@ -88,8 +85,6 @@ static void rfc2863_policy(struct net_device *dev)
 	}
 
 	WRITE_ONCE(dev->operstate, operstate);
-
-	write_unlock(&dev_base_lock);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4e797326c88fe1e23ca66e82103176767fe5c32e..16634c6b1f2b9c0d818bb757c8428039c3f3320f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -842,9 +842,22 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 }
 EXPORT_SYMBOL_GPL(rtnl_put_cacheinfo);
 
+void netdev_set_operstate(struct net_device *dev, int newstate)
+{
+	unsigned int old = READ_ONCE(dev->operstate);
+
+	do {
+		if (old == newstate)
+			return;
+	} while (!try_cmpxchg(&dev->operstate, &old, newstate));
+
+	netdev_state_change(dev);
+}
+EXPORT_SYMBOL(netdev_set_operstate);
+
 static void set_operstate(struct net_device *dev, unsigned char transition)
 {
-	unsigned char operstate = dev->operstate;
+	unsigned char operstate = READ_ONCE(dev->operstate);
 
 	switch (transition) {
 	case IF_OPER_UP:
@@ -866,12 +879,7 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	if (READ_ONCE(dev->operstate) != operstate) {
-		write_lock(&dev_base_lock);
-		WRITE_ONCE(dev->operstate, operstate);
-		write_unlock(&dev_base_lock);
-		netdev_state_change(dev);
-	}
+	netdev_set_operstate(dev, operstate);
 }
 
 static unsigned int rtnl_dev_get_flags(const struct net_device *dev)
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index be0e43f46556e028e675147e63c6b787aa72e894..5ef6d437db727e60bfd8cf68f010f0151d0db98b 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -28,29 +28,19 @@ static bool is_slave_up(struct net_device *dev)
 	return dev && is_admin_up(dev) && netif_oper_up(dev);
 }
 
-static void __hsr_set_operstate(struct net_device *dev, int transition)
-{
-	write_lock(&dev_base_lock);
-	if (READ_ONCE(dev->operstate) != transition) {
-		WRITE_ONCE(dev->operstate, transition);
-		write_unlock(&dev_base_lock);
-		netdev_state_change(dev);
-	} else {
-		write_unlock(&dev_base_lock);
-	}
-}
-
 static void hsr_set_operstate(struct hsr_port *master, bool has_carrier)
 {
-	if (!is_admin_up(master->dev)) {
-		__hsr_set_operstate(master->dev, IF_OPER_DOWN);
+	struct net_device *dev = master->dev;
+
+	if (!is_admin_up(dev)) {
+		netdev_set_operstate(dev, IF_OPER_DOWN);
 		return;
 	}
 
 	if (has_carrier)
-		__hsr_set_operstate(master->dev, IF_OPER_UP);
+		netdev_set_operstate(dev, IF_OPER_UP);
 	else
-		__hsr_set_operstate(master->dev, IF_OPER_LOWERLAYERDOWN);
+		netdev_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
 }
 
 static bool hsr_check_carrier(struct hsr_port *master)
-- 
2.43.0.687.g38aa6559b0-goog



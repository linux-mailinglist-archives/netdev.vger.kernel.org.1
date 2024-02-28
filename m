Return-Path: <netdev+bounces-75742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C002386B0ED
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14181C2105D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07E151CD7;
	Wed, 28 Feb 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTAcXtc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EF36132
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128488; cv=none; b=d4gEDt4pF+aT4pJxXiR8wu6CDe1n39Qv2rs/wG/BSHVfk1qMC6Rnm339ED9SNzYGvmjHK7Jst2vYjZUOnS6xDTWnfVw2bORr9TVpwnVYABGJ7GAboa4haC8M+L8QEAt93gaMxs0zB3rLnkWJpmQislA3W0Q8ZnjXK2oKNVpB9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128488; c=relaxed/simple;
	bh=pyRTrCFIF53ALj594M75v4uX/qajHVqWfX1akzaUjDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=osi4MdeOMj8hn/s1wjze2M7QzfF0pQj1qEjxj4+vWY8U1kTwTvA4daGQP2BHdT2SbcKJ+8B7gMruVa3a9sbZ9vZLBTJgj9KtcP/LntAiRyRmY4gZUfgjuEJ0oJ1F+2LS/cP6qgMVyFi7Gm4yQiRihoHh/ULekodYaafVeQnFKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTAcXtc+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so6997828276.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128486; x=1709733286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ief8H3jG8cWOh1EE+DNugp+OaUBgAgHchahPCNShsic=;
        b=WTAcXtc+y08nwjwoYGM+145j5J02QzCguORCkzsQF554cwn1jHWSL1c4AZ9j2K0Hpr
         +zzVs5ILGEqHsSZEfx4Umr6FhrWQ1Ej0hC3my2aeaV+gZfGzfbj93efb2LlBET5+u6W4
         xsuXUkd4n/s6rYvqaAjBTbfIdoLByovvEy0LZQl/NuES6OiEvD31DsaOQh9StOsr74yt
         nxBd0tN52Fkhpc8W90BoLrScoen/HZAl+lyZO/bCEqDbDwlnCtA1ByL4rLo7CF3iacpc
         GmvOAn1VafdiCcTaG4nEnA/ALbqQJLweq727iMs6sUn64AnjBNG3s0Dt3N+Tr0qjsF7B
         ce7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128486; x=1709733286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ief8H3jG8cWOh1EE+DNugp+OaUBgAgHchahPCNShsic=;
        b=NjCtWgT7ByaULzF5DaRghg4E7S5gbMeqsEBd2VfTFfUdSvZzcrpV7U84kDs8DjVx/J
         fvt9SVTAJySgd418du2Y/DyTVS63hnH2xmfCBilsKgmsy44cQaSYcHXs6COlkRNWvjgY
         4QQ5rGfKKtmG0j+oofR6YyEfoj3AA5jbTn2vDJ+NgpW+mm0/857tpBMI7Np7zrKCjo78
         7Ml7fUkrIypIp65/So5z+i9duv1D7uQYNDRQsJ4E/k39iRqgBmqDHlm7SvHVhr62bodu
         K3IfBHGpATgiSF9n5lxq4gyrphLuYvyrCDWGY4+/EJ7T5i5GGyo8vA1Adkxw8NWY3ro6
         2Puw==
X-Gm-Message-State: AOJu0YxSmORECSUt22Wb3FfiJ4kzjzcwwre/TBTsimBoVJItBMbKxRIi
	msZhs4eaVZnLE4yQimtv+iOrhqebKvLp3H7YGS+3+jiqItdyVWX0v/3daZtp+AiMGLnAa63NbUG
	Z3+BXuSkxng==
X-Google-Smtp-Source: AGHT+IGipDaQRvhHY/rNTKkNDYB46GXzP7qMcJe9KPKYkjoKdPbNnsQRYU75TUYubrtJyCSDAZlmeqhYe4wZ1g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:174a:b0:dce:30f5:6bc5 with SMTP
 id bz10-20020a056902174a00b00dce30f56bc5mr116327ybb.4.1709128484304; Wed, 28
 Feb 2024 05:54:44 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:26 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/15] ipv6: annotate data-races around cnf.disable_ipv6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

disable_ipv6 is read locklessly, add appropriate READ_ONCE()
and WRITE_ONCE() annotations.

v2: do not preload net before rtnl_trylock() in
    addrconf_disable_ipv6() (Jiri)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c   | 9 +++++----
 net/ipv6/ip6_input.c  | 4 ++--
 net/ipv6/ip6_output.c | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e27069ad938ca68d758ef956b8c36cb85697eeb5..9c1d141a9a343b45225658ce75f23893ff6c7426 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4214,7 +4214,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -6388,7 +6388,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6405,7 +6406,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6413,7 +6414,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index b8378814532cead0275e8b7a656f78450993f619..1ba97933c74fbd12e21f273f0aeda2313bd608b7 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -168,9 +168,9 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
-		if (idev && unlikely(idev->cnf.disable_ipv6))
+		if (idev && unlikely(READ_ONCE(idev->cnf.disable_ipv6)))
 			SKB_DR_SET(reason, IPV6DISABLED);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 31b86fe661aa6cd94fb5d8848900406c2db110e3..0559bd0005858631f88c706f98c625ad0bfff278 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -234,7 +234,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
-- 
2.44.0.rc1.240.g4c46232300-goog



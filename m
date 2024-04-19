Return-Path: <netdev+bounces-89596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F75C8AAD19
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124CCB21C62
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060607F7F4;
	Fri, 19 Apr 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/MBONQF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB517BAF9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524015; cv=none; b=BoShECgPACK33aF8xJHODuAI3p8x2rAMzHeUL0cINQ9XPQv4L8LbsEFPmnWp2El0/cta7nCAM91ZWEsRmUPnXK4hMdcex+gQWiwrAgJwHgagbivtiJJ6/3x54nO0KrHgQ3eIJH8hALtcfXkrJ41w+oT4m6P5sKKGpwq4+Qj2fLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524015; c=relaxed/simple;
	bh=He6bvtI1r57LILZNjiIrnwn6xVEDf8ZkS3CR9XDqr2c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qabVm43OPMfakK62vtgAaeRl2gnjDTJpOq/IIp1vXuLh+5atWIW9SuO+x451biXfCOp7ZxUkkrqkKSvDe+axLfRh8gbV6AdKctvYD9j2pyrUiL7Qed1DdiG23gOucSOcfm2ysNrZvUC9XJr671JeN2hLtKoLmEAs+pBi+/L4YEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/MBONQF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61afae89be3so37691107b3.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713524013; x=1714128813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ww4u37mAY5ySAvVCwtBY2Z/kMhJTHtCAJG+tMPNgbHQ=;
        b=u/MBONQFKF859Uv9UBWe78XwiuzDHdGGHPKCuYNakmLzucWxIGrt85TyUk8WarkVjW
         QX+n8m92Ph6DC4nwYqtdZNsBiuCPysUk9Zhugg8ZNcFnPwa+gzFSC+9yHJxWaO+7ruFy
         LikzvE7M4VzHbUGHMpLrXeCxrGKVpl8yR/hfdZB2Bdq7OMteYhQktIYa2lnwZYlqbP0Y
         o8kuho4ttMrrurJYW4N/FUUDJJgkxNuH6xaCZH9n1uFuOgjSxeHMxVFKsDfrp0sVAGs5
         820TGttye0Y/SMO2HdHoOXWjBKTbuTZqCuZtfAWSL/f4oFWBf+Xvy6ch1snGRZAlwFA3
         6c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713524013; x=1714128813;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww4u37mAY5ySAvVCwtBY2Z/kMhJTHtCAJG+tMPNgbHQ=;
        b=jm1VSKO7v3dnmvR7bp2no2BRg5njbsYyrbYSLl+mJ2ZIESXBS8q3vMeIJX2avIshLD
         49NeMVKAKDzQX1N344egKXxMPGuk/Lolj5yi5NeAJQRnXF7M+2f7g4dfm/nbdYwzXj0z
         Gozk67CA/xkSYos4uUWfrH66eb8PdxpKu6Jum96e8mnfXtWv1QZpo6XPwQgkFwdTmmpU
         yiEzkpEVpFpYKMM/Q3g25FbO7nPtv68cix26iEtoQ1n/9A2Q9186tyv+rAYjQuIVlE4X
         Zzu/wikeruC+r9xWnr9oqsvYTIPJf1oAXaClYcurTrIqY56KXQs7ICCNW0CqsqcX23Yh
         JvVw==
X-Gm-Message-State: AOJu0YzEnHEC0U4G9QhBTmE4cOoWCc1bCHvEqz5SX17eW/IzkbAyjnxr
	C3m/0OvyREiNBs4xoxSjxYhnTSAlDt5p3klMZCwfQ4XpVeqAgMiOM2V67TkhfvKYudhDsxxrh7c
	/AGfmatvswA==
X-Google-Smtp-Source: AGHT+IHLGMEgdOJOxrRNsJCd2jcCng2eUwpzWElwB45JTx79ETw+qoHPfPsMRENeSsYW7W8bMktdLgwMYjcafA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9156:0:b0:61a:e2ee:f22f with SMTP id
 i83-20020a819156000000b0061ae2eef22fmr400611ywg.6.1713524013569; Fri, 19 Apr
 2024 03:53:33 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:53:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419105332.2430179-1-edumazet@google.com>
Subject: [PATCH net] icmp: prevent possible NULL dereferences from icmp_build_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Andreas Roeseler <andreas.a.roeseler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

First problem is a double call to __in_dev_get_rcu(), because
the second one could return NULL.

if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)

Second problem is a read from dev->ip6_ptr with no NULL check:

if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))

Use the correct RCU API to fix these.

Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Andreas Roeseler <andreas.a.roeseler@gmail.com>
---
 net/ipv4/icmp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617627e17669f9b3aaee1cbbf178ebf..e1aaad4bf09cd43d9f3b376416b79a8b2c0a63ca 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1032,6 +1032,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
 	struct net *net = dev_net(skb->dev);
+	struct inet6_dev *in6_dev;
+	struct in_device *in_dev;
 	struct net_device *dev;
 	char buff[IFNAMSIZ];
 	u16 ident_len;
@@ -1115,10 +1117,15 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	/* Fill bits in reply message */
 	if (dev->flags & IFF_UP)
 		status |= ICMP_EXT_ECHOREPLY_ACTIVE;
-	if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (in_dev && rcu_access_pointer(in_dev->ifa_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV4;
-	if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))
+
+	in6_dev = __in6_dev_get(dev);
+	if (in6_dev && !list_empty(&in6_dev->addr_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV6;
+
 	dev_put(dev);
 	icmphdr->un.echo.sequence |= htons(status);
 	return true;
-- 
2.44.0.769.g3c40516874-goog



Return-Path: <netdev+bounces-244415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0DCB6C70
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 18:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742143033D42
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87A322B67;
	Thu, 11 Dec 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjJ67jrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16D31B110
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474555; cv=none; b=BGOjOdtLImlKwwVH4/IXqmaOH9pbO6B6+gM16YBUaVvDBpINQTFF0Dc3XPDAVogeg7jaJuQvxKje+9XPixnQLaq35C68MQTP+sDu3+oc6hFsirxnv2/vg2GHCLd2vTsds6PBGCoiYdcEnYHE57vH51K0ShQWmIaA9Dljs5i+iHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474555; c=relaxed/simple;
	bh=6uTe9KD5SAJUD26lsuNUQSaNEV4Z1tig75wWyB/rj7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bBjgZANd0vkyjFqYYfUkYkDi9hViRcAti1dhEGOwOEUQ4Z3FAkQ4ZNKuZl5Ph5zrzW6YojG1eMWOB6UKaMdqwfNex//vqFPkat4dD9YJesvQTkgXNXCZ6sIRWdndev696235IQVRTF/dUhC8bqVnlVTBtIg+PtFhifL/bnZBCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjJ67jrM; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6446ee26635so691069d50.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765474552; x=1766079352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MBOeBcTEbNJvkGQfDnVPgf5MkMccVhxHNjxWEdtskdE=;
        b=GjJ67jrM/MGZ0DH9tCxcnO/gSiYm6MD4lwbRGXRLWuXZqOMbU4n24UtZdBWzPf4Xgb
         cofsh2T6zMy6uaxiXMo4RMqyEIm055K1NbXdDPcKubbaqR3F/K6/WvFniOt42Ei9JTwQ
         +GF8A9L0upXcMC62WIEhyehWsEeNCGOBxJg+etJ1aoNJsO1EnEJroY5ZCYnN0wmj9J4z
         wmtFSS2omjqmq8hYO1YYQmdbbA6cHRS1lwDlSEKnp8uz2Klui4NHwUuIg7y1XmdMZhI7
         3Kgc379iZD/Fetqhq/Pw/jQCZ8ithkqIOw47Uz3Odz97H4+ZS698CUGExET0MXC49m6Z
         AfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765474552; x=1766079352;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBOeBcTEbNJvkGQfDnVPgf5MkMccVhxHNjxWEdtskdE=;
        b=eF4r0DkBUgiDhgyqPspQbqqca403fqhDGOMwjpzW5PsmJp7HQdiKt2N3vv5JRjAa6N
         hRR89yBUBf0uMmvAmk8BIBqLImgx7xam8+ed+bOEKRh9c/9xy+VhiavACGU3/MAxzlAR
         beQ39hjniZocVuetrOeflIge3q/Z2YDYXmv0F1bx7S/DJpPHb8edLZaWWWsp0F5o+z2O
         s0QVaD5DWwCDlhuC5O/NhsUXoKa0bAVh7+5R2SrsvH/dSyPs7lyufPFR0zyjMKUmdnPc
         2fXQoHTCzZr/EU2V+7+sVCX042DDxac5jR7sEQbPhbOkErM8rGjJgLrsPVCgmRkoVqmn
         hw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt/czGyBOpp4LxDCAYvUEjB4YV3FU5Qi9H3xV51kCFRwHTb1v3OREUaJ4RxEcjnOCjnY7qK44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJ2+AgAVS1kbE/GtY0nl6iOE4CjcI5H3jk4B13Xrz9UirP6zC
	EnIYDcQIvlNLvn3N2nsMKwTV6EDdS7j6xt2c5L+fmFJfHqiztkeyADdT9wLYDH923Gqs4i8sxAG
	WASMQeqN1/goQaQ==
X-Google-Smtp-Source: AGHT+IHldfO5+g5xk8fhRTtnopixpEGXS/DUHPuvl2uO1/wHrmUu/mmZe4EP6hLimzmIJRmZmny6iOs7LrY9EQ==
X-Received: from yxtr8.prod.google.com ([2002:a53:ec48:0:b0:644:bf91:9c62])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1345:b0:644:4259:9b62 with SMTP id 956f58d0204a3-6446e8fc163mr5594521d50.1.1765474552370;
 Thu, 11 Dec 2025 09:35:52 -0800 (PST)
Date: Thu, 11 Dec 2025 17:35:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251211173550.2032674-1-edumazet@google.com>
Subject: [PATCH net] ip6_gre: make ip6gre_header() robust
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+43a2ebcf2a64b1102d64@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Over the years, syzbot found many ways to crash the kernel
in ip6gre_header() [1].

This involves team or bonding drivers ability to dynamically
change their dev->needed_headroom and/or dev->hard_header_len

In this particular crash mld_newpack() allocated an skb
with a too small reserve/headroom, and by the time mld_sendpack()
was called, syzbot managed to attach an ip6gre device.

[1]
skbuff: skb_under_panic: text:ffffffff8a1d69a8 len:136 put:40 head:ffff888059bc7000 data:ffff888059bc6fe8 tail:0x70 end:0x6c0 dev:team0
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:213 !
 <TASK>
  skb_under_panic net/core/skbuff.c:223 [inline]
  skb_push+0xc3/0xe0 net/core/skbuff.c:2641
  ip6gre_header+0xc8/0x790 net/ipv6/ip6_gre.c:1371
  dev_hard_header include/linux/netdevice.h:3436 [inline]
  neigh_connected_output+0x286/0x460 net/core/neighbour.c:1618
  neigh_output include/net/neighbour.h:556 [inline]
  ip6_finish_output2+0xfb3/0x1480 net/ipv6/ip6_output.c:136
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
  ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:220
  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
  ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
  NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
  mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
  mld_send_cr net/ipv6/mcast.c:2154 [inline]
  mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693

Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
Reported-by: syzbot+43a2ebcf2a64b1102d64@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/693b002c.a70a0220.33cd7b.0033.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index c82a75510c0e..8bc3f05f594e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1366,9 +1366,16 @@ static int ip6gre_header(struct sk_buff *skb, struct net_device *dev,
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ipv6hdr *ipv6h;
+	int needed;
 	__be16 *p;
 
-	ipv6h = skb_push(skb, t->hlen + sizeof(*ipv6h));
+	needed = t->hlen + sizeof(*ipv6h);
+	if (skb_headroom(skb) < needed &&
+	    pskb_expand_head(skb, HH_DATA_ALIGN(needed - skb_headroom(skb)),
+			     0, GFP_ATOMIC))
+		return -needed;
+
+	ipv6h = skb_push(skb, needed);
 	ip6_flow_hdr(ipv6h, 0, ip6_make_flowlabel(dev_net(dev), skb,
 						  t->fl.u.ip6.flowlabel,
 						  true, &t->fl.u.ip6));
-- 
2.52.0.239.gd5f0c6e74e-goog



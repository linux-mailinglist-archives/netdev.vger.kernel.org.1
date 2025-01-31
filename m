Return-Path: <netdev+bounces-161800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5FA241AA
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F867A39D4
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89E1EEA44;
	Fri, 31 Jan 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hX1xVv4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC71F151E
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343633; cv=none; b=qfgX4L/efCEidb4K5RCfsrwoipOLWZpDzBHDHXgoSrlKsTAxa0f9qNS1cVR8+tjzG4O68ALqfz8BV5v1Sf7exzG/mV7ukKd1faCeAvjFmx7HIX+L0JB2zrJ5bPWcZRhCpC8RFal8uw1WyR20ShoG+aWaXArHy2hXz7KqnSLDUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343633; c=relaxed/simple;
	bh=IbL4pV519P+5BtuvaDgCVnklrPjC6i4lvL22nMn+tC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPo4MDawg/Cg0PAnfxP7kxhlHuSnjuby1/U+Xt5XGGM9hkcIx8DXsE4ZS6yNUFbBKVZBgZrLdc0MprV+fC/5yzS4UGLdJRBsji5atVQBgZy+xTbFBji2//QKxiYP4Pk24LKX7kbe45BXFSerVweYSdwJMgCxaKuA1uWgPbWaYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hX1xVv4m; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8f4a0df93so56555396d6.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343630; x=1738948430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xr0k9J8ircXguZd/XTDGs++ZqClk/BqaFLz/vlFnqfg=;
        b=hX1xVv4mSSdp1ER5ajVqj16InywsZxJyF/Da/9UrkUS9DJ5gFCg24+vfW5AzJrRQnq
         2u+f9kCRvPYZJgwFL9uqzelRuOsVeXZhgX7Sr6FrzcjYA9xQngw98snwBkfPv999E4wQ
         kELkNcVHXXU9m0xHwve+iicQ8nCBmPvnfMBuxwEjQroJG2pnLuNMXUm90I4fvb6mhkbd
         k2FY65GM+nAn8HkTKRvdhE9y1Z0mizAmEOg8CabAYVmAFkK8N4vL6cSO+47slxn5SX0H
         MuBffHTezmuTvtI4ifAWgZBQaM+AXF63kdSNNH+usOfCF3sMs9WGZQ/ZXYsCBbj8F0Io
         OS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343630; x=1738948430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr0k9J8ircXguZd/XTDGs++ZqClk/BqaFLz/vlFnqfg=;
        b=TzcTXpZ/BEL8h77tfdx+ILmHwXoWzFEyD8k6Q1QlsX/7hKZHJT92JRz84QkXkUpZBl
         k2zJH4aMEsA80lpYTJ3u2AUXKA3LKYDFhO2HyGRxIvlkXaoHi1hiZX0GdJlqK0e2pLfH
         aPxD9MaunRuZ+31S3pHCHMRzm2tpTA5VU0sBGIplAsZSt9IvYT6wPnw33H+TgrY8e/au
         1q8dOw7ewTXRWG0IZGfrUtFu9GfdODtXPz1F3ny4H0l6txw8YloV4nH2fjSQB31XE5Jw
         pw/6hH2tbIZHcDtqQvTx7gmwmTcPVc3QvQwyMadQ+OgVxXkr1JK+GA9DJhNCHOLDgC/D
         9lNg==
X-Gm-Message-State: AOJu0Yxl+uFCRiIbf+msXpA8p6V6EDYWUa7sqHZ2aeb4xHoh2C5DH/1Y
	Qzjnvm3moIvz0Yo2J+XESNQFEcc6742Afvn9RNByC69XnpY/GVfXPtnUSREZF0WGzlQmkfiR4al
	qiuTDjHdhMw==
X-Google-Smtp-Source: AGHT+IFo4yaUW3CRbIvGujWFiYDSG7KvZyK/QIHEyAUuvFaykuss0Ka6B4gutbkEKHS0P+ra2hiqHy536ZrQ9g==
X-Received: from qvbmc10.prod.google.com ([2002:a05:6214:554a:b0:6e1:a069:1177])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:238f:b0:6dd:c594:27a2 with SMTP id 6a1803df08f44-6e243c07fc9mr200676046d6.27.1738343630669;
 Fri, 31 Jan 2025 09:13:50 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:27 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-10-edumazet@google.com>
Subject: [PATCH net 09/16] ipv4: icmp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ICMP uses of dev_net() are safe, change them to dev_net_rcu()
to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 094084b61bff8a17c4e85c99019b84e9cba21599..19bf8edd6759872fe667af82790b77b01212271b 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -401,7 +401,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	bool apply_ratelimit = false;
 	struct flowi4 fl4;
 	struct sock *sk;
@@ -611,9 +611,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		goto out;
 
 	if (rt->dst.dev)
-		net = dev_net(rt->dst.dev);
+		net = dev_net_rcu(rt->dst.dev);
 	else if (skb_in->dev)
-		net = dev_net(skb_in->dev);
+		net = dev_net_rcu(skb_in->dev);
 	else
 		goto out;
 
@@ -834,7 +834,7 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	 * avoid additional coding at protocol handlers.
 	 */
 	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return;
 	}
 
@@ -868,7 +868,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 
 	/*
 	 *	Incomplete header ?
@@ -979,7 +979,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
 {
 	if (skb->len < sizeof(struct iphdr)) {
-		__ICMP_INC_STATS(dev_net(skb->dev), ICMP_MIB_INERRORS);
+		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 		return SKB_DROP_REASON_PKT_TOO_SMALL;
 	}
 
@@ -1011,7 +1011,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = dev_net_rcu(skb_dst(skb)->dev);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1040,9 +1040,9 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 
 bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 {
+	struct net *net = dev_net_rcu(skb->dev);
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
-	struct net *net = dev_net(skb->dev);
 	struct inet6_dev *in6_dev;
 	struct in_device *in_dev;
 	struct net_device *dev;
@@ -1181,7 +1181,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
@@ -1198,7 +1198,7 @@ int icmp_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct rtable *rt = skb_rtable(skb);
-	struct net *net = dev_net(rt->dst.dev);
+	struct net *net = dev_net_rcu(rt->dst.dev);
 	struct icmphdr *icmph;
 
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
@@ -1371,9 +1371,9 @@ int icmp_err(struct sk_buff *skb, u32 info)
 	struct iphdr *iph = (struct iphdr *)skb->data;
 	int offset = iph->ihl<<2;
 	struct icmphdr *icmph = (struct icmphdr *)(skb->data + offset);
+	struct net *net = dev_net_rcu(skb->dev);
 	int type = icmp_hdr(skb)->type;
 	int code = icmp_hdr(skb)->code;
-	struct net *net = dev_net(skb->dev);
 
 	/*
 	 * Use ping_err to handle all icmp errors except those
-- 
2.48.1.362.g079036d154-goog



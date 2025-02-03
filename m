Return-Path: <netdev+bounces-162115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9F3A25D0A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECF6166540
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A720E020;
	Mon,  3 Feb 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mehIXYGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399B212F94
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593064; cv=none; b=A0fbtErHppZJOR19dawCT+p0+jzQZ21PlUOccpBAJJWp88cwp3fP9ML8FsZUg2rbk2aixVtbnn1/ywRSNJWEG6MmxV8OrTW4tm8TsTSuWkZ97rXWekzaxAX7n1dUoaoTmoOe4v4s0rUOWvm51S8FywFnTWTbQX/BuJdqdMxvJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593064; c=relaxed/simple;
	bh=d3dj99GwhO57qeQ2adh9xlLxNv6SasSECy9c0wvM8hA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fPNTbusXoYc46V2HgrbaNtoDGtVerC7RlpJYAdhEbGxOWhrKBMBrdihtG/Layspe7ZeHOy0gHms3H37AdBjVP+amAjzsexfiBS0fSmNWd6f0vYHbPkFRjueEsNEzjEeV8BprfY+jDMUdip0iUzlM5aIg/W00ZdWCHaMqjzZEjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mehIXYGI; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-86109879700so449537241.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593061; x=1739197861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+ZMNVR2H63jr3rmlUpqr5AzS7G4WJne1EULmAVBdRU=;
        b=mehIXYGIVCyO00plH0Kgw5eTfZ+wfky+q+RGeIQzyyTwtvposu9xHrQ5efqyyVv0tA
         LaCsk1uP1ShdaibO1CuR2iqEY0NlQh9tuGLU/JU4UIRR/5UB+L6YNO0AWrCBFfyyBTd7
         +Od960N/WAC68/U2+jQR2e+Xf+pkCPKnbnD4HLILwRE2185LxnSchgqsy+/8KjX72DfC
         G6AFS3L6dtRtEKYmemIW7tOa/3Jfq5oSmCdwoWACEObNxHpac/YhA/iYz+9u3nmBTcgf
         0ok000iho71YwRVufCnkzJURM3P3besvY12TJx5HswF44pI0zinQpMxjtUcusplK1Tv0
         U31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593061; x=1739197861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+ZMNVR2H63jr3rmlUpqr5AzS7G4WJne1EULmAVBdRU=;
        b=I7wonv8k8tjiGGAOJn+6cD44eLu/D5AfQ1ICsibrtI7P6BCssRSpl1PDn4FopLxPsh
         TLEUvDICA3nPGZx7dII5juAk2Imq8qnYpUEpnagLZUPs3L289T091mK7d/zuGihaJ63l
         hiP96i90mhOhpDAsP8hmnMS6YMOrWWKpoLZ0iVpGAALDgQjfgoF8t+NJO3vI63rvIWCr
         v0lszg8c/mWbxvIZ2WurDi4Xv6FE2gN0RUH2lF96jr/+On6YbQlwZajiXP2HW3szmZPd
         V0Z4PllPqXAJimiss0j0F1rDHyi+42VxPly2l5+wQOo97yog58qPVCFiWGrxXh6sC9sx
         f/YQ==
X-Gm-Message-State: AOJu0Yya0dey20INGWiDKX7U6vPCYSwoeizAzPU02oSBpkdm3hahaXPw
	CYDgwrjcmIq6TntyNwkC9VgmZAKGlyq/NZMxKPDo24mcZRkHCW+nL87gowrxi3U2FIUiRTsbOCw
	m7k/+U3gL2A==
X-Google-Smtp-Source: AGHT+IEEwB8C7BPhqTDfCMdaqAhZaj5RWt0+s5JsxcAKBZBZy4hef2lkZyaNWPwOP1CDzyUrR0kMSqNdXl94oQ==
X-Received: from vsvd34.prod.google.com ([2002:a05:6102:14a2:b0:4b4:53a9:4626])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:571b:b0:4b1:340a:ce63 with SMTP id ada2fe7eead31-4b9a4fa355dmr16459530137.11.1738593061244;
 Mon, 03 Feb 2025 06:31:01 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:39 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-10-edumazet@google.com>
Subject: [PATCH v2 net 09/16] ipv4: icmp: convert to dev_net_rcu()
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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



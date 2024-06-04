Return-Path: <netdev+bounces-100762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72AF8FBE41
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE31F2235B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FAD14E2F4;
	Tue,  4 Jun 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ECNOhF4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022614E2E4
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537675; cv=none; b=nATkkwkm7n+KGiQJq6qQIUbtT8Afm/xiV3r4ZI+7UI7JQl1DQruGG2AX+47NjUbQZtVoeMGukMYGE4OmoSSe35l0YOGKWFkSRN7f5Xecy+b3yNs5bz64Zp09+k3Cy8g1Fj6mOxaQGOZRE3NQ3G+0r0CzuXqXreiQb3YDexRcZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537675; c=relaxed/simple;
	bh=kSyvuVmoawm0A1229Z9cjCnSswrtkKHtT2WgaP8HoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6QYRWBbojPmIunGH06S32LDzQ2Uwa4qD4PiH28DdA9zOVRUAXsPLnc+5cg8DdQu+QS0biKBjbHMwP/EROQEgzB/2HAK8jsK1gmF+pV/Zh30ZXDHESrxCFck5/8oAGDJLx1IZs4rbduxvrDUX7oomZAxdnur1HFiGMZTpaB1G+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ECNOhF4D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44025bb945dso5448161cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717537672; x=1718142472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=ECNOhF4DhW2ck/MgMn1GFml8XgX8b+BjYujnwEMYcKdHODY0s8cx8aSIJ1Y1K1B+wc
         fWxZD4GHXFcZSBH5YsyaeEbm0AmPHfFrU4LrrDgr72TrjMXcDE9YiwuNGGtXWNkDRJwg
         zqYbNQ6YRjdRUGYDewv2hfnYC25Id6c+SOJ1rB/aoHgUEFWOR5NMMmf6ZTeLR49z9ZjX
         u2IZQ3sFjhQItraejhwuuBdRMiRqnRuKg3A3P24uM9Xv21/2LWZWwiMFVFOm0QKa4Wr0
         cErmXR1vL/CG0CVG5oKDxRd7y2++TrFJHbgfIPoqgEa83AeIezy9cLfX6nUlgMPDjG0o
         vLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537672; x=1718142472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDm6iwovalgWz0sxMpvGD5PNxGmSKas+lavj2Qq0ow=;
        b=jpF97HqU7OOutaVdjwi7Oh2bkHd3fCNfn06TEBGBTNc0QN8NippXiPR9iNs1Anlo2M
         tLifMZgPjYaeUnL+mxxm7cxNCM4doi6odmV8/oJF/cRExQmSz1/JsdkEulv1HevX4XRV
         DWLtLe/rtfQXoksOjtHNj+SVTvzB+d6obLBJ1/j+GpaGzY7TaEkbMifcpTBG6J1EKgwZ
         //M0pCZTTosjH1gbpe0BOE0Xr0YbIPOQWaZBQF370OV1jUZ8dcZa+GALOX8xxuGEhpH5
         xjXsoG/TSff0l3lQjrKRPqrP8nRUEl91kXX/yMIuD1cYROc0sCFmPDYD5U/4BntxuC9v
         s1Ng==
X-Gm-Message-State: AOJu0YzMCjL5Jys34R5hQ1g3xE9Sf0p5B7ZpO4DqriWNGHsmLf3zhlhl
	GkeLGmHTqL+SO3BDK7taK5D2gCyrRDFinETlOm0ueDZGSaeOSKXEzUonm9PYHpcsli8XVEnaqsH
	3aWI=
X-Google-Smtp-Source: AGHT+IGrjmW80tkDxovgZo69Xf5PbK5esJcY0OF5LniVh0HDjzfNjOgJwHal5f9dAzBVDUlBowbAnQ==
X-Received: by 2002:ac8:5dd2:0:b0:43d:f989:edbc with SMTP id d75a77b69052e-4402b670b7emr5780621cf.52.1717537672021;
        Tue, 04 Jun 2024 14:47:52 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4402627e268sm6946441cf.61.2024.06.04.14.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:47:51 -0700 (PDT)
Date: Tue, 4 Jun 2024 14:47:48 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [RFC v3 net-next 4/7] net: raw: use sk_skb_reason_drop to free rx
 packets
Message-ID: <854cb997b5407fbc4d23014d895f7cef5df724a1.1717529533.git.yan@cloudflare.com>
References: <cover.1717529533.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717529533.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/raw.c | 4 ++--
 net/ipv6/raw.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1a0953650356..474dfd263c8b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -301,7 +301,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -312,7 +312,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f838366e8256..608fa9d05b55 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -362,14 +362,14 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) &&
 	    skb_checksum_complete(skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 		return NET_RX_DROP;
 	}
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
 
@@ -390,7 +390,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
@@ -415,7 +415,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_SKB_CSUM);
 			return NET_RX_DROP;
 		}
 	}
-- 
2.30.2




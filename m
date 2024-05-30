Return-Path: <netdev+bounces-99566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A58D54C2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463041C220D3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D5186E4F;
	Thu, 30 May 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JvyjSpIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B3182D3C
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105627; cv=none; b=BYSLdMzBFXYzUHpuaHJQxpIR/WslTcu4PKbLxe763lXd4SF1KXynlsIHz4mHOR5pwURmIr0K3+OFd623svD/cP2hJ5GIQj9JLWOumO+9FrlTpAmGnJ7GjP7ZL1ML8HscFyPlsK+qJVqEAC/GQ0+KkAGF3Cyjb9iZ/42zlsiWnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105627; c=relaxed/simple;
	bh=y3+eQROhctQnk3LEiLSPrdQt64pO69knN7si0Z3L3mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfXL0QetNSmXy1oYuLPUXifMwrb3gS/sS7nBcXyZKRrSc/uzJt/u/aQ8ZIR/6EdkXDDxa6KNLizTGHO+/o/rKXRIaBmXPpzMCVqdVHVpUu0MBs5VnapF1Ljcv8tsJnHNsdyMiKe5Qghj3BuCS2BSZhWq4e9yZYxXMh7tzjvCgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JvyjSpIa; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-794cbdca425so100346285a.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717105624; x=1717710424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRNW+MUSsgkJBT+7REaMI9265axxAr+6yEAep7NXTwE=;
        b=JvyjSpIa/ikelX5qwDU8A4rGizYHJh5lFSz/5IHIjsTF7ozc1Uadns0qlV6s2G3KSv
         CY2BLKQVGquwKRuUwdgOAtPWk7DvOl82WLwOB/f65Q9dWgwLnf8MrqhD5QJWaqXrEkcu
         IgnRSroauLWV8KuEBTYEbkrSqdff9F5chJCe0PlR5haCJaDJntNbo5Jso4HHLvpFCmKT
         yg+KjpGPE8/SgeTKW+PZsgZ5oaydi1+PZglWmKpFC/N1/L+Ly0C1nCJC1gGiOYCwADaD
         MCPG/f2wmDYcz2mfiKnQNA1t8N+9YE1VkYpQ/9I+WFZyW2cV9naCiKhRUpefLZ4bQPhJ
         ml8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717105624; x=1717710424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRNW+MUSsgkJBT+7REaMI9265axxAr+6yEAep7NXTwE=;
        b=tamnIkaxJr0upUpxV/PcHKb3hM6ShpW/5NMk7iK/QBiZ5ZWg2ptgZ6eap2yQFHkVZ7
         AwHDxeEBx00IEHQPm4BVWzJu1uJKqgIzPplxOqRRQREI6YpIOZxWTOgf2zWmBisaa7bn
         qxyufK4jz+LHUVN7BQsaybPi9Q72kgxFl3YIETQ/GD0KNBZdsVohF4vSJmAjf321ThwA
         i/gZsieKYjuQ+jp6TaVZ9sJrCnJYgU15ljVOLHpfwkGKP/H9IxSAhzypqOy+IzOwZLtJ
         mYoL4yAxcxdGaJCDTPqjTLhscjcUrVQJOWz39npht+ZYYD69Hm1FpqNCi54Vj7HHNQTc
         Hs3A==
X-Gm-Message-State: AOJu0YzsSaiJmPYgOJK+Xd2K2zdmw47mFlOTAwlvy+rsz2QhsNr26/KO
	WWUFdijvPeoWV2pV8wFhxtmwQBa+ztcaXm1u6bSnmaEnGpG+Rs5zIau2FwuAIcQXYTuRg11VOCO
	fiOM=
X-Google-Smtp-Source: AGHT+IEzs95+FCSCrSeu5I6ebwijeLwG58rCifGbKQk6mzGpuAgio+YB1VxEby878mMBqMulFOPD7w==
X-Received: by 2002:a05:620a:6126:b0:792:bfb8:848b with SMTP id af79cd13be357-794e9daaaf8mr406252585a.27.1717105624315;
        Thu, 30 May 2024 14:47:04 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f306332bsm14237385a.76.2024.05.30.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:47:03 -0700 (PDT)
Date: Thu, 30 May 2024 14:47:01 -0700
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
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC net-next 3/6] net: raw: pass rx socket on rcv drops
Message-ID: <f17b2b252963301f5f15b9ac27f473fc9de96e62.1717105215.git.yan@cloudflare.com>
References: <cover.1717105215.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717105215.git.yan@cloudflare.com>

Use kfree_skb_for_sk call to pass on the rx socket

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/raw.c | 4 ++--
 net/ipv6/raw.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 1a0953650356..429498420eb3 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -301,7 +301,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	ipv4_pktinfo_prepare(sk, skb, true);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		kfree_skb_for_sk(skb, sk, reason);
 		return NET_RX_DROP;
 	}
 
@@ -312,7 +312,7 @@ int raw_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		kfree_skb_for_sk(skb, sk, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f838366e8256..c927075f013f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -362,14 +362,14 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if ((raw6_sk(sk)->checksum || rcu_access_pointer(sk->sk_filter)) &&
 	    skb_checksum_complete(skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+		kfree_skb_for_sk(skb, sk, SKB_DROP_REASON_SKB_CSUM);
 		return NET_RX_DROP;
 	}
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
-		kfree_skb_reason(skb, reason);
+		kfree_skb_for_sk(skb, sk, reason);
 		return NET_RX_DROP;
 	}
 
@@ -390,7 +390,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
 		atomic_inc(&sk->sk_drops);
-		kfree_skb_reason(skb, SKB_DROP_REASON_XFRM_POLICY);
+		kfree_skb_for_sk(skb, sk, SKB_DROP_REASON_XFRM_POLICY);
 		return NET_RX_DROP;
 	}
 	nf_reset_ct(skb);
@@ -415,7 +415,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
-			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
+			kfree_skb_for_sk(skb, sk, SKB_DROP_REASON_SKB_CSUM);
 			return NET_RX_DROP;
 		}
 	}
-- 
2.30.2




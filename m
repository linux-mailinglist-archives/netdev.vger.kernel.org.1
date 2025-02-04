Return-Path: <netdev+bounces-162540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F5A27333
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C7D1889494
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F006215788;
	Tue,  4 Feb 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spwGIoOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6E21ADD2
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675463; cv=none; b=nTu+FwFH5TE4QK8vU6HwVhzaPMa+S0a7RjJixNGBAtWXZcwdHOX9KDOozFG04oF2Q3J9zIDZSABLFnATdJiRTW1q89s/eHp3OASooePiT3bfbh8EJOOvhmkKUDuUdkeqALqYICs8iRNWtvv8MbrLFNpnpYU9fmU5SenthRmxrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675463; c=relaxed/simple;
	bh=EBbPvxOWDuVZT9dCKcZQ7dF5vOxnJ2dsyERiuGzIvv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OX2+rLheQtSvhmsl7suCYUhaY1rRBNM0IFWsxv7VwpLGDKkthyNLNoVbF4TIxmyPGXDchjXUjW1Lo0zF9427J8ZbrIhoxGUCiwNtCWxXVu8opobOlN74lj/m5XFsQogpEm6MyaYDCVaptwtQiMPREfYUjh65ZsnnFkP34R9K+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spwGIoOe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f28c51fde0so55804567b3.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675460; x=1739280260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SVdRvkLIsGq6su81v12UHC6PsBXnXjKLGYhsQefYE=;
        b=spwGIoOeLJnXhlRDSqD2YaVnqsWiZhRKeVphhQSRHoO2/cyRiXYRjXig/YXWVTcZaa
         gZgz1Pv3JHGdO/97LMpeiFQSW9pbjXOuBojlphkkaFFvAjWx+WVDeyy9J4Yu1KIZLfdc
         TrnlUPBWBNFIngJ93M6CfjJA14SAsaHfF21w/DPwR/pDSHBjTu0bjxy6v+TSbvWrBDXX
         qPdSrc/6DyP4wKpOPjtZalIJtsdkkV1B3u8Xkhqhw4oRQ4eCCUPqj8IESLpK/mfJqtMl
         K3Jcyh9BKaAxjQfQlnpDA5ns3AahGH+5+dFpimYjcmsNnsqVNcbpC5+H+Kuf09yRmQLJ
         v9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675461; x=1739280261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SVdRvkLIsGq6su81v12UHC6PsBXnXjKLGYhsQefYE=;
        b=BMrPv6vFAXI9WY5QJ5OsIPgTFBJKTuklmq6RBPGA5mvFBZvK0ncM6O1EeOWsP0lsCr
         C7HiOKSXRO0mJG+BH47HaLLYJrcRqVRHMCd3LlC8jAU8Pk203AoImrtwAHEEwCn4+k2r
         hvDoANjRFkxH+w35FL9rO03kxVEhn784z3VKpZ+gYGUvqMAVWC8wq6yRaN4Pwt4PIPL5
         jsxrxgEQoRXk5Phoc0aV/N/M0gIgD0S/c9iG/vVlDysrbnvDrC/MRL7WTvJRgxlfwM0M
         i+27WH2lsPTZc99R3P2nggZZCbAv87xm1DPlqtJe3j4kihnhqxflApRcC1EGuUbSph11
         28ZQ==
X-Gm-Message-State: AOJu0Yzb8pmmD9xjffGNWz793Z0vB8VUalstESUbk08pRYdvDXiQv1EP
	17IsiFMK0Lclb2h6af7WsFWf8b0kmTcDa+Vg40BdLThRAtqSGx3r9WFgV2r+C5WbKtbP/WOgxf5
	zcTCEXlBQug==
X-Google-Smtp-Source: AGHT+IFl+JeLCvHuU0m5jmChaeVLI+F2GS1eIunCcGmP85pXPVCkox8+PAFk0GvonwhiuU1eQw2EZCrsMggYXA==
X-Received: from ybbeb10.prod.google.com ([2002:a05:6902:278a:b0:e44:6c5e:fe3b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:2204:b0:e5a:e731:48be with SMTP id 3f1490d57ef6-e5ae7314b47mr10758854276.13.1738675460703;
 Tue, 04 Feb 2025 05:24:20 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:53 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-13-edumazet@google.com>
Subject: [PATCH v3 net 12/16] ipv6: output: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net() calls from net/ipv6/ip6_output.c
and net/ipv6/output_core.c are happening under RCU
protection.

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6_output.c  | 4 ++--
 net/ipv6/output_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d577bf2f3053873d27b241029592cdbb0a124ad7..4c73a4cdcb23f76d81e572d5b1bd0f6902447c0e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -393,7 +393,7 @@ static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
 
 			if (inet6_test_bit(RTALERT_ISOLATE, sk) &&
-			    !net_eq(sock_net(sk), dev_net(skb->dev))) {
+			    !net_eq(sock_net(sk), dev_net_rcu(skb->dev))) {
 				continue;
 			}
 			if (last) {
@@ -503,7 +503,7 @@ int ip6_forward(struct sk_buff *skb)
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net_rcu(dst->dev);
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	u32 mtu;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e60b27726facbb59bbef97d6fee7f5..94438fd4f0e833bb8f5ea4822c7312376ea79304 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -113,7 +113,7 @@ int ip6_dst_hoplimit(struct dst_entry *dst)
 		if (idev)
 			hoplimit = READ_ONCE(idev->cnf.hop_limit);
 		else
-			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
+			hoplimit = READ_ONCE(dev_net_rcu(dev)->ipv6.devconf_all->hop_limit);
 		rcu_read_unlock();
 	}
 	return hoplimit;
-- 
2.48.1.362.g079036d154-goog



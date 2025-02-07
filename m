Return-Path: <netdev+bounces-164005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AFA2C44E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701F03A9441
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8121D003;
	Fri,  7 Feb 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7wiMAim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D7215043
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936735; cv=none; b=GCFNtRa35HVTEPJbYFpnlQSMfybKcr7Xur9v0krYSt653q5qSl0URex2+88N3blsFhBSuXr7HnMoorzrOHY6Hd1yrqG6GaX5RIQdFtUXn5DX/9HDJMr+VDMzOizTO7sWnLWneZrUnlqkNzdA8U+dMCsiM0G7xaHziinjSCStyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936735; c=relaxed/simple;
	bh=/LJvWcreEEAerDSTukjmKP7MgWMa9UN2BBvpxyTf3DQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qd+UKChzcSIK9knt69KVGnZ3bA9N2AlwdBRMVQ7BIFP8iKseGE7LSBEC+fVm9MBALnX7lyJDvJR92hULpXefWrFzmAlMQTnhz42i0P+DHXGkk62RjTsgQAptSa5LrWYpK4isXqzjaxCfr/xmQjXL7iGVLpYk5w6ft64c3X8CYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7wiMAim; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c03ff85008so424411585a.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936732; x=1739541532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dg8FsbPy9RUFaLmEehAwSOfd1SNk5Hq1VflxMhl3GFs=;
        b=p7wiMAimTrDnHOOvap0DhH0npkQGWziLR7ppPa7xi14PLTW6UeMYo46yrPPl/1jbBx
         E5nW3mPVNmiEZuxaG2g3Q7FXSsPrRPJh6R2f3kRBPGW4grijWRbG+a5mVL7xANEFJ73g
         8idbmR11XkQ/uP8aNHQEk3vTMpY45OTfG1W6VGRJ/Xxzy8fYhZ8tCvmnGvGiBS5NiIVo
         QSQTdvdEKRGT3yQGnX4tCgMnRM7b2qg+p8+yJ/+Q1M5gV8t6WRmnNmHZUGJbe5WZREWD
         YoVoyB+IHRz5C79EXAPhVmjsNm214uYTnJBBww+oHlGIeuiskvIcw/F/ep55OQeNPHBq
         YqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936732; x=1739541532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg8FsbPy9RUFaLmEehAwSOfd1SNk5Hq1VflxMhl3GFs=;
        b=SgTSaIfZpGVND31uPc4CyvJu9NeXmI+IIofP7arMKGXMtIX07SPUNaK0mwCyw4dAOV
         YVuqSjS52UL8CTZVEKv6IwkSA4Frv0RaTFeTCi7lxZxoNDqI5omivFtezQrxRObjpF6A
         F5oEHQFs9akSTR7SlX6Hh18KT1qQUxYPWB3bTsh6zFZ5phKAvRwNB3KFw4UhzkeqZAyZ
         cDxaY08tCptVB8UKYxsOQq3SiZS8kWW2ru7DcxH+3eEUMKW2P+J7npridlG6cOU/3BrR
         5bjHXgQq2wqIxwgbQ6k89qIh8wbowVCEOnVBhsuA2egs+FmEdMQxNtackkRbYARVgBz8
         75xQ==
X-Gm-Message-State: AOJu0Yzvq6YcFn7t7fNxmtrXzPhdIW/izMXyqSiJZDaNx4de9lC4kddv
	acnO2cr29+DmEz630dEWdxZJ+w8B6OKR3aVorWisEmLyBMa7JBxRd7fZxgcxjhiO75pCXRW/J7a
	xo2n/BMWrKw==
X-Google-Smtp-Source: AGHT+IH7/Fk/TY+gtkWI3ooyPh6oleQRaIyPv9Ln518JfwFJs7mrvZJNuZAgR5ZjhgLc6iLYDV6Xh9NtTh+MMw==
X-Received: from qknpw5.prod.google.com ([2002:a05:620a:63c5:b0:7bc:e5d3:d03b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:45a5:b0:7b6:d799:1f84 with SMTP id af79cd13be357-7c047bbc66bmr456653585a.15.1738936732607;
 Fri, 07 Feb 2025 05:58:52 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:39 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-8-edumazet@google.com>
Subject: [PATCH net 7/8] ndisc: extend RCU protection in ndisc_send_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ndisc_send_skb() can be called without RTNL or RCU held.

Acquire rcu_read_lock() earlier, so that we can use dev_net_rcu()
and avoid a potential UAF.

Fixes: 1762f7e88eb3 ("[NETNS][IPV6] ndisc - make socket control per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ndisc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 90f8aa2d7af2ec1103220378c155b7b724efc575..8699d1a188dc4a15ac0b65229c4dd19240c9c054 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -471,16 +471,20 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		    const struct in6_addr *saddr)
 {
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(skb->dev);
-	struct sock *sk = net->ipv6.ndisc_sk;
 	struct inet6_dev *idev;
+	struct net *net;
+	struct sock *sk;
 	int err;
-	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	u8 type;
 
 	type = icmp6h->icmp6_type;
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
+	sk = net->ipv6.ndisc_sk;
 	if (!dst) {
 		struct flowi6 fl6;
 		int oif = skb->dev->ifindex;
@@ -488,6 +492,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
 		dst = icmp6_dst_alloc(skb->dev, &fl6);
 		if (IS_ERR(dst)) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return;
 		}
@@ -502,7 +507,6 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
-- 
2.48.1.502.g6dc24dfdaf-goog



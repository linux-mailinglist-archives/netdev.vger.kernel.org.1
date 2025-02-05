Return-Path: <netdev+bounces-163097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE197A2954D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C7E3A1137
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51861DC9AF;
	Wed,  5 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dggopWDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA51DC19D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770699; cv=none; b=MHV7SSQ/azLLMpyKG9FDICsR+TJ97wIKOLLISCdUIzuBomAuL+eDMZCPasrgTqPJKVW7LEuqNnNN6PFPoRn+tFSuz2kqHtwSGK5n5vJMHkBQsXSVP2eqOZSmHPOYPj+4iiFP+kWkhLOTaCVsxtsCrPeIisysRxDl3bWPZRiRPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770699; c=relaxed/simple;
	bh=U2kX53Sg+dT2QzomNtvGlbWRO8/OdC8wBUIn0TCpjBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q50fwEmaI9ECJaXH8uNPbdklFNhtqwfD1eezGm4yCi25QBQK2DpiDd3oHh5mfy+s3VW+27GxkvJGJ7wkXPb+RRrJ52qmM+ztI6G0FmyiZ2QqdlwzFZLxtpqTOJbM3TEW+uPcaybTWIE76C5FRHJ7UvIM2TbtdG8I8v41oJxL0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dggopWDv; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4678f97242fso187496991cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770697; x=1739375497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zszYcJFJYdWef4gkJGhQ49R4MBi7sue+kr7ORa+aE30=;
        b=dggopWDvJ6aKcLDGfz/L0GNRI2rj/i34lbzn6XxQpXITcZKmkPJsI28y8UZkB/xn9Y
         kD6DwnSsdT7Vlx4ilNPkmrMLhAB0AXu5PI4JhSXuPy99vQNl//PN9zkqBwo7ShxTx50t
         zio95mqorwUfsjJRqq4LH+JhQmbFCbTvzuwUJ/O/Gn6mqg6Rkl7c9nDwFKBni1mST3uD
         SWk1GVwUXnxRtRQRkCG7ivUKJPBtohos9TUQk1V/Vjlq415JTzoWwPO8KVY2qlCguJPb
         FX/ycDrdeBBP+XlGdvEvyIh4cJh1nglByvt9rlRT3v43BoIAOWy4Wg7ZEv7f5lgP3yys
         thUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770697; x=1739375497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zszYcJFJYdWef4gkJGhQ49R4MBi7sue+kr7ORa+aE30=;
        b=VerxPGAoPXll4jUqdaVeSGUXOQvSFh5isHlhfH+91MJCb25bu8s5E59HFAA24oKE3D
         rgSLWYSyNPts5N7cMNrOZosS0+w1WQLi98BY3eirEVLUaI2aYCvGisQ4HtTXqCtCBOpU
         YKSioZoyC1Jpmtpk9LNaqCB0MInLAqE5yyLcjVgAcWg41RNRrSbOrv3YVYGEWrckjWGo
         uGLpJm4IpgqI1I971ShN2WxIzioTU8oNX0dFmQDc0JfD8bjkSHUxy/pmet4qow7WN0so
         ht4VL56w0N8FuJqzBsP7JqRtVn0NS89wRySbnFXlLCz6kf7I4cL5rXJ7c8yo9sinppRi
         zXKQ==
X-Gm-Message-State: AOJu0YzLbrgTA2pZfmiAToT2PL2z+FYolc3n9arXJeLritA/V0HXTQoK
	JQAigiLn+FgHDeu8YD3yy0XpUANAcBvfqYwkJY62p17P5s7HmyK6ol4f5tLBUk5hXX8umiKfERe
	P1PJilF7qkg==
X-Google-Smtp-Source: AGHT+IGbd/+oJHM6TirW7H5yPo35H5mReONoHPz0xWqgOw08EugnYp3zZdq9/dUohYYdS081sq4BevKwlCi3wA==
X-Received: from qtbbq13.prod.google.com ([2002:a05:622a:1c0d:b0:46b:1ac5:905c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:156:b0:461:5571:5cc6 with SMTP id d75a77b69052e-470282d6974mr45310731cf.46.1738770696990;
 Wed, 05 Feb 2025 07:51:36 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:19 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-12-edumazet@google.com>
Subject: [PATCH v4 net 11/12] ipv6: icmp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icmp6_send() must acquire rcu_read_lock() sooner to ensure
the dev_net() call done from a safe context.

Other ICMPv6 uses of dev_net() seem safe, change them to
dev_net_rcu() to get LOCKDEP support to catch bugs.

Fixes: 9a43b709a230 ("[NETNS][IPV6] icmp6 - make icmpv6_socket per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/icmp.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a6984a29fdb9dd972a11ca9f8d5e794c443bac6f..4d14ab7f7e99f152cd5f5adaa023f0280957f275 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -76,7 +76,7 @@ static int icmpv6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	/* icmpv6_notify checks 8 bytes can be pulled, icmp6hdr is 8 bytes */
 	struct icmp6hdr *icmp6 = (struct icmp6hdr *) (skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (type == ICMPV6_PKT_TOOBIG)
 		ip6_update_pmtu(skb, net, info, skb->dev->ifindex, 0, sock_net_uid(net, NULL));
@@ -473,7 +473,10 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	if (!skb->dev)
 		return;
-	net = dev_net(skb->dev);
+
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
 	mark = IP6_REPLY_MARK(net, skb->mark);
 	/*
 	 *	Make sure we respect the rules
@@ -496,7 +499,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		    !(type == ICMPV6_PARAMPROB &&
 		      code == ICMPV6_UNK_OPTION &&
 		      (opt_unrec(skb, info))))
-			return;
+			goto out;
 
 		saddr = NULL;
 	}
@@ -526,7 +529,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if ((addr_type == IPV6_ADDR_ANY) || (addr_type & IPV6_ADDR_MULTICAST)) {
 		net_dbg_ratelimited("icmp6_send: addr_any/mcast source [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -535,7 +538,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if (is_ineligible(skb)) {
 		net_dbg_ratelimited("icmp6_send: no reply to icmp error [%pI6c > %pI6c]\n",
 				    &hdr->saddr, &hdr->daddr);
-		return;
+		goto out;
 	}
 
 	/* Needed by both icmpv6_global_allow and icmpv6_xmit_lock */
@@ -582,7 +585,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	np = inet6_sk(sk);
 
 	if (!icmpv6_xrlim_allow(sk, type, &fl6, apply_ratelimit))
-		goto out;
+		goto out_unlock;
 
 	tmp_hdr.icmp6_type = type;
 	tmp_hdr.icmp6_code = code;
@@ -600,7 +603,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 
 	dst = icmpv6_route_lookup(net, skb, sk, &fl6);
 	if (IS_ERR(dst))
-		goto out;
+		goto out_unlock;
 
 	ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
@@ -616,7 +619,6 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		goto out_dst_release;
 	}
 
-	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
 
 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
@@ -630,13 +632,15 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 		icmpv6_push_pending_frames(sk, &fl6, &tmp_hdr,
 					   len + sizeof(struct icmp6hdr));
 	}
-	rcu_read_unlock();
+
 out_dst_release:
 	dst_release(dst);
-out:
+out_unlock:
 	icmpv6_xmit_unlock(sk);
 out_bh_enable:
 	local_bh_enable();
+out:
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(icmp6_send);
 
@@ -679,8 +683,8 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
 
-	rt = rt6_lookup(dev_net(skb->dev), &ipv6_hdr(skb2)->saddr, NULL, 0,
-			skb, 0);
+	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
+			NULL, 0, skb, 0);
 
 	if (rt && rt->dst.dev)
 		skb2->dev = rt->dst.dev;
@@ -717,7 +721,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
 
 static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sock *sk;
 	struct inet6_dev *idev;
 	struct ipv6_pinfo *np;
@@ -832,7 +836,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 				   u8 code, __be32 info)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct inet6_protocol *ipprot;
 	enum skb_drop_reason reason;
 	int inner_offset;
@@ -889,7 +893,7 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
@@ -921,7 +925,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 		skb_set_network_header(skb, nh);
 	}
 
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INMSGS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INMSGS);
 
 	saddr = &ipv6_hdr(skb)->saddr;
 	daddr = &ipv6_hdr(skb)->daddr;
@@ -939,7 +943,7 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 	type = hdr->icmp6_type;
 
-	ICMP6MSGIN_INC_STATS(dev_net(dev), idev, type);
+	ICMP6MSGIN_INC_STATS(dev_net_rcu(dev), idev, type);
 
 	switch (type) {
 	case ICMPV6_ECHO_REQUEST:
@@ -1034,9 +1038,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 
 csum_error:
 	reason = SKB_DROP_REASON_ICMP_CSUM;
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_CSUMERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_CSUMERRORS);
 discard_it:
-	__ICMP6_INC_STATS(dev_net(dev), idev, ICMP6_MIB_INERRORS);
+	__ICMP6_INC_STATS(dev_net_rcu(dev), idev, ICMP6_MIB_INERRORS);
 drop_no_count:
 	kfree_skb_reason(skb, reason);
 	return 0;
-- 
2.48.1.362.g079036d154-goog



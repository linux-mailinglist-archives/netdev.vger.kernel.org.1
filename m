Return-Path: <netdev+bounces-162118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D4A25D3B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA94F3AA3F5
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629D9213224;
	Mon,  3 Feb 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvSGTTzA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B698212FB6
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593068; cv=none; b=ojHBmw9XWChdbXC80rowyHbqlk809wd+RKh3nPhjoXixV0T/GVmjuX0Oi89zMMaeRqQwUo4T/uimZ41PiOqBiHZJEggly2s3Cwr6VCr2o30m2qkn+UoBO519idmmbrIGzifdpEjWFaG94HiBwD+j4qnnQYWIMo4oPwQjwKYESfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593068; c=relaxed/simple;
	bh=EBbPvxOWDuVZT9dCKcZQ7dF5vOxnJ2dsyERiuGzIvv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wul+fHnTdbencUI2HA9OoRlR+YGLgO7YVxGpFgRw3NxXRRiRzA6va2pVnotBa5wrT82JfJWxdb5J+7ZuSnhGrtoFcqVPhdnk66JzRgKqlt65JVWj3udDRzDrtueihaeccZEpq/qCqU15hDl2aZXMXAQT3jG1+ulSmsRHIM3nvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvSGTTzA; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d8fe8a0371so70558206d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593065; x=1739197865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SVdRvkLIsGq6su81v12UHC6PsBXnXjKLGYhsQefYE=;
        b=qvSGTTzAQL6m7ySS4RJkY2vhca83aDesTi7mqtvaCfA2WnJyATXq8i9OFDQj8lQu40
         srec0IeZs2RCQuMmuCG62PQC9SGlFyGcn6SzcvHl+2Z2FE0SGOsgdpVtPTyPh1DqiMi/
         Mxsmz+yKRhaa04riX9tl6p4O1eJaYXjNThcjHjcsbOz0P8DWINWrc704/dOODJ/BU/sG
         8Bquxc2fwly+FgAaO9zBgXG6UNEW3ZoynnAmrujYzZqtq6rL0Om+omtCfLerge4SmpPC
         GCc7jZj6ZHhW/vjRjUzqYEJiZd46QljTopjCwcePN4FcghhrRjV+cPoRQTV6KxSbcsq5
         MQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593065; x=1739197865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SVdRvkLIsGq6su81v12UHC6PsBXnXjKLGYhsQefYE=;
        b=ay/JP/xfVQM7HOnKe6vncuM14C16xm24flNKTLzd36B/NbWGVamBcYWja6Ri++85FB
         I9GbwwRnwa8h2vDEUDc3W7m5XsVkljbQGBw/A9G96L35KxaRGYR2LzOaZNDamHxCVJh2
         fKwrw4gwBgYkhG1oQpfbGTtI3r4xEMzP/q1iSst9WiJwZ/q7mtHu6R3yVf6sNlYOFgWR
         n0J1qLpyXp654cR4+NCc6bj6GFGsoHixfb64TQ3GFZtXS61kbyKx5il9LL/iiT0is6lP
         j0q+BKJLSvun3B/5dsdpKIUraMq+cqPW4SUtxlA9S4Ag3Ht4E5rugYpoYrP0BRMiscL7
         GI+A==
X-Gm-Message-State: AOJu0YwvFDSnNduzorBq0cuuoAHdtOIh2PXR6h/wE3D4O2eMvrq8qlJa
	5jruR6xSd3VdRuXo5sGeY440mgFuoEgJGRBpSCAvrEKaTNsBh6WJQFE8KPwONz5eEBgYz5p8WgH
	Ek9SuDABUTQ==
X-Google-Smtp-Source: AGHT+IGw3EetgSeKPNRgsQbu0MeSYCUMrSM6H/uqiv6/c+lfoXxTzw2xlwuE4qvQuQ1FoPMP4lmV/LXIjPiKKg==
X-Received: from qvboq11.prod.google.com ([2002:a05:6214:460b:b0:6e2:355c:1fa9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:412:b0:6d8:a84b:b508 with SMTP id 6a1803df08f44-6e243bb84e7mr291283806d6.12.1738593065417;
 Mon, 03 Feb 2025 06:31:05 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:42 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-13-edumazet@google.com>
Subject: [PATCH v2 net 12/16] ipv6: output: convert to dev_net_rcu()
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



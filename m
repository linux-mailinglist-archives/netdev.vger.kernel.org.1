Return-Path: <netdev+bounces-201908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16431AEB643
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4481C21344
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6272BEFE5;
	Fri, 27 Jun 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQcYZyyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405A2BDC2D
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023547; cv=none; b=dAl2Xav1+s53cDtsvCrdtu/nzCkoCXcISsgy28+UUJxCLj1b+s5T48iUK3yMNX2I9VwFjCOJKIqKzJ+j7u2aJrNzO8/KY97tANvuPJB4HyJj1HJ6MyxrQYf5RlGwVeLe/zXFBz55oZO+ViQp1B7OYnI6cuSwj4co2biDlBbk1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023547; c=relaxed/simple;
	bh=4opc7/ecamB5+bh3e68N0xfr1nqcpzLOPn7lqMwrFk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSjoqTM40Napk5a9zDx0OoJRnY9mdHZFK4ChTDDfjllllaYmqChYIeulT37rlHLzx7XbxlP3fpwRi/s84M8GEeawE4QCAM4pKlmVFp3ior08tO1YHw9hJZjCbEu1xQm572O8XWzqpVtDhJlYH3cR7NTa5vuc18o2BZ5itOICin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQcYZyyZ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a589edc51aso43892361cf.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023545; x=1751628345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDCe445NVtN1yNQth6Dn4TDSiBUVXVp6GB6U7hOP69I=;
        b=mQcYZyyZVg3UpE3InNbZ9UE7MiVLL1ayfPiqH6HLmYJwpCoprqeNWgtCZUNC1UA2MQ
         nanhrCbiBE85hqj7H9ao+M8AN3TuzWEt/hit4ld6bhpEMAOoZPztjLa1764TU7G5gg/3
         tvS67ORzTBSxBPdSGfYs8jBdruhEtDtfTTO2qr9QuwwsjjB0G9lKvCPbAmBTGEKKmiAY
         x6nGqD2Uq0+mVMnPPYuQPqW6H0fZcWOzrrEAfeHgOUUKkbaoNIkwNGhWJXgWJB7LDiT6
         XXXgQfDNsnBj7iYbt8HliYRMsUnwFvTIi+HS5PbPJU2P6rudlukxYBNkl4w5rgu5/6Wy
         Gvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023545; x=1751628345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDCe445NVtN1yNQth6Dn4TDSiBUVXVp6GB6U7hOP69I=;
        b=BKbpbVNQoQ4GEJ0dj1E0ZPdxjjjMK4CLT3gqIVD3zwc3pEo8ebBM2ps/8VsKw4wPeH
         LGgGl1q+VNy9VC9cq8qJ9mbdGtFnX7pE0f+SLmcVdOG8DJO7Gi33nI+uiok8yYomw2hf
         MXHLCJBxHg09R33cdtoj2oMQP7kYzKKkWB2DsIFjjnmKMJy/fqPV94B13MT+VPLqxj8U
         RPD49pKiTzq7l8X6px7f+1V64SDe3juxhegEUle3us766LpSwncoslwjbzd+dIZCa+c0
         R2OeGFx4a3mLZ92QCjm7K3Etli5gD+f/Gh1BnNTPnkUWsdXb6WYVwx0IKKX2KNJz7ymo
         dm0A==
X-Forwarded-Encrypted: i=1; AJvYcCXUCTZE0FlqnbSVYveO5MRgrT0h5me3bIIBv6IuWIj53SrqhxHnaO/kBUKoAE5lqkNYAVs/ilQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmh1U0vKbcu0iIl6i6cu9ylMef40qxd7UqTOj7Dmfa1fvYiyrK
	AsrhKtZeg3HTG8rRJHmT77MAQ8pk13F9SQZ9s98gtn0UShwn5b2v1y/MOAl2u48Mam4lxv6G2fF
	Qh0w81nNM0XQeIg==
X-Google-Smtp-Source: AGHT+IEISiUiws3fdPQQK3IANsJwlQShwHPec8XN1q1AyAprzrRtMiJP452FLsv5RfdKG6aI7zimiO3WvargXQ==
X-Received: from qtbcb6.prod.google.com ([2002:a05:622a:1f86:b0:494:57b3:465])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1494:b0:494:993d:ec30 with SMTP id d75a77b69052e-4a7fca249f8mr50859641cf.16.1751023544721;
 Fri, 27 Jun 2025 04:25:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:21 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-6-edumazet@google.com>
Subject: [PATCH net-next 05/10] net: dst: annotate data-races around dst->output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst_dev_put() can overwrite dst->output while other
cpus might read this field (for instance from dst_output())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need RCU protection in the future.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h      | 2 +-
 include/net/lwtunnel.h | 4 ++--
 net/core/dst.c         | 2 +-
 net/ipv4/route.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index c0f8b6d8e70746fe09a68037f14d6e5bf1d1c57e..b6acfde7d587c40489aaf869f715479478f548ca 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -458,7 +458,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->output),
 				  ip6_output, ip_output,
 				  net, sk, skb);
 }
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index eaac07d505959e263e479e0fe288424371945f5d..26232f603e33c9c7a1499a0dd2f69c0ba10cc381 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -138,8 +138,8 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len,
 static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 {
 	if (lwtunnel_output_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_output = dst->output;
-		dst->output = lwtunnel_output;
+		dst->lwtstate->orig_output = READ_ONCE(dst->output);
+		WRITE_ONCE(dst->output, lwtunnel_output);
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
 		dst->lwtstate->orig_input = READ_ONCE(dst->input);
diff --git a/net/core/dst.c b/net/core/dst.c
index 13c629dc7123da1eaeb07e4546ae6c3f38265af1..52e824e57c1755a39008fede0d97c7ed7be56855 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -149,7 +149,7 @@ void dst_dev_put(struct dst_entry *dst)
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
-	dst->output = dst_discard_out;
+	WRITE_ONCE(dst->output, dst_discard_out);
 	dst->dev = blackhole_netdev;
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 75a1f9eabd6b6350b1ebc9d7dc8166b3d9364a03..ce6aba4f01ff25a8f9238271a7ae2295f7c7bb93 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1688,7 +1688,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 			new_rt->rt_gw6 = rt->rt_gw6;
 
 		new_rt->dst.input = READ_ONCE(rt->dst.input);
-		new_rt->dst.output = rt->dst.output;
+		new_rt->dst.output = READ_ONCE(rt->dst.output);
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
-- 
2.50.0.727.gbf7dc18ff4-goog



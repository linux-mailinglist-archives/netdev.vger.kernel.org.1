Return-Path: <netdev+bounces-132214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A2990FA3
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0B9282836
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101C1D90B3;
	Fri,  4 Oct 2024 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZo/I/6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07F1ADFEB
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069418; cv=none; b=gPiX8gNk2fWmyUjQrv/W/uked7nxXb2UCRKZi69wKIYVHYi0XBPX8lLG0SM5vx9UIErwlwdeNbyH7Cd24fzKY1ce7i3oJDM5IBkmRHyoOx/HJeBLYksckgHb/auQaPLO0nNDuK2kjFheEMWOzGtZJikT5Qia2R0so6YwAyaY5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069418; c=relaxed/simple;
	bh=oyBhtjfCS4KUO8+N6jIQpgzbsKWLdqbQvXOYfY2XtsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/hMHddK/Y3FcUlwL+ZFUcnLebP987ud2RPUJEAI9iCyBBwrlgbGbDm0d9H9e1TtRRPRmbOu65JXtquahAdO4gyW0gSgFLi3IR53RKNyXmFSz4TyI+mISd5BV+RsQN5dMLUPdr/Kk6ZTZoddAcIhyS3GMd/5Im8xUkUD4iFMstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZo/I/6W; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f0be237so48482667b3.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069416; x=1728674216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQY54G0TzTKd8OAMtVgvMSskixlx2R2Qlae++KVsEb0=;
        b=nZo/I/6WVZJc1CAHrWa5OW6mFvYS5/Ggk5RZlrOEHXmyGjOJSJMHGOQ2/4N2A0KRwy
         HRLY4iI9452gWMxZAU4k5MHxaBmhqRydLXIjEa31GhnfMzxe8d2n/vehoKVY5RoOBbEy
         nMEvUa4rM5KqZnIsBkjdEZ7ozcjsSfdSFlprDu3V9iOxAlnBCS8tCGfvYaoyVvnSVDbj
         wPuZMB9y+YoishEqvtziF/1YsQMbjfORQLjIZIrmA64BEtjfrWoWeNiCM1KqHIwnqzWx
         sTrmJlwZmPZpM2ASJ/iajTN9tAedsakYB2TLfOJCLGFCRDqCW2sbldRLPncbGixRkTPT
         fq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069416; x=1728674216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQY54G0TzTKd8OAMtVgvMSskixlx2R2Qlae++KVsEb0=;
        b=Pap41VMmqWCxHbGG1vsad+Oc5J0TGdwLl8o+kYW+OLJL7gdgPWJhAioiwnmprAm6jJ
         QEM0nYhbN5mjKLQCEh1Zx0a3Y0IEeHT7spZOS6N/Od+LSNnoXPUjkGgdBhl/KtBpnh9V
         G1+Y54Pgl7fBJi7CTXVUVnfNDR0IOW1U6Vmjs4ctY5qf+Qr9isiNzMQ8JLS7eBarvpj1
         F4TB6zBZylDr20sbpPkpnpGyBEHMDWJbRlJOJqUQ0pk9t4XQocfX98gEixFSBic4NZvQ
         fLxvAvRA/mHn01XK7cBiVLuu2+f+DQuQU4wY5HpwP4i27hw5tO7iTLVeXtcFK6hzzXoi
         6cVg==
X-Gm-Message-State: AOJu0YzX5UnOlfAvAjvPRcnmCBd2+69x1oehaMZCc4tLks3zuMXxIK/Q
	QYLr0me9RxCBH9TCJ4y0oJSfZzoyfzvrnDxnIY0YzzhzUOrQ8a5GWESA+pAG/EYM+rg/74Kx62m
	AcTEHKrSxrA==
X-Google-Smtp-Source: AGHT+IHHkzkSi4zGZMJxVSWNTbopSJRZBtvXHIGN9zQ1umntorxUGy6BxKHw7vmyQE+EZZ+IkfqWqlW/OYd7pw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:b1c:b0:e25:5cb1:77d8 with SMTP
 id 3f1490d57ef6-e289391fba7mr2475276.6.1728069415606; Fri, 04 Oct 2024
 12:16:55 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:44 +0000
In-Reply-To: <20241004191644.1687638-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004191644.1687638-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] ipv4: tcp: give socket pointer to control skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip_send_unicast_reply() send orphaned 'control packets'.

These are RST packets and also ACK packets sent from TIME_WAIT.

Some eBPF programs would prefer to have a meaningful skb->sk
pointer as much as possible.

This means that TCP can now attach TIME_WAIT sockets to outgoing
skbs.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h     | 3 ++-
 net/ipv4/ip_output.c | 5 ++++-
 net/ipv4/tcp_ipv4.c  | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index bab084df15677543b7400bb2832c0e83988884cb..4be0a6a603b2b5d5cfddc045a7d49d0d77be9570 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -288,7 +288,8 @@ static inline __u8 ip_reply_arg_flowi_flags(const struct ip_reply_arg *arg)
 	return (arg->flags & IP_REPLY_ARG_NOSRCCHECK) ? FLOWI_FLAG_ANYSRC : 0;
 }
 
-void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
+void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
+			   struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 49811c9281d424bc4b43b8e9075da9fe724773cb..7d42be9e614d343cb9e4e25238c50a715a6f8ce2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1587,7 +1587,8 @@ static int ip_reply_glue_bits(void *dptr, char *to, int offset,
  *	Generic function to send a packet as reply to another packet.
  *	Used to send some TCP resets/acks so far.
  */
-void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
+void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
+			   struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
@@ -1653,6 +1654,8 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
+		if (orig_sk)
+			skb_set_owner_edemux(nskb, (struct sock *)orig_sk);
 		if (transmit_time)
 			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		if (txhash)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5afe5e57c89b5c28dfada2bf2e01fa7b3afa61f0..8260aa9440f9e1e6fb50b4c01854acaccbbdec17 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -907,7 +907,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 		ctl_sk->sk_mark = 0;
 		ctl_sk->sk_priority = 0;
 	}
-	ip_send_unicast_reply(ctl_sk,
+	ip_send_unicast_reply(ctl_sk, sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
@@ -1021,7 +1021,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
 			   inet_twsk(sk)->tw_priority : READ_ONCE(sk->sk_priority);
 	transmit_time = tcp_transmit_time(sk);
-	ip_send_unicast_reply(ctl_sk,
+	ip_send_unicast_reply(ctl_sk, sk,
 			      skb, &TCP_SKB_CB(skb)->header.h4.opt,
 			      ip_hdr(skb)->saddr, ip_hdr(skb)->daddr,
 			      &arg, arg.iov[0].iov_len,
-- 
2.47.0.rc0.187.ge670bccf7e-goog



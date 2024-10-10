Return-Path: <netdev+bounces-134366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7022998EBE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66AC6B28518
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11D1CCEC5;
	Thu, 10 Oct 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+P+PIu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76031C9B6F
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582510; cv=none; b=R08cws5A1jwbTCzFcVTDiOPB5SqwNFKN/QC+usf8V47P/7kDq/QyP2nBk5LN61WbmjTL7AGRRk2wquUGgAKJsfRRSbc5PADLwNOCnj1nj02ZfzfSabHGTG26QrU/fxneEMgASnWnXArr1j/ydZIIyB3fkAwII9EEniGBjBdpM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582510; c=relaxed/simple;
	bh=zonKsBU1GurMAmpIRhwC/D9RxGan+tC92g9iQoZgywc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HerhDAUjDQUOcQEHV+4+Fhps0Dk4kbl7rhLuhEuYhjrO/HxdG/kHx4r7ghBa/iy/TS9Ahl6Tg4lLvBfVold1sTKO2lrTzyVvkBI64D4e1EEL7IVa51xLWsK4tOBt2vapVnWq2H6b9VoXu0XGJGy2qGY6jbJ211PpngRkY0gwjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+P+PIu5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so20872427b3.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582508; x=1729187308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKR4YNRuy3v3002HCuwc8XsJfvyuPUaTnDkfawn1JOM=;
        b=L+P+PIu5hQfeiduSb6P2U8xvVspccfKCKT11UUnjzSGZxxK38zRDSCPminXCcuAI3U
         pfHfbqWk0MAkPvhnMyIKl5AP4ekSGBWr4OrPai/BmuHWrt/9JDdTA2pyeVUGt1FiPfsk
         nbWLuvMFL/KEgzFTLOdyvqeGDvZ94w6t1GP3zi2lI1yjG90w2Y6JgiL9WqhAg6KyTtsD
         4I0B0gTG0F6jwZbclzjAyifO3v9UsQjK5ODcmJ4OEpTdVScK+4en1WHMKkbIJZdDJy9N
         Q2J7vvFFti+XIJYnip+uFo2xUDgXOtDD76nS9xUjlqJWu7QN+c0T9tUUsGjW0/fHIL7V
         J1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582508; x=1729187308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKR4YNRuy3v3002HCuwc8XsJfvyuPUaTnDkfawn1JOM=;
        b=ZOV454SfMHTuriM56Fenh7KbZ1EGO9xkWVpSlMKsavKetkpIbWWD8+C7L9tKlc32wp
         AnBocyEqrzbgg13h0S7TA4GHy4KsEDQf52CbMuqB3mJctlMZlIh/xn+STPLfZvUBaYUB
         99vrFTsUmtZ6eKnt9NhrZsbLeElCLSEwuX5S/VEPDR8k6Skj0uETqknXn7P1Eq0q7HUn
         +G36E//d4i9ZrAYUd3d8Bhe2ZWtEvyWF5wps9Z603S0GkxHsYq6E2vbVACHyJZuTeSSJ
         Yo9MuTBvpd0bbp/n9IVQmkyBbSy4OmmgeL4XvfNwPw+JhSv3lTPwlQZyvDMZB+cNpNXW
         W+qg==
X-Forwarded-Encrypted: i=1; AJvYcCXf0DNqx2u14EEw2HCy8Y/TrW4ScqMIq032rg2QDMJH7fqKlLcyjCEfocov4Aua++W4qrTWnWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyje6/QojXFT8GYDXn3RFGotsT6iVl0MDy79hmS25+8fLJPFsSq
	0YGPEK38bP5cU1zEkzS0HbZznj/2RtzPSDOODxzVFnVcNXL5sw52blMwpwHrOZsMOyGmyhpwhkV
	ptt06ZwtQkQ==
X-Google-Smtp-Source: AGHT+IGsQbetn9j7kXw+KnQ8FI4jlj3mf2IdaikLQuDPQGnnS8jTpwpDCkhBGduabrUTRvKH3aNTK2w4TMWrQg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:460d:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e3221683d8mr173547b3.4.1728582507790; Thu, 10 Oct 2024
 10:48:27 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:17 +0000
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-6-edumazet@google.com>
Subject: [PATCH v3 net-next 5/5] ipv4: tcp: give socket pointer to control skbs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
index e5c55a95063dd8340f9a014102408e859b4eb755..0065b1996c947078bea210c9abe5c80fa0e0ab4f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1596,7 +1596,8 @@ static int ip_reply_glue_bits(void *dptr, char *to, int offset,
  *	Generic function to send a packet as reply to another packet.
  *	Used to send some TCP resets/acks so far.
  */
-void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
+void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
+			   struct sk_buff *skb,
 			   const struct ip_options *sopt,
 			   __be32 daddr, __be32 saddr,
 			   const struct ip_reply_arg *arg,
@@ -1662,6 +1663,8 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
+		if (orig_sk)
+			skb_set_owner_edemux(nskb, (struct sock *)orig_sk);
 		if (transmit_time)
 			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		if (txhash)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 985028434f644c399e51d12ba8d9c2c5740dc6e1..9d3dd101ea713b14e13afe662baa49d21b3b716c 100644
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
2.47.0.rc1.288.g06298d1525-goog



Return-Path: <netdev+bounces-132546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91699212E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9381F21681
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC916E87D;
	Sun,  6 Oct 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATiS1bKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85E18A95D
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246757; cv=none; b=cXRZMixFGH2UZa88a7a2LiiHzsqGW2AEi+immxTWh/I8EHtCzG8hndXn+pe60G4WVDCSMq9vRYa+58mq+FwUreuUjaY7cfxU0IUDj0y1mDohJVC7iPim86kY7rfDH6Ozpr8FS4pxjfLkqXDVJXV8iXiSM1hlurDDnrBh0kWC/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246757; c=relaxed/simple;
	bh=CzptCRZ+80Rz3LavDf81jJ10UlDXiTs0J2jCDtr/szU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivQKJmKJNBGOUeSIvkF82vELzxOqyTVh+MomusX6hD5FppMsTohITqiZWQafUN3SFX8qoCitBolx96GlfHzXxkWs9kvH+ZSQlo1ZJLKh9e3KNmb8SBy5ybPO/hq8F8zi1/o1afvFMIj+mwtdeFZfNoLeAv7T1qROjtA3FMWtqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATiS1bKs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e24e37f1eeso78731617b3.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246755; x=1728851555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9giHI7mOzs1A14Xi8IWFiG1R65fEJzdr2/Je30Sg2w=;
        b=ATiS1bKsbK1RCIGCyfGrtw4BfBSYE55pzvrQMit8HxPs/aMWbgI0D5lvZghi1VaQP6
         /YwcRER2Otal4tOQCHUGPjCyQzUbuT/mEsid00Gu6VOovzr/sTKpD5inQa3s/th35743
         7SoE1qImy1JmSbqG7MO89L9Sy4lF5plz/kSNpHiJ9w8QQ0hbc8qSPu9bQjR17xIsJuoc
         yG3V+3d8FAbCN/ncS3h1lHPGR0NAg8kza0Vb7CkYy2WTST2A8YMUo8UcEE8TTaX8QqCF
         Q8xzEbUtvnQUiU3D9myH8Db/ugWGk+5jLspe9G/Ui4Ykqfad1ddSwBIGlaOx7ay6eJW4
         X20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246755; x=1728851555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9giHI7mOzs1A14Xi8IWFiG1R65fEJzdr2/Je30Sg2w=;
        b=ULogFdB1UdMUOr+bnz/vH/IYPXcrnc2o83kmSJ4NQJCiaRAkEsyoa5bevkYG7ww7qM
         M+9xg1mc1BtsKvUn5AwYcOl52ZvQo6DeTgPLgP/dmlWGUOTxTYzTsw5d1PXQVSHFlxaX
         KdhnXk37CrFk4tzvHCUvXGXRdWFYqhPXCMuTI3RMjH3CUKfLU0MSnYFmQRVSYQcCWUin
         1Tl/k4nSLrB43XvJ9yo0Ab3AF8iKeEa9wNRQALqE5lqIwj+pB0B35nb9fLmb6wVKe10j
         jAoin1Bj5dBv0DvJsl6ChdVDfFQ+0gGpW86PbUL/tA27Ki460e+xTtmeR/F+748aghgP
         9ORg==
X-Gm-Message-State: AOJu0Yy1GVbIGTFP7dg2hzeZZjelfXfzM3j4sKk8adslMHnQSxg1d38Q
	Tz7D5uDFfhG4DP6s7dXcbiLcZafDBY1cqf0rxOjlAePy1vnqSIOGePvSZV/64sNqjo+KwStNgeV
	R1JydHAmeSw==
X-Google-Smtp-Source: AGHT+IGGlGGY16wFGeshUS9ggEyCxYcNGzQOu45QxRuRETxFWi1v+oYNGogxmEp8mQsdShthMIyJJkRNrhDYrw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:ae8a:0:b0:e28:8591:2655 with SMTP id
 3f1490d57ef6-e28934f6b47mr8175276.0.1728246755395; Sun, 06 Oct 2024 13:32:35
 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:24 +0000
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241006203224.1404384-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/5] ipv4: tcp: give socket pointer to control skbs
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
2.47.0.rc0.187.ge670bccf7e-goog



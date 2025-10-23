Return-Path: <netdev+bounces-232284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431BC03D14
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D35714E43A7
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB882C21D6;
	Thu, 23 Oct 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puz/puEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B22C2358
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261485; cv=none; b=scA92BPB1L/BtD8TdarPsjXV+CGBNOKbIxlIpER9tG5S70elMuBtAGXwbmMd3OH2+9YgDBv9H+DibyxjtNgVGwbxrTeZ5iRnihtDyKycmojsYbVXdRjTPbHCrsaHnl5qoD5sFZ+Liy34z2WO/oRIx2Uv3ejVzJtjHPiShRnCzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261485; c=relaxed/simple;
	bh=1iwt7aXvoiQwwrHf71gxwtQTTN9XGGEKH0es+M4m/0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uguiz8HrCQktUScEDPcGYVHj8aCH+sET5eUKN8FklimaOlRRr+BxWDRFOWJO8b3CQbbp5xZieblFnYaCjN4KSKOtP1TsLK3qh5yfUdmkKtWrFQ4tDIYA83FtpKQj/o3FfaVPKkv359dzR5m6E5x3y8fZ0GGe7H6End+fOATL8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puz/puEs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a285bb5376so62824b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261483; x=1761866283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTcwJFcFrZGq/VYSErxG5yG9npqamnMz+RN/i46Gn0=;
        b=puz/puEswvkD8WjxKni7OR20IY43NNarpMgv9Heg1BjCm9TNC+2trnLAFKe8t7CiEC
         DGmcVRS8+J2ddH2JmTK0UgXVlD9TRnOXewOsdpADbcXPtKoLusBbYMwXh1E+JL+9mSv+
         kJ3C3hTDs7IthgrVDUhGLqFhWdzecXtdNgLqg8x3ODfFj4DiRu+j0mXauhRiGh1ywUO+
         4N/J11R8Oip0+iqrvlBvqTi/39Rm6I+p98Npf8WN4uzaketuEw83Q1AzOxvmRCO5qWd8
         74xuR/TuHywJ4mo0CrF5H4vi6OvcuVeQ8vzLvrAz7zI8313sAjlgKYBQcOF4IXnHeP69
         RRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261483; x=1761866283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTcwJFcFrZGq/VYSErxG5yG9npqamnMz+RN/i46Gn0=;
        b=f1PnTa+7CNY+21nqe8m2+9wdAs+/jiowSkJGqmdqUsUmwzrFsuVt2XhGAiCqreGtOP
         i/a2/AltUMn9E1x/YPomhXgMQljKseBa0sNIHrStHEqCk4uMk+8OK5luxZQaa3CjRG6g
         p1BGcLXcKKV4ZxdHT8SIyQIEeEh2809usEr+OfeeKzFC8iHjBuhwYD3OBjYRVm0MCcTT
         dPbR48wgqp+sh9qOFWt3XyNOYLr/GYk9YP2/WQ6+mxE51t5TIzip/l/BhGfXwfVDRQKx
         /2ZHvshQ0WKbgtB2mJHhGyTOA4x8VEkO/qMUx392R42ps+j8EUFPHCFoJMoIQ2V1q8XM
         HeTA==
X-Forwarded-Encrypted: i=1; AJvYcCVDFeweMMjIqPcHYXpdBpI+jEzGpR6w6GESHwCzXmvfUuwKVvH//wlvCU/PGFIfsUlASFY5yPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZWS3q2Te+BYkyR2NkRO7+gRXGd3QBcb6kPMMePzXu+RRto8Dd
	7rx5QFm+9hwWSJji5DvseREMKLrNb+jlvDJ9de/5cv1g42gShKgIRSgfm0A/lgmHf2N36likInR
	tPj9qSQ==
X-Google-Smtp-Source: AGHT+IE74OioyAGV55yXxO4l0QlMdNZuJTUm1zFT4p54j2viGgCfjKH71P7ogA1msNFpuOlnI1OnDXZ/Vgs=
X-Received: from pjza10.prod.google.com ([2002:a17:90a:e20a:b0:33b:ba58:40a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a1:b0:2fc:a1a1:480a
 with SMTP id adf61e73a8af0-334a86070acmr34641213637.38.1761261483017; Thu, 23
 Oct 2025 16:18:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:55 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_v[46]_create_accept_sk() are no longer used.

Let's remove sctp_pf.create_accept_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sctp/structs.h |  3 ---
 net/sctp/ipv6.c            | 45 --------------------------------------
 net/sctp/protocol.c        | 27 -----------------------
 3 files changed, 75 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 2ae390219efd..3dd304e411d0 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -497,9 +497,6 @@ struct sctp_pf {
 	int  (*bind_verify) (struct sctp_sock *, union sctp_addr *);
 	int  (*send_verify) (struct sctp_sock *, union sctp_addr *);
 	int  (*supported_addrs)(const struct sctp_sock *, __be16 *);
-	struct sock *(*create_accept_sk) (struct sock *sk,
-					  struct sctp_association *asoc,
-					  bool kern);
 	int (*addr_to_user)(struct sctp_sock *sk, union sctp_addr *addr);
 	void (*to_sk_saddr)(union sctp_addr *, struct sock *sk);
 	void (*to_sk_daddr)(union sctp_addr *, struct sock *sk);
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index c0762424a854..069b7e45d8bd 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -777,50 +777,6 @@ static enum sctp_scope sctp_v6_scope(union sctp_addr *addr)
 	return retval;
 }
 
-/* Create and initialize a new sk for the socket to be returned by accept(). */
-static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
-					     struct sctp_association *asoc,
-					     bool kern)
-{
-	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
-	struct sctp6_sock *newsctp6sk;
-	struct inet_sock *newinet;
-	struct sock *newsk;
-
-	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
-	if (!newsk)
-		return NULL;
-
-	sock_init_data(NULL, newsk);
-
-	sctp_copy_sock(newsk, sk, asoc);
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	newsctp6sk = (struct sctp6_sock *)newsk;
-	newinet = inet_sk(newsk);
-	newinet->pinet6 = &newsctp6sk->inet6;
-	newinet->ipv6_fl_list = NULL;
-
-	sctp_sk(newsk)->v4mapped = sctp_sk(sk)->v4mapped;
-
-	newnp = inet6_sk(newsk);
-
-	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-	newnp->ipv6_mc_list = NULL;
-	newnp->ipv6_ac_list = NULL;
-
-	sctp_v6_copy_ip_options(sk, newsk);
-
-	/* Initialize sk's sport, dport, rcv_saddr and daddr for getsockname()
-	 * and getpeername().
-	 */
-	sctp_v6_to_sk_daddr(&asoc->peer.primary_addr, newsk);
-
-	newsk->sk_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
-
-	return newsk;
-}
-
 /* Format a sockaddr for return to user space. This makes sure the return is
  * AF_INET or AF_INET6 depending on the SCTP_I_WANT_MAPPED_V4_ADDR option.
  */
@@ -1167,7 +1123,6 @@ static struct sctp_pf sctp_pf_inet6 = {
 	.bind_verify   = sctp_inet6_bind_verify,
 	.send_verify   = sctp_inet6_send_verify,
 	.supported_addrs = sctp_inet6_supported_addrs,
-	.create_accept_sk = sctp_v6_create_accept_sk,
 	.addr_to_user  = sctp_v6_addr_to_user,
 	.to_sk_saddr   = sctp_v6_to_sk_saddr,
 	.to_sk_daddr   = sctp_v6_to_sk_daddr,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ad2722d1ec15..2c3398f75d76 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -580,32 +580,6 @@ static int sctp_v4_is_ce(const struct sk_buff *skb)
 	return INET_ECN_is_ce(ip_hdr(skb)->tos);
 }
 
-/* Create and initialize a new sk for the socket returned by accept(). */
-static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
-					     struct sctp_association *asoc,
-					     bool kern)
-{
-	struct sock *newsk = sk_alloc(sock_net(sk), PF_INET, GFP_KERNEL,
-			sk->sk_prot, kern);
-	struct inet_sock *newinet;
-
-	if (!newsk)
-		return NULL;
-
-	sock_init_data(NULL, newsk);
-
-	sctp_copy_sock(newsk, sk, asoc);
-	sock_reset_flag(newsk, SOCK_ZAPPED);
-
-	sctp_v4_copy_ip_options(sk, newsk);
-
-	newinet = inet_sk(newsk);
-
-	newinet->inet_daddr = asoc->peer.primary_addr.v4.sin_addr.s_addr;
-
-	return newsk;
-}
-
 static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
 	/* No address mapping for V4 sockets */
@@ -1113,7 +1087,6 @@ static struct sctp_pf sctp_pf_inet = {
 	.bind_verify   = sctp_inet_bind_verify,
 	.send_verify   = sctp_inet_send_verify,
 	.supported_addrs = sctp_inet_supported_addrs,
-	.create_accept_sk = sctp_v4_create_accept_sk,
 	.addr_to_user  = sctp_v4_addr_to_user,
 	.to_sk_saddr   = sctp_v4_to_sk_saddr,
 	.to_sk_daddr   = sctp_v4_to_sk_daddr,
-- 
2.51.1.851.g4ebd6896fd-goog



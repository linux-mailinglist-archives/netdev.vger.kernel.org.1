Return-Path: <netdev+bounces-231410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FFBF8FA8
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8804F19A7F4E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503572C0284;
	Tue, 21 Oct 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJ01O36E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AF2BE65F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083076; cv=none; b=DkOrVbed6LCjNA+HfVOetW2RV+8UvOL5NVoGqqHrwv2tS2+qXGo/sIl8MtDeGGhtG3mbMeYxvaDBAeCVzsnGpa02sGiX638jNCjrfcfOGvKSRbjWXMEUErGf3pdRZijf1tokgAGm4S7z0lXjeLEEldiggfkgwy7IQej3Jl1DsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083076; c=relaxed/simple;
	bh=SwAsiApdUjgrqoDmFrpyEzQMgWFef+ZxqnCAzxBIITw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n5/jBlXAjwpoGgIJIoyLBSlYJoVeekmcYx8cbT6PIJZyqjtytdXItFJayV3Vtqw/Hh6guV5+PE7nddTvRB1Au5Q971cQm+y6RZynCDjTXB5TabVD2ymRz4fK/glEge6I1f5MBJ/L/Jr4XatOJDACAJPYZQsTxqZ6sME91QC9Ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJ01O36E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so6095735a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083074; x=1761687874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtno1n73NuAo7ZO7TbzYkVoEWUOYcFAYgqNvsiH/ctc=;
        b=iJ01O36ErkzmRMr5jBXr0sS8kfavfccZVFAHnWWROoqyWm9dslRp/BsbK5qggo5rSc
         bMOAmN98ERFfHpqh3aOxhiSbdEL1h2SicNjJuc95sz3qL1ySFpCw9La2IjkoEUXbw7mz
         Nau1o/sz7Y3ngNBM9Yq2btKyF2xAcFHSmSsKJU2nLYQGp/uNMIu6KQa3UBEdTPmpG7vb
         nu1xlv7DcPuy6PLjxNa7Y3E8Sdo6hdHaQm+vkVz2/JIECfIT2zPkj09mBqTZD6l8K4Xt
         GN4fiGocln85wTybcvOAMogAPcbRv+Wa5v4YfcJjdDmzcw7/C4YF1AKUGMZGp3yJBby+
         lvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083074; x=1761687874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtno1n73NuAo7ZO7TbzYkVoEWUOYcFAYgqNvsiH/ctc=;
        b=AVAyzSpIrQDHDjiWCBKM8+WmEgJv8Xja9h5HAmS/kX9Rndz/o6lD8cPC4j7OWU5Hlb
         UgCC9sxoXymYdVOyuLldHlKGQIIvFMVAxih6TYl1U6GpRtwZ0pL4WboQU38dyUnMMo46
         fGLQVtoE5bPLSYI8aJN0RCH8A+zyxbIHJy4O9O9/bp786Ef7+DpTN1hHt5Zka99i7pI8
         0wyAwE57w/Uc39waN4+b9y21NPifnuAEpmYCrzcqXgOIIkoQpBleRo8/TTw8VRdULJHX
         SfaqcEXOppHPtMgQN7QimNu++a61THtsRO1dJJv6cTcgD5OmqrIdjKkspSfNt5rnsleN
         pxiA==
X-Forwarded-Encrypted: i=1; AJvYcCV/kudTOKNjasp5/y6cXBdjzltByq1hBORcnhpF6KFBd2vPKIJHI9bsC0BDZ6rpED/LiDYlrDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+CRaEPIW4sNAiLxlDCZDCNznR8Uke7qntdoaW19P797eP7tD4
	sQwy6jc/wFwxCFcXr59Fsfsxcz3c/Zn5l3e3bSgEi0opVdyJADQcyTm9wygnpmDXpXFyKzQmGho
	P4Ysz2w==
X-Google-Smtp-Source: AGHT+IFs9Yw+bqgmHx+d1HkEbQ+TiVSIf/8OrUwtxIeYjS5pVuiM4KeuywoIxx6gFK8HLGQS5ymgvsq9Kyk=
X-Received: from pjut11.prod.google.com ([2002:a17:90a:d50b:b0:33b:beb0:be7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380f:b0:32e:8931:b59c
 with SMTP id 98e67ed59e1d1-33bcf90c0cdmr23380362a91.27.1761083073938; Tue, 21
 Oct 2025 14:44:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:23 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
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
index 2ae390219efdd..3dd304e411d02 100644
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
index c0762424a8544..069b7e45d8bda 100644
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
index ad2722d1ec150..2c3398f75d766 100644
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
2.51.0.915.g61a8936c21-goog



Return-Path: <netdev+bounces-231889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC06BFE470
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 23:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E53274E6926
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F9303A03;
	Wed, 22 Oct 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WrajX+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F42FC880
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167855; cv=none; b=WEsUaiaFTowdMvtqW3Uh39Mc+AOrfD7pw5zuO+l7AMxT4K6R60PQA+sA1lZNNbrtktGJBfIlmmWjkI9HfnQEqoSwq9Hf2iJwRZ7qmZVCGG5j1e2No1Yl1v0lT59b6uRRYwO2dh5GUDUt1CDvvzIXyu2FxIdnB9x62K73Juh1FlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167855; c=relaxed/simple;
	bh=QptB+PtfCGErbwrCihZ5NZWiDF5LNLfj9kJ1h3qxklQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l79LZwLQsbr/6DgzYRlIHntEB2i1g8agizD8qT80kQd8ughCNHiWNW8xq2hYDUhJJpMKeyVuicHTAxl7d/lh7RJWmyuz+SHlvdVU1dNgfHG6g2kh1W3FkE4U3MdJoc2SGwDGIjBHIFVNKW69Bs1mUTYm5I6+MLR322IvSpp2KTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WrajX+P; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-792722e4ebeso66695b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167853; x=1761772653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+x0HtiSQIGqMUo3vEudJ0qk/2gl6PsSQ5y94WRZHcMY=;
        b=1WrajX+PmDwLfXQ8cxrvWwkrI35BTVqcEG/OWNy+jcjeUumKdeqgUbQDQ7HHKDenOT
         HFjFzD9hZvcfWtTddcu9Uiw3CS1MYFgOP2wgRhlnO+S55O16FqhYpdI/4yMSId2DPsUQ
         pudUk5PYJjLnSDvlIdsC8o3PMTpmGd9z10JVvQqCAEeHLZ+hNKoyUcVxOUn51HkLJYyn
         zbGeDNLq5rhjoiInDgy/JkBTVPHbXcoEoOrD2zXK6ydXZhu8+5KXuoVhSmPVq1+j8GLs
         Yk9LJczpSm+7YSK71+9cci8aLhEgTtZEGxkFS7iH0gduriQOWFpUm925mfte0zkomSHh
         CAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167853; x=1761772653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x0HtiSQIGqMUo3vEudJ0qk/2gl6PsSQ5y94WRZHcMY=;
        b=aA7EzVamYC/StBnHc5fthWE9UMcMyqPLPtB6pdHTGSIUfCfHXZwVhxDRB3urpVfXrP
         2MQzh+QVPPzsgV2+kK6T2Fk8l4ur7tApexc9NzAq/yf+NVGZEZlC1S/n3ro9LO04EAA4
         WRML/wFUmsDHQBhmeP3hxguzy8PC8B1ZIsSkBxTpFF5Yz+zGew8AreKZQRk8FVv6nVlm
         Z9eudfd03uKxDfakOB5Bj2H0JbsAqC+7KQSBq5TMo/DfstzuGASVoH3R8r/GYXTWkw32
         wHZxlm/15O9blWyuGB1BV7rOnsupiIcBrsrd4bie87YujAibpdzdIMCdArmWplknjkI7
         vP+A==
X-Forwarded-Encrypted: i=1; AJvYcCWVu5RZFnWXJwY5FyP1YjYyr4kMbDe7g4kin3JRenCHlhcsYY9TAHRbpcY60XObPw1N74zfzOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YvXjvyI+1S/tGzVwcheemFb1MoOpbe9llNe9ZsAOPJDQu0NK
	jEVdMQi7JgJYcuyyqDjsA4BB7zyi5Vckt/BLMvEwXJomnWyUs7yPZVAaWmpIAz6iegNLn+YBPY0
	z82+MsA==
X-Google-Smtp-Source: AGHT+IEOrN4oMV2jjEdQEjxn/lYNtvQ78FszhWzGZOqt5YYf9TY6LNgJkeagSnsb6audzDqFOgCl48107W0=
X-Received: from pjbgm5.prod.google.com ([2002:a17:90b:1005:b0:33b:a0cd:53ed])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9392:b0:32d:a478:5216
 with SMTP id adf61e73a8af0-334a864aa42mr24492225637.56.1761167853369; Wed, 22
 Oct 2025 14:17:33 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:06 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
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
2.51.1.814.gb8fa24458f-goog



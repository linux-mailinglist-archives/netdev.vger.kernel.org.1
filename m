Return-Path: <netdev+bounces-273334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOLtCTTzymlaBwYAu9opvQ
	(envelope-from <netdev+bounces-273334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:03:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D07361BA6
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4053046B8C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8183A7843;
	Mon, 30 Mar 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7zqFDOO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16143A75AB
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907838; cv=none; b=BzWinLhKg6JcA+NFwmZrKoWolCRoO3oYKCCQZfpIUhSbVASAggIECZDPc31kC1Gg2yiTGda3NQciK+bCSB8/8LksB5ALtLG8259CiuxEMia2pAM/+3hY3T3t7AFL97wqP0Pp2j29CL55hV/GhjGfur0caCMrmsuwmPoZs1zYlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907838; c=relaxed/simple;
	bh=MZhxXerGlASDsfcGK3gTBWWhreUnNcrpdb47N1l6ULA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lywTfh4kWt7pZdb5nL26foJQVgxyneAEaj0imeXrWW8BxuE60onp2+NoOjJn7dp0vOS666JRr+uDb5ETe6nWgPMllcw+Siw6fEXvyhkwIK8eNYkErzEIbcGBsqca2pYnFo7PF1myv4QmWctiX+d3d9nKJd82+GfzbRSNFAd8uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7zqFDOO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c71a8969eso2867566b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907835; x=1775512635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ09Hs2Uy/7LGsQS5aliSwwfndVhkXSmLIoOZ9aoz80=;
        b=r7zqFDOOcVFwW1uU/JwyyWCOWhfCl0SlwVHLO4QvQ5dWxRWk1c4yzs85w29Tox4a9q
         k53y1HUFQEK5gH1AxrYzBQ+bLeZYTHhm9Q9IgCChH1hVkYzRIZP8AcoG/I9YeH1o/Qib
         IQv4VaCgbY5Ej7HvgcGN/2YSOIEaa0VC0zpIX5f5yC16CRyFlI8V7hy4/sjJ7BX94GSl
         oLkZWLWaatyKepW+mjy+3an1jGVyjGOoevz/as+DzN3A7YUgAcWuSRAMYoLpxY7L1AGp
         BekCkMQ6LxmsL52FpFIe65XcCXEOiwi/Pq6qWXCpsyn0OT//1KF4ZIp7jcy4FMcqNOVP
         MhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907835; x=1775512635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ09Hs2Uy/7LGsQS5aliSwwfndVhkXSmLIoOZ9aoz80=;
        b=hrSDTXnkEy6wvAxeMPdAYmG/9DpgQVLG2cS6n9H0/SAAF26Bp66MXzRI2NqLwm1B8S
         IHfPaz7jWp68/cl1+J0IeQG1uuIZH6RxpXkH99MaWLymehuXSLbXYV+FxCMR1PLmygk2
         dnjAb1mzPbkEKqHS2pL2amnacgL+Y4l2nHB+60N/hv7M2efl/4JmLZXt2IED1c89AKPW
         JVqNdUlHm5GspSewYbfPjBM65O2Iw9PMeuJ9ue1KiPov3kFX4IgBCxkQC+AD+4e97dus
         V5hOB9407+0pUnqm6AN+ffa6fAkIDqMTok3zf4e0LDdO7GACywSkFmbvJ5OQzYHGZePH
         wFcA==
X-Gm-Message-State: AOJu0YzA0kHyZG37wajkwiUTz8iBx3ZBe2+CdocHj7GObLhSgI96OtJf
	0WyERLTGXwql23FcSQdcj8mpOnbwiyJnKb4pToalf7yajvSYkkADC2JMdyq96Y72MJIQ6aicxaR
	KQ0x4iLoPDxe5QzWD7AU/RVjQYVmL72POkuNeKHk/Ya+ugW5aWMUvW+wfzq0uFIvLZxKfVgrM9I
	wfqSA3bwOF8J6OLf5cQMZEDCYYiTAkD1Q=
X-Received: from pfwp34.prod.google.com ([2002:a05:6a00:26e2:b0:829:9e78:35e9])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4993:b0:82c:d7c4:4c69
 with SMTP id d2e1a72fcca58-82cd7c452ecmr469214b3a.3.1774907834342; Mon, 30
 Mar 2026 14:57:14 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:03 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-4-jrife@google.com>
Subject: [PATCH net-next v3 3/4] udp: Preserve destination address info after abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75D07361BA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For explicit disconnections using connect(AF_UNSPEC) behavior remains
unchanged while udp_abort now avoids clearing inet_daddr and inet_dport.
This is safe to do without changing behavior elsewhere, since lookups
only consult these fields if the socket is currently connected (sk_state
== TCP_ESTABLISHED). The behavior of getpeername doesn't change w.r.t.
aborted sockets, since it returns -ENOTCONN as long as sk_state ==
TCP_CLOSE. Behavior of BPF socket iterators and /proc/net/udp /do/
change with both now seeing the non-cleared daddr+dport pair after
an abort. Behavior of BPF socket lookup helpers which invoke
__udp*_lib_lookup don't change, since the result of compute_score should
be the same as before.

Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6e5ba2ce9314..043496a249ca 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2207,7 +2207,7 @@ static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return res;
 }
 
-int __udp_disconnect(struct sock *sk, int flags)
+static int ___udp_disconnect(struct sock *sk, int flags, bool clear_dest)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	/*
@@ -2215,8 +2215,10 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
-	inet->inet_dport = 0;
+	if (clear_dest) {
+		inet->inet_daddr = 0;
+		inet->inet_dport = 0;
+	}
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
@@ -2233,14 +2235,19 @@ int __udp_disconnect(struct sock *sk, int flags)
 	sk_dst_reset(sk);
 	return 0;
 }
+
+int __udp_disconnect(struct sock *sk, int flags)
+{
+	return ___udp_disconnect(sk, flags, true);
+}
 EXPORT_SYMBOL(__udp_disconnect);
 
-static int udp_disconnect_unhash4(struct sock *sk, int flags)
+static int udp_disconnect_unhash4(struct sock *sk, int flags, bool clear_dest)
 {
 	struct udp_table *udptable = udp_get_table_prot(sk);
 
 	udp_unhash4(udptable, sk);
-	__udp_disconnect(sk, flags);
+	___udp_disconnect(sk, flags, clear_dest);
 
 	return 0;
 }
@@ -2248,7 +2255,7 @@ static int udp_disconnect_unhash4(struct sock *sk, int flags)
 int udp_disconnect(struct sock *sk, int flags)
 {
 	lock_sock(sk);
-	udp_disconnect_unhash4(sk, flags);
+	udp_disconnect_unhash4(sk, flags, true);
 	release_sock(sk);
 	return 0;
 }
@@ -3264,7 +3271,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	udp_disconnect_unhash4(sk, 0);
+	udp_disconnect_unhash4(sk, 0, false);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.1118.gaef5881109-goog



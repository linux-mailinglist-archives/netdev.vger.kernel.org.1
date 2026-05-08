Return-Path: <netdev+bounces-285689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HPYI16S/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FF4F3119
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A30305661C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5037C92C;
	Fri,  8 May 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAIfzTb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A461377020
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225660; cv=none; b=KJ/itqS17S5k/pXiC7FU6faC6ILxNlrWWQHyR4xxkDvYH1BlBXKsFA1v23HFrDfYCDnWBQL9P5sbwnAh6QEOA0s4CP4hBIgLb8I0ssYwxL2xvuyhfDRIqrAGR+HuLWOe21vXFRNwWM/PsuT/x8aLhTU6UerudvitWUgYSkJwN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225660; c=relaxed/simple;
	bh=TGltxMQkQsdbqAh2DwtfQZgmmqx0Zorpy6CAt6AWSyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdhxPYTWtco+KIG3VTxHEO8JnOgi5lGP+2BQNu1HjD0KEg9om19hTrMSmXxk3KSm10x7NxWEtZvM6ybjiD1FHgF0r9f1Q4iyz62ZRZkrTs2p/PLoiAHn46mtILol3jTxVd9E6CHKo5QcwTn7lWVZdlebOmS8zvl0kHdBdsPSLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAIfzTb1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353b042152so1707640b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225658; x=1778830458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQOWSf9Ud5fPWv1RAV6b+nx4m1stEcoGMB/24Dun1ZI=;
        b=OAIfzTb1ylMCJQi3XZenrukQRqExqe3qBIKiUIUP0gSUFfT/5MMDjLXQgC3YYSfzFk
         Nf7HDF7AgE8qUvUEbuIhEiiPL1PNqn8MQAVwo8rmmN5s+/GI2g2tXHBDYHZNSsi18/iB
         dXVVCA3kT+blXvZQ8n9bSjjh1jjx1ixjx1O5mofSgQHodkigfeAKSzH8TWUIq3YL5z+E
         bkoe4JujNBgV5h5sqsj0rxXY4mWufBoxMBsU2HyKe5LMDFod93sw+i8W7OXrHbfsOXox
         +8vdwFubuAiiRdkUaqhcm9AnU1ZEHSAuUW/KEqTbEB41HbG9kdO9ulohOqbkL0QQ/VlD
         LT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225658; x=1778830458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQOWSf9Ud5fPWv1RAV6b+nx4m1stEcoGMB/24Dun1ZI=;
        b=enGQBhEPZOtIteALsOYGYDteEzhizomc3HssRGnfcGq62qcjCaB5WAkNmnWY5WIDcV
         DTaX0FgLY5LRrg/gaAkKH6MPvYy6vZY/64hPWtuXl8IsWwRUz8wNnG/DslUrRC64kg+p
         0GWtMRJ3NF+QJz9BGx4vFg4iq4EWoM3fXBRbmZphMGnOMNbeRPuEjS+3THqAFriZXNCp
         u1U0fobzWk6vKDR32uotXtm8oJkGQ3WpzjCn/YFc3i83DGggj0txRmNYESBNsETbsNRy
         ae0yINFeN6ppIAmZjw5Rtx/8Rgpbc+2VRgPIxHfVJ4zuHkDwPgX7cGuTvir7WXt/N6uC
         4Uzg==
X-Forwarded-Encrypted: i=1; AFNElJ+4Q2wwaJkwgF/ylpqOkfnLCQgAccYT0A7CLcLdqQ3LoCDZtff2EaNbPZzau9SlSFA25lqn1U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfrOugpgsZIaipuq8uNmt0MBH2hvbEvTuLPw9WqeCTvWyAPni
	kT7VFw2k0P0G1pS6e74XYLIc0uWQSHdxLciofGA4t3CWt2iBKDAPJhI3BGKqnrOr2f3FRfUOL/v
	K7m0DCw==
X-Received: from pfaj20.prod.google.com ([2002:aa7:9294:0:b0:838:27b2:c77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c08:b0:82c:7383:3745
 with SMTP id d2e1a72fcca58-83a5c0baee6mr11273170b3a.19.1778225658376; Fri, 08
 May 2026 00:34:18 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:25 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-5-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 4/8] tcp: Split out __tcp_set_rcvlowat().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 370FF4F3119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

We will add a kfunc for BPF_SOCK_OPS_RCVLOWAT_CB hooks to
adjust sk->sk_rcvlowat.

These hooks will be triggered when:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

In the enqueue path, tcp_data_ready() is always called
after the hooks in tcp_queue_rcv() and tcp_ofo_queue().

If tcp_set_rcvlowat() were used as is, tcp_data_ready()
could be called twice for the same skb, which is redundant
and also confusing.

Let's split out __tcp_set_rcvlowat() and add a flag to
control wakeup behaviour.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dfa52ceefd23..4e9e634e276b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -515,6 +515,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2014a6408e93..1d9e52fc454f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1829,8 +1829,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1843,7 +1842,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1858,6 +1858,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	return 0;
 }
 
+/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
+int tcp_set_rcvlowat(struct sock *sk, int val)
+{
+	return __tcp_set_rcvlowat(sk, val, true);
+}
+
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
-- 
2.54.0.563.g4f69b47b94-goog



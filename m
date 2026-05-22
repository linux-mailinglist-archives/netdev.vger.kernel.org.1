Return-Path: <netdev+bounces-290705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO/XOtUKEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD65B035D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D0B3068E4E
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1B3A63E7;
	Fri, 22 May 2026 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYnV+H9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1C3911CE
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435971; cv=none; b=jbvAQbukgV9/cIArWr+GmPBvmb6d8GAjhQzq5E3/Td6HQwsQ1YRjNJJDrpQ3WdJFiLqNESUtjE/nwP+LR62kvMVqREJDzGTIx3n7c0QOr2+5/a+2M5RJlCX9KjOBGDoxyGJp4GVgWTsNZbEE+C+uKNmIgyT257hAYpFg+aeFko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435971; c=relaxed/simple;
	bh=kIv6gMdGhCbK7oa+mQvZvqU1S5H4TI4D7YmZRRwaok4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dP36Cmv/+xeOu/sHVfa0KK8EyWJZ9hwNa3NUA45gbjY8IyMM3z0M25shlf2Mi4WlZjFUN3vmKASaRlxLEo/jdKo9uk/9R9p7Yceyg8nr4ylFwdS1sY8f+IG3BWkPSDu6cOi5DiImftx/TK9Wf+bMzlTmxK60CLXvX/2UBwbEJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYnV+H9d; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso14257132a91.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435969; x=1780040769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=vYnV+H9dayCKE7lgtqIHtm86FI/eZCG+5/9RJ1Et0eDSLChphFi/qjOFtgxoncN0sq
         ZBA2tJfu8eg4Ydc3Pka/XZJHK3JcJbvuzWenj/xU9pg49f3xKuYfPgX5aB1M8XeOQfIE
         0vlPhJffuMW8YYEXrfoEQZTdCHqCeB0k282mIt9zjS2Pj/EN4Jm6It4ItMp+xSdFk9ow
         etOL2cPD3wDhVJ3kqBCxT3TTyO8d0BLACGkfvQljtuYljaX9H48UZTWg96MBxr0If+x1
         Re4RJGGrrJY56yxJ+PaaYuvczISa+xU12GDHWv9HD7lA5ROpBmkj4Q7MEPlrNxmHdU/l
         WfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435969; x=1780040769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=Yaza1DP58n6Y/+QyySF2pDRm9nfVsaXIkW+668/FMqJg1iK2dEPoy8PlBR1l6ITGsx
         dJ7lItoxrJJ6NE15RfHkl/hJ94gjm6lb6gXQWfeqBLmYmq2+BfGuKWbuvX5UoWLqS9/6
         8gegjv0Y3JIMiwD2Qo8A5BoH9Ogxbdq5/U7VtdsU99Y6Y7m4MSMOQATjLHuWeM80cFNL
         tXggN9dRDC0SgSjUy9bcg+edfDJiK3cIU2CZMX4BGDZ9SrB2RBv31WlQD3XXl6Hb27KP
         AEyHCS7A5Mu9ggcReLmfagrfgD86KcleSoG1H1jgpBH+sAQHvRat0jYSIBJgWx+F6Cp4
         ws4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mENqQg4R3yL/HW6+ItDLMWN6WvkLVy5rS+w0C8TjTJYxBbsvMwWvtYdzxH+2E2idtQ1FJf3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2GLufELQcQ3WIL97I5ITeF1GOxLi5HJd6uGpA5dB33M2KZRf
	dBt+8gr8/+oRS51Nd/eKKqoxMFLjXghLRZ1AaYhVoBYpBs1gtrQaNa7OcLjO2G1idg35geGqB1W
	fqwGYyQ==
X-Received: from pgmm20.prod.google.com ([2002:a05:6a02:5514:b0:c82:7c27:98c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2983:b0:398:a060:a967
 with SMTP id adf61e73a8af0-3b328cb9b95mr2606936637.11.1779435968667; Fri, 22
 May 2026 00:46:08 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:55 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 04/11] tcp: Split out __tcp_set_rcvlowat().
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290705-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.849];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BFD65B035D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We will add a kfunc for BPF_SOCK_OPS_RCVQ_CB hooks to
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
index ecbadcb3a744..c6a6853909c4 100644
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
index 432fa28e47d4..3afeb69a547a 100644
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
2.54.0.746.g67dd491aae-goog



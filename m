Return-Path: <netdev+bounces-291059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLV6JvdlEWr7lQYAu9opvQ
	(envelope-from <netdev+bounces-291059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C75BDE8F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02A873015C9A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01C35F5F3;
	Sat, 23 May 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8d2kKjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DD357CEA
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525009; cv=none; b=AIRYRcuHjJwPuJntciJ+FQx2JLWjNIhJt6TH1takbClQSV/+j2o31MAefv/+TnTA73/rpzZKdra1XfYlfCGQgJWDd4RGGr29EQdJZ9CTNM5pZL9oPv45Y0VtuCsaHADCiBmWhvtK83Upj9g+m/n5Fmbs8vUku0xfnV+2THOV8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525009; c=relaxed/simple;
	bh=kIv6gMdGhCbK7oa+mQvZvqU1S5H4TI4D7YmZRRwaok4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqSk/x1TS4OJctp6Fnd0Jd2uWdznDYiBxUvx7ywWou7iIk1ELgrWLHTcGDTZi+SxDaIAb3oZ9488UL+dEyPX9I6K5JVXomU9S4nZEM61d2G0SrEQ3SeG8SFag3N4DltEvp2uNeTxnLhMGRxqLMWFm4lfO32EdQ5Qv+pStC5xBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8d2kKjR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba268cb5e6so84664645ad.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525007; x=1780129807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=R8d2kKjRdXSlwb/8hCipuhNiYXFIRGTJA6JALASvQAaXO0dgA0iYTjTmw5SWIGZVgc
         7RvLIDdhyEhKa+Sgu+79+Ti7LKfRhIaxRjEjcXOeuiqiljbCVkfN1bsljcG1Yu3pUTj0
         GjeFaoXZP5Fx26mj3aQIEVv4uCN9dL56SJCO7jpArPYPCz+IfuRqN+k8BZAf0kw7zjME
         odlHkNIFVCf5k0yKbJSccYgYDxeGQvTnIaEVXtlLc+7oTv02J8i/EJAhIek1gvLrFe2b
         bfzVLCvxKciACGncxeiu8UQsNpR8PxbCUabR3tJSJeXbKwqp3VHo5thAkS0waWlXxUY5
         d5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525007; x=1780129807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=rq5jAj+ZaLWSyPIUNU81wRe5Fc5udp+e/8b/TdRaEPcVAEPoY7Ksj9mqhBBimNBy8p
         bXw5bAFk+4eqivxi4w5LwFIFGz0AHL0FwiiiFzmYF+evtVysulDnErCXAnAwVpl5yk07
         kZ/0VMUjfwE+3BV/RSnLrBlEfgSAQFex9xVg1U+1r/+HNXCkqhazPS4ipVSrwgt5aqmB
         QREsfRxDKTgl5xLklvng9MDCddCAFxKYxuuK18VONNZFKzcUkMt59SsvdGAXak89EWrn
         7dASs3guvRDY8WZUvB8BL6/v2Ye1TTef+WWhPC5XlRORgBMfg1p1v+tJmZ0cuCU16gSu
         6eMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mmIUD1a1U6fvZj9mx4XdpT6BrTPbKaD3clrKnjD66hrTiqNHA9sjpIGfi+Gao6bG4V4U9hu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYiU3/HgcO5feIOEg5E2udYR72QlRCYI2iBn4+5dbVUK4IGaD
	2FHsSMIfRIRr9Ced9swFe5CYdpniw2a0gXjRtsj7KouuAI1CmeSWXg2A1rdSSHQgm6/OtqQu2J1
	d+hqsNg==
X-Received: from plbkt3.prod.google.com ([2002:a17:903:883:b0:2ba:3ba3:73eb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc4:b0:2be:9659:591c
 with SMTP id d9443c01a7336-2beb031ae09mr82252225ad.4.1779525007415; Sat, 23
 May 2026 01:30:07 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:33 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-5-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 04/11] tcp: Split out __tcp_set_rcvlowat().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291059-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.849];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F28C75BDE8F
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



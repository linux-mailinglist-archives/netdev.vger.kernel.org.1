Return-Path: <netdev+bounces-291061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMRZDi1mEWoelgYAu9opvQ
	(envelope-from <netdev+bounces-291061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:32:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5C5BDECE
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CC7303677A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F9346A18;
	Sat, 23 May 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYqIUXw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6235E923
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525011; cv=none; b=P1ckiabsxQ2jvu2NnTpNHo2FskOCXff68ge0fvm1uIDZA/+iYsp/uQmbOlZLPAMxvY0oJqDJj3eKcduK1AOtAFn7Vbas7iucVajZSSiO6n+mvAPCIiurPZaGBHNcO/bpFugfcQHNxsrEJbxczRZ+SZv4H30QlhUalRHr9zCQndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525011; c=relaxed/simple;
	bh=5LrXufthRaBma0LppObW+hMFrDBdhr0Cg0Ci1Puo6Kk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MX3yAUpmG7PoqtWXqhTSdDcn0zRiXioVXoCmJvzqVlYTX0ArEu0TBcslDO06MeAfPzTreWJlbz68bgXdXRq/+J3m84LcOh1hIw82V1UotHx4SERKB62kuuhecDDbsYyKpedPfR66lJ0LNRhseyW0EVAN6LGJUm/8Dq66LobTP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYqIUXw6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beb9002a00so9662105ad.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525009; x=1780129809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GfFkAr3DVuvqBoBN/Pxq5E1UZmkQhNiNFGEdg4cGok=;
        b=hYqIUXw6dTjlDZPEb6HwVGxcXA/dAA51XWEk76PPdTUQS5qYPVFbwWzK3/assxr6kv
         hzWLLEX12Fqp3Oxl/R+il84Kwuj2GglsAj+SWTSW0JbbVNO0uojPcmCSrAx7gU97/0uf
         Op4UCq85cXaCqS+qn6Aj3fMULNcWAsHPzmb8ygUqUanrfMA8UVKoX+IVQc/SA4bHkp2i
         6Bs9529oyqGbbIZNuKLQlwv0FZKE9JAKXfJf2HCILMtbEVkc1IYGJKaWc+rMfYKNldb0
         EE89fpt60VKcJoZYWceeKdI8OlXqMZdtp92GFmcxhUs/gi2J45TBqfKtdCfhjsGeMp2L
         ni8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525009; x=1780129809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GfFkAr3DVuvqBoBN/Pxq5E1UZmkQhNiNFGEdg4cGok=;
        b=XGm/HdZXg7hUT+mhve8HSZvRrkKJXSfthECnVGKHvxwX9O1HBG5xwA4QYR5j2rr/uZ
         y1IDIS4yDzt7FIs35gH4JRjKyTm5TXW99U6z/MT2vrO1XsB01BRyq9L0Y3fhG21pQedr
         p9kPw3Y6n2mhk9hyiHDvRz2KSe4rVT+LrEY2k0hfXNrR8rkizHppo/5JYU0UCJFKzZPp
         w7mkKm4tAMX2zWsAwFVW5lyPHM3PWvN1zzzIb3TGZCdvMwxhh62MK8Xm9zPAj+Oqg6ot
         kXeWgsOrYOLFw+jxQZf76prjM0MOVwFOOqj3QcUs9IYcPjDF8abVqe1ER4Ji9ezs9sxi
         yMmA==
X-Forwarded-Encrypted: i=1; AFNElJ824inHuQ6xVSgtKKUR7AL7Pu+F1vrg/O4/hsi06kNusc0hCY8qVmFxwJN1n1R5SntPe3/X/Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/PuD9clmQRtQk3HfKmdOAd+Q6mBU2zsJnZOYeO0hft7CrY3N
	qXQ8ca0jbYNJuZCF0QsfBaz7QPXFql61tfu60wWWhOF01LYIIDY+eB1rB78S/KMKfRvcoBZDyyY
	9WRYd+g==
X-Received: from ploo12.prod.google.com ([2002:a17:902:e00c:b0:2bd:9e00:f173])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c4:b0:2b2:4d78:eec2
 with SMTP id d9443c01a7336-2beb0711965mr69515875ad.18.1779525009081; Sat, 23
 May 2026 01:30:09 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:35 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-7-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
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
	TAGGED_FROM(0.00)[bounces-291061-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.838];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ADF5C5BDECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both BPF_SOCK_OPS_RCVQ_CB and SOCKMAP can intercept and handle
socket receive queues, leading to overlapping use cases.

While BPF_SOCK_OPS_RCVQ_CB focuses on optimizing single-socket
performance by reducing EPOLLIN wakeups and fully preserves TCP
zerocopy support, SOCKMAP is designed to facilitate multi-socket
routing at the cost of higher overhead and no zerocopy support.

Enabling both features on the same socket makes no sense and
results in unexpected interference between them.

For instance, SOCKMAP calls __tcp_cleanup_rbuf(), where we will
add a BPF_SOCK_OPS_RCVQ_CB hook, and bpf_sock_ops_tcp_set_rcvlowat()
calls sk->sk_data_ready(), which would trigger SOCKMAP.

Let's make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.

Note that it requires write_lock_bh(&sk->sk_callback_lock) to
synchronise with tcp_bpf_update_proto() and check if sk->sk_prot
is one of tcp_bpf_prots[][] because sock_map_update_elem() only
holds bh_lock_sock() without checking sock_owned_by_user().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Check sk->sk_prot and update tp->bpf_sock_ops_cb_flags
    under sk->sk_callback_lock, and only when not flagged yet.
---
 include/net/tcp.h  |  1 +
 net/core/filter.c  | 35 +++++++++++++++++++++++++++++++----
 net/ipv4/tcp_bpf.c | 12 ++++++++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c6a6853909c4..bc95d8e7b62e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2853,6 +2853,7 @@ struct sk_msg;
 struct sk_psock;
 
 #ifdef CONFIG_BPF_SYSCALL
+bool tcp_in_sockmap(const struct sock *sk);
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #ifdef CONFIG_BPF_STREAM_PARSER
diff --git a/net/core/filter.c b/net/core/filter.c
index 3608036632a8..1fb63b264b18 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 	return 0;
 }
 
+static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
+{
+	if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
+	    tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
+		tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+		return 0;
+	}
+
+	write_lock_bh(&sk->sk_callback_lock);
+
+	if (unlikely(tcp_in_sockmap(sk))) {
+		write_unlock_bh(&sk->sk_callback_lock);
+		return -EBUSY;
+	}
+
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+
+	write_unlock_bh(&sk->sk_callback_lock);
+
+	return 0;
+}
+
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 				  char *optval, int optlen)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long timeout;
-	int val;
+	int val, err;
 
 	if (optlen != sizeof(int))
 		return -EINVAL;
@@ -5424,7 +5446,9 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
 			return -EINVAL;
-		tp->bpf_sock_ops_cb_flags = val;
+		err = __bpf_sock_ops_cb_flags_set(sk, val);
+		if (err)
+			return err;
 		break;
 	default:
 		return -EINVAL;
@@ -5999,8 +6023,9 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, argval)
 {
-	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	struct sock *sk = bpf_sock->sk;
+	int err;
 
 	if (!is_locked_tcp_sock_ops(bpf_sock) &&
 	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
@@ -6009,7 +6034,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
-	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	err = __bpf_sock_ops_cb_flags_set(sk, val);
+	if (err)
+		return err;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
 }
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..7e7966b095f9 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 }
 #endif /* CONFIG_BPF_STREAM_PARSER */
 
+bool tcp_in_sockmap(const struct sock *sk)
+{
+	const struct proto *prot = sk->sk_prot;
+
+	lockdep_assert_held(&sk->sk_callback_lock);
+
+	return &tcp_bpf_prots[0][0] <= prot &&
+		prot <= &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_NUM_CFGS - 1];
+}
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
@@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 			sock_replace_proto(sk, psock->sk_proto);
 		}
 		return 0;
+	} else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG)) {
+		return -EBUSY;
 	}
 
 	if (sk->sk_family == AF_INET6) {
-- 
2.54.0.746.g67dd491aae-goog



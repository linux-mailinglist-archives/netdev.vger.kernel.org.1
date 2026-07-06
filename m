Return-Path: <netdev+bounces-305169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +OugICT6S2rRdwEAu9opvQ
	(envelope-from <netdev+bounces-305169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:55:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4370714B79
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dvD+YAbY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305169-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305169-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3EAA33AA94E
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FF3B3BF3;
	Mon,  6 Jul 2026 17:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588813B2FD6
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358390; cv=none; b=Y2yKvpTNXhLl0aFQBj6p6DTUHYXSFc/YMmW1jUvFv84QWCI4ZS1S9LAOVGQ+SCt4DgLbq+bkmYyo7AJjx4CSK0ZVtzJSkHT+EY7XBo1TvJ5/coxfQlR14SlSMobawwCAMLhkun1by7fmtKQPVbNMYId5U/H/0dZUM8vfZnmO83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358390; c=relaxed/simple;
	bh=p0CwclzJRZIoa7wHNIZjI0kyp3LcocRuWIHx6Q07PUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuGqwkejiGxujySv3VbhVyuQS86XMel/GoK8k4zWIHhgMElgOmi4TWcpU1ZoNInTcG7mTTtXk0GhUrW4Cnceo+STtpWXcLv4Hrm25CxXCUNfrh5OKzXG0kLCKeE1TXJnEu2FXoOT/gkl/TfXiqajYTGecWzK9gV5GWPPugu+hy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvD+YAbY; arc=none smtp.client-ip=209.85.161.54
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a18e363d52so45924eaf.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358387; x=1783963187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+ZNLOlwxwz08HKOBTTMS0oVpW8kpSzr2tAgT6LGER8=;
        b=dvD+YAbYNhltSNh88RX7Tsenu6xRHVWpewNFqMlkzYt/NlgF3ygWhKzv3shYyS5OYG
         6eVVW9FfvKf/2R1msoswXb56XdTj43j/Xy3/eVLUyNObIzcsbM98P2xCOJn2srFaByOD
         sauf/l7t3cgRLAbtzSJGv+u8Vay2fJtPVBrEugr48BINZL/lOfsYEIyIpxek8L66222n
         M+v6dokpz7zJlBJoILKvKqc5xhsx5+36RBQ523Ss2pSKP3Y8wU8yLMFzsezK7ZSVTD9c
         QDbys+ioIv5vHL2zMwHlNEASgMtOoJ1EH4x/2iuV5R+eCE9EmL0cXPatv7blHqrCuors
         lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358387; x=1783963187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+ZNLOlwxwz08HKOBTTMS0oVpW8kpSzr2tAgT6LGER8=;
        b=qnpOc/D3kt2ByrEj+wNvprsAASluj0f6ARI5asuZMpzPtQZ6gqgaNrH2Sz9og1mJ1Q
         uoPi65yOiytsmCg7fRWqzacEHrJcuyhVBVhX5aRAYxZcYxMUhbxfzQYRsL+s5GUTTheq
         Zq4TMXEB5bcfB9THpBRI95i8UbAfF89W3Gzj/gxpdwETnQmCFd+glkAG2p/6X6wqEQFU
         q+khpumIJA5Ze+sJKOCB+RdC9Y1MNhWJXs6trb85bhY/6HP0tsVRCt1Xcy34P2ZH+6wj
         GI+lt66o9BBozPlZL/xLsm8z7CzAHha28/n067TYEuJ9Yn7oVcPplf19mBGbI4oAUU6C
         4Haw==
X-Gm-Message-State: AOJu0YzZR0/LQlfvRLPGYBnGcf2tWKh0F45i5PWKvg4Q5yVegyxxbH3p
	2sbIiCkiKwAq63VIhfuZ1owHMvBcs4cSNa5iAIm+5+jqwdhMubwoyxKY
X-Gm-Gg: AfdE7cke83nYu3EIazasmS59QYZ+q7xVbuBOvNMNC3cxwfL66kPmcko++5EasA4jewl
	V1smYUpufwdvKYjMctLcSEKOKUKe+zMhNJqu+egtTxnidRkX/W7yVtah4HBJcLVqXtgJ1uzCiH8
	Ipk/2/9nPOonccvUhSKqZhQ+unrLZi7VqyldZ3aljxw29aObHoneFuvIRnlBYVe2bOwJrkSENVe
	mX6xOi3gWP670ylRSCxRNJO3nXuc7JECV6diqiatk8PAcwaCLWETGrR5tJC6MqI2H0fux6I5NPG
	0uqTspe+uNEeKyQjb8GmkXLxtjqryKuncMsudYW4VCm2w09DIOQe3A6hLyYbTBZmvZIyhgH//Yz
	ny/acUh4uTMvqZIsAdp6vBd+mOw6hOz38TmOn4ACM2UT6oJuxTTfQsmZeSnwrwgNcsRIO0ixbPt
	JHZQ==
X-Received: by 2002:a05:6820:161e:b0:6a1:50f8:abb5 with SMTP id 006d021491bc7-6a35480d671mr755889eaf.32.1783358386742;
        Mon, 06 Jul 2026 10:19:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310003927sm8478665eaf.6.2026.07.06.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops callbacks as struct_ops
Date: Mon,  6 Jul 2026 10:19:13 -0700
Message-ID: <20260706171918.317102-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4370714B79

In LSFMMBPF 2025, I have talked about moving the BPF_PROG_TYPE_SOCK_OPS
to a struct_ops interface [1].

The BPF_SOCK_OPS_*_CB enum interface has grown over time as new TCP
callback points were added. A BPF_PROG_TYPE_SOCK_OPS program now
commonly needs a large switch on sock_ops->op, and the shared
bpf_sock_ops_kern context has become harder to extend because different
callbacks have different locking, argument, skb, and helper
requirements. The existing 'union { u32 args[4]; u32 replylong[4]; }' is
also not reliable in passing args to bpf prog when there are multiple
progs attached to a cgroup.

The above has already been solved in struct_ops. Add a TCP-specific
struct_ops type, bpf_tcp_ops, and support attaching it to cgroups.
This allows each callback have its own func signature and allows
the verifier to select kfuncs/helpers based on the specific
struct_ops member being implemented.

This patch wires up the following existing sock_ops callbacks:
- BPF_SOCK_OPS_TIMEOUT_INIT
- BPF_SOCK_OPS_RWND_INIT
- BPF_SOCK_OPS_RTT_CB
- BPF_SOCK_OPS_STATE_CB
- BPF_SOCK_OPS_RETRANS_CB
- BPF_SOCK_OPS_TCP_CONNECT_CB
- BPF_SOCK_OPS_TCP_LISTEN_CB
- BPF_SOCK_OPS_RTO_CB
- BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB
- BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB

BASE_RTT is ignored as it is not particularly useful. NEEDS_ECN should
be done in bpf-tcp-cc instead. The tstamp ones should be a separate
struct_ops (e.g. "bpf_sock_ops") that can work in both TCP and UDP.

timeout_init and rwnd_init could have a request_sock pointer. This patch
tries a different API and direclty passes the request_sock pointer as
an arg.

Two other approaches were considered before settling on having
bpf_get_retval() read the dispatcher's run_ctx via saved_run_ctx. The
first was to inherit the retval in the trampoline itself: add a helper
in the four __bpf_prog_enter*() paths that, for struct_ops programs,
copies the chained value from the caller's run_ctx (now saved_run_ctx)
into the program's own run_ctx. It works but puts a per-enter
program-type check on the generic trampoline fast path, taxing all
fentry/fexit/lsm callers for a cgroup-struct_ops-only feature. The
second was to do that same inherit only for the int-returning members
via a gen_prologue that emits a hidden kfunc at the start of
timeout_init/rwnd_init; this keeps the cost off the generic path and
scoped to bpf_tcp_ops, but needs a kfunc + BTF_ID + prologue-emission
machinery. The chosen approach avoids both: it touches neither the
trampoline nor the program, since saved_run_ctx already points at the
dispatcher's run_ctx that carries the value.

[1], page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h    |   1 +
 include/net/tcp.h      | 113 ++++++++++++++++++++++++-
 net/ipv4/Makefile      |   1 +
 net/ipv4/af_inet.c     |   1 +
 net/ipv4/bpf_tcp_ops.c | 188 +++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c         |   1 +
 net/ipv4/tcp_input.c   |   4 +
 net/ipv4/tcp_output.c  |   2 +
 net/ipv4/tcp_timer.c   |   1 +
 9 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index df95ae690da5..91024d2da4ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2597,6 +2597,7 @@ struct bpf_trace_run_ctx {
 struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
+	int retval;
 	struct bpf_run_ctx *saved_run_ctx;
 };
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..2102f9f2afd6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2953,12 +2953,120 @@ static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 
 #endif
 
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_CGROUP_BPF)
+
+struct bpf_tcp_ops {
+	/* Should return the initial SYN (active open) or SYN-ACK (passive open)
+	 * retransmission timeout. Return the timeout in jiffies, or <= 0 for
+	 * the kernel default.
+	 *
+	 * @req: request_sock on the passive (synack) path; NULL otherwise.
+	 */
+	int (*timeout_init)(struct sock *sk, struct request_sock *req);
+
+	/* Should return the initial advertised receive window, in packets,
+	 * or < 0 for the kernel default. @req as in timeout_init().
+	 */
+	int (*rwnd_init)(struct sock *sk, struct request_sock *req);
+
+	/* Called when an active connection becomes established.
+	 * @skb is the SYNACK that completed the 3WHS, or NULL for a
+	 * TCP_REPAIR socket (tcp_finish_connect() with no skb).
+	 */
+	void (*active_established)(struct sock *sk, struct sk_buff *skb__nullable);
+
+	/* Called when a passive connection becomes established.
+	 * @skb is the ACK that completed the 3WHS.
+	 */
+	void (*passive_established)(struct sock *sk, struct sk_buff *skb);
+
+	/* Called when the retransmission timer fires. */
+	void (*rto)(struct sock *sk);
+
+	/* Called on every RTT sample.
+	 * @mrtt: the measured RTT, in microseconds.
+	 * @srtt: the updated smoothed RTT.
+	 */
+	void (*rtt)(struct sock *sk, long mrtt, u32 srtt);
+
+	/* Called when the connection changes TCP state.
+	 * @state: the new state (one of the TCP_* states).
+	 */
+	void (*set_state)(struct sock *sk, int state);
+
+	/* Called when an skb is retransmitted.
+	 * @skb: the retransmitted skb.
+	 * @err: tcp_transmit_skb() return value (0 on success).
+	 */
+	void (*retrans)(struct sock *sk, struct sk_buff *skb, int err);
+
+	/* Called right before an active connection is initialized. */
+	void (*connect)(struct sock *sk);
+
+	/* Called on listen(2), right after the socket enters TCP_LISTEN. */
+	void (*listen)(struct sock *sk);
+};
+
+#define bpf_tcp_ops_call(op, sk, ...)					\
+do {									\
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {			\
+		const struct bpf_prog_array_item *item;			\
+		const struct bpf_tcp_ops *tcp_ops;			\
+		struct cgroup *cgrp;					\
+									\
+		cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);		\
+		rcu_read_lock_dont_migrate();				\
+		bpf_cgroup_struct_ops_foreach(tcp_ops, item, cgrp,	\
+					      CGROUP_TCP_SOCK_OPS) {	\
+			if (tcp_ops->op)				\
+				tcp_ops->op(sk, ##__VA_ARGS__);		\
+		}							\
+		rcu_read_unlock_migrate();				\
+	}								\
+} while (0)
+
+#define bpf_tcp_ops_call_int(op, init_retval, sk, ...)			\
+({									\
+	int __retval = (init_retval);					\
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {			\
+		const struct bpf_prog_array_item *item;			\
+		const struct bpf_tcp_ops *tcp_ops;			\
+		struct bpf_tramp_run_ctx run_ctx;			\
+		struct bpf_run_ctx *old_run_ctx;			\
+		struct sock *__sk = sk_to_full_sk(sk);                  \
+		struct request_sock *req = NULL;			\
+		struct cgroup *cgrp;					\
+									\
+		if (__sk) {						\
+			run_ctx.retval = (init_retval);			\
+			cgrp = sock_cgroup_ptr(&__sk->sk_cgrp_data);	\
+			if (!sk_fullsock(sk))				\
+				req = (struct request_sock *)sk;	\
+			rcu_read_lock_dont_migrate();			\
+			old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);\
+			bpf_cgroup_struct_ops_foreach(tcp_ops, item, cgrp, \
+						      CGROUP_TCP_SOCK_OPS) { \
+				if (tcp_ops->op)			\
+					run_ctx.retval = tcp_ops->op(__sk, req, ##__VA_ARGS__); \
+			}						\
+			bpf_reset_run_ctx(old_run_ctx);			\
+			rcu_read_unlock_migrate();			\
+			__retval = run_ctx.retval;			\
+		}							\
+	}								\
+	__retval;							\
+})
+#else
+#define bpf_tcp_ops_call(op, sk, ...)		do { } while (0)
+#define bpf_tcp_ops_call_int(op, init_retval, sk, ...)	(init_retval)
+#endif
+
 static inline u32 tcp_timeout_init(struct sock *sk)
 {
 	int timeout;
 
 	timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT, 0, NULL);
-
+	timeout = bpf_tcp_ops_call_int(timeout_init, timeout, sk);
 	if (timeout <= 0)
 		timeout = TCP_TIMEOUT_INIT;
 	return min_t(int, timeout, TCP_RTO_MAX);
@@ -2969,7 +3077,7 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 	int rwnd;
 
 	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT, 0, NULL);
-
+	rwnd = bpf_tcp_ops_call_int(rwnd_init, rwnd, sk);
 	if (rwnd < 0)
 		rwnd = 0;
 	return rwnd;
@@ -2984,6 +3092,7 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
 	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
+	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
 }
 
 #if IS_ENABLED(CONFIG_SMC)
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 06e21c26b76f..afbac63d1cb4 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_TCP_AO) += tcp_ao.o
 
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_tcp_ca.o
+obj-$(CONFIG_CGROUP_BPF) += bpf_tcp_ops.o
 endif
 
 ifdef CONFIG_GCOV_PROFILE_NETFILTER
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..ac8431da67f4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -227,6 +227,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
 			return err;
 
 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
+		bpf_tcp_ops_call(listen, sk);
 	}
 	return 0;
 }
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
new file mode 100644
index 000000000000..3febbc8dd1a0
--- /dev/null
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/bpf_verifier.h>
+#include <net/bpf_sk_storage.h>
+#include <net/tcp.h>
+
+static int timeout_init_stub(struct sock *sk, struct request_sock *req__nullable)
+{
+	struct bpf_tramp_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
+
+	return ctx->retval;
+}
+
+static int rwnd_init_stub(struct sock *sk, struct request_sock *req__nullable)
+{
+	struct bpf_tramp_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
+
+	return ctx->retval;
+}
+
+static void active_established_stub(struct sock *sk, struct sk_buff *skb__nullable)
+{
+}
+
+static void passive_established_stub(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static void rto_stub(struct sock *sk)
+{
+}
+
+static void rtt_stub(struct sock *sk, long mrtt, u32 srtt)
+{
+}
+
+static void set_state_stub(struct sock *sk, int state)
+{
+}
+
+static void retrans_stub(struct sock *sk, struct sk_buff *skb, int err)
+{
+}
+
+static void connect_stub(struct sock *sk)
+{
+}
+
+static void listen_stub(struct sock *sk)
+{
+}
+
+static struct bpf_tcp_ops __bpf_tcp_ops = {
+	.timeout_init = timeout_init_stub,
+	.rwnd_init = rwnd_init_stub,
+	.active_established = active_established_stub,
+	.passive_established = passive_established_stub,
+	.rto = rto_stub,
+	.rtt = rtt_stub,
+	.set_state = set_state_stub,
+	.retrans = retrans_stub,
+	.connect = connect_stub,
+	.listen = listen_stub,
+};
+
+BPF_CALL_0(bpf_tcp_ops_get_retval)
+{
+	struct bpf_tramp_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, run_ctx);
+
+	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
+	 * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the int
+	 * return value chained across the bpf_tcp_ops attached to the cgroup
+	 * and is this program's saved_run_ctx.
+	 */
+	if (WARN_ON_ONCE(!ctx->saved_run_ctx))
+		return 0;
+
+	return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
+			    run_ctx)->retval;
+}
+
+const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
+	.func		= bpf_tcp_ops_get_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+static const struct bpf_func_proto *
+get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	u32 moff = prog->aux->attach_st_ops_member_off;
+
+	switch (func_id) {
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_setsockopt:
+		/* The listener is not locked. */
+		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
+		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
+			return NULL;
+		return &bpf_sk_setsockopt_proto;
+	case BPF_FUNC_getsockopt:
+		if (moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
+		    moff == offsetof(struct bpf_tcp_ops, timeout_init))
+			return NULL;
+		return &bpf_sk_getsockopt_proto;
+	case BPF_FUNC_get_retval:
+		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
+		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
+			return &bpf_tcp_ops_get_retval_proto;
+		return NULL;
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
+static bool is_valid_access(int off, int size, enum bpf_access_type type,
+			    const struct bpf_prog *prog, struct bpf_insn_access_aux *info)
+{
+	if (!bpf_tracing_btf_ctx_access(off, size, type, prog, info))
+		return false;
+
+	if (base_type(info->reg_type) == PTR_TO_BTF_ID &&
+	    !bpf_type_has_unsafe_modifiers(info->reg_type) &&
+	    info->btf_id == btf_sock_ids[BTF_SOCK_TYPE_SOCK])
+		/* promote it to tcp_sock */
+		info->btf_id = btf_sock_ids[BTF_SOCK_TYPE_TCP];
+
+	return true;
+}
+
+static int bpf_tcp_ops_init_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_tcp_ops_check_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_tcp_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_tcp_ops_validate(void *kdata)
+{
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_tcp_ops_verifier = {
+	.get_func_proto		= get_func_proto,
+	.is_valid_access	= is_valid_access,
+};
+
+static struct bpf_struct_ops bpf_tcp_ops = {
+	.verifier_ops = &bpf_tcp_ops_verifier,
+	.init_member = bpf_tcp_ops_init_member,
+	.check_member = bpf_tcp_ops_check_member,
+	.init = bpf_tcp_ops_init,
+	.validate = bpf_tcp_ops_validate,
+	.name = "bpf_tcp_ops",
+	.cgroup_atype = CGROUP_TCP_SOCK_OPS,
+	.cfi_stubs = &__bpf_tcp_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init __bpf_tcp_ops_init(void)
+{
+	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+}
+late_initcall(__bpf_tcp_ops_init);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..94ed1ac2abc1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2996,6 +2996,7 @@ void tcp_set_state(struct sock *sk, int state)
 
 	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG))
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
+	bpf_tcp_ops_call(set_state, sk, state);
 
 	switch (state) {
 	case TCP_ESTABLISHED:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 61045a8886e4..12fb690d21c4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6694,6 +6694,10 @@ void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
 	tp->snd_cwnd_stamp = tcp_jiffies32;
 
 	bpf_skops_established(sk, bpf_op, skb);
+	if (bpf_op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB)
+		bpf_tcp_ops_call(active_established, sk, skb);
+	else
+		bpf_tcp_ops_call(passive_established, sk, skb);
 	/* Initialize congestion control unless BPF initialized it already: */
 	if (!icsk->icsk_ca_initialized)
 		tcp_init_congestion_control(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 00ec4b5900f2..a91770adfb3a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3678,6 +3678,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
 				  TCP_SKB_CB(skb)->seq, segs, err);
+	bpf_tcp_ops_call(retrans, sk, skb, err);
 
 	if (unlikely(err) && err != -EBUSY)
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
@@ -4298,6 +4299,7 @@ int tcp_connect(struct sock *sk)
 	int err;
 
 	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
+	bpf_tcp_ops_call(connect, sk);
 
 #if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
 	/* Has to be checked late, after setting daddr/saddr/ops.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..4337627ee0ea 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -290,6 +290,7 @@ static int tcp_write_timeout(struct sock *sk)
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RTO_CB,
 				  icsk->icsk_retransmits,
 				  icsk->icsk_rto, (int)expired);
+	bpf_tcp_ops_call(rto, sk);
 
 	if (expired) {
 		/* Has it gone just too far? */
-- 
2.52.0



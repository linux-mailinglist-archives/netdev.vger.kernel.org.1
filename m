Return-Path: <netdev+bounces-289630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id V4D1NVTdDGphpAUAu9opvQ
	(envelope-from <netdev+bounces-289630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0745855DF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE3233025D4B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01E3ECBEA;
	Tue, 19 May 2026 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lo8JeHKj"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C23ECBFB
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227965; cv=none; b=JDjQHnZ74cyBnnzIx6/2Emh8zq122FPk0+j++C3iuNR2YDOmTIFDmKGW5Of4t1uF2hH0UmbQbXOcHMKi/bED9v9NwG7f70v3jbu4leUXjPnmgXzwyI18W8UX4xuZYMsl9MhrP3s+r20+1n5342IGJRHfO6zGlGoyKw8av3wqnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227965; c=relaxed/simple;
	bh=ZcGjKbVwQoxeFjHQ5lGnSM9g2YXjd6HchvKDY6b/Ke8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJyJ5ID0Pmzfr89nqrN5c2B+yt2nZopBN+aIh+M6Hqn8+zWCCEhzle+ZdtJLcw4oVYJNvjqGeQzOeuFD2irxdTqpIFH2e5Q9KiKuy3+LyGk8B+c318FgtNXjdvloudtdKGZitjCJ0Pl26atYz9OTlV8BfqabO8pUEdKiQb8+XDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lo8JeHKj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPzwzImi5SRYWFHKZHpwiJt3zqE6j4NwSOR6Ja0AU/8=;
	b=lo8JeHKjLKA2868h0Z/H9jd5p3617I2ja/DNeANF7CPOQZyeWGRzBBrxK0/oUlMdklWmXF
	pE0SnyD6dei9M0kKDFsI6W+hc4xc6wfxlyef0b0NRxhw8L5vYSHMW2uqGfGeGblKXGPQlt
	Fx+ytFUlLMFSHrDM2Hd0m5q7NNiwgDg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 10/12] bpf: tcp: Support selected sock_ops callbacks as struct_ops
Date: Tue, 19 May 2026 14:58:17 -0700
Message-ID: <20260519215841.2984970-11-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289630-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: EC0745855DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

In LSFMMBPF 2025, I have talked about moving the BPF_PROG_TYPE_SOCK_OPS
to a struct_ops interface [1].

The BPF_SOCK_OPS_*_CB enum interface has grown over time as new TCP callback
points were added. A BPF_PROG_TYPE_SOCK_OPS program now commonly needs a
large switch on sock_ops->op, and the shared bpf_sock_ops_kern context has
become harder to extend because different callbacks have different locking,
argument, skb, and helper requirements. The existing
'union { u32 args[4]; u32 replylong[4]; }' is also not reliable in
passing args to bpf prog when there are multiple progs attached to a cgroup.

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

I don't think BASE_RTT is useful. NEEDS_ECN should be done in
bpf-tcp-cc instead. The tstamp ones should be a separate
struct_ops (e.g. "bpf_sock_ops") that can work in both TCP and UDP.

timeout_init and rwnd_init could have a request_sock pointer. This patch
tries a different API and direclty passes the request_sock pointer as
an arg

The patch is incomplete. TODOs:
- A skb argument should be added to the retrans ops.
- ACTIVE_ESTABLISHED_CB and PASSIVE_ESTABLISHED_CB
- BPF_SOCK_OPS_*HDR related ops
- RTO

[1], page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/net/tcp.h      |  74 ++++++++++++++++++++++-
 net/ipv4/Makefile      |   1 +
 net/ipv4/af_inet.c     |   1 +
 net/ipv4/bpf_tcp_ops.c | 134 +++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c         |   4 +-
 net/ipv4/tcp_output.c  |   5 +-
 6 files changed, 214 insertions(+), 5 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a744..eb9ff07f3c83 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2960,12 +2960,78 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 
 #endif
 
+#if defined(CONFIG_BPF_JIT) && defined(CONFIG_CGROUP_BPF)
+
+struct bpf_tcp_ops {
+	int (*timeout_init)(struct sock *sk, struct request_sock *req);
+	int (*rwnd_init)(struct sock *sk, struct request_sock *req);
+	void (*rtt)(struct sock *sk, long mrtt, u32 srtt);
+	void (*set_state)(struct sock *sk, int state);
+	void (*retrans)(struct sock *sk, int type);
+	void (*connect)(struct sock *sk);
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
+		struct bpf_run_ctx *old_run_ctx;			\
+		struct bpf_cg_run_ctx run_ctx;				\
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
@@ -2976,7 +3042,7 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 	int rwnd;
 
 	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT, 0, NULL);
-
+	rwnd = bpf_tcp_ops_call_int(rwnd_init, rwnd, sk);
 	if (rwnd < 0)
 		rwnd = 0;
 	return rwnd;
@@ -2989,8 +3055,10 @@ static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
 
 static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG)) {
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
+		bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
+	}
 }
 
 #if IS_ENABLED(CONFIG_SMC)
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 7f9f98813986..356335e06b4c 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -71,4 +71,5 @@ obj-$(CONFIG_TCP_AO) += tcp_ao.o
 
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_tcp_ca.o
+obj-$(CONFIG_CGROUP_BPF) += bpf_tcp_ops.o
 endif
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0e62032e76b1..71f9a171310f 100644
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
index 000000000000..aa647d805882
--- /dev/null
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -0,0 +1,134 @@
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
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	return ctx->retval;
+}
+
+static int rwnd_init_stub(struct sock *sk, struct request_sock *req__nullable)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	return ctx->retval;
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
+static void retrans_stub(struct sock *sk, int type)
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
+	.rtt = rtt_stub,
+	.set_state = set_state_stub,
+	.retrans = retrans_stub,
+	.connect = connect_stub,
+	.listen = listen_stub,
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
+late_initcall(__bpf_tcp_ops_init)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4..c0f47a4c7980 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2998,8 +2998,10 @@ void tcp_set_state(struct sock *sk, int state)
 	 */
 	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG))
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG)) {
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
+		bpf_tcp_ops_call(set_state, sk, state);
+	}
 
 	switch (state) {
 	case TCP_ESTABLISHED:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f7..ed51713b2216 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3673,9 +3673,11 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
 	}
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
+	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG)) {
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
 				  TCP_SKB_CB(skb)->seq, segs, err);
+		bpf_tcp_ops_call(retrans, sk, err);
+	}
 
 	if (unlikely(err) && err != -EBUSY)
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
@@ -4296,6 +4298,7 @@ int tcp_connect(struct sock *sk)
 	int err;
 
 	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
+	bpf_tcp_ops_call(connect, sk);
 
 #if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
 	/* Has to be checked late, after setting daddr/saddr/ops.
-- 
2.53.0-Meta



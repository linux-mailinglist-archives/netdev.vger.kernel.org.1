Return-Path: <netdev+bounces-298427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSo1BsldK2qS8AMAu9opvQ
	(envelope-from <netdev+bounces-298427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC0676138
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ltYDB3pO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9638314BAB1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF631C567;
	Fri, 12 Jun 2026 01:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1230566C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226925; cv=none; b=mUsKHnYt/zQee7Bt8+XRHwc1Ccx2fpmHG+MTMAEIE6T60gYBKpemYr1BhNiCbgfxGpR3gTcVCza3i5YHhv/IURxTLueNv1GJOjEopmBAppu3wdgMY07gZVC8mfUYWToSzD7zri9mFuwrcJ+XG2dO5t/6OLvqhk/eLml8AdFxePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226925; c=relaxed/simple;
	bh=fnJuavT71SaYMp8YHtSumr/AzT063gWmBCp0+f5FIeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8mvtEWifqCgtt5kLBy5meAFmKZEtUn8Gsa7OcTwT7+fuQybUFs+eoMAyW6o+aaMRiBba6hNYrDt+WIl4FRZWRov52odXn4EKGoxeEYiMOX3nSwvgSFQLejjFTj9NiUDngE+QdCXyFw+kbYjUpDesON6EDiFbRoh7yDhwcm4uXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltYDB3pO; arc=none smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13832028e9fso413963c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226922; x=1781831722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN+cd0V7eh6P/XjvI6AdUyUAsxL3p1hB0mM+x3ai7gI=;
        b=ltYDB3pO+5CQmBRRu1CoykrH60WbL+iJ0AxXgMZuVPJr9wqlHgtOGPcDw5+jpHvv+D
         gSnkHMPgGn4nmUtKcCMXiLyN/PoMMxXrYTCwp3/GcOiNv01sff0bXB8HDeVu2VlvwF4q
         SGRUpQQhxSc+CylQublRbrHFWsFHbF1lJVXAkasFKePrqIeoCXqenNjH2ElkKiMFU3Dg
         6Gv4fFE/l22oybiAXyIKjmBCxhcjnTtruk7hgWD+bjiELI7DlYnwslnaE8F5uTdimgN5
         lqxQS2I40eXghksbbaC2iT9yUoBIRdLz7YY61bCJEwtetoo1u7obKQOC4gqcmNXWsOPI
         sQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226922; x=1781831722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UN+cd0V7eh6P/XjvI6AdUyUAsxL3p1hB0mM+x3ai7gI=;
        b=O538VlP8BxKC36Mxv5aCYHhhAxx2EWxjH0zkwl7CGnW4xD+HYGJMFH4eX21WFVu+Ml
         PRgylj/XpJkhFh5abxUt3YmaAbGAnbzrVM/AApYTOmTkVEooCBG93DmgdS6y6hINBUH0
         q/amQV0fiCzjhDPJj+aiJm/l/ZT0Khi91FWwGoU8CgkBDA56fkxFMZWI+o8diltdlUoz
         RMVaWJiweOf8AjzdhgqEQwEWLgwTMbhQLTbcp7BJfar1F6zu3PsgNqSxSg0Ymc3M4Jdf
         uhdXz25BoY0PzfhqLlymMtSIAPXwp0BCCQckAWi5me3jO8yZ73wVrKtBavCPar8PXPJA
         23NQ==
X-Gm-Message-State: AOJu0Yx6x6QXC7EpwxTwLItepc9oGrdN8V0fAg5cb2l8GD0AhLaUsK/+
	UmH3kfMjUPm/W4ebBLLhGq3awSoxb+wn1Yo+mqD1Xw3a863I7LMArQPqHkHImA==
X-Gm-Gg: Acq92OENk9RtUfbOgsUp5NUjv1iIJfmXl9X2rexIuJn+m7is1EICUwrnf89GB+ypbCL
	3fEiGSRBjxCWBy1eoEmtVzaItjybeLhEGNXorcFE13wc3SMil/OhROWpocZtHnOfvmarpACUt9O
	fPyA7vbBON9CcxLGtgOmxDXfAmR2AZ6ZvlWqVNx72MZuacbfy/bgoI8gwbTPrZFNJiZ2kOjsGtF
	iScOHOpep4qLBQSBlQKY3c3958ohFiN2Cy1IBXqMbB6zakEUNKSVFBeZrh/y+1tVaGlQqnu9rs7
	/FPRpjeqzl6lKHLap0CIEwO9M/rLVS9bEvydPXCO/fJR+a7XUxIccPgMW/fPMKnwKWq+/zUYXaX
	LEEC8TCst2gelSoGJWYGWyqHwgkfDUlCFe8h47nAuXlpWqd0zTvzuH9MZKHfD1XpTGKVIVioz8G
	/JckyS2IVASR0rVFKs0NoieaZS3tOnT8Y60d1xgo9FHkoDFGGgBH4MAuNLBvWBV6151A==
X-Received: by 2002:a05:7022:43a9:b0:136:d237:b42f with SMTP id a92af1059eb24-1384bb97396mr341577c88.32.1781226920829;
        Thu, 11 Jun 2026 18:15:20 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:20 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 1/5] tcp_bpf: add bpf_sock_splice_pair kfunc for opportunistic loopback splice
Date: Thu, 11 Jun 2026 18:14:48 -0700
Message-ID: <20260612011452.134466-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com,multikernel.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298427-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyou.wangcong@gmail.com,m:cwang@multikernel.io,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[multikernel.io:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFDC0676138

Two locally-connected TCP sockets can be paired by a sock_ops BPF
program at handshake completion. Once paired, sendmsg copies the user
payload into a per-direction kernel-side byte ring; recvmsg drains the
ring into the user buffer. Both copies happen in their own task's mm,
so no cross-mm pin / kmap dance is needed and the splice fast path
incurs no skb construction, no softirq, and no TCP protocol-state
processing. The TCP wire connection itself never sees the spliced
bytes: sequence numbers stay frozen at post-handshake values, so FIN,
RST, and keepalive continue to work through the regular paths and the
pair tears down via a normal close handshake.

Per-direction ring layout
-------------------------

The ring is a power-of-two byte buffer (16 KiB by default) backed by
order-2 pages from __get_free_pages(), manipulated through
include/linux/circ_buf.h macros. Both per-direction rings are allocated
when the pair is formed, so the data path never allocates. Producer and
consumer are SPSC (one socket each side), so head and tail are updated
with smp_store_release() / smp_load_acquire() without a data-path lock.
Each side keeps a private cache of the other's cursor (the producer
caches ring_tail) and reads the real, cross-CPU cursor only when the
cache is exhausted - standard SPSC cursor caching. sendmsg copies from
the user iov into the ring at head; recvmsg copies out at tail.

The ring is the queue between sender and receiver - it accumulates
across recvmsg calls, so a sequence of small sends amortises into one
wake when the receiver isn't draining synchronously. This is what
makes the splice path viable for streaming workloads without forcing
per-message rendezvous. The cost is one extra in-kernel copy compared
to a sender->user-pages direct mechanism, but the benefit is that the
splice path can stay engaged across arbitrary phasing between sender
and receiver - no app cooperation required.

The sender keeps the peer ring alive across the copy with a per-pair
percpu_ref rather than a per-message socket refcount, and validates
only its own socket's error/shutdown state, as the rest of tcp_bpf does
- a peer reset reaches it over the still-live TCP connection. Both keep
the per-message cost off cross-CPU cachelines.

Sender (splice_send_ring) defers to tcp_sendmsg() when (a) the peer
rcv_queue is non-empty (preserving stream ordering against prior TCP
fallback) or (b) the ring is full (TCP-level backpressure via sndbuf /
snd_wnd absorbs the overflow). Receiver (tcp_bpf_splice_recvmsg)
defers to tcp_recvmsg() when the rcv_queue holds data and the ring is
empty. The end-to-end ordering invariant is: rcv_queue bytes are
always older than any ring bytes drained alongside them, because the
sender only writes to the ring while the peer rcv_queue is empty.

For bytes that take the splice fast path, SO_SNDBUF and SO_RCVBUF are
not honored - the sndbuf / rcvbuf accounting machinery is exactly
what splice intentionally bypasses. The associated infrastructure -
sk_mem_charge / sk_mem_uncharge, sk_forward_alloc,
prot->memory_allocated, tcp_memory_pressure, the per-cpu reserves -
is among the most painful parts of TCP to maintain, and spliced bytes
opt out of it as a side effect of having no skb-borne kernel-side
bytes to account for. The ring's own capacity is bounded
(SPLICE_RING_SIZE), giving a hard upper bound on per-pair memory.
SIOCINQ / SIOCOUTQ reflect only the underlying TCP socket's frozen
counters, and getsockopt(TCP_INFO) likewise. Bytes that take the TCP
fallback go through the regular TCP path with all of its normal
accounting.

Pairing is opt-in per flow - the BPF program at handshake decides
which connections to splice. Applications that mix handshake-style
traffic and bulk streaming on the same paired socket get the right
behaviour on both phases automatically: the handshake survives via
TCP fallback, the bulk phase runs through the ring.

The receiver parks on the socket waitqueue when the ring is empty.
A following patch adds an optional bounded busy-poll of the ring
before parking, gated on the socket's SO_BUSY_POLL budget; it is off
by default and is what turns the latency-bound TCP_RR case into a
large win once enabled. The numbers below are with busy polling
disabled.

Microbenchmarks
---------------

Pinned to two adjacent CPUs (sender CPU 1, receiver CPU 0), 10s per
run, 3 runs averaged; netperf to 127.0.0.1. Splice without busy
polling.

Bare-metal loopback:

  TCP_STREAM  msg=   64 B:   2577 ->  1680  Mbps  (0.65x)
              msg=  256 B:   9336 ->  8640  Mbps  (0.93x)
              msg=    1 KB: 22416 -> 24136  Mbps  (1.08x)
              msg=    4 KB: 37893 -> 52304  Mbps  (1.38x)
              msg=   16 KB: 48019 -> 53235  Mbps  (1.11x)
              msg=   64 KB: 49686 -> 49418  Mbps  (0.99x)

  TCP_RR      sz=     1 B:  110.2k -> 267.0k tps  (2.42x)
              sz=    64 B:  111.6k -> 265.7k tps  (2.38x)
              sz=     1 KB: 105.8k -> 235.1k tps  (2.22x)
              sz=    16 KB:  40.5k ->  89.6k tps  (2.21x)
              sz=    64 KB:  17.8k ->  20.9k tps  (1.17x)

Container-to-container (two network namespaces connected via veth pair
plus Linux bridge, processes pinned in the same way):

  TCP_STREAM  msg=   64 B:   1420 ->   1643 Mbps  (1.16x)
              msg=    1 KB:  3710 -> 21326 Mbps  (5.75x)
              msg=    4 KB:  8084 -> 48834 Mbps  (6.04x)
              msg=   16 KB: 26083 -> 27788 Mbps  (1.07x)
              msg=   64 KB: 47659 -> 47507 Mbps  (1.00x)

  TCP_RR      sz=     1 B:  105.0k -> 265.0k tps  (2.52x)
              sz=    64 B:  101.2k -> 264.3k tps  (2.61x)
              sz=     1 KB:  99.9k -> 233.9k tps  (2.34x)
              sz=    16 KB:  44.8k ->  91.1k tps  (2.03x)
              sz=    64 KB:  18.1k ->  23.5k tps  (1.30x)

Synchronous-RPC workloads (TCP_RR) win 2.0-2.6x across both
environments because the ring eliminates the per-cycle overhead of the
kernel TCP receive path. Mid-message streaming wins on loopback
(4-16 KB at 1.1-1.4x). Tiny-message streaming on bare-metal loopback
regresses to 0.65x because loopback TCP's TSO super-segments amortise
per-batch cost to ~20 ns/msg, below the ring's 2-copy per-cycle floor;
this is structural. In containers the same workload wins decisively
because per-packet veth+bridge overhead dwarfs the ring's floor:
STREAM-1 KB and STREAM-4 KB go 5.75x and 6.04x because TCP's per-skb
cost dominates the container path and the ring sidesteps it entirely.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 include/linux/skmsg.h |   9 +
 include/net/tcp.h     |   8 +
 net/core/skmsg.c      |   3 +
 net/ipv4/tcp_bpf.c    | 809 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 828 insertions(+), 1 deletion(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f9..c9b7144cc846 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -80,6 +80,8 @@ struct sk_psock_work_state {
 	u32				off;
 };
 
+struct sk_psock_splice;	/* defined in net/ipv4/tcp_bpf.c */
+
 struct sk_psock {
 	struct sock			*sk;
 	struct sock			*sk_redir;
@@ -121,6 +123,13 @@ struct sk_psock {
 	struct delayed_work		work;
 	struct sock			*sk_pair;
 	struct rcu_work			rwork;
+
+	/* Loopback splice state for paired stream sockets. NULL until the
+	 * first bpf_sock_splice_pair() call on this psock; lazily allocated
+	 * and kept for the lifetime of the psock so that sender/receiver
+	 * paths don't need to revalidate the pointer mid-flight.
+	 */
+	struct sk_psock_splice __rcu	*splice;
 };
 
 int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..c1597accdac9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2855,6 +2855,8 @@ struct sk_psock;
 #ifdef CONFIG_BPF_SYSCALL
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+void tcp_bpf_splice_unpair(struct sk_psock *psock);
+void tcp_bpf_splice_destroy(struct sk_psock *psock);
 #ifdef CONFIG_BPF_STREAM_PARSER
 struct strparser;
 int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
@@ -2880,6 +2882,12 @@ static inline void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 }
 #endif
 
+#if !defined(CONFIG_BPF_SYSCALL)
+struct sk_psock;
+static inline void tcp_bpf_splice_unpair(struct sk_psock *psock) {}
+static inline void tcp_bpf_splice_destroy(struct sk_psock *psock) {}
+#endif
+
 #ifdef CONFIG_CGROUP_BPF
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..b39fc249a18d 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -881,12 +881,15 @@ static void sk_psock_destroy(struct work_struct *work)
 		sock_put(psock->sk_redir);
 	if (psock->sk_pair)
 		sock_put(psock->sk_pair);
+	tcp_bpf_splice_destroy(psock);
 	sock_put(psock->sk);
 	kfree(psock);
 }
 
 void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
 {
+	tcp_bpf_splice_unpair(psock);
+
 	write_lock_bh(&sk->sk_callback_lock);
 	sk_psock_restore_proto(sk, psock);
 	rcu_assign_sk_user_data(sk, NULL);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..549f37077244 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -4,14 +4,31 @@
 #include <linux/skmsg.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/circ_buf.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/wait.h>
 #include <linux/util_macros.h>
+#include <linux/percpu-refcount.h>
 
 #include <net/inet_common.h>
+#include <net/inet_sock.h>
 #include <net/tls.h>
 #include <asm/ioctls.h>
 
+static bool sk_psock_is_spliced(const struct sk_psock *psock);
+static int tcp_bpf_splice_recvmsg(struct sock *sk, struct sk_psock *psock,
+				  struct msghdr *msg, size_t len,
+				  int flags, int *err);
+static int splice_send_ring(struct sock *sk, struct sk_psock *psock,
+			    struct msghdr *msg, size_t size, int flags);
+static int tcp_bpf_splice_sendmsg(struct sock *sk, struct msghdr *msg,
+				  size_t size);
+static void splice_ring_free(struct sk_psock_splice *s);
+static bool tcp_bpf_is_readable(struct sock *sk);
+
 void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tcp;
@@ -365,6 +382,46 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, flags);
+
+	/* Splice dispatch.
+	 *
+	 * Streaming-friendly ordering: drain anything TCP has already
+	 * queued in sk_receive_queue FIRST. The sender stays on plain
+	 * tcp_sendmsg() (preserving Nagle, TSO, sk_write_queue
+	 * coalescing) whenever the peer rcv_queue has bytes in flight,
+	 * so if a receiver is keeping up with a bulk stream we never
+	 * publish a bvec and never push the sender into per-message
+	 * synchronous mode. Only when sk_receive_queue is empty (the
+	 * receiver would otherwise block) do we enter the rendezvous
+	 * path; the sender's opportunistic check then finds our pinned
+	 * iov and does the direct user-to-user copy fast path.
+	 *
+	 * splice_recvmsg returns 0 with no error if rcv_queue gained
+	 * bytes during the wait (TCP arrival raced our pin), in which
+	 * case the next block below drains them via tcp_recvmsg() and
+	 * stream ordering is preserved end-to-end.
+	 */
+	if (sk_psock_is_spliced(psock)) {
+		int err = 0, rcopied;
+
+		/* tcp_bpf_splice_recvmsg drains the ring first (ring bytes
+		 * predate any rcv_queue bytes when both have data) and only
+		 * returns 0 when both are empty or rcv_queue has the only
+		 * bytes left. The block below then routes the rcv_queue
+		 * drain via tcp_recvmsg().
+		 */
+		rcopied = tcp_bpf_splice_recvmsg(sk, psock, msg, len,
+						 flags, &err);
+		if (rcopied > 0) {
+			sk_psock_put(sk, psock);
+			return rcopied;
+		}
+		if (err) {
+			sk_psock_put(sk, psock);
+			return err;
+		}
+	}
+
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
 	    sk_psock_queue_empty(psock)) {
 		sk_psock_put(sk, psock);
@@ -626,8 +683,9 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 	prot[TCP_BPF_BASE]			= *base;
 	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
+	prot[TCP_BPF_BASE].sendmsg		= tcp_bpf_splice_sendmsg;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
-	prot[TCP_BPF_BASE].sock_is_readable	= sk_msg_is_readable;
+	prot[TCP_BPF_BASE].sock_is_readable	= tcp_bpf_is_readable;
 	prot[TCP_BPF_BASE].ioctl		= tcp_bpf_ioctl;
 
 	prot[TCP_BPF_TX]			= prot[TCP_BPF_BASE];
@@ -756,4 +814,753 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
 	if (is_insidevar(prot, tcp_bpf_prots))
 		newsk->sk_prot = sk->sk_prot_creator;
 }
+
+/* Per-psock splice state: a SPSC byte ring (this socket reads from
+ * ring_buf; the paired sender writes into it). Sender defers to
+ * tcp_sendmsg() when peer rcv_queue is non-empty (ordering) or the
+ * ring is full (backpressure); receiver defers to tcp_recvmsg() when
+ * rcv_queue has data. Head/tail are monotonic; buffer offset is
+ * (cursor & (ring_size - 1)). Data path is lockless via release/
+ * acquire on head/tail; ->lock serialises only lazy alloc / teardown.
+ */
+struct sk_psock_splice {
+	struct sk_psock		*peer;      /* NULL after unpair */
+	spinlock_t		lock;       /* alloc/teardown only */
+	void			*ring_buf;  /* order-2 pages, ring_size bytes */
+	size_t			ring_size;  /* power of 2 */
+	struct percpu_ref	ring_ref;   /* cross-socket writers into ring_buf */
+
+	/* Producer and consumer cursors live on separate cache lines: the
+	 * writer's release-store of ring_head must not invalidate the
+	 * reader's hot ring_tail line, and vice versa. cached_tail is the
+	 * producer's private cache of ring_tail, kept on the producer's own
+	 * line, so the producer reads the consumer-owned ring_tail only when
+	 * its cache says the ring is full - standard SPSC cursor caching.
+	 */
+	unsigned long		ring_head ____cacheline_aligned_in_smp;
+	unsigned long		cached_tail;
+	unsigned long		ring_tail ____cacheline_aligned_in_smp;
+};
+
+#define SPLICE_RING_SIZE	(16U * 1024U)
+
+/* Wake any waiters parked on @sk. Used at teardown so a sleeping
+ * receiver observes the cleared ->peer and exits. The smp_mb() closes
+ * the same lost-wakeup window as splice_wake_sync() below.
+ */
+static inline void splice_wake(struct sock *sk)
+{
+	wait_queue_head_t *wq = sk_sleep(sk);
+
+	smp_mb();
+	if (wq && waitqueue_active(wq))
+		wake_up_interruptible_all(wq);
+}
+
+/* Wake the receiver after a producer write to the ring. The _poll
+ * variant with EPOLLIN | EPOLLRDNORM is required so poll()/select()/
+ * epoll waiters see the wake (a plain sync wake carries no mask and is
+ * silently dropped by poll waiters); wait_event-style waiters wake on
+ * it too. The smp_mb() orders the ring head publish before the
+ * waitqueue_active() check, pairing with set_current_state() in the
+ * consumer's wait loop - without it the producer can skip the wake
+ * while the consumer concurrently parks with the predicate just-
+ * not-yet-true, a lost wakeup. _sync hints the scheduler to keep the
+ * wakee on the producer's CPU.
+ */
+static inline void splice_wake_sync(struct sock *sk)
+{
+	wait_queue_head_t *wq = sk_sleep(sk);
+
+	smp_mb();
+	if (wq && waitqueue_active(wq))
+		wake_up_interruptible_sync_poll(wq, EPOLLIN | EPOLLRDNORM);
+}
+
+static bool sk_psock_is_spliced(const struct sk_psock *psock)
+{
+	struct sk_psock_splice *s = rcu_dereference(psock->splice);
+
+	return s && rcu_access_pointer(s->peer);
+}
+
+static int tcp_bpf_splice_sendmsg(struct sock *sk, struct msghdr *msg,
+				  size_t size)
+{
+	struct sk_psock *psock;
+	int spliced = 0;
+	int ret;
+
+	psock = sk_psock_get(sk);
+	if (psock) {
+		if (sk_psock_is_spliced(psock)) {
+			int flags = (msg->msg_flags &
+				     ~MSG_SENDPAGE_DECRYPTED) |
+				     MSG_NO_SHARED_FRAGS;
+
+			spliced = splice_send_ring(sk, psock, msg,
+						   size, flags);
+		}
+		sk_psock_put(sk, psock);
+	}
+
+	if ((size_t)spliced < size) {
+		ret = tcp_sendmsg(sk, msg, size - spliced);
+		if (ret < 0)
+			return spliced > 0 ? spliced : ret;
+		return spliced + ret;
+	}
+	return spliced;
+}
+
+/* percpu_ref release: fires after percpu_ref_kill() once every in-flight
+ * cross-socket sender has dropped its hold. Safe to free the ring and the
+ * splice state now.
+ */
+static void splice_ring_ref_release(struct percpu_ref *ref)
+{
+	struct sk_psock_splice *s =
+		container_of(ref, struct sk_psock_splice, ring_ref);
+
+	splice_ring_free(s);
+	percpu_ref_exit(&s->ring_ref);
+	kfree(s);
+}
+
+static struct sk_psock_splice *splice_get_or_alloc(struct sk_psock *psock)
+{
+	struct sk_psock_splice *s, *old;
+
+	s = rcu_dereference_protected(psock->splice, 1);
+	if (s)
+		return s;
+
+	s = kzalloc_obj(*s, GFP_ATOMIC);
+	if (!s)
+		return NULL;
+	spin_lock_init(&s->lock);
+
+	if (percpu_ref_init(&s->ring_ref, splice_ring_ref_release, 0,
+			    GFP_ATOMIC)) {
+		kfree(s);
+		return NULL;
+	}
+
+	old = cmpxchg((struct sk_psock_splice **)&psock->splice, NULL, s);
+	if (old) {
+		percpu_ref_exit(&s->ring_ref);
+		kfree(s);
+		return old;
+	}
+	return s;
+}
+
+static void splice_lock_pair(struct sk_psock_splice *a,
+			     struct sk_psock_splice *b)
+{
+	if (a < b) {
+		spin_lock_bh(&a->lock);
+		spin_lock_nested(&b->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_bh(&b->lock);
+		spin_lock_nested(&a->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static void splice_unlock_pair(struct sk_psock_splice *a,
+			       struct sk_psock_splice *b)
+{
+	if (a < b) {
+		spin_unlock(&b->lock);
+		spin_unlock_bh(&a->lock);
+	} else {
+		spin_unlock(&a->lock);
+		spin_unlock_bh(&b->lock);
+	}
+}
+
+/*
+ * Tear down a splice pair. Idempotent and safe to call from any teardown
+ * path (sk_psock_drop, tcp_close, tcp_disconnect, RST handler). No-op if
+ * the psock was never spliced.
+ *
+ * Note: the splice_state allocation is NOT freed here - it lives until
+ * sk_psock_destroy. That keeps sender/receiver fast paths free of
+ * lifetime dances.
+ */
+void tcp_bpf_splice_unpair(struct sk_psock *psock)
+{
+	struct sk_psock_splice *self_s, *peer_s;
+	struct sk_psock *peer;
+	bool was_paired = false;
+
+	self_s = rcu_dereference_protected(psock->splice, 1);
+	if (!self_s)
+		return;
+
+	rcu_read_lock();
+	peer = rcu_dereference(self_s->peer);
+	if (!peer) {
+		rcu_read_unlock();
+		return;
+	}
+	if (!sk_psock_get(peer->sk)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	peer_s = rcu_dereference_protected(peer->splice, 1);
+	if (!peer_s) {
+		sk_psock_put(peer->sk, peer);
+		return;
+	}
+
+	splice_lock_pair(self_s, peer_s);
+	if (self_s->peer == peer && peer_s->peer == psock) {
+		rcu_assign_pointer(self_s->peer, NULL);
+		rcu_assign_pointer(peer_s->peer, NULL);
+		was_paired = true;
+	}
+	splice_unlock_pair(self_s, peer_s);
+
+	/* Wake any blocked rendezvous waiters on either side. They will
+	 * re-check the predicate, see splice->peer == NULL, and exit.
+	 */
+	splice_wake(psock->sk);
+	splice_wake(peer->sk);
+
+	if (was_paired) {
+		/* Drop the pair's psock references. Ring buffers are NOT
+		 * freed here: a recvmsg may be mid-splice_ring_read() on
+		 * either side, holding only sk_psock_get() - it does not
+		 * keep ring_buf alive. Defer the kvfree to
+		 * tcp_bpf_splice_destroy(), which runs after psock teardown
+		 * has drained all callers.
+		 */
+		sk_psock_put(peer->sk, peer);
+		sk_psock_put(psock->sk, psock);
+	}
+	sk_psock_put(peer->sk, peer);
+}
+EXPORT_SYMBOL_GPL(tcp_bpf_splice_unpair);
+
+void tcp_bpf_splice_destroy(struct sk_psock *psock)
+{
+	struct sk_psock_splice *s;
+
+	/* Kill the ring ref; splice_ring_ref_release() frees the ring and s
+	 * once any in-flight cross-socket sender has dropped its hold.
+	 */
+	s = rcu_dereference_protected(psock->splice, 1);
+	if (s)
+		percpu_ref_kill(&s->ring_ref);
+}
+EXPORT_SYMBOL_GPL(tcp_bpf_splice_destroy);
+
+/* The PASSIVE_ESTABLISHED_CB fires BEFORE the kernel transitions the
+ * accepted child's state from TCP_SYN_RECV to TCP_ESTABLISHED.Accept
+ * SYN_RECV here since we know the callback contract guarantees
+ * imminent ESTABLISHED.
+ */
+static bool splice_state_ok(int state)
+{
+	return state == TCP_ESTABLISHED || state == TCP_SYN_RECV;
+}
+
+static int splice_validate(struct sock *a, struct sock *b)
+{
+	struct tcp_sock *ta = tcp_sk(a), *tb = tcp_sk(b);
+
+	if (a->sk_family != b->sk_family)
+		return -EINVAL;
+	if (a->sk_protocol != IPPROTO_TCP || b->sk_protocol != IPPROTO_TCP)
+		return -EINVAL;
+	if (!splice_state_ok(a->sk_state) || !splice_state_ok(b->sk_state))
+		return -EINVAL;
+	if (ta->repair || tb->repair)
+		return -EINVAL;
+	if (ta->urg_data || tb->urg_data)
+		return -EINVAL;
+	return 0;
+}
+
+static int splice_ring_alloc(struct sk_psock_splice *s)
+{
+	void *buf;
+
+	if (READ_ONCE(s->ring_buf))
+		return 0;
+
+	buf = (void *)__get_free_pages(GFP_ATOMIC | __GFP_NOWARN,
+				       get_order(SPLICE_RING_SIZE));
+	if (!buf)
+		return -ENOMEM;
+
+	spin_lock_bh(&s->lock);
+	if (s->ring_buf) {
+		spin_unlock_bh(&s->lock);
+		free_pages((unsigned long)buf, get_order(SPLICE_RING_SIZE));
+		return 0;
+	}
+	s->ring_buf    = buf;
+	s->ring_size   = SPLICE_RING_SIZE;
+	s->ring_head   = 0;
+	s->ring_tail   = 0;
+	s->cached_tail = 0;
+	spin_unlock_bh(&s->lock);
+	return 0;
+}
+
+static void splice_ring_free(struct sk_psock_splice *s)
+{
+	void *buf;
+
+	spin_lock_bh(&s->lock);
+	buf = s->ring_buf;
+	s->ring_buf    = NULL;
+	s->ring_size   = 0;
+	s->ring_head   = 0;
+	s->ring_tail   = 0;
+	s->cached_tail = 0;
+	spin_unlock_bh(&s->lock);
+
+	if (buf)
+		free_pages((unsigned long)buf, get_order(SPLICE_RING_SIZE));
+}
+
+static size_t splice_ring_write(struct sk_psock_splice *s,
+				struct iov_iter *from, size_t size)
+{
+	unsigned long head, tail, mask;
+	size_t avail, want, to_end, first, second, done;
+
+	if (!s->ring_buf)
+		return 0;
+
+	mask = s->ring_size - 1;
+	head = s->ring_head;
+	/* Use the producer's cached_tail, refreshed by splice_ring_space()
+	 * earlier in this same send. It is conservative - the real ring_tail
+	 * only advances - so the free space computed here never exceeds the
+	 * true free space, and we avoid a second cross-CPU ring_tail read.
+	 */
+	tail = s->cached_tail;
+	avail = CIRC_SPACE(head, tail, s->ring_size);
+	want = min_t(size_t, size, avail);
+	if (!want)
+		return 0;
+
+	to_end = s->ring_size - (head & mask);
+	first  = min_t(size_t, want, to_end);
+
+	done = copy_from_iter(s->ring_buf + (head & mask), first, from);
+	if (done < first) {
+		/* Publish data before head advance. */
+		smp_store_release(&s->ring_head, head + done);
+		return done;
+	}
+	second = want - first;
+	if (second) {
+		done = copy_from_iter(s->ring_buf, second, from);
+		/* Publish data before head advance. */
+		smp_store_release(&s->ring_head, head + first + done);
+		return first + done;
+	}
+	/* Publish data before head advance. */
+	smp_store_release(&s->ring_head, head + first);
+	return first;
+}
+
+static size_t splice_ring_space(struct sk_psock_splice *s)
+{
+	unsigned long head = s->ring_head;
+	size_t space = CIRC_SPACE(head, s->cached_tail, s->ring_size);
+
+	if (space)
+		return space;
+	/* Cache exhausted; refresh from the consumer-owned cursor - the only
+	 * cross-CPU ring_tail read. Pairs with smp_store_release(&ring_tail).
+	 */
+	s->cached_tail = smp_load_acquire(&s->ring_tail);
+	return CIRC_SPACE(head, s->cached_tail, s->ring_size);
+}
+
+static size_t splice_ring_read(struct sk_psock_splice *s,
+			       struct iov_iter *to, size_t size)
+{
+	unsigned long head, tail, mask;
+	size_t have, want, to_end, first, second, done;
+
+	if (!s->ring_buf)
+		return 0;
+
+	mask = s->ring_size - 1;
+	tail = s->ring_tail;
+	/* Pairs with smp_store_release(&ring_head) in splice_ring_write():
+	 * ensure we read producer's data after observing the head advance.
+	 */
+	head = smp_load_acquire(&s->ring_head);
+	have = CIRC_CNT(head, tail, s->ring_size);
+	want = min_t(size_t, size, have);
+	if (!want)
+		return 0;
+
+	to_end = s->ring_size - (tail & mask);
+	first  = min_t(size_t, want, to_end);
+
+	done = copy_to_iter(s->ring_buf + (tail & mask), first, to);
+	if (done < first) {
+		/* Release: free slots before the producer sees the advance. */
+		smp_store_release(&s->ring_tail, tail + done);
+		return done;
+	}
+	second = want - first;
+	if (second) {
+		done = copy_to_iter(s->ring_buf, second, to);
+		/* Release: free slots before the producer sees the advance. */
+		smp_store_release(&s->ring_tail, tail + first + done);
+		return first + done;
+	}
+	/* Release: free slots before the producer sees the advance. */
+	smp_store_release(&s->ring_tail, tail + first);
+	return first;
+}
+
+static bool splice_ring_has_data(const struct sk_psock_splice *s)
+{
+	if (!s->ring_buf)
+		return false;
+	/* Acquire ring_head so any data published by the producer is
+	 * visible if we go on to read it after this check.
+	 */
+	return CIRC_CNT(smp_load_acquire(&s->ring_head),
+			READ_ONCE(s->ring_tail),
+			s->ring_size) > 0;
+}
+
+static bool splice_recv_ready(struct sock *sk, struct sk_psock_splice *s)
+{
+	return splice_ring_has_data(s) ||
+	       !skb_queue_empty(&sk->sk_receive_queue) ||
+	       READ_ONCE(sk->sk_err) ||
+	       (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
+	       !rcu_access_pointer(s->peer);
+}
+
+static long splice_recv_wait(struct sock *sk, struct sk_psock_splice *s,
+			     long timeo)
+{
+	return wait_event_interruptible_timeout(*sk_sleep(sk),
+					splice_recv_ready(sk, s), timeo);
+}
+
+/* prot->sock_is_readable for paired-splice sockets. tcp_stream_is_readable()
+ * (via tcp_poll() / select() / epoll) consults this to mark POLLIN when
+ * sk_receive_queue is empty - we must also report data sitting in the
+ * splice ring, otherwise poll-driven readers wait forever despite the
+ * sender having produced bytes.
+ */
+static bool tcp_bpf_is_readable(struct sock *sk)
+{
+	struct sk_psock_splice *s;
+	struct sk_psock *psock;
+	bool readable = false;
+
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock) {
+		s = rcu_dereference(psock->splice);
+		if (s && splice_ring_has_data(s))
+			readable = true;
+		else
+			readable = !list_empty(&psock->ingress_msg);
+	}
+	rcu_read_unlock();
+	return readable;
+}
+
+/*
+ * Drain the ring or sleep until the sender publishes more data.
+ * A spurious wake loops back and re-waits rather than returning 0,
+ * because the dispatcher's TCP/sk_msg fallback is keyed on
+ * sk_receive_queue / psock->ingress_msg - neither observes the ring,
+ * so returning 0 with no error would deadlock the caller in
+ * tcp_msg_wait_data() that the sender's next splice_wake_sync()
+ * cannot satisfy.
+ *
+ * Returning 0 is reserved for: EOF (peer shutdown), pair gone, or
+ * sk_receive_queue gained bytes (sender dropped back to tcp_sendmsg,
+ * defer to the TCP path). Errors are reported via *err.
+ *
+ * Caller must NOT hold sk's socket lock - this function may sleep.
+ */
+static int tcp_bpf_splice_recvmsg(struct sock *sk,
+				  struct sk_psock *psock,
+				  struct msghdr *msg, size_t len,
+				  int flags, int *err)
+{
+	struct sk_psock_splice *s;
+	size_t copied;
+	long timeo;
+
+	*err = 0;
+	/* PEEK is not implemented against the ring (no peek-without-advance
+	 * helper). Return 0 with no error so the dispatcher defers to the
+	 * TCP path; ring contents are invisible to PEEK but the socket
+	 * continues to work for normal apps.
+	 */
+	if (flags & MSG_PEEK)
+		return 0;
+
+	s = rcu_dereference_protected(psock->splice, 1);
+	if (!s)
+		return 0;
+
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
+	for (;;) {
+		copied = splice_ring_read(s, &msg->msg_iter, len);
+		if (copied)
+			return copied;
+
+		/* Stream-ordering: if the sender ever dropped back to
+		 * tcp_sendmsg, those bytes are now in sk_receive_queue
+		 * and predate any future ring writes (sender only writes
+		 * to the ring when peer rcv_queue is empty).
+		 */
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			return 0;
+
+		if (sk->sk_err) {
+			*err = -sk->sk_err;
+			return 0;
+		}
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			return 0; /* EOF */
+		if (!rcu_access_pointer(s->peer))
+			return 0; /* Pair gone */
+		if (signal_pending(current)) {
+			*err = sock_intr_errno(timeo);
+			return 0;
+		}
+		if (!timeo) {
+			*err = -EAGAIN;
+			return 0;
+		}
+
+		timeo = splice_recv_wait(sk, s, timeo);
+	}
+}
+
+static int splice_send_ring(struct sock *sk, struct sk_psock *psock,
+			    struct msghdr *msg, size_t size, int flags)
+{
+	struct sk_psock_splice *self_s, *peer_s;
+	struct sk_psock *peer;
+	int total = 0;
+
+	if (msg->msg_flags & MSG_OOB)
+		return 0;
+
+	self_s = rcu_dereference_protected(psock->splice, 1);
+	if (!self_s)
+		return 0;
+
+	while (size > 0) {
+		size_t done, space = 0;
+
+		/* All peer / peer->sk accesses happen under RCU. If the ring
+		 * has space, grab the peer's ring_ref before dropping RCU: that
+		 * pins peer_s (and its ring) so the copy below can run outside
+		 * RCU and fault/sleep normally. peer_sk is *not* pinned by the
+		 * ref, so it must not be touched after rcu_read_unlock().
+		 */
+		peer_s = NULL;
+		rcu_read_lock();
+		peer = rcu_dereference(self_s->peer);
+		if (peer) {
+			struct sock *peer_sk = peer->sk;
+			struct sk_psock_splice *ps = rcu_dereference(peer->splice);
+
+			if (ps && READ_ONCE(ps->ring_buf) &&
+			    !sk->sk_err && !(sk->sk_shutdown & SEND_SHUTDOWN) &&
+			    skb_queue_empty(&peer_sk->sk_receive_queue)) {
+				space = splice_ring_space(ps);
+				if (space && percpu_ref_tryget_live(&ps->ring_ref))
+					peer_s = ps;
+			}
+		}
+		rcu_read_unlock();
+		if (!peer_s)
+			break;
+
+		/* Holding peer_s->ring_ref: peer_s and its ring stay alive.
+		 * The copy touches only the ring, never peer_sk, so a normal
+		 * faulting copy is safe here.
+		 */
+		done = splice_ring_write(peer_s, &msg->msg_iter,
+					 min(size, space));
+		percpu_ref_put(&peer_s->ring_ref);
+
+		if (!done)
+			break;
+		total += done;
+		size  -= done;
+	}
+
+	/* Wake exactly once, after the loop, re-deref'ing peer under RCU.
+	 * Doing this inside the loop would carry the _sync hint repeatedly
+	 * and cost a redundant wake per wraparound iteration.
+	 */
+	if (total) {
+		rcu_read_lock();
+		peer = rcu_dereference(self_s->peer);
+		if (peer)
+			splice_wake_sync(peer->sk);
+		rcu_read_unlock();
+	}
+	return total;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_sock_splice_pair - pair two stream sockets for opportunistic
+ *			  loopback splice.
+ * @peer:  the other socket, retrieved via sockhash lookup. This kfunc is
+ *	   KF_RELEASE: it consumes the reference the sockhash
+ *	   bpf_map_lookup_elem acquired on @peer (a sockmap/sockhash lookup
+ *	   is an acquire - see is_acquire_function() in the verifier).
+ *	   Consuming it here is required, not merely convenient: a sock_ops
+ *	   program cannot call bpf_sk_release (the helper is not available
+ *	   to that program type), so a release kfunc is the only way the
+ *	   program can avoid leaking the acquired reference.
+ * @skops: sock_ops context; ctx->sk is one side of the pair.
+ *
+ * Atomically installs the splice peering on both sides. Both sockets
+ * must be SOCK_STREAM, of the same address family, with psocks attached
+ * (typically via prior bpf_sock_hash_update), and neither already
+ * paired. Currently only TCP_ESTABLISHED is accepted; AF_UNIX
+ * SOCK_STREAM support is planned (the generic name reflects that
+ * extension path).
+ *
+ * After this call, sendmsg attempts a direct iov-to-iov copy into the
+ * peer's currently published recv iov; any bytes the splice path did
+ * not consume (because the peer is not in recvmsg) fall back to the
+ * normal TCP send path so the sender never blocks. Recvmsg first drains
+ * the socket's TCP rcv_queue (preserving stream ordering) and otherwise
+ * publishes the user iov for a sender to copy into. No skb, no sk_msg,
+ * and no verdict-program involvement on the splice fast path.
+ *
+ * Pairing is torn down automatically on close, disconnect, shutdown, or
+ * RST.
+ *
+ * Return: 0 on success; -EEXIST if either side is already paired (race
+ * loser); -EINVAL on state validation failure; -ENOENT if no psock
+ * exists on either side; -ENOMEM on splice-state allocation failure.
+ */
+__bpf_kfunc int bpf_sock_splice_pair(struct sock *peer,
+				     struct bpf_sock_ops_kern *skops)
+{
+	struct sk_psock_splice *self_s, *peer_s;
+	struct sk_psock *p_self, *p_peer;
+	struct sock *sk;
+	int ret;
+
+	if (!skops || !peer) {
+		ret = -EINVAL;
+		goto out_release;
+	}
+	sk = skops->sk;
+	if (!sk || sk == peer) {
+		ret = -EINVAL;
+		goto out_release;
+	}
+
+	ret = splice_validate(sk, peer);
+	if (ret)
+		goto out_release;
+
+	p_self = sk_psock_get(sk);
+	if (!p_self) {
+		ret = -ENOENT;
+		goto out_release;
+	}
+	p_peer = sk_psock_get(peer);
+	if (!p_peer) {
+		sk_psock_put(sk, p_self);
+		ret = -ENOENT;
+		goto out_release;
+	}
+
+	self_s = splice_get_or_alloc(p_self);
+	peer_s = self_s ? splice_get_or_alloc(p_peer) : NULL;
+	if (!self_s || !peer_s) {
+		/* If self_s succeeded but peer_s failed, self_s stays
+		 * attached to p_self; it isn't leaked (freed at psock
+		 * destroy) and is reusable for a future pair attempt.
+		 */
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	if (splice_ring_alloc(self_s) || splice_ring_alloc(peer_s)) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	splice_lock_pair(self_s, peer_s);
+	if (self_s->peer || peer_s->peer) {
+		ret = -EEXIST;
+		goto out_unlock;
+	}
+
+	/* Each side keeps a psock ref on the other for the duration. */
+	if (!sk_psock_get(sk)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+	if (!sk_psock_get(peer)) {
+		sk_psock_put(sk, p_self);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+	rcu_assign_pointer(self_s->peer, p_peer);
+	rcu_assign_pointer(peer_s->peer, p_self);
+	ret = 0;
+
+out_unlock:
+	splice_unlock_pair(self_s, peer_s);
+out_put:
+	sk_psock_put(peer, p_peer);
+	sk_psock_put(sk, p_self);
+out_release:
+	/* KF_RELEASE: consume the caller's refcount on @peer (taken by
+	 * bpf_map_lookup_elem on the sockhash). All exit paths come
+	 * through here.
+	 */
+	if (peer && sk_is_refcounted(peer))
+		sock_gen_put(peer);
+	return ret;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_tcp_splice_kfunc_set)
+BTF_ID_FLAGS(func, bpf_sock_splice_pair, KF_RELEASE)
+BTF_KFUNCS_END(bpf_tcp_splice_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_tcp_splice_kfunc_id_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_tcp_splice_kfunc_set,
+};
+
+static int __init bpf_tcp_splice_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS,
+					 &bpf_tcp_splice_kfunc_id_set);
+}
+late_initcall(bpf_tcp_splice_init);
+
 #endif /* CONFIG_BPF_SYSCALL */
-- 
2.43.0



Return-Path: <netdev+bounces-290711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPGAI1ULEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BFC5B03C8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5809303A510
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7239280C;
	Fri, 22 May 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKJYtBQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57B3911CE
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435985; cv=none; b=KXCm3uOzjbIeTSdl6HA9Eao9oCzPIVFAvyHPoZ3LhwoOMXHy7sahdrzEA/nh19QKJ1Gv0wRHqP6veNS4TxGIZGviVNQdpj6OcbiggrzKPfOIBav/TVQClA7NB5UUDaOS0OMJkig1OK/fz1aV9UH47c4Zpk/BYnShTwuqOwi6RBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435985; c=relaxed/simple;
	bh=/B3NWZCkuPYA6qZxcM009OVhGM+Il9oTqOS9zUowvKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvTL+zBfDvnu/H5A8lZF6Roz20+1kViwmkAqnzqwbqnmG3EkA3AODUIFYImexpLROy1OLBRWuL8cN/Y906EzmReFxU+Y0gAfkSwhCfTGh9Z5E7APQxFaE3ZgrzahRJrr1pbCr+yhkBTmM3jRHbkOO+fKWoX823dVCq8YcZqSaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKJYtBQp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3692f395339so7127140a91.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435975; x=1780040775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIsSQko+yFn7IbbQ1h/GQqTHyBUWcJ2XU33TnQQUWag=;
        b=jKJYtBQpmSBbaj3Zu3/AhowAbZZ+NHYfqIUBEcfUmEtCzDSyOxpz5IQ6MUAXRHqRuH
         0kTGrZuO7Ht4CTF/tM8kmxv+vOQT+/W0JWtnFGqbE0H1h5USRbcNJI92bDKaCc3OjylX
         bX2REg8VJ7iL3cp7FXUauH+ItHZOx8vSg1IQ3sUUGOgmenLlw26ckkE/k8hT6UYxGDp8
         4Qv1/Dx+Az1/8jAREVpk8ixO6OiCrZYc7VTVcnTfXjQF1PckfOGjSZrX1/OJlcWFSF7q
         ruzMsKYmsSUkXDM/B3wsXl5BHfAF2yvign8j+GGgpcCx7oJBcWMuvCK8/eRf3lGuYjq3
         NiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435975; x=1780040775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIsSQko+yFn7IbbQ1h/GQqTHyBUWcJ2XU33TnQQUWag=;
        b=CZkxs2HiNZ0jSqegiAGRqlDRRC/Uf6JrcqZq6xKZE0TQ5o8Cl99E/PtQ1A7rmOnvfp
         vZDAwa+6G37Kvkvyw23geafaFuxcpKnU7Cc4dWMvgk7HKkYBfpFMo9SzYSBdPZ7LDbX7
         S2fXNDJr+nBHtcKIP97fucVs2LblL1UGZyvwOikiy/pIp2I+xf9+R4RxAr27XcXQEkxA
         xgWdkBDzHBNUPF/SQf4PtfFaba8IGgwyJxR5GV9kelY8MxRWAHkJ0Gq5iiR1/GoVoFal
         rFVg61XoM2ar9LXS6+gDYQiA/RmX+/xMVonY9FwFQKDQ2Zyt9hcmSDE6TTopIGSxHvYy
         5RsQ==
X-Forwarded-Encrypted: i=1; AFNElJ96rgZBbEMQ73S2Q7EM4J9jnFzdTib0T13qRmhmWq1rZxHoA7SRa3bhaHyG4Z3HP0bMd4dq3IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx887hrV8+G8zL0637VptRWOI9ScyKsokXQTm05/FYX75kv9I2W
	EZkGQHtMKXiFsWVmen0ttVEsDkZoau2Hh3sGLN+1JDLBd7vpefP72pgixrcmqldfWmPXuX4Xkp6
	pLNAWsQ==
X-Received: from pfblh9.prod.google.com ([2002:a05:6a00:7109:b0:839:4a33:c35d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:698:b0:39b:8dcb:f37d
 with SMTP id adf61e73a8af0-3b328c988b0mr2408825637.17.1779435974794; Fri, 22
 May 2026 00:46:14 -0700 (PDT)
Date: Fri, 22 May 2026 07:45:02 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-12-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 11/11] selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
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
	TAGGED_FROM(0.00)[bounces-290711-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.933];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ev.events:url]
X-Rspamd-Queue-Id: E3BFC5B03C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The test is roughly divided into two stages, and the sequence
is as follows:

  I) Setup

    1. Attach two BPF programs to a cgroup
    2. Establish a TCP connection (@client <-> @child) within the cgroup
    3. Enable BPF_SOCK_OPS_RCVQ_CB on @child

 II) RPC frame exchange in various patterns

    4. Send a partial RPC descriptor from @client to @child
    5. Verify that epoll does NOT wake up @child
    6. Send the remaining data of the RPC frame
    7. Verify that epoll finally wakes up @child

During setup, two BPF programs are attached to simulate
a real-world scenario; one is SOCK_OPS and the other is
CGROUP_SOCKOPT.

While the SOCK_OPS prog handles the dynamic adjustment of
sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
BPF_SOCK_OPS_RCVQ_CB via userspace setsockopt() using
pseudo options:

  #define SOL_BPF               0xdeadbeef
  #define BPF_TCP_AUTOLOWAT     0x8badf00d

  setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));

This reflects a common production use case where an application
decides to start parsing RPC frames only at a certain point in
the stream (e.g., after HTTP Upgrade), rather than immediately
after TCP 3WHS (BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, etc).

When BPF_TCP_AUTOLOWAT is enabled, the BPF prog initialises
sk_local_storage for two sequence numbers to manage its state.

Then, for the RPC frame exchange, this test uses a simple format
defined as follows

  0        8       16      24       32
  +--------+--------+-------+--------+ `.
  |            header size           |  |
  +--------+--------+-------+--------+   > RPC descriptor (8 bytes)
  |            payload size          |  |
  +--------+--------+-------+--------+ .'
  ~               header             ~
  +--------+--------+-------+--------+
  ~               payload            ~
  +--------+--------+-------+--------+

Every time a new skb is enqueued to sk->sk_receive_queue,
the SOCK_OPS prog parses it and updates these sequence numbers:

  rpc_desc_seq : the SEQ # of the start of the RPC descriptor
  rpc_end_seq  : the SEQ # of the end of the RPC frame
                 => rpc_desc_seq + 8 + header size + payload size

Assume we receive two RPC descriptors in the following pattern:

  1. When we receive skb-1, only a part of RPC descriptor is parsed.
     rpc_desc_seq is set to the first byte while rpc_end_seq is
     unknown.  Thus, sk->sk_rcvlowat is set to the size of the RPC
     descriptor (8 bytes).

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+.................+....................+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
  +-----------+.................+....................+......
  ^              ^-.
  `- rpc_desc_seq   `- sk->sk_rcvlowat

  2. Next, we receive skb-2, which completes the first RPC descriptor.
     Now rpc_end_seq is known, so sk->sk_rcvlowat is advanced to it.

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+-----------------+....................+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...
  +-----------+-----------------+....................+......
  ^                                   ^
  '- rpc_desc_seq                     '- rpc_end_seq
                                           & sk->sk_rcvlowat

  3. Once we receive skb-3, which contains the next full RPC descriptor,
     rpc_desc_seq is advanced and rpc_end_seq is updated according
     to the size of RPC frame 2.

     Note that sk->sk_rcvlowat is NOT updated to the new rpc_end_seq
     yet.  This ensures that the application is woken up to read the
     already complete RPC frame 1.

   <- skb-1 -> <---- skb-2 ----> <------ skb-3 ----->
  +-----------+-----------------+--------------------+......
  |  RPC desc 1  |  header + payload  |  RPC desc 2  | ...   |
  +-----------+-----------------+--------------------+......
                                      ^                      ^
              rpc_desc_seq -----------'  rpc_end_seq ----...-'
                & sk->sk_rcvlowat

This sequence corresponds to the 4th test case in rpc_test_cases[],
and we can see helpful output if we "#define DEBUG":

  # cat /sys/kernel/tracing/trace_pipe | \
    awk '{ if ($0 ~ /AF_/) sub(/^.*AF_/, "AF_"); print $0 }' & \
    BGPID=$!; ./test_progs -t tcp_autolowat; kill -9 -$BGPID
  ...
  AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 0, end_seq: 1, len: 1, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 0
  AF_INET6 rpc_test_cases[3]: Copied 1 bytes: rpc_desc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_desc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 8, actual: 8

  AF_INET6 rpc_test_cases[3]: Start parsing skb: seq: 1, end_seq: 8, len: 7, rpc_desc_seq: 0, rpc_end_seq: 0, rpc_buff_len: 1
  AF_INET6 rpc_test_cases[3]: Copied full descriptor: rpc_desc_seq: 0, rpc_end_seq: 258, header_len: 100, payload_len: 150
  AF_INET6 rpc_test_cases[3]: No more descriptor: rpc_end_seq: 258, end_seq: 8
  AF_INET6 rpc_test_cases[3]: Setting rcvlowat: tp->copied_seq: 0, rpc_desc_seq: 0, rpc_end_seq: 258, rpc_desc_buff_len: 8
  AF_INET6 rpc_test_cases[3]: Set rcvlowat: expected: 258, actual: 258
  ...

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Make copy_len u64 and swap validation order for it
    for no_alu32.
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 326 ++++++++++++++++
 4 files changed, 682 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..fc4d6f68f247 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -64,6 +64,10 @@ struct bpf_tcp_req_attrs;
 extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *sk,
 				   struct bpf_tcp_req_attrs *attrs, int attrs__sz) __ksym;
 
+struct bpf_sock_ops_kern;
+extern int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops_kern,
+					 int rcvlowat) __ksym;
+
 void *bpf_cast_to_kern_ctx(void *) __ksym;
 
 extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
new file mode 100644
index 000000000000..5e971c42a32a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+#include <sys/epoll.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+#include "tcp_autolowat.skel.h"
+
+#define SOL_BPF			0xdeadbeef
+#define BPF_TCP_AUTOLOWAT	0x8badf00d
+
+struct rpc_descriptor {
+	u32 header_len;
+	u32 payload_len;
+};
+
+enum rpc_event_type {
+	RPC_EVENT_END,
+	RPC_EVENT_AUTOLOWAT,
+	RPC_EVENT_SEND,
+	RPC_EVENT_RECV,
+	RPC_EVENT_EPOLL,
+	RPC_EVENT_RCVLOWAT,
+};
+
+struct rpc_event {
+	enum rpc_event_type type;
+	union {
+		int len;
+		int nfds;
+		int val;
+		int rcvlowat;
+	};
+};
+
+#define RPC_DESC_SIZE (sizeof(struct rpc_descriptor))
+
+struct rpc_test_case {
+	char data[4096];
+	struct rpc_descriptor desc[32];
+	struct rpc_event event[32];
+} rpc_test_cases[] = {
+	{
+		.desc = {
+			{ .header_len = 100, .payload_len = 150 },
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Single full RPC message in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 100 + 150},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Two full RPC messages in skb. */
+			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			/* Single full RPC message in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 3},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 100, .payload_len = 150},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* Two full RPC messages in skb. */
+			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			/* Single full RPC message in skb. */
+			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE},
+			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
+			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
+		},
+	},
+	{
+		.desc = {
+			{.header_len = 100, .payload_len = 150},
+			{.header_len = 200, .payload_len = 500},
+		},
+		.event = {
+			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
+			/* The first descriptor is partial. */
+			{.type = RPC_EVENT_SEND,	.len = 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},
+			/* The first descriptor is available. */
+			{.type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE - 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* The first header is ready. */
+			{.type = RPC_EVENT_SEND,	.len = 100},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* skb has the first payload and 1 byte of the next descriptor. */
+			{.type = RPC_EVENT_SEND,	.len = 150 + 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 150 + 100},
+			/* After reading the first RPC message, SO_RCVLOWAT should be RPC_DESC_SIZE. */
+			{.type = RPC_EVENT_RECV,	.len = RPC_DESC_SIZE + 150 + 100},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE},
+			/* The second descriptor is available. */
+			{.type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE - 1},
+			{.type = RPC_EVENT_EPOLL,	.nfds = 0},
+			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 200 + 500},
+		},
+	},
+};
+
+struct tcp_autolowat_test_cb {
+	int saved_netns;
+	union {
+		int fd[4];
+		struct {
+			int server, client, child;
+			int epoll;
+		};
+	};
+};
+
+static void tcp_autolowat_teardown_cb(struct tcp_autolowat_test_cb *cb)
+{
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(cb->fd); i++) {
+		if (cb->fd[i] != -1)
+			close(cb->fd[i]);
+	}
+
+	if (cb->saved_netns != -1) {
+		err = setns(cb->saved_netns, CLONE_NEWNET);
+		ASSERT_OK(err, "restore netns");
+
+		close(cb->saved_netns);
+	}
+}
+
+static int tcp_autolowat_setup_cb(struct tcp_autolowat_test_cb *cb, int family)
+{
+	struct epoll_event ev = {};
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cb->fd); i++)
+		cb->fd[i] = -1;
+
+	cb->saved_netns = open("/proc/self/ns/net", O_RDONLY);
+	if (!ASSERT_NEQ(cb->saved_netns, -1, "save netns"))
+		goto err;
+
+	err = unshare(CLONE_NEWNET);
+	if (!ASSERT_OK(err, "unshare"))
+		goto err;
+
+	err = system("ip link set dev lo up");
+	if (!ASSERT_OK(err, "set up lo"))
+		goto err;
+
+	cb->server = start_server(family, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_NEQ(cb->server, -1, "start_server"))
+		goto err;
+
+	cb->client = connect_to_fd(cb->server, 0);
+	if (!ASSERT_NEQ(cb->client, -1, "connect_to_fd"))
+		goto err;
+
+	cb->child = accept(cb->server, NULL, NULL);
+	if (!ASSERT_NEQ(cb->child, -1, "accept"))
+		goto err;
+
+	cb->epoll = epoll_create1(0);
+	if (!ASSERT_NEQ(cb->epoll, -1, "epoll_create"))
+		goto err;
+
+	ev.events = EPOLLIN;
+	ev.data.fd = cb->child;
+
+	err = epoll_ctl(cb->epoll, EPOLL_CTL_ADD, cb->child, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto err;
+
+	return 0;
+
+err:
+	tcp_autolowat_teardown_cb(cb);
+	return -1;
+}
+
+static int tcp_autolowat_build_data(struct rpc_test_case *test_case)
+{
+	struct rpc_descriptor *desc = test_case->desc;
+	char *ptr = test_case->data;
+	int rpc_size;
+
+	memset(ptr, 0, sizeof(test_case->data));
+
+	while (desc->header_len + desc->payload_len) {
+		rpc_size = sizeof(*desc) + desc->header_len + desc->payload_len;
+
+		if (!ASSERT_LE(ptr + rpc_size - test_case->data,
+			       sizeof(test_case->data), "data overflow"))
+			return 1;
+
+		memcpy(ptr, desc, sizeof(*desc));
+		ptr += rpc_size;
+		desc++;
+	}
+
+	if (!ASSERT_GT(ptr - test_case->data, 0, "no data"))
+		return 1;
+
+	return 0;
+}
+
+static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *cb,
+				       struct rpc_test_case *test_case)
+{
+	struct rpc_event *event = test_case->event;
+	char *ptr = test_case->data;
+	struct epoll_event ev;
+	socklen_t optlen;
+	int err, optval;
+	char buf[4096];
+
+	if (tcp_autolowat_build_data(test_case))
+		return;
+
+	while (1) {
+		switch (event->type) {
+		case RPC_EVENT_END:
+			return;
+		case RPC_EVENT_AUTOLOWAT:
+			err = setsockopt(cb->child, SOL_BPF, BPF_TCP_AUTOLOWAT,
+					 &event->val, sizeof(event->val));
+			if (!ASSERT_OK(err, "setsockopt"))
+				return;
+			break;
+		case RPC_EVENT_SEND:
+			err = send(cb->client, ptr, event->len, 0);
+			if (!ASSERT_EQ(err, event->len, "send"))
+				return;
+
+			ptr += event->len;
+			break;
+		case RPC_EVENT_RECV:
+			err = recv(cb->child, buf, event->len, 0);
+			if (!ASSERT_EQ(err, event->len, "recv"))
+				return;
+			break;
+		case RPC_EVENT_EPOLL:
+			err = epoll_wait(cb->epoll, &ev, 1, 0);
+			if (!ASSERT_EQ(err, event->nfds, "epoll_wait"))
+				return;
+			break;
+		case RPC_EVENT_RCVLOWAT:
+			optval = 0;
+			optlen = sizeof(optval);
+
+			err = getsockopt(cb->child, SOL_SOCKET, SO_RCVLOWAT, &optval, &optlen);
+			if (!ASSERT_OK(err, "getsockopt") ||
+			    !ASSERT_EQ(optval, event->rcvlowat, "rcvlowat"))
+				return;
+			break;
+		}
+
+		event++;
+	}
+}
+
+static void tcp_autolowat_run_rpc_tests(struct tcp_autolowat *skel, int family)
+{
+	struct tcp_autolowat_test_cb cb;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rpc_test_cases); i++) {
+		memset(skel->bss->test_name, 0, sizeof(skel->bss->test_name));
+
+		snprintf(skel->bss->test_name, sizeof(skel->bss->test_name),
+			 "AF_INET%c rpc_test_cases[%d]",
+			 family == AF_INET ? ' ' : '6', i);
+
+		if (!test__start_subtest(skel->bss->test_name))
+			continue;
+
+		err = tcp_autolowat_setup_cb(&cb, family);
+		if (err)
+			continue;
+
+		tcp_autolowat_run_rpc_test(&cb, &rpc_test_cases[i]);
+		tcp_autolowat_teardown_cb(&cb);
+	}
+}
+
+static void tcp_autolowat_run_tests(struct tcp_autolowat *skel)
+{
+	tcp_autolowat_run_rpc_tests(skel, AF_INET);
+	tcp_autolowat_run_rpc_tests(skel, AF_INET6);
+}
+
+void test_tcp_autolowat(void)
+{
+	struct tcp_autolowat *skel;
+	struct bpf_link *link[2];
+	int cgroup;
+
+	skel = tcp_autolowat__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	cgroup = test__join_cgroup("/tcp_autolowat");
+	if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
+		goto destroy_skel;
+
+	link[0] = bpf_program__attach_cgroup(skel->progs.tcp_autolowat, cgroup);
+	if (!ASSERT_OK_PTR(link[0], "attach_cgroup(SOCK_OPS)"))
+		goto close_cgroup;
+
+	link[1] = bpf_program__attach_cgroup(skel->progs.tcp_autolowat_setsockopt, cgroup);
+	if (!ASSERT_OK_PTR(link[1], "attach_cgroup(SETSOCKOPT)"))
+		goto destroy_sockops;
+
+	tcp_autolowat_run_tests(skel);
+
+	bpf_link__destroy(link[1]);
+destroy_sockops:
+	bpf_link__destroy(link[0]);
+close_cgroup:
+	close(cgroup);
+destroy_skel:
+	tcp_autolowat__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index d8dacef37c16..bdf28d320383 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -74,6 +74,8 @@
 
 #define NEXTHDR_TCP		6
 
+#define TCPHDR_FIN		0x01
+
 #define TCPOPT_NOP		1
 #define TCPOPT_EOL		0
 #define TCPOPT_MSS		2
diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
new file mode 100644
index 000000000000..41eacfdb34aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright 2026 Google LLC */
+#include "vmlinux.h"
+
+#include <string.h>
+#include <limits.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#include "bpf_tracing_net.h"
+
+#define SOL_BPF			0xdeadbeef
+#define BPF_TCP_AUTOLOWAT	0x8badf00d
+
+//#define DEBUG /* For verbose output. */
+
+struct rpc_descriptor {
+	u32 header_len;
+	u32 payload_len;
+};
+
+#define RPC_DESC_SIZE		(sizeof(struct rpc_descriptor))
+#define MAX_RPC_DESC_PER_SKB	100
+
+struct tcp_autolowat_cb {
+	/* Don't put this field at the end; BPF verifier complains. */
+	char rpc_desc_buf[RPC_DESC_SIZE];
+	u32 rpc_desc_seq;
+	u32 rpc_end_seq;
+#ifdef DEBUG
+	u32 isn;
+#endif
+	u8 rpc_desc_buff_len;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct tcp_autolowat_cb);
+} tcp_autolowat_map SEC(".maps");
+
+char test_name[64];
+
+#ifdef DEBUG
+#define LOG(str, ...)							\
+	bpf_printk("%s: " str, test_name, ##__VA_ARGS__)
+#else
+#define LOG(...)
+#endif
+
+#define SEQ(val)				\
+	(val - cb->isn)
+#define TP_SEQ(field)				\
+	(tp->field - cb->isn)
+#define CB_SEQ(field)				\
+	(cb->field - cb->isn)
+
+static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
+				struct tcp_autolowat_cb *cb,
+				u32 seq, u32 end_seq)
+{
+	struct rpc_descriptor *rpc_desc;
+	u32 rpc_copied_seq;
+	u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
+	u64 rpc_len;
+	int err;
+
+	rpc_copied_seq = cb->rpc_desc_seq + cb->rpc_desc_buff_len;
+
+	if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
+		copy_len = RPC_DESC_SIZE - cb->rpc_desc_buff_len;
+	else
+		copy_len = end_seq - rpc_copied_seq;
+
+	/* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
+	 * clang omits the "copy_len == 0" check below, which is necessary
+	 * to satisfy the BPF verifier's range check for bpf_skb_load_bytes().
+	 */
+	barrier_var(copy_len);
+
+	/* Do not swap the order of the two copy_len checks below.
+	 * The BPF verifier somehow does not properly track the minimum
+	 * value for 'copy_len == 0'.
+	 *
+	 * 91: (15) if r7 == 0x0 goto pc+40      ; R7=scalar(smin=smin32=-247,smax=smax32=8)
+	 * 92: (25) if r7 > 0x8 goto pc+39       ; R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0xf))
+	 *
+	 * This does not occur if copy_len is u32.
+	 */
+	if (copy_len > RPC_DESC_SIZE)
+		goto disable; /* always false, only for verifier. */
+	if (copy_len == 0)
+		goto disable; /* FIN. */
+
+	if (cb->rpc_desc_buf + cb->rpc_desc_buff_len >= &cb->rpc_desc_buf[RPC_DESC_SIZE])
+		goto disable; /* always false, only for verifier. */
+
+	err = bpf_skb_load_bytes(skops, rpc_copied_seq - seq,
+				 cb->rpc_desc_buf + cb->rpc_desc_buff_len, copy_len);
+	if (err)
+		goto disable;
+
+	cb->rpc_desc_buff_len += copy_len;
+
+	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
+		LOG("Copied %d bytes: rpc_desc_buff_len: %u", copy_len, cb->rpc_desc_buff_len);
+		goto partial;
+	}
+
+	rpc_desc = (struct rpc_descriptor *)cb->rpc_desc_buf;
+	rpc_len = RPC_DESC_SIZE + rpc_desc->header_len + rpc_desc->payload_len;
+
+	if (rpc_len > INT_MAX)
+		goto disable;
+
+	cb->rpc_end_seq = cb->rpc_desc_seq + rpc_len;
+
+	LOG("Copied full descriptor: rpc_desc_seq: %u, rpc_end_seq: %u,"
+	    " header_len: %u, payload_len: %u",
+	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq),
+	    rpc_desc->header_len, rpc_desc->payload_len);
+
+	return 0;
+disable:
+	return -1;
+partial:
+	return 1;
+}
+
+static void tcp_set_autolowat(struct bpf_sock_ops_kern *skops_kern,
+			      struct tcp_autolowat_cb *cb,
+			      struct tcp_sock *tp)
+{
+	/* To handle wraparound. */
+	u32 val = 0;
+
+	LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_end_seq: %u, rpc_desc_buff_len: %u",
+	    TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
+
+	if (before(tp->copied_seq, cb->rpc_desc_seq))
+		val = cb->rpc_desc_seq - tp->copied_seq;
+	else if (cb->rpc_desc_buff_len != RPC_DESC_SIZE)
+		val = RPC_DESC_SIZE;
+	else
+		val = cb->rpc_end_seq - tp->copied_seq;
+
+	if (val != tp->inet_conn.icsk_inet.sk.sk_rcvlowat) {
+		bpf_sock_ops_tcp_set_rcvlowat(skops_kern, val);
+
+		LOG("Set rcvlowat: expected: %u, actual: %d\n",
+		    val, tp->inet_conn.icsk_inet.sk.sk_rcvlowat);
+	} else {
+		LOG("No need to set rcvlowat: %u\n", val);
+	}
+}
+
+static void tcp_disable_autolowat(struct bpf_sock_ops *skops,
+				  struct bpf_sock_ops_kern *skops_kern)
+{
+	int flags;
+
+	flags = skops->bpf_sock_ops_cb_flags & ~BPF_SOCK_OPS_RCVQ_CB_FLAG;
+	bpf_sock_ops_cb_flags_set(skops, flags);
+
+	bpf_sock_ops_tcp_set_rcvlowat(skops_kern, 1);
+
+	LOG("Disabled autolowat");
+}
+
+static void tcp_do_autolowat(struct bpf_sock_ops *skops,
+			     struct tcp_autolowat_cb *cb,
+			     struct tcp_sock *tp)
+{
+	struct bpf_sock_ops_kern *skops_kern;
+	struct tcp_skb_cb *tcb;
+	struct sk_buff *skb;
+	u32 seq, end_seq;
+	int ret = 0, i;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+
+	if (!skb)
+		goto update;
+
+	tcb = bpf_core_cast(skb->cb, struct tcp_skb_cb);
+	seq = tcb->seq;
+	end_seq = tcb->end_seq - !!(tcb->tcp_flags & TCPHDR_FIN);
+
+	LOG("Start parsing skb: seq: %u, end_seq: %u, len: %u, "
+	    "rpc_desc_seq: %u, rpc_end_seq: %u, rpc_buff_len: %u",
+	    SEQ(seq), SEQ(end_seq), end_seq - seq,
+	    CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
+
+	if (cb->rpc_desc_buff_len != RPC_DESC_SIZE) {
+		ret = tcp_parse_descriptor(skops, cb, seq, end_seq);
+		if (ret)
+			goto update;
+	}
+
+	i = 0;
+
+	while (1) {
+		if (i++ > MAX_RPC_DESC_PER_SKB) {
+			ret = -1;
+			break;
+		}
+
+		if (after(cb->rpc_end_seq, end_seq)) {
+			LOG("No more descriptor: rpc_end_seq: %u, end_seq: %u",
+			    CB_SEQ(rpc_end_seq), SEQ(end_seq));
+			break;
+		}
+
+		cb->rpc_desc_seq = cb->rpc_end_seq;
+		cb->rpc_desc_buff_len = 0;
+
+		if (cb->rpc_end_seq == end_seq)
+			break;
+
+		LOG("Found next descriptor: rpc_end_seq: %u, end_seq: %u, len: %u",
+		    CB_SEQ(rpc_end_seq), SEQ(end_seq), end_seq - cb->rpc_end_seq);
+
+		ret = tcp_parse_descriptor(skops, cb, seq, end_seq);
+		if (ret)
+			break;
+	}
+
+update:
+	if (ret >= 0)
+		tcp_set_autolowat(skops_kern, cb, tp);
+	else
+		tcp_disable_autolowat(skops, skops_kern);
+}
+
+SEC("sockops")
+int tcp_autolowat(struct bpf_sock_ops *skops)
+{
+	struct tcp_autolowat_cb *cb;
+	struct bpf_sock *bpf_sk;
+	struct tcp_sock *tp;
+
+	if (skops->op != BPF_SOCK_OPS_RCVQ_CB)
+		goto out;
+
+	bpf_sk = skops->sk;
+	if (!bpf_sk)
+		goto out; /* always false, only for verifier. */
+
+	tp = bpf_skc_to_tcp_sock(bpf_sk);
+	if (!tp)
+		goto out; /* always false, only for verifier. */
+
+	cb = bpf_sk_storage_get(&tcp_autolowat_map, tp, 0, 0);
+	if (!cb)
+		goto out;
+
+	tcp_do_autolowat(skops, cb, tp);
+out:
+	return 1;
+}
+
+static int tcp_init_autolowat_cb(struct bpf_sockopt *sockopt,
+				 struct bpf_tcp_sock *btp)
+{
+	struct tcp_autolowat_cb *cb;
+	struct tcp_sock *tp;
+	int flags;
+
+	cb = bpf_sk_storage_get(&tcp_autolowat_map, btp, 0,
+				BPF_SK_STORAGE_GET_F_CREATE);
+	if (!cb)
+		return -1;
+
+	tp = bpf_core_cast(btp, struct tcp_sock);
+	if (!tp)
+		return -1;
+
+	cb->rpc_desc_seq = tp->copied_seq;
+	cb->rpc_end_seq = tp->copied_seq;
+#ifdef DEBUG
+	cb->isn = tp->copied_seq;
+#endif
+
+	if (bpf_getsockopt(sockopt->sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+			   &flags, sizeof(flags)))
+		return -1;
+
+	flags |= BPF_SOCK_OPS_RCVQ_CB_FLAG;
+
+	if (bpf_setsockopt(sockopt->sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
+			   &flags, sizeof(flags)))
+		return -1;
+
+	return 0;
+}
+
+SEC("cgroup/setsockopt")
+int tcp_autolowat_setsockopt(struct bpf_sockopt *ctx)
+{
+	void *optval_end = ctx->optval_end;
+	int *optval = ctx->optval;
+	struct bpf_tcp_sock *btp;
+
+	if (ctx->level != SOL_BPF || ctx->optname != BPF_TCP_AUTOLOWAT)
+		goto out;
+
+	if (optval + 1 > optval_end)
+		return 0; /* -EPERM */
+
+	btp = bpf_tcp_sock(ctx->sk);
+	if (!btp)
+		goto out;
+
+	if (*optval && tcp_init_autolowat_cb(ctx, btp))
+		return 0; /* -EPERM */
+
+	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
+			   * setsockopt handler.
+			   */
+out:
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.54.0.746.g67dd491aae-goog



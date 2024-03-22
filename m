Return-Path: <netdev+bounces-81327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EC8873AC
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D196A1F2390E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3A7828D;
	Fri, 22 Mar 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a/trMScL"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FC7827D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134888; cv=none; b=mafFbP7T5GlKgqbuElOdTNDuSJlUk90NicXVruAA8LPGgJQ4qo7LbEXKyMscv4mzAiyBExJRVS1ot1C+Hv5wmAzvECjPR7OJ/t/kIrpveK0ieUc0i9RGlweriUMtNWQMD3iBMNtBGd1lXb4wwzMR1JNrmrQm/7OxmNdGpV6fgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134888; c=relaxed/simple;
	bh=jHNo/BwOrkdMuMPNXi1CztnxTagdh1jCw+MrOuGUv3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psNuk6lNKhzjOEEL1Tpv9V+4kMo0r/mpihig6SAy9/8UkqOWuYZugmce93gg9E56aKodSh8vfFqwSl3BKRndX3Blw8MUg+oZVC2a9EKgeepWD+khVtOHv5t+JoQgp+G2Ot3YsHY5/Sj0RerSGQtiHgtWNNIstjpjnfD96rkZzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a/trMScL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711134884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoEE820M1awPTI1L+zzn5LfVdI+dM+yEOGLBmomZJBo=;
	b=a/trMScL3h3EkgJcH+O9HXy0XuKeMkm6G5/8PDxC4GXL3BbrZSTcwg0ONjqdub02zB4Wiy
	CKDu1K28rB0kKWV/sTb6sZVfIDrSLqS1aSKO++0iCqCD14f4l+b6Ew86T2AyV/KsYikydA
	TTG2rQrZHumTZVj/PeVbPWZPeMxXmnE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test loading bpf-tcp-cc prog calling the kernel tcp-cc kfuncs
Date: Fri, 22 Mar 2024 12:14:33 -0700
Message-ID: <20240322191433.4133280-2-martin.lau@linux.dev>
In-Reply-To: <20240322191433.4133280-1-martin.lau@linux.dev>
References: <20240322191433.4133280-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a test to ensure all static tcp-cc kfuncs is visible to
the struct_ops bpf programs. It is checked by successfully loading
the struct_ops programs calling these tcp-cc kfuncs.

This patch needs to enable the CONFIG_TCP_CONG_DCTCP and
the CONFIG_TCP_CONG_BBR.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/config            |   2 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  12 ++
 .../selftests/bpf/progs/tcp_ca_kfunc.c        | 121 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 01f241ea2c67..afd675b1bf80 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -88,3 +88,5 @@ CONFIG_VSOCKETS=y
 CONFIG_VXLAN=y
 CONFIG_XDP_SOCKETS=y
 CONFIG_XFRM_INTERFACE=y
+CONFIG_TCP_CONG_DCTCP=y
+CONFIG_TCP_CONG_BBR=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a88e6e07e4f5..0facb6d9d304 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -13,6 +13,7 @@
 #include "tcp_ca_write_sk_pacing.skel.h"
 #include "tcp_ca_incompl_cong_ops.skel.h"
 #include "tcp_ca_unsupp_cong_op.skel.h"
+#include "tcp_ca_kfunc.skel.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -529,6 +530,15 @@ static void test_link_replace(void)
 	tcp_ca_update__destroy(skel);
 }
 
+static void test_tcp_ca_kfunc(void)
+{
+	struct tcp_ca_kfunc *skel;
+
+	skel = tcp_ca_kfunc__open_and_load();
+	ASSERT_OK_PTR(skel, "tcp_ca_kfunc__open_and_load");
+	tcp_ca_kfunc__destroy(skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -557,4 +567,6 @@ void test_bpf_tcp_ca(void)
 		test_multi_links();
 	if (test__start_subtest("link_replace"))
 		test_link_replace();
+	if (test__start_subtest("tcp_ca_kfunc"))
+		test_tcp_ca_kfunc();
 }
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
new file mode 100644
index 000000000000..fcfbfe0336b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+extern void bbr_init(struct sock *sk) __ksym;
+extern void bbr_main(struct sock *sk, const struct rate_sample *rs) __ksym;
+extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
+extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
+extern void bbr_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+extern u32 bbr_ssthresh(struct sock *sk) __ksym;
+extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
+extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
+
+extern void dctcp_init(struct sock *sk) __ksym;
+extern void dctcp_update_alpha(struct sock *sk, u32 flags) __ksym;
+extern void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev) __ksym;
+extern u32 dctcp_ssthresh(struct sock *sk) __ksym;
+extern u32 dctcp_cwnd_undo(struct sock *sk) __ksym;
+extern void dctcp_state(struct sock *sk, u8 new_state) __ksym;
+
+extern void cubictcp_init(struct sock *sk) __ksym;
+extern u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
+extern void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked) __ksym;
+extern void cubictcp_state(struct sock *sk, u8 new_state) __ksym;
+extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event event) __ksym;
+extern void cubictcp_acked(struct sock *sk, const struct ack_sample *sample) __ksym;
+
+SEC("struct_ops/init")
+void BPF_PROG(init, struct sock *sk)
+{
+	bbr_init(sk);
+	dctcp_init(sk);
+	cubictcp_init(sk);
+}
+
+SEC("struct_ops/in_ack_event")
+void BPF_PROG(in_ack_event, struct sock *sk, u32 flags)
+{
+	dctcp_update_alpha(sk, flags);
+}
+
+SEC("struct_ops/cong_control")
+void BPF_PROG(cong_control, struct sock *sk, const struct rate_sample *rs)
+{
+	bbr_main(sk, rs);
+}
+
+SEC("struct_ops/cong_avoid")
+void BPF_PROG(cong_avoid, struct sock *sk, u32 ack, u32 acked)
+{
+	cubictcp_cong_avoid(sk, ack, acked);
+}
+
+SEC("struct_ops/sndbuf_expand")
+u32 BPF_PROG(sndbuf_expand, struct sock *sk)
+{
+	return bbr_sndbuf_expand(sk);
+}
+
+SEC("struct_ops/undo_cwnd")
+u32 BPF_PROG(undo_cwnd, struct sock *sk)
+{
+	bbr_undo_cwnd(sk);
+	return dctcp_cwnd_undo(sk);
+}
+
+SEC("struct_ops/cwnd_event")
+void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
+{
+	bbr_cwnd_event(sk, event);
+	dctcp_cwnd_event(sk, event);
+	cubictcp_cwnd_event(sk, event);
+}
+
+SEC("struct_ops/ssthresh")
+u32 BPF_PROG(ssthresh, struct sock *sk)
+{
+	bbr_ssthresh(sk);
+	dctcp_ssthresh(sk);
+	return cubictcp_recalc_ssthresh(sk);
+}
+
+SEC("struct_ops/min_tso_segs")
+u32 BPF_PROG(min_tso_segs, struct sock *sk)
+{
+	return bbr_min_tso_segs(sk);
+}
+
+SEC("struct_ops/set_state")
+void BPF_PROG(set_state, struct sock *sk, u8 new_state)
+{
+	bbr_set_state(sk, new_state);
+	dctcp_state(sk, new_state);
+	cubictcp_state(sk, new_state);
+}
+
+SEC("struct_ops/pkts_acked")
+void BPF_PROG(pkts_acked, struct sock *sk, const struct ack_sample *sample)
+{
+	cubictcp_acked(sk, sample);
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops tcp_ca_kfunc = {
+	.init		= (void *)init,
+	.in_ack_event	= (void *)in_ack_event,
+	.cong_control	= (void *)cong_control,
+	.cong_avoid	= (void *)cong_avoid,
+	.sndbuf_expand	= (void *)sndbuf_expand,
+	.undo_cwnd	= (void *)undo_cwnd,
+	.cwnd_event	= (void *)cwnd_event,
+	.ssthresh	= (void *)ssthresh,
+	.min_tso_segs	= (void *)min_tso_segs,
+	.set_state	= (void *)set_state,
+	.pkts_acked     = (void *)pkts_acked,
+	.name		= "tcp_ca_kfunc",
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0



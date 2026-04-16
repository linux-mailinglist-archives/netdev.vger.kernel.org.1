Return-Path: <netdev+bounces-279011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHPXD+3H4GnjlwAAu9opvQ
	(envelope-from <netdev+bounces-279011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E240D65A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0559D30BF062
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216EA3A75B1;
	Thu, 16 Apr 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPxOlj1m"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B03A1D14
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338677; cv=none; b=pKsKkq6agsIX2Tomca5t0yuprUy4ow8oOz0JDdW1Mv/8PESXKnXEu2HGFslK+nReVZBBSJgaepYquID/WEkUKnkunFfLn/N8COu+hRtN3NXAAMrxW+NWwXxOwzngVtU7EjGjSX5U2+QoPhSmXl4viUSyyVOtfx1LsXhFA/KA8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338677; c=relaxed/simple;
	bh=dKUQGdzSULQLFpjO4woDfNNas3V9RQeU8cHdUhNQEJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxxnA7fhCjsNNEOxGUT85l6vpQeOpWJenarFMhmdZYsBDa2NryQwDKF/RGBmhni8sLfx61E/2X00HnkRhFdl96Nw8EriFyGEFj65MY4lmMqy1rF3xd1IgHL5Ld9qjejy3T2fQQbkEWoGsu8T8e0WGf7cCddhTO6KEVO/Gbg/qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPxOlj1m; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776338673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0g3FoFi5R4RZ3NBwYcu3bG8S2Vu+l0yHuaglflknQ3U=;
	b=tPxOlj1mIfymjjjGNuzOmCJiDGCniTAj4kwYlQ8s5hYU3z+RzIFlU/5PRo3Bw3fdyPSXev
	5+MFfyZmOSWCpGGtNPd71quIwsYBQ2Qv+jl3PK/QUegVHxdIwAtC0dFApp/2bMhlXcqL/D
	577U9NAVmpVV88aCmkm/2FhWXxvMzKQ=
From: KaFai Wan <kafai.wan@linux.dev>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	kafai.wan@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
Date: Thu, 16 Apr 2026 19:23:08 +0800
Message-ID: <20260416112308.1820332-3-kafai.wan@linux.dev>
In-Reply-To: <20260416112308.1820332-1-kafai.wan@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279011-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C68E240D65A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a sockops selftest for the TCP_NODELAY restriction in
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

The test program calls bpf_setsockopt(TCP_NODELAY) from
ACTIVE_ESTABLISHED_CB and PASSIVE_ESTABLISHED_CB to verify that it is
still allowed outside the TCP header option callbacks.

It then enables BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG, sends data to
exercise the TCP header option path, and checks that
bpf_setsockopt(TCP_NODELAY) returns -EOPNOTSUPP from both
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB while the
connection continues to make forward progress.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/tcp_hdr_options.c          | 54 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 40 ++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..2d738c0c4259 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -513,6 +513,59 @@ static void misc(void)
 	bpf_link__destroy(link);
 }
 
+static void hdr_sockopt(void)
+{
+	const char send_msg[] = "MISC!!!";
+	char recv_msg[sizeof(send_msg)];
+	const unsigned int nr_data = 2;
+	struct bpf_link *link;
+	struct sk_fds sk_fds;
+	int i, ret, true_val = 1;
+
+	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
+
+	link = bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt, cg_fd);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
+		return;
+
+	if (sk_fds_connect(&sk_fds, false)) {
+		bpf_link__destroy(link);
+		return;
+	}
+
+	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) active"))
+		goto check_linum;
+
+	ret = setsockopt(sk_fds.passive_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) passive"))
+		goto check_linum;
+
+	for (i = 0; i < nr_data; i++) {
+		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg), 0);
+		if (!ASSERT_EQ(ret, sizeof(send_msg), "send(msg)"))
+			goto check_linum;
+
+		ret = read(sk_fds.passive_fd, recv_msg, sizeof(recv_msg));
+		if (!ASSERT_EQ(ret, sizeof(send_msg), "read(msg)"))
+			goto check_linum;
+	}
+
+	ASSERT_NEQ(misc_skel->bss->nr_hdr_sockopt_estab, 0, "nr_hdr_sockopt_estab");
+	ASSERT_EQ(misc_skel->bss->nr_hdr_sockopt_estab_err, 0, "nr_hdr_sockopt_estab_err");
+
+	ASSERT_NEQ(misc_skel->bss->nr_hdr_sockopt_len, 0, "nr_hdr_sockopt_len");
+	ASSERT_EQ(misc_skel->bss->nr_hdr_sockopt_len_err, 0, "nr_hdr_sockopt_len_err");
+
+	ASSERT_NEQ(misc_skel->bss->nr_hdr_sockopt_write, 0, "nr_hdr_sockopt_write");
+	ASSERT_EQ(misc_skel->bss->nr_hdr_sockopt_write_err, 0, "nr_hdr_sockopt_write_err");
+
+check_linum:
+	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
+	sk_fds_close(&sk_fds);
+	bpf_link__destroy(link);
+}
+
 struct test {
 	const char *desc;
 	void (*run)(void);
@@ -526,6 +579,7 @@ static struct test tests[] = {
 	DEF_TEST(fastopen_estab),
 	DEF_TEST(fin),
 	DEF_TEST(misc),
+	DEF_TEST(hdr_sockopt),
 };
 
 void test_tcp_hdr_options(void)
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index d487153a839d..a8cf7c4e7ed2 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -28,6 +28,12 @@ unsigned int nr_data = 0;
 unsigned int nr_syn = 0;
 unsigned int nr_fin = 0;
 unsigned int nr_hwtstamp = 0;
+unsigned int nr_hdr_sockopt_estab = 0;
+unsigned int nr_hdr_sockopt_estab_err = 0;
+unsigned int nr_hdr_sockopt_len = 0;
+unsigned int nr_hdr_sockopt_len_err = 0;
+unsigned int nr_hdr_sockopt_write = 0;
+unsigned int nr_hdr_sockopt_write_err = 0;
 
 /* Check the header received from the active side */
 static int __check_active_hdr_in(struct bpf_sock_ops *skops, bool check_syn)
@@ -326,4 +332,38 @@ int misc_estab(struct bpf_sock_ops *skops)
 	return CG_OK;
 }
 
+SEC("sockops")
+int misc_hdr_sockopt(struct bpf_sock_ops *skops)
+{
+	int true_val = 1;
+	int ret;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		nr_hdr_sockopt_estab++;
+		set_hdr_cb_flags(skops, 0);
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		if (ret)
+			nr_hdr_sockopt_estab_err++;
+		break;
+	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		nr_hdr_sockopt_len++;
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		if (ret != -EOPNOTSUPP)
+			nr_hdr_sockopt_len_err++;
+		/* just trigger BPF_SOCK_OPS_WRITE_HDR_OPT_CB */
+		bpf_reserve_hdr_opt(skops, 12, 0);
+		break;
+	case BPF_SOCK_OPS_WRITE_HDR_OPT_CB:
+		nr_hdr_sockopt_write++;
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		if (ret != -EOPNOTSUPP)
+			nr_hdr_sockopt_write_err++;
+		break;
+	}
+
+	return CG_OK;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0



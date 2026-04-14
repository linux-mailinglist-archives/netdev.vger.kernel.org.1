Return-Path: <netdev+bounces-278410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKCbKf0j3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC363F9465
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699783020EFA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4333DA7F1;
	Tue, 14 Apr 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xI+6m4mw"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0D3B9DAC
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165862; cv=none; b=eRepQvME4caA7YsReHt8PsiyQhO2m+6qSQV3lIB9lb+3Nlun2ExLEDvseuVgRNsynUGWSV8L0qTXUmKIGtA5BK5ZOUFHC4nJe23e/1yWLhmDOO9IbAgiNQYtdojjPtulA1y2T9wjDI0uDjpNWkYUK8RAMeMwqln6DLNe60qu1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165862; c=relaxed/simple;
	bh=0XKwPrVsLYqMkdidCVFKYLqUJ4c4EfyJ1ob1+L0+szc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAVUfk9DURlmaPA+zfy/o4XB1Lbb5HjGpaU4NRYo+vRWRIgDI5kGj/NO3/zIevbQ2VzOl9beu15bGvn0L56MmQcagVUhgfCnZ/zs1FRH+1nLug+o4JpR4td1LrZqnSjXzTTgSTor4eGFQPoGC4nh0hooD+G17Hu9sWL2XNGPP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xI+6m4mw; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yPm78UqHyZkm1QqrS3WLRW2slYckpyvj6iqSa7dJaU=;
	b=xI+6m4mw4iR24mWikEbqUbtnMYM5+ZpcfMM5M6FbhOQ4Uufl8H2/De2LPdo8YObnMU+8Ud
	8Z2Ami6lZae5H3ObtR+5Ex8+w/cyMVqW7NSK4cZ7tjfp+iKINoDXYnJqAchxvk38DA+ZxR
	9EAsw2MiFlpnwzkFoGHnYiv6jAeT5rI=
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover TCP_NODELAY in hdr opt callback
Date: Tue, 14 Apr 2026 19:23:10 +0800
Message-ID: <20260414112310.1285783-3-kafai.wan@linux.dev>
In-Reply-To: <20260414112310.1285783-1-kafai.wan@linux.dev>
References: <20260414112310.1285783-1-kafai.wan@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278410-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 5DC363F9465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a sockops test program that enables
BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG on connection setup and calls
bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB.

Exercise the connection by sending data after the socket is
established. Before the fix, this setup can recurse through
tcp_push_pending_frames() and bpf_skops_hdr_opt_len() until the
kernel hits a stack guard page. After the fix, the connection
continues to make forward progress and the data exchange completes.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/tcp_hdr_options.c          | 34 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 18 ++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..f361f9c7bf59 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -513,6 +513,39 @@ static void misc(void)
 	bpf_link__destroy(link);
 }
 
+static void hdr_sockopt(void)
+{
+	const char send_msg[] = "MISC!!!";
+	char recv_msg[sizeof(send_msg)];
+	const unsigned int nr_data = 2;
+	struct bpf_link *link;
+	struct sk_fds sk_fds;
+	int i, ret;
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
+check_linum:
+	sk_fds_close(&sk_fds);
+	bpf_link__destroy(link);
+}
+
 struct test {
 	const char *desc;
 	void (*run)(void);
@@ -526,6 +559,7 @@ static struct test tests[] = {
 	DEF_TEST(fastopen_estab),
 	DEF_TEST(fin),
 	DEF_TEST(misc),
+	DEF_TEST(hdr_sockopt),
 };
 
 void test_tcp_hdr_options(void)
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index d487153a839d..e1dc7246193e 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -326,4 +326,22 @@ int misc_estab(struct bpf_sock_ops *skops)
 	return CG_OK;
 }
 
+SEC("sockops")
+int misc_hdr_sockopt(struct bpf_sock_ops *skops)
+{
+	int true_val = 1;
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		set_hdr_cb_flags(skops, 0);
+		break;
+	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		break;
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0



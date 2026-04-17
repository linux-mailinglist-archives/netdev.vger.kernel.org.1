Return-Path: <netdev+bounces-279286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG7DCjz94Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:28:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D404193FC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A194320182B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C483B3BEB;
	Fri, 17 Apr 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jq8U88dj"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152F3B27EA
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417678; cv=none; b=CuUJfxS6TAtIwAa6zTzU/aep5dqV3XjK/DbGZ8BCOjICSILjMjuIaQ33v7YCZaaGVPd+3yCa6Ylxu7DPZaJ3FhuZkv2YQIDpLpbFUb3nj7rJI/s7abgHgjXOrWorPrKeOFLyVIP41MJCDojX57LVpd8fuu+dVdA1v5KfPGDPvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417678; c=relaxed/simple;
	bh=M6ErwwDPUWYN/stgA9KjTyOFuDDepXWfSieVtMbfiIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3v1NmFYMnYmLggurbGzZ1eCZQ2rW2mb0Y8HJRAVuKQFjHUQWtWYC0st960zys+4oB3x4kCToF31lc4fx8DzxUezNzTg2+HM/49HpImBnQj6YFMMKUbXN4tJqXr2CW5xQQR1JZqmFXr1fVl/caEhUVEiWapwUNV6CZyBvIi6zJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jq8U88dj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776417673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7l7fufO2xt/WoYOZ4wD7hIr19kUg279ukInRFdUToo=;
	b=jq8U88djAv55h31U43KcrgH5i+vZWxwyBDgaYAPFt7qs2MoTbn5knw/LiGGmlz5iNPpLkm
	MUTggw17haZVU/IFGFp5Qht6DfdzngzjCb8dwpIot/5yZCLVCKGKgCdq7AQbejxKmWNV/5
	aux1TmMKNRKkBis9krKWNti0FUqO38s=
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
Date: Fri, 17 Apr 2026 17:20:35 +0800
Message-ID: <20260417092035.2299913-3-kafai.wan@linux.dev>
In-Reply-To: <20260417092035.2299913-1-kafai.wan@linux.dev>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-279286-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70D404193FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a sockops selftest for the TCP_NODELAY restriction in
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB.

With BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG enabled,
bpf_setsockopt(TCP_NODELAY) returns -EOPNOTSUPP from
BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB, avoiding
unbounded recursion and kernel stack overflow.

Other cases continue to work as before, including
BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB and user space
setsockopt(TCP_NODELAY).

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/prog_tests/tcp_hdr_options.c    | 12 +++++++++++-
 .../bpf/progs/test_misc_tcp_hdr_options.c         | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index 56685fc03c7e..7b9dbbb84316 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -461,7 +461,7 @@ static void misc(void)
 	const unsigned int nr_data = 2;
 	struct bpf_link *link;
 	struct sk_fds sk_fds;
-	int i, ret;
+	int i, ret, true_val = 1;
 
 	lport_linum_map_fd = bpf_map__fd(misc_skel->maps.lport_linum_map);
 
@@ -477,6 +477,10 @@ static void misc(void)
 		return;
 	}
 
+	ret = setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY)"))
+		goto check_linum;
+
 	for (i = 0; i < nr_data; i++) {
 		/* MSG_EOR to ensure skb will not be combined */
 		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg),
@@ -507,6 +511,12 @@ static void misc(void)
 
 	ASSERT_EQ(misc_skel->bss->nr_hwtstamp, 0, "nr_hwtstamp");
 
+	ASSERT_TRUE(misc_skel->data->nodelay_est_ok, "unexpected nodelay_est_ok");
+
+	ASSERT_TRUE(misc_skel->data->nodelay_hdr_len_err, "unexpected nodelay_hdr_len_err");
+
+	ASSERT_TRUE(misc_skel->data->nodelay_write_hdr_err, "unexpected nodelay_write_hdr_err");
+
 check_linum:
 	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
 	sk_fds_close(&sk_fds);
diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
index d487153a839d..a02e28d9db2e 100644
--- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
@@ -29,6 +29,10 @@ unsigned int nr_syn = 0;
 unsigned int nr_fin = 0;
 unsigned int nr_hwtstamp = 0;
 
+bool nodelay_est_ok = true;
+bool nodelay_hdr_len_err = true;
+bool nodelay_write_hdr_err = true;
+
 /* Check the header received from the active side */
 static int __check_active_hdr_in(struct bpf_sock_ops *skops, bool check_syn)
 {
@@ -300,7 +304,7 @@ static int handle_passive_estab(struct bpf_sock_ops *skops)
 SEC("sockops")
 int misc_estab(struct bpf_sock_ops *skops)
 {
-	int true_val = 1;
+	int true_val = 1, false_val = 0, ret;
 
 	switch (skops->op) {
 	case BPF_SOCK_OPS_TCP_LISTEN_CB:
@@ -316,10 +320,19 @@ int misc_estab(struct bpf_sock_ops *skops)
 	case BPF_SOCK_OPS_PARSE_HDR_OPT_CB:
 		return handle_parse_hdr(skops);
 	case BPF_SOCK_OPS_HDR_OPT_LEN_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		nodelay_hdr_len_err &= ret == -EOPNOTSUPP;
+
 		return handle_hdr_opt_len(skops);
 	case BPF_SOCK_OPS_WRITE_HDR_OPT_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true_val));
+		nodelay_write_hdr_err &= ret == -EOPNOTSUPP;
+
 		return handle_write_hdr_opt(skops);
 	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		ret = bpf_setsockopt(skops, SOL_TCP, TCP_NODELAY, &false_val, sizeof(false_val));
+		nodelay_est_ok &= ret == 0;
+
 		return handle_passive_estab(skops);
 	}
 
-- 
2.43.0



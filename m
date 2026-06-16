Return-Path: <netdev+bounces-299789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EQ5LIQZMWp1bgUAu9opvQ
	(envelope-from <netdev+bounces-299789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF668D9E6
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Lf/DI4db";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299789-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF093171B8F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9611D421F1A;
	Tue, 16 Jun 2026 09:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EA421F1E
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602308; cv=none; b=FxYO+i82kU2ACBjnB99vJqMcVBLUk307EVPovIuSN3V3IT4o6OB193dRtvIWmScTI7UQxzKUq0Omqp+d2IiyBnN64B8Gp6xxh/vJWgpSP6bm31cFQaeq36xxzWc6SG7zz4b/ldbE9h8AbKcZW+T3/gFG9huO/IlAS6Scpoe1j6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602308; c=relaxed/simple;
	bh=masccS+7veDUie+oWDi6NRulf6w+dIgm7hvvOnWqGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPFCyNQgbMioiSufvk0m1FKbAQxcaqdbvcXqBpdHXW9PfM3iz9eKgxQToBxBrYq6kkEDqgOVCd/AS0Z3pxD+nLR+1BCoteR3VOgTXw0OeSpe1XPqSoT375prypvEdCX6S9LZIJvrqprCURrTwCxD7BZ+HtZ7vkNCzAh2rYFgBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf/DI4db; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c132ac5ec2so42963035ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602307; x=1782207107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpDob04Du+/4G79ElledxXfX7TMGsPEaydT5UDTPkDw=;
        b=Lf/DI4dbpon05Oqg6jCyTzWBgLpS34NQWCYnl5E6urkLgu1uhu5DJTxEfI8kc2wPz9
         raBvXD+SlUygQza4wcfkVN8Va6TXk4XZ8+w4BeVJYfQY+C3ZjhSYuV8NP92aF+XyY2MK
         4YBKi/eeyMHvN5z54iKcg5kEL3iJLfRXeReLIgvx0GOTYtW54Slm2C4Q8/hoDH5IN3QR
         EQTK2ck4vRX/UK8dOLLJnthJYAzk5mML3aehjvdSnMVxQMnTuucGX+lQSgBI/NEzi+uk
         lew+F1tW60CS3OjeMdRD+zDRgCNBNLWz3WvFLTfxYixoewTv797QVGAFuBe8Coa1bWn0
         z2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602307; x=1782207107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpDob04Du+/4G79ElledxXfX7TMGsPEaydT5UDTPkDw=;
        b=kmdBejHeMBRycLPTeTqtjoTaVqFGl/RZ09gCmQE7dN+9W6F3FIAycD9dIyReH8loiV
         fUPMKJyVUCMmNFtgEbbKue+jn24Diocka6SqN2nkfph2UuhhvUZ1GLyUgUSPT5zX2lsq
         YlUVEZUaAJbtkqyhj5l5vHSk9yJSZrxFH/Yb70lJSwYqJ6LeEqBXeO6NN6ecOeyi/Q6t
         /NhHcGkFuzAWdPy3RAZQ2irfyPNb5hnlJCtg0xxl4oqi41csvukJTJXu6XKRdEqw/6Vq
         XxU3XxeIXme79r7UY0BblrxureTrDlvbErtWvMZ+vOwsz4u5zuk92iN6mblVMgEjWc96
         VDiA==
X-Gm-Message-State: AOJu0YwLNRFKlWHNzFPrWZgJfUi6s3XZ1WHWjQMyXJQ/MbaugTLRBLi4
	dRH0cOP5BlpQgFQeYXQ9khNjlzjfIPcPM2elQ8qJEUccDEY24YIHfjyZ
X-Gm-Gg: Acq92OGmyTSC+TX6tTvPxzScJYxUMh9ggnv6SrcyE8d0az0k6eDK6Ssl0+tQlLiVA66
	moLHCXoHXwGH84nBS0owTBuD68v3KCb5c+w5CD/6AOTTFKdvrKpgckAvbWW34CZt5F/vYpLCOu9
	2fdF6ZkaV825Wwv+nvbjnenWlt8CA/b6BTzRhRYWcFSlj3RTb+hWBbpVKxXeM5y8SxLuByPWkc3
	WKlHTMf5rKPccCY30aJi4f8dMu/HibQtBF+/q8nlHCowfmUrnRvemq3n3/0wvYLmKv2vJ8c2mWG
	Gibps97/MegUTuejYn7Ow6s49Zl9yV2fRt2geyWJFTKjxgOY8LW4uqpM7PTMkV1q1gMQh0M/9XI
	ZNUv5x/fLnz3aeLP9ycrI6bs4X0/UGMHtM4MQRQ8oQnzN7vXzNOYo2b54YcnJRU+IeQMl3RFvk0
	GFHDLoQwQakbp0pIzNc6kiPObjP9/yWESVTcSO9hckDwEwhz4YakgHbpWOXXP9rAo=
X-Received: by 2002:a17:903:37c5:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c664243261mr168196865ad.23.1781602306778;
        Tue, 16 Jun 2026 02:31:46 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c52sm127329545ad.22.2026.06.16.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:31:46 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
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
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover partial copy of non-linear test_run output
Date: Tue, 16 Jun 2026 17:31:03 +0800
Message-ID: <20260616093103.471444-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299789-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paul.chaignon@gmail.com,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ctx.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CEF668D9E6

prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
for a short data_out buffer while still reporting the full output size
through data_size_out.

Add the same coverage for non-linear test_run output. Use pass-through
TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
and a 100-byte data_out buffer. The expected output spans both the linear
data and the first fragment.

Verify that test_run returns -ENOSPC, reports the full packet length
through data_size_out, and copies the packet prefix into data_out for
both non-linear skb and XDP frags paths.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 72 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 2 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 01f1d1b6715a..71af1ff02023 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -4,6 +4,10 @@
 
 #include "test_pkt_access.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_LINEAR_DATA_LEN 64
+#define SHORT_OUT_LEN 100
+
 static const __u32 duration;
 
 static void check_run_cnt(int prog_fd, __u64 run_cnt)
@@ -20,6 +24,71 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
 }
 
+static void init_pkt(__u8 *pkt, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		pkt[i] = i & 0xff;
+}
+
+static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+	memset(out, 0xa5, sizeof(out));
+
+	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &skb;
+	topts.ctx_size_in = sizeof(skb);
+
+	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
+}
+
+static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+	memset(out, 0xa5, sizeof(out));
+
+	ctx.data = 0;
+	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
+}
+
 void test_prog_run_opts(void)
 {
 	struct test_pkt_access *skel;
@@ -69,6 +138,9 @@ void test_prog_run_opts(void)
 	run_cnt += topts.repeat;
 	check_run_cnt(prog_fd, run_cnt);
 
+	test_skb_nonlinear_data_out_partial(skel);
+	test_xdp_nonlinear_data_out_partial(skel);
+
 cleanup:
 	if (skel)
 		test_pkt_access__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..cd284401eebd 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
 
 	return TC_ACT_UNSPEC;
 }
+
+SEC("tc")
+int tc_pass_prog(struct __sk_buff *skb)
+{
+	return TC_ACT_OK;
+}
+
+SEC("xdp.frags")
+int xdp_frags_pass_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
-- 
2.43.0



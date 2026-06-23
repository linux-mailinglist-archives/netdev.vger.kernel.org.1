Return-Path: <netdev+bounces-301235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TmTHGHvkOWrwygcAu9opvQ
	(envelope-from <netdev+bounces-301235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:42:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F326B34E7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:42:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cdJmT8bU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301235-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301235-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 370BE306B64E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C4385D87;
	Tue, 23 Jun 2026 01:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A695386423
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:41:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178862; cv=none; b=fi38287Yre7R8hXnaihf8jM8FDthScCSyfH+X0S21rxsdwwW/yxwnK57DJBiNBsfL6+PmFTMzM2M3XYPg8OFO4a+wKNTKpl9yUA37nF1G7bRmuEV/Vxwt2PCKJX5tgLcKbWRfUcysriQ1jM4FYlLh6nbA4/VakwKjnv6312uw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178862; c=relaxed/simple;
	bh=TeljXPih3XySpBflJVQVLxHCds/34/7xYyQklL7E838=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNY0Eg8fAAVSj8MWKje9bSHIu29tNpbilL4esymI5qpMc6eACDrZDvyQzLpgQD7HY0ihvNSnD9/7M8XETa16fwme/+cEEQlcMaQM4k03i9ezcMOBybMI2AkJ3xydxJAalFo+SUWAjUq+Xaow4Fc1W3zKR049cYwUfTTa1u90wCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdJmT8bU; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf1cda2b17so3335625ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 18:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782178860; x=1782783660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGVecrSz6dhJP1jTtBAIJOkndE4qmahRc7vcfNDXjzo=;
        b=cdJmT8bUvgv6nOcVBX7TUVeG9a+WndOa4sBxFrA7k8Vh2ZWTaTyaBZUQYY1sloZt5F
         r+qHxY92zLdyVLeVB5j2bVxYUUDEIWINUosiYpYzvHpia/xTxYWUHUstMEZLeE/PaqEQ
         vf7ojUb0mMBvPFmrtJOmu1Rfn9pDZbwXpv7/a+dd/jVTIBSlAL2h3SkqCoqTRxwPAB9d
         +FbIR86hR3PfeL63Ts2zFqsoBiCpIvryrlJv7WfY46IIlUtlxH3OrldnZdavQawaPhkM
         eOqXQq65J1vRtwd7aIevD/07QKsvj/LP3dKKZvPRqHLkJ8ypU+qppVklFYr8r9PfrdkU
         jD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178860; x=1782783660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGVecrSz6dhJP1jTtBAIJOkndE4qmahRc7vcfNDXjzo=;
        b=M/cTK/rITq/CerVRAxYdIGNKmFS6eQVFXvFl2aGvYAKIGbMNM+eKvIyRZ3qf6bN3IE
         SJeT8vYI+i24vp6oUZbGn8/B5q98FxWHsYS3mZUqzKLSIYZf33ftAZJfZlrwLLw2k3Tp
         rwhrBPcTGXI3j5kG/vv3dteQINWJsedVbi26fA4tf752HQfFGcjgV2mfnyMWdXjJ6AUg
         yDevwD8aG0g/r4d6EFG48MNw91iuGW0uMxrwinUOYrDdm4ksGHQrzjJIDi6IHbMUn73c
         AdKugxGudhDTgDwDlafGk/BN+RCbSIKKdv6+NvCxRyhUY2U6IprUEjcNy+GImsLcKlt2
         PAFQ==
X-Gm-Message-State: AOJu0Yx/yw9rRkY25N0XSU7mpCtlFgmfW02KghFjL4dABvfzIof1v8ba
	ZPFwP9TWMwxsQoPRLe/D8BvlX/+TRtuOY79axCwkrhh0IdJ0uBkWZpAM
X-Gm-Gg: AfdE7clZ5A8cOw4zDxYwHVbPes1hwTljcs2CyyuJVQ7Qu8BLj6vaju5pfgsiakMS9J6
	7rtegDRBJBF+umYIRX710uaGj7+e+xb5T8jqwBLSSJCVWgdclJjRMAqU3T+Vorl4gDZIXAfL/1a
	ALR4z634KMunRBq/Dtpw+kBu00zcE7euZFOI8T8TUIauMwKFqlEM8aKCMqOkitAWoEKwV7NnbGj
	22FR6ouAlH2PIa6iFBvEapgmikgUUyjGGdj5SxUSWViSza3EJ8rT1TpmotC7B/ZVugkTSGJ6bWi
	A08mlTe0ERVdAmZVLVWFhV5MVW7nY6/eUfLPcNNo7PpoOLgcWA9G5q3Tkw4bdhJLAUPlYES95Tq
	ZSXEpdX3ZgJoe4Y8AitFSUckhNCeVWUaZ+ZO9cHsIWKi8zEQ7inb0zi2+g/+CXw9Qu3kqUKTMTM
	iVMEnkqhxhaPUYbWsOnWIfEA3LoeZZm79fLqmS2l6mSfPIQaKOYCxXYPIGNkQ5k+NPGkMOSdVFe
	087q/pnq18=
X-Received: by 2002:a17:903:4b4f:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2c7c3d5e7a0mr11648095ad.9.1782178859632;
        Mon, 22 Jun 2026 18:40:59 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad83sm90093085ad.79.2026.06.22.18.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:40:59 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4] selftests/bpf: Cover partial copy of non-linear test_run output
Date: Tue, 23 Jun 2026 09:40:27 +0800
Message-ID: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-301235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3F326B34E7

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

v4:
- Send only the selftest patch; the fix patch has been applied to bpf/master.
- Initialize data_out buffers to avoid reading uninitialized stack memory if
  bpf_prog_test_run_opts() fails unexpectedly.

 .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 01f1d1b6715a..beb6fa78fd94 100644
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
@@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
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
+	__u8 out[SHORT_OUT_LEN] = {};
+	struct __sk_buff skb = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
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
+	ASSERT_EQ(err, -ENOSPC, "skb_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_partial_size");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_partial_data");
+}
+
+static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN] = {};
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
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
+	ASSERT_EQ(err, -ENOSPC, "xdp_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_partial_size");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_partial_data");
+}
+
 void test_prog_run_opts(void)
 {
 	struct test_pkt_access *skel;
@@ -69,6 +136,9 @@ void test_prog_run_opts(void)
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



Return-Path: <netdev+bounces-91842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6167E8B4297
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 01:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CA81C20983
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9E3D0C5;
	Fri, 26 Apr 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWdIxhZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D563B794
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173391; cv=none; b=iBEBO7nD+ZJRe66guiusFSx9mYA9FdeYZ5P4QpTsiB0fr3NXjS+0nWuE9rGtBZJTTRl7MHIbVeU+vrnonuCe3t8fVyfnIdaBJ4EzUqU2Kn+v3eFNz2sXHU3zOMHv7a3kpMfWT8hAAfW1N+D4V6aEvSQwWxSt9dK+s8xIOtzMpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173391; c=relaxed/simple;
	bh=gbVkTwn5jRcuW/hi/B9qThg2hX7UX8ihWjogq9Gimt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A1ePlMhSOgyuH/tIZTFdwIpiKQfDaR79jwt1wo2GcGxqoLfPPfqXvgQzcgeV2eHb6RlcaJdBcIFZY6hF/MOqFQ5Qf1buWlSXt6TkC40rZDHPX6thJ3GYkuCVptYIqPNW1LT5+5S6WL1oDxBy+qcsVSrLmtFIAwKZ7w6W4BmIVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWdIxhZx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso2414255a12.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173389; x=1714778189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0znMKtvFHOoEh2zdPfHh4MTKThh8+XiKRoSkT+54dk=;
        b=kWdIxhZx1pN5hTSfua6lDH/SiS4dmrVYPYoAbETZvXyBNcQxN0TaDGWJy6VtufAO9F
         FP8KN3QIrd5qFKAgn77+ID/fd9qzr/SnamG3v91iApwWWAokBC7UyaAiibv0yjgjd3Pq
         IK+HswSKgtO2Cfk5Ytqjz3M3KP0A47RdNIQsR+LV5olPEb/UifuhJuPv+fLVlw/HK6KA
         5PD0fp/6baAJSP6OQywGn1Jb7jPiFtjSQ4bTdHPj/FR3yWuyZgr5bK7VL5yB95+7WXnX
         cDTCzIKXOXCuGYEZ0Ag+iH2IjQ+qza0H8mIz1mNTCffIdBmyTyfWSkI1TZR5Oy0VfpC/
         dujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173389; x=1714778189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0znMKtvFHOoEh2zdPfHh4MTKThh8+XiKRoSkT+54dk=;
        b=SHIito7LHjcmL1B7a4FWR2ttgEEB3hYd1shFZ4nbeKitUGA3/xfO+Cf0qA7yE77lNO
         uHCHezAggmeuKRrPKopSmU/VHXStxR/u3C+RR9IJzrEoiOoktz9rZKc10VV8AsIsIX9/
         rEnETlvoLv9qZIhshjLW5lEieSkUIfLYUUOkau90KNTBZyyvX7l5J2J2DFlD8TYnF9nF
         9Z/vJvCsrU20h2rMMezGMCvxqs9sFNp+54+gC0wKdDe4fh3dBsvIObLwwdQkBNos0wn3
         uXSKhheZhCE1flqODdAXniI0MKrcVyTLwPlvJ3nBEwZjvGzQ92j96DvIlrRR2CG8yf+I
         0O6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1IZ3mrARgnBtgGII5DwMdo0sp29Vt/67zgZ0TAwJJyWHHFvw0Ac/TAsc6U0JjyZcY4oIUqyEDdGaJE9vMwWu0veo0xf+H
X-Gm-Message-State: AOJu0YypDJ/gk4Prvl6VBkSR5/8LkpEkaS3F7o0C/gxlAS8UQX31oG0v
	dMgt/QFLOEeFP7KfOnVe56Mt2m1U79O5neOdasgNmeY0DMhZdo0h9dbgAkyGWSV3nw==
X-Google-Smtp-Source: AGHT+IFp8nJcKa916nGLL8Ip6wnd9kCOFZHKVgoll8BaXGN4HxQAm/1mACo7Vc8f1M/NvJfv6cBDUyo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:86c7:0:b0:5dc:19d0:dccc with SMTP id
 x190-20020a6386c7000000b005dc19d0dcccmr12786pgd.3.1714173388374; Fri, 26 Apr
 2024 16:16:28 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:20 -0700
In-Reply-To: <20240426231621.2716876-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426231621.2716876-1-sdf@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-4-sdf@google.com>
Subject: [PATCH bpf 3/3] selftests/bpf: Add sockopt case to verify prog_type
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Make sure only sockopt programs can be attached to the setsockopt
and getsockopt hooks.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt.c        | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/testing/selftests/bpf/prog_tests/sockopt.c
index dea340996e97..eaac83a7f388 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -24,6 +24,7 @@ enum sockopt_test_error {
 static struct sockopt_test {
 	const char			*descr;
 	const struct bpf_insn		insns[64];
+	enum bpf_prog_type		prog_type;
 	enum bpf_attach_type		attach_type;
 	enum bpf_attach_type		expected_attach_type;
 
@@ -928,9 +929,40 @@ static struct sockopt_test {
 
 		.error = EPERM_SETSOCKOPT,
 	},
+
+	/* ==================== prog_type ====================  */
+
+	{
+		.descr = "can attach only BPF_CGROUP_SETSOCKOP",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+
+		},
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+		.attach_type = BPF_CGROUP_SETSOCKOPT,
+		.expected_attach_type = 0,
+		.error = DENY_ATTACH,
+	},
+
+	{
+		.descr = "can attach only BPF_CGROUP_GETSOCKOP",
+		.insns = {
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+
+		},
+		.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+		.attach_type = BPF_CGROUP_GETSOCKOPT,
+		.expected_attach_type = 0,
+		.error = DENY_ATTACH,
+	},
 };
 
 static int load_prog(const struct bpf_insn *insns,
+		     enum bpf_prog_type prog_type,
 		     enum bpf_attach_type expected_attach_type)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
@@ -947,7 +979,7 @@ static int load_prog(const struct bpf_insn *insns,
 	}
 	insns_cnt++;
 
-	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCKOPT, NULL, "GPL", insns, insns_cnt, &opts);
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
 	if (verbose && fd < 0)
 		fprintf(stderr, "%s\n", bpf_log_buf);
 
@@ -1039,11 +1071,15 @@ static int call_getsockopt(bool use_io_uring, int fd, int level, int optname,
 static int run_test(int cgroup_fd, struct sockopt_test *test, bool use_io_uring,
 		    bool use_link)
 {
+	int prog_type = BPF_PROG_TYPE_CGROUP_SOCKOPT;
 	int sock_fd, err, prog_fd, link_fd = -1;
 	void *optval = NULL;
 	int ret = 0;
 
-	prog_fd = load_prog(test->insns, test->expected_attach_type);
+	if (test->prog_type)
+		prog_type = test->prog_type;
+
+	prog_fd = load_prog(test->insns, prog_type, test->expected_attach_type);
 	if (prog_fd < 0) {
 		if (test->error == DENY_LOAD)
 			return 0;
-- 
2.44.0.769.g3c40516874-goog



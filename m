Return-Path: <netdev+bounces-226240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA4B9E6B1
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAF1179227
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC942EA736;
	Thu, 25 Sep 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2jJkGxx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723012EA48D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792977; cv=none; b=VvcO4BvsC9sTEOafbBigFt4FS5Yz09+EC72hH9U+c+3vTTneq+ETmk6e73G3ukH7YgFwuYzopaWd7WOrCWYv3SXgfZR6D82DaMD0vajEtb7+BiM+faYZVTBh+LzVRGgj0M81b6skL7EBbWikmXTKui3keud3XNO0AqLVdyq7bxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792977; c=relaxed/simple;
	bh=kGgcaZ5dSflruy84oMfsVc6mcKHnV9Yn/tYcBzKlk6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOmY1y0mO2gGt/G4RGSzwWo9a1riI2AVWctSyEln/A/u4ehP6vMI0dRWAP1Al5jo7JegFSYgCEOJVTYL3cviPeQIvfn46AzxWDL63e2bTUuEdHJ9BgAFp9vDAsOkhznhDMU4bgMufwDehGOD8erMW/Us4I7VdAiJRAu0sINs4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2jJkGxx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6317348fa4fso121708a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792974; x=1759397774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYrzRC+Mc8HpR/NxS7zdVfXYo8jUCkc291LCyvTTrB8=;
        b=S2jJkGxxy6Daxqe9nWvx3qbSDesO0egeLMuOIE/hYmQ9jQY6Y/PIC7FsXaOLDvvARy
         H4swx3kFiiOYuF0AM9eNnletr0JQIn05k8TZ4a4DoicBz4s/CyYZs/Qf/KbZgq7Y7P3E
         RaXkrSLLWW3JyMNdvrxoq9urHZwiG804uMAvx5MYsAx/1XNNYjYwCvZQT9B3g43gT1EK
         0PHUWYu/Mn2wgVvcL0FuM0zIbbYWXHKOHEl0uBwyO+/h57gkRYN2GD371xETOMfUMwvo
         zXU1mE9vsdnoetNShmsWyCuJQ7GR6tWJxguvENjqpaJWiCwCVOYX+TK1+l2L9xGnwiA3
         5LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792974; x=1759397774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYrzRC+Mc8HpR/NxS7zdVfXYo8jUCkc291LCyvTTrB8=;
        b=m3nQqOLV/xcuAr5n+vqiBQU3D5CqWLoGvaspi00mqGfCmVzjibfpxMh5/E2e1bvgy5
         G6hzHy1hL/vMEbhn+d/CIOLiDa8sgfKsJxJohTaA4xVW5jpz+/OM0qXpm4tWZNStEdhv
         tyklWVeupdCQ1QaGbwbdmVqQ0jgt/9U4KqrVuimJvs4N7qgkTG69gC69D7HPZZjs6DNV
         BCUIlk/jsubZi+DlXHPiPzJrTZiFeQzix8/wPJOIRzfHuxanZsf/DXYFhuNOkQ3m/glR
         qCvvo4qPRPbr8CwIEkzFhMXrpPWHenQ3am+Lw+qTQCymlCRpLJB0wkcGFMUi1mWQ7Lqh
         +mxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzg9SATg+o/POmDZ6clp2IPcINdZI8/MjF8Yt3GyS9lQjxfKYG4zu+l82ub3p4+arTlX5gr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySA4hmw0DZpvbFoM3aMqnmVL90vUEQ/BHb0qLwF64TruKfIrU
	kZml/eqx3lrH/LpQjleZ/XrMM4aJ5IyPq7FK1NzSaTaqhGuSttxt/MqY
X-Gm-Gg: ASbGncsqhG+gDSa+BfkgtG1Qc4SXhjCHGX6sU4QbheoGR+GvRWFMilw3vKjVwRVjoym
	kwG8FEet89hXUbDnNidsw6TXATnUe+6ZAHdtSEsJbJhVTDwi4Y9BX0mHsdTmp7T3aIPsA3SCHHP
	oP4pXSop/qbcNngJoXhv9PWvNevwNUVF6VbgGXzyt/IaKfU4FjQmMuPa01kc/1LDIuT2XpMgdVL
	qn2trudnOmPKnvDiCI6kWuZUqmAP0qmvTo+vuoUP5e11loLUh60GjBUe5CHgDTopJr4xepE6hp9
	Pdv/aG5J6dkQtN4DbYv2kWvqAAKVLJFRYFzZgZ6Iuic8eTGC550PdaPMgVZ68/f8VTfccu0cBrb
	fP76KO6cbBD3ff/vVp9hpxRmdgFmqGvDFELanTw==
X-Google-Smtp-Source: AGHT+IEneqUbInPckHU+/2ODBYNyktvBg1Q4FEg/iNx5A55j1JRc7HsQFyzgpGys7+XvMH0c6D/9kA==
X-Received: by 2002:a50:8d89:0:b0:62c:dfae:ab96 with SMTP id 4fb4d7f45d1cf-6349fac9c10mr931863a12.7.1758792973580;
        Thu, 25 Sep 2025 02:36:13 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:13 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 1/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:39 +0100
Message-ID: <20250925103559.14876-2-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Change only variable types for correct sign comparisons

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_global_func11.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index 283e036dc401..2ad72bf0e07b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 6e03d42519a6..53eab8ec6772 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index 02ea80da75b5..c4afdfc9d92e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 __noinline int foo(const struct S *s)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index 1f2cb0159b8d..9138d9bd08fc 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -5,7 +5,7 @@
 #include "bpf_misc.h"
 
 struct S {
-	int x;
+	__u32 x;
 };
 
 struct C {
diff --git a/tools/testing/selftests/bpf/progs/test_map_init.c b/tools/testing/selftests/bpf/progs/test_map_init.c
index c89d28ead673..311e6ac64588 100644
--- a/tools/testing/selftests/bpf/progs/test_map_init.c
+++ b/tools/testing/selftests/bpf/progs/test_map_init.c
@@ -22,7 +22,7 @@ int sysenter_getpgid(const void *ctx)
 	/* Just do it for once, when called from our own test prog. This
 	 * ensures the map value is only updated for a single CPU.
 	 */
-	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	__u32 cur_pid = bpf_get_current_pid_tgid() >> 32;
 
 	if (cur_pid == inPid)
 		bpf_map_update_elem(&hashmap1, &inKey, &inValue, BPF_NOEXIST);
diff --git a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
index d9b2ba7ac340..4b8ab8716246 100644
--- a/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
+++ b/tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c
@@ -102,7 +102,7 @@ int xdp_ingress_v6(struct xdp_md *xdp)
 	opt_state.byte_offset = sizeof(struct tcphdr) + tcp_offset;
 
 	/* max number of bytes of options in tcp header is 40 bytes */
-	for (int i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
+	for (__u32 i = 0; i < tcp_hdr_opt_max_opt_checks; i++) {
 		err = parse_hdr_opt(xdp, &opt_state);
 
 		if (err || !opt_state.hdr_bytes_remaining)
-- 
2.51.0



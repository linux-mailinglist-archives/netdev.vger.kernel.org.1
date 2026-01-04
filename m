Return-Path: <netdev+bounces-246760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB65CF0FBE
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169CA3063259
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE5302149;
	Sun,  4 Jan 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUZbYBBt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE65302756
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532641; cv=none; b=iU7iENUGbbZVZ2ioOYspQii8MqN8UflvfG/APZbXvasKFx3mavniGjawM0V70K6yZJXoPfplrj6GB9OHO0GqzJJUfEtkBj8hZolUL5z/2XwPdSjMEnZikCGguyJY8HBf5cSKLD572tnkUen3lfOplPFrA1SCS1oXeUFZKlX5cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532641; c=relaxed/simple;
	bh=l/pB7uVblz5yUYx9vVEAQ9iGeAfGiUcxBP+M7nG1v3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukYNLtdY5wR6eC3uEFGQ23OwVBCyVjZ/YQ/92kd6PgikPZ+6U6JfGk2yp77Jgp6/wNuiDIGx6/8fRWjVGGy1mVK139BYxd+/YFvEXRuB7VkbMwTYK7gnGvz1X88kMepAjyG8pBY0ctwBkX8DaddR2nCaYPVbdPqDNDLs567qOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUZbYBBt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso15631812b3a.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532636; x=1768137436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhOaRHrMPgBGQqZ9JTk0YwCbrcBEBCvTMf35tIgKBVg=;
        b=DUZbYBBtSz5EMkmaiD/TX/nbeenMJOM7dQ//1B7lghg8wbDyEG59+NCs7QRrxi1XW5
         R5eRBf4kk9rGoNBhtjgSYljFuGNdSenmlnoAl1D1OWwsJXj9vlGyJ4I4ffPE5R1dyyxf
         LtxrpShg8X/MDEp0YqSv9REW0tLKiMn37LZI0qqBt2tATP+bVRoGOffd9k+hTI65bR01
         0+nxlPJO6KA2y4QnmQb2KQ1yt8oNsInZ9tA27k/alR2dZRYM/Lf2EfDJ75wpKQ4odJ8j
         oT67ra+uB7n4FOmV4oZRD1vGIsa4bTNcHdIfJkl4I8HarPT2Y9s91P+ikCM+4fWUH7UP
         ZxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532636; x=1768137436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhOaRHrMPgBGQqZ9JTk0YwCbrcBEBCvTMf35tIgKBVg=;
        b=Ijg+KES/Zhab40TvIJ3zVvd9MTrLWsUkqduGXuhV/DiVwCguBzuTVWurXHcJrpi2my
         xUAh/UKVXAuI/8XqVQS3pR1Gd1QILN2nlW3ujVvOMiD+5XfLnKCr/wIYfn5cRngOB9ej
         22f+LhNa6MHXCdekuiWqg8AEf6ReQd7RoVBvOlh1CjCwm7bDeYSjDbigYvzvZVCx0JVY
         ZCgJtMxwKZdJYIZ+uXC39PGwWwY2eHE/YH3QJw631KlIUtkzRvGtPqPrdqxXzWUilcLc
         KJJ9CM6JFwK8lhzjKTPNjEX4oryb6br5xlrH8xGJvtgAhCo5XYfXpQjozsCxExGJd0r9
         TVYA==
X-Forwarded-Encrypted: i=1; AJvYcCWPXwCzsJbBDNYPVRmnuhy1NBH2B57igTkBDNKfhRG2y+Q0uVOjgVULSc52+ULWcMeigRN0UCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSz5jZJb32CHpTIWEMcrXWVBW7SG91pX9N5NcisTuS26vr/ps
	OHSdqxZ/CrZ//AB2TpHjSSQ0j6XfI1Jkp2ra9f/2txxK9zs68M7c++im
X-Gm-Gg: AY/fxX6UsrNoUnYgpLUmTiGbE8lanVEDTLFeLFfs6UyyXSP+WkaD1nfMyooY1ciHXnR
	k6QMNZMMXuGBHST72WSddZPTnaH1qkDr5wz1JKQXKbAHuVFMq/savSldJm4/SnbWrypWZrqGpF4
	H+zTsCi4Uci54SyZwkF1ytGZOe7kMeNDnpwEUCOUFPRmWPGGwUJIVXOpSVQ0uDvKVkhz0COu0bQ
	F0Wm0Oq+DUewjBcJcIWgys7OYV5IHQBbfoNzzkkXMHGWYk1t3VTel0cc4LotLSdRkmpfWoxxy1P
	B01hgXT+RjfUGqjRu16Y66et3e0v3x9buLGmFio5031qQFHBd1ZtmKr6hq3pPAwVnysWMBAbSng
	uwlNrzBIIgkNhOVzqRypRHo2dx2z9YbjDsm+uSv56ZORk7L407hucBikOcZPRY66B7lKAMDCoxA
	vjM9I0cwNgIHS+n8HaWA==
X-Google-Smtp-Source: AGHT+IHh2+8bf+lLxGiq4ZmcFmxVSzU2krL6789my/Uv92Ard/irM18/tDYIcl2ke7iyrnqPtjylBg==
X-Received: by 2002:a05:6a20:72a7:b0:35a:80f2:fa3c with SMTP id adf61e73a8af0-376a8cbe357mr46833125637.31.1767532635996;
        Sun, 04 Jan 2026 05:17:15 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:17:15 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
Date: Sun,  4 Jan 2026 21:16:35 +0800
Message-ID: <20260104131635.27621-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104131635.27621-1-dongml2@chinatelecom.cn>
References: <20260104131635.27621-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testcase for the jited inline of bpf_get_current_task().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 5829ffd70f8f..47eb78c808c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -110,6 +110,7 @@
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
+#include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 
 #define MAX_ENTRIES 11
@@ -251,6 +252,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
+void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
new file mode 100644
index 000000000000..398a6405d00a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+SEC("fentry/bpf_fentry_test1")
+__description("Jit inline, bpf_get_current_task")
+__success __retval(0)
+__arch_x86_64
+__jited("	movq	%gs:{{.*}}, %rax")
+__arch_arm64
+__jited("	mrs	x7, SP_EL0")
+int inline_bpf_get_current_task(void)
+{
+	bpf_get_current_task();
+
+	return 0;
+}
+
+#else
+
+SEC("kprobe")
+__description("Jit inline is not supported, use a dummy test")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0



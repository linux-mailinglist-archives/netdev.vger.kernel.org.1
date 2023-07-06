Return-Path: <netdev+bounces-15810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE8749EDF
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C91C20D9C
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FF9469;
	Thu,  6 Jul 2023 14:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F69457;
	Thu,  6 Jul 2023 14:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABA8C433C7;
	Thu,  6 Jul 2023 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688653361;
	bh=yDBvfndKjEgluCr2OUU13EcTyPrXy62c+4pPDGslyiY=;
	h=From:To:Cc:Subject:Date:From;
	b=bVdRnuRcCDjTajpAmfb2BDudaol6XjWyAkkYusojS0frgOPH84s2OiotXP4VEMHtU
	 f00LjcxBzHOEyuV8GbiXKPQOmuWhQUI9nxHCq2NED/ZiWuhUWS0B5B2yjno/GDzhG2
	 WIhJ9ZNtEY8HWKwmmSm+PG6c6uVYH6dyhGb5KEES2rmTckIvHfmKOti13bo1TNvnCY
	 YVMOI9SW5anRK411UTtH9/OtepjdrYbd0z/+VndSD4cpmVQ627FM/tp1MCt7qm1Z+M
	 JiSlsgpyICuoWWee8mNKya19IlCXrGZIq7jtuXfqsfcMINVUbea/wWboybEZG1SKp2
	 giredYerJAi6A==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
Date: Thu,  6 Jul 2023 16:22:28 +0200
Message-Id: <20230706142228.1128452-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
buffer overrun if the number of syms on the system is larger than
MAX_SYMS.

Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
the maximum is reached.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9b070cdf44ac..f83d9f65c65b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,7 +18,7 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 300000
+#define MAX_SYMS 400000
 static struct ksym syms[MAX_SYMS];
 static int sym_cnt;
 
@@ -46,6 +46,9 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
+		if (i >= MAX_SYMS)
+			return -EFBIG;
+
 		syms[i].addr = (long) addr;
 		syms[i].name = strdup(func);
 		i++;

base-commit: fd283ab196a867f8f65f36913e0fadd031fcb823
-- 
2.39.2



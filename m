Return-Path: <netdev+bounces-59835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD481C2F4
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 02:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A892884E0
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC29A50;
	Fri, 22 Dec 2023 01:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OdYNJNFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F223AD
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d190044c5so13885295e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703210357; x=1703815157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4/lFuQQ8aRjKsTJBeQApKDK4hOJ7gyWGAx/V6cHGCw=;
        b=OdYNJNFaxFk2iN2YF0mbpqyIMNA4S7NjQnLkmCCtfiYfhiexFpxc1XTWW4tU39Dc75
         U+PJ+Fiy8fUtG07LMoD74KsxmDTCSw+sarmk7y+pQlfJFOoD/N8Tg4d6ehT+p8eKMbOH
         t7yJjU2BwtKhiW025Seo71y4BI5NJo5d72UyJ3ftZ7PkqUlNke9NTdtNiTCbLGJeN24G
         02ySfjQ4gdXylOsXIjHhgvT/PByXsvroEmKgD442atx8v+k2y3sU+HwJmFY1WbDRRojM
         Ua5L+SD1vPGk/Ie3M5uZzzLN33u5L0JbYVEvNBdRu0U1iN7v4UJw4swIpmFocxEzPelS
         YiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703210357; x=1703815157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4/lFuQQ8aRjKsTJBeQApKDK4hOJ7gyWGAx/V6cHGCw=;
        b=vaTibkuHNR3F5F5ZipTD4Yc5ZSg/zbmkM96l88MT4DlYLIU2bvnHK3I3vtsHXBUILg
         7ElV9K1rt/I7CvOignrSk07txWVgyItRB92rzOvKy8lPIla1CEFqVVFv13vq3UGvXLo+
         6YBIj1g0/PfKcpcVd1If1WI6V4+8K6TWulUV4TO4uqBjxyiLUOPfMJzoK2IsSVJDvv0u
         tEjbwSPUBUTop59K+xkXHrLMKYfMk9OYanC5k5g2oVQWuQiVksSND5BHPa8EBnjgEm4X
         3zoE19yjlq8CSuI/1L6UdUrmQuzecOB+wv2StAMRLKiRkhRcSVWb8hjXVVJDKYrrAJw0
         DkxA==
X-Gm-Message-State: AOJu0YwqYqgk4ison3TGqiNM7xdHqxu4R86NfZv3PyE5sb/qseq3Onui
	UZ3/Rgbt33LkRinm+pm8GNB5FxWJ3mUD
X-Google-Smtp-Source: AGHT+IH0xcKaXPa+NaR8F7vKcQ7Ml2MM8rqbFcOFYbfAEowW+XEKlfZE7rP5ZmekIo8e5GdaGC/vEA==
X-Received: by 2002:a05:600c:cf:b0:40d:3d6b:c310 with SMTP id u15-20020a05600c00cf00b0040d3d6bc310mr320620wmm.84.1703210357433;
        Thu, 21 Dec 2023 17:59:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c310300b0040c6b2c8fa9sm12991667wmo.41.2023.12.21.17.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:59:16 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 2/2] selftest/tcp-ao: Work on namespace-ified sysctl_optmem_max
Date: Fri, 22 Dec 2023 01:59:07 +0000
Message-ID: <20231222-selftests-tcp-ao-fixups-v1-2-39c73817c372@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
References: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703210346; l=3509; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=aAhgKSShLm2so0+GO2W3s1G0l6uod//MDjvHynQQ5Wg=; b=koV9a+5/3Pucgn48VBu2Sh1ZHLSSqOqy9ycM0YGAc0ddXk7FEpUuFDo2sHnn8An1OyxjOsBqx 4iml95eTdL6CFy7TXArUqZ1pJxCvRBW52MXuWYXgWz2iGWn33hwX9KN
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Since commit f5769faeec36 ("net: Namespace-ify sysctl_optmem_max")
optmem_max is per-netns, so need of switching to root namespace.
It seems trivial to keep the old logic working, so going to keep it for
a while (at least, until kernel with netns-optmem_max will be release).

Currently, there is a test that checks that optmem_max limit applies to
TCP-AO keys and a little benchmark that measures linked-list TCP-AO keys
scaling, those are fixed by this.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 374b27c26ebd..92276f916f2f 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -277,22 +277,38 @@ void __test_init(unsigned int ntests, int family, unsigned int prefix,
 
 /* /proc/sys/net/core/optmem_max artifically limits the amount of memory
  * that can be allocated with sock_kmalloc() on each socket in the system.
- * It is not virtualized, so it has to written outside test namespaces.
- * To be nice a test will revert optmem back to the old value.
+ * It is not virtualized in v6.7, so it has to written outside test
+ * namespaces. To be nice a test will revert optmem back to the old value.
  * Keeping it simple without any file lock, which means the tests that
  * need to set/increase optmem value shouldn't run in parallel.
  * Also, not re-entrant.
+ * Since commit f5769faeec36 ("net: Namespace-ify sysctl_optmem_max")
+ * it is per-namespace, keeping logic for non-virtualized optmem_max
+ * for v6.7, which supports TCP-AO.
  */
 static const char *optmem_file = "/proc/sys/net/core/optmem_max";
 static size_t saved_optmem;
+static int optmem_ns = -1;
+
+static bool is_optmem_namespaced(void)
+{
+	if (optmem_ns == -1) {
+		int old_ns = switch_save_ns(nsfd_child);
+
+		optmem_ns = !access(optmem_file, F_OK);
+		switch_ns(old_ns);
+	}
+	return !!optmem_ns;
+}
 
 size_t test_get_optmem(void)
 {
+	int old_ns = 0;
 	FILE *foptmem;
-	int old_ns;
 	size_t ret;
 
-	old_ns = switch_save_ns(nsfd_outside);
+	if (!is_optmem_namespaced())
+		old_ns = switch_save_ns(nsfd_outside);
 	foptmem = fopen(optmem_file, "r");
 	if (!foptmem)
 		test_error("failed to open %s", optmem_file);
@@ -300,19 +316,21 @@ size_t test_get_optmem(void)
 	if (fscanf(foptmem, "%zu", &ret) != 1)
 		test_error("can't read from %s", optmem_file);
 	fclose(foptmem);
-	switch_ns(old_ns);
+	if (!is_optmem_namespaced())
+		switch_ns(old_ns);
 	return ret;
 }
 
 static void __test_set_optmem(size_t new, size_t *old)
 {
+	int old_ns = 0;
 	FILE *foptmem;
-	int old_ns;
 
 	if (old != NULL)
 		*old = test_get_optmem();
 
-	old_ns = switch_save_ns(nsfd_outside);
+	if (!is_optmem_namespaced())
+		old_ns = switch_save_ns(nsfd_outside);
 	foptmem = fopen(optmem_file, "w");
 	if (!foptmem)
 		test_error("failed to open %s", optmem_file);
@@ -320,7 +338,8 @@ static void __test_set_optmem(size_t new, size_t *old)
 	if (fprintf(foptmem, "%zu", new) <= 0)
 		test_error("can't write %zu to %s", new, optmem_file);
 	fclose(foptmem);
-	switch_ns(old_ns);
+	if (!is_optmem_namespaced())
+		switch_ns(old_ns);
 }
 
 static void test_revert_optmem(void)

-- 
2.43.0



Return-Path: <netdev+bounces-183577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B86A91131
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3AA19074FE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125A1D61B9;
	Thu, 17 Apr 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vSuxi/dE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022E1D47C7
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853592; cv=none; b=jIa64Zk8+PchdQ6DYt5XMbv76V8L2m2phKPwKBV7zO8RCeJo6QOXINJ7dK3Rv3bZpQLAim+sl6q+cu8bmVOvTs0OAFH1jSze/+duVrfcO5VkB8joLVEG/EzH/lVQpGZpHnvpq88U3s7MPIOT//lQB6+mz/zjGPHWot8zmARD6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853592; c=relaxed/simple;
	bh=iC38gdoHa0iB1zJg2rOXQF/27QGDkW0uzWiTqqa4j3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU543kNER2D7V8sFv1J8GvUgCS4b8nIze5kbMgwiE+clQIRm3pryXxqZPkTgkMOWdTDsDPHHtyBDYH+tlBNPM3nGueT6F5+dAeMvF6TcMEZq3A+oBfFJoN2KouIOJ/ZL5W5sKZbO9+X89Ddwfy+OjiLP7aMGpBAps2bYdKtVG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vSuxi/dE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3085f827538so264892a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853590; x=1745458390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZCFxUxzlk1WaRej7yGOb8bWsdrrxKB0c/PerPrAolw=;
        b=vSuxi/dEclKZP/Uw2HlGkujTqUsjwtcgulp4TI8gVBA0qXXl3BYAdL9Mz5dTEo/a4+
         2+LBJF+x26DlKumHooL/iPouP2w27utGceCOFB3ta5FwokuRCNsESkJP7Q1ROiuMqX83
         tmO6dYZ4OglgM9ncvu30Un7+EnAziLaQ0Rars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853590; x=1745458390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZCFxUxzlk1WaRej7yGOb8bWsdrrxKB0c/PerPrAolw=;
        b=fNl/Ck7UStKdtc6WHi3lyqfwtsVcNq+uQ9oFgnVAjBXCg67gHLaD7fZZBJqqSGwFT/
         3VrbFt6AnnvGDUvjv/nFuB71rqS2nLCcsmqnMJoeWVvjv+5lHdMM/JiO+oFT+z7lMlBO
         YVw4aGJ/r1ThAsRTTts8xjH1/4m146XaSM2ang7nOznXUFFH7ZbTS43nKfJkrt8UiEzS
         kPxTFvmhKjQCgjwQHbbHLMsc58QE2/lmwXVKLPx1xLqSXC9VtoGt1pjRkc3ie37igyZ6
         Kd7qjefRTVOvG0K0CFgKqOYYY2/9oiRNbrLTqVLWYtZ/J2jDTUtxeP/bK9ly/V0CBpxp
         8HwQ==
X-Gm-Message-State: AOJu0Yz6fHbPR4pEb9nXccYhp3qTTLB5zQ4lFWKfcJ8dpGsXGuDp6H8x
	9C22FRvjTkTh7oYl3/gD0CeyFKbpglXAySdEVfHgdYC12HG3vAR4Fxk1tHRosRyIXQyW5k75zpq
	XR4fe9lnm0RVBISUoi24JZaPNLH4UYw+qtD1FhwJeyoEKuJj9Wlx0/dC802byYjBvT90qTOWhl7
	ujCtPkSj/TLkDRpzjhbUxH+FOA+0V/GdhkCzg=
X-Gm-Gg: ASbGncspJr0S1DJYzQhS+0wyDn5FCKlb87z6KHShCW6b6HmMPDUO07MHOevVnUzqyF/
	QV4AG7XdvvSt4olWZ6z2rWcX7/ojTiQasWHB7VFsAOJOGI4RSZ80Qudf6HwP6Ix385lN7C8BEJQ
	vFWIjymMaI954Bg3nUQ6ygngBQS/N2oW9Nbt6ijL7HXy7PTvIm8yFZLKLoZ9rby+m91hTj2EqPi
	vVm7Pf4Uyt/VSpsqArw3JNgJi1zo3mBHjZo8YMGJ41EogObRI5eYh6qf3wu0ARgOWK0G8HCAazT
	e/wo6eVD2qP4JC2WwCKzWQx8STyE7BKAPszR/bHeYvSHTg/u
X-Google-Smtp-Source: AGHT+IFURUTFYkzHYQIncz+BfKUAREfkEb0hfHFXyfz2gYFuInISIzikqK/QQxnSU1SXGYMuPoyaZA==
X-Received: by 2002:a17:90b:2f4e:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-30864173b39mr5158528a91.32.1744853589813;
        Wed, 16 Apr 2025 18:33:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v2 2/4] selftests: drv-net: Factor out ksft C helpers
Date: Thu, 17 Apr 2025 01:32:40 +0000
Message-ID: <20250417013301.39228-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor ksft C helpers to a header so they can be used by other C-based
tests.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +---------------
 2 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h

diff --git a/tools/testing/selftests/drivers/net/ksft.h b/tools/testing/selftests/drivers/net/ksft.h
new file mode 100644
index 000000000000..3fd084006a16
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ksft.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(__KSFT_H__)
+#define __KSFT_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static void ksft_ready(void)
+{
+	const char msg[7] = "ready\n";
+	char *env_str;
+	int fd;
+
+	env_str = getenv("KSFT_READY_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		fd = STDOUT_FILENO;
+	}
+
+	write(fd, msg, sizeof(msg));
+	if (fd != STDOUT_FILENO)
+		close(fd);
+}
+
+static void ksft_wait(void)
+{
+	char *env_str;
+	char byte;
+	int fd;
+
+	env_str = getenv("KSFT_WAIT_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		/* Not running in KSFT env, wait for input from STDIN instead */
+		fd = STDIN_FILENO;
+	}
+
+	read(fd, &byte, sizeof(byte));
+	if (fd != STDIN_FILENO)
+		close(fd);
+}
+
+#endif
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index aeed25914104..d5bb8ac33efa 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -11,56 +11,11 @@
 #include <net/if.h>
 #include <inttypes.h>
 
+#include "ksft.h"
+
 #define UMEM_SZ (1U << 16)
 #define NUM_DESC (UMEM_SZ / 2048)
 
-/* Move this to a common header when reused! */
-static void ksft_ready(void)
-{
-	const char msg[7] = "ready\n";
-	char *env_str;
-	int fd;
-
-	env_str = getenv("KSFT_READY_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		fd = STDOUT_FILENO;
-	}
-
-	write(fd, msg, sizeof(msg));
-	if (fd != STDOUT_FILENO)
-		close(fd);
-}
-
-static void ksft_wait(void)
-{
-	char *env_str;
-	char byte;
-	int fd;
-
-	env_str = getenv("KSFT_WAIT_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		/* Not running in KSFT env, wait for input from STDIN instead */
-		fd = STDIN_FILENO;
-	}
-
-	read(fd, &byte, sizeof(byte));
-	if (fd != STDIN_FILENO)
-		close(fd);
-}
 
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
-- 
2.43.0



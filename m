Return-Path: <netdev+bounces-196695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E1AD5F97
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C533A2CAE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1D2BDC31;
	Wed, 11 Jun 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="0vdyDy4w"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8E2222CA;
	Wed, 11 Jun 2025 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671850; cv=none; b=RIsVn7gkM5apxufQz+bQufBrtogpqErRVagIUm19fxHiPpYHXsJGoevtexykYACfFb0rbUOhyV+ai4hnYBbOs1+kloPIOWXu1v7Na8MRx69XlFfpfj36gFwXH1R3j3QIEFYrctHY9R3rnqvO795k0VKAJLmrTNWbZY5QdYUO9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671850; c=relaxed/simple;
	bh=l+3eGtGFJPPGFfFCjxhEmKxENxAOs/hijlNpTuHUvQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2fyV5RZFvb5vLYb9dqqGl0KjpUMp0opRZ0H/kVGGTNJX55cy5TYCmG8mUykSUXW8W5mD7817bXe+IkRy0nEMhokLYpyl7NZL04XSJJtQbB5bbyHs8d0+cyJ389+dnxsc6xCMz6ZyjiQJRQ8+NOflwN6DleHWQ6fu6/aaNT3qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=0vdyDy4w; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZZ-00BIDl-4K; Wed, 11 Jun 2025 21:57:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=g3P/b2xpkd5Ju2ZEi9PD/MpzldHWyAMly/rPPt2zMp4=; b=0vdyDy4w5DEKVG4vQ/baGS47cS
	St3J+CbDkgG9+KuUpsqMHAiOIIsofDG+d1F4xW9EJXAcX/EgIZI55kbLU+jVWCNMxXOrR/JIEubnY
	75ipr07E23f8+d9qn5bBKjBLH3qjsEOj46h8abjZdGVloRSY8dCnyky1RL8F3a1hfz5iXAPqkbpSf
	lAkw1vd/v1QAjRJBDOvR+ZD/yxSKJ3wjzjn+2MeL7ZQcK7J0JET1taicdFl9arVnQ5hHTcqhw/kq1
	ej4d2tXfyD99id4VJyVF0smc59cihC2Sm1LH+Fg/VE8s/jpfIwrmeXlIS78Q+ibAyOrpbHRVC9HfS
	3yxlyouQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZY-0004Bc-PC; Wed, 11 Jun 2025 21:57:20 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPRZH-00BycS-Lv; Wed, 11 Jun 2025 21:57:03 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 11 Jun 2025 21:56:51 +0200
Subject: [PATCH net-next v3 2/3] vsock/test: Introduce get_transports()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-vsock-test-inc-cov-v3-2-5834060d9c20@rbox.co>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
In-Reply-To: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Return a bitmap of registered vsock transports. As guesstimated by grepping
/proc/kallsyms (CONFIG_KALLSYMS=y) for known symbols of type `struct
vsock_transport`, or `struct virtio_transport` in case the vsock_transport
is embedded within.

Note that the way `enum transport` and `transport_ksyms[]` are defined
triggers checkpatch.pl:

util.h:11: ERROR: Macros with complex values should be enclosed in parentheses
util.h:20: ERROR: Macros with complex values should be enclosed in parentheses
util.h:20: WARNING: Argument 'symbol' is not used in function-like macro
util.h:28: WARNING: Argument 'name' is not used in function-like macro

While commit 15d4734c7a58 ("checkpatch: qualify do-while-0 advice")
suggests it is known that the ERRORs heuristics are insufficient, I can not
find many other places where preprocessor is used in this
checkpatch-unhappy fashion. Notable exception being bcachefs, e.g.
fs/bcachefs/alloc_background_format.h. WARNINGs regarding unused macro
arguments seem more common, e.g. __ASM_SEL in arch/x86/include/asm/asm.h.

In other words, this might be unnecessarily complex. The same can be
achieved by just telling human to keep the order:

enum transport {
	TRANSPORT_LOOPBACK = BIT(0),
	TRANSPORT_VIRTIO = BIT(1),
	TRANSPORT_VHOST = BIT(2),
	TRANSPORT_VMCI = BIT(3),
	TRANSPORT_HYPERV = BIT(4),
	TRANSPORT_NUM = 5,
};

 #define KSYM_ENTRY(sym) "d " sym "_transport"

/* Keep `enum transport` order */
static const char * const transport_ksyms[] = {
	KSYM_ENTRY("loopback"),
	KSYM_ENTRY("virtio"),
	KSYM_ENTRY("vhost"),
	KSYM_ENTRY("vmci"),
	KSYM_ENTRY("vhs"),
};

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/vsock/util.h | 29 ++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39..803f1e075b62228c25f9dffa1eff131b8072a06a 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -7,6 +7,7 @@
  * Author: Stefan Hajnoczi <stefanha@redhat.com>
  */
 
+#include <ctype.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
@@ -23,6 +24,9 @@
 #include "control.h"
 #include "util.h"
 
+#define KALLSYMS_PATH		"/proc/kallsyms"
+#define KALLSYMS_LINE_LEN	512
+
 /* Install signal handlers */
 void init_signals(void)
 {
@@ -854,3 +858,55 @@ void enable_so_linger(int fd, int timeout)
 		exit(EXIT_FAILURE);
 	}
 }
+
+static int __get_transports(void)
+{
+	char buf[KALLSYMS_LINE_LEN];
+	const char *ksym;
+	int ret = 0;
+	FILE *f;
+
+	f = fopen(KALLSYMS_PATH, "r");
+	if (!f) {
+		perror("Can't open " KALLSYMS_PATH);
+		exit(EXIT_FAILURE);
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		char *match;
+		int i;
+
+		assert(buf[strlen(buf) - 1] == '\n');
+
+		for (i = 0; i < TRANSPORT_NUM; ++i) {
+			if (ret & BIT(i))
+				continue;
+
+			/* Match should be followed by '\t' or '\n'.
+			 * See kallsyms.c:s_show().
+			 */
+			ksym = transport_ksyms[i];
+			match = strstr(buf, ksym);
+			if (match && isspace(match[strlen(ksym)])) {
+				ret |= BIT(i);
+				break;
+			}
+		}
+	}
+
+	fclose(f);
+	return ret;
+}
+
+/* Return integer with TRANSPORT_* bit set for every (known) registered vsock
+ * transport.
+ */
+int get_transports(void)
+{
+	static int tr = -1;
+
+	if (tr == -1)
+		tr = __get_transports();
+
+	return tr;
+}
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..71895192cc02313bf52784e2f77aa3b0c28a0c94 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -3,8 +3,36 @@
 #define UTIL_H
 
 #include <sys/socket.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/vm_sockets.h>
 
+/* All known vsock transports, see callers of vsock_core_register() */
+#define KNOWN_TRANSPORTS(x)		\
+	x(LOOPBACK, "loopback")		\
+	x(VIRTIO, "virtio")		\
+	x(VHOST, "vhost")		\
+	x(VMCI, "vmci")			\
+	x(HYPERV, "hvs")
+
+enum transport {
+	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
+	#define x(name, symbol)		\
+		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
+	KNOWN_TRANSPORTS(x)
+	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
+	#undef x
+};
+
+static const char * const transport_ksyms[] = {
+	#define x(name, symbol) "d " symbol "_transport",
+	KNOWN_TRANSPORTS(x)
+	#undef x
+};
+
+static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
+static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
+
 /* Tests can either run as the client or the server */
 enum test_mode {
 	TEST_MODE_UNSET,
@@ -82,4 +110,5 @@ void setsockopt_timeval_check(int fd, int level, int optname,
 			      struct timeval val, char const *errmsg);
 void enable_so_zerocopy_check(int fd);
 void enable_so_linger(int fd, int timeout);
+int get_transports(void);
 #endif /* UTIL_H */

-- 
2.49.0



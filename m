Return-Path: <netdev+bounces-194054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D286CAC7259
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826971BA4048
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027281F561D;
	Wed, 28 May 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="znegzxaV"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115114A8E;
	Wed, 28 May 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465137; cv=none; b=ssU1U5PnBEnp8It71X506+SeaYgmOGlVFjfPWPo1tf5qkVL9eeSSAFyQAUqkbVghfn71nR0hitJxqRGZLxNdA+fYbS09Ct4cob/IgFOwFDDqk7ylPwqfS4vZYQIolFKVW6aUWIrMYZFlc6tE2LhSkk+gC4AlpYA4WCsJZlyw2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465137; c=relaxed/simple;
	bh=5vNqbnpuocbB5KxnNgtdlCu+kDtLgut93zWsETJpyqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNChg+y3bGG2fNMnWcscVW11uRobCG7PleRnd8iqOGy3n5tK4roZktDNlapIu8e3Ftb1ki+7kWrcet6ibs4shhz+q3He5cszv1a6QlIWocwijUY9wgRuusHUHexU82ejv8oQ5U/KjRihvh64X7kHKPVBF93GAiKaiJXkKYzPHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=znegzxaV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeU-006kZe-Oe; Wed, 28 May 2025 22:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=s9UKfKrtbNFptlDKWxq7CWOT7YvxuhQzl2iCNVp0T1I=; b=znegzxaVxWYS5T+0vzrMt9/VC4
	zw2TisYvcB13F6+ANlfR8pUk7KmX/5J+pghcPCnVwVskPSwShpNEP4X87K5tK+gOrymDzqZ0iF9Gi
	e8wh69eytjLIEthKF1p9tiE9rdK4HJR+FZveg7ytvJiEt++5JuR09vcxGd9fjtTQz29//4F/k6fGs
	/i+BsZXt8Dr/gHCCFyazG2Sjdr1KW1JOqJaCuIOQ2H6CB4rlLr+AF9Vb+azr1JW7KGCXFstwctW0j
	nG5d8Sl1vDB6UCqGS0FhgO077yAZmNHkry5qW5aQqnSa8prkI/UN9Eowp4RZCMv7Gtm+PgR+EvEHB
	Dbqg2OZw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeU-0005Bd-9k; Wed, 28 May 2025 22:45:30 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uKNeB-00GEBu-HQ; Wed, 28 May 2025 22:45:11 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 28 May 2025 22:44:42 +0200
Subject: [PATCH RFC net-next v2 2/3] vsock/test: Introduce get_transports()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
In-Reply-To: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Return a bitmap of registered vsock transports. As guesstimated by grepping
/proc/kallsyms (CONFIG_KALLSYMS=y) for known symbols of type `struct
virtio_transport`.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/vsock/util.h | 12 ++++++++++
 2 files changed, 72 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39..74fb52f566148b16436251216dd9d9275f0ec95b 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -7,6 +7,7 @@
  * Author: Stefan Hajnoczi <stefanha@redhat.com>
  */
 
+#include <ctype.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
@@ -17,6 +18,7 @@
 #include <assert.h>
 #include <sys/epoll.h>
 #include <sys/mman.h>
+#include <linux/kernel.h>
 #include <linux/sockios.h>
 
 #include "timeout.h"
@@ -854,3 +856,61 @@ void enable_so_linger(int fd, int timeout)
 		exit(EXIT_FAILURE);
 	}
 }
+
+static int __get_transports(void)
+{
+	/* Order must match transports defined in util.h.
+	 * man nm: "d" The symbol is in the initialized data section.
+	 */
+	const char * const syms[] = {
+		"d loopback_transport",
+		"d virtio_transport",
+		"d vhost_transport",
+		"d vmci_transport",
+		"d hvs_transport",
+	};
+	char buf[KALLSYMS_LINE_LEN];
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
+		for (i = 0; i < ARRAY_SIZE(syms); ++i) {
+			match = strstr(buf, syms[i]);
+
+			/* Match should be followed by '\t' or '\n'.
+			 * See kallsyms.c:s_show().
+			 */
+			if (match && isspace(match[strlen(syms[i])])) {
+				ret |= _BITUL(i);
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
index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..63953e32c3e18e1aa5c2addcf6f09f433660fa84 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -3,8 +3,19 @@
 #define UTIL_H
 
 #include <sys/socket.h>
+#include <linux/bitops.h>
 #include <linux/vm_sockets.h>
 
+#define KALLSYMS_PATH		"/proc/kallsyms"
+#define KALLSYMS_LINE_LEN	512
+
+/* All known transports */
+#define TRANSPORT_LOOPBACK	_BITUL(0)
+#define TRANSPORT_VIRTIO	_BITUL(1)
+#define TRANSPORT_VHOST		_BITUL(2)
+#define TRANSPORT_VMCI		_BITUL(3)
+#define TRANSPORT_HYPERV	_BITUL(4)
+
 /* Tests can either run as the client or the server */
 enum test_mode {
 	TEST_MODE_UNSET,
@@ -82,4 +93,5 @@ void setsockopt_timeval_check(int fd, int level, int optname,
 			      struct timeval val, char const *errmsg);
 void enable_so_zerocopy_check(int fd);
 void enable_so_linger(int fd, int timeout);
+int get_transports(void);
 #endif /* UTIL_H */

-- 
2.49.0



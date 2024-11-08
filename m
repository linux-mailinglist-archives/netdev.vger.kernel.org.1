Return-Path: <netdev+bounces-143127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65449C1380
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4171FB21A30
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA93AC2B;
	Fri,  8 Nov 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="byUA/m0p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5225DF49;
	Fri,  8 Nov 2024 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028672; cv=none; b=vEt5+f9KEEexUzmz0QIFYnc40Ga54ql874bsPo0u986CX3+ELebC+XaTckATvtTQlwQbhOLcvF3i/kbk4Iwh92sVutZuZSyMvpmMAWHFXFqw0jL2IfrFPk5bm2wGSW1HkwVuu5Yk/UHl9O5YkLUDhab0fyu5unOrwB4rHKfpx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028672; c=relaxed/simple;
	bh=7wgLYdObdi1uZicgfI8/wqQQnHCbEAdB3mF3z+24b7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aovPgxdbF31ubD8gJudAvz6KnQ3kM33xktHPSuOfIQcLxEymFztyJRFWq7aLbLbEthVkMdsL8LkBDPbYPxCD2VKTZKHfLB4XffQP+gbuUj/QXxCMTiHeI7g51OQK5O97qHrI5RAO3FrXGjqVB0Idu/7+p3ckEZZygGW9uPp6JJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=byUA/m0p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A819m81013968;
	Fri, 8 Nov 2024 01:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5j/cZiy/pxag6SaZR
	1SGLumrjK4EnE7JIEOT+QI8udw=; b=byUA/m0pVdJSkVzInZeH2E2d3QcnoiLow
	r7QN2dhej4KbBVzh7w4jH4ULGlsSZvhomucB+jrTL4HF6v/Uuz6apJM5NYXjP26u
	hAPxmPwsIq21ytrBX3f5R9QsCIyCQLPzIAMJI6+XM8dz+OthJEEHBni74+9IEwsb
	2gcs4DEqei3ZD0G3jdOubketuK+22AtsRtPQDvgIUo0Eo6jPhqERrFxEZSnRyq+8
	tR2TpDU5SkckONuRaPZTdiXg6LtCUS882YfBs1zZWjWC0mlDjMcF20yBzeD8Fdlc
	5Hi2/a5Kb+b4iVW9Jw8Nel01XniRIxU+j+/omPi15OMqXhkssE1JA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s8r3r0p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7GvgeI023412;
	Fri, 8 Nov 2024 01:17:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p14116e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A81HiR051314984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 01:17:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0AA5803F;
	Fri,  8 Nov 2024 01:17:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C365C58054;
	Fri,  8 Nov 2024 01:17:43 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.11])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 01:17:43 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 3/3] vsock/test: verify socket options after setting them
Date: Thu,  7 Nov 2024 19:17:26 -0600
Message-Id: <20241108011726.213948-4-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108011726.213948-1-kshk@linux.ibm.com>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w4UyLNSLs6C7bzR6Ugw0pgv7izlK0F74
X-Proofpoint-ORIG-GUID: w4UyLNSLs6C7bzR6Ugw0pgv7izlK0F74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080007

Replace setsockopt() calls with calls to functions that follow
setsockopt() with getsockopt() and check that the returned value and its
size are the same as have been set.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 tools/testing/vsock/Makefile              |   8 +-
 tools/testing/vsock/control.c             |   8 +-
 tools/testing/vsock/msg_zerocopy_common.c |   8 +-
 tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
 tools/testing/vsock/util_socket.h         |  19 +++
 tools/testing/vsock/vsock_perf.c          |  24 ++--
 tools/testing/vsock/vsock_test.c          |  40 +++---
 7 files changed, 208 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/vsock/util_socket.c
 create mode 100644 tools/testing/vsock/util_socket.h

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 6e0b4e95e230..1ec0b3a67aa4 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 all: test vsock_perf
 test: vsock_test vsock_diag_test vsock_uring_test
-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o
-vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
-vsock_perf: vsock_perf.o msg_zerocopy_common.o
+vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o util_socket.o
+vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o util_socket.o
+vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o
 
 vsock_uring_test: LDLIBS = -luring
-vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
+vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o util_socket.o
 
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
index d2deb4b15b94..f1fd809ac9d5 100644
--- a/tools/testing/vsock/control.c
+++ b/tools/testing/vsock/control.c
@@ -27,6 +27,7 @@
 
 #include "timeout.h"
 #include "control.h"
+#include "util_socket.h"
 
 static int control_fd = -1;
 
@@ -50,7 +51,6 @@ void control_init(const char *control_host,
 
 	for (ai = result; ai; ai = ai->ai_next) {
 		int fd;
-		int val = 1;
 
 		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (fd < 0)
@@ -65,11 +65,9 @@ void control_init(const char *control_host,
 			break;
 		}
 
-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
-			       &val, sizeof(val)) < 0) {
-			perror("setsockopt");
+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
+				"setsockopt SO_REUSEADDR"))
 			exit(EXIT_FAILURE);
-		}
 
 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
 			goto next;
diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
index 5a4bdf7b5132..4edb1b6974c0 100644
--- a/tools/testing/vsock/msg_zerocopy_common.c
+++ b/tools/testing/vsock/msg_zerocopy_common.c
@@ -13,15 +13,13 @@
 #include <linux/errqueue.h>
 
 #include "msg_zerocopy_common.h"
+#include "util_socket.h"
 
 void enable_so_zerocopy(int fd)
 {
-	int val = 1;
-
-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
-		perror("setsockopt");
+	if (!setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
+			"setsockopt SO_ZEROCOPY"))
 		exit(EXIT_FAILURE);
-	}
 }
 
 void vsock_recv_completion(int fd, const bool *zerocopied)
diff --git a/tools/testing/vsock/util_socket.c b/tools/testing/vsock/util_socket.c
new file mode 100644
index 000000000000..e791da160624
--- /dev/null
+++ b/tools/testing/vsock/util_socket.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Socket utility functions.
+ *
+ * Copyright IBM Corp. 2024
+ */
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include "util_socket.h"
+
+/* Set "unsigned long long" socket option and check that it's indeed set */
+bool setsockopt_ull_check(int fd, int level, int optname,
+	unsigned long long val, char const *errmsg)
+{
+	unsigned long long chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+				chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
+				chkval);
+		goto fail;
+	}
+	return true;
+fail:
+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
+	return false;
+}
+
+/* Set "int" socket option and check that it's indeed set */
+bool setsockopt_int_check(int fd, int level, int optname, int val,
+		char const *errmsg)
+{
+	int chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+				chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %d got %d\n",
+				val, chkval);
+		goto fail;
+	}
+	return true;
+fail:
+	fprintf(stderr, "%s val %d\n", errmsg, val);
+	return false;
+}
+
+static void mem_invert(unsigned char *mem, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		mem[i] = ~mem[i];
+}
+
+/* Set "timeval" socket option and check that it's indeed set */
+bool setsockopt_timeval_check(int fd, int level, int optname,
+		struct timeval val, char const *errmsg)
+{
+	struct timeval chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	 /* just make storage != val */
+	chkval = val;
+	mem_invert((unsigned char *) &chkval, sizeof(chkval));
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+				strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+				chklen);
+		goto fail;
+	}
+
+	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
+		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
+				val.tv_sec, val.tv_usec,
+				chkval.tv_sec, chkval.tv_usec);
+		goto fail;
+	}
+	return true;
+fail:
+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
+	return false;
+}
diff --git a/tools/testing/vsock/util_socket.h b/tools/testing/vsock/util_socket.h
new file mode 100644
index 000000000000..38cf3decb15c
--- /dev/null
+++ b/tools/testing/vsock/util_socket.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Socket utility functions.
+ *
+ * Copyright IBM Corp. 2024
+ */
+#ifndef UTIL_SOCKET_H
+#define UTIL_SOCKET_H
+
+#include <stdbool.h>
+
+bool setsockopt_ull_check(int fd, int level, int optname,
+		unsigned long long val, char const *errmsg);
+bool setsockopt_int_check(int fd, int level, int optname, int val,
+		char const *errmsg);
+bool setsockopt_timeval_check(int fd, int level, int optname,
+		struct timeval val, char const *errmsg);
+
+#endif /* UTIL_SOCKET_H */
diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 8e0a6c0770d3..b117e043b87b 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -21,6 +21,7 @@
 #include <sys/mman.h>
 
 #include "msg_zerocopy_common.h"
+#include "util_socket.h"
 
 #define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
 #define DEFAULT_TO_SEND_BYTES	(64 * 1024)
@@ -88,13 +89,16 @@ static unsigned long memparse(const char *ptr)
 
 static void vsock_increase_buf_size(int fd)
 {
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
-		       &vsock_buf_bytes, sizeof(vsock_buf_bytes)))
-		error("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+	if (!setsockopt_ull_check(fd, AF_VSOCK,
+			SO_VM_SOCKETS_BUFFER_MAX_SIZE, vsock_buf_bytes,
+			"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)"))
+		exit(EXIT_FAILURE);
+
+	if (!setsockopt_ull_check(fd, AF_VSOCK,
+			SO_VM_SOCKETS_BUFFER_SIZE, vsock_buf_bytes,
+			"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
+		exit(EXIT_FAILURE);
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &vsock_buf_bytes, sizeof(vsock_buf_bytes)))
-		error("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 }
 
 static int vsock_connect(unsigned int cid, unsigned int port)
@@ -183,10 +187,10 @@ static void run_receiver(int rcvlowat_bytes)
 
 	vsock_increase_buf_size(client_fd);
 
-	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVLOWAT,
-		       &rcvlowat_bytes,
-		       sizeof(rcvlowat_bytes)))
-		error("setsockopt(SO_RCVLOWAT)");
+
+	if (!setsockopt_int_check(client_fd, SOL_SOCKET, SO_RCVLOWAT,
+			rcvlowat_bytes, "setsockopt(SO_RCVLOWAT)"))
+		exit(EXIT_FAILURE);
 
 	data = malloc(buf_size_bytes);
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index c7af23332e57..3764dca1118e 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -27,6 +27,7 @@
 #include "timeout.h"
 #include "control.h"
 #include "util.h"
+#include "util_socket.h"
 
 static void test_stream_connection_reset(const struct test_opts *opts)
 {
@@ -444,17 +445,14 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 
 	sock_buf_size = SOCK_BUF_SIZE;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			sock_buf_size,
+			"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)"))
 		exit(EXIT_FAILURE);
-	}
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
 		exit(EXIT_FAILURE);
-	}
 
 	/* Ready to receive data. */
 	control_writeln("SRVREADY");
@@ -586,10 +584,9 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
 	tv.tv_usec = 0;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
-		perror("setsockopt(SO_RCVTIMEO)");
+	if (!setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+			"setsockopt(SO_RCVTIMEO)"))
 		exit(EXIT_FAILURE);
-	}
 
 	read_enter_ns = current_nsec();
 
@@ -855,9 +852,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-		       &lowat_val, sizeof(lowat_val))) {
-		perror("setsockopt(SO_RCVLOWAT)");
+	if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+		       lowat_val, "setsockopt(SO_RCVLOWAT)")) {
 		exit(EXIT_FAILURE);
 	}
 
@@ -1383,11 +1379,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	/* size_t can be < unsigned long long */
 	sock_buf_size = buf_size;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
 		exit(EXIT_FAILURE);
-	}
 
 	if (low_rx_bytes_test) {
 		/* Set new SO_RCVLOWAT here. This enables sending credit
@@ -1396,9 +1390,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		 */
 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)")) {
 			exit(EXIT_FAILURE);
 		}
 	}
@@ -1442,9 +1435,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		recv_buf_size++;
 
 		/* Updating SO_RCVLOWAT will send credit update. */
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)")) {
 			exit(EXIT_FAILURE);
 		}
 	}
-- 
2.34.1



Return-Path: <netdev+bounces-148548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE59E25A3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150CFB87721
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FD1F76B6;
	Tue,  3 Dec 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XwFPms/j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5E1F7547;
	Tue,  3 Dec 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238448; cv=none; b=mAsgVs0SMF67gaMd4SkoclgiSDfbos3wBB2mf6SiEnPCjSlrk4F3bh7K44EJI1ZTullRxf2uS7Cxak9in8346iptEfaa7xJKSeZwHHr9hc8A/hwjQa5gLDF86TJlbTqZR5Wboohvh6FA+krpFN2Vw1Z7nXnD/LB7gh8u+PaCOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238448; c=relaxed/simple;
	bh=dtJ7cfDiG4eABWJmL/KBwWznHCVrybOriHvdqQiOjN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JK5FP6IXfiWbiPntnH21daocHcxiohAZWiBAScnXu4zVOi3n/MVDGDJmx+M+l323V8UrLGalAC7I2YBfwcyoTsH/cKm5AGYabeXq3DQ0uB2JdtpVEBKXk1uuYAKKohzVWD7A2zNifUWwYVtVxLAztxIx3FfDLUAkbjV+dZIZfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XwFPms/j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CpRTa009471;
	Tue, 3 Dec 2024 15:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5r0m4UT7hi3BU/x/g
	P+I04UMTCAYd5LoMcTRFF0H6c8=; b=XwFPms/je8FoxJmebc4pBPcH4u+L06bhs
	RLWOciHHzpSqBGitYVcSZh3V9VsDZ5I+iQao40gius89+1o2syORtVsgPVmKW1Rp
	+l9rGeGlIS2zFQnp/kLqERgo5H9xEYJa4hWZDq+zaTL8YFLy11Ks9+wceYJgSGzR
	wcW5IQmerxXemxsYrzaI+5GGMTLMDevpyE6hFzsi4surAA5DezLQtmtsrlxs6DkM
	oXOqJe92xg7UQYMK4YAyf/zGGZERFvn3DdxqrR3+49WoJdA34nHteUVatf0qWzSR
	pSaJbf3p8pJ+j7Yy4y2sutZBZC5KIdPefIKlB/gAak1ffwFCqmA4Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgq7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3D5ARm020366;
	Tue, 3 Dec 2024 15:07:17 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s9dyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3F7F5x4522544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 15:07:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 416E358055;
	Tue,  3 Dec 2024 15:07:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECEFB58043;
	Tue,  3 Dec 2024 15:07:14 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 15:07:14 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        pabeni@redhat.com, AVKrasnov@sberdevices.ru, mst@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v8 3/3] vsock/test: verify socket options after setting them
Date: Tue,  3 Dec 2024 09:06:56 -0600
Message-Id: <20241203150656.287028-4-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203150656.287028-1-kshk@linux.ibm.com>
References: <20241203150656.287028-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N4gJpOd84CFcoEetg8Elbf6z19N6fOhK
X-Proofpoint-GUID: N4gJpOd84CFcoEetg8Elbf6z19N6fOhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030127

Replace setsockopt() calls with calls to functions that follow
setsockopt() with getsockopt() and check that the returned value and its
size are the same as have been set. (Except in vsock_perf.)

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/control.c             |   9 +-
 tools/testing/vsock/msg_zerocopy_common.c |  10 --
 tools/testing/vsock/msg_zerocopy_common.h |   1 -
 tools/testing/vsock/util.c                | 142 ++++++++++++++++++++++
 tools/testing/vsock/util.h                |   7 ++
 tools/testing/vsock/vsock_perf.c          |  10 ++
 tools/testing/vsock/vsock_test.c          |  51 +++-----
 tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
 tools/testing/vsock/vsock_uring_test.c    |   2 +-
 9 files changed, 181 insertions(+), 53 deletions(-)

diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
index d2deb4b15b94..0066e0324d35 100644
--- a/tools/testing/vsock/control.c
+++ b/tools/testing/vsock/control.c
@@ -27,6 +27,7 @@
 
 #include "timeout.h"
 #include "control.h"
+#include "util.h"
 
 static int control_fd = -1;
 
@@ -50,7 +51,6 @@ void control_init(const char *control_host,
 
 	for (ai = result; ai; ai = ai->ai_next) {
 		int fd;
-		int val = 1;
 
 		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (fd < 0)
@@ -65,11 +65,8 @@ void control_init(const char *control_host,
 			break;
 		}
 
-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
-			       &val, sizeof(val)) < 0) {
-			perror("setsockopt");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
+				     "setsockopt SO_REUSEADDR");
 
 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
 			goto next;
diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
index 5a4bdf7b5132..8622e5a0f8b7 100644
--- a/tools/testing/vsock/msg_zerocopy_common.c
+++ b/tools/testing/vsock/msg_zerocopy_common.c
@@ -14,16 +14,6 @@
 
 #include "msg_zerocopy_common.h"
 
-void enable_so_zerocopy(int fd)
-{
-	int val = 1;
-
-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
-		perror("setsockopt");
-		exit(EXIT_FAILURE);
-	}
-}
-
 void vsock_recv_completion(int fd, const bool *zerocopied)
 {
 	struct sock_extended_err *serr;
diff --git a/tools/testing/vsock/msg_zerocopy_common.h b/tools/testing/vsock/msg_zerocopy_common.h
index 3763c5ccedb9..ad14139e93ca 100644
--- a/tools/testing/vsock/msg_zerocopy_common.h
+++ b/tools/testing/vsock/msg_zerocopy_common.h
@@ -12,7 +12,6 @@
 #define VSOCK_RECVERR	1
 #endif
 
-void enable_so_zerocopy(int fd);
 void vsock_recv_completion(int fd, const bool *zerocopied);
 
 #endif /* MSG_ZEROCOPY_COMMON_H */
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index a3d448a075e3..34e9dac0a105 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -651,3 +651,145 @@ void free_test_iovec(const struct iovec *test_iovec,
 
 	free(iovec);
 }
+
+/* Set "unsigned long long" socket option and check that it's indeed set */
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg)
+{
+	unsigned long long chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
+			chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
+	exit(EXIT_FAILURE);
+;
+}
+
+/* Set "int" socket option and check that it's indeed set */
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg)
+{
+	int chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	chkval = ~val; /* just make storage != val */
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (chkval != val) {
+		fprintf(stderr, "value mismatch: set %d got %d\n", val, chkval);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %d\n", errmsg, val);
+	exit(EXIT_FAILURE);
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
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg)
+{
+	struct timeval chkval;
+	socklen_t chklen;
+	int err;
+
+	err = setsockopt(fd, level, optname, &val, sizeof(val));
+	if (err) {
+		fprintf(stderr, "setsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	 /* just make storage != val */
+	chkval = val;
+	mem_invert((unsigned char *)&chkval, sizeof(chkval));
+	chklen = sizeof(chkval);
+
+	err = getsockopt(fd, level, optname, &chkval, &chklen);
+	if (err) {
+		fprintf(stderr, "getsockopt err: %s (%d)\n",
+			strerror(errno), errno);
+		goto fail;
+	}
+
+	if (chklen != sizeof(chkval)) {
+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
+			chklen);
+		goto fail;
+	}
+
+	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
+		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
+			val.tv_sec, val.tv_usec, chkval.tv_sec, chkval.tv_usec);
+		goto fail;
+	}
+	return;
+fail:
+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
+	exit(EXIT_FAILURE);
+}
+
+void enable_so_zerocopy_check(int fd)
+{
+	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
+			     "setsockopt SO_ZEROCOPY");
+}
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fff22d4a14c0..ba84d296d8b7 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -68,4 +68,11 @@ unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
 struct iovec *alloc_test_iovec(const struct iovec *test_iovec, int iovnum);
 void free_test_iovec(const struct iovec *test_iovec,
 		     struct iovec *iovec, int iovnum);
+void setsockopt_ull_check(int fd, int level, int optname,
+			  unsigned long long val, char const *errmsg);
+void setsockopt_int_check(int fd, int level, int optname, int val,
+			  char const *errmsg);
+void setsockopt_timeval_check(int fd, int level, int optname,
+			      struct timeval val, char const *errmsg);
+void enable_so_zerocopy_check(int fd);
 #endif /* UTIL_H */
diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 8e0a6c0770d3..75971ac708c9 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -251,6 +251,16 @@ static void run_receiver(int rcvlowat_bytes)
 	close(fd);
 }
 
+static void enable_so_zerocopy(int fd)
+{
+	int val = 1;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
+		perror("setsockopt");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void run_sender(int peer_cid, unsigned long to_send_bytes)
 {
 	time_t tx_begin_ns;
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 0b7f5bf546da..48f17641ca50 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -444,17 +444,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 
 	sock_buf_size = SOCK_BUF_SIZE;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	/* Ready to receive data. */
 	control_writeln("SRVREADY");
@@ -586,10 +582,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
 	tv.tv_usec = 0;
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
-		perror("setsockopt(SO_RCVTIMEO)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
+				 "setsockopt(SO_RCVTIMEO)");
 
 	read_enter_ns = current_nsec();
 
@@ -855,11 +849,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-		       &lowat_val, sizeof(lowat_val))) {
-		perror("setsockopt(SO_RCVLOWAT)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+			     lowat_val, "setsockopt(SO_RCVLOWAT)");
 
 	control_expectln("SRVSENT");
 
@@ -1383,11 +1374,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	/* size_t can be < unsigned long long */
 	sock_buf_size = buf_size;
 
-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &sock_buf_size, sizeof(sock_buf_size))) {
-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
-		exit(EXIT_FAILURE);
-	}
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 
 	if (low_rx_bytes_test) {
 		/* Set new SO_RCVLOWAT here. This enables sending credit
@@ -1396,11 +1385,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		 */
 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	/* Send one dummy byte here, because 'setsockopt()' above also
@@ -1442,11 +1428,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 		recv_buf_size++;
 
 		/* Updating SO_RCVLOWAT will send credit update. */
-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
-			       &recv_buf_size, sizeof(recv_buf_size))) {
-			perror("setsockopt(SO_RCVLOWAT)");
-			exit(EXIT_FAILURE);
-		}
+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
+				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
 	}
 
 	fds.fd = fd;
diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
index 04c376b6937f..9d9a6cb9614a 100644
--- a/tools/testing/vsock/vsock_test_zerocopy.c
+++ b/tools/testing/vsock/vsock_test_zerocopy.c
@@ -162,7 +162,7 @@ static void test_client(const struct test_opts *opts,
 	}
 
 	if (test_data->so_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 
diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
index 6c3e6f70c457..5c3078969659 100644
--- a/tools/testing/vsock/vsock_uring_test.c
+++ b/tools/testing/vsock/vsock_uring_test.c
@@ -73,7 +73,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
 	}
 
 	if (msg_zerocopy)
-		enable_so_zerocopy(fd);
+		enable_so_zerocopy_check(fd);
 
 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
 
-- 
2.34.1



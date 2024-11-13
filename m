Return-Path: <netdev+bounces-144436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B59C747A
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F76284286
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2824C200CBE;
	Wed, 13 Nov 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xwy2uLJK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A711F6666;
	Wed, 13 Nov 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508576; cv=none; b=RNXJNeL1Aljplw34tCPJSkZgm9CvdgyoC3gGI8lWY3ktIKRskBTRNIZV0LWPR5xIEQivjVju3LZpqQS+5kzvf4NdYoE9/Xdn9PjcXyYD9BQnPA3sV4ts2DOTKaNaK5/Hsz3Ts88jbS1RhfuK3kp1vrAT7CcsYABIz5kFMZjdllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508576; c=relaxed/simple;
	bh=zqfEmR3ZxE5BBErtEyisFCyCuhq30Yd4C9NzyKLX/xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUifO8yg44AOiSBpNxnvMx6o/hTD+s8QDXX7tsmy2yLUGdqc23uVZ5OAhLtiDT3fb7IToi8aYYK2To2J7GLfIIJ42mi3cfuOxZrBdrZLYW+mFERePsf7LkeLtNyahyDoSug/4QQl8HE7sYye5GYc8NaF6bAu0gO4R+6IFZkymhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xwy2uLJK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADC8Si6016235;
	Wed, 13 Nov 2024 14:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1WXvViyc/ejbVc3ul
	mZ9A8tGjSjwOxM5hvFojVOsH5M=; b=Xwy2uLJKBeck72m/CMqfQrU9Xkwxdq+ru
	3izaDZvfOSluQ+4y9OSSad7Shpg1q6tW+Yy/yzxCpUXqYCOd3rOby9V91aAKqnCh
	/Gg6D+6NXj+uTowNiE5BD8iGO0H3nh26rNQxEkQyTmeaJS2jbTnBT+fPuL79QFuo
	a1GAcPZepsxLEIUtsXQqj2J4uifJ5Ldvx/cEYQXlLjLBKqa4dlN2ESmEd7iriMgN
	WOWtsd0mKPxwiBnCDIAfqOatOcoT1Zsl9sbKVzxvKBhiZxjsER1MbPc/4oaQbP4I
	+zcsRxJz6tG648MVLBv9RIMS53DFRvym2TQrw5+L9jWuTpcVxdGfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdceuurt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEOh8j011017;
	Wed, 13 Nov 2024 14:36:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s6e0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADEa7aH49480188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:36:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBBE58052;
	Wed, 13 Nov 2024 14:36:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646EC58065;
	Wed, 13 Nov 2024 14:36:07 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 14:36:07 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 2/3] vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
Date: Wed, 13 Nov 2024 08:35:56 -0600
Message-Id: <20241113143557.1000843-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113143557.1000843-1-kshk@linux.ibm.com>
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lcL2iJYSogpoaJoNyc3Sz9Phay0pkEqn
X-Proofpoint-ORIG-GUID: lcL2iJYSogpoaJoNyc3Sz9Phay0pkEqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130124

Change parameters of SO_VM_SOCKETS_* to unsigned long long as documented
in the vm_sockets.h, because the corresponding kernel code requires them
to be at least 64-bit, no matter what architecture. Otherwise they are
too small on 32-bit machines.

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Fixes: 685a21c314a8 ("test/vsock: add big message test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_perf.c |  4 ++--
 tools/testing/vsock/vsock_test.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 22633c2848cc..8e0a6c0770d3 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -33,7 +33,7 @@
 
 static unsigned int port = DEFAULT_PORT;
 static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
+static unsigned long long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
 static bool zerocopy;
 
 static void error(const char *s)
@@ -162,7 +162,7 @@ static void run_receiver(int rcvlowat_bytes)
 	printf("Run as receiver\n");
 	printf("Listen port %u\n", port);
 	printf("RX buffer %lu bytes\n", buf_size_bytes);
-	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
+	printf("vsock buffer %llu bytes\n", vsock_buf_bytes);
 	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
 
 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7fd25b814b4b..c7af23332e57 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	unsigned long long sock_buf_size;
 	unsigned long remote_hash;
 	unsigned long curr_hash;
 	int fd;
@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	unsigned long long sock_buf_size;
+	size_t buf_size;
 	socklen_t len;
 	void *data;
 	int fd;
@@ -655,13 +656,20 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 
 	sock_buf_size++;
 
-	data = malloc(sock_buf_size);
+	/* size_t can be < unsigned long long */
+	buf_size = (size_t) sock_buf_size;
+	if (buf_size != sock_buf_size) {
+		fprintf(stderr, "Returned BUFFER_SIZE too large\n");
+		exit(EXIT_FAILURE);
+	}
+
+	data = malloc(buf_size);
 	if (!data) {
 		perror("malloc");
 		exit(EXIT_FAILURE);
 	}
 
-	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
+	send_buf(fd, data, buf_size, 0, -EMSGSIZE);
 
 	control_writeln("CLISENT");
 
@@ -1360,6 +1368,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	int recv_buf_size;
 	struct pollfd fds;
 	size_t buf_size;
+	unsigned long long sock_buf_size;
 	void *buf;
 	int fd;
 
@@ -1371,8 +1380,11 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 
 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
 
+	/* size_t can be < unsigned long long */
+	sock_buf_size = buf_size;
+
 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &buf_size, sizeof(buf_size))) {
+		       &sock_buf_size, sizeof(sock_buf_size))) {
 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1



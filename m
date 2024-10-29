Return-Path: <netdev+bounces-139954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846009B4C95
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA936B230AA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFB194C7D;
	Tue, 29 Oct 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPYdAEjB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66141194ACF;
	Tue, 29 Oct 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213412; cv=none; b=YOTisUkQtgNLWBzAW/OEnUIGyOw30D7CS+yxMgT6wTx9bi0GMB/i1BiEObVXsalHDwBI4sAM0/IDvvGnIXyKnmZiNFMaW3dWYFHNF3EX/7oXmM6GNpPZ4zalKW9Aoo4R+b5neMty+OwbxNH/sQO/c817/T/7d3lu4ILl+K+IaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213412; c=relaxed/simple;
	bh=F/LW19ymPPlR9IWT73D3azwwuXjzFN5svQLs7cxPAcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzxhuED+AXR57jz2w6XffjxXgxc3o7qlIAu3a/aAM9IOTMMMAUBTwhO6XN6OnxjMmZbmbPuVl7dESsziSnc+T4TrC7mfioulhxCu4rA0vH7ePy8mkcitx+HlsCGAFkpNzTHriMpQnSMkq1Gcp4FDDQoQpbvkGklXXTVbeuiK8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPYdAEjB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T25Qaq023299;
	Tue, 29 Oct 2024 14:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7vVYXuC1ioSQfQx6O
	/drkWaQfdD8ocUarmEpHbaRvcE=; b=cPYdAEjB1XR1oDM2Ozas+2enmOkoPrFUJ
	z3N6xY/JGd6DS9CYHxyveo2RvJCTZKll2R3qH9fGAiQj0lIwTQwVHAByDefhWrll
	pQN0kGXlyI3sMdckDGPxf+Kjky/TAjMEVQ+eXPWYfW81+4HagsA6JgnGuSNscqr7
	7RlzT/M0KgW3C7uze83LcZFpND1wGx9END8Eyezfe9g+wZanJGdVZ1dWQh//4MRx
	aduSNeVJoDkjqK8SxIKgiE825deWp4p9f2gstgwvv+E4iCMG6fdqzLSAcs8Rvbzt
	zzvFElSoyrSMzY/HwHcw/1NaxTmpxMHKEn4/NAYo5jN0qMW/pqjaQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43g16dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:50:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAS5Tt018404;
	Tue, 29 Oct 2024 14:50:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8k3d9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:50:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TEo2uk37814880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:50:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1140458058;
	Tue, 29 Oct 2024 14:50:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C6558063;
	Tue, 29 Oct 2024 14:50:00 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 14:50:00 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 2/2] vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
Date: Tue, 29 Oct 2024 09:49:54 -0500
Message-Id: <20241029144954.285279-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029144954.285279-1-kshk@linux.ibm.com>
References: <20241029144954.285279-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EbXK0FdnjQF3oYcSmTB5VL-udFTIRBO7
X-Proofpoint-ORIG-GUID: EbXK0FdnjQF3oYcSmTB5VL-udFTIRBO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=921 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290110

Change parameters of SO_VM_SOCKETS_* to uint64_t so that they are always
64-bit, because the corresponding kernel code requires them to be at least
that large, no matter what architecture.

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Fixes: 685a21c314a8 ("test/vsock: add big message test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 tools/testing/vsock/vsock_perf.c |  2 +-
 tools/testing/vsock/vsock_test.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 22633c2848cc..88f6be4162a6 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -33,7 +33,7 @@
 
 static unsigned int port = DEFAULT_PORT;
 static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
+static uint64_t vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
 static bool zerocopy;
 
 static void error(const char *s)
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7fd25b814b4b..49a32515886f 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	uint64_t sock_buf_size;
 	unsigned long remote_hash;
 	unsigned long curr_hash;
 	int fd;
@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	uint64_t sock_buf_size;
+	size_t buf_size;
 	socklen_t len;
 	void *data;
 	int fd;
@@ -655,13 +656,19 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 
 	sock_buf_size++;
 
-	data = malloc(sock_buf_size);
+	buf_size = (size_t) sock_buf_size; /* size_t can be < uint64_t */
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
 
@@ -1360,6 +1367,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	int recv_buf_size;
 	struct pollfd fds;
 	size_t buf_size;
+	uint64_t sock_buf_size;
 	void *buf;
 	int fd;
 
@@ -1370,9 +1378,10 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	}
 
 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
+	sock_buf_size = buf_size; /* size_t can be < uint64_t */
 
 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &buf_size, sizeof(buf_size))) {
+		       &sock_buf_size, sizeof(sock_buf_size))) {
 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1



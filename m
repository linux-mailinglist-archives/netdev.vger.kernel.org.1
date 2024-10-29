Return-Path: <netdev+bounces-139953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB19B4C92
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26E81C21339
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3D1946BB;
	Tue, 29 Oct 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JcW3OYbn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F822190679;
	Tue, 29 Oct 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213409; cv=none; b=Yq5mYsTc23zbFIGwVrNHYDiU0Q7oiTsntLQzVy+Hu5ttm8oHKI4NdVnsgqUV90LD1+v4hwFMmYRweed0hfPYc+fKaTquMmiaKIcj2VY8RWzUmqsh/UyaCncq9my9SgJg0mHXJHZAESxIkYK0O+axGyNSDJPf41NJNx31bjIaA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213409; c=relaxed/simple;
	bh=icntjnGysQ+hEHpDE9l/ljFz9vl8wA8BHuRskt5DZkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikTT5NmqHOkzOXtw2kxReZ9EmXE68wnmTQ0+iT1b16joOqNoCV1Qd5+XJuYcY/IpXiRj/Ae6Tchwre9DSyaECYFdxccZqWhxzpl2t49D3TRwNAm+VoNxgpKU2zgqEI131Ul9pO8q98ngifTZrln8ZgBnWxixGbKWkAH7donF5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JcW3OYbn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T4o221031994;
	Tue, 29 Oct 2024 14:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zQ0K3g3G6sAWCVQAB
	OYxVi1Yu2obe6oJxQWPuvuV0RI=; b=JcW3OYbnxFYQ3uIqe00I0y8Znjk9eM4dp
	Yy4vWjvpEzIVTIkcB8hke17a0IHF5tkkHBpn5tQfVapyuI4AQGP+B13maSuYZNDW
	R7B7/YsgLC+tDWNy1b+tr/SGxEeebix7z/2KKAL3Lypo3xwHnCUVwR2H8p4UjkNa
	ytDc7vk7WVdAvnF374tm+p1e4ZlK0KLHsJ/MGFJHht1iXYI1YVSrhdFvsXvG824p
	EDEqBWO80JrGqChDcvGL49e/6DqJHmiBfCdwnBzR5+KrramBhfuFNtJd1NZ+Odtd
	kr5gHRm3vnY5bqvkGoQ6KkY/fbZ/i0RJxWSnN/HEvfy8aDI0b3DTg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42js0h2ptg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:50:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAXXOe013506;
	Tue, 29 Oct 2024 14:50:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hbrmuf5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:50:01 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49TEo0Bu52035846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 14:50:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0303458057;
	Tue, 29 Oct 2024 14:50:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB17358058;
	Tue, 29 Oct 2024 14:49:59 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2024 14:49:59 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 1/2] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Tue, 29 Oct 2024 09:49:53 -0500
Message-Id: <20241029144954.285279-2-kshk@linux.ibm.com>
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
X-Proofpoint-GUID: vIxV5MmCOas8SIScRPZUoFjCYzr1zREp
X-Proofpoint-ORIG-GUID: vIxV5MmCOas8SIScRPZUoFjCYzr1zREp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290110

This happens on 64-bit big-endian machines.
SO_RCVLOWAT requires an int parameter. However, instead of int, the test
uses unsigned long in one place and size_t in another. Both are 8 bytes
long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
test for the exact size of the parameter, it only cares that it's >=
sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
returns with success and the socket stays with the default SO_RCVLOWAT = 1,
which results in vsock_test failures, while vsock_perf doesn't even notice
that it's failed to change it.

Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_perf.c | 6 +++---
 tools/testing/vsock/vsock_test.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 4e8578f815e0..22633c2848cc 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -133,7 +133,7 @@ static float get_gbps(unsigned long bits, time_t ns_delta)
 	       ((float)ns_delta / NSEC_PER_SEC);
 }
 
-static void run_receiver(unsigned long rcvlowat_bytes)
+static void run_receiver(int rcvlowat_bytes)
 {
 	unsigned int read_cnt;
 	time_t rx_begin_ns;
@@ -163,7 +163,7 @@ static void run_receiver(unsigned long rcvlowat_bytes)
 	printf("Listen port %u\n", port);
 	printf("RX buffer %lu bytes\n", buf_size_bytes);
 	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
-	printf("SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
+	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
 
 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
 
@@ -439,7 +439,7 @@ static long strtolx(const char *arg)
 int main(int argc, char **argv)
 {
 	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
-	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
+	int rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
 	int peer_cid = -1;
 	bool sender = false;
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 8d38dbf8f41f..7fd25b814b4b 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
 
 static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 {
-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
+	int lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
 	short poll_flags;
@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
 static void test_stream_credit_update_test(const struct test_opts *opts,
 					   bool low_rx_bytes_test)
 {
-	size_t recv_buf_size;
+	int recv_buf_size;
 	struct pollfd fds;
 	size_t buf_size;
 	void *buf;
-- 
2.34.1



Return-Path: <netdev+bounces-139163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF569B08AB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAFBB253D6
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302D1607B2;
	Fri, 25 Oct 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s88mfr5N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A221A4AA;
	Fri, 25 Oct 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870915; cv=none; b=S+4v+4fRalwqdLKHEHgyDkh3jmYen1dmHsLENr+puFZIwz5UH+DsLPj7o0iRfVge4nuUey/ENqkJntBZK+ZPLVfhTH7cWv53c5XwRatRSwqnoTy49dxv//HBY4QD4JLWoPvlmr5eiecvidq0TL50GcxEhIt6JzFVUDI/TygIIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870915; c=relaxed/simple;
	bh=NQrucM9x+saoFF0bKhfOtTTsmlsmJGDQESQbN+cJ5T8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAcSWtJCC773eE0f2l1W/Cxnz5QKdnV4/vXhnh4oPUs0d4q+hNtEA03IP3ekeexECDGFDtEPrjUvkwHDC2olNFQETfDF+tf7duBeeaTC/EEtenyVMSd4/hR8y8uX/TNZBJIArq6U+jRb5eVEcflobZh228mCtFSbKDQfx7Y5KFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s88mfr5N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PDpA4b021561;
	Fri, 25 Oct 2024 15:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5LJ+VKt8Wb3JvYVN3+XmhS5GVyUE5yneVa6dfImU/
	6Q=; b=s88mfr5NqxxZLp2ghjviqDWcV4e7B7+RkZ9hCrVxF1rkJle8jAXdvYrFq
	5WkbRV6UQ/o9sv/Ne5SPD19QfoUUveP3X4BfuSVYgkoh+q0S7xAObhVXgvYefKff
	hTft4M9xuR9dbOnqINJm4CHzhHfmq3Va2jrvRQzIM7vP0bvK9WrpPnrU/JNlr0DV
	gPZAur1aBtDiV7RT5ctIir4fgLS0tfxCl9d2fnGFxe2wG5HQ07iWIF0IxGOTT+/G
	vL9KQAzS3jMwdHfu0z7ilNs5WeciMS6OOKdah7s5B+bVGSUDEGjBFBQm8SdBjvgN
	sIvYvhHYnOuyZdEeWD47ZDwGifQjw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw494td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:41:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEDICt014571;
	Fri, 25 Oct 2024 15:41:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk86cj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:41:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49PFfkUM64946464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 15:41:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4CCA58056;
	Fri, 25 Oct 2024 15:41:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED6258052;
	Fri, 25 Oct 2024 15:41:46 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.242.95])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 15:41:46 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Fri, 25 Oct 2024 10:41:24 -0500
Message-Id: <20241025154124.732008-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PJJO1tMEtrrwJ16oFZKthF54PSAHqkis
X-Proofpoint-GUID: PJJO1tMEtrrwJ16oFZKthF54PSAHqkis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250122

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
---

Notes:
    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.
Changes for v3:
- fix the same problem in vsock_perf and update commit message
Changes for v2:
- add "Fixes:" lines to the commit message

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
index f851f8961247..30857dd4ca97 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -833,7 +833,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
 
 static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 {
-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
+	int lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
 	short poll_flags;
@@ -1282,7 +1282,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
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



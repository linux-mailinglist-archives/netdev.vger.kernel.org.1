Return-Path: <netdev+bounces-144435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B29C7479
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A35F287D09
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BE1FBF7F;
	Wed, 13 Nov 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iB6e51ql"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2A52F76;
	Wed, 13 Nov 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508574; cv=none; b=EOGvGP7aLrZ8+SPuPrPqVfqvyo1tp+Y6nFFyyxrYtM+xhBSSxpDJngXhpq52FZfkOzxfZJcSg4+BQTVKjQccPwJvNejnXIK7VBP2DttF5yb1egPHAbQMoMTEhE+7xbwjvoX1joOgthQ9WHsLfXIA8PUkOvLUdMRhpHCX+dMIN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508574; c=relaxed/simple;
	bh=icntjnGysQ+hEHpDE9l/ljFz9vl8wA8BHuRskt5DZkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4xAlFk+4UwoykFPVYMau45zFSmTMpBa/L/P/cX+jNfHTzNBXMpWlCCgsLAnjVWlfPSoz6jEnhg5MgmFwzWMpgfibP5PrWCpXGWuKVNi4ksMtrVBV9YBZapOVZo/JoYjCIHFNpq4e5fBZLT240FZmc0zoocuRf4vjgNPZcZ5/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iB6e51ql; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDQKcW016314;
	Wed, 13 Nov 2024 14:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zQ0K3g3G6sAWCVQAB
	OYxVi1Yu2obe6oJxQWPuvuV0RI=; b=iB6e51ql2tanqrVO8+wtZ+nwedPYfPBh8
	ue1eAoa9DW7gE+GsisZCL5woziyb/tBoDoYVJoNFapxI9jrOK7sf9pJwHyteaN1+
	a2t3WmNa4RNQWsS1vPs2GpMTYBt4KBi2CoBEa+Edty7zr28YVQt5TKEt91B6cSZE
	/0yNAdP33+DAIk7ezyDM+4kAhMXw3uU3OrRso2pRDPQD46cC+nspWiZ/4FOBybMX
	nmwELMMe7agaVE5J9qUylg/osdKUyfKx5/1q5bdNRa50HuErgqRSOd1jQGy7jcPN
	I+NLXYBiUaxjXlWreZbRz72m/4Kcf+rYAjnVZ8edxzlPRx4Ln9Bsg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdceuurq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD799LI017144;
	Wed, 13 Nov 2024 14:36:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9je8ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADEa63h11207278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:36:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AFC058067;
	Wed, 13 Nov 2024 14:36:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7010958052;
	Wed, 13 Nov 2024 14:36:06 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 14:36:06 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 1/3] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Wed, 13 Nov 2024 08:35:55 -0600
Message-Id: <20241113143557.1000843-2-kshk@linux.ibm.com>
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
X-Proofpoint-GUID: FFpnAEJqpDPd-bdzs4NOGtmiuXCsMSZz
X-Proofpoint-ORIG-GUID: FFpnAEJqpDPd-bdzs4NOGtmiuXCsMSZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130124

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



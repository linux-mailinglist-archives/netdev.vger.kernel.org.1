Return-Path: <netdev+bounces-143126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E119C137E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2679D2836DD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023F199B9;
	Fri,  8 Nov 2024 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bh+b1DGw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A2BE46;
	Fri,  8 Nov 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028671; cv=none; b=hpYMbviTGUs06iJsIn1z8NuzFhqB4uSCO96W+foRmdJ9GLrcaAyX4czubtglP62V4TaPMJZd80nD62bUd0H/m1QS9sLg60vW9mF2eXqdQRG5l92sP4p6U7LeuYT/eQu5g/+ViS2vMUWaj6dqquCnPLQCMXB5a7Hmaz89/36RkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028671; c=relaxed/simple;
	bh=icntjnGysQ+hEHpDE9l/ljFz9vl8wA8BHuRskt5DZkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1MiDX389TVjKPOKtKBRKdHmhIiQEVdHH9e7QUZRl7ynMLqmhtUOYDT0dcyzA1u9zIyk3ztDYLlxC8etm9Ees936jcEKrbsQN70oMTB3+YCYDn7etCVYMPFLftSwMrPuddNYdBOvGO5IWO5twCWegQP1/lfhjpuXMUYWGzpla+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bh+b1DGw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81C0me006963;
	Fri, 8 Nov 2024 01:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zQ0K3g3G6sAWCVQAB
	OYxVi1Yu2obe6oJxQWPuvuV0RI=; b=bh+b1DGw56QEbUx25Qvfgvw95GYpE97GV
	NQECf9xVFi5OrCGFqx4a5mD3/QnMlSVpZAsJ/r3PkV9nlrsVN5ZEPGQ0wGrX/HpP
	nFF75pp89PYJnuPYIki44hL5B/sSSuoCAjJRN/8r2x0b4bd/sQdRpAt8SSXrJEt8
	g3+UZ4pEAKlKNdqmgQuMSlUKUeo3AM2GqciscKeHwKwRVJ0MJwEZJfIZZZbZDSs6
	i+RjhH/i9IqUsWx53vFpH5fOMredcJf0aowIkQcUaRec6MDiB5lyrquLioxcnHHQ
	1I2fjhnPerKMsENIxrTfVp+JJWMalHQDxTqLn9sTyrjMp7bn3qghw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s8r3g10x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MDFmN024253;
	Fri, 8 Nov 2024 01:17:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds9afx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A81HfEf14746280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 01:17:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79BC15804E;
	Fri,  8 Nov 2024 01:17:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C195803F;
	Fri,  8 Nov 2024 01:17:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.11])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 01:17:40 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 1/3] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Thu,  7 Nov 2024 19:17:24 -0600
Message-Id: <20241108011726.213948-2-kshk@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 6QZIHNzUNeVwqW7dyIMBR4f9IEZryN9h
X-Proofpoint-GUID: 6QZIHNzUNeVwqW7dyIMBR4f9IEZryN9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080007

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



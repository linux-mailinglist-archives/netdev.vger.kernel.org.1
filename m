Return-Path: <netdev+bounces-148546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C105A9E2205
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788EEB87553
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A751F75AE;
	Tue,  3 Dec 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gv5P8nPz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FB1F706C;
	Tue,  3 Dec 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238447; cv=none; b=OtmNcRiz9L1CZE7Rq8D0tGidp2DULXioZl3TUFF7vRe8r8s5BUJNXRppqZo3bVwH8Pmxdsmeg3ZVwO1YOsGS9caFtLUbm9qWyVVEHf8D0GUQWuEl2PzznnR8xz63y2otpAKm1Dc3v1XBUGXvsQcXEU+ufdlZLCqEELqVyADpQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238447; c=relaxed/simple;
	bh=icntjnGysQ+hEHpDE9l/ljFz9vl8wA8BHuRskt5DZkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uy+xbCL4eHRRFcilADQp99mxl9S/KVWih4kgv2invfv67+xtAjYi811aod32dMaKZaueiraMlf5qY4A4MiNJ6DtqzGAT23GkMOEn9pzz4eASYaQNFXFOl445XPFDqqF+Z0dVw30xdc/ZHBORhCmZP1/IBIbGFTjx8OiUS4+5MKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gv5P8nPz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CrlNq012690;
	Tue, 3 Dec 2024 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zQ0K3g3G6sAWCVQAB
	OYxVi1Yu2obe6oJxQWPuvuV0RI=; b=Gv5P8nPzYnWJFkfv8trTXYg2HBnEPEnef
	bkMhX8FKQmSwFYBMr3xLYLn4EjwFsC+mnzx6liP2Jjg8FVhK8QQQwC9R38EeSIt+
	L5Imxt/JF77woDoQeZdLb7eoDorAMTEl/ZwWlND/HWCbhSMTwjKzBUKq9a1aG/TN
	3ZJD13e0JAw/gAsyp94ujC05J6k8vmTd1rqAlTaPpwYxA2jUKm5mY5fL5YAF0LZ4
	zK64XyXoxQGvefJCpGCdptygJsriCXm94OtR5UCRNAKwkrMK9QzOztAZW2xEqx5+
	OpwYziN1655ajrgtGVm4NozKmFo53CEpy0/UaDgzQIjzuF4sU39Kg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4j2dpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3D5DRZ020564;
	Tue, 3 Dec 2024 15:07:14 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s9dya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3F7D4F51315434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 15:07:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1197358059;
	Tue,  3 Dec 2024 15:07:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C238258055;
	Tue,  3 Dec 2024 15:07:12 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 15:07:12 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        pabeni@redhat.com, AVKrasnov@sberdevices.ru, mst@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v8 1/3] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Tue,  3 Dec 2024 09:06:54 -0600
Message-Id: <20241203150656.287028-2-kshk@linux.ibm.com>
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
X-Proofpoint-GUID: PClN66sNYqmmnCJzbLCyA-0XCzWJWH9F
X-Proofpoint-ORIG-GUID: PClN66sNYqmmnCJzbLCyA-0XCzWJWH9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030127

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



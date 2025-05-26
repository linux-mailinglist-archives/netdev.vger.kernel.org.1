Return-Path: <netdev+bounces-193441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E408AC40B3
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C6D7A9B02
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287F20C03E;
	Mon, 26 May 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsHqLega"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564C1F463C;
	Mon, 26 May 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267453; cv=none; b=XEBiCs4jvojT7UnmQf1/LxAVMILDVrNwdCXYok6Ai0SDZnTEK7iARWKbbuYJ4XXBaMN6O0pnM1HQqoUH9HXb7wjmRNVtTbUvf9PDlC4Hb3NpEzsDV3lEvvI98J7xDuVGoYVhvPdwd1k6z2CTqDCX9TGSTLfcqD9ZktvEJPcmc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267453; c=relaxed/simple;
	bh=BPzMadv+6y0REco6m/3KTHH6etAqFJH+OU0kdoFoggU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sBMEtUCJ15s39dlp/mEdxgZnoTzzXNQUzJh3ScPv4Rx1GqDOSdCZPs1AHMQHsd36wP8PaMpKMxhJrSgVdCwcKFG6rOutoLIo5kvql6tngcCYvAo+L3LA45+Q7bfCnoZ9mUHEpsgFigHZE1D1lmT7PiRpfdSrBqaCTgkmVXWS0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsHqLega; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QB8SNo002304;
	Mon, 26 May 2025 13:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3c6hymiUmN+Rg7HCY4QK3LteXbtKZUBJA+lVBNURd
	7U=; b=hsHqLegazLreSfsez2oGYh2z1tOg89vK55eHDC2rHvnnPRx0hUmVEvIkj
	CCqjHPZ1ucuQnBoiaww3HmZx2eJ8nU+Mqf8O5mVO81acc6jhKvxtunVt7FFOfodq
	xrZknecWAkj//e32zDQ4ubPVBcPyIUUOQ4k/xfKxNUh4S9KbZnwp4cJg4mJoxqvM
	FsJNOf8pLdCDa+AhXGkC6KW0xG139eH/Tq4lSf+Y5q8P29PsEs59CFrRsyMQIOJv
	/SVMEkpxlE1AgCNWbHRFzDxPesEdkOmM4YvqB6+7oWxgwxc9vyO8WQ4hIr5/eV68
	3QhdTIikKsva84MYVHerKLC90zhQg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46v0p2d8cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 13:50:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q9Or9C007944;
	Mon, 26 May 2025 13:50:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu52x2t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 13:50:44 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54QDohGH29098502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 13:50:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F27158056;
	Mon, 26 May 2025 13:50:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4F05805E;
	Mon, 26 May 2025 13:50:43 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.242.189])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 May 2025 13:50:43 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v2] vsock/test: Fix occasional failure in SOCK_STREAM SHUT_RD test
Date: Mon, 26 May 2025 08:49:49 -0500
Message-Id: <20250526134949.907948-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KLNkpw_zqN2FlZFwL1EjlOzqrFWMiuh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDExNSBTYWx0ZWRfX8uLBm9zuaCCS PtMBhmeQCYiH05VvSB2GPoeM3nP+lXrktzofztIgxl1wp0Xy5+Tmz47AfH3IrTeR02dCVR7tFbB P4X3b/D2UKVKE+THaFri8edpuQycpPvdpvX/61kC8g+VJEjgMQpkQvE3j0515uo9fMEyZL7Oxab
 70d/BH9OM54BGDv0kjU5vrxhNKSQCCfjl0dSeq6Ej0yPrWSPMGGQinnKLjrDldT2CeQCKCUkFZL /bfWiMEHlm+R4x8/ajW91IADDs5xnVaYQXUd6fuGPZM4XkZuh+IH8jFkRBOvh/4muP6J+t2FKyq /HjQeMq/RfJJFfskmC8snCjYrcYURjW1VTy7s4X/cILIJMvce8TurCody8SqEtlB3n/FjXCQfSY
 M10fXH+86GEfNmOWH3LKrDyn4JHkyPgOeZBfACC0ywPdVcvuokuBm1Kue3HD9bh9Ihsg9aDN
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=683471b5 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Qnlq2qKdrR5swm6YVpgA:9
X-Proofpoint-GUID: 1KLNkpw_zqN2FlZFwL1EjlOzqrFWMiuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_06,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260115

The test outputs:
"SOCK_STREAM SHUT_RD...expected send(2) failure, got 1".

It tests that shutdown(fd, SHUT_RD) on one side causes send() to fail on
the other side. However, sometimes there is a delay in delivery of the
SHUT_RD command, send() succeeds and the test fails, even though the
command is properly delivered and send() starts failing several
milliseconds later.

The delay occurs in the kernel because the used buffer notification
callback virtio_vsock_rx_done(), called upon receipt of the SHUT_RD
command, doesn't immediately disable send(). It delegates that to
a kernel thread (via vsock->rx_work). Sometimes that thread is delayed
more than the test expects.

Change the test to keep calling send() until it fails or a timeout occurs.

Fixes: b698bd97c5711 ("test/vsock: shutdowned socket test")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
Changes in v2:
 - Move the new function to utils.c.

 tools/testing/vsock/util.c       | 11 +++++++++++
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 14 ++------------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index de25892f865f..04ac88dc4d3a 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -798,3 +798,14 @@ void enable_so_zerocopy_check(int fd)
 	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
 			     "setsockopt SO_ZEROCOPY");
 }
+
+void vsock_test_for_send_failure(int fd, int send_flags)
+{
+	timeout_begin(TIMEOUT);
+	while (true) {
+		if (send(fd, "A", 1, send_flags) == -1)
+			return;
+		timeout_check("expected send(2) failure");
+	}
+	timeout_end();
+}
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index d1f765ce3eee..58c17cfb63d4 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -79,4 +79,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
 void setsockopt_timeval_check(int fd, int level, int optname,
 			      struct timeval val, char const *errmsg);
 void enable_so_zerocopy_check(int fd);
+void vsock_test_for_send_failure(int fd, int send_flags);
 #endif /* UTIL_H */
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 613551132a96..b68a85a6d929 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1060,15 +1060,9 @@ static void sigpipe(int signo)
 
 static void test_stream_check_sigpipe(int fd)
 {
-	ssize_t res;
-
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	vsock_test_for_send_failure(fd, 0);
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1071,7 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	vsock_test_for_send_failure(fd, MSG_NOSIGNAL);
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.34.1



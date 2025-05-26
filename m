Return-Path: <netdev+bounces-193332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26AAC38AF
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FF3170681
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150E41A5B93;
	Mon, 26 May 2025 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OoXew1jd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6C81A254C;
	Mon, 26 May 2025 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233973; cv=none; b=RLALh6hv7Cy9fc56ZQzyVMnwzPXUvdjzmlqfoL50tcItTNaL/NHjO7wqN1ThrXoEze9mu8XoSxVR+WUrPUbtHFrjKzeBu9QDhNDQu2ZqMhs/mws622SSdxMtzFJ9dCh/J3S3kBT8UEL7YMvErpezQ0PJTfJoMQ7mxgsURm0IsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233973; c=relaxed/simple;
	bh=mn8ba3UTDa4URrSa/YaCqXTzQBlqqLMeOBmtg4InUXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lS/GVFBEvqAJ/kQaul+c8KakwYl9cqNQKbzILECZXLcPsreAA8BfXJYddZtAAxXMmpUx+ctMj/ybL+36XZSrpxW6qmfYHboWf8GQVNzfSHXYs8a3xBFt2kfnpI2jcZhnuCkDXAA/Q2IPtI8asv1QCpojtSkOZOszF6H0NTJ7QKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OoXew1jd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PKe6cS001698;
	Mon, 26 May 2025 04:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=A/2Y9sujCohNMkIn/XEj5QKAxZbDlEiFLj/Bbpg1/
	Ko=; b=OoXew1jdL3xZ7eMIt2UAVW2XlBkhJdm3DeTka3nnqxBs0QdagSuVT04D2
	CKOG0CN7S4NHpzDSEXE9WhVaRGZaK6IJ/szAp2Q8a3ugrcx/GPqbdstxEXd5XUaw
	fthYbkeBjHvvCKmrGtM6uZprex8EtjpyJ+0HIw+MabvWuMuHZFAYh4KWl6jg2LUF
	raVNsY3tUJIVg/6kxeuThb3OMoEfJmDnVhHpiqPsG2MfwF1C4WcDE/cwqXzpO+95
	deQwYvmmQ6CtBb7O7MuxjTbjYY11Lws7xueuycJhkVgrM7eVHoDb80jfIEH2MQQ1
	hUGJ5jx6ZY5IKYochHJD0jfMD1MyQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u5mby608-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 04:32:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q1vueF016644;
	Mon, 26 May 2025 04:32:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureu4t1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 04:32:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54Q4WglU27198140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 04:32:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EE358059;
	Mon, 26 May 2025 04:32:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5533E58043;
	Mon, 26 May 2025 04:32:42 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.243.103])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 May 2025 04:32:42 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net] vsock/test: Fix occasional failure in SOCK_STREAM SHUT_RD test
Date: Sun, 25 May 2025 23:32:20 -0500
Message-Id: <20250526043220.897565-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E9bNpbdl c=1 sm=1 tr=0 ts=6833eeed cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=HT24iyfb7oJRp2wcDU8A:9
X-Proofpoint-GUID: -d6ii3Z_t74ZB3IEDtDn0pcimtKEABzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDAzNSBTYWx0ZWRfX8iLOaLeU+aoC zCzZUz1xaXrsPsXaH9RIfrsYGVqDnqKdW99RAdo8h1uAROKUvvca57wBSCMF4A5Cp/mluyK37ds RjoqKrU53aC4F1wjMCS+RcfsmXxNuR34f5VKsCNrr6mmr9i6xV3y/xF70qv+Zufze0BjvabK71k
 GPIVGXId1MgrmnxwGQ/6TxOLRDXrvMPi5ywELZqKegF923OKQ09ng5ro/tNcOlSZjm3s2+rBN9S yg3HGbROjESG0GRRV18Tv1osvonYaCrnOW+TnDRThyNemw5T1ESVYK4GoaWqHJCMOyZd59nCL6B zWvuMPWvbKaU/7hUkBSrx36sIhS/s9WXrbR5BPEhyLQotoVABMgtGyIdSVKci0yAlunmRnX5R7w
 k4/FkzWrgt+sQeYll6M4A6vbGyHoPMmDn1ksMPtA/X+TloRCmeO0P7GI59qXXvMKBDI+HlIE
X-Proofpoint-ORIG-GUID: -d6ii3Z_t74ZB3IEDtDn0pcimtKEABzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260035

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
 tools/testing/vsock/vsock_test.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 613551132a96..c3b90a94a281 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1058,17 +1058,22 @@ static void sigpipe(int signo)
 	have_sigpipe = 1;
 }
 
-static void test_stream_check_sigpipe(int fd)
+static void test_for_send_failure(int fd, int send_flags)
 {
-	ssize_t res;
+	timeout_begin(TIMEOUT);
+	while (true) {
+		if (send(fd, "A", 1, send_flags) == -1)
+			return;
+		timeout_check("expected send(2) failure");
+	}
+	timeout_end();
+}
 
+static void test_stream_check_sigpipe(int fd)
+{
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	test_for_send_failure(fd, 0);
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1082,7 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	test_for_send_failure(fd, MSG_NOSIGNAL);
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.34.1



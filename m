Return-Path: <netdev+bounces-188605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC9AADDB1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6843A52D0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB47257421;
	Wed,  7 May 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qo0+q8uO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B2202C2D;
	Wed,  7 May 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618534; cv=none; b=onS2ayec8rjZuaKv3U4WZVaHSJatQoMZ9gEJ7aJMl0ehiZ5SHk28iOWagnPmzPqauBO3lao/TsAP+rMIT1TSEo69xCcc3/1DLfUK9U450GOLUWrc1g6IU1xcp65e266FZeYypCnkD/34zaUbSQwgvSvlsy5quVx97+70Us660jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618534; c=relaxed/simple;
	bh=c2liinLUBnSwgh4aiW9HpT6+opg8QrsIjZnsRhmMkRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4jVHVddrBF0vAuHbkB20sVBGLaRJ124TaVBpzTcRnHfhAlA2PQbMzWfoKlFG3d2VBx8VxMNsbI0ob6ReE5FpuKLrJNJQ5xXK2pr9s6+oCPr9SyVYzkwXqKc/kFjwrLM8R7yknFBj66oubjz322oBb0RTWZP6Jkk46zLDo7Zfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qo0+q8uO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547BE9IS017730;
	Wed, 7 May 2025 11:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cULoZ7kaOPQj0/FlnNdSAt+/VqKG2GcHgg3mJovbe
	XQ=; b=Qo0+q8uOIn1eT/oLZ02NTkwJvdXeWA6jNwU8e8TqoLPmvqACieyGtLicY
	a3BC1dabbGQIWi+G+Y3PnC/OxnImPDgfo27H0N+Ckcwm/0sR6BFB/5B1mOKNDEBD
	va9Zwc02ofDtnKvKh+E72TBzc+2/7EuESILUxUF5c/hQj61DBGXE92kpRe/GROf0
	leZjeQAoyuWE5dpq5zYR9feCNAZx/aBEvRcCRh2FuU0Xf2behQGrrQj3QVoPM8mX
	LNdUvD1iBmvGpNapQnLrCfkZ9/csXHuRzLqbcNd+Xkkm6MbYNPxZgOxnsBTkVZjG
	VOk9FL7a1/A/94jVQ/ZF0N1zACAAw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0jt84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 11:48:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5478Vm1R002728;
	Wed, 7 May 2025 11:48:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp0g3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 11:48:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547BmkPS63439152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 11:48:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B069958059;
	Wed,  7 May 2025 11:48:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F65958043;
	Wed,  7 May 2025 11:48:46 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.251])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 11:48:46 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net] vsock/test: Fix occasional failure in SIOCOUTQ tests
Date: Wed,  7 May 2025 06:48:33 -0500
Message-Id: <20250507114833.2503676-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nCLsIGQN4p3M4hHIR0-xue-DU42wrGOL
X-Proofpoint-GUID: nCLsIGQN4p3M4hHIR0-xue-DU42wrGOL
X-Authority-Analysis: v=2.4 cv=LYc86ifi c=1 sm=1 tr=0 ts=681b48a0 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Kg6wQDg3F1ofPJjr4V4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwOSBTYWx0ZWRfX8/UrslnoiAch eyR4G/yJjy8azLUOPE7yv8+ITj7gwrBOMe1/7RVZ23r/2fXllH7HTL/ZiXwScPwqVBSbaS8pOFo xv15Odjum/qXFHLEaNSTNuAjOgXwogDyNrlweOdoxcvlpltpktK6btW5gdbbzKzcUL3b/Mm82Na
 0aMEjrfLCOBbPZ+w0q+6a0QtgfreYVpnYBApnSB6bf7wPUq1r3hSzPxd8A0ldqqcF+vgbl2cg99 9w82Kpy4MPSponuE3R+0/d8mmbInZispDrVCVlGZHLI321SaPtZfVXfbY4D7Hnxkiig48P5+JMQ Vts1jitkE1HamyEB9c8Z8CvEa/itvepy4aFz2m4N8dCeZ/Dgn8TrW8Pyq9ngnt32/Y2jEK0jtWC
 By0ItQ/OCxjD8gvrmFedc0SnVhMHOZkE9CVns3KEv8Z6o/IgzsapW08k6TcfNmpou6hFp+5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070109

These tests:
    "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
    "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".

They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
have been received by the other side. However, sometimes there is a delay
in updating this "unsent bytes" counter, and the test fails even though
the counter properly goes to 0 several milliseconds later.

The delay occurs in the kernel because the used buffer notification
callback virtio_vsock_tx_done(), called upon receipt of the data by the
other side, doesn't update the counter itself. It delegates that to
a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
more than the test expects.

Change the test to try SIOCOUTQ several times with small delays in between.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..143f1cba2d18 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1264,21 +1264,27 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 	control_expectln("RECEIVED");
 
-	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-		} else {
+	/* SIOCOUTQ isn't guaranteed to instantly track sent data */
+	for (int i = 0; i < 10; i++) {
+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		if (ret == 0 && sock_bytes_unsent == 0)
+			goto success;
+
+		if (ret < 0) {
+			if (errno == EOPNOTSUPP) {
+				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+				goto success;
+			}
 			perror("ioctl");
 			exit(EXIT_FAILURE);
 		}
-	} else if (ret == 0 && sock_bytes_unsent != 0) {
-		fprintf(stderr,
-			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
-			sock_bytes_unsent);
-		exit(EXIT_FAILURE);
+		usleep(10 * 1000);
 	}
 
+	fprintf(stderr, "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
+		sock_bytes_unsent);
+	exit(EXIT_FAILURE);
+success:
 	close(fd);
 }
 
-- 
2.34.1



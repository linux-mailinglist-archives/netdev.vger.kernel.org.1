Return-Path: <netdev+bounces-188700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6F4AAE443
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E4216FAA9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC928A41F;
	Wed,  7 May 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lszMnzFx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8728A40B;
	Wed,  7 May 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630915; cv=none; b=AxrhZwAv7b5+LHuIHZM0qYvVBxM7HcTrZa6t7VXzg/nqPEb9GXWVw04QsHk89TzC3iPSIdw2v8Pah8xYaUTFrQoEB+u2uJBen3Y7CG1bDhX5g7tGnuZILFUrru+XB5RJilhw+zbx9KI3LYvXsTPNlQajFYjq+cxB5h3TT8SKAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630915; c=relaxed/simple;
	bh=5tkF3CDM/SiahZE1ey/V/R9PuHe6xmDu1THD4EbU57Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uxi4ZLt1UdpeHux5GV2DOPFWGDcoWwq/qgLklpP6fB8spOGTzzWNSFowSyng/H8LLvzKvKNPvtm+W91swWvWYZ29nAxXoCzbDgVf6tJxtorO2/rbFvBGAa02IJSrFsYA0k7ONkl3rpVDVCgx4uQO8cMtRZDg3PMzOew2ugWxIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lszMnzFx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54795ISI004107;
	Wed, 7 May 2025 15:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uNrmQhTG6hbnUeRlUgPPTB1Jk+T5FRziSefdljTfZ
	YY=; b=lszMnzFxEynDa40P61y45fNpCk784ts7Q0wM2XHskJfIzh7YiG40jcFeK
	/KR4oEJEbDL/mkbQgvouksvIRVcPLNM/nc9+jTCnJzRMn6U0pzjRs1fk/Flp2mJ3
	0fdn59oeQJfZh1vGPwzaAuOj14/pvXFU/h60AF4cR2S8hWd4nKN1ed4x4sJen2Nb
	w+Txfwt5//NswH99gmCYc790VDMmy5c75kyR8gnT9U6JDKPTw4Xra4d7b78iqyMc
	4h2uwruZO2tNJNPNa95Oc+qK4Qcvf4toyNsIO8zCOCaL3JMZcug3tGAVmPrnwKnw
	1ahYPYGzrrohjlB9Uh6nrKY7cRkpA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ft0mcg2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 15:15:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547CDWaF004231;
	Wed, 7 May 2025 15:15:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb25ynx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 15:15:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547FF2rT24707818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 15:15:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB69558062;
	Wed,  7 May 2025 15:15:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848E65805E;
	Wed,  7 May 2025 15:15:05 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.251])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 15:15:05 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ tests
Date: Wed,  7 May 2025 10:14:56 -0500
Message-Id: <20250507151456.2577061-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N5VCJu82kjq3pSZkrKerxRsT73TIubyF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0MiBTYWx0ZWRfX0RBznA7dB3wc o99INo9SP5+GQM+nfpXtHYE7gvSpE+8ms8Vd4ilsnLGkvSCLlUafIj256ntO9yIAdONEm8kJpvf 6DPjNmF28P/0cL6aDXBG5+8BU9rP5ABQoe12o14xDkuDwvqGHiRTGMAIR9P1OSVgudHkaHayUUq
 y+ttoyXDhabtviVhdSnLqGSKPBB9zHycSN8RoFYwKDOOEJunWh3KmMj6+DaLnJM+oFOo1X1jgWJ CcyhHWpjGxwygDGxgzHrhP/hA5x6N76/VNH45SpvqHD7mjtK4lMZW104duVUBx/LUKG0AokBige MKH6Go8PqxHpW7J6ImEbHZJbD7APFiuaQIR9T1PbdvJuljncE2Nsb0nK59H+FafqoBP6/Iqce0b
 Fc90gQ7qMtvE3GMmSQgobebZYFXPDgSJLK/8i+1fuCUWT3aSrWO9itYBpUp5u2l/xOw61Ah2
X-Authority-Analysis: v=2.4 cv=U4eSDfru c=1 sm=1 tr=0 ts=681b78fc cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=3dInbp6vRfHhuKdI63AA:9
X-Proofpoint-GUID: N5VCJu82kjq3pSZkrKerxRsT73TIubyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070142

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

Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
Changes in v2:
 - Use timeout_check() to end polling, instead of counting iterations.

 tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..613551132a96 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1264,21 +1264,25 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 	control_expectln("RECEIVED");
 
-	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-		} else {
+	/* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
+	 * the "RECEIVED" message means that the other side has received the
+	 * data, there can be a delay in our kernel before updating the "unsent
+	 * bytes" counter. Repeat SIOCOUTQ until it returns 0.
+	 */
+	timeout_begin(TIMEOUT);
+	do {
+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		if (ret < 0) {
+			if (errno == EOPNOTSUPP) {
+				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+				break;
+			}
 			perror("ioctl");
 			exit(EXIT_FAILURE);
 		}
-	} else if (ret == 0 && sock_bytes_unsent != 0) {
-		fprintf(stderr,
-			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
-			sock_bytes_unsent);
-		exit(EXIT_FAILURE);
-	}
-
+		timeout_check("SIOCOUTQ");
+	} while (sock_bytes_unsent != 0);
+	timeout_end();
 	close(fd);
 }
 
-- 
2.34.1



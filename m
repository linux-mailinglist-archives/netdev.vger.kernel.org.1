Return-Path: <netdev+bounces-241914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB49C8A4D4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2AF4E1647
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AB2EDD41;
	Wed, 26 Nov 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rJEiXJL1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280D2868AD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166972; cv=none; b=okPeEFOeroT+GLzLcu8Jndz4fNO0ksnofukDHdvgkKP3juc76+3ukTmefmkdtsADukeLRTZVNcwC67iGhXIT35+oor63/WhONYXdzy8Qs9j8W8sSusTI4ZJdPtFng8xcE5IcFK16D0ojdYaECECoSjEsafI590FZ6McXqxjm/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166972; c=relaxed/simple;
	bh=O4gGoJx2vP3qOF1ZvgPkANtdErrgbludkhfPhJsqHno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWIPbSpNL6YfZby/HT0FLdEH8UkASrXTXOOyuRNI1pJuFYdoNJObHDAKKMdVOnTBau6LwZMADDGH4wI5RAZ6n82la8yb8oQ8kU6seOf9RJAfjXZMrg6CoNDqP7cXN0JGRpNSVXkWiuQjph4vVuqVtTf++fdbojBPvLS1ivUEAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rJEiXJL1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ8DfQI005649;
	Wed, 26 Nov 2025 14:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=G5Vqd0r93B10i1z87P15EO59OcIG0RZ8wdsHOKzFq
	UA=; b=rJEiXJL1wJ+pYRn6s2dLpyF+PcESt/6nhANCDl4NDEA/fAtGDJX2Be4qw
	Wa7WQFVCKZv90V/cZHnMxjgEY+iMFCq2+whq7xoJFa9vu+hHptX/lV1gPEtDi9Xa
	7gLkBm4DkqSkMtOzs0gbXXTvoqHuUq1T63/g5aEse66XDWPpB5DbVRTW+KtRY1K+
	q481GYsl8DRljyneklamNDex/356zKvj62CwLHMC/sBt9T5S2CZPTeIiRh1bqFeN
	LujIf15HDP1D33StzqmoLQ1izsy1RGQBWHbgCPJ3ud9IxIQjK3ZYPBF9YqjMip1R
	viW+gnt7wVxTvYzAXOEt3mk1FM9bA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj4rg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:22:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQEGuJf031834;
	Wed, 26 Nov 2025 14:22:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pj4rfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:22:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQE8PeX013839;
	Wed, 26 Nov 2025 14:22:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnb0jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 14:22:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQEMg6F62062964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 14:22:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEBB2004B;
	Wed, 26 Nov 2025 14:22:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B104B20040;
	Wed, 26 Nov 2025 14:22:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 14:22:42 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] dibs: Remove KMSG_COMPONENT macro
Date: Wed, 26 Nov 2025 15:22:42 +0100
Message-ID: <20251126142242.2124317-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX0wl7z6Xp4M81
 7nBe1/NXi2HHPRh3Awkve8/hmTQExrCo1jBECeUgwKSMgc2I6hcnD/JJV24aJi1PRSTa87Ax+Nc
 X1VESOwFUB+1YGC9DCiZPORmD1qo4PwsZmiAOoh3S5hahPZh0C7eU6Yzm71WE+aklKyjG2+Lmor
 D9NdJVwpmTmN7B0S/cJ6HaC0gQvX+iaX5VmO7Xe+Po6KGC5kkokd7OH13s1Lv5OYr/okExNPOrX
 cuu83WYD2twghCagjL/KEqOkIVPkZVzXY5PmhwdiJoEeyMp3TG4MukiLG57+s5SgqIyfi8OR14/
 h6NRdGB9k+6IDSeEU6f4t9TJF8n39afzab+t1gy077U5nxXKjlamnQWSRoY6fEpoUc0qwql25PV
 pOygg/YGgwWNL+Vs4U/SsZ/DFMkOeQ==
X-Proofpoint-ORIG-GUID: dswi6run_7vGqcrLi2kQmCBipti7ywMo
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69270d36 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8
 a=x8b-iUPIWsrqbuzLT4EA:9 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: aEM0bNpRpww3MNFqUqGs3iO3R8-5GeOz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
catalog" from 2008 [1] which never made it upstream.

The macro was added to s390 code to allow for an out-of-tree patch which
used this to generate unique message ids. Also this out-of-tree doesn't
exist anymore.

The pattern of how the KMSG_COMPONENT is used was partially also used for
non s390 specific code, for whatever reasons.

Remove the macro in order to get rid of a pointless indirection.

[1] https://lwn.net/Articles/292650/

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index dac14d843af7..b8c16586706c 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -6,8 +6,7 @@
  *
  *  Copyright IBM Corp. 2025
  */
-#define KMSG_COMPONENT "dibs"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+#define pr_fmt(fmt) "dibs: " fmt
 
 #include <linux/module.h>
 #include <linux/types.h>
-- 
2.51.0



Return-Path: <netdev+bounces-205470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0EAFEDD3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AFD1BC0218
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6112E54D8;
	Wed,  9 Jul 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cctJyvpw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9192E6127
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075234; cv=none; b=bS85056lo+H9VQOFHkFGdmALXTO6sP/TZ92M4kaNhBC76zlmcjwjv7YJF5h5bT8nYWqwjrJ2SWLqfDo0rNt3Kpbs3wfsKcLiy9xV3OBPdoBtfS34mHH10T6W0iMtohrnjn1gCZm8FN8rOyIYwNbSz7C8j0XvcIcobnU3Sxj1VyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075234; c=relaxed/simple;
	bh=ZLaQWqXGQv/+JRAdEgXBm0SPx52hwQqaydSg4LGXTZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bLO2OJ4FgyOeEwChlUXXXab67uI/nByZ8RMFUYTmHaia87mWctvCpkekjYW5QWnPh6DTnt4QfB2FQW5NHgwjIPOP8A0zWUNu3r6Bvoh0UOnfuybmVHPWImzt5vqWUaTAkeiURoI2SD9V8Kvay4dTJ2Uhdn9rnXAHRPPsmaPd60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cctJyvpw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CmBLw026528;
	Wed, 9 Jul 2025 15:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=78bIYBw791i4+HmQoK2JpOwCgNgqhUcyN1ahfrbhs
	AA=; b=cctJyvpwL2dbqPfXv1ecTMVOlc1onXsLUr7Rj/i5oeINFXRRMlPE77ubA
	HWriVa3VUkZG4HirvihRX4ushzDrDqg+a0FDJRxtaVQsVcDTjJIixQ7axNEaEj1X
	DH7Z0V4xfUpBzLfERf35onNjJQlAsx9YW6KVkgG1jfmLTuoAtEHGIz+KSrofqVUY
	f8KbMZqskkHaKL7raW8RAto6Sz6caE2eIgH9AmOf9XNimaymoacH5C3JxsemTafb
	0T0s7Bd9x5FKFGFYT9NkFqhCsoCQP+T+mA4jyD/Ue619uGUlXi9S4cj+GcYYHqXN
	dZ5sXE0Ia+JTl+BJGLH+pTeuF/q1w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyxd00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 15:33:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569Bu54o002888;
	Wed, 9 Jul 2025 15:33:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmgq25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 15:33:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569FXeo726673846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 15:33:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9ED5806B;
	Wed,  9 Jul 2025 15:33:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B4F5806A;
	Wed,  9 Jul 2025 15:33:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.247.211])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 15:33:39 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, nnac123@linux.ibm.com, horms@kernel.org,
        bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH net] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
Date: Wed,  9 Jul 2025 08:33:32 -0700
Message-Id: <20250709153332.73892-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=crubk04i c=1 sm=1 tr=0 ts=686e8bd6 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=iejt9ChpHOqe0sw4oRoA:9
X-Proofpoint-ORIG-GUID: ggG0dmWUhDmQYNXekEiV4MFQSbBw5Soz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzOCBTYWx0ZWRfXy/ADfysU53Oh xDIvQvkTOKYZCsNfNv/Npxtrvzeq4FG6vcnJXTVPp9O1/wCyDB8M+M2NGXjxlYEp4+H+JpssCrm OUfRkhrSpz2cTY+ACX0XEEfibHsQCsFV9uWeQuRSbsaCRcs2lcE3tUir3eH7YDrcya0KxRN3R19
 swUVThNs2mSM2u2cLP8M9wvmDd9qFKEQhFyXKYR9RaDcE2HDV2RfPB9uJIlSs0D2/p3NRHOhLCd kyxjRIlNRbEXbo+Elar2qwbvRoijD0qeoOVTnesu8uNoxzUZV7EI6eqcH34kSxFnI8RkHUJ5VAD BVvG8kWSoZyYLaMt4pK3JAudgoMEJL2DNxkMIJC4dvU1BbMuNIpaJw+sVFTzn02I7n+9q765vlb
 yW79qaNgX+E3jAgipouQ/+sIj/07Wx/g76ARgx+7K541tQzfNAXy73nuNY/O/oyKMaoZJb07
X-Proofpoint-GUID: ggG0dmWUhDmQYNXekEiV4MFQSbBw5Soz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=878
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090138

The previous hardcoded definitions of NUM_RX_STATS and
NUM_TX_STATS were not updated when new fields were added
to the ibmvnic_{rx,tx}_queue_stats structures. Specifically,
commit 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx
batched") added a fourth TX stat, but NUM_TX_STATS remained 3,
leading to a mismatch.

This patch replaces the static defines with dynamic sizeof-based
calculations to ensure the stat arrays are correctly sized.
This fixes incorrect indexing and prevents incomplete stat
reporting in tools like ethtool.

Fixes: 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx batched")
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Reviewed-by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index a189038d88df..246ddce753f9 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -211,7 +211,6 @@ struct ibmvnic_statistics {
 	u8 reserved[72];
 } __packed __aligned(8);
 
-#define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
 	u64 batched_packets;
 	u64 direct_packets;
@@ -219,13 +218,18 @@ struct ibmvnic_tx_queue_stats {
 	u64 dropped_packets;
 };
 
-#define NUM_RX_STATS 3
+#define NUM_TX_STATS \
+	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_rx_queue_stats {
 	u64 packets;
 	u64 bytes;
 	u64 interrupts;
 };
 
+#define NUM_RX_STATS \
+	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(u64))
+
 struct ibmvnic_acl_buffer {
 	__be32 len;
 	__be32 version;
-- 
2.39.3 (Apple Git-146)



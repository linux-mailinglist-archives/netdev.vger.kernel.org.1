Return-Path: <netdev+bounces-203468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737DAF5FC5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE53F1C41153
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE02E7BDD;
	Wed,  2 Jul 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BlVUWXux"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394012E7BD0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476699; cv=none; b=XJgkfrCqfWBZJyz504hRLwizlqb5zkEZTE5PnAfgaTTLduQug2Br+iz67nqKILdCB5xB2y2B+3ZhCdubMk1kMHbz03KxhGGTOjCbpuCuDbuFgt95VCfvG/J0dR2bTVf9mdIkhhGuF4NVzLLKbEn4A1MszukMSO/sMFwGj3qC4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476699; c=relaxed/simple;
	bh=7AEuH53Sc4qoovzst7l5R/jUtBSDXZn9zink5XRJTDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOdNjBek4qahMJecOs1tb3BPgfJ2Fiu7AJ8LeitTwYhqzcjO39USsYQdjz3bCyMrQ84PSziISF8n0Fby17wy5Jo4eS8mpUaVJFRmEzotEUz4c68rDIILisQLotwWogT8hl8MaU2JAnKCheIyT0nRWWAIQMiQEg9vpv8fhlUIFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BlVUWXux; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562CeIZj013209
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HAUoZ5P8vDVBfVwvG
	SvwslNLEfu5Isd3XRhixDsD55o=; b=BlVUWXuxQEZdk+vyh55FWE2Tb6BeFzpgL
	oeL+MSsMNMJ0BHuXBCcXYpFXA8SPnWRCTa31qbb8CXaJ085+hJOjwB0p69tECX5w
	eiAY3P6XY7KY2GjyRdIZxyzWi7gCz+W3sLNT6LSDhh+cxaqk7haES04zfTn/mQpB
	eSpFmKHBdmZ8BsuwT2XYQFWAJPlu/1RHsWYRq17yV9i7YEWAdE1v78dhJuVFpNDK
	QSPmxbC4JAk1Zu4+0Ir8LjsZvXSfBF8BiSKOY0eX/ks7s1qihSUIsPP8h34UUuAu
	4Q87mmmpV9NcJ9of9seG3AU6aCgsrGn8OySEdfho6B9Rrd/N1Z6Nw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1xqq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562EK7pU021939
	for <netdev@vger.kernel.org>; Wed, 2 Jul 2025 17:18:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqprnu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 17:18:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562HIDuL18219768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 17:18:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AFA5805A;
	Wed,  2 Jul 2025 17:18:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51AB5805F;
	Wed,  2 Jul 2025 17:18:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.2])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 17:18:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        davemarq@linux.ibm.com, mmc@linux.ibm.com
Subject: [PATCH v2 net-next 2/4] ibmvnic: Fix hardcoded NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
Date: Wed,  2 Jul 2025 10:18:02 -0700
Message-Id: <20250702171804.86422-3-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250702171804.86422-1-mmc@linux.ibm.com>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DrStXVfmFlIPAOWduyerC-HZJMwKWKgX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MiBTYWx0ZWRfX/0URXtDZhe8J FYESi/NSqVTFtB2ufboejYXxTOTfkM+/7OuWmEtLdj3rzum8oG7/lLMBzWZXtT7uFX6g6kRMkul Dm+voYiyRlN3S57HwRqxsgvs6r8JmK/ZU/D3004jLX5MgXRCxA7b1hnGnwS0aNVmijVbpRmuvj3
 QxemKrHb4dzqTyb2DJACrOmHv8bhzd/vqwkOnR5iu6anhHOXGsNHI35x3wC0KhUYfBWtoraK4fM uOpxuUREt8THQKOxIbacXZ0i5fDY91D47ge42wA2EP/QE2tzzDgKUhO01SxcHYltCAPBZ/r/R2s KXRl622dYMEKAERnqsWfRsqpvUw92lunJDPWHGgX0bLHMKOpMyGCQ9rdfars+sEDpdThsnyaMaa
 TjHXD/B88PQqniNlbsy4WMC53rNyqDyW8lRYxIrR8kVSvrKs9QG50hnNVv7weGl8DgJErtF8
X-Proofpoint-GUID: DrStXVfmFlIPAOWduyerC-HZJMwKWKgX
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=686569d7 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=iejt9ChpHOqe0sw4oRoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=861 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020142

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
Reviewed by: Haren Myneni <haren@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 9b1693d817..e574eed97c 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -211,7 +211,6 @@ struct ibmvnic_statistics {
 	u8 reserved[72];
 } __packed __aligned(8);
 
-#define NUM_TX_STATS 3
 struct ibmvnic_tx_queue_stats {
 	atomic64_t batched_packets;
 	atomic64_t direct_packets;
@@ -219,13 +218,18 @@ struct ibmvnic_tx_queue_stats {
 	atomic64_t dropped_packets;
 };
 
-#define NUM_RX_STATS 3
+#define NUM_TX_STATS \
+	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(atomic64_t))
+
 struct ibmvnic_rx_queue_stats {
 	atomic64_t packets;
 	atomic64_t bytes;
 	atomic64_t interrupts;
 };
 
+#define NUM_RX_STATS \
+	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(atomic64_t))
+
 struct ibmvnic_acl_buffer {
 	__be32 len;
 	__be32 version;
-- 
2.39.3 (Apple Git-146)



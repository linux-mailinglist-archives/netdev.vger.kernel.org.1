Return-Path: <netdev+bounces-202697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41CAEEB09
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E848D3E10ED
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788D25B30E;
	Mon, 30 Jun 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PLdwckey"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A1259C82
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751327303; cv=none; b=KD8lHLnB18BaU+82UBRraZvs3Rpb0bsgFZ/BuWj+WPj6HG4b7Dx41YsDQo+8Kswj/rTVchsvecN1nYB+13hMnUge9hwza06gYLKxupHyjvKydRZbHyVJ3u9wqQ3gfZazjzSQ1QFiuNOx13UltPBbwsIaR/kkeyyMFG3tKRfOweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751327303; c=relaxed/simple;
	bh=nB7AEl3INZ/JBIsdcyVoIX9BChgfK2OI0rUYWmzcm4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSD2+78c9szzlGlhP9ixOWv1yriZLix3c9lcGRgLqJeRI37zmPiWzTHtwBWDPs63xHIWglvFIX3ObVMq3F6BRoGDjngkDrgJRrfg4fkMMc4J0RmWKHKAsZu1GLbwo69A6DiUWq60BMf+TLmUUIiC3B7vAt+aEgYOORWf27JWUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PLdwckey; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UGHY6J000758
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sF3QegOImj0j7A8/x
	/j/0vbTLA30NgrCxcKSa87vB5o=; b=PLdwckeyzb4gj0qhAhRCxMzUUbRSGWYVg
	8wd68GRHOtjVz+jmW1bjczhr1Pf0hOf349oeM/1oyDVXFXFVpVkh8Ps9Uj7xcQQg
	f4aSBr3CaUjMadzNDtnuDF+rqjq9gDMdNV5lxGYjrtNsgn47m8DuBj2R6Lz1ACe2
	kK3kacwi7cKJZwhotpRrHQtZuitUcIOoEJVvWC7QgKVouh+08TQzBilGOUm05r0H
	neWmtmBN8tprebc7mad/OzYhIAZJTgp+aYj6xqiR1iPf0UblI9v0Hm/A/oPBBCAj
	pG5686U4XNkD77c0TEOAA/4SRPNk+wsJEmxmK84NT40t/1hq0S5Ug==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt4jbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UNX3Fm006835
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm7xyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:48:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55UNmDhJ24576586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 23:48:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1988C5805B;
	Mon, 30 Jun 2025 23:48:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA4758058;
	Mon, 30 Jun 2025 23:48:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 23:48:12 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
        mmc@linux.ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next 1/4] ibmvnic: Derive NUM_RX_STATS/NUM_TX_STATS dynamically
Date: Mon, 30 Jun 2025 16:48:03 -0700
Message-Id: <20250630234806.10885-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250630234806.10885-1-mmc@linux.ibm.com>
References: <20250630234806.10885-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NT9640mWE4YqJm1YRLraef3rvwuDtbCY
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6863223f cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=iejt9ChpHOqe0sw4oRoA:9
X-Proofpoint-ORIG-GUID: NT9640mWE4YqJm1YRLraef3rvwuDtbCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE5NiBTYWx0ZWRfX0qHXz482Hf+K 8SGBvx2CBF/16Ak+Cd+soGJZmHXSgmSw0UcdhxD8ZERyQoG50c0L/PICmUsup3fCVTdN3uApGIi Je46vruX87ldnCf0j/lvM1tC6qzKpD6jVWz5XBxd6AoPDKmniDuAvrs54cvDYUlsdyWmQrWdzxG
 ZQL6bCloiL+P1y/MPDK+J7inDpmK6teDAR8NI3DscSAu7AG0SVJ79B8/zPEueyoF6I6Gmhd9oZI 5hmW2GN5uM1N+KhkZFSgvxJS55Tv6RsJLnFAUWxQX8XfgoWJcX1WEUq1l5uhSTYkI1awcKQBE9U M9W9wfM9SJIZ8xvDxanKiwSqE6N3bhn5ghEdN1vUcML2kchJakdJ6gLwq4QzJh8Ktu8w2lAxW4i
 CPSnzk8+2BefmAbtGStByQChIVPxHgic7P+A/9iCAlPez8dWhqaqD9GSG6o3PP8gFScU8lj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_06,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=803
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300196

Replace the hardcoded #define NUM_RX_STATS/NUM_TX_STATS 3
with a sizeof-based calculation to automatically reflect
the number of fields in struct ibmvnic_rx_queue_stats.
and struct ibmvnic_tx_queue_stats.

This avoids mismatches and improves maintainability.

Fixes: 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx batched")

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index a189038d88..246ddce753 100644
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



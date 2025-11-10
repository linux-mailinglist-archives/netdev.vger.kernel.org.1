Return-Path: <netdev+bounces-237335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BACC48FB1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AA53B3365
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F932B992;
	Mon, 10 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aoxaWRZC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48C2D8DD1
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802052; cv=none; b=Xh/NG17BIoawIi9IBDoVg3Q/0Ox1aCkfW+mX9W3arAB0bEsErpVg87VCWDBRQ2VKQzme0iHwOBP1nlDBsG/MYV2yow149VkQR6j+bRNtAGqIWlof8M2gLooY1IQ2eGbUHqRNx/HooDU0UH9UGHAR6VR9bRuniHZQcAUS4jE0wWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802052; c=relaxed/simple;
	bh=mldFs3lgziJLDd1VaLkbA+Q79vCBKVCBAT097NrFH04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzFcwRzGGtvy6/NDVfDms9oybtgPkI4cL+7lZBRdRuxsjiu5PTZ+rSFw5TTXLMMHyf3vfFwa3nynfwrX8DJUGj78DNEtT7+GEpImZ27dYECwHHcBd8yl/y6PvL+exG1qW8rOpiAVAEUoB3haTiRkzh/2jIjmIImVDbblkCS4Hek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aoxaWRZC; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAJ5m8n022535;
	Mon, 10 Nov 2025 19:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=KpXejc+jLka+M3pFuI6nQwOEZn/4E
	sJzwleh4PV0vjI=; b=aoxaWRZC+PYThw3HB/FEi3BxmBZmMbDPEv1+WrqExSfFu
	otKKOM5qp9RUbDwuIREczU695Mdsdyi9kJrNOvK9BIiwnTmw+rlE0G1WGtyMDZ0C
	IKFPQnh1DKDzRRC/FipAASPG9ON4AeUFdtCDGOis8nzSvMVQ2od1Mfi1Nu2cZPzQ
	PWEHPJ8OqAONC3GxbcfrOk+NnmVLIoJHnO9p9wbw1EYYxA3tVdRDKRqPQMarCL7O
	yQlCKLFe/XR8L7aBEaUnFnIC32oZZnIDZc1vlnYJj6gktjBt8ETzhl1PUy3vzOw6
	hoSuPpaLuO114UKUi8WPvPiBQGiaBYUwiO4cbswKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abnw6r0gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 19:13:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHmOvI020966;
	Mon, 10 Nov 2025 19:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8j330-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 19:13:48 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAJ8lcO019732;
	Mon, 10 Nov 2025 19:13:48 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9va8j32f-1;
	Mon, 10 Nov 2025 19:13:47 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com,
        aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] i40e: fix src IP mask checks and memcpy argument names in cloud filter
Date: Mon, 10 Nov 2025 11:13:38 -0800
Message-ID: <20251110191344.278323-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100163
X-Authority-Analysis: v=2.4 cv=Rv7I7SmK c=1 sm=1 tr=0 ts=6912396d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=NcnMm06Wdh5AIhxd0tAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE2MiBTYWx0ZWRfXwjh3yMqXaGcC
 D2AIuKd+bnMB++VrYoQo/xkO7a8hMm2Cm6PNfDRWJ6eK6xMfoa4YTRcL38bjiViCy0MRbuJ95y8
 lUPrQLBLqYiiA5En6AKAUV2d2Ht4flbaBl6AI3qkV4tcqZA8aJIO/rWuvdDek6Ae4lgUxY+RtyX
 lUN1GVeiyJwXYlhi9RySXjpsnqsaDn9hslnkjpykq6dx6HiH+AN9YWLmoez2sIpb/is1CgCQG0j
 t9eM+hknxErTtTVO4EoReR2NG6nv2M5kT6GLu6yuUoN72K+fvub9uBOPezf6c5CycdwY9A1I1JO
 gT0zvGMcoMuGVdtBn/6guGIZy2MdSgdNHZ/somHyZfoc011Nh77jKsy9I8JmItZ8RFTVhJLFds4
 jdOQ9mZGeHqf90gP5uexiZvv5csEww==
X-Proofpoint-ORIG-GUID: NsXZ8sJbRETJnJ0uuAK_Jy-yKhDQn3Yu
X-Proofpoint-GUID: NsXZ8sJbRETJnJ0uuAK_Jy-yKhDQn3Yu

Fix following issues in the IPv4 and IPv6 cloud filter handling logic in
both the add and delete paths:

- The source-IP mask check incorrectly compares mask.src_ip[0] against
  tcf.dst_ip[0]. Update it to compare against tcf.src_ip[0]. This likely
  goes unnoticed because the check is in an "else if" path that only
  executes when dst_ip is not set, most cloud filter use cases focus on
  destination-IP matching, and the buggy condition can accidentally
  evaluate true in some cases.

- memcpy() for the IPv4 source address incorrectly uses
  ARRAY_SIZE(tcf.dst_ip) instead of ARRAY_SIZE(tcf.src_ip), although
  both arrays are the same size.

- The IPv4 memcpy operations used ARRAY_SIZE(tcf.dst_ip) and ARRAY_SIZE
  (tcf.src_ip), Update these to use sizeof(cfilter->ip.v4.dst_ip) and
  sizeof(cfilter->ip.v4.src_ip) to ensure correct and explicit copy size.

- In the IPv6 delete path, memcmp() uses sizeof(src_ip6) when comparing
  dst_ip6 fields. Replace this with sizeof(dst_ip6) to make the intent
  explicit, even though both fields are struct in6_addr.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1 -> v2
update patch subject line and replace ARRAY_SIZE with sizeof
as suggested by Alex and added Reviewed-by Alex and Paul.
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..dd9fb170d98b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3818,10 +3818,10 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		cfilter.n_proto = ETH_P_IP;
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+			       sizeof(cfilter.ip.v4.dst_ip));
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       sizeof(cfilter.ip.v4.src_ip));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		cfilter.n_proto = ETH_P_IPV6;
@@ -3876,7 +3876,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		/* for ipv6, mask is set for all sixteen bytes (4 words) */
 		if (cfilter.n_proto == ETH_P_IPV6 && mask.dst_ip[3])
 			if (memcmp(&cfilter.ip.v6.dst_ip6, &cf->ip.v6.dst_ip6,
-				   sizeof(cfilter.ip.v6.src_ip6)))
+				   sizeof(cfilter.ip.v6.dst_ip6)))
 				continue;
 		if (mask.vlan_id)
 			if (cfilter.vlan_id != cf->vlan_id)
@@ -3964,10 +3964,10 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		cfilter->n_proto = ETH_P_IP;
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter->ip.v4.dst_ip, tcf.dst_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+			       sizeof(cfilter->ip.v4.dst_ip));
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter->ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       sizeof(cfilter->ip.v4.src_ip));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		cfilter->n_proto = ETH_P_IPV6;
-- 
2.50.1



Return-Path: <netdev+bounces-236855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C584C40C7E
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01346188EF30
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9657F2DAFBE;
	Fri,  7 Nov 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J6xWiYeF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3229ACFD
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531801; cv=none; b=DGJ0UbDHCbxIvPXevKdeuoDJ38ewj5Pj/LDPipMeh3d4/f5uKvqc47TQoJzKHX6cj9XdSTrCzN9FBsu8fjTRyoVITlrcdzNnEPpLldECUx7EjQ8YP1SMP2BGY+vJamJ/t8hPfrBmeb8Q5+uj51mK/qVFpiw2urDg1P9M5Vr8ETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531801; c=relaxed/simple;
	bh=Bz3mFU6ghrbgxfRBPw8Q3eO7knnZcjfaKfezs12WmOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAOVLnF+5EY8A0uyZ/JtdsiPlfgaEjzuQBchATIOULK4O4szWxEmBMcpO6PmqK1IRqXZ6tRsokpag8LB69agKd37W/p54NUEBkcRE8HWRm7ebMmv1bg3MA7SKrgsNRpPFqFvRXcDrDjxTV5goA8OTaS4OtbxlHRs7kA931ysjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J6xWiYeF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FdYbI024662;
	Fri, 7 Nov 2025 16:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=m68lcx4PfSk8hNTgvIueNHdgTg7KJ
	SZWMdAzddNOwR0=; b=J6xWiYeF7CnF3TT7WaT3ecTiDaTgMfkZZKn9//Zyu1VlB
	EzlzDWlZs9xcoS+JkPlKfIB2FJOGmutpkQxMCT5DSBF+LoScsYz43uSL7g2P6F9T
	UHVTdNFfPuXTxftdcyE9tbZbSIwWVxbuXoW8BeFGgFoiL51NUyFR/CGBHlCp1WnF
	niahkbkXokPnzA182YOlJjj5q52pDybGeY6rDIOTviT7FKiaVs/ozhOKtbopciLZ
	ivscvLXeRi4MX8KEK6MXipDmcT43i5N56VXhW4LtUxNfss8xU4wQw1tE/ZJ5racW
	ld7xoCxAYuLrdAWEmxtAYv/n16GbHYyJkpsxgez+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9kkr81yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:09:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7G4fJ3014864;
	Fri, 7 Nov 2025 16:09:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndqhyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:09:46 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A7G9jgJ011859;
	Fri, 7 Nov 2025 16:09:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ndqhy3-1;
	Fri, 07 Nov 2025 16:09:45 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
        anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net] i40e: fix incorrect src_ip checks and memcpy sizes in cloud filter
Date: Fri,  7 Nov 2025 08:09:39 -0800
Message-ID: <20251107160943.2614765-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Authority-Analysis: v=2.4 cv=O9I0fR9W c=1 sm=1 tr=0 ts=690e19cb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=kL11o3IWDno-IncmjmsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyOSBTYWx0ZWRfX2u46IaqLLljX
 CQ2f9Abk+3eedH9vtDp4+fut9iRvGNFPYg48IHoM7SB0jRg1Q8Qx92DdB8E1LgZyv4lwIujcGAI
 UiDAB6/67TJHInFuhWbORz+4PSg5K5kIHkz37slAYIA+Ox/WJPQ6py5trU2JhEIiDhiH3Brg79L
 1QFwVlkw9m83M0fLPF246JKhL/Va09RPY0cgcxePkul5cSWvWhTOx3fStyY8T2ziDvotQK0wk4y
 RNlOYeIVmBj4so+jgDPDy11wz1I2+Sd+siyayXwqApFIjZMTT+juOOhH5mL849kcmNl3+8LA4fm
 GeJvdTxh23k+pgGc1bxcJYrDZv4qZEalltkJn1E3KKplvtPa1iBGmoCnYYw1x+dazSYHvSuMf+f
 Puxn+oUdlTzxQnlxwOzW9Tb7V5ohGg==
X-Proofpoint-ORIG-GUID: 2bMHgCEOAjUrKq0bwcoKy7fQhajNJ2o1
X-Proofpoint-GUID: 2bMHgCEOAjUrKq0bwcoKy7fQhajNJ2o1

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

- In the IPv6 delete path, memcmp() uses sizeof(src_ip6) when comparing
  dst_ip6 fields. Replace this with sizeof(dst_ip6) to make the intent
  explicit, even though both fields are struct in6_addr.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..c90cc0139986 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3819,9 +3819,9 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip,
 			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       ARRAY_SIZE(tcf.src_ip));
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
@@ -3965,9 +3965,9 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter->ip.v4.dst_ip, tcf.dst_ip,
 			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter->ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       ARRAY_SIZE(tcf.src_ip));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		cfilter->n_proto = ETH_P_IPV6;
-- 
2.50.1



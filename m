Return-Path: <netdev+bounces-236823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581F7C4063B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF8C3B520F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E9328B54;
	Fri,  7 Nov 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lM6KaFrI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF92C2369
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525871; cv=none; b=uTyalLmcPaNPed/ZbhsukHW7ClfE1k66qNJi+dR/jRfcy6H1H2stzrAoq+9fANCuwRJwwp2t9II/Y8pNOteSv7mgL9cnw6Sr/wVwFBT7xfC+pyMj3fTMkXWCcU7htjkEpZC24MKSn4UyDBZEn7A5XVksXZzJIE+EfDhZxnitjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525871; c=relaxed/simple;
	bh=pOrgQrnt2bAV2rwFEhenpVMFIt6XO4Pcr4+DbOhQoIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaFtO0On9dZionlpQudXsryVV+dhli9zUZkSqiSIXJz0EGxlrbsx/YW3Chku3iv013r0hewziIezO31toIQ+gJnJ5TEb56dg65f/M/Uo+DMf0twwj5o8Z0KWihLLfxNes0SQIssSVcGY4ynQFs67XF8FOWoHQWHpQfgdMqfuUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lM6KaFrI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7E58Ve032330;
	Fri, 7 Nov 2025 14:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HuyCyNIxSTtU1XKMsaRkv99RE6i6L
	6TQ42UPOrrYmNE=; b=lM6KaFrIIWwHXLb7B02L+owzJ+4qFlBpnJj+LVkddwlLO
	C3bRed/etj9KXGsMQlrPV9IPcfuCv9oWMiM5ylVuToyV9wcxxo3P5Fw09XVfZO69
	OjGKiuOm475jgMX/ICP+nK6rV5pPE25Obp9JDZaWJs2M3Fm7d3e23BUBHtEJtW0i
	thqtObtZQaCWIKCKtL8mCUusHmXs2zWA1H5zIzIsXraXwSNxOoKoSAkNi7tzP+6o
	6lFrX/33WSC3rZEt+BCZ0RZQf7dv6WZk/4tUb+d4PdS6aMsoKD4tJ+EleCNaejuB
	5RiugqQfPKxlHQOzclrs/D9RXYWiIiHswhq6VfsMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9j77r1x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 14:30:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7DlDrC023016;
	Fri, 7 Nov 2025 14:30:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhcsyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 14:30:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A7EUsPT020742;
	Fri, 7 Nov 2025 14:30:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nhcsxj-1;
	Fri, 07 Nov 2025 14:30:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
        anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next v3] iavf: clarify VLAN add/delete log messages and lower log level
Date: Fri,  7 Nov 2025 06:30:26 -0800
Message-ID: <20251107143051.2610996-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511070119
X-Proofpoint-GUID: 9nZ0CKNCiYJFQoYQiAPGwwJDiigxscM0
X-Proofpoint-ORIG-GUID: 9nZ0CKNCiYJFQoYQiAPGwwJDiigxscM0
X-Authority-Analysis: v=2.4 cv=aNv9aL9m c=1 sm=1 tr=0 ts=690e029f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=qHh1Kq1xxaR9noxbE6oA:9 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExNSBTYWx0ZWRfXwYRSEeDg6fsv
 XN5eSVPzaO1UdXzpRqAhbkJjuuGdNSZvulQunOvrbf7yjzAxboakcJ8Z7kncNubZcA6PLYaoHiK
 zi8eAcWHUCY2afWvll1sBiBgl42zEYlIeEx9VXyVMlP4Zo3PZ+qqd2ME9Ok2RNB8H0ms/1tjs9O
 ZZPpJbZcEF4dXumng2dJiLtpkH0u9fk2Zkct4rEg0oeJCIS1q/9C961N9kgtzDDcz8LwEqzZNdW
 54z05zuLgyUEzDF5fxB0kUxZNw/dmHcXSlAzEdgZaBvxdLgmyOw0rPBBgqpfz47Ki5fgvPZkqpV
 nEXShVvnBN30/oomMRIH5aI2Bp7CCDY6wC9hZB2xpvbkhnPu/2GeTDMDAqIoHW9QEW0aigvMliY
 fpQc7dQh+hmGGSV2Nll1yOKRe4DY3DrSoWUNS5+0LychSVMomSg=

The current dev_warn messages for too many VLAN changes are confusing
and one place incorrectly references "add" instead of "delete" VLANs
due to copy-paste errors.

- Use dev_info instead of dev_warn to lower the log level.
- Rephrase the message to: "virtchnl: Too many VLAN [add|delete]
  ([v1|v2]) requests; splitting into multiple messages to PF\n".

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1 -> v2
remove "\n" b/w message 
added vvfl and vvfl_v2 prefix
v2 -> v3
removed vvfl/vvfl_v2 prefix and using virtchnl:
prefix and (v1/v2) in the sentence suggested by Alex.
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 34a422a4a29c..88156082a41d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -793,7 +793,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN add (v1) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -838,7 +839,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN add (v2) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
@@ -941,7 +943,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN delete (v1) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -987,7 +990,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "virtchnl: Too many VLAN delete (v2) requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
-- 
2.50.1



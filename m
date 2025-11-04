Return-Path: <netdev+bounces-235516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7FC31CB4
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E4A3B41D1
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5C1B0439;
	Tue,  4 Nov 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkLRZbLY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414EDF71
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268955; cv=none; b=Ci+xnd46R+fhFjG8Xxi0O9ynvYoD4CtD9PTt6TTEdBw6prYsadoOLJheTLDS2oZMOwDlpbKdH+N24mYh2uoyHbcwG26A7cCmU9ErZ/G9xdqzi+pBEmM2V+y801qa68ju1trTv12BVhp2tLOcwgb7oZFPQfrP5v8fIPt45CP2Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268955; c=relaxed/simple;
	bh=Vp8CzUQPKs3QMnMcFAnhkYuhi/eLiOPfzbVZQ9805+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aD2lgBANyH5Md21qHWmARKynJbHS0JMBXVjKfqI6ca0deCPR4mJSJrEt/sVhnyHogSNX/yiZ7KSIjiHwrZlthhwuEJS/aYfNucJWszlhAHru2HobWSdC18BDQU6pmc8u3ejkeK6FcoOx0FI6EqZmpRLCctE8hzAr4GIdJyaXiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkLRZbLY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4ExYkM026294;
	Tue, 4 Nov 2025 15:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=hQBwQoGzHrMQMWBFlP8/3WEktsb+1
	DIpXJFeBQPhykw=; b=LkLRZbLYuzTXiRy8RX2LwUPIBasAfO4eScwKSkz+bt1aV
	spwzWYCqFfLArkehautY+2VPW8f7n6KqPaQheROx9/dAG5k8KgBFlvc2Yd+IB8Tf
	YykCUrCT2+30baREe/OVKehO5fuUpR0YPaEmuSY1pkB+/w7+RVcREEenHc1wpL56
	V7bCmfqOmRp8zDxWBfcYAlaCHEmHITaRjGvATzq8nfwpTkl6VXZrstjVJ872tGJZ
	WEtMqP/D5YH4ug/C2TouDbXZ+RORK29LM0Rq5WLH6Y9gwv9xB2GN0cUV3YZ4pusY
	/f/jPZ2I2z4ZCVEGg4eAX87MNU+RvEZ9yEOsq8lAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7kr0r0nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 15:08:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4Dmh4t022014;
	Tue, 4 Nov 2025 15:08:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkg7aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 15:08:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4F8uS0014809;
	Tue, 4 Nov 2025 15:08:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nkg77r-1;
	Tue, 04 Nov 2025 15:08:56 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
        anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next v2] iavf: clarify VLAN add/delete log messages and lower log level
Date: Tue,  4 Nov 2025 07:08:35 -0800
Message-ID: <20251104150849.532195-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyNCBTYWx0ZWRfX1dCixKPHWNj9
 mMn81lHtRovp90dOQy+CqFH8NQUd6OXujDobssxY0/RYYy3UiTu7yDJ8b5HLp7gXyiE83vTNsEi
 dTANCjxx986n70rqFUXp0m7guygmI6lyG1kIpyKqrKO/XKGxmJDcSZWnnSXCjV2ZXnBCGcyJFOG
 MHBmhy5UVk/mxRF/B7jlrKsOBBEecWrSK16y9GIbnX+Ql65jgOyuArpV1t74PFV2/rT1AmN/WC2
 9le65JY6eFmBKBhhqVAGpMhopuiq8VAO8UaeRnIO70LErB/B10zq9Dq+xzFyE98KgVfDyGF2Esc
 4b1lsptqlYrJRV4sNnSx5FyNHVZRYAh03gwNMiBFJLuUuHM7W+K6ewexfZU9LzEEN/dSlf0vgi8
 z4TsG0lDFGKjSNWaiPKLLOphLcjE6TZBQTQbvMAOIC1KZOaWSkU=
X-Authority-Analysis: v=2.4 cv=Z5fh3XRA c=1 sm=1 tr=0 ts=690a1709 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=aDMgItlAmnlL-JTvjQ0A:9 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: bYrG44d6fm9pxrGPK0mk727xPe8vhZFt
X-Proofpoint-GUID: bYrG44d6fm9pxrGPK0mk727xPe8vhZFt

The current dev_warn messages for too many VLAN changes are confusing
and one place incorrectly references "add" instead of "delete" VLANs
due to copy-paste errors.

- Use dev_info instead of dev_warn to lower the log level.
- Rephrase the message to: "[vvfl|vvfl_v2] Too many VLAN [add|delete]
  requests; splitting into multiple messages to PF".

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1 -> v2
remove "\n" b/w message 
added vvfl and vvfl_v2 prefix
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 34a422a4a29c..c9495c260e6a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -793,7 +793,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "vvfl Too many VLAN add requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -838,7 +839,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "vvfl_v2 Too many VLAN add requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
@@ -941,7 +943,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "vvfl Too many VLAN delete requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -987,7 +990,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev,
+				 "vvfl_v2 Too many VLAN delete requests; splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
-- 
2.50.1



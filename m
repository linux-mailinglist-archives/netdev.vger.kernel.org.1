Return-Path: <netdev+bounces-234986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B98C2AB17
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388EA188E136
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF292E6CA7;
	Mon,  3 Nov 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+Zzpgw4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9902E62A2
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161276; cv=none; b=r9z7ZVF3E5KMSdFUr3GN8Nw9SgRdPj0cZsaMMllGVymL5KeMfr8fyLpXkwYXdkP8TuvYI50Y6/RxAdwr2zekE5fw3OqJ2TMol8gGqxCtMnjdCy7roVft/eCXkH5+j69moZFUUKH+bXoXYtaEJ4JWMO7PMjg3E/ryyYkJMGo4GaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161276; c=relaxed/simple;
	bh=NXwBF1KDQ6erOMQrWYYN/NeD3c/wU0ID5WowRF9+R+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgfvI5ZaQJUxJtquw5BhAuoGmLsgRueqfPwyHIhl9e0D/r4tCJ9f4moR9uxh55Jm8JRtrcjTFyTkxKjSodNc1rPAOSYsVhcniIyDcIFjj2+koh1BLcrfXGXFldFI92IZbRTh2W0vMl/0lUUW7DDL462UfclhfyCWn8mlDQGbPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+Zzpgw4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A38pcqs004018;
	Mon, 3 Nov 2025 09:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=LLiGQrYWE39YqjM8oK0kbp6Fs6Pmv
	bsq0lrVOKIQdSQ=; b=M+Zzpgw4+kiU14uR1y2QqqjBuNClixXDhMwNxafnmUIoi
	WZc3/XvG9AvvUmWpqDuUvg1pcWuRMTsVuFGHzfkpBGw95a0eJ30uokoaUghe3Qi/
	0LFbSOeUCdcGvlkfTCYIzmHE5f1W0+r5nCfpjgMq/NrxO74NViHwJq5PHYVmrcvs
	1b0ZK8azEzePSzeh4xSGwKmZpuKr1Xz//wyk+KyMpUQ+m05fdW8CRBGWRjw0U1JQ
	PxpE7ykoQPoIOpTqjhnLvmTedqLk0xserjwj6x9gak0ahYp5I2NC02pE/2lEOFxg
	NlwkI2CKjFM7HAHnEZv5AzTWd9I5eKL5aBpe4NxyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6rut03tn-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 09:14:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A375rDL039741;
	Mon, 3 Nov 2025 09:04:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhmyyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 09:04:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A391HOd018176;
	Mon, 3 Nov 2025 09:04:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nhmyy7-1;
	Mon, 03 Nov 2025 09:04:50 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
        anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] iavf: clarify VLAN add/delete log messages and lower log level
Date: Mon,  3 Nov 2025 01:03:26 -0800
Message-ID: <20251103090344.452909-2-alok.a.tiwari@oracle.com>
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
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3NyBTYWx0ZWRfX0rZB5OABWdQx
 giMa4k2veuAYtc58j64l1jEZVM0CEN0EvP25fSOWZMV47tEXFY/u9SpFYZz8TXJWyjpWTgLEdoT
 nFIQ78tZ8sYxAB/xrmkrhmsizds/goHjHSpYeVop04svggtecZABZbx9eH0bU/trqfj1h7UgQZF
 B/Qy26JjrdSAZFuAmnpUzxYoqmyhhQT7l99RI/J+MJqUj5HN1WAaw6nJ4WyEPO7UVOIt08jAc3+
 FA2ZiyzCzCuja/j2VJsvkipfXv/dR5W4UQ9whaqjXG5soGXisdfMIbjjz88Xe7XL5wFKVFyX7AS
 inHUddARdRAFJk6/G2NjSkt/yJ3ZeSXfKPM70ke/ZplCY2zXc74Exf3iOfPH3qMUfYrwtAX5DLA
 a3dPBh/uksQqsk0nV+GQy3XZfm45dkg7egQgqvmSGIKtTw+uuek=
X-Proofpoint-ORIG-GUID: MV84B9-flZR7mrJz_b20N1hg4OgLoRFy
X-Proofpoint-GUID: MV84B9-flZR7mrJz_b20N1hg4OgLoRFy
X-Authority-Analysis: v=2.4 cv=ILoPywvG c=1 sm=1 tr=0 ts=6908726c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=CjulpbiJ9qt4iOXFzOQA:9 cc=ntf awl=host:12124

The current dev_warn messages for too many VLAN changes are confusing
and one place incorrectly reference "add" instead of "delete" VLANs
due to copy-paste errors.

- Use dev_info instead of dev_warn to lower the log level.
- Rephrase the message to: "Too many VLAN [add|delete] changes requested,
  splitting into multiple messages to PF".

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
https://lore.kernel.org/all/47f8c95c-bac4-471f-8e58-9155c6e58cb5@intel.com/
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 34a422a4a29c..3593c0b45cf7 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -793,7 +793,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev, "Too many VLAN add changes requested,\n"
+				"splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -838,7 +839,8 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev, "Too many VLAN add changes requested,\n"
+				"splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
@@ -941,7 +943,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl, vlan_id, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev, "Too many VLAN delete changes requested,\n"
+				"splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl, vlan_id,
 							   --count);
@@ -987,7 +990,8 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 
 		len = virtchnl_struct_size(vvfl_v2, filters, count);
 		if (len > IAVF_MAX_AQ_BUF_SIZE) {
-			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
+			dev_info(&adapter->pdev->dev, "Too many VLAN delete changes requested,\n"
+				"splitting into multiple messages to PF\n");
 			while (len > IAVF_MAX_AQ_BUF_SIZE)
 				len = virtchnl_struct_size(vvfl_v2, filters,
 							   --count);
-- 
2.50.1



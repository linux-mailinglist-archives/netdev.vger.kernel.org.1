Return-Path: <netdev+bounces-234627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279CC24CA6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 115754EA889
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AE3469E9;
	Fri, 31 Oct 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AvTipmG7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6533B96F
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910346; cv=none; b=WxDtOT6RNc8JZTTmrtiuNtTCZgHJfTIU9St8Wsqu5vkO7RpMyeJ6c7QCtgEVfodhJl501s8Mita7tJyp1jITCG8yq583Qq/Hb1EdwX5D6VIml7TAvjhfq8yF85bdE1Jzl8vhNjZzZ0I/ocmJAnhI5bsY5K7oZ+6qZ3tRpjj8JaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910346; c=relaxed/simple;
	bh=sUVKHpNXcFFgncPRqyFF1NXllnmZHV3ORBnURBazKso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+gQW6KXJ4Camrc0B8Ie4b+h5MquKXUggwXWejK89m7HiwY3KS45gZBZeVifjZm0Gb48hdLAML7SFNi46yFjVcI3qIeISRYaCxVPZn/3iiQ9wabD2CbDZKQsLLUgHL8aHaIOoIjlXqIMKSS4RaMhXek5D2AE+KcFVWSn/oDzuLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AvTipmG7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VBET1o022884;
	Fri, 31 Oct 2025 11:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FgDLey3Zqi6Osn80JreSghmBPaQW7
	A9EuAfKqF/D7oQ=; b=AvTipmG77YCjuduOB30Id9Dhjc5FE+QutREQPIxN2qPaB
	WItENITmXryo/P0JqYex/efyLtI/b0qJJGz3zYoOItapSgemWwpqVrJlblCcvmpw
	ECuq0sdU7wsJEd1zDubSo7zXhqttN4+jBCs/lgrD9oIANCnmS2PY+4DTiBT1NPJi
	AEH4GJwlY0pnWoPMcTVsHevU2p2qeGq4ts3qM0neqo91S5heew5GjvFVKxBUfrtv
	6QjJDy89DnBUMbh+MjlHfoN9pZDK4AIguSaBObt48+mKHfyvfLnKVmwREdEn2syo
	54So1I6S3223A4V6UBN+VbpQv5b8p3hhx03y51C/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4v2gg11v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 11:26:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59V9tFw7007797;
	Fri, 31 Oct 2025 11:26:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359wj3as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 11:26:58 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59VBPvAO003458;
	Fri, 31 Oct 2025 11:26:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a359wj39u-1;
	Fri, 31 Oct 2025 11:26:57 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: zhuyikai1@h-partners.com, gongfan1@huawei.com, andrew+netdev@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] hinic3: fix misleading error message in hinic3_open_channel()
Date: Fri, 31 Oct 2025 04:26:44 -0700
Message-ID: <20251031112654.46187-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510310103
X-Proofpoint-GUID: MCY_mnQ8nwdLWaX6Dbux_nrxjekk8NJx
X-Authority-Analysis: v=2.4 cv=afBsXBot c=1 sm=1 tr=0 ts=69049d03 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=YzBAHazEskuLAWdpv40A:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfXzQlMYmyV//Q/
 FkS9UoBIgxH7yvKUMLGaw6PW7ZlGDezHLcmlVYB93gAvCqjjXXksHX4MX8VUA1+s7e6MLJITji8
 V32tomI1J4ovzmtiFQZ8YRMq+3IGLFytAwJaWwkiLWgnxrqDjprQUd41i8OPtCVunOL9NbfZdZe
 zyZzxqU+DLFo6VQA1gTwkcyn1gP23xK9AwHVW0e5WwsgFRgHP1AWB8PDxLO4xDFktcP8WaJPIF3
 XgS19JNXhO8sZ3VhYbQhdGiITFfQ9urj6xO760VtPE1yxoA1A7oTtWwzs4uhp0cI64rHYsFm9Uu
 W1rj5ezMBxAChmBbjoAMEZga/UxD2892O9Cxy5qd2w8mLPH6RloKVKlnFKnN84vhdy3kSJDvU9v
 aFqJd9HBiHiiq9NTbX6+DVp2CV+kOQk/M/3Ocnw7p5ZpIv4ZAPE=
X-Proofpoint-ORIG-GUID: MCY_mnQ8nwdLWaX6Dbux_nrxjekk8NJx

The error message printed when hinic3_configure() fails incorrectly
reports "Failed to init txrxq irq", which does not match the actual
operation performed. The hinic3_configure() function sets up various
device resources such as MTU and RSS parameters , not IRQ initialization.

Update the log to "Failed to configure device resources" to make the
message accurate and clearer for debugging.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
Fixes: b83bb584bc97 ("hinic3: Tx & Rx configuration")
---
 drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 0fa3c7900225..bbf22811a029 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -304,7 +304,7 @@ static int hinic3_open_channel(struct net_device *netdev)
 
 	err = hinic3_configure(netdev);
 	if (err) {
-		netdev_err(netdev, "Failed to init txrxq irq\n");
+		netdev_err(netdev, "Failed to configure device resources\n");
 		goto err_uninit_qps_irq;
 	}
 
-- 
2.50.1



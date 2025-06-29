Return-Path: <netdev+bounces-202209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22612AECB63
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 07:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260F1189838D
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 05:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F10184E;
	Sun, 29 Jun 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="maTAq/EX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654CEC4;
	Sun, 29 Jun 2025 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751174201; cv=none; b=Op4ZB+4QFHJRXJ7YpQE6lAPaYulcK1SsqpladRF9pd2Fu+YB/Uy4r+igU7rUhPvjY/cRAglWTrWef9ON8x1jIh9l4Qw+whmUMy+YuaPJPj/A3n8Eltzqzdapjpi3vmeliPX50B7RuxwQwGwJDfiH2dZ+v39zRYI3iZAOoyo1iHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751174201; c=relaxed/simple;
	bh=5YCtt4xWoE2sFZbqLhmFUZNY5xZBfrLF3umVblZJwhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPuZ1qEjmHSOOLSiRu3nv5UYoOX6prmBW4ZneUgxEHvTiYIKGG8T5nR1dNEkM2Mc/jmitDPUS7/dGHNMjwe01rbHV7RWvEw/aCBmgRy0vuPLsqcy8RR8+JuZeMnhmAInKXlgcI3rl/N60qZ3Y7uvL1xu8EW/27o21WeX1Jvl6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=maTAq/EX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55T01Ivl011733;
	Sun, 29 Jun 2025 05:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=PF3DZSZbA4tBUtEFvdIVO9kArXETg
	OS8vUkIBIamiuY=; b=maTAq/EX1k5GlkKyZO1ehQsgN3jQR6Nv7VD9+jJer3dyL
	KMJzWSfGNnjVkd0FMYct8WckbAdjjoqOzitmqTKDWKQQ4NLtzGDZxkq5b8rHlZB0
	auvO/Pvgqa2QzYiOdJg0+mH7QUoY1+C3QX9f+y/6y2kfrNqbFkzwvyDOjQ9YV9lC
	/rViAfbMq+NWfngAxp5UZ75eVPhWd0xwmehkXVj6ieRbRrN3zmQT2nHdnbCV5ly4
	D+0UotUYLjoh9hk5zq48bY0udJ7vQZEy9VHNxfXX+J8JiE9ZoKh1i3ZE2IN1kcml
	SZwrEPmLSBQtIEnkW2+Uttoth4pDcb1tW5L4H20Og==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af0u4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Jun 2025 05:16:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55T57ZGT038552;
	Sun, 29 Jun 2025 05:16:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u78t87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Jun 2025 05:16:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55T5BM8A020395;
	Sun, 29 Jun 2025 05:16:09 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u78t82-1;
	Sun, 29 Jun 2025 05:16:09 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
Date: Sat, 28 Jun 2025 22:15:37 -0700
Message-ID: <20250629051540.518216-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506290041
X-Proofpoint-ORIG-GUID: E4FMocrkEVo34wSxTFAcXpK3dmRZfjCk
X-Proofpoint-GUID: E4FMocrkEVo34wSxTFAcXpK3dmRZfjCk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDA0MiBTYWx0ZWRfX1XzUF28HmOio 3Rmpgb3lys6DDXLsPaDs2C8BdToQupenPxVwilEZUjN6j1z+mgE3cV+C17Gs/h/KsHwZwlzlQk3 Dz0sbvmmGSeLKzlFlN7i3+jBAedgCI5s/9Dn7BvnQgjAwmRY7Ao5AmNydKibehN+tnwr+1zhWX1
 kWNcaOY0pO8H1nbC0VOYgnqrszm/vi0ryUWmGbXeoFdVn42Te73mcy6CyaWHbKBK/+VHCjvsKmF mKR0uEhZMq+Bazpseg6BOue+YtJevqe2DjOscAlg4PCJh3FLfsvupHT17mJj4hNP5ns/l9r0TEd C7fXIudW81WXFZGrI1ZBPaRgE0tDAbP055bofUCtw4kBj9Rcq3ZDGocNL/3NYGbQbtr3dsdl38j
 Tflqtq0xuuZjKuDJ0ARtF5I0GEOmdBPvYFV+wEEJwgHWsuKGu+lj0p/rNNyOkYDa9IftfG6H
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6860cc23 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=Heg8zcIur3sJgoQ754cA:9

The current logic in nicvf_change_mtu() writes the new MTU to
netdev->mtu using WRITE_ONCE() before verifying if the hardware
update succeeds. However on hardware update failure, it attempts
to revert to the original MTU using a direct assignment
(netdev->mtu = orig_mtu)
which violates the intended of WRITE_ONCE protection introduced in
commit 1eb2cded45b3 ("net: annotate writes on dev->mtu from
ndo_change_mtu()")

Additionally, WRITE_ONCE(netdev->mtu, new_mtu) is unnecessarily
performed even when the device is not running.

Fix this by:
  Only writing netdev->mtu after successfully updating the hardware.
  Skipping hardware update when the device is down, and setting MTU
  directly.
  Remove unused variable orig_mtu.

This ensures that all writes to netdev->mtu are consistent with
WRITE_ONCE expectations and avoids unintended state corruption
on failure paths.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
Note: This change is not tested due to hardware availability.
v1 -> v2
remove unused variable orig_mtu.
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6eb..633244bc00f35 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1578,7 +1578,6 @@ int nicvf_open(struct net_device *netdev)
 static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct nicvf *nic = netdev_priv(netdev);
-	int orig_mtu = netdev->mtu;
 
 	/* For now just support only the usual MTU sized frames,
 	 * plus some headroom for VLAN, QinQ.
@@ -1589,16 +1588,18 @@ static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
-	WRITE_ONCE(netdev->mtu, new_mtu);
 
-	if (!netif_running(netdev))
+	if (!netif_running(netdev)) {
+		WRITE_ONCE(netdev->mtu, new_mtu);
 		return 0;
+	}
 
 	if (nicvf_update_hw_max_frs(nic, new_mtu)) {
-		netdev->mtu = orig_mtu;
 		return -EINVAL;
 	}
 
+	WRITE_ONCE(netdev->mtu, new_mtu);
+
 	return 0;
 }
 
-- 
2.46.0



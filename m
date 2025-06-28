Return-Path: <netdev+bounces-202159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE9AEC676
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 11:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1769A189FF9F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19122F75B;
	Sat, 28 Jun 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZwka4bp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9B2236EE;
	Sat, 28 Jun 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751104390; cv=none; b=tGRW8gJ/Xhon4lNhU68kg2hrKoEgmLu6mQHVLm8iPgif3AfcPGRYXqXRT3RBFKtFRt5XxnuAf7C09b1pFfR6DqR6jxaaHHfTZ/7Om4qaRnwQ7/0Vo/ng3sFd1Zli0qm3STW9fagIL0TvATH/VWo844o8waNBz0KAZTwJ0RcxuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751104390; c=relaxed/simple;
	bh=Qz+vgWNHPP5vF6coYhtws3bEQ6ML7SD4vFoXMIuSgAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGC8jKq7k+JiT+O4n24XxsWPclcZurZLuQ07tbj3O8H9x0b8VZdOWdaklc3HdNYn0JGP7iyDLwM34PMkO6yAYSJUd7xPWjfVPyhM3CXHbQpGK0J1AuX8DojOD3YJrG4OIfDF9Pb4eGgo9+hHSYF8VXMK7beW/CXcYTNpWgeZZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cZwka4bp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S5f6hg012201;
	Sat, 28 Jun 2025 09:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Ae72umgiYtiNIqSIpFA7MtGiQ10aN
	aJ+Z7V+1qQL1rM=; b=cZwka4bpy0oVFlkVdr0I0snQlXojMCEJTqmskNX4np85u
	EP7uLfVXgCqslQsdWEOMERkZexWMPOO9eDUv0gD9pxkC0NCR16WafurL/bxWs9+Q
	yp4Y8phbqg5I5c0zTyhzkvZScUw7XJIjBXqhDsxSDzLIBVR6PpW6vNGRuE4usaj/
	ueaq2L7tV+wNPcGDiA83BwMVqLTz9OqyUZcX1aX08dECFJUt0d4iiflZZ8QVtOpu
	jozq8C2DHF9pGxtAOB26meYDQ3Zpc5khCjVzpcq2cmSGgZiAuiV7qiZZNHmqH+ww
	YfwHaHlZVAPhk2v7K8CgLP8lczJViJ/uvvBRNAFJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j76687kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 09:52:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55S9LeYF014207;
	Sat, 28 Jun 2025 09:52:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u6r8f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 09:52:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55S9qqR2009214;
	Sat, 28 Jun 2025 09:52:52 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47j6u6r8er-1;
	Sat, 28 Jun 2025 09:52:52 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
Date: Sat, 28 Jun 2025 02:52:19 -0700
Message-ID: <20250628095221.461991-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506280080
X-Proofpoint-GUID: 28NGkk0EG0roxnsCG4rY-kj-ROsDwQTD
X-Proofpoint-ORIG-GUID: 28NGkk0EG0roxnsCG4rY-kj-ROsDwQTD
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=685fbb76 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=6GJOchzy3z8SWhoumhsA:9 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDA4MSBTYWx0ZWRfX7T9s0A92THvT DX3/F38hBL3wrkdQj1tm0eOzavSjF4r5NyyJKLZa80w+ITNTA159pJEtgZVOsuT/mBgyXuy5u92 h/Rk+1Z091eBZ8b+SbFdPkleE478Mrs4CxDXLTLxWRhrsFkOr+ceIUaQdlLZPao/UVaSZWwjQd1
 2qN9DFLlHJ5L9XoCHUo5xZs2hTuub29ak1kQoUdFAxu4F+R/LUIxtR2S4bNgZNSGH8OHtRJHKKZ f/+QmcEo9E7CrV+ueeQaalmwJa0yUcIDFJH2PU5r4EQ2xnsMFYW1JY+NeUCyilA8NS/umCi+CfT oHTqMUesPWoEFnNt5ZQ6rTLBrXr65yJ4ACkYKw9KDooEkHHiNYDvxPA+ASgmo+gkjDDjVHH0iFf
 /rwyrLZNb1wYeCNAf9b8j9OG4BiayVy6YI/3vZpJMPmNF1lldcNc9r1kbPz3kBRcM5Num4GT

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

This ensures that all writes to netdev->mtu are consistent with
WRITE_ONCE expectations and avoids unintended state corruption
on failure paths.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
Note: This change is not tested due to hardware availability.
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6eb..ba26ba31a28bf 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1589,16 +1589,18 @@ static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
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



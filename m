Return-Path: <netdev+bounces-204442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBDAFA781
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 21:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035023B5A74
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DBD288537;
	Sun,  6 Jul 2025 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gIbM0PWf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E687B3E1;
	Sun,  6 Jul 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751831063; cv=none; b=hmTZ1Hof0BHBZqD0XoIdWVJEnGtwGcfsmvM9qbSKTL2cbCuE1Za+QcQLzFMRnw3YtNjAvx9x7YnEwYSW456QfO1tC7fyBpfZp8Eytte8Ep85SDHiZ+CSERW0/spi+tp9aL9F/kEm3vlpydhCKI0rwFIUFlcj2FbbT698qN6TmX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751831063; c=relaxed/simple;
	bh=TSgDwVxqyTCCtOVNGZAXW3H2A9hsP3zJNy5SDirqyg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ir7umcfgL5ox1Mk0zFvtSV77Yd4k26mq5ZMrKGU6WhSNYnAkwZhYICFDcFXF7cbhZsZUr45T+oQ32G+aqSUo0mXVJAgZ7rC+kQ6sUNepSUfyMRv5omb8ky81rzap6sHqi9q8LGIHyFIFLc7nF+IlRuBaV0Fn5H7Wg45H6dK5yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gIbM0PWf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566702s7017602;
	Sun, 6 Jul 2025 19:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DyWUe8d1haw6m8Oy1cI30UgcAmbCj
	yeCPJKwX4Tb+kM=; b=gIbM0PWfjM/yE0F3sOODWqKbRZ/XqzQBvHcJcuOrtTL37
	1hj5WU5pikqp4Q26+zt/0+pTCHBgEr9xZF5C6DdrgwxfYaeSloQApuemVKqLFLo+
	Eb+mAqEAkMeb0g90+HZThSECyBL+9nXaQpgv3ZZBNumy5PPoCd4rT8x8I8WB1Onh
	Z0vwzShmmQ2MzX56GtnAp+xkndKkjoh62rqD1bOKyJzu6f2N3lKK/32a4ohUHnmE
	nLcU1AfPyRsgbyBRKM6+wT6YAQ1JAwiK8K+xnK2EpENEN1lh2/Ossz3z7TKlOutv
	Mif/W3lznQMx4Tz3diWt8GUTsA0B0Klm4SO/VpD1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47pvkxsfx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 19:44:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 566GBoh2014173;
	Sun, 6 Jul 2025 19:43:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg7ggas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Jul 2025 19:43:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 566Jhwv8007692;
	Sun, 6 Jul 2025 19:43:58 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptg7ggah-1;
	Sun, 06 Jul 2025 19:43:58 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
Date: Sun,  6 Jul 2025 12:43:21 -0700
Message-ID: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507060126
X-Proofpoint-GUID: vPShqCo2W3JHl8gIwplnonW7g9JumuOR
X-Authority-Analysis: v=2.4 cv=a5Uw9VSF c=1 sm=1 tr=0 ts=686ad200 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Heg8zcIur3sJgoQ754cA:9 cc=ntf awl=host:12058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA2MDEyNiBTYWx0ZWRfX7762+z18io8I YHRqK58bq3ToBBffQqK0EroeY63XNgOsjdex53ntMFemr2FuNxoQIwnl3NmhO0VD9AhCrK5+m8y YOmYc+rMgUy1wgvAsF2Ou2af2PiDVx30rdnKm9Z8ICUyz8PwJUlUVqt2k7Hcpj12X12fReDj+oz
 fXnHlXhp94bG94Sn3SEXKqsTeBAGBXUKQmC+R3rEosmlbEA08qMVyIATkeV3n7WH3mzKIAB7qL2 zf2TvuSVXdiJ5expgj0xgTGXFhFRI2Dv+1HWVH6VtUGcMT2qK/mw/s9G4pE+ck02lYgt52lROEV nxux0ZNxaahOd76o82muTa2DhKl05ONrKJDuSCw/HaEu7RUGEd7UBsUyAVdi7PIFpoe4SMoONaE
 c7+1carHuUTcOjkNYn5OxF3LGVStgJVihm7z1pNvRNlYeTDGa2ZJmD3CMDRRK4dpHWWn5in3
X-Proofpoint-ORIG-GUID: vPShqCo2W3JHl8gIwplnonW7g9JumuOR

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
  directly. Remove unused variable orig_mtu.

This ensures that all writes to netdev->mtu are consistent with
WRITE_ONCE expectations and avoids unintended state corruption
on failure paths.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v2 -> v3
https://lore.kernel.org/all/20250630111836.GE41770@horms.kernel.org/
Simplify code as suggested by Simon
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6eb..1be2dc40a1a63 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1578,7 +1578,6 @@ int nicvf_open(struct net_device *netdev)
 static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct nicvf *nic = netdev_priv(netdev);
-	int orig_mtu = netdev->mtu;
 
 	/* For now just support only the usual MTU sized frames,
 	 * plus some headroom for VLAN, QinQ.
@@ -1589,15 +1588,10 @@ static int nicvf_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
-	if (!netif_running(netdev))
-		return 0;
-
-	if (nicvf_update_hw_max_frs(nic, new_mtu)) {
-		netdev->mtu = orig_mtu;
+	if (netif_running(netdev) && nicvf_update_hw_max_frs(nic, new_mtu))
 		return -EINVAL;
-	}
+
+	WRITE_ONCE(netdev->mtu, new_mtu);
 
 	return 0;
 }
-- 
2.46.0



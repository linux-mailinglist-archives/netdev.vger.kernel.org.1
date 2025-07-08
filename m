Return-Path: <netdev+bounces-205101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3077AFD5C7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16241583511
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77962E3B03;
	Tue,  8 Jul 2025 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k9Ksgk6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EC2DC33D;
	Tue,  8 Jul 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997218; cv=none; b=H5jEuaNL9MLGhOvWfzkgNnP7+Af3C0fIRpOzXKbshpVAIBlcZsnKFMlXKOQFzAdk7Yi2/psOglh/taDK80wt5ljbV8rJzm0yS93QglkVHDnGIS+rDbTJEzNvUq4rCzoO3JgL4BeORPh6MMRZLxq9lCjFpAuvPdkKf4mtje6YGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997218; c=relaxed/simple;
	bh=BvDV8p5FETSMWVU1BZi0FPj3bybZk7UYrX/ESm3UydU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXchsVe+b5sE+mMSlFzspBSIARLy3lyYKa2OPJddhXhbk/5j3PBsvcD7yQDeMau3bCnVA3iFqLqJeepN7MDuv3HrZzO3OqnrmU6WkSFZ6QwR04JeYlad/wlv9U5g8MMjtZEsdPKjsYUhf3BRoss80Tygd1CVtrzSHsuftHJy1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k9Ksgk6Y; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568HbKIh029071;
	Tue, 8 Jul 2025 17:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=46+sQH1n5Knp03ba
	6G7W6BAhaEyMNgWTRzlpacnlqMs=; b=k9Ksgk6YVqeA7vj2QWjdrCAism5+PcGe
	A7hn+6+1PcV5lj7m/9paLe0X9ws0X2hk9lvveIv1JLxSwb5jdsES7gi5axod37LF
	VZM9wHdeGfLoOmyIIPBgrGyUVWpwAthwvZnxyuc+ErYWWl2jki53MESaE6zJYU65
	Wxy8L/sNPwUGFy3HxlaYuXDrjG19ZF24TZfxGONWGefg02/1yOGhB1kq09b3qCa/
	IIuG61SYKQP3sWQ6pOfoKu2Gct5c9Vk/Ru/HwHg2AlKewzRcniHcr9C4GeEFkFBs
	R5IintR7VM/Ht9wjKVldwoNpFvlhvWt1f87lww8kF6BVkD6KXaiTXg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s7vsg11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 17:53:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568H0j3j027404;
	Tue, 8 Jul 2025 17:53:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9x5bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 17:53:22 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568HrLif020285;
	Tue, 8 Jul 2025 17:53:21 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptg9x5ag-1;
	Tue, 08 Jul 2025 17:53:21 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: thunderx: Fix format-truncation warning in bgx_acpi_match_id()
Date: Tue,  8 Jul 2025 10:52:43 -0700
Message-ID: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080149
X-Authority-Analysis: v=2.4 cv=dYCA3WXe c=1 sm=1 tr=0 ts=686d5b13 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=xO2tqtdlJwZuTTCz-PAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12057
X-Proofpoint-GUID: BUzLkKWaWhkHOaiMx5gcs2nadI9h35Mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0OSBTYWx0ZWRfX6BPQtWttynJU C6t848ZnUzq9hQjGXWGkV1PZGQQZ9lN38EIh9zD7t1fsSBfStknJTcxOqshnECVZcVc3SeVH+fo zmUtkIrAkyNpcxXLAD11ssxizZg+6/fFfTXn7NBWV2ChpWRfBOaNFHX0Ne/9BHEkN0KoeCTYV+N
 hkMR7sGQBRIF5J0hwSl/C35/NrL5eggZ8xwdQkdr8vVd/3inDx1yBwBUufXw36dGEP2UZ2bLTUI vh2m714nDfN/tCC5zPcvokvICjJrZKVqi2Az6mhlV3vSf0Kb+PjF7epjDw2W4pkBMRITChbwuzf OZCZUUggiNF/kKapqRutc93FkPLrC3/tn40iwCiCLZ5AOKi4Jtg/qH/4HPeTP6rfICQ+UvBx8Xd
 GbwYAOtjhysjPuZTN6RtE5vGHiU1VAtiX1kmpUIw5jrZGlBGoVfmLdJ5QehUgaFoxc6tPlpz
X-Proofpoint-ORIG-GUID: BUzLkKWaWhkHOaiMx5gcs2nadI9h35Mu

The buffer bgx_sel used in snprintf() was too small to safely hold
the formatted string "BGX%d" for all valid bgx_id values. This caused
a -Wformat-truncation warning with Werror enabled during build.

Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
snprintf() to ensure safety and suppress the warning.

Build warning:
  CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
‘bgx_acpi_match_id’:
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: ‘%d’
directive output may be truncated writing between 1 and 3 bytes into a
region of size 2 [-Werror=format-truncation=]
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
                             ^~
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
directive argument in the range [0, 255]
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
                         ^~~~~~~
  drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
‘snprintf’ output between 5 and 7 bytes into a destination of size 5
    snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);

compiler warning due to insufficient snprintf buffer size.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1->v2
No changes. Targeting for net-next.
https://lore.kernel.org/all/20250708160957.GQ452973@horms.kernel.org/
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 3b7ad744b2dd6..2eea3142eebea 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1429,9 +1429,9 @@ static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
 {
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct bgx *bgx = context;
-	char bgx_sel[5];
+	char bgx_sel[8];
 
-	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
+	snprintf(bgx_sel, sizeof(bgx_sel), "BGX%d", bgx->bgx_id);
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
 		pr_warn("Invalid link device\n");
 		return AE_OK;
-- 
2.46.0



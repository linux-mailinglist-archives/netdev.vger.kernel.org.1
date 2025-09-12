Return-Path: <netdev+bounces-222715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D981DB55790
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4398C1CC2DC5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B712C15B5;
	Fri, 12 Sep 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mtdoBj/+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518626E17D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708545; cv=none; b=ghbcLtThh0QpfQkEBstRziVqA5ZBpC+jetJTTlHazVJHeBXtW6Y3CDONBdUvHh+xDAexb4qUQB9oB+Tm6/mRTehywTIGBmumc1DZvgJxDhJ+G+HpKxhgxtuaeJI1IWVy3teeaXSHa/CZrTCL8u/pMNPMyMp5QslZNC1oKYBbh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708545; c=relaxed/simple;
	bh=xenv9wLEZxV2uQ+KcRjqrXuSRpPk+GCKhFljXHz/Fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfrb0lA4jJsjqrBxaAdf/ByhFwanuo3iKFLtHLzJuqk7pzDKjw8dEZJfnAa80k/TACtntlQSm8vEG6cypyah9rhTxwKe8o+ppDCJPhnEZEv/qyYGNaylXyzykJjhOvuEh1ovla21rqcDi/LHR/plM0W4i7H+lQ7VnBAnhPm9Vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mtdoBj/+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CIMj0W002316;
	Fri, 12 Sep 2025 20:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=oxbB8XmfNOc8a2elCCKG3zN/08BNw
	sgUEmm3Ia5Nqqo=; b=mtdoBj/+b3tpbuDFeczQeb9WI00wC+opxC8cEB4pKNZmb
	q6wzobNYXuZDMY2bOD+hDd8hWpC5rDu+hnDdABeJgvhjarTXzgxaZIGhZhtoG1en
	2zepxoACuwYit6mRGMrEgAVW9lS+zAhZZIWFoWZtshHHbLW+I8PWzVW2M6gEYEm/
	AOIeKA58sZu/7MQ92/OsupDgoHNTHpj0ThmA8yDOf/y4XlM6mASAMX7KtYB4ptY/
	WhzGmQG3W64KIv3+qHWM+V2OFQlrdex5fWjF63p0/NQ605rthG901Vqd44EhbbRn
	eXfsdjnoN+JKONNPz455pmSyZhA97SybV8DtwvlkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jh10ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 20:22:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CK0FEu025959;
	Fri, 12 Sep 2025 20:22:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bded0pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 20:22:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CKM5cw032005;
	Fri, 12 Sep 2025 20:22:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bded0nu-1;
	Fri, 12 Sep 2025 20:22:05 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
        darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] net: ena: fix duplicate Autoneg setting in get_link_ksettings
Date: Fri, 12 Sep 2025 13:21:59 -0700
Message-ID: <20250912202201.3957338-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120186
X-Proofpoint-ORIG-GUID: axL1ogeHIO3AFbh0dKCqAI5vEkZOHyqg
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c480ee b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=5oCYBnOEwo6DVAxAOAUA:9
 cc=ntf awl=host:13614
X-Proofpoint-GUID: axL1ogeHIO3AFbh0dKCqAI5vEkZOHyqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX1LwyplHTbD5z
 g7jikBpsffxIVHDEWqoXSP7+GHRyt3IW4wF20Yq5+6GqjtMPKem8pzzIO0aesyR2XoTWlL/6TjT
 +yFLEffIRnamI9ZezgaHMg93WWzNkqHsppXYmNZM+r3dCwpSVs5PaAQCV6nhjQkMzL8sLctWCAV
 lpi9nvUqAS4IF5v/3z5LfjgVsqShkReP3GATWRfauCecgAe+LEr6tFDN950N6WsTyuI2SlCOihh
 vI436dwC7/AFw8BF9Pg5BQ4v4/xYC4OtZcyuXtmL/e7NyXlnz//zIEM7TgLCdX0P6LM7z/2MuDN
 xZcVPqm1pUxC2max79dxmgNcNmM0FsY48Kpr1m98oO0B0VURyweOIca9p2Bylr5wtOIhsRU+XoY
 f2BqW+GeAQTLtBTkqzKrkApMAaTiXA==

The ENA ethtool implementation is setting Autoneg twice in the
'supported' bitfield, leaving 'advertising' unset.

ENA devices always support Autoneg, so 'supported' should always have
the bit set unconditionally. 'advertising' should only be set when
ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK is present, since that
reflects runtime enablement.

Fix by unconditionally setting Autoneg in 'supported' and moving the
conditional flag check to 'advertising'

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
set autoneg unconditionally in 'supported' and
move advertising under AUTONEG_MASK check, as 
discussed with Andrew
https://lore.kernel.org/all/20250911113727.3857978-1-alok.a.tiwari@oracle.com/
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a81d3a7a3bb9..10405949cea2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -467,12 +467,13 @@ static int ena_get_link_ksettings(struct net_device *netdev,
 	link = &feat_resp.u.link;
 	link_ksettings->base.speed = link->speed;
 
-	if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK) {
-		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+	/* Autoneg is always supported */
+	ethtool_link_ksettings_add_link_mode(link_ksettings,
+					     supported, Autoneg);
+
+	if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK)
 		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
-	}
+						     advertising, Autoneg);
 
 	link_ksettings->base.autoneg =
 		(link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK) ?
-- 
2.50.1



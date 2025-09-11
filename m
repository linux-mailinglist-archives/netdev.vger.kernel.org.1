Return-Path: <netdev+bounces-222101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CAB530FE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840881C83936
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6831CA7B;
	Thu, 11 Sep 2025 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+fthXk6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F930F94A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590663; cv=none; b=jtSMelOw4nQn+aL035nTzJto7FOt2PSAahIf1RM2LuZSrJuSQX6B4FGxMz/yJZVSa4TRhBlnonmLu/xmq9WPQhGsxbjelMeJVmF26PAuxoqBaqpPbm/n+rN1TCQGjazUFjMJaLSlmIok9y889b9Y9yacmEliJrEGXL8zU8W6D3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590663; c=relaxed/simple;
	bh=u6umOtzdj3W9bZWwuhhKDx6RA5dkO6dv53GPJnlDTp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrMfKR7z2lXNzydIKgg14Fqs8/7V290ORzSAoLFW7lsUYnSUvRM8AyaAJjfIlcmLzV6k2mR2pfWY39KCFSNXFOXvecWOHz/a2Sa7oxVa0fk/TCKK8gyaUWW4gLkz9eHH6c8Fd/wDAevk5Fr94hfPHagVINmChXdwvYT/rs2IFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+fthXk6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8fl0c002057;
	Thu, 11 Sep 2025 11:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xb2CXb0ZzHiVUZ9x7mSkjL9XR3F4Z
	90ZfedCuRFmyR0=; b=l+fthXk6yyg64Q4U0VIgLoooI1GeOnSpV3/A0+onHraXM
	ZfFe78sx9wlAcsZcOtt23ds1S172cphHkuA0RJHhud+g4wUZgDJPLTpy7yCzocs2
	qc4OO4u3nVcfvB+j6HGn68q0S6QQJ1O3YZQy1pUOPX2FyWbsPdHKXU3UPFIDn1vb
	84t5URW74AtznIK+RqdwwzZ0VbjLIx1zkt8u4drI8grdEyyEKTgsFRrbNu512esV
	wS5PuMO7jB+wGPPMI6276tw/B/Froa1PzZqHWnPDgVCJYNKdhYBEoHz7aDr6p/n+
	cCt4HD3YlprXcTnMjTClKaLTuJ2qx9qBPawRjH0hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shwyed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 11:37:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BA9rbN012850;
	Thu, 11 Sep 2025 11:37:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdch2ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 11:37:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58BBbU13040856;
	Thu, 11 Sep 2025 11:37:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdch2v4-1;
	Thu, 11 Sep 2025 11:37:30 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: shayagr@amazon.com, akiyano@amazon.com, saeedb@amazon.com,
        darinzon@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] net: ena: fix duplicate Autoneg setting in get_link_ksettings
Date: Thu, 11 Sep 2025 04:37:20 -0700
Message-ID: <20250911113727.3857978-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110105
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c2b47c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=F1KUkW-MTnVBcKIWaLUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX64LMnpu5QufE
 45JUqjbqgzWBKwbBaJn9Nsv9e2CwPVQUKQmSgraS98h1iOU1tnZzvGDNZGQTAIeq+7L/EswkRBf
 7gpwVWEdqI7q+NqHlDyOr42+UOoicRwmf/nLuBkVIsC5Pb/1SN08E9dg10RGYa5Sa+4SOxHd1Yo
 1iBBPHwhni1AVHuKgvo5ojSM2mqR7nmIBoc8s+Nvz1I6otqbtc3+TJ3ASjL1jAP0I29ON4dYkjz
 KEUHLPMSh36/mQxrwnd8pn/SYU6xRX1bzt5kElIZhgs761ZqX2xanceVY7G7FLyxIQIWSL2w5Fe
 kTwqdpsCQ3ShPmE+mtVvnaujab0oLAae9MH6yRYKAXADkzmxKLua9DVGNIg+z6VRGKcWhX662vV
 ySbsc5hx
X-Proofpoint-GUID: P_Tm8pA3eOiVzfib7QvGhHSTCuYM4-HY
X-Proofpoint-ORIG-GUID: P_Tm8pA3eOiVzfib7QvGhHSTCuYM4-HY

The ENA ethtool implementation mistakenly sets the Autoneg link mode
twice in the 'supported' mask, leaving the 'advertising mask unset.

Fix this by setting Autoneg in 'advertising' instead of duplicating
it in 'supported'.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a81d3a7a3bb9..a6ef12c157ca 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -471,7 +471,7 @@ static int ena_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(link_ksettings,
 						     supported, Autoneg);
 		ethtool_link_ksettings_add_link_mode(link_ksettings,
-						     supported, Autoneg);
+						     advertising, Autoneg);
 	}
 
 	link_ksettings->base.autoneg =
-- 
2.50.1



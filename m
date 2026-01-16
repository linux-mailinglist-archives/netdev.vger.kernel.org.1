Return-Path: <netdev+bounces-250576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED0CD3395D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F00C3136E01
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5338399A6C;
	Fri, 16 Jan 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMmsoD1/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD6328B5B
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582124; cv=none; b=E8fnJAQVYH9yy7EzzmDiY3Q9CyxCDHS0o7eLIcYKFvNbVuzRN3OGbcf41FJ80+L1TGOjolwBVb9MjosIDUOC68u47p9FA4JAgQgjFiol3xSjf4SkYo68XXzH7FwXsDAnTnZW+dyFSNxQTOh9cpqfJQ3N5uJjxdX8jCGb161B+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582124; c=relaxed/simple;
	bh=fjrpAgYLSkF+d8YydrpELjG2aX3ZMWCLuI2EJuhYjpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gq9JQDNFMIdkCcwqNz5gLxeiAlY+LAs40aYky9gTftrlOa+p/vmFwZmjb0b2GOUBD/R0A4vAp6Qyw3bO6wMLEpw8re1CM2GrTdURGDGfctPhzkAXs4k5A9dCrAJLsoDjzeW0GK+UMbtGtMqv2zYQQS40GPgJ5fcjCCq4eyfvS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMmsoD1/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDuadH1841234;
	Fri, 16 Jan 2026 16:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=YSHDjTbZAw0mNDlOdJAjn6n9aqlCv
	mrsIEX6FuETWog=; b=lMmsoD1/oHjUe958yqwdySVt8GlJwSrhn95QK0BIWm1V5
	WLl2uRXsEZxvP/iMZ1p0+c493ewjnKdtX4wx/M4o8phaGRMa86I7M0diV31zCjCE
	RNqqzorLrsZNPSniGqF3ff/3slK5xsvBPXE8Z/Rimdb8r/97KiRmoQIbuGjDBmr6
	BvzDOfVJzjg0ReUe+kAVRZge3VTgewr6kskP9shGJ40k6D/03gKEkmhFU25HOy2y
	qNSxwThoVCYqGf1xKKAe5ZYtKwfvloiL+pwwP5vS9wZr4VCFG/yClxmGuWShVLw5
	eHRohVn+6jNY3GDCeN2Sx5aGEgbSHQAE96oVs7y6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp5em9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:48:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GG4gde034710;
	Fri, 16 Jan 2026 16:48:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7d4bd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:48:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60GGmPCn028862;
	Fri, 16 Jan 2026 16:48:25 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd7d4b0j-1;
	Fri, 16 Jan 2026 16:48:24 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sd@queasysnail.net, bbhushan2@marvell.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        andrew+netdev@lunn.ch, sbhatta@marvell.com, jerinj@marvell.com,
        hkelam@marvell.com, gakula@marvell.com, lcherian@marvell.com,
        sgoutham@marvell.com, george.cherian@marvell.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] octeontx2: cn10k: fix RX flowid TCAM mask handling
Date: Fri, 16 Jan 2026 08:47:12 -0800
Message-ID: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMiBTYWx0ZWRfX/33c4KEx2TSi
 aM+FBqL9Da/ygZyz8xBUcTdqwzzGOGSM/+Uhbbu6RCkGo2Ki4ArYgCTjj+nfkbZ1+uj9j4tM4HG
 kvA5peRa/CbfoNzijMPrUaFRWU9ktrYwq1krs0IOeLCh8RwrybQokcd+hXT+D5Wd8NNOPyocZt5
 NSybRCMxoj3ReLmud7lp6Gb4dOWcbnfVwW9TH/1DVm/Dj/+6FWo+yEiVlM9UKu0d8jD3LqlU7l0
 36nyiRYC4dR8jO4KYdZsvR0WeN7UJ9lvRspwha8JK9W5befGDy9321oRAJ2ErxHRW8kSb9S50Ma
 5rHr6OE2lsBwJ6AYDYxJSunIqc4N+mN0EVtEYmdq/wTgreErLsx8ChigIU7zlhpnQzzPd2hwEpl
 ofyWedbL6dex8bfcoiKCk7P7xS3lhKS7zDcMdv/lzaFK4GYoPFvzRTb4H3kBCPlBa9KDt5X0duH
 VDD9POnv0IuGchvQyfQ==
X-Proofpoint-GUID: ZpbQF5wx4Ezc7cyiMQJuGHKFKMlInT77
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=696a6bdb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WH0dMkGvYnepeJO_RSAA:9
X-Proofpoint-ORIG-GUID: ZpbQF5wx4Ezc7cyiMQJuGHKFKMlInT77

The RX flowid programming initializes the TCAM mask to all ones, but
then overwrites it when clearing the MAC DA mask bits. This results
in losing the intended initialization and may affect other match fields.

Update the code to clear the MAC DA bits using an AND operation, making
the handling of mask[0] consistent with mask[1], where the field-specific
bits are cleared after initializing the mask to ~0ULL.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 4c7e0f345cb5..060c715ebad0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -328,7 +328,7 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 
 	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
 	req->mask[0] = ~0ULL;
-	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
+	req->mask[0] &= ~MCS_TCAM0_MAC_DA_MASK;
 
 	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
 	req->mask[1] = ~0ULL;
-- 
2.50.1



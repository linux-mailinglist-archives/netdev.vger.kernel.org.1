Return-Path: <netdev+bounces-202194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00866AEC939
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 19:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD0A3AD5A5
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478562727E2;
	Sat, 28 Jun 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGkXke3K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A124168D
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129741; cv=none; b=FlzJBTUeGsxkxpp1jKGMVP7wDVya0mDDXYIptiOCqonVslDwxWQMwbFvvYj8Z9Pk1Yl2ZPMPhAA8EFAwkH55bAensoAUhQCIOvNcBHyDg6MKyHYCU+SwTWmENrofOGElk5NpaO27w2+RhAQAbXOiiwVCWmmDt5EV2OOy+0mWqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129741; c=relaxed/simple;
	bh=+hTZEpdciRxYaOPprirWd16kthog2jJc3YfvgPlK/30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfKxmb+80kZYfOsag0GANAI6Bq4Bh01wzT6T9TT8vpNGP8Nf1ZmM1yYK1kS1O4DG8Bw66+SgRdoQ3CIfktTQQoEK9GvHdwXKBdyR09nKNWF33S3RV3+zatYT7mttcJrdKvpkVyvLdtwbDxSHp7wvGAfdLklRT68YYyXTu2OVpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGkXke3K; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SFv2Dx008882;
	Sat, 28 Jun 2025 16:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7nFesguspO2oIQS9bCrbnuipBMv1o
	wmsSAwQRXcI/3Y=; b=jGkXke3KAwuYf6fB0Os2SzYs4s25FjfBt7qytKRq7vkzu
	heq4XeycC5CnvBW46z0SWOIKqwU3io5SrpNp7wzc1XNXHct8pLzIYqd89urygrRN
	bk22oGKkhvHSR/TnxfCBPLbVaBq3UuBx3G0Qpd/1DYyPQXQKLMVEwznuMm4eqKgq
	IZ3VJaHo9SZ7kA6h4eijV/s3sQYWvXvU4PrOMR3wyYim1oOiGoxB7A6o5tZngYkk
	HD0TN5lUfz97B+CJM0N/mDjz8hi93MLFZrtuQatNd3Jtyl7EJ9j+4LKeQVVvulDG
	6Nu9SVerO4lP+UDVra0mSDw0z4j5pN/0265F5ByMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7048e2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 16:55:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55SCjExa018062;
	Sat, 28 Jun 2025 16:55:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ue6ngt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 16:55:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55SGtCMv035435;
	Sat, 28 Jun 2025 16:55:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47j6ue6ngd-1;
	Sat, 28 Jun 2025 16:55:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [QUERY] net: octeontx2: query on mutex_unlock() usage and WRITE_ONCE omission
Date: Sat, 28 Jun 2025 09:55:06 -0700
Message-ID: <20250628165509.3976081-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506280141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDE0MSBTYWx0ZWRfX+vvFee4zrFVT 221Rpddwg/sAUUYvouN4EudMlWb860ro/XigPbbYN2gAkSiNfyPZmv4e/wPOd7iIuPXsK2Ujumw +Id8JgOIgaNfUuDvGYYs22/qGrV0zmOzpr2kL1SCI+r0wYulhtAw4Cgt2O3LQF/e8VVxU+cwIrr
 uN0zP8N7N0kxvgkBhd7UKgIoxDN6CCNYiUSyNJ0Xq5DotU02v43I8UWQLchslAfUNnqSLW+vpzk ieE7dpWUVBl3joBe+0CcGOobc2tWUb5Bi1pC08QIZiL7rs4lgqYM2PCYqOn1erVIagLy1YYIgj2 CMhJZzHK00feww+vy3U0ZUDQNPtbagJJXY1fDP2+4siPuDl1vEr1trmvU3HFzWv18PXtOXLEcZj
 eO2Q5TT4Tbv2DA1LnNGIHZi9b45qRCtrKKW57TaZHqjm8AFbTtcGw2WqHHZYv4m6Y9KXkFmE
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68601e72 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6IFa9wvqVegA:10 a=F3810AnyE7Z43hPB1GkA:9 cc=ntf awl=host:13215
X-Proofpoint-GUID: _ho1cE3jGGfohIWd8zK8E_4UQmcB-n8a
X-Proofpoint-ORIG-GUID: _ho1cE3jGGfohIWd8zK8E_4UQmcB-n8a

Noticed a couple of points in rep.c that might need attention:

1.
Use of mutex_unlock(&priv->mbox.lock) in rvu_rep_mcam_flow_init()

mutex_unlock(&priv->mbox.lock);
This function does not explicitly acquire mbox.lock, yet it calls mutex_unlock().
Could you confirm whether this is a bug or if the lock is acquired implicitly in a helper function like otx2_sync_mbox_msg()
or a possible leftover?

2.
Direct assignment of dev->mtu without WRITE_ONCE in rvu_rep_change_mtu()

dev->mtu = new_mtu;
Should this use WRITE_ONCE() to ensure safe access in concurrent scenarios?

Thanks,
Alok
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 2cd3da3b6843..88dddf1fffb3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -88,7 +88,7 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
 		sort(&rep->flow_cfg->flow_ent[0], allocated,
 		     sizeof(rep->flow_cfg->flow_ent[0]), mcam_entry_cmp, NULL);
 
-	mutex_unlock(&priv->mbox.lock);
+	mutex_unlock(&priv->mbox.lock); // why mutex_unlock here 
 
 	rep->flow_cfg->max_flows = allocated;
 
@@ -323,7 +323,7 @@ static int rvu_rep_change_mtu(struct net_device *dev, int new_mtu)
 
 	netdev_info(dev, "Changing MTU from %d to %d\n",
 		    dev->mtu, new_mtu);
-	dev->mtu = new_mtu;
+	dev->mtu = new_mtu; // < Is there a reason WRITE_ONCE isn't used here
 
 	evt.evt_data.mtu = new_mtu;
 	evt.pcifunc = rep->pcifunc;
-- 
2.47.1



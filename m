Return-Path: <netdev+bounces-221971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FCEB52784
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 06:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5F16809D1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89DD22836C;
	Thu, 11 Sep 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oHjNQSFi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03508213E9C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564656; cv=none; b=qpuFVSi+6HQNZAuG5jUssddS0Si9vAAATHEvKsXW1GtsWkofmGmt4+jN+AaBqxUsxHodRyTqlC7C+9/3a6cWo4imbwYaf2s9nQ6RyHKQXGozLjWSleutHTttpVNFRmEv/loAVvihu1tJtGB47vzoW75lwAA0vhnnAFBMv34BpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564656; c=relaxed/simple;
	bh=BgsI+AiTgfuafUWQSmOXvl140yZFuftVvl6XyP6jhLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QOAMY6xZHwSOQGoYxKzQrF8Zu4ApOe8PwNEW1RNMF0CDTkzz4e4CI0JHgKh+bwEwbXs3Mz/gINXakw35kmGKyd+5Elgdbx4lbwvcybBUyz4u7uL2iv1YCRjgrknNUEz1OsP43f4AG42DsZMAabJa+KOO2YGENB1oQiK3AZrE9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oHjNQSFi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALg1u5028229;
	Thu, 11 Sep 2025 04:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VPrRpoQ6P9XY9W9QON18itiKr5n0O
	FgBjk5mBHV1+tY=; b=oHjNQSFi/ReRqQT483YJJX55PELvEWPJnJMnjAYCAGqJR
	8W1yLchs6SUTcRUuAYOZtM1i//6N3e/IyBNOAVindixzRwXjxwt2WLYN5IitL4wg
	HgThgMEIZYchlHAx0CFy9F1l7ofPJad881NdIZGC7Tis74/klQLVbrZCghwOP/+x
	bOlbQ7ZkWCbOGKnpPCf37FLP+aAuVN6+snghg+9oXztFEPN+xVzo6pU34eiQenyr
	6r1BjJh6eoc4cNjEoudr4hQBkllRF9RayHOv1PkNRm26y/O81kLYT6mk2j7iT16P
	Y75YEZBCkWxyU9ruqGDo8FxyxryI8JyzineKHevzQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922965g68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 04:24:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4IdOa032848;
	Thu, 11 Sep 2025 04:23:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcvfdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 04:23:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58B4NsFt000763;
	Thu, 11 Sep 2025 04:23:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdcvfdf-1;
	Thu, 11 Sep 2025 04:23:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: shannon.nelson@amd.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] ionic: use int type for err in ionic_get_module_eeprom_by_page
Date: Wed, 10 Sep 2025 21:23:41 -0700
Message-ID: <20250911042351.3833648-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110036
X-Proofpoint-GUID: 1V9B5QZbCyE1yqfFojy9KfpKnAEiCoiM
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c24ee1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=aYG9vCOGyGdZPDYcLycA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX21sEBRD/CXcY
 4Y4L5Sg9w3h5WWVLbBYh+5zhH468Q6zs2icQyTono+JwFVL0TIL1rs+eNlL6INdhR0oxaYAXVvj
 AV91cHCOsvNcOPu0V5Z//N/eKsrkmy4qEIQFFFG9wFCf+Q/fiDqVa5L9FG9Cp9sqRBlnvXAv1At
 r/7hsrJpR5IfjUn05oMzb1JeezUFftWgFoqZOGgx2mbi3zhFJKPcP0b2gZIs8/gFENbTDjOf9NF
 YwJONhFITbIKTtxykVS5lp8cZGZWTf/BBtTeoKGilNfhP8h+nyeE1uLJhO++U9LXJqFQP0B6jg7
 AtXdoyE2XvPi2jHy17zLRB5KumuajNORkOK8S4voy2bDuFimE4hITDHNdvI91oyiOOviTC/Ju3d
 FFn5uT1o
X-Proofpoint-ORIG-GUID: 1V9B5QZbCyE1yqfFojy9KfpKnAEiCoiM

The variable 'err' is declared as u32, but it is used to store
negative error codes such as -EINVAL.

Changing the type of 'err' to int ensures proper representation of
negative error codes and aligns with standard kernel error handling
conventions.

Fixes: c51ab838f532 ("ionic: extend the QSFP module sprom for more pages")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 92f30ff2d631..c3f9835446e2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -978,7 +978,7 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 	struct ionic_dev *idev = &lif->ionic->idev;
-	u32 err = -EINVAL;
+	int err = -EINVAL;
 	u8 *src;
 
 	if (!page_data->length)
-- 
2.50.1



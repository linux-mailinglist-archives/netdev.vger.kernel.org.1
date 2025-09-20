Return-Path: <netdev+bounces-224981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FCB8C7A6
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A3B3AE080
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264325783F;
	Sat, 20 Sep 2025 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8TQNqDD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C772634
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370074; cv=none; b=D9VEcOnzIomNrqvb91jaaJ45+0RDrocqaUv/t5pntRUXEEoEjfjGhaeVi87JS2N/fWczoKjIE1iPs/+y5DF9dfh8D865ieRDSnWjUikzbAAWuB8VtKZUs8LCpWeHPIXy/AyM8FB4iwE4jYB8c9PbqpZ9/7bkQ7hMr12V5FPVLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370074; c=relaxed/simple;
	bh=EvkRjHPn0ACKmRr0yPphICFZDDg5xL1TIOjFgcVfjIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qc0g/sfrGsCij739xEJpJJ75sb+fJNuZbW3Mkq53SQqig718jF78+3DjjSXx1oQuwY2LwpNGjdmNGAAETfOohXQxduGqslemyyMPiGOvNo3D4BojC8CxrbM9gA+z1v7c7z3rR0IllfBvcLTLC6uY1YlYOKvhG8x6VsZ9O9xf9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8TQNqDD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KBtw9N025016;
	Sat, 20 Sep 2025 12:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8xBgHofxQh1kK63X3KzHQyoUyI/5P
	r7yHBSo4LQD3Ao=; b=m8TQNqDDj+UNT0bexfLFdKus13FPk8f0N30nLGY9EnUuE
	mdIzCfsx5eJQPUBImnhRVv1TCeccR9/khkqgMxLqLLG8dYesOOuAfuyu8Gv9k+u6
	wF7De9twRucaZn/l2nJGI9+bRFwM4YMmFmp0sc6OOv9/fJMYTdXQYVhL7n2qPs/I
	tszMUEIA7RMr/FnO8cNjrRV1HaBD2MlXY9RZVdn9XFhTQfzoMjN/WVnwOEkYiXbC
	bVgsoisHb2gAGoMweNwCrSuHa8Redp2EnXXsVSIzbMNSjYIl3ylKcEWXlKcd/7e4
	H0FplVq/2wrFLcXsyGx+HTvyyr1Vkmt6Yuc9gBD4w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m5988wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Sep 2025 12:07:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58K93mDc026003;
	Sat, 20 Sep 2025 12:07:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq5ad9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Sep 2025 12:07:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58KC4vfY023643;
	Sat, 20 Sep 2025 12:07:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 499jq5ad99-1;
	Sat, 20 Sep 2025 12:07:35 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sankararaman.jayaraman@broadcom.com, ronak.doshi@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] vmxnet3: remove incorrect register dump of RX data ring
Date: Sat, 20 Sep 2025 05:07:18 -0700
Message-ID: <20250920120732.351640-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-20_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=934
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509200116
X-Proofpoint-ORIG-GUID: VabhWGIVceNvdulLfCD43yyhDhH2wNfv
X-Proofpoint-GUID: VabhWGIVceNvdulLfCD43yyhDhH2wNfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfX5wLQUh2ifTrt
 RcKf7MW+RWu2XvydrZ8wMM/zDGbLgyTpY2Yth89GPnXxIYPdioNlhkhoSR0xQUi7FCyusuxPBz4
 KgusegzQ99HX+TToN/beljnB7QDLieJaebOuP2ujqExWueNuFCAvi370elyuwhW0o5+X6THBrG+
 RtunyTDoICLWTfzrubWRtbkps8qmBJtegU9lKmgSjQYryd8rXMp+My84PMOn6WxJdAaby/ZimNj
 aTYjdv3JvdYYeKtzWM0bsRSTkH9pKc1NqSZRDNyae2Oh/Ys895twZI2XjMbC/tTBTS2X6pxyfpJ
 afWs7eCzsBOIOt6z9TFeZPtdGKe8SKPpkQjR+8smFyORbNFlTt25Ap9ZtdqdAfx2JTwoGRlP0Q2
 a2ZEgXxW
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68ce9908 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=qPOv6JDsv7PWW1c7V-cA:9

The ethtool get_regs() implementation incorrectly dumps
rq->rx_ring[0].size in the RX data ring section. rq->rx_ring[0].size
belongs to the RX descriptor ring, not the data ring, and is already
reported earlier. The RX data ring only defines desc_size, which is
already exported.

Remove the redundant and invalid rq->rx_ring[0].size dump to avoid
confusing or misleading ethtool -d output.

Fixes: 50a5ce3e7116 ("vmxnet3: add receive data ring support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
correct fixes tag reference.
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index cc4d7573839d..82f5a6156178 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -598,7 +598,6 @@ vmxnet3_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 
 		buf[j++] = VMXNET3_GET_ADDR_LO(rq->data_ring.basePA);
 		buf[j++] = VMXNET3_GET_ADDR_HI(rq->data_ring.basePA);
-		buf[j++] = rq->rx_ring[0].size;
 		buf[j++] = rq->data_ring.desc_size;
 
 		buf[j++] = VMXNET3_GET_ADDR_LO(rq->comp_ring.basePA);
-- 
2.50.1



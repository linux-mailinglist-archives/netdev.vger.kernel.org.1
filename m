Return-Path: <netdev+bounces-239080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0467BC638C6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7236A358940
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AFE2D6620;
	Mon, 17 Nov 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ljua8/tf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF530F957
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374990; cv=none; b=fcwd5aCNOGqcLOtGkEa7eqmk3Ho+O+K8prD0nNoRa9+8vTtSmfFe9HEWHetLkN8jMdMAlvXvZmEfkLcRpvMQWgRJtPS5h29+0gh/o2+zssFTdiTuHtEmdUPmvJiKz0887NMNw6a4hlVqRUqISOE1fL0B1bXbd5aAYGnASXLt+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374990; c=relaxed/simple;
	bh=qpXIJgb3AgYnf28XYf0pACQ8tP7TbIr0r51h3GEwpsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlbkIS6uBKL+X1JRRolNr9uinfhZWcNAUpNzrSuf1LsjmbjM1b2z5eNBN/wsJIHM0oNmi7uWjXVoZhH8XSmtG5tEUWVF18dELwP1Bz2KCG1jNjdgJZC1obHJjtGevaoY9ikFLomkdspZjyjllCb5OIKQ+Jt2nY/G+VW9p/hBJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ljua8/tf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH9uoLI012025;
	Mon, 17 Nov 2025 10:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DDnGEVSvCpUNQAbRmBxXcKjjqev9m
	c/oqa07zTkHqPo=; b=Ljua8/tfbi+ggaLOKsDAQ4QvH7a7BGYdoGYYmlTXRUCty
	Ctrrjg2PRdMk7kFgNIlh5qSM03qomd0IHnKM0MZMeW7RFd0D+RRjM4Po7K3eOkNa
	JproPJTfMlMh9T4kXhPsfwh6dDldVSphkfkDtM3pYyFKUG2BRLziI24c6yOluJCp
	xN40yDdNiE2WfhxqaH6/ozfxKaAV123dfwIoBhvMG5AahCEbNM//+Le0ph8BxhvG
	t07LE/AISLDBo5PD4srytS6O97WngaF/SimtgDHzqWdLFEgfAXNnKu8mIC8Hvdg6
	yJIhywBdSg0OjreQpOzxX4ZEffORYnQRyG51/yWog==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j27dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:22:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH84Ebf039880;
	Mon, 17 Nov 2025 10:22:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyhs7w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 10:22:51 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AHAMoOf004472;
	Mon, 17 Nov 2025 10:22:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4aefyhs7vh-1;
	Mon, 17 Nov 2025 10:22:50 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: michal.kubiak@intel.com, przemyslaw.kitszel@intel.com,
        aleksander.lobakin@intel.com, anthony.l.nguyen@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net] idpf: Fix incorrect NULL check in completion descriptor release
Date: Mon, 17 Nov 2025 02:22:25 -0800
Message-ID: <20251117102244.9188-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170087
X-Proofpoint-ORIG-GUID: C8xvwBz8nwkZQ88fkuFvTqnZg8T1qbSL
X-Proofpoint-GUID: C8xvwBz8nwkZQ88fkuFvTqnZg8T1qbSL
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691af77b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=uA2SwY9BN-IQXUrAw9wA:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0I51Wzgbvs3a
 6g6X2dcxbZq+oazeh2Xg1loFoK10MRWWUSWE0Jvx+1vkJSXOwzc1Q61ZjjEX5tsurMyI1d6q+1s
 r68mOL/GtfOJjDCa15WNuywWgHwVfOZEop4UNey4Ierj5vCp0q8whg67kgWImutMPEmYZAD7Not
 cUtUvCXzGpNFWnZvEO/FTepjc7CVHcV61N2AyzBijs3eI8HYhr1/voqtSs02fFq319A+AYwlPHS
 Tz99yL5Q7GMtk3etbZF4uScWG59RvWId2QjH3y0vfWJG4+tmUZ/ECfwfwY9r5080nexgJhz46fp
 /cNgYTvLKYHk5M+KOP4myEPizF8LANWSh6poIq8oMHZ/iE9IDfFaKPuRIRp5UHlpvCOSwkNarqw
 RUdM7RGKfAr+KAawyjHx0ca1AObiEs5y5HNJ5mWGHeDcSRxQltE=

idpf_compl_queue uses a union for comp, comp_4b, and desc_ring.
The release path should check complq->desc_ring to determine whether the
DMA descriptor ring was allocated. The existing check against
complq->comp is incorrect, as only desc_ring reliably reflects the
allocation status.

Fixes: cfe5efec9177 ("idpf: add 4-byte completion descriptor definition")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..1e7ae6f969ac 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -134,7 +134,7 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 {
 	idpf_xsk_clear_queue(complq, VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
 
-	if (!complq->comp)
+	if (!complq->desc_ring)
 		return;
 
 	dma_free_coherent(complq->netdev->dev.parent, complq->size,
-- 
2.50.1



Return-Path: <netdev+bounces-194532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFEDACA042
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4791724FB
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EE23816E;
	Sun,  1 Jun 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LO8ePrat"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D88EACE;
	Sun,  1 Jun 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748806496; cv=none; b=LuCwUwpoB9ntOl8TmeBKCp2+LAT2RfWg+KDHGL75DBskPsFN63K8p6/qLKS1u3JcpMtd1eq/9Pd6ZsQCLrq80mYpMK9vd92Vn0+6duQGs4egiWVMJ3pzmyvmly1XtzNW0g1mhEyi4iaPZlp8QRaPAq++tFR5bBQLD4xOvyXzysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748806496; c=relaxed/simple;
	bh=NTFQkyNqsHcrn8lkGwZ6RLpnzzc1CI6S3pitnpH7D0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4Mil+AuKqEi9aoyrv+ti56BJ1VU+FwEnTZ7r6FG5aAiDsvQHPtPZCrJ3OiAmIEAqqk0BEL/nvrxxWzD8UzMJFUJyAwz6YdOkWW0yR/Z/ygXPOnJg5IaSPBSoKLnhwqNlGyzmV0B1Na4J48xkX14kWfZAgGa7bVuuYfBOWIlQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LO8ePrat; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551JI6uE018270;
	Sun, 1 Jun 2025 19:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=4fjYtSkV1aKAUXwE9/z/l+vMRbRYw
	tV8rj2AbMaSrzo=; b=LO8ePratAEbM4rCMMf/Z57BqSKK8gpoYkZ97vgcbwaFYt
	76IwfNUTad18nuyXqgPF0v5qaWf8sXTNLPKsesEFxoySK7VMKk0fTn3+q+hc/TcI
	3lMyjT09w2J/+AhVYsnrkcZW8roEbxKVJhCoxHQMzTNHJogdnl8sJumS5tiZXx+y
	0zAtvkQ2sA/lTDV8ZO2hM2bShqd6iiYPhbiSsbZt5ckXxs2bi03tVOGOISZuBfLg
	WMgeHZzmnVioUgUmq48s17bUuzblT8MzMRK351LE6TY3HvOkoD/11DOQ3NSIVw9S
	DvDWdlqSkciWVEDGqxpSHukmlCDH8sve+mv2PLl1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrc41f7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:34:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 551IopRU034484;
	Sun, 1 Jun 2025 19:34:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77800a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 01 Jun 2025 19:34:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 551JYWL0006407;
	Sun, 1 Jun 2025 19:34:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr778002-1;
	Sun, 01 Jun 2025 19:34:32 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: almasrymina@google.com, bcf@google.com, joshwash@google.com,
        willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
        kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
Date: Sun,  1 Jun 2025 12:34:21 -0700
Message-ID: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-01_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506010170
X-Proofpoint-GUID: Ts8SNxs-Syt6Dtjmiw4sv12qblDvpBOl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAxMDE3MCBTYWx0ZWRfXwQsgLaJ5TLSa 3NRHqngJQQxFU+E4pErICUbAFAbOWArVKWbbpmWQ+iPpUFU1Zy+2HLO9mRkZ8jkqcZZlcTHdeGI ubi05/QQ3XG2JZzNCcYXmAoEUB47kKhKVNEKGJiPUC/8zXoAM1dNwLejB506+KfGhjtub4tSEMy
 5ad01a75mPxr9AqwPqAkU1vkG3KQQWfTvVGc+CJkd0F7lqUiGBoQyg4V3VMCOtLfbVDPFrCPJTw k4RzniQvStW96+bGYUy/himo86C3PAJswotm6/5j+Suma0dU9yPd+0LYsFN/SyySYmnXCPiJAJC W854vHcCJrvQBW84xrcOuGR3J6mpREe9tFOm0QwGA5tRxfbUAP/OM4pfmSKKmyKOjc+iSfC4ODG
 0UvRxmbDmTxxU/EPVnNXhT//TN4JpgAqd4n9/Pgf7BQIeA/GEpUQhe6Vjek23M/VhjInsf9h
X-Proofpoint-ORIG-GUID: Ts8SNxs-Syt6Dtjmiw4sv12qblDvpBOl
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=683cab4a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=dI2OP5g5qT_45olihkAA:9 cc=ntf awl=host:13207

gve_alloc_pending_packet() can return NULL, but gve_tx_add_skb_dqo()
did not check for this case before dereferencing the returned pointer.

Add a missing NULL check to prevent a potential NULL pointer
dereference when allocation fails.

This improves robustness in low-memory scenarios.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index a27f1574a733..9d705d94b065 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -764,6 +764,9 @@ static int gve_tx_add_skb_dqo(struct gve_tx_ring *tx,
 	s16 completion_tag;
 
 	pkt = gve_alloc_pending_packet(tx);
+	if (!pkt)
+		return -ENOMEM;
+
 	pkt->skb = skb;
 	completion_tag = pkt - tx->dqo.pending_packets;
 
-- 
2.47.1



Return-Path: <netdev+bounces-208008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACAB0950E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA071C46667
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E621B9DA;
	Thu, 17 Jul 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q5EHa4ne"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E52080C4
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780998; cv=none; b=lxPKG07tTQZ54mrk2xZ4B/B8lcQDKnJjaHecEJL1xItlGmoiMf4jLVYEP/ESAgeqiXTOT6Wi/wfswdJ2CxiO4aFfgDpisxw9dGK06MEFLUcSDTy1zjp5YgCFaxhOfFzY2okWW8OIns6Iyt32magAWsqin6FtWzDyYlQPniB07v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780998; c=relaxed/simple;
	bh=Kn/TPW78P3PwWBJuYrIrat0HjRFsy+CagLoM9v8MkPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8i157r2pVFAQxeH5kogjdI+40e73VKeMBe2pV4rnxLQYzOK2ydeYS9snp4x/cl2ZhSp2yEs0hhDEW1Vq07oy4L8tmx1xvdgtdV/S0BYJzdlaDsi1YszMoj/imcYTlGkT8iUcHmuuuKsCYTFpyKRfjp1mF+J54IiRxL63cNRG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q5EHa4ne; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXroL006679;
	Thu, 17 Jul 2025 19:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FVo1KLjLPTWT7opAQqEWttbNzdAC+
	kkxNL049Dbzfog=; b=Q5EHa4nezqM1autTyzi+rZtJJxXpBwfx4KrfaAN3LPuZC
	xFO/tVMOCUXT0SPswiEEioYDVqo+fuxZVs3JX3rsp6ho5mRMSGv9KEb4w80IFelG
	q7psuiHbwIsn9/4a1EX+guZ+iCHrjCiq1HO/rhBmBZLfTEqlMPnqXOdpFbmV2qzn
	BIqS7trw1BPtdvJP+uT06gtsYKX9XOT3IjfaRcKIN1uNn9w4v5sCPC2yYEqRFCcd
	+FPU9An9OQv/CZLSrdPj/ZE59p6jJeo337DV8PB9/3zRfCR8sTTyBdqrDn9QlUwk
	hk7luMV+YXiYDelGKfXgKzh9KwnvJhKpK/Lv2ENpA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk673j0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:36:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJPBUS012951;
	Thu, 17 Jul 2025 19:36:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cptaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:36:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HJaMHw028854;
	Thu, 17 Jul 2025 19:36:22 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ue5cpt9k-1;
	Thu, 17 Jul 2025 19:36:22 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: somnath.kotur@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] be2net: Use correct byte order and format string for TCP seq and ack_seq
Date: Thu, 17 Jul 2025 12:35:47 -0700
Message-ID: <20250717193552.3648791-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170173
X-Proofpoint-ORIG-GUID: -qJzwOqQvJQgehRWymNubHuZcl9Ao7Ii
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687950b8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=cmPuA5mWZHLCR3AKRpAA:9 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NCBTYWx0ZWRfX274p82fJ2GCd 7jxl2hWHuJuJffI9u++Kmp+yJgIyNYL+GaDArfaP9O+ybz2B92hrp38zQ7WZySLF7XWKJXAe8/A 6comCGSg6cRccx2wyYsaL2bs1MOtVKmDjLWyeoTppPgnCMiHtoI8q9QETi1KOYvGeYRfrb2MvRs
 3wazA3E70ui6OLp3doeX1s5p2ka9P2a0EzDlTM0SGSvyFVls1Qu6jvOnRSwRfZfKxHuu4i4aK35 tqVHdToVbsVh5i0GYE+hbuS6qso7mlkqc9yYCchhmxd8EqSdsRxEAGCLC6za5qY5AuxXEv9/uE4 gnf03uYZ7bnUZUtvfV9tMa/CygZzLOnV15xFETYFVXU49cLIAd86xazMCJe0gIKJzPmXqRyt1Po
 8gambwuSyfo3J8vhySyy2HSfhmnnTuAQqYKvzyoV/Lya/BE6Hbp4uziDe9SrbDTYc0boun78
X-Proofpoint-GUID: -qJzwOqQvJQgehRWymNubHuZcl9Ao7Ii

The TCP header fields seq and ack_seq are 32-bit values in network
byte order as (__be32). these fields were earlier printed using
ntohs(), which converts only 16-bit values and produces incorrect
results for 32-bit fields. This patch is changeing the conversion
to ntohl(), ensuring correct interpretation of these sequence numbers.

Notably, the format specifier is updated from %d to %u to reflect the
unsigned nature of these fields.

improves the accuracy of debug log messages for TCP sequence and
acknowledgment numbers during TX timeouts.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 3d2e215921191..490af66594294 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1465,10 +1465,10 @@ static void be_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 						 ntohs(tcphdr->source));
 					dev_info(dev, "TCP dest port %d\n",
 						 ntohs(tcphdr->dest));
-					dev_info(dev, "TCP sequence num %d\n",
-						 ntohs(tcphdr->seq));
-					dev_info(dev, "TCP ack_seq %d\n",
-						 ntohs(tcphdr->ack_seq));
+					dev_info(dev, "TCP sequence num %u\n",
+						 ntohl(tcphdr->seq));
+					dev_info(dev, "TCP ack_seq %u\n",
+						 ntohl(tcphdr->ack_seq));
 				} else if (ip_hdr(skb)->protocol ==
 					   IPPROTO_UDP) {
 					udphdr = udp_hdr(skb);
-- 
2.46.0



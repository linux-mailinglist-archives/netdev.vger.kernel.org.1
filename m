Return-Path: <netdev+bounces-205887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B28B00AFD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DF17D536
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5782FC3B2;
	Thu, 10 Jul 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cnjvnysb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7B12B71
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170828; cv=none; b=WXhxAlZu5gdGLnc3HKX/FtVg62uQvCtCCHg702qFJjgjDnkoIEX6rZNIvWLaZRY1No7ZXmK+R1yOfAvkM5E07988Li8HQgc6sJH6pyufyhdK0J3BgKbEVE50Fv5NTiSylwW1NYDzxpnlU9OrTzANjQbVglPaIVUd71NVIaMREqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170828; c=relaxed/simple;
	bh=x+ZF//+d2KLA0HgVudjhpEcPepg8tsPtSahbthlfAFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAurC6wAdXWAJqqpbx5+Mm/c25TVU+X5P8rLndv1/c1NmnfsuHWZo9H6oTGPKDqg3ebt6T/7xCZwSAc7B4XVtILim6FNRLhRgCDnKXcK9ixYLpWPvqp5o4RG1ZdWinNTIDF6ZlFmxhZ8eGkmWTSbQ7nSA5qX4bwgA0LUf5SmYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cnjvnysb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AHYvg1013180;
	Thu, 10 Jul 2025 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=UMZnw2mPFViSIIspfxL8aFoXe70mX
	uEmmobwjjLLiVc=; b=CnjvnysbkUc+cWIdVUATlsAkhG58KZn20agtBHhcWrzey
	EDUl1MMxp3Uw5vAJR3Jj/SosAQu+4VOalBXbg4WXC3+C/OVbUoNuBxqbXv4GTEdM
	Wt8VGkagSl/qTm9+PmOZltJo0r3CFbXfx7hP1NNq977pyth7u0Px4SSTT7Ljiwor
	H2UzWqOtQ/aNxosbR+eKla6XbPIEPES1cEbwLnrEsiHKI3GEYNWUybD4K4e/MoIn
	wH1qhRSMaD8mQIrOVC1uEMNdpd0tbRmbVXIz/va8LX3BqiVk1IMqK4egDpaIV9QF
	Sozmgs6vZgAWsl4KTLJ6ljJ3/gmIU7JoNOnltl9Lw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47thwxr2w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 18:06:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGa42E027491;
	Thu, 10 Jul 2025 18:06:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcky4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 18:06:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AI6qmD015798;
	Thu, 10 Jul 2025 18:06:52 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgcky3t-1;
	Thu, 10 Jul 2025 18:06:52 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: abin.joseph@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, darren.kenny@oracle.com
Subject: [PATCH net] net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()
Date: Thu, 10 Jul 2025 11:06:17 -0700
Message-ID: <20250710180621.2383000-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE1NCBTYWx0ZWRfXwAsR9ARAoqsG iWg0shZN2MME47jHYgvYYmu0/ikceRzJJ9xv9SteiItOMkmuyegChGZl3OA3hTJkXu11/XsiLE2 ucuvvT4nuknI9xQmUNAfem3/FPurZAICpLXYUqFwiUJD55YSvC/UKUmEq8v6PN25L5VUrldh3Mz
 vrCpEldRsnA9yTOPEXEeXWpd8ONQZKmpdq2vlwySTlCCq1VSI5F/BN4Gz8zuIBufmyIYuS7qi23 17knY0avU6PWGfgELLHZ8FzHvOQLThdeh/LECWWowhRnDnIIAw8HUAxoXg//DRsFwQYz2QYZVPd Oz8R/B9nb/TBAEo1fEusOn/plYlxBFxZX+VPy7MDH6ecZOcMiL2a2xFmaxD7mvHNU2BMa1w1ZkX
 CQ6vLRSviMHI93ZNE3FGJjHm0kZapmPGJp5FeLSE5mt7eLHAmh8lJSEFU1x33b7G+K/1n2rp
X-Proofpoint-GUID: 2Daqc6PyyofPC_ptVATUMQsXM72wlPoU
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=6870013e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=8r0NROPdEQMzgN-JFG4A:9 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 2Daqc6PyyofPC_ptVATUMQsXM72wlPoU

The function ll_temac_ethtools_set_ringparam() incorrectly checked
rx_pending twice, once correctly for RX and once mistakenly in place
of tx_pending. This caused tx_pending to be left unchecked against
TX_BD_NUM_MAX.
As a result, invalid TX ring sizes may have been accepted or valid
ones wrongly rejected based on the RX limit, leading to potential
misconfiguration or unexpected results.

This patch corrects the condition to properly validate tx_pending.

Fixes: f7b261bfc35e ("net: ll_temac: Make RX/TX ring sizes configurable")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index edb36ff07a0c6..6f82203a414cd 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1309,7 +1309,7 @@ ll_temac_ethtools_set_ringparam(struct net_device *ndev,
 	if (ering->rx_pending > RX_BD_NUM_MAX ||
 	    ering->rx_mini_pending ||
 	    ering->rx_jumbo_pending ||
-	    ering->rx_pending > TX_BD_NUM_MAX)
+	    ering->tx_pending > TX_BD_NUM_MAX)
 		return -EINVAL;
 
 	if (netif_running(ndev))
-- 
2.46.0



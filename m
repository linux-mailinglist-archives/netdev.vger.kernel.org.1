Return-Path: <netdev+bounces-232120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B836C01596
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 564064E3DEF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0101314B82;
	Thu, 23 Oct 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kq6hfG7R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CD3019DA
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225926; cv=none; b=QdjWtzRP4qZB0iTZkW9vbSoyJYDfsQ3If6GWUfzNUtw43VTAiwY26rKv8RlqGr1EkxzGGQYS7DcFm3D5Wh1SMHklSXDyj/Tda2YQ2KlNBu0mJfCymMrI08kejX9hLyTWFf3JYAqDbYTdggPUIhxyE/YeIfZj+YuwNwOYAUbCVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225926; c=relaxed/simple;
	bh=iulZegjP+BP/P7mlXWrs00Hx/PzOo3WDPECz+6ZoN4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cj1cS7EYTFaxOGF6u+YKsEt7OQ1UVkB7M5LYug2N17pDKe3hesZ1oo0Dc5T2RUEENzTFihytGnrkM069Et4shFOIukoOrOQ5Fyn4lNKGzPVejm6Pyb6gUAUmEvatwPSk4D+FuQ9ej6SgX18zlchsV0N4vKxwGlhDtnTBH1qIpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kq6hfG7R; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NC8aD2025025;
	Thu, 23 Oct 2025 13:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=6+77b2eEXvPG7tPG9Q4RTZwyG22J7
	fW9kMUdmX0fSlM=; b=Kq6hfG7R/RIh/H+6FZPjK12/G96DPNSgNPMCD2IF7+iGy
	usZ0LZb4V5J23xrMop41ixPcQ0msc9uPHASvXeuNHqkbpbLaS+0fLmI9yZIn/RSo
	IpnKn28Apo/8/By7NF7o+lqUpcpCUfCvdD2tB3a0KREA+hyp5Q4ooi358qvdsh8M
	3A8XFBh7WyUsP6tsGHeWBDVtqfDkJa8JYs+tQE5XP4YOnQzxlbqlW2e7MOFySSLA
	Tm2Tx/xbQ7OoFWTx8POMDPuIN/FMgNQ4KodxJ/k9lt1Up/3F7gVV2sC9tr8QqJJp
	KOU1j4ZxjhNkYyexMJrmlOtr8vIpUnMIgXHoE+JAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0tfjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:25:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NCOXW0012050;
	Thu, 23 Oct 2025 13:25:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bet7vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 13:25:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59NDOxMt039830;
	Thu, 23 Oct 2025 13:25:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bet7v1-1;
	Thu, 23 Oct 2025 13:25:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next v2 1/2] idpf: correct queue index in Rx allocation error messages
Date: Thu, 23 Oct 2025 06:25:02 -0700
Message-ID: <20251023132507.1102549-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230122
X-Proofpoint-ORIG-GUID: PplxOYSXDZHQnPcfPYZmQx9wvuMe91VW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX4ScV1/CwqOnE
 ppyV9SruUThjCMrO+3aQnRJiPqd3hnfAB35Gh4N9JHnoY9KWQ1kcq8szehF4AZPEOHuqp9LTwG8
 8EYkuXmln76RuqiJ3Owkj/+lFRt8VY+DGSyMsUmxbH7YtvV90dIT0QysFDhaUXbn0r/xp7kl5Pn
 gnQEhy9mz4uGa6N3Xqkvf6Pcyasn2Tf/mBCofOfXWeRV6bbnAj/23Z7HBCWMzJKdR19fmosZ4Wh
 zgZDV+wUfVAlEpNCxQ3dMIWhn2lPk4u4DfYWSgTv01SEDjQIHpcwCGy0J+FZxyXcc8ldowSY+xJ
 F+VXhSPdY/UiAyO61h3TcZZvQhzloXFGYUG0AIdUXQerWGHnjBRmmrcUsX8OmpkCNm/kA0kZRB7
 IZSUy06XPIaNR5w73wQW9hQd+mq1Og==
X-Proofpoint-GUID: PplxOYSXDZHQnPcfPYZmQx9wvuMe91VW
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fa2cb7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=WBbdE9CXIwfSKu4_ZZ4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22

The error messages in idpf_rx_desc_alloc_all() used the group index i
when reporting memory allocation failures for individual Rx and Rx buffer
queues. The correct index to report is j, which represents the specific
queue within the group.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2
no change only added Reviewed-by:
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..e29fc5f4012f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -923,7 +923,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			if (err) {
 				pci_err(vport->adapter->pdev,
 					"Memory allocation for Rx Queue %u failed\n",
-					i);
+					j);
 				goto err_out;
 			}
 		}
@@ -940,7 +940,7 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 			if (err) {
 				pci_err(vport->adapter->pdev,
 					"Memory allocation for Rx Buffer Queue %u failed\n",
-					i);
+					j);
 				goto err_out;
 			}
 		}
-- 
2.50.1



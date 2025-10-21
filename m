Return-Path: <netdev+bounces-231373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D3BF81E4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 863473575EF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98934D93A;
	Tue, 21 Oct 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aO7UyJvP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DF34D91F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072086; cv=none; b=bh8gK7OLoDGrYPxVQ6CvpLVM2n6AV52XmzltsrBrh1VZSLwdZKNreqHyQCTRQsfKPkWkZ/51tFEJd9jX2KtoQWEuIK3v/dM/Fyb75ZYgbywpkp7/6vkaqldr+xVJJXvRvgQgxo9fUjG62UUT0ckIM63Zc/RktP9VEzRhAGb3aBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072086; c=relaxed/simple;
	bh=SinaLyAEKTqwvWAw5dR0CcMsMWFiyxHoLWw6FCK/6So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKFWO5LGUq9JzA/HR7dO6k+wjbwSXW2cN5/TKBfscH+5iH/6dtEdk11WeM+PuNKpxjX34oSn11mzRN0xdy3EyN5k1ABv84CIAw2t1FST7HnfAA/IGdpb/Csffz46s4fK/5O+nNVQSGsFNj9T5KCH3JYuF9xxmXzWlagz+gw5qXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aO7UyJvP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LHSZKN018687;
	Tue, 21 Oct 2025 18:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=O0DqkzJD+nxHZ/2nBy8Mlk98l7KjK
	z3RMj06g2Pxgtk=; b=aO7UyJvP0CG/wjcxxAnkfHXUCbbQr675X3mbFxb9FZD7J
	lPY8v2yq7fvDgh3bFvESfIUKtX0BwiWu7iUa6OyhwlxZvkEGCa7j6RfdY6TaNHH4
	X0eWT6TUFYdQYt0rQbcFg9+c61PFvtjAJz9Ujt+PxEQMUek6UzIWTk+K3nx4ardR
	AmKAyD1QbQQW7HeY0+ZEzqI2rB7FAy+ZjThWMp5aCFgUp8tho7n5k5Iu2sD3ICjU
	xTrdQblhT6auPA81CPuxYElH5tW4qzvOctOBcpjdB0bBCVegM/XgZxbB4xjd1EZ7
	CpOBaSQOqAINPUUalUm6qwhg6SJ/gnN8/Q+SIV0gA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdna0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 18:41:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LISjhO025501;
	Tue, 21 Oct 2025 18:41:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc7esm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 18:41:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LIfBld014153;
	Tue, 21 Oct 2025 18:41:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bc7es9-1;
	Tue, 21 Oct 2025 18:41:11 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next 1/2] idpf: correct queue index in Rx allocation error messages
Date: Tue, 21 Oct 2025 11:40:54 -0700
Message-ID: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210149
X-Proofpoint-GUID: RaanWEFhjTGwWyzrQoV2c2CnImh2PU8l
X-Proofpoint-ORIG-GUID: RaanWEFhjTGwWyzrQoV2c2CnImh2PU8l
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f7d3c9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WBbdE9CXIwfSKu4_ZZ4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX5+dzO7vXijII
 RWx0ceUdEZqMOoknWCnNwBU9raOFTFVKv87FMdPEFXKkm7/zTMNgr3DUvTpLHF/I3WigsXkTaSF
 6EF8+KIUB26g9NvrfdhphpMi4AB+DfAvX4DQZBtWb1xykhhh2TyQSirtzd2wb5WnjuNfCU/wN4D
 E/SboknbqbhaNG/39vQL1nMS2mbF4z1OkRKJDiBsibCgBW8Pu2jiGgHXwA0czgRw6Wl3oWpHdfX
 de+3ikCLXiqHGNa71qEc41yeGVKMlfUY9A2UWCQ4lHQcaFPmRbLZP2BU4Fq3aW6AUEbsAWKvqLN
 bmFUwmDTI0jcUSTYQMGSAdQWTRiqV//4ETCpZyIZ543eg8cJMNrzO9fkEVy680tMKNtp9KVs5Bv
 XaGOuS+zFqieWQPrjf2NFY6G4UBnLA==

The error messages in idpf_rx_desc_alloc_all() used the group index i
when reporting memory allocation failures for individual Rx and Rx buffer
queues. The correct index to report is j, which represents the specific
queue within the group.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
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



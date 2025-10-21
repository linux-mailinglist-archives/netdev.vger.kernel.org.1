Return-Path: <netdev+bounces-231375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC94BF834E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0940E19C014B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD634A3D6;
	Tue, 21 Oct 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jc/van9E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54134C141
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073956; cv=none; b=A0H7Mc4QN2gFSKZydnuXDaZvZ534kBGYnO93qE67UiQHw4O2FDg2XPRH6gfVj3MeFI62kdksUpP0LQZIEkGH/fCvJmMocoX+IxBHYPEuNZIwwg0UvCZIXa8QpjeU4E3Dpi4aJpUq+3AGzVXEMSLIGUIxn4VAISI5Io/0m8vLBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073956; c=relaxed/simple;
	bh=IeiL13aoq4Jz2C5PCp74b1vpXgA/rpRxqc4GvK8g/uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzIt9e32CoRZCfNBNx140A7bWu6g/hVEVEf0W8pO8Tl01LkqpuY3nxFh11yXKTdtIEST/mFzR4RKv/s7+0r4kHXf88Zc76grkeU6CXOhP2NM2x9LhDaWvazJ0t2iNK9xbG2CX7XrijBe7Gel9zyyOW3mheAhVeIZa6+UBKTBeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jc/van9E; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LH4GkU013637;
	Tue, 21 Oct 2025 19:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=CWVpQClt/35C+ZDB/T0t2XcdIS5xn
	M9NZTrNT4EG2aw=; b=jc/van9EwRhHJv7KFkbPDNLCZgfXRUgWeY4UQURpnBNBr
	FPb/fDkz95Zw05v+Ln2T3MvrMNvZTkhVYoG3PJWjwHYnvZ+cl0rfp0bBaVaT8GfJ
	RkuQT0ETL51y/M1iL6ZaLT2CnbvTbbBfV0LXpTy9rnKA2QMVQeFoPKUSIDm3RuW/
	Rk58dqLxW0VKQOs8nm/y72tv3b8f1dpXifc4y1SBnPezm4xAHcRHVoKhGuoGTdr4
	5QbaT7XjK3x9bLSjvt7avvHfSMJN/XeIEtas48O8IU+RIGrmwV5q1PbbhvtBdeeM
	ojojPmyMI2xZuaNHtqocTSdrmIffgo7N0WmNXN8+A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3076b64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 19:12:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LIv3sC032304;
	Tue, 21 Oct 2025 19:12:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bd8tkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 19:12:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LJCKr6032644;
	Tue, 21 Oct 2025 19:12:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bd8tjg-1;
	Tue, 21 Oct 2025 19:12:20 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ixgbe: fix typos in ixgbe driver comments
Date: Tue, 21 Oct 2025 12:12:14 -0700
Message-ID: <20251021191216.2392501-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210153
X-Proofpoint-ORIG-GUID: JXr5RMB1Z_cyo6nyLBQgqdDdDYaj_fuf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXx+6YbWqJyi2j
 NMjPJuBJ0gRXU3vOkjMNaQbkjjH7HbVPO5HJrtjv4yeIg7lhXqt6I6BtUZSkfvWdZ7/QgyYRYtj
 Rb8hr8rCB2SSu9o4dKqsXLMhKVqAezHlUe18QC5D9Kns+vl4SaP2uLewGWsZZkkLRLVRqz8dIEM
 +VZSjbXPc1ciIsfCd09Hdq3yDI4s4vutxVHdsOoNjVkxu9IaEfe4JWmwE+It1568a0fqATx+FMC
 bnWORaZzXyL/ZyTCRpuK7t5EafgSF5z4m2Hhk6XR0/XaiD+CYYdrv9rAilY8uX+QocK4Wju+Rmb
 8WLSqgVQaGR65LQNDohizPT/rUmbveH6RGFXY3D1qPb40OjrqBzRIL/8OsMtNG9vwMQlvmMBMlv
 A/qV8VVm0stMxASC1R5VxYAkcgmkKAs2cUT5o9u/6LPxJ34ST8g=
X-Proofpoint-GUID: JXr5RMB1Z_cyo6nyLBQgqdDdDYaj_fuf
X-Authority-Analysis: v=2.4 cv=csaWUl4i c=1 sm=1 tr=0 ts=68f7db16 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=O4Don3bGMySjCclUSRcA:9 cc=ntf awl=host:13624

Corrected function reference:
 - "proc_autoc_read_82599" -> "prot_autoc_read_82599"
Fixed spelling of:
 - "big-enian" -> "big-endian"
 - "Virtualiztion" -> "Virtualization"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index d5b1b974b4a3..3069b583fd81 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -198,7 +198,7 @@ static int prot_autoc_read_82599(struct ixgbe_hw *hw, bool *locked,
  * @hw: pointer to hardware structure
  * @autoc: value to write to AUTOC
  * @locked: bool to indicate whether the SW/FW lock was already taken by
- *	     previous proc_autoc_read_82599.
+ *	     previous prot_autoc_read_82599.
  *
  * This part (82599) may need to hold a the SW/FW lock around all writes to
  * AUTOC. Likewise after a write we need to do a pipeline reset.
@@ -1622,7 +1622,7 @@ int ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	}
 
-	/* store source and destination IP masks (big-enian) */
+	/* store source and destination IP masks (big-endian) */
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRSIP4M,
 			     ~input_mask->formatted.src_ip[0]);
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRDIP4M,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 170a29d162c6..a1d04914fbbc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -318,7 +318,7 @@ static int ixgbe_xdp_queues(struct ixgbe_adapter *adapter)
  * ixgbe_set_dcb_sriov_queues: Allocate queues for SR-IOV devices w/ DCB
  * @adapter: board private structure to initialize
  *
- * When SR-IOV (Single Root IO Virtualiztion) is enabled, allocate queues
+ * When SR-IOV (Single Root IO Virtualization) is enabled, allocate queues
  * and VM pools where appropriate.  Also assign queues based on DCB
  * priorities and map accordingly..
  *
@@ -492,7 +492,7 @@ static bool ixgbe_set_dcb_queues(struct ixgbe_adapter *adapter)
  * ixgbe_set_sriov_queues - Allocate queues for SR-IOV devices
  * @adapter: board private structure to initialize
  *
- * When SR-IOV (Single Root IO Virtualiztion) is enabled, allocate queues
+ * When SR-IOV (Single Root IO Virtualization) is enabled, allocate queues
  * and VM pools where appropriate.  If RSS is available, then also try and
  * enable RSS and map accordingly.
  *
-- 
2.50.1



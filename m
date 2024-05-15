Return-Path: <netdev+bounces-96642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C38C6D81
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53201F221C1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4A15B54E;
	Wed, 15 May 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Im9gBaq5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C315B129
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807277; cv=none; b=esw3n7xr88HFbypmYUAV5QwW5+77KmXBhyx3xzy9mgt4UOzufiD3TxI+MzisWPRf4XwKg8tuWSp9eK0/a0RxkXF4hNypXQ92L8U4cbqQmLe5pNm6/vdSwv2uIaaiXxdRCDPlGJzZVJUEh1KF6KPCvI32GkFwTWIs/9JWEngtQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807277; c=relaxed/simple;
	bh=QG4ohtzM33XftuXeaYkaO5n8PugkI9wJCvZuDmqLmV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjCVsYWQTB1X79lVcuH4a0UE6rZqiTRAvEMueuzcP1VuKGJCK6mD/kql5tG+K0OOmfz1pBDjXyPLZrsF9H3m5yKO4NcjPA5ge1HAT7yb3Kaz3FQ+YguQeYUSB03DW2BLF8S+VH5FbInXvmp6Lkbv8EdWz7h/1/ULPlDX8g8Vp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Im9gBaq5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FKbQin017679;
	Wed, 15 May 2024 21:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bzzXFgKg1rdEQSE4vr331IXTULHw0GQKEPgX7dcGB2Y=;
 b=Im9gBaq5njr62mwmR8Xu9LMkzCE0bovmmuKzaEgtnFbyyh3OkhIpdji0hWHn9skhelMF
 i6p/mDVces/OZF1qNsbrO7w8wIX4ddE+tP3WtVHCtgnO/ChimwsJXazwpEzOIYtNhDSO
 38fDITaD4O1rJ5EGpEiSHv6tMr9DVnzLehb37IIBjczfeDj+1L8W//7CuIFrhlmhiZKA
 IwQxf/jvR0O4fIRI6c82Fd+9wcdY591CTpb4oexJRvgOJVjOtn+wQp5JTnbTiOl9n91i
 UEJ9nmy1cW+HAENvmruBI/paCF13h6eKwaOGMyeGXZCRV6DuT+nln781P+vyEaoLDjBp kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5486r2bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FL7XHD004790;
	Wed, 15 May 2024 21:07:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y5486r2be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FIQ7VC002310;
	Wed, 15 May 2024 21:07:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pdvrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:32 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FL7Txi24773160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 21:07:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1E15805C;
	Wed, 15 May 2024 21:07:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5275805A;
	Wed, 15 May 2024 21:07:28 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 21:07:28 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        pmenzel@molgen.mpg.de
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net V4,2/2] i40e: Fully suspend and resume IO operations in EEH case
Date: Wed, 15 May 2024 16:07:05 -0500
Message-Id: <20240515210705.620-3-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515210705.620-1-thinhtr@linux.ibm.com>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r6z84ZXkDb45nEgqQr0ZYRUWxeDBV9rq
X-Proofpoint-ORIG-GUID: yOmzwD4q6gJl-f4k-8Y_5DdIxYMZbmQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_13,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150150

When EEH events occurs, the callback functions in the i40e, which are
managed by the EEH driver, will completely suspend and resume all IO
operations.

- In the PCI error detected callback, replaced i40e_prep_for_reset()
  with i40e_io_suspend(). The change is to fully suspend all I/O
  operations
- In the PCI error slot reset callback, replaced pci_enable_device_mem()
  with pci_enable_device(). This change enables both I/O and memory of
  the device.
- In the PCI error resume callback, replaced i40e_handle_reset_warning()
  with i40e_io_resume(). This change allows the system to resume I/O
  operations

Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Robert Thomas <rob.thomas@ibm.com>
Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 281c8ec27af2..9f71a61e0c52 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11138,6 +11138,8 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit,
 	ret = i40e_reset(pf);
 	if (!ret)
 		i40e_rebuild(pf, reinit, lock_acquired);
+	else
+		dev_err(&pf->pdev->dev, "%s: i40e_reset() FAILED", __func__);
 }
 
 /**
@@ -16459,7 +16461,7 @@ static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
 
 	/* shutdown all operations */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
-		i40e_prep_for_reset(pf);
+		i40e_io_suspend(pf);
 
 	/* Request a slot reset */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -16481,7 +16483,8 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
-	if (pci_enable_device_mem(pdev)) {
+	/* enable I/O and memory of the device  */
+	if (pci_enable_device(pdev)) {
 		dev_info(&pdev->dev,
 			 "Cannot re-enable PCI device after reset.\n");
 		result = PCI_ERS_RESULT_DISCONNECT;
@@ -16544,7 +16547,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	if (test_bit(__I40E_SUSPENDED, pf->state))
 		return;
 
-	i40e_handle_reset_warning(pf, false);
+	i40e_io_resume(pf);
 }
 
 /**
-- 
2.25.1



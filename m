Return-Path: <netdev+bounces-90332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713668ADC4A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4314B21FF8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F561C290;
	Tue, 23 Apr 2024 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fwxn7bYb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5217C73
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843349; cv=none; b=jKVdaJLEo79N+6m86MSp9951/1rIQr81E0xPDrl5lJZrySIOX5HmsGknoTA8chWL3IaKVBZkCsvXEZhONLfWE3Wf4Nnj5OgnF5eyONImmXFoJrY/ht3UFvov5DurRxdDEgjswInr971JlPaOlzMz7iixQbRyHLA3bUzer9d/yOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843349; c=relaxed/simple;
	bh=ZO8WoDxdnt01vKXkQ0NdzQeCEyZQX+x0trn9BvqMX2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=de/QkLeMuYuGcthFnUPvPtZ5k8tZDcc9+cyXmlgSlYwd7HrEBjqPp5jWlAy5ynrPJtnNzhLVwDisGdUlklb2seEBVUVDwc79kwYdVzo68T0/0lwXAydReRW5uuVG95TNfR3WbPb2NnyTzcM1CsZYFQBg6eyGd+SP5YGXM3hzcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fwxn7bYb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N3WYu9004390;
	Tue, 23 Apr 2024 03:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mJWg1YY69LAOTpXjNlTVn6/Zflw/uBJW6Fr5/CtkIJA=;
 b=Fwxn7bYbBBsxnPGQx9OOb8k3Zlvx+bqQePbnCQFEsm8q4nuQCBlf/9u/IFf8huFmFxSe
 83/2GkUYznANXYbCaSJEvpVjkTBvGYj3crlI4a61Yr+yJ7VOxM2XWqFPDJdO5Y+UvFfQ
 SoN2xJ1281+UhQ+4hD7kRn6DpkxRZKDQ7Llppr86BnJU3GTwWH5LijUK9rbmx79SYauk
 xay+UDaGwN4nQapOinQSJ5IZOLoQ5kf33WBOX43HwVAf4Eafwxjvd0A7VDwS689TGmji
 /zU3rVkhuFcPTi7whE7lMRszgHnreyMGWcL9IiMbT650HGzUT/vSJlciFIP7ZSqClvzP Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp55u803k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 03:35:39 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N3Zdt6010538;
	Tue, 23 Apr 2024 03:35:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp55u803f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 03:35:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N3KT0f021021;
	Tue, 23 Apr 2024 03:35:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmrdyugfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 03:35:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N3ZYwp48300530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 03:35:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE78A58056;
	Tue, 23 Apr 2024 03:35:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8B225805A;
	Tue, 23 Apr 2024 03:35:33 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.67.140.7])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 03:35:33 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, Thinh Tran <thinhtr@linux.ibm.com>,
        Robert Thomas <rob.thomas@ibm.com>
Subject: [PATCH] net/i40e: Fix repeated EEH reports in MSI domain
Date: Mon, 22 Apr 2024 22:34:59 -0500
Message-Id: <20240423033459.375-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8J1XINCSbU2yE1A0jbw6vsq_obOefjhu
X-Proofpoint-GUID: chalIONgVCMK_JL0VEtpmeDLyMY_nAd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230009

The patch fixes an issue when repeated EEH reports with a single error
on the bus of Intel X710 4-port 10G Base-T adapter, in the MSI domain
causing the devices to be permanently disabled.  It fully resets and
restart the devices when handling the PCI EEH error.

Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
introduced.  These functions were refactor from the existing
i40e_suspend() and i40e_resume() respectively.  This refactoring was
done due to concerns about the logic of the I40E_SUSPENSED state, which
caused the device not able to recover.  The functios are now used in the
EEH handling for device suspend/resume callbacks.

- In the PCI error detected callback, replaced i40e_prep_for_reset()
  with i40e_io_suspend(). The chance is to fully suspend all I/O
  operations
- In the PCI error slot reset callback, replaced pci_enable_device_mem()
  with pci_enable_device(). This change enables both I/O and memory of 
  the device.

- In the PCI error resume callback, replace i40e_handle_reset_warning()
  with i40e_io_resume(). This change allows the system to resume I/O 
  operations


Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
Tested-by: Robert Thomas <rob.thomas@ibm.com>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 29 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 48b9ddb2b1b3..58418aa9231e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -54,6 +54,9 @@ static int i40e_get_capabilities(struct i40e_pf *pf,
 				 enum i40e_admin_queue_opc list_type);
 static bool i40e_is_total_port_shutdown_enabled(struct i40e_pf *pf);
 
+static int i40e_io_suspend(struct i40e_pf *pf);
+static int i40e_io_resume(struct i40e_pf *pf);
+
 /* i40e_pci_tbl - PCI Device ID Table
  *
  * Last entry must be all 0s
@@ -11138,6 +11141,8 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit,
 	ret = i40e_reset(pf);
 	if (!ret)
 		i40e_rebuild(pf, reinit, lock_acquired);
+	else
+		dev_err(&pf->pdev->dev, "%s: i40e_reset() FAILED", __func__);
 }
 
 /**
@@ -16327,7 +16332,7 @@ static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
 
 	/* shutdown all operations */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
-		i40e_prep_for_reset(pf);
+		i40e_io_suspend(pf);
 
 	/* Request a slot reset */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -16349,7 +16354,8 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
-	if (pci_enable_device_mem(pdev)) {
+	/* enable I/O and memory of the device  */
+	if (pci_enable_device(pdev)) {
 		dev_info(&pdev->dev,
 			 "Cannot re-enable PCI device after reset.\n");
 		result = PCI_ERS_RESULT_DISCONNECT;
@@ -16411,8 +16417,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 	if (test_bit(__I40E_SUSPENDED, pf->state))
 		return;
-
-	i40e_handle_reset_warning(pf, false);
+	i40e_io_resume(pf);
 }
 
 /**
@@ -16521,11 +16526,16 @@ static void i40e_shutdown(struct pci_dev *pdev)
 static int __maybe_unused i40e_suspend(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	struct i40e_hw *hw = &pf->hw;
 
 	/* If we're already suspended, then there is nothing to do */
 	if (test_and_set_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
+	return i40e_io_suspend(pf);
+}
+
+static int i40e_io_suspend(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
 
 	set_bit(__I40E_DOWN, pf->state);
 
@@ -16572,11 +16582,16 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 static int __maybe_unused i40e_resume(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	int err;
 
 	/* If we're not suspended, then there is nothing to do */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
+	return i40e_io_resume(pf);
+}
+
+static int i40e_io_resume(struct i40e_pf *pf)
+{
+	int err;
 
 	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
 	 * since we're going to be restoring queues
@@ -16588,7 +16603,7 @@ static int __maybe_unused i40e_resume(struct device *dev)
 	 */
 	err = i40e_restore_interrupt_scheme(pf);
 	if (err) {
-		dev_err(dev, "Cannot restore interrupt scheme: %d\n",
+		dev_err(&pf->pdev->dev, "Cannot restore interrupt scheme: %d\n",
 			err);
 	}
 
-- 
2.39.3



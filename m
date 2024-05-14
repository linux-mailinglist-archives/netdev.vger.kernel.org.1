Return-Path: <netdev+bounces-96433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DA8C5C3B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E40B22E5F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFA18133E;
	Tue, 14 May 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UOUi1e1u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2B180A97
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718152; cv=none; b=qvumuufkOal5bRveouqxg6RBH8MWG1b4MY5p/3DN6UsOSslN3LLfcDNvUuDnBFK6ytpVRKbNiZOVk4TpsnwW+gAQs7+1iTkiN2CSpvX21dLvwndN011rvzuTUhTR4OuaPgqV4ashT1zMK8aM8msJytIQlXnsbSDqM2OR7Ov9owQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718152; c=relaxed/simple;
	bh=P1iOukPag43Zb8E8gd2fw75QW1h1x8T/I5JHBP1rhK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRSt8ebCu3iqaEe9gq1Hd5Wlmi2iJXPV1MjKLLtHvuMrAwDh06gUWnEr5NDuK9u7QXO05Js8tKT/r8WLrONnbuA2e4Q91IA64qSnWoyVC3/oimtqIPINh39cBa66EuE6OPPlqvwcvWG0RTz5rd2CXKyw5UNM7ibU6zZ1s5Ssh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UOUi1e1u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIvYcH016016;
	Tue, 14 May 2024 20:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N4FJD9aZjm3e2+Yl85Azx7ImOI5tVBtwDqFHuaiULsQ=;
 b=UOUi1e1uNRjzM1rob9hbzWvzahVeRNMqc9gAORSx/XrO1UoNg8sEUm4E7r2YjXKz0V65
 6O3lgZj0xooSDyFCmdlKtrOYzvL09BeWLP9DRaDFDsTtPkfOszHWIvEE9BQxpZxmlURK
 wuvtYmWUxaiM98Cd11C3dlquWNF5lRML0/DdHAJCkI6KOOPHuAlKgKcfUPJcCORXpFb3
 7RcapNJg4PA3CllxrcwLhvndvTbRuZF6feLpA7aivimOEApCoWiUjqeFAyvRx/eSjBS3
 DFgXISD6ux8nQZuYi+RzSvIaxfisQ7O3RmNyyLDkYiTYTtBkx3GCLSwXXlSiSY+SxRvp XA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4dpf05y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:27 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EKMQWY013852;
	Tue, 14 May 2024 20:22:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4dpf05xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EI0Kbt020165;
	Tue, 14 May 2024 20:22:25 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyym0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EKMM0m28115504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 20:22:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA73258065;
	Tue, 14 May 2024 20:22:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D7B5806A;
	Tue, 14 May 2024 20:22:21 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 20:22:21 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        horms@kernel.org
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH iwl-net V3,2/2] i40e: Fully suspend and resume IO operations in EEH case
Date: Tue, 14 May 2024 15:21:41 -0500
Message-Id: <20240514202141.408-3-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514202141.408-1-thinhtr@linux.ibm.com>
References: <20240514202141.408-1-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _z_36CDJBqR5u2avDrLkAa-YmxtV3IXg
X-Proofpoint-GUID: xwabXrURfsu_wNOQAJTZjCIfInoZAa9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140145

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



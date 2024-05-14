Return-Path: <netdev+bounces-96432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99618C5C38
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8EE283466
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E5181324;
	Tue, 14 May 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsZ/2+2m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714E180A97
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718149; cv=none; b=c5dIskfsfmVKcYVcnJZXjw65l41vfAFkRYnJtLnXq+N6Fx0TOdUgVBmB3yuLUPxC5PpdzyxbvXUgTxOHyJlAwonwC42wcjUAXWwDNRva+tmvrBccMni5lPjdwXA8eOZkwxpUmoc3lNOZjbPGlR0jL5D3EGiFcHLVWROBAqQP0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718149; c=relaxed/simple;
	bh=l56wHdkNldhVEhG/4wGkg3bAt72hU5xdr8jmpw+xfxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GO7/t2bfZ24vEzfAtTGGZv+MAtTbecpKtR5hnCi050Jge6unoCL6s461MNuhmHepnHBNcgxMmL/QDGG4hQjexwbMtjG6dneqeL32b0f/uT4wigsaE+SHkSlY1j1QvK3C3wKh24L7FDtqA8r4oLRR00RtUwzn3YyrJVSOXiq0OzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OsZ/2+2m; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EK8reb022289;
	Tue, 14 May 2024 20:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RzWW2gF7g5hrOPIwaLijUVWMe/uSASLlQud5LLYzWTg=;
 b=OsZ/2+2m5ycVzSR+2Yk79E81+BJrwRr3cfbdf3jUz/bBaCxHQMcsV+TkHGZwgM2R+0C1
 QSytglnXuzeWxhVLdHf3uMiuUT6oZwlJ2/UrzpQOB5yKo44r+v3RXf8qb002kxfYNe3x
 oGFv7IcPrXR8G9wsAtUM6wHzNPHXQWSDP+wsiVi1eCqtDCWKVUTViK7dUl4SFTLfLlZU
 KXkSPy/W8v/HUduT8u2Se+L0kyPut0yZqmR6IhbqwL2dI08UuWsoLafCoy94QscJS5tG
 DlzS5Yy5wyGBBblTJq58z3rfeFudglCJ+028M2gNxrJNZ450c6VTtac0BIMgv/fJc5+M 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4eqwr0wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:22 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44EKMMXD012814;
	Tue, 14 May 2024 20:22:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4eqwr0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJIQ7E029599;
	Tue, 14 May 2024 20:22:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7kq4e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 20:22:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EKMHRJ38929112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 20:22:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C38258052;
	Tue, 14 May 2024 20:22:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCB6158072;
	Tue, 14 May 2024 20:22:16 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 20:22:16 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        horms@kernel.org
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH iwl-net V3,1/2] i40e: fractoring out i40e_suspend/i40e_resume
Date: Tue, 14 May 2024 15:21:40 -0500
Message-Id: <20240514202141.408-2-thinhtr@linux.ibm.com>
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
X-Proofpoint-GUID: 0276MaNfkgQSIZAgKi_Zg0tJ-NZbA--1
X-Proofpoint-ORIG-GUID: tuQDCAyrxGx0nO5IUDv02UQJqxpBmLJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140145

Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
introduced.  These functions were factored out from the existing
i40e_suspend() and i40e_resume() respectively.  This factoring was
done due to concerns about the logic of the I40E_SUSPENSED state, which
caused the device not able to recover.  The functions are now used in the
EEH handling for device suspend/resume callbacks.

Reordered the function, i40e_enable_mc_magic_wake() has been moved 
ahead of i40e_io_suspend() to ensure it is declared before being used.

Tested-by: Robert Thomas <rob.thomas@ibm.com>
Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 248 +++++++++++---------
 1 file changed, 134 insertions(+), 114 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ffb9f9f15c52..281c8ec27af2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16303,6 +16303,138 @@ static void i40e_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+/**
+ * i40e_enable_mc_magic_wake - enable multicast magic packet wake up
+ * using the mac_address_write admin q function
+ * @pf: pointer to i40e_pf struct
+ **/
+static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+	u8 mac_addr[6];
+	u16 flags = 0;
+	int ret;
+
+	/* Get current MAC address in case it's an LAA */
+	if (pf->vsi[pf->lan_vsi] && pf->vsi[pf->lan_vsi]->netdev) {
+		ether_addr_copy(mac_addr,
+				pf->vsi[pf->lan_vsi]->netdev->dev_addr);
+	} else {
+		dev_err(&pf->pdev->dev,
+			"Failed to retrieve MAC address; using default\n");
+		ether_addr_copy(mac_addr, hw->mac.addr);
+	}
+
+	/* The FW expects the mac address write cmd to first be called with
+	 * one of these flags before calling it again with the multicast
+	 * enable flags.
+	 */
+	flags = I40E_AQC_WRITE_TYPE_LAA_WOL;
+
+	if (hw->func_caps.flex10_enable && hw->partition_id != 1)
+		flags = I40E_AQC_WRITE_TYPE_LAA_ONLY;
+
+	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
+	if (ret) {
+		dev_err(&pf->pdev->dev,
+			"Failed to update MAC address registers; cannot enable Multicast Magic packet wake up");
+		return;
+	}
+
+	flags = I40E_AQC_MC_MAG_EN
+			| I40E_AQC_WOL_PRESERVE_ON_PFR
+			| I40E_AQC_WRITE_TYPE_UPDATE_MC_MAG;
+	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
+	if (ret)
+		dev_err(&pf->pdev->dev,
+			"Failed to enable Multicast Magic Packet wake up\n");
+}
+
+/**
+ * i40e_io_suspend - suspend all IO operations
+ * @pf: pointer to i40e_pf struct
+ *
+ **/
+static int i40e_io_suspend(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	set_bit(__I40E_DOWN, pf->state);
+
+	/* Ensure service task will not be running */
+	del_timer_sync(&pf->service_timer);
+	cancel_work_sync(&pf->service_task);
+
+	/* Client close must be called explicitly here because the timer
+	 * has been stopped.
+	 */
+	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+
+	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
+	    pf->wol_en)
+		i40e_enable_mc_magic_wake(pf);
+
+	/* Since we're going to destroy queues during the
+	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
+	 * whole section
+	 */
+	rtnl_lock();
+
+	i40e_prep_for_reset(pf);
+
+	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
+	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
+
+	/* Clear the interrupt scheme and release our IRQs so that the system
+	 * can safely hibernate even when there are a large number of CPUs.
+	 * Otherwise hibernation might fail when mapping all the vectors back
+	 * to CPU0.
+	 */
+	i40e_clear_interrupt_scheme(pf);
+
+	rtnl_unlock();
+
+	return 0;
+}
+
+/**
+ * i40e_io_resume - resume IO operations
+ * @pf: pointer to i40e_pf struct
+ *
+ **/
+static int i40e_io_resume(struct i40e_pf *pf)
+{
+	int err;
+
+	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
+	 * since we're going to be restoring queues
+	 */
+	rtnl_lock();
+
+	/* We cleared the interrupt scheme when we suspended, so we need to
+	 * restore it now to resume device functionality.
+	 */
+	err = i40e_restore_interrupt_scheme(pf);
+	if (err) {
+		dev_err(&pf->pdev->dev, "Cannot restore interrupt scheme: %d\n",
+			err);
+	}
+
+	clear_bit(__I40E_DOWN, pf->state);
+	i40e_reset_and_rebuild(pf, false, true);
+
+	rtnl_unlock();
+
+	/* Clear suspended state last after everything is recovered */
+	clear_bit(__I40E_SUSPENDED, pf->state);
+
+	/* Restart the service task */
+	mod_timer(&pf->service_timer,
+		  round_jiffies(jiffies + pf->service_timer_period));
+
+	return 0;
+}
+
 /**
  * i40e_pci_error_detected - warning that something funky happened in PCI land
  * @pdev: PCI device information struct
@@ -16415,53 +16547,6 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	i40e_handle_reset_warning(pf, false);
 }
 
-/**
- * i40e_enable_mc_magic_wake - enable multicast magic packet wake up
- * using the mac_address_write admin q function
- * @pf: pointer to i40e_pf struct
- **/
-static void i40e_enable_mc_magic_wake(struct i40e_pf *pf)
-{
-	struct i40e_hw *hw = &pf->hw;
-	u8 mac_addr[6];
-	u16 flags = 0;
-	int ret;
-
-	/* Get current MAC address in case it's an LAA */
-	if (pf->vsi[pf->lan_vsi] && pf->vsi[pf->lan_vsi]->netdev) {
-		ether_addr_copy(mac_addr,
-				pf->vsi[pf->lan_vsi]->netdev->dev_addr);
-	} else {
-		dev_err(&pf->pdev->dev,
-			"Failed to retrieve MAC address; using default\n");
-		ether_addr_copy(mac_addr, hw->mac.addr);
-	}
-
-	/* The FW expects the mac address write cmd to first be called with
-	 * one of these flags before calling it again with the multicast
-	 * enable flags.
-	 */
-	flags = I40E_AQC_WRITE_TYPE_LAA_WOL;
-
-	if (hw->func_caps.flex10_enable && hw->partition_id != 1)
-		flags = I40E_AQC_WRITE_TYPE_LAA_ONLY;
-
-	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
-	if (ret) {
-		dev_err(&pf->pdev->dev,
-			"Failed to update MAC address registers; cannot enable Multicast Magic packet wake up");
-		return;
-	}
-
-	flags = I40E_AQC_MC_MAG_EN
-			| I40E_AQC_WOL_PRESERVE_ON_PFR
-			| I40E_AQC_WRITE_TYPE_UPDATE_MC_MAG;
-	ret = i40e_aq_mac_address_write(hw, flags, mac_addr, NULL);
-	if (ret)
-		dev_err(&pf->pdev->dev,
-			"Failed to enable Multicast Magic Packet wake up\n");
-}
-
 /**
  * i40e_shutdown - PCI callback for shutting down
  * @pdev: PCI device information struct
@@ -16521,48 +16606,11 @@ static void i40e_shutdown(struct pci_dev *pdev)
 static int __maybe_unused i40e_suspend(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	struct i40e_hw *hw = &pf->hw;
 
 	/* If we're already suspended, then there is nothing to do */
 	if (test_and_set_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
-
-	set_bit(__I40E_DOWN, pf->state);
-
-	/* Ensure service task will not be running */
-	del_timer_sync(&pf->service_timer);
-	cancel_work_sync(&pf->service_task);
-
-	/* Client close must be called explicitly here because the timer
-	 * has been stopped.
-	 */
-	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
-
-	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps) &&
-	    pf->wol_en)
-		i40e_enable_mc_magic_wake(pf);
-
-	/* Since we're going to destroy queues during the
-	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
-	 * whole section
-	 */
-	rtnl_lock();
-
-	i40e_prep_for_reset(pf);
-
-	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
-	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
-
-	/* Clear the interrupt scheme and release our IRQs so that the system
-	 * can safely hibernate even when there are a large number of CPUs.
-	 * Otherwise hibernation might fail when mapping all the vectors back
-	 * to CPU0.
-	 */
-	i40e_clear_interrupt_scheme(pf);
-
-	rtnl_unlock();
-
-	return 0;
+	return i40e_io_suspend(pf);
 }
 
 /**
@@ -16572,39 +16620,11 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 static int __maybe_unused i40e_resume(struct device *dev)
 {
 	struct i40e_pf *pf = dev_get_drvdata(dev);
-	int err;
 
 	/* If we're not suspended, then there is nothing to do */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
-
-	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
-	 * since we're going to be restoring queues
-	 */
-	rtnl_lock();
-
-	/* We cleared the interrupt scheme when we suspended, so we need to
-	 * restore it now to resume device functionality.
-	 */
-	err = i40e_restore_interrupt_scheme(pf);
-	if (err) {
-		dev_err(dev, "Cannot restore interrupt scheme: %d\n",
-			err);
-	}
-
-	clear_bit(__I40E_DOWN, pf->state);
-	i40e_reset_and_rebuild(pf, false, true);
-
-	rtnl_unlock();
-
-	/* Clear suspended state last after everything is recovered */
-	clear_bit(__I40E_SUSPENDED, pf->state);
-
-	/* Restart the service task */
-	mod_timer(&pf->service_timer,
-		  round_jiffies(jiffies + pf->service_timer_period));
-
-	return 0;
+	return i40e_io_resume(pf);
 }
 
 static const struct pci_error_handlers i40e_err_handler = {
-- 
2.25.1



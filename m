Return-Path: <netdev+bounces-98787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5408D27BE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDDCB23238
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1313E040;
	Tue, 28 May 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWL3jxUz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC613DDB1
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933983; cv=none; b=WrYnUC3aKmZp3MIZ8w+MLVOQRB00/Yu84auDJjWu1C7wOU0bGs7n3UbcchnPICXK6BpPwbfPddXGnYVa4161bCHC+U6ZvaLtuL3xcmNnDrCURaf5sTNfCRkbxGndsrK1bQy0l4G2mEeao6C6NwMJfItAyFkTGVIAfRfHBxLDNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933983; c=relaxed/simple;
	bh=UJ2E3Y583GVGQdVc9Myzhcn/k2Ye5fuzb5OUxNbziCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pC47rvrLIXTI2VTB6Dq9oNeCXtIQGV3dp5NmE+3t4u2PscjMxX9AJS4FZ5LJ+nkDpvrIWcpqkHahtcVhG8DdE5+a1rCmItE9pX5Ug6QKl1ePC5exhOJs8+yzQ6zo/eB4IgIkcaDur3y9Hxtz8Vjt04xMz2aeps7xEuEf8TXQvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWL3jxUz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933982; x=1748469982;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UJ2E3Y583GVGQdVc9Myzhcn/k2Ye5fuzb5OUxNbziCA=;
  b=kWL3jxUzaN0Wwpl9GMMHCiVAfcz7NFnTyIy82YJ1/ircCCeXDR9Z8hMv
   asZyGAjTBrFU9KKhMfTpyc55Mr6IFHJt+OOAAW6D3BT3H6DwsJzP8PsiQ
   cHCbg0k3LL4KN1rO2I1My91lIFjdcSfXqbNjh1q6K79eWoQ1xw3oxOuH3
   SISS6xvcAZdS5XHsKaCh3tnR0Vx7uG4jWGevddNhQGqt/exrFdnV7H8y2
   UEV4ta9D9TyUGNZ6C32A/84Wlea4DQENL4rt6fo+fMkFQ96M2jpSbsE6M
   ffM/b+UhKuoCPH9/AfVfmK8gr560RdNBxBTB3pZnTMcD8AwhiGZW6cniS
   g==;
X-CSE-ConnectionGUID: 3807aX7PSUiqs7Tqi3+o8g==
X-CSE-MsgGUID: PvhU5GrZSfqrHXkGWPTf1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439614"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439614"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: 2PsHNT7KRd6agUdaZkvXAA==
X-CSE-MsgGUID: Cm19ZucnThWP6GiX3iEA7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087519"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:06 -0700
Subject: [PATCH net 3/8] i40e: Fully suspend and resume IO operations in
 EEH case
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-3-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Thinh Tran <thinhtr@linux.ibm.com>, Robert Thomas <rob.thomas@ibm.com>, 
 Simon Horman <horms@kernel.org>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Thinh Tran <thinhtr@linux.ibm.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5f25ea304bf..284c3fad5a6e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11171,6 +11171,8 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit,
 	ret = i40e_reset(pf);
 	if (!ret)
 		i40e_rebuild(pf, reinit, lock_acquired);
+	else
+		dev_err(&pf->pdev->dev, "%s: i40e_reset() FAILED", __func__);
 }
 
 /**
@@ -16491,7 +16493,7 @@ static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
 
 	/* shutdown all operations */
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
-		i40e_prep_for_reset(pf);
+		i40e_io_suspend(pf);
 
 	/* Request a slot reset */
 	return PCI_ERS_RESULT_NEED_RESET;
@@ -16513,7 +16515,8 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
-	if (pci_enable_device_mem(pdev)) {
+	/* enable I/O and memory of the device  */
+	if (pci_enable_device(pdev)) {
 		dev_info(&pdev->dev,
 			 "Cannot re-enable PCI device after reset.\n");
 		result = PCI_ERS_RESULT_DISCONNECT;
@@ -16576,7 +16579,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 	if (test_bit(__I40E_SUSPENDED, pf->state))
 		return;
 
-	i40e_handle_reset_warning(pf, false);
+	i40e_io_resume(pf);
 }
 
 /**

-- 
2.44.0.53.g0f9d4d28b7e6



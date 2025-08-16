Return-Path: <netdev+bounces-214272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0550B28B4F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885C67AA01E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168C42222C7;
	Sat, 16 Aug 2025 07:14:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6F1FDA92
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328493; cv=none; b=DPmv+6+k6eMgVkURN89YspgYrlpmm/Ft77D4gJTRYjdo7pK/Ua4TW1z5gG7S1dymDVL+HTKsOZKGfT9jmi9LDp+HJjNrvkEN0HK7j/6c0mttgnB+QeUQddwSJKycw+xkOnXbIES99HdHVJHsSgnkOaAFtqfwmDxnTE82tG2nOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328493; c=relaxed/simple;
	bh=oeQ2OTjlrtVj/v9a3psGJMI/IhXiWsjVQTr6UMcOYzY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=V3wkvHnCIWaRuVvTM59964hRG5u8jVN/FzK03XTECOAAPVAFXrIFlT1UXrE8j/XPHOnEr5YvG1/8YwDtZLhNEpLaZxcrlHW5dAb+sO+HGS1UB5/FvgcpY487ucBCDzeLmp9v8YCIogGwNwY5b93kPn0CmdGBnXWeEnL59ODgqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id D075C2C25B80;
	Sat, 16 Aug 2025 09:14:41 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 9D91F600D2F4;
	Sat, 16 Aug 2025 09:14:41 +0200 (CEST)
X-Mailbox-Line: From 22e7b32bfe524219eb7ff1e5c6b4d91763b79eef Mon Sep 17 00:00:00 2001
Message-ID: <22e7b32bfe524219eb7ff1e5c6b4d91763b79eef.1755327132.git.lukas@wunner.de>
In-Reply-To: <cover.1755327132.git.lukas@wunner.de>
References: <cover.1755327132.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Aug 2025 09:10:03 +0200
Subject: [PATCH 3/3] i40e: Fix enable_cnt imbalance on PCIe error recovery
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

After a PCIe Uncorrectable Error has been reported by an i40e adapter
and has been recovered through a Secondary Bus Reset, its driver calls
pci_enable_device() without having called pci_disable_device().

This leads to an imbalance of the enable_cnt tracked by the PCI core:
Every time error recovery occurs, the enable_cnt keeps growing.  If it
occurs at least once and the driver is then unbound, the device isn't
disabled since the enable_cnt hasn't reached zero (and never again will).

The call to pci_enable_device() has almost no effect because the
enable_cnt was already incremented in i40e_probe() through the call to
pci_enable_device_mem().  The subsequent pci_enable_device() thus bails
out after invoking pci_update_current_state().

Remove pci_enable_device().  In lieu of pci_update_current_state(), set
the power state to D0 because that's the power state after a Secondary
Bus Reset (PCIe r7.0 sec 5.3.1.1).

The intended purpose of pci_enable_device() may have been to set the
Memory Space Enable bit in the Command register again after reset, but
that is already achieved by the subsequent call to pci_restore_state().

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v3.12+
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 29 +++++++--------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9d6d892602fa..7e87234fde67 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16439,29 +16439,20 @@ static pci_ers_result_t i40e_pci_error_detected(struct pci_dev *pdev,
 static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
-	pci_ers_result_t result;
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
-	/* enable I/O and memory of the device  */
-	if (pci_enable_device(pdev)) {
-		dev_info(&pdev->dev,
-			 "Cannot re-enable PCI device after reset.\n");
-		result = PCI_ERS_RESULT_DISCONNECT;
-	} else {
-		pci_set_master(pdev);
-		pci_restore_state(pdev);
-		pci_save_state(pdev);
-		pci_wake_from_d3(pdev, false);
-
-		reg = rd32(&pf->hw, I40E_GLGEN_RTRIG);
-		if (reg == 0)
-			result = PCI_ERS_RESULT_RECOVERED;
-		else
-			result = PCI_ERS_RESULT_DISCONNECT;
-	}
+	pdev->current_state = PCI_D0;
+	pci_set_master(pdev);
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
+	pci_wake_from_d3(pdev, false);
 
-	return result;
+	reg = rd32(&pf->hw, I40E_GLGEN_RTRIG);
+	if (reg == 0)
+		return PCI_ERS_RESULT_RECOVERED;
+	else
+		return PCI_ERS_RESULT_DISCONNECT;
 }
 
 /**
-- 
2.47.2



Return-Path: <netdev+bounces-214271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B2B28B4E
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8994A7AB77B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B8D2222C2;
	Sat, 16 Aug 2025 07:12:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A1A221FD4
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328379; cv=none; b=OI4miQ1dbZyZNtG7jOZrQc62lkiKzcTJ+jWbR6BWw5YyU/LCyYdrkNC/XcqDBXKGkURpQDr4E6KUHcdOENSfm1NrZmmISShwiGP9tnPYuvmScng20fry45OKmSjShRZjkuwbyIFwU5wFA2oY0GUd+Zn/5Pcrspqwvof0o2STfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328379; c=relaxed/simple;
	bh=Fl9mDD8+5RYwo64b8fYNfqa37MzxlpI2ZhiGFEcvYLc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=O6BgZl+pJn6Q8zokuRaAux/kiAm4elvKbfp0pE80tX5gCs9Ltr4FMfR5hdaUdfHe3oFLM4hnZAmJPyErSVR6B5MGfgoMa7jdBsWSMJGU/QU40dhaIkJjEq5ORueTo5r27A3MjxGcQu56/THEFZablQV7uhL0yRmZlkdSfMHbbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id 600283008985;
	Sat, 16 Aug 2025 09:12:55 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 1C9ED600D2F4;
	Sat, 16 Aug 2025 09:12:55 +0200 (CEST)
X-Mailbox-Line: From 525e494c981747ef2cdd666c50870b69aabf94af Mon Sep 17 00:00:00 2001
Message-ID: <525e494c981747ef2cdd666c50870b69aabf94af.1755327132.git.lukas@wunner.de>
In-Reply-To: <cover.1755327132.git.lukas@wunner.de>
References: <cover.1755327132.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Aug 2025 09:10:02 +0200
Subject: [PATCH 2/3] ice: Fix enable_cnt imbalance on PCIe error recovery
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

After a PCIe Uncorrectable Error has been reported by an ice adapter
and has been recovered through a Secondary Bus Reset, its driver calls
pci_enable_device_mem() without having called pci_disable_device().

This leads to an imbalance of the enable_cnt tracked by the PCI core:
Every time error recovery occurs, the enable_cnt keeps growing.  If it
occurs at least once and the driver is then unbound, the device isn't
disabled since the enable_cnt hasn't reached zero (and never again will).

The call to pci_enable_device_mem() has almost no effect because the
enable_cnt was already incremented in ice_probe() through the call to
pcim_enable_device().  The subsequent pci_enable_device_mem() thus bails
out after invoking pci_update_current_state().

Remove pci_enable_device_mem().  In lieu of pci_update_current_state(),
set the power state to D0 because that's the power state after a
Secondary Bus Reset (PCIe r7.0 sec 5.3.1.1).

The intended purpose of pci_enable_device_mem() may have been to set
the Memory Space Enable bit in the Command register again after reset,
but that is already achieved by the subsequent call to
pci_restore_state().

Fixes: 5995b6d0c6fc ("ice: Implement pci_error_handler ops")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v5.2+
---
 drivers/net/ethernet/intel/ice/ice_main.c | 32 ++++++++---------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3be4347223ef..848d5b512319 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5720,30 +5720,20 @@ ice_pci_err_detected(struct pci_dev *pdev, pci_channel_state_t err)
 static pci_ers_result_t ice_pci_err_slot_reset(struct pci_dev *pdev)
 {
 	struct ice_pf *pf = pci_get_drvdata(pdev);
-	pci_ers_result_t result;
-	int err;
 	u32 reg;
 
-	err = pci_enable_device_mem(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "Cannot re-enable PCI device after reset, error %d\n",
-			err);
-		result = PCI_ERS_RESULT_DISCONNECT;
-	} else {
-		pci_set_master(pdev);
-		pci_restore_state(pdev);
-		pci_save_state(pdev);
-		pci_wake_from_d3(pdev, false);
-
-		/* Check for life */
-		reg = rd32(&pf->hw, GLGEN_RTRIG);
-		if (!reg)
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
+	/* Check for life */
+	reg = rd32(&pf->hw, GLGEN_RTRIG);
+	if (!reg)
+		return PCI_ERS_RESULT_RECOVERED;
+	else
+		return PCI_ERS_RESULT_DISCONNECT;
 }
 
 /**
-- 
2.47.2



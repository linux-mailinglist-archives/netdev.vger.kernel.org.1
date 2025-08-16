Return-Path: <netdev+bounces-214270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B735EB28B4D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CA3177DA6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CE2222B6;
	Sat, 16 Aug 2025 07:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100ED2222B4
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755328309; cv=none; b=JRMVEicpvuk1Z/hrlp2RWzRUQrPtIJ+AldEDP8fmak+d8xgUbQZArhZMEiaB45GsKr+EFJF8E4UlSBrlruWgwVpjRi+bYpmlt6uoV9XQVLt8MoZmPSGkxhQTjqFSH4H/cWqyPcazFYngvGuNfGPc/9sGJ7xEUWaEx7N3Sf4i7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755328309; c=relaxed/simple;
	bh=tYoECHvRgWyHLr2REreetWE8ssdkEeVi/OekTvWUyh0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=lDXwTHENkjR/1jKmKf3izRxeaHYK61pdGU52u7POxqTaPYGzVPrgqMMoBJGKh4VFjXjJgb27cgxmQVVgCQ2wgQCi990z2qajYifOBVhk5TGdI+/U91okdLQh4iYohwuKwcEZEctY2D/FQjbVBsYY/1KE4CwHVmZ3GwfdMEvJz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id D3B063006799;
	Sat, 16 Aug 2025 09:11:35 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 78A4B600D2F4;
	Sat, 16 Aug 2025 09:11:35 +0200 (CEST)
X-Mailbox-Line: From 24f58fd9bff53f2cd2771d23352343caaefe834b Mon Sep 17 00:00:00 2001
Message-ID: <24f58fd9bff53f2cd2771d23352343caaefe834b.1755327132.git.lukas@wunner.de>
In-Reply-To: <cover.1755327132.git.lukas@wunner.de>
References: <cover.1755327132.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Aug 2025 09:10:01 +0200
Subject: [PATCH 1/3] ice: Fix enable_cnt imbalance on resume
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The ice driver calls pci_enable_device_mem() on resume without having
called pci_disable_device() on suspend.

This leads to an imbalance of the enable_cnt tracked by the PCI core:
Every time the adapter is resumed, the enable_cnt keeps growing.  If the
adapter is resumed at least once and the driver is then unbound, the
device isn't disabled since the enable_cnt hasn't reached zero (and
never again will).

Moreover the call to pci_enable_device_mem() has no effect because the
enable_cnt was already incremented in ice_probe() through the call to
pcim_enable_device().  The subsequent pci_enable_device_mem() thus bails
out after invoking pci_update_current_state().  But current_state was
already updated by the PCI core:

  pci_pm_resume_noirq()
    pci_pm_default_resume_early()
      pci_pm_power_up_and_verify_state()
        pci_update_current_state()

In summary, the call to pci_enable_device_mem() is both harmful and
superfluous, so remove it.

The intended purpose of the call may have been to set the Memory Space
Enable bit in the Command register again on resume, but that is already
achieved by the preceding call to pci_restore_state().

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v5.9+
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 10a473a50710..3be4347223ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5643,12 +5643,6 @@ static int ice_resume(struct device *dev)
 	if (!pci_device_is_present(pdev))
 		return -ENODEV;
 
-	ret = pci_enable_device_mem(pdev);
-	if (ret) {
-		dev_err(dev, "Cannot enable device after suspend\n");
-		return ret;
-	}
-
 	pf = pci_get_drvdata(pdev);
 	hw = &pf->hw;
 
-- 
2.47.2



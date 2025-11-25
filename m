Return-Path: <netdev+bounces-241686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2DC875B1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCC4EC396
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA633C510;
	Tue, 25 Nov 2025 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpZWvPgB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968533BBC4
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110203; cv=none; b=U/8HJ5Y7p0u095KjMIgW6/UeitpDTyOlKwQP6IDaEw3E/Vwqga3WANquVdUZLMy7S5V1q4ylyQvNxOd9KpLFsrBS4l7ZeVKLVfzok1YDiTiQBpmSCi+95FHnauZsJZdJFYqqYKgn4X4SdzQFYN+edThXiSOvT9qwdr12gEBwKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110203; c=relaxed/simple;
	bh=m5ihyvCcWicJwarHIrIJuTJxi7yNDlpoRGxYIeesDcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoWtOQLXrz2YkwxO+dVYuVBj/8Ic1MhcO32P2d2SBSEka4s/8qw5KQCkQtRJPMPXUkCFH8NPGazq8lwvvnINk09ZCXPfqLCWrJLUFMWHAESrlfQ/5Vsk+tLYhvPswQqjX8SfCF9p9E7elThV521CYmTxkfFUjnr9+lTzKlEyJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpZWvPgB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110202; x=1795646202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m5ihyvCcWicJwarHIrIJuTJxi7yNDlpoRGxYIeesDcE=;
  b=JpZWvPgBsSOrUIP/h9K82DODIhml2VbHJMx2QalrzvHthzo+yDMI1WUy
   VJUWItb8Dx5sAo4hBYrcqVrU9JiFJTwVKMEl4kUBjIeyxoJ/OEH6BH/Kf
   mp4cNGjOQb82/l1KPQpsSZwb2AaBrobwMuzwpaxr3MMoCk5tAd92A4WkF
   yHYOzP6gyuZIALqCg2ZADBmMqFr9QnClUlVrayWmyL3uhV3qGxQYrc55r
   C2rKvABH6V0EzUnARg02hGHdtrh+1waV0Lk8vlgoi6vsNbwm3IAzfe3aE
   oMiduPIlSw4KLzvPdGj0Dxn+PFdVN7UhT40oDAjLfC8SmHOIqdMox2Ldj
   g==;
X-CSE-ConnectionGUID: ezUGd6f+TmmaY0cU+7/g7Q==
X-CSE-MsgGUID: zFxLp5y7QRaFzIrYKR7HXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729899"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729899"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:40 -0800
X-CSE-ConnectionGUID: RDnkaHDkTV2knpJ1xlSgzQ==
X-CSE-MsgGUID: fADhvQ08STWUAK0pJW+Tyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209561"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	gregkh@kernel.org,
	sjaeckel@suse.de,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	post@mikaelkw.online
Subject: [PATCH net-next 06/11] e1000e: Remove unneeded checks
Date: Tue, 25 Nov 2025 14:36:25 -0800
Message-ID: <20251125223632.1857532-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller, ethtool_set_eeprom(), already performs the same checks so
these are unnecessary in the driver. This reverts commit
90fb7db49c6d ("e1000e: fix heap overflow in e1000_set_eeprom"), however,
corrections for RCT have been kept.

Link: https://lore.kernel.org/all/db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de/
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index cee57a2149ab..7b1ac90b3de4 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -551,9 +551,9 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	size_t total_len, max_len;
 	u16 *eeprom_buff;
 	int ret_val = 0;
+	size_t max_len;
 	int first_word;
 	int last_word;
 	void *ptr;
@@ -571,10 +571,6 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
-	if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
-	    total_len > max_len)
-		return -EFBIG;
-
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
-- 
2.47.1



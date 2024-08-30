Return-Path: <netdev+bounces-123862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6B966B1B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93DBB22431
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC771C1AA8;
	Fri, 30 Aug 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOt10Omh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4E1C172B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051904; cv=none; b=kglIUzlytF/9tBMMlXDUFOb92yOs2Sz/6IEpzU9vMEdqs5LYR1kHpVZXlIj8AjmveCicoTCE9fdHaz7QTHXlTotnw/U3E0uBCE9ejToWU98PF82oH3TAUCJ90VOubCqJRtZe/PRSdXl5Q05NPl00jbuFARkI2r98ZaEWHOf4byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051904; c=relaxed/simple;
	bh=xAdJk/uk38k/lbfXLMhyVfntNDd+U5njMYnXdn/Xm8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3xLnExJM0dvsdpFHDCRNsWF4ML4Hr8T5SZwbYiHlkMAXLIR461RHVQbOs9cuEk55pBCT/lEu0nBEzYNPTir3dZcfhJBTxAwt8s49nvkqT/IfPELfwrYv8rskI2drY5xbnKfyRefZLLZxNgwGomy9iFP8TKN2Ea/wCS3u+xZPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOt10Omh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051903; x=1756587903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xAdJk/uk38k/lbfXLMhyVfntNDd+U5njMYnXdn/Xm8o=;
  b=KOt10OmhFh7nhBA1qRm9/7aFUoq6Ta7j9huNqwtzVlfYuM9rPWmVLU0B
   oRhOGkWLsNuKmJpM4k5o8y95hfdJyyIcWjE2+MtCtDuA6CVU0hDHv34Z3
   bWpdE8foPkId+1J2m76tNOawU67y3G2GhMeg4uYICm/l1X9e8+8nwI9h0
   +oW4E3Bu+8h+9B4JURvF2sIKSZ3p+PMOvzpkSO5KWDh8qPEbRijN1OqPO
   +aaKD5zD/sdhmv/zyr2D62XWADtTVRCU1k9Sr05YyOccs+Xu+evNzgHLJ
   MBAGlHvrMplUyPdrMzJeIZAWqlhSCvyDv25kxVjukIfN4EvJSAJHZi0Tm
   w==;
X-CSE-ConnectionGUID: 7QHebLtvQqSMdcPQ+ddDvA==
X-CSE-MsgGUID: qnZbbGeOR1y173UM3wPCeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304285"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:05:01 -0700
X-CSE-ConnectionGUID: hHLdalEfTyGjV0kPh3m6+A==
X-CSE-MsgGUID: TzbXIaTVT+C7shbtT6VqaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625260"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:05:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 5/6] e1000e: avoid failing the system during pm_suspend
Date: Fri, 30 Aug 2024 14:04:47 -0700
Message-ID: <20240830210451.2375215-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Occasionally when the system goes into pm_suspend, the suspend might fail
due to a PHY access error on the network adapter. Previously, this would
have caused the whole system to fail to go to a low power state.
An example of this was reported in the following Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=205015

[ 1663.694828] e1000e 0000:00:19.0 eth0: Failed to disable ULP
[ 1664.731040] asix 2-3:1.0 eth1: link up, 100Mbps, full-duplex, lpa 0xC1E1
[ 1665.093513] e1000e 0000:00:19.0 eth0: Hardware Error
[ 1665.596760] e1000e 0000:00:19.0: pci_pm_resume+0x0/0x80 returned 0 after 2975399 usecs

and then the system never recovers from it, and all the following suspend failed due to this
[22909.393854] PM: pci_pm_suspend(): e1000e_pm_suspend+0x0/0x760 [e1000e] returns -2
[22909.393858] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -2
[22909.393861] PM: Device 0000:00:1f.6 failed to suspend async: error -2

This can be avoided by changing the return values of __e1000_shutdown and
e1000e_pm_suspend functions so that they always return 0 (success). This
is consistent with what other drivers do.

If the e1000e driver encounters a hardware error during suspend, potential
side effects include slightly higher power draw or non-working wake on
LAN. This is preferred to a system-level suspend failure, and a warning
message is written to the system log, so that the user can be aware that
the LAN controller experienced a problem during suspend.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205015
Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 360ee26557f7..f103249b12fa 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6671,8 +6671,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
 			/* enable wakeup by the PHY */
 			retval = e1000_init_phy_wakeup(adapter, wufc);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable wakeup\n");
+				goto skip_phy_configurations;
+			}
 		} else {
 			/* enable wakeup by the MAC */
 			ew32(WUFC, wufc);
@@ -6693,8 +6695,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			 * or broadcast.
 			 */
 			retval = e1000_enable_ulp_lpt_lp(hw, !runtime);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable ULP\n");
+				goto skip_phy_configurations;
+			}
 		}
 	}
 
@@ -6726,6 +6730,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		hw->phy.ops.release(hw);
 	}
 
+skip_phy_configurations:
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
@@ -6968,15 +6973,13 @@ static int e1000e_pm_suspend(struct device *dev)
 	e1000e_pm_freeze(dev);
 
 	rc = __e1000_shutdown(pdev, false);
-	if (rc) {
-		e1000e_pm_thaw(dev);
-	} else {
+	if (!rc) {
 		/* Introduce S0ix implementation */
 		if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
 			e1000e_s0ix_entry_flow(adapter);
 	}
 
-	return rc;
+	return 0;
 }
 
 static int e1000e_pm_resume(struct device *dev)
-- 
2.42.0



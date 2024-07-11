Return-Path: <netdev+bounces-110935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577D392F03C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1BD1C215E1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329B19EEDD;
	Thu, 11 Jul 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEWgByBw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8019EEBB
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729182; cv=none; b=gcJLrT7xfgULnpb/E5gVK1JJyG2Xc3gE5GpOoz3OvBGDp8aI+SMjdNBMrL3LmpHJlm3irzG1thjMgviuaqxnz6HE8Ow50VJ/WxOLlgtAQfPIgAKg88JfAB9erNiVzWIDNemVsjq5rB+8UNDt6Qas+EYK37l9JyzBXKvYNtPMNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729182; c=relaxed/simple;
	bh=X+8JKyy8qpnkW0bAtQjvBGoi4ccMcR5vuw6AThdzJ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz2oLWyhU78HRv88CeWkZQescFL+QKAVxbLnIeIUnYhhAvJ3I0RXA93TzrUhr9DM0KbKjcaUZYeG8le1D9GflhLmm2RZjAu59sseWtx82k29LznOUSvVomefSJqFniF3P1VKXfKyuE6SdeKUUxe3ZAyYm9SBRZeLvnpIwiFKIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEWgByBw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720729181; x=1752265181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X+8JKyy8qpnkW0bAtQjvBGoi4ccMcR5vuw6AThdzJ1U=;
  b=WEWgByBw4ctIeIFRt/AJdRpVZ1KRDrkN62wI5PXnfwb8rd5vKEQ/plp1
   FxvvsZU/Szeb0ktzYs49NMK6u09p7evFNGICIBNAUkrugS+xsm+4ozdyK
   GMl+1/lTf0TbyCsvlSfFH3dQBFbm87QV6uOYxL6NqX8nhdAz2NkI78Emn
   LaDfzfpaEResNh6UZJQ6ER1zxjffgrf6YxGhYU5hKtjDEDApC3n/mBkxF
   00j0a1fOEo6yXlF8OEQ9Tvdna2jbxRBVxoTPam2REWPv6B0c0CO2Xrzeo
   D79/u0LdmCqoXWgh7TH2jpgtW5GHcez5S0qj6Msc2dX7hRAniNMBXVILP
   w==;
X-CSE-ConnectionGUID: CppfrKGfSdeEM0dbE+lSpQ==
X-CSE-MsgGUID: DaPhDZQfSu2K0HDCpuY9MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="12508411"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="12508411"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 13:19:39 -0700
X-CSE-ConnectionGUID: ezdGeDgOTd2sH+eGx3Zi8w==
X-CSE-MsgGUID: jrwLOEQHRPSChB1n3cJemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71887421"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jul 2024 13:19:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 5/5] igc: Remove the internal 'eee_advert' field
Date: Thu, 11 Jul 2024 13:19:30 -0700
Message-ID: <20240711201932.2019925-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

Since the kernel's 'ethtool_keee' structure is in use, the internal
'eee_advert' field becomes pointless and can be removed.

This patch comes to clean up this redundant code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 1 -
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ------
 drivers/net/ethernet/intel/igc/igc_main.c    | 3 ---
 3 files changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8b14c029eda1..c38b4d0f00ce 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -202,7 +202,6 @@ struct igc_adapter {
 	struct net_device *netdev;
 
 	struct ethtool_keee eee;
-	u16 eee_advert;
 
 	unsigned long state;
 	unsigned int flags;
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0cd2bd695db1..ab17170fe7e6 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1636,10 +1636,6 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 			 edata->supported);
 
-	if (hw->dev_spec._base.eee_enable)
-		mii_eee_cap1_mod_linkmode_t(edata->advertised,
-					    adapter->eee_advert);
-
 	eeer = rd32(IGC_EEER);
 
 	/* EEE status on negotiated link */
@@ -1700,8 +1696,6 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	adapter->eee_advert = linkmode_to_mii_eee_cap1_t(edata->advertised);
-
 	if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
 		hw->dev_spec._base.eee_enable = edata->eee_enabled;
 		adapter->flags |= IGC_FLAG_EEE;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7a7cbed237d3..cb5c7b09e8a0 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4975,9 +4975,6 @@ void igc_up(struct igc_adapter *adapter)
 	/* start the watchdog. */
 	hw->mac.get_link_status = true;
 	schedule_work(&adapter->watchdog_task);
-
-	adapter->eee_advert = MDIO_EEE_100TX | MDIO_EEE_1000T |
-			      MDIO_EEE_2_5GT;
 }
 
 /**
-- 
2.41.0



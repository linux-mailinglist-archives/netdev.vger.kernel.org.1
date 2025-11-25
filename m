Return-Path: <netdev+bounces-241687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6486C87593
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38993342567
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87D33C520;
	Tue, 25 Nov 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxxsQUYt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA533BBD3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110203; cv=none; b=D2aDBIqIiwrwHuqPVuxQZoay1oVNQuASfiVoLDx2xsxvOUKXwQV9yR+zn5J1w2AGPKx8nNMkMd41VZgmg9HFST+byuBcGq5RK2Mq2zFY2uQNp3GfQEFHahNR6GFrrSuqgAy5N9LZ2FmrufVCtQUicDWkGWH+U2uf6o1H1rwwr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110203; c=relaxed/simple;
	bh=yE0ypcTOBnt7Dw3Kvp0dL6BmqiDUE9+/8vbSbXtFa/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvTN8GHfYFUOxiU/7UmOz/AG0PifU03fSMFCIJahlJbio72hCwfwHhp8UVs5XeKPmj/TXWdNX40BxWcZh29UotbnEjf3MUIMtXujOy3rpHVDDb6bZmwJBVPtXXzz8fMTeVGBPZsYd6H2h+XSZvoLeCDAbQLQzXgwSynwqWvVg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxxsQUYt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110202; x=1795646202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yE0ypcTOBnt7Dw3Kvp0dL6BmqiDUE9+/8vbSbXtFa/Q=;
  b=ZxxsQUYtp4z1grG6o0U1m4F/xnTSyleLK8WhO/nAUMxE5Okuxx2XG5Rh
   K5R/jJyPR5w1hRspAytHCoz0dF7c3c1pHc73JCzFG1SYqicyHJWzk2D7b
   Qi0ARVFchSlQCtqYnwKxZe0anSHUC3R+HQWwONLttGKU0nBUZWbU1shZU
   dU0HuGUUGPBpRu2I2xG1GJV8ULvThaFQ3NUD+gmqArwrh5OhZpfXLhZIW
   tubzqscRrliEXAyJeaAWscfOkOvrlRsdWJzJnV5tzta056vB2KwRVt7zs
   kfNAycvK9HeGjqd1M8x3b6MXXKwOTemLoAeMIA6NM9pBVYp5WeXEculCO
   A==;
X-CSE-ConnectionGUID: BvY9+7nATeGtUwHdvE43XA==
X-CSE-MsgGUID: l9TBjFFtRu6tNvMExsm+kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729905"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729905"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:41 -0800
X-CSE-ConnectionGUID: K0kgDqHtTICtDZiv93ammw==
X-CSE-MsgGUID: Yg60hxT/Tv6hoFGzXBNRdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209564"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	alok.a.tiwarilinux@gmail.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 07/11] ixgbe: avoid redundant call to ixgbe_non_sfp_link_config()
Date: Tue, 25 Nov 2025 14:36:26 -0800
Message-ID: <20251125223632.1857532-8-anthony.l.nguyen@intel.com>
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

From: Alok Tiwari <alok.a.tiwari@oracle.com>

ixgbe_non_sfp_link_config() is called twice in ixgbe_open()
once to assign its return value to err and again in the
conditional check. This patch uses the stored err value
instead of calling the function a second time. This avoids
redundant work and ensures consistent error reporting.

Also fix a small typo in the ixgbe_remove() comment:
"The could be caused" -> "This could be caused".

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 3190ce7e44c7..4af3b3e71ff1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7449,7 +7449,7 @@ int ixgbe_open(struct net_device *netdev)
 					 adapter->hw.link.link_info.link_cfg_err);
 
 		err = ixgbe_non_sfp_link_config(&adapter->hw);
-		if (ixgbe_non_sfp_link_config(&adapter->hw))
+		if (err)
 			e_dev_err("Link setup failed, err %d.\n", err);
 	}
 
@@ -12046,7 +12046,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  * @pdev: PCI device information struct
  *
  * ixgbe_remove is called by the PCI subsystem to alert the driver
- * that it should release a PCI device.  The could be caused by a
+ * that it should release a PCI device.  This could be caused by a
  * Hot-Plug event, or because the driver is going to be removed from
  * memory.
  **/
-- 
2.47.1



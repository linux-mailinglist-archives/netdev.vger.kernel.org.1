Return-Path: <netdev+bounces-158307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F2A115DD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B01168D9C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046F79FD;
	Wed, 15 Jan 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHXWDrw5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94828EA
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899736; cv=none; b=XDb1fHFB17cFxwACc8mA4LonH7Gnyg6Cm3LND1MipvClSPmtSiGgtD5oUkOhr7ufC4ILrea7bheN1cGoU170Jur0CQCC7nczkYZ2QpjvJ9CXTkAWkW4zX9YVrDhMaWmmGGWaJkKXyIJlWJEUpnddDe5g3VJ89BKKP1uLhA8YHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899736; c=relaxed/simple;
	bh=c6XEK8H2bobr3a3qFVyP7+0hRU78mtNYtPNLxlAVm6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzDF+sUTblL5ycv0p7tbnsPEANbGSiftBRluyP0WaIiSEdx5SczoX7Qck9j4CfcSlW15ErobhMAzWF5Ds6jZBxz/tVFSV27rFrH3bwdY10hMRCPP9y7vCiAtCnJnX8QUys5CQQaB8e0Fik+o6MYsbh30B2X1HWxnzZGOvV4sGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHXWDrw5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899734; x=1768435734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6XEK8H2bobr3a3qFVyP7+0hRU78mtNYtPNLxlAVm6Y=;
  b=iHXWDrw5qlxVu3+xB2BJ6HBikqB9uXJLQ1LHfAIFT/hHayK093qTwZxA
   rKDt2+4/sOgVndIkO1747YLDdR753ohx+/0Ul7Qg97SoL4dmPyURtm+VL
   XR3f3NyzbfXJGLDKuc+jBhPybs4B1Kx1TlQCYpzxt6MAJNeAfcHpq4vQR
   xzAYyjhMJd3DmjzwWffPUEYQGKtbLhdKqlkgWncYzIs/Hr5sX4paHlMwJ
   go+q7XyhHuGwEZ8fbd5IULPMPt27IBdldCCXGei4V66LGx7VPqNezE4u7
   8pOa7W0P8YxFcFaX2MrXXdZXlNBKGwJWP+wSBW/JJWNhULrKEzLra6xs9
   Q==;
X-CSE-ConnectionGUID: fyBZhamsSf2yeakBfIlUhg==
X-CSE-MsgGUID: jBvYD8ylSHeTnJeUZiF8Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897465"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897465"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:52 -0800
X-CSE-ConnectionGUID: /dPoJRCnSM2bGNf2fSZLgA==
X-CSE-MsgGUID: tB+PCrWxSPuoU3cDNDYQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211404"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 04/13] ice: ice_probe: init ice_adapter after HW init
Date: Tue, 14 Jan 2025 16:08:30 -0800
Message-ID: <20250115000844.714530-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move ice_adapter initialization to be after HW init, so it could use HW
capabilities, like number of PFs. This is needed for devlink-resource
based RSS LUT size management for PF/VF (not in this series).

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7fd79482116f..f63e485e65f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5277,13 +5277,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	}
 
 	pci_set_master(pdev);
-
-	adapter = ice_adapter_get(pdev);
-	if (IS_ERR(adapter))
-		return PTR_ERR(adapter);
-
 	pf->pdev = pdev;
-	pf->adapter = adapter;
 	pci_set_drvdata(pdev, pf);
 	set_bit(ICE_DOWN, pf->state);
 	/* Disable service task until DOWN bit is cleared */
@@ -5314,12 +5308,19 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		goto unroll_adapter;
+		return err;
 	}
 
+	adapter = ice_adapter_get(pdev);
+	if (IS_ERR(adapter)) {
+		err = PTR_ERR(adapter);
+		goto unroll_hw_init;
+	}
+	pf->adapter = adapter;
+
 	err = ice_init(pf);
 	if (err)
-		goto unroll_hw_init;
+		goto unroll_adapter;
 
 	devl_lock(priv_to_devlink(pf));
 	err = ice_load(pf);
@@ -5338,10 +5339,10 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_init:
 	devl_unlock(priv_to_devlink(pf));
 	ice_deinit(pf);
-unroll_hw_init:
-	ice_deinit_hw(hw);
 unroll_adapter:
 	ice_adapter_put(pdev);
+unroll_hw_init:
+	ice_deinit_hw(hw);
 	return err;
 }
 
-- 
2.47.1



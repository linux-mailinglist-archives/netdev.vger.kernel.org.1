Return-Path: <netdev+bounces-76699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0D86E8BA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4961C25CDD
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F053B198;
	Fri,  1 Mar 2024 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaNnz3ew"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FF3A8E1
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318949; cv=none; b=ilxEzaaKkavTNSh7dWbD4RYxs6W4GJHsErhfTtEO701GqwIAdzJcseMIZJDmzUcXfd6n2S3avM2B2HAahYpyr809qi16arTYPqsJnBJYtzg0dz9imx8h/GAj3qG0Q+fnuu1NSgU8UKZ8TIJif+vwIPZbHBA3wQNI2BK7Lf4o3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318949; c=relaxed/simple;
	bh=hVx8kEWB0NM4arQBXWds0RDnWCJ5xCohgP2h1PuXIwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvKX8yOKXkQ84NQrRn/RT+L4oRTl4aC+Xa3zPRi1XxGvkiPrHNpgRX6qK5zXeYGLFtwrOEY0ar2ZYo8Bl1N976OfKL5dY01PZzlntOHtxx3K+55+dmgx+w7U4wGBMu+KV8Ti4IfCuqEUMOsSiI2EUZzuIOL6v0XdMY3Z/0QrSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaNnz3ew; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709318948; x=1740854948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVx8kEWB0NM4arQBXWds0RDnWCJ5xCohgP2h1PuXIwU=;
  b=CaNnz3ewdOuAsqn/O4Nt5EunHsuyrwplYGIyHnBz2zMabk3qqvoNmEQb
   NcMNFXCRsB4nW6xYWUMNWvxJ3tKymOiA+71UziPo3jK9fTrL5dc43AN5S
   Cpz16mj35Y7H6fFMZ+LeXI40u0IrgeWbeNODbuwXMvpoEfpS4anVNzu4O
   r/euHooM5SQ81cdwU/PCG/RK2J3yli12D2w5DOrOoEuFNvCoQ6RQjoAgG
   pioCvCfcMapEllJLUdTyN/Iqzke59NEApiMG+WD7Vby1HXwvpjrqPRzDw
   BBpqKvjg1bA+Liy8kpJINL65Izx4XwmwUQXEmqKJPGnUGtD9rHxyGjo5/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15303351"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15303351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:49:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8205871"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 01 Mar 2024 10:49:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next v2 4/4] e1000e: Minor flow correction in e1000_shutdown function
Date: Fri,  1 Mar 2024 10:48:05 -0800
Message-ID: <20240301184806.2634508-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Add curly braces to avoid entering to an if statement where it is not
always required in e1000_shutdown function.
This improves code readability and might prevent non-deterministic
behaviour in the future.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index af5d9d97a0d6..cc8c531ec3df 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6688,14 +6688,14 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	if (adapter->hw.phy.type == e1000_phy_igp_3) {
 		e1000e_igp3_phy_powerdown_workaround_ich8lan(&adapter->hw);
 	} else if (hw->mac.type >= e1000_pch_lpt) {
-		if (wufc && !(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | E1000_WUFC_BC)))
+		if (wufc && !(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | E1000_WUFC_BC))) {
 			/* ULP does not support wake from unicast, multicast
 			 * or broadcast.
 			 */
 			retval = e1000_enable_ulp_lpt_lp(hw, !runtime);
-
-		if (retval)
-			return retval;
+			if (retval)
+				return retval;
+		}
 	}
 
 	/* Ensure that the appropriate bits are set in LPI_CTRL
-- 
2.41.0



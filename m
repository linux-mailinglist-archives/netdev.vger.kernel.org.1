Return-Path: <netdev+bounces-75970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2D86BCF0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDDEB24A5E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE12C6B4;
	Thu, 29 Feb 2024 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXIaQQzz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EFE20335
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167304; cv=none; b=n5E3iIYqMjzMcIihgPJn+eP1Hk+cQ4tpWPyG3J3haB1c/cZwtQbXbqgCdKiq7FU7c0m+uF6voB8FaSLS1DxMk6YcPE4Or8JLfTdIMCyKkCTuu8itWP49Cyn8BxjVHtmZpsjX0353uwZn01R+0oe2JUdqaIZrB6r08ewGEcoEy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167304; c=relaxed/simple;
	bh=hVx8kEWB0NM4arQBXWds0RDnWCJ5xCohgP2h1PuXIwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAcL9U97fklh4dLNMk5O3rk7HpJr77mj55KJKL+0ThTLWqpswVvVwS4FXg5CuXSu2+VucZsyhJpAMpXLs9hldPGTgVSeA21H3ZvzMmCkbqz8I4JvzFyF2Hneg8OJlgu4lWLTyo41DZywXSRq51NInW4uHz+IyI6cs6/h8a50G8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXIaQQzz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167304; x=1740703304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVx8kEWB0NM4arQBXWds0RDnWCJ5xCohgP2h1PuXIwU=;
  b=HXIaQQzzGS48lBKtPZ0MruhTMOk58I+h9Tv6MO+Kn/0x+Dpf2LCsdI3Z
   qQGXdJ1ELtlxtYnXoKh/PEMI/k1f0ECHBXoo8RooTRSvc1s4K5+YBiBo2
   0m6dMvtUZeYrXVP96kNwaDronZZffKxyjObTl0uO81zrOGhUN8ZCRcaU1
   e+q6W/9q1+0OrQguqz1xdWieyDZEtjulUqATf8udcrrJrdS4EC/F0LLO7
   PfzyyW36q7cGfrxU+6pbhLloPjfDAfYJ8hHyUwilmtWAt6HRArXra9fSI
   rhYTC05uNKs1y6GzyPawjNC4VXId0j2lo6p8OIngewfRLAeOfbdZe4jIs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776530"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12281956"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 16:41:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 4/4] e1000e: Minor flow correction in e1000_shutdown function
Date: Wed, 28 Feb 2024 16:41:32 -0800
Message-ID: <20240229004135.741586-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
References: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
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



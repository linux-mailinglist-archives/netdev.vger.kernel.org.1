Return-Path: <netdev+bounces-221403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FBB5071F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D593C3A7447
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD83570B8;
	Tue,  9 Sep 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPZqOKJN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C32FD1B6
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449964; cv=none; b=StWGCPdtDjYIeFYsTWRGVRddqpnjYkqYG6XdTjG4wrKS0DS3tQSkXL0sfPYm40htG1VnIGqoE5yE7j5zxg6fZfI3njGTkPEBneJ+tYYGAWt/Sh/wH+oeB9o2K65KYTCo1kew82myZ36/RIPT6OSuScBQcYGCSP5GBXDINe4dHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449964; c=relaxed/simple;
	bh=Rph/9iZBDrh0m0X7L8bXh52CdnnS+p8wMUzXdXPkGXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeJXMlpN2B/BVc2g73gAeuhZuEeK9Ru+XLe2wwnNYgKE8n5RurU55aDsadCWWM0huHycuKxQVjW8CsZadR6FPcpFD7wSecdWgKdsgstkFxnXTcskv/IBvM1Kwi2GjAU+jALLsLIg0uMhESiyW9x6gHaAB3svGEgpTdX0h3CQFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPZqOKJN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757449964; x=1788985964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rph/9iZBDrh0m0X7L8bXh52CdnnS+p8wMUzXdXPkGXg=;
  b=MPZqOKJNiWpGUWMTNnAHbj//Ph/M9DxJ7jMy7WZHVbC5e6Tq4N005Mv3
   RBEscj0eJNdVGjysmhnmvjKx75BFvf7CLbVB0rqw4P7uI2IqS2c77W/96
   afOykRvqL9nhiND4m6np+yvQUUpClcf5O8DrF/4qesedRqpQftUDFSJkR
   4+Hx7gt6O1vMb7U+uBiJURwn4lswML+CSIKqacPUmzXfN7IMPiJawNNtB
   4oTqgOTOj5J93VFJVr4CBHJzy92jf8v1CL62uhQbmstTkzvLnUgEeNukw
   Led/CkNuXSRhzWZ437VaHS8G12uM6LUErWF96Rp4mexzOlunGdoiTl9DL
   g==;
X-CSE-ConnectionGUID: BYpm0uXyRzae5uYpo8G66Q==
X-CSE-MsgGUID: fybb6gC9QP2hcp1MIvlM1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59606771"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59606771"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:32:41 -0700
X-CSE-ConnectionGUID: q9J0IUzQRPG+mO+GLOIMpA==
X-CSE-MsgGUID: LWNcA+eORlmRFNBwlXwfDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173287030"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2025 13:32:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/4] igb: fix link test skipping when interface is admin down
Date: Tue,  9 Sep 2025 13:32:32 -0700
Message-ID: <20250909203236.3603960-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
References: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

The igb driver incorrectly skips the link test when the network
interface is admin down (if_running == false), causing the test to
always report PASS regardless of the actual physical link state.

This behavior is inconsistent with other drivers (e.g. i40e, ice, ixgbe,
etc.) which correctly test the physical link state regardless of admin
state.
Remove the if_running check to ensure link test always reflects the
physical link state.

Fixes: 8d420a1b3ea6 ("igb: correct link test not being run when link is down")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 92ef33459aec..7b8f32c5169a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device *netdev,
 	} else {
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
-		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
-		else
-			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
 		data[TEST_REG] = 0;
-- 
2.47.1



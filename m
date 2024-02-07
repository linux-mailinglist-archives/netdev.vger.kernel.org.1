Return-Path: <netdev+bounces-69959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893684D22B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357311F22BC6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BD85957;
	Wed,  7 Feb 2024 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0nYFsqM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A884FC4
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333428; cv=none; b=KbZopidz98fZ5JpBTq+vXu+rrg8R2tFWUOuLUPDmL2fH45GWqpBgBaGQJ2Z5lTKbCyvydRkNC+L0CbmbBN/W0Nzsmr/ZI+0ugJ3cBBkPgReJu9asHDlPHCPYPracAecvOAlneVritGDAZ6q6YB5PuqzZRN7CL/R6CYTUdCEWAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333428; c=relaxed/simple;
	bh=YNKh4xJJb+21v+mu5N+fqp43cwc5UY3vEtjImJqUNPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxPpQAjffd05Dff6N/xqM4JC5l3wnPGGt0RsW7+Sk9zDnXsZW3Fgf56Lk2Xq4Di9P838TPjq7Hb2bj1WXtg7O/6FsF7oqXtR1lFU77vPkU9SHUDYrtIowJvAgM9+BqGCvnxDw1nQa/79acLAwKXvrDz+ncEz26u8Pl+NSFMJI7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0nYFsqM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707333427; x=1738869427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNKh4xJJb+21v+mu5N+fqp43cwc5UY3vEtjImJqUNPE=;
  b=d0nYFsqM1vdhXmxKlYJK9u9mZtPI7zKcAVxldrEzRSmq2w4PgHHfk4EI
   rimQH6M358Mwu110my2jsrP123NA9yUXdWbpOk7zhR4i7DOXpzqe0DHWt
   v8r4qsRhThm6cxXaP/OYIRU1Sx4mTTAllRcTzCBBWJVkqyUWRFDnriqyQ
   W3/2xLnfu9LnExSWaoR5nXqFsVD/f7Ht9mpUJ2XER5Bypjqj018vdBnYJ
   5ODnlgioW7LwW+aNRDIZOdyxSTMVhA4xkfsm72rgKy533z4EocMy4J0HV
   rFOiHDuecy5RDw5W3FKtSUvbHD+M4KIGoe730PUb2aibwLpNqaAbErDNt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="953478"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="953478"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 11:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1780662"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2024 11:17:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 2/3] igc: Use netdev printing functions for flex filters
Date: Wed,  7 Feb 2024 11:16:53 -0800
Message-ID: <20240207191656.1250777-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
References: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

All igc filter implementations use netdev_*() printing functions except for
the flex filters. Unify it.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4b3faa9a667f..91297b561519 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3385,7 +3385,7 @@ static int igc_flex_filter_select(struct igc_adapter *adapter,
 	u32 fhftsl;
 
 	if (input->index >= MAX_FLEX_FILTER) {
-		dev_err(&adapter->pdev->dev, "Wrong Flex Filter index selected!\n");
+		netdev_err(adapter->netdev, "Wrong Flex Filter index selected!\n");
 		return -EINVAL;
 	}
 
@@ -3420,7 +3420,6 @@ static int igc_flex_filter_select(struct igc_adapter *adapter,
 static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 				    struct igc_flex_filter *input)
 {
-	struct device *dev = &adapter->pdev->dev;
 	struct igc_hw *hw = &adapter->hw;
 	u8 *data = input->data;
 	u8 *mask = input->mask;
@@ -3434,7 +3433,7 @@ static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 	 * out early to avoid surprises later.
 	 */
 	if (input->length % 8 != 0) {
-		dev_err(dev, "The length of a flex filter has to be 8 byte aligned!\n");
+		netdev_err(adapter->netdev, "The length of a flex filter has to be 8 byte aligned!\n");
 		return -EINVAL;
 	}
 
@@ -3504,8 +3503,8 @@ static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 	}
 	wr32(IGC_WUFC, wufc);
 
-	dev_dbg(&adapter->pdev->dev, "Added flex filter %u to HW.\n",
-		input->index);
+	netdev_dbg(adapter->netdev, "Added flex filter %u to HW.\n",
+		   input->index);
 
 	return 0;
 }
-- 
2.41.0



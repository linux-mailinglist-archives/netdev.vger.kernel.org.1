Return-Path: <netdev+bounces-208232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B1B0AA6C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DD11C4823F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F552EA159;
	Fri, 18 Jul 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUXdRdgs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E62E92B7
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864696; cv=none; b=X8LrcupIC6ycutYunUR0KtAI24QSA4lSfXuhsqCdmkL8V2+4NL/VszLcH6kzwGO7rzxDbezaIgiS7N9ZFzu71C1xXFeA0wxwCNa+zxNCgDNQzkquDGkH801dHriN3iSKuFmQHO6pFiixbRhcpSv++wmcsaWr2hk8oD969uBSu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864696; c=relaxed/simple;
	bh=SRxBsb0TC62Wbm8k/oefwWHyhyQmkR5Q4pBNDa+qUuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiUtNYW1foCKwaqrdxaQz5r90RTKqfVRLn0iAUb9YpbVJoMySEwSg09pR0hPNR75CuCT7xc6dvEwif17FTBqspbln3R6U0d/cuqGMPpfZRa1q4WFsRUoJ4/wYRBx3o3FVn4+BpDTIjFWhi8SL/1x9u+HKWPe5AnK6ZpTqOPJKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUXdRdgs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864694; x=1784400694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SRxBsb0TC62Wbm8k/oefwWHyhyQmkR5Q4pBNDa+qUuE=;
  b=ZUXdRdgswrza9SNlVFfxrbZZfdDfEgkJZG56H1ESQQgeDuEidEDHvqJR
   +r6U5ESCSQhpeDpdGUSp9f3fhaFbCNY4oz4sLoJ3DyvHJQhuyBB/OGNJk
   XvsGOk0ut68UFJmS5cyB74eyzofofy6nUqW1QWGyk0VkjCq6TOVj2djHp
   2EukfdUAj9zJCvIierg7JGJb4g/9GdYaTQ/g8EN2/ndJvmUd7Ck4Px3gT
   YbbMjLKJ28h+4FuEBx10tZtVwZajI8hOV5KqJLrNFE1aJ0SJ55IRjAgjy
   GU8rnVYJvI9HKAVAhb1Fm2U3RfNxCD7Al/yZ+n5Svsz7bpFwgrvSJfN6k
   Q==;
X-CSE-ConnectionGUID: wj74anrOSw21EA9Sa83gog==
X-CSE-MsgGUID: jhGQnm3tT3OYeNlUyAIpig==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320647"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320647"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:26 -0700
X-CSE-ConnectionGUID: a9Jz9yWZSxCaVeLNBCKq8Q==
X-CSE-MsgGUID: nrwdzjzEReq9SD/IsLavww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506918"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	anthony.l.nguyen@intel.com,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH net-next 13/13] ixgbevf: remove unused fields from struct ixgbevf_adapter
Date: Fri, 18 Jul 2025 11:51:14 -0700
Message-ID: <20250718185118.2042772-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuto Ohnuki <ytohnuki@amazon.com>

Remove hw_rx_no_dma_resources and eitr_param fields from struct
ixgbevf_adapter since these fields are never referenced in the driver.

Note that the interrupt throttle rate is controlled by the
rx_itr_setting and tx_itr_setting variables.

This change simplifies the ixgbevf driver by removing unused fields,
which improves maintainability.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 4384e892f967..3a379e6a3a2a 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -346,7 +346,6 @@ struct ixgbevf_adapter {
 	int num_rx_queues;
 	struct ixgbevf_ring *rx_ring[MAX_TX_QUEUES]; /* One per active queue */
 	u64 hw_csum_rx_error;
-	u64 hw_rx_no_dma_resources;
 	int num_msix_vectors;
 	u64 alloc_rx_page_failed;
 	u64 alloc_rx_buff_failed;
@@ -363,8 +362,6 @@ struct ixgbevf_adapter {
 	/* structs defined in ixgbe_vf.h */
 	struct ixgbe_hw hw;
 	u16 msg_enable;
-	/* Interrupt Throttle Rate */
-	u32 eitr_param;
 
 	struct ixgbevf_hw_stats stats;
 
-- 
2.47.1



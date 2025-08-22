Return-Path: <netdev+bounces-216074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF62B31E38
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB891887314
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4471212556;
	Fri, 22 Aug 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViYRQC3d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBF71D8DFB
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875798; cv=none; b=jHVEZDiFn+YXu0xSQORwNRUq1ZE43yjezYth9VJG9hO0kaywUYDMOZxJM7jKAeGUP4yp+H+9XJ6wHTfM7qv5TKpYCN7dYoAAebqH/wqCmYxgMtao70VW4OrHtelaQNnfOaNU7wNxlAfQ76+KWQ9dk87IsqXejhtzAUh8SsSpkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875798; c=relaxed/simple;
	bh=oY0mk8KxQRWIvojXK2ESN4yhb+YTZY9xVqcXmvwTL6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NSYREDazTHzaKRaA1qFPQzDzJfI50K1VsXUdauTpf5lEiFsqgauaMQcm04pf0V037yFHTYu5x18unkIggxzm+XPYHHQ0rVW+ESeVHTDik1/aEko9K715JOWC2ZifqyK3RvlTpKCc5X//AM+HKepy+U0SHY44caILC954g6kUnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViYRQC3d; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755875797; x=1787411797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oY0mk8KxQRWIvojXK2ESN4yhb+YTZY9xVqcXmvwTL6c=;
  b=ViYRQC3d5KV2oOStm4DAjVTGZQLgGRhfQK4vOc/+MgPoqrBoN8LLnzPU
   mIDfy6/TlB4SykPmUCKyFwdKIp9wYifgE2QzA+O+RaMnF4zVvXEUnjPCs
   imJRWKhz1x5IHWiq8si2pky4X0wT+ZMmW50zej4Gt/QgTJhMCt+y6Vfx9
   uB2QzZqo4ogesTIMQAK71X5T37UtknpKGGT2QAU95uFN3sFiPsJJrW5De
   B538kMBqy4ubDtvnpGnjldwGsZu7q3Vd+1NehOK+raYX+Vk1TAXGcdfK/
   EsQphQAW82gA2sF+UZL3dU4igV1gsuPahInQQ0PynZsTmnZCqGV+vDu1x
   Q==;
X-CSE-ConnectionGUID: Z1hR4FybRJCIESkSdp9PEg==
X-CSE-MsgGUID: RG97LaVGQcWB2VQbLR61gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58135045"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58135045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:16:34 -0700
X-CSE-ConnectionGUID: e09I/N5oSyasjeBqD4Wc4g==
X-CSE-MsgGUID: Lrd2Pn0TQe6YY13vbLYEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172923721"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 22 Aug 2025 08:16:32 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net] i40e: remove redundant memory barrier when cleaning Tx descs
Date: Fri, 22 Aug 2025 17:16:17 +0200
Message-Id: <20250822151617.2261094-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e has a feature which writes to memory location last descriptor
successfully sent. Memory barrier in i40e_clean_tx_irq() was used to
avoid forward-reading descriptor fields in case DD bit was not set.
Having mentioned feature in place implies that such situation will not
happen as we know in advance how many descriptors HW has dealt with.

Besides, this barrier placement was wrong. Idea is to have this
protection *after* reading DD bit from HW descriptor, not before.
Digging through git history showed me that indeed barrier was before DD
bit check, anyways the commit introducing i40e_get_head() should have
wiped it out altogether.

Also, there was one commit doing s/read_barrier_depends/smp_rmb when get
head feature was already in place, but it was only theoretical based on
ixgbe experiences, which is different in these terms as that driver has
to read DD bit from HW descriptor.

Fixes: 1943d8ba9507 ("i40e/i40evf: enable hardware feature head write back")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 048c33039130..b194eae03208 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -948,9 +948,6 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 		if (!eop_desc)
 			break;
 
-		/* prevent any other reads prior to eop_desc */
-		smp_rmb();
-
 		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
-- 
2.34.1



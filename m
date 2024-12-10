Return-Path: <netdev+bounces-150831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F8E9EBAD8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D5B166E5F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C90228CA1;
	Tue, 10 Dec 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="He6Te8u7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018122838D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862455; cv=none; b=VtmPgK5sW+BC1kqVP1WUBxQ2c3bk6sKO4j3l/g+GsbzSK2ugGo7fueNaA9vz4n/ilwdUyWKX3z+/LBLhorLQ2mgg7PzuuAh/oHtA+bXrcjkI6fAjEqdkbbjAq65pa0UC+kLZRsfUEOHVBicbYGzWRKO2iN8Y1NRlbOwQIt5VLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862455; c=relaxed/simple;
	bh=v7hoMCEz7ROSti854OJowvcJXvedBmhI9aTL1eiL1pY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uobn6OMX2ZuHIfnr9PvPg8lb37m01jSCabP/rvMYVUR24loJHHWrgNP0vVbdvdoNV+oNpqYFEEcPo0b4FRlDn7a9y2sbSpJn3LI2xncGI9nSAI/gINuE0aKAW+xL9xABUQ2TUZtZ8MSQXIj0fseZwRB2Rqq8ol3xGyBvUqORKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=He6Te8u7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862454; x=1765398454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=v7hoMCEz7ROSti854OJowvcJXvedBmhI9aTL1eiL1pY=;
  b=He6Te8u7aHuvZeeG71+itQnKrKPjp8UNshWKrTYohqcpM2Nyhd0rJNl+
   btKXm7WgAq6K5X7yRODnUSq1SbXYVvslVV6Na8pHE+RXmBP/n8lu/I32A
   rXebA5TaNV1JrxVKCmY9bU0icx7RInmVqqIWhJNGY56025dhcnMOOVero
   aefNXmQmOnItG+ED6/BQ6RhlMwxSC2ubebk57tXlJWMOYhlTsnzPkTMHm
   Hg/xmyrZCawo4QQ14b0mHKmmAMDTME7tSg2eg3gqBgTYiPrATXR4WKdyB
   CEUCoNbHJQdk8Rpvbk2qD/AuFx4tEcR+MQnEaGCWrqPoTgpKlWP6yoA0h
   w==;
X-CSE-ConnectionGUID: BSq7Qdw3QNODbgx/pq1PKQ==
X-CSE-MsgGUID: k99KlM33Rp6JyOQsJZySzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147326"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147326"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:29 -0800
X-CSE-ConnectionGUID: xkZyub4oTTKws2e2YFLYqg==
X-CSE-MsgGUID: rHsLj76tQAmwEDT4bXhExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424104"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:29 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:18 -0800
Subject: [PATCH net-next v10 09/10] ice: move prefetch enable to
 ice_setup_rx_ctx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-9-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The ice_write_rxq_ctx() function is responsible for programming the Rx
Queue context into hardware. It receives the configuration in unpacked form
via the ice_rlan_ctx structure.

This function unconditionally modifies the context to set the prefetch
enable bit. This was done by commit c31a5c25bb19 ("ice: Always set prefena
when configuring an Rx queue"). Setting this bit makes sense, since
prefetching descriptors is almost always the preferred behavior.

However, the ice_write_rxq_ctx() function is not the place that actually
defines the queue context. We initialize the Rx Queue context in
ice_setup_rx_ctx(). It is surprising to have the Rx queue context changed
by a function who's responsibility is to program the given context to
hardware.

Following the principle of least surprise, move the setting of the prefetch
enable bit out of ice_write_rxq_ctx() and into the ice_setup_rx_ctx().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c   | 3 +++
 drivers/net/ethernet/intel/ice/ice_common.c | 9 +++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 5fe7b5a100202e6f0c33c617c604d45f9487b1f4..b2af8e3586f7620d372f2055e337485d102d3cbc 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -454,6 +454,9 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Rx queue threshold in units of 64 */
 	rlan_ctx.lrxqthresh = 1;
 
+	/* Enable descriptor prefetch */
+	rlan_ctx.prefena = 1;
+
 	/* PF acts as uplink for switchdev; set flex descriptor with src_vsi
 	 * metadata and flags to allow redirecting to PR netdev
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8683c9ac6cedc5a6f9b34f347784c496ec08b840..4c6cc48aaef0c31eaa1d9de35effcd812933d270 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1433,14 +1433,13 @@ static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
 }
 
 /**
- * ice_write_rxq_ctx
+ * ice_write_rxq_ctx - Write Rx Queue context to hardware
  * @hw: pointer to the hardware structure
  * @rlan_ctx: pointer to the rxq context
  * @rxq_index: the index of the Rx queue
  *
- * Converts rxq context from sparse to dense structure and then writes
- * it to HW register space and enables the hardware to prefetch descriptors
- * instead of only fetching them on demand
+ * Pack the sparse Rx Queue context into dense hardware format and write it
+ * into the HW register space.
  */
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
@@ -1450,8 +1449,6 @@ int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 	if (!rlan_ctx)
 		return -EINVAL;
 
-	rlan_ctx->prefena = 1;
-
 	ice_pack_rxq_ctx(rlan_ctx, &buf);
 
 	return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);

-- 
2.47.0.265.g4ca455297942



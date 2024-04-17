Return-Path: <netdev+bounces-88731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18638A85B8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE00282B8C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C1C1420B3;
	Wed, 17 Apr 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7u5rd24"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE31411FC
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363351; cv=none; b=rM9fIbOFpbXgatVbXV0xGX3ICfdQ9K2kt7ClHMIff8eF7Vj4bRg+RAPfDaH2HxOKr6LqCzwjZqfV1ASetNnCVeg2ySRMdGCtJ8JKCuDwcn6XKSYtB7blb2QEGBrgMaGcUnhT0GRwyVFTdFpQG7XCkFlH/eWUGbi81iuAqqxdbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363351; c=relaxed/simple;
	bh=1E2uszQfk+zUo+ucnNQQ2WB7gVrzkrOrAWmc+rg1JxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1+lY4GcUI+jHyizyxhc/tY2eDHifR8eEZI48sy4+p0Htw68IxOGq3fQhuwKIopTK9JlwrbMIENDoUThnd0fT/VS9Ex0psLV9h6d6C/y46OcN3G4D8jdtzo9bis/ypzCpIjj+4fGw4DaB4y84JlXHVXVxpIGT2Wh7F/QPsaWOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7u5rd24; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713363351; x=1744899351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1E2uszQfk+zUo+ucnNQQ2WB7gVrzkrOrAWmc+rg1JxU=;
  b=O7u5rd24K3SbLKwBjuJzjJqIKsVg9MQ/m6tYsNjUKpNghc6I1qB+aWRW
   NSusMZiLhHGogDwwP7TRmZutNubTnF7iTow7I8yzpkS8BaSUEzxjYT3La
   +GlKuyPH1rgtGn2NqvvuGZrYyN8401X6HosHqyJKsIG5srEVimULnbjFn
   PdBlwdT/XNWfqkRRI7lUWIKzsA9Xl0xJLsgnl24IYvj4g9ZYGx0C94nup
   BbTHNQiDdgXw2fMANVjIKhFQ04HXBr4MSczXc6/2k8crIBQKyu4RRUIeJ
   Odg1IR/kyHt9hNbAIWzmnPVfi6OFOuCXu2DIo8lrVLWdms6UkjduLd4uQ
   g==;
X-CSE-ConnectionGUID: YbAHm40US4aestMvU+rU4g==
X-CSE-MsgGUID: TWWEn51mS26H76wTn39alg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737136"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:15:50 -0700
X-CSE-ConnectionGUID: MM4sNz4iReGDtdlKbdCsxQ==
X-CSE-MsgGUID: eNDdauv2TXmWVG8ZgRHXVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="60050475"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 17 Apr 2024 07:15:46 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: [iwl-next v4 4/8] ice: treat subfunction VSI the same as PF VSI
Date: Wed, 17 Apr 2024 16:20:24 +0200
Message-ID: <20240417142028.2171-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9bbb7b328ae9..29552598ddb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6677,7 +6677,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7375,7 +7376,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0



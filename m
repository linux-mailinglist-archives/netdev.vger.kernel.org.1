Return-Path: <netdev+bounces-126095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1F96FDF9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7271E1F21C9E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A277158DC6;
	Fri,  6 Sep 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frLg0zNA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7415ADA7
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661817; cv=none; b=iI98j7NC+IiUZ6l9G6v4OydjBjeFYEWXz7m5KSN94ANPExHZO27//E/uRsF45CK/ArP4+zMMjn/8sVJBmGRptTgbqw1wOMP5eHp6/Uro4j6rRogMDNHcp9cKYPjE87XMy0+948gwV4BjjMaYzGtMcxaHtmWiU/QPxHlyUfsfhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661817; c=relaxed/simple;
	bh=vgxzkdmAttEMD3KqyGvODQXEltQZe5xpiwecWIkz87E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzjuX1Q7eOqf6TrUIsyIsI+Xyy3wAcwEjguw0IwOCHnhoUivm/9td5nJqzHAgI+U4rSQPR328K2OPQFjndrmPyBS+isqsbUi0VhQA0olpPT5gJ0fzwyT9UWgqazUKPzcphzp9KfwRYjvL4QdeiczGcdNje/L/brnB+lhkR/Bol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frLg0zNA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661816; x=1757197816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgxzkdmAttEMD3KqyGvODQXEltQZe5xpiwecWIkz87E=;
  b=frLg0zNAavW699+9eUB814vEj5uujuytb/aYLpBpYokXpVX4GvQpNNRl
   T5RvgGmwMz7eky3ohGm3kraVRA55r1hFZSGxC+ykgeK9BfVANUkjK3TMr
   4u+omYU2TYEVcEfgXULDdQbE5mQrn2Wwil9serX/fZ5oJqbDCpi7zDrd2
   PzeIbiZUVCm57F51LXL30k85BBJ6rMc9Lt9sT7YDdOW4z1AF6Ty4LlVIf
   gO3TKefIWLlJr/RdtRIH2tHC+xlPYXMBStvDlSisNE8imV2fVEZyYV+d/
   D5TktCukQUmGl/Slihm2uV/jy53Xv6seTJkF7inXHYOCoOGH8T/3CeJAN
   w==;
X-CSE-ConnectionGUID: dMWSR3R4TqiX8o6Y0u6b+A==
X-CSE-MsgGUID: LNRmYm2QRlylsWW1SNTSNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030697"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:14 -0700
X-CSE-ConnectionGUID: Twg/W5kJTYG3DtLF5DT/SQ==
X-CSE-MsgGUID: SBU0zUuhRDW0akyLqDq83w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490410"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v5 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Fri,  6 Sep 2024 15:29:55 -0700
Message-ID: <20240906223010.2194591-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b11124fef4b9..c2e56413645a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6754,7 +6754,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			      vsi->type == ICE_VSI_SF)))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7452,7 +7453,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0



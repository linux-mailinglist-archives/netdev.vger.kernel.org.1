Return-Path: <netdev+bounces-169168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E446DA42C53
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2316118902A8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7531FFC53;
	Mon, 24 Feb 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJN0uPeY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E31EDA26
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424021; cv=none; b=WAPEAxUMkjFBJfv5A23205YA6mDXAgB6BmEhgdY5WmQKwvS+1hKpucDADP9pDU0H3ohfzfLUs8hvKhrpw50emc3f5ZzOkieu7aQd0rYzJeQ9xTHIcSLfNI6p4UVGTL+/eYUiQst0dv8FC3ABpfW32JB3kajUSJsBHGkgh5y7VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424021; c=relaxed/simple;
	bh=zXIV4Vs4DTZa9MGglwuulnjPA627lXa9IWLZ1k8YS88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoKygHFU9L9UMT1Xvk5dxLs2WdThwdUgQ1BT1WGzg+0aDKT+y8qGX939IcgY3SDbIYIXhsLaBNuufOsQCUBd85HzH0QjxGSNEpx92aLvDM73BlMqWyK1BdJVHhLozkezrJMlgK4XqswXcbJcTxs0g0jfFVbIqfvssRBscb6gfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJN0uPeY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424017; x=1771960017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zXIV4Vs4DTZa9MGglwuulnjPA627lXa9IWLZ1k8YS88=;
  b=VJN0uPeYFqzpHkBiZ4pk4JMoJO2Ffm1ROcn+Vhls4wXxHswy+bIW5c8e
   z1Bx9o5p57WK5DHNihUVtjMawimCdkNwsn5F5S0u4PGyEYxD0sjjJY259
   HKMkT89YrD/JhODJGAbOGSoGOgg0ea6snf//XD5hp57IKk2xNz9ZFJu9b
   R+9YhbjGJfERgRmLh0zSu1DQMCAHweQG8QzKcaDNry1ih58OkCBLHwwMj
   8PIqMBxmx7aj2NQWXNM2gkK+ISqmxNbpr98Dkc4Kpaj/geowf81KZyDbP
   cWsZ4W8azLx4ChR6FeSoWhIvBPgCToT3rxwho+tq/WNiUhCewqjgKFUcI
   g==;
X-CSE-ConnectionGUID: w2qgzB+WT3KsZqUGLQ5bCw==
X-CSE-MsgGUID: VVvWsJcgQtCJM1tA0lYbNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614195"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614195"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:55 -0800
X-CSE-ConnectionGUID: G/ozPYuZTLqSemwXHL7tzw==
X-CSE-MsgGUID: pO5Huj65RRWoe2RUGpndWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358459"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/5] ice: Avoid setting default Rx VSI twice in switchdev setup
Date: Mon, 24 Feb 2025 11:06:42 -0800
Message-ID: <20250224190647.3601930-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

As part of switchdev environment setup, uplink VSI is configured as
default for both Tx and Rx. Default Rx VSI is also used by promiscuous
mode. If promisc mode is enabled and an attempt to enter switchdev mode
is made, the setup will fail because Rx VSI is already configured as
default (rule exists).

Reproducer:
  devlink dev eswitch set $PF1_PCI mode switchdev
  ip l s $PF1 up
  ip l s $PF1 promisc on
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs

In switchdev setup, use ice_set_dflt_vsi() instead of plain
ice_cfg_dflt_vsi(), which avoids repeating setting default VSI for Rx if
it's already configured.

Fixes: 50d62022f455 ("ice: default Tx rule instead of to queue")
Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fb527434b58b..d649c197cf67 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -38,8 +38,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (ice_vsi_add_vlan_zero(uplink_vsi))
 		goto err_vlan_zero;
 
-	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
-			     ICE_FLTR_RX))
+	if (ice_set_dflt_vsi(uplink_vsi))
 		goto err_def_rx;
 
 	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
-- 
2.47.1



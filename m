Return-Path: <netdev+bounces-95337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439898C1ED0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4672812FD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED91DFEA;
	Fri, 10 May 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnilRB6w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC871DA53
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325274; cv=none; b=KO6Uy4Cg58JlsYWAYGoxtaPsl//ya/iq7sLh+k/1K3c7jz68W7yCSGnFZRR/RtyOgGNuD5yvZYtk8uSnGDBT538S1HhYEOXvAYbHmA6b3jU4oc+uuuQKsHa7OZzcB5LnF236HKWAa9amLkH6iTSPieMfR89A9ms18mWdH3UEKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325274; c=relaxed/simple;
	bh=7Z5BMxHLuJ5UMSApi9Kc/uGbu8BZML4zQAUIuCmDxZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1FGxBjp0lL2ngrTblzwEFF4SmJNYzjGRK4bGp6mxQbR7eiqk1/pRjQ4rA3X3dM21abbb5V19MiG9d9a0RlZM9WNUdClSKOiQ56xJKmEEyoL/M/cVqLq1fICp0L53MONOv/hTOhKNe9Y4B9vUQEhjwBdR9OYjL+TaqLCLgZ9WVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnilRB6w; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325273; x=1746861273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Z5BMxHLuJ5UMSApi9Kc/uGbu8BZML4zQAUIuCmDxZg=;
  b=LnilRB6wmZRNIcya1Gnu4W47bIgJxXeiIJhhqKBCbXTuIwkFaY+K6y89
   Q16zjYFZU2WOgOqP8bRK0CAdcE6OnkxJEze8DdOOdAqdOBNmcCHUOT7gz
   wTQ4wV5mBif71BKwXhqAkdABS3aB/Zo1b2lSPeoNQ5GIqgT84VEQA1M8j
   P0R0cEq1R8ZP5783P9cuRN0CCcE5g/tXkkc6u0VcKaCOvdXT5yr16UBHd
   Tn4oPyL+BBWK5f0oFEjt2o6xCjCQ1/me3fbzAhuJ1UCuRmJ6WXjsS2fXN
   W8vpb6bxFCvms4/Eo4ZDXJwN3u7jb+8YWjmsFwLkBviPHkyzgcg+G3TUC
   Q==;
X-CSE-ConnectionGUID: QWDBdxI6SKyrukFwBjTVyA==
X-CSE-MsgGUID: hEviYpXNQeaqqh+GilL1FA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21886711"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21886711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:14:33 -0700
X-CSE-ConnectionGUID: 4FhhP4J2SFqh65JTLrf6Xw==
X-CSE-MsgGUID: huWJ7oP4S7y/oyNu+/wWcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29383136"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:14:28 -0700
Date: Fri, 10 May 2024 09:13:51 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 03/14] ice: add basic devlink subfunctions support
Message-ID: <Zj3JLw/mT/MZJu9G@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-4-michal.swiatkowski@linux.intel.com>
 <ZjyuTA_zMXzZSa7L@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjyuTA_zMXzZSa7L@nanopsycho.orion>

On Thu, May 09, 2024 at 01:06:52PM +0200, Jiri Pirko wrote:
> Tue, May 07, 2024 at 01:45:04PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >
> >Implement devlink port handlers responsible for ethernet type devlink
> >subfunctions. Create subfunction devlink port and setup all resources
> >needed for a subfunction netdev to operate. Configure new VSI for each
> >new subfunction, initialize and configure interrupts and Tx/Rx resources.
> >Set correct MAC filters and create new netdev.
> >
> >For now, subfunction is limited to only one Tx/Rx queue pair.
> >
> >Only allocate new subfunction VSI with devlink port new command.
> >This makes sure that real resources are configured only when a new
> >subfunction gets activated. Allocate and free subfunction MSIX
> 
> Interesting. You talk about actitation, yet you don't implement it here.
> 

I will rephrase it. I meant that new VSI needs to be created even before
any activation or configuration.

> 
> 
> >interrupt vectors using new API calls with pci_msix_alloc_irq_at
> >and pci_msix_free_irq.
> >
> >Support both automatic and manual subfunction numbers. If no subfunction
> >number is provided, use xa_alloc to pick a number automatically. This
> >will find the first free index and use that as the number. This reduces
> >burden on users in the simple case where a specific number is not
> >required. It may also be slightly faster to check that a number exists
> >since xarray lookup should be faster than a linear scan of the dyn_ports
> >xarray.
> >
> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> >Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >---
> > .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 357 ++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  33 ++
> > drivers/net/ethernet/intel/ice/ice.h          |   4 +
> > drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
> > drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
> > 7 files changed, 410 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >index 10073342e4f0..3fb3a7e828a4 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >@@ -6,6 +6,7 @@
> > #include "ice.h"
> > #include "ice_lib.h"
> > #include "devlink.h"
> >+#include "devlink_port.h"
> > #include "ice_eswitch.h"
> > #include "ice_fw_update.h"
> > #include "ice_dcb_lib.h"
> >@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
> > 
> > 	.rate_leaf_parent_set = ice_devlink_set_parent,
> > 	.rate_node_parent_set = ice_devlink_set_parent,
> >+
> >+	.port_new = ice_devlink_port_new,
> > };
> > 
> >+

[...]

> >+/**
> >+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
> >+ * @port: pointer to devlink port
> >+ * @hw_addr: hw address to set
> >+ * @hw_addr_len: hw address length
> >+ * @extack: extack for reporting error messages
> >+ *
> >+ * Sets mac address for the port, verifies arguments and copies address
> >+ * to the subfunction structure.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ */
> >+static int
> >+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
> >+				int hw_addr_len,
> >+				struct netlink_ext_ack *extack)
> >+{
> >+	struct ice_dynamic_port *dyn_port;
> >+
> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >+
> >+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
> >+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
> >+		return -EADDRNOTAVAIL;
> >+	}
> >+
> >+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
> 
> How does this work? You copy the address to the internal structure, but
> where you update the HW?
>

When the basic MAC filter is added in HW.

> 
> >+
> >+	return 0;
> >+}

[...]

> > 
> >@@ -5383,6 +5389,7 @@ static void ice_remove(struct pci_dev *pdev)
> > 		ice_remove_arfs(pf);
> > 
> > 	devl_lock(priv_to_devlink(pf));
> >+	ice_dealloc_all_dynamic_ports(pf);
> > 	ice_deinit_devlink(pf);
> > 
> > 	ice_unload(pf);
> >@@ -6677,7 +6684,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
> > 
> > 	if (vsi->port_info &&
> > 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> >-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
> >+	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {
> 
> I think this is some leftover, remove.
>

Yeah, thanks, will remove it.

> 
> > 		ice_print_link_msg(vsi, true);
> > 		netif_tx_start_all_queues(vsi->netdev);
> > 		netif_carrier_on(vsi->netdev);
> >-- 
> >2.42.0
> >
> >


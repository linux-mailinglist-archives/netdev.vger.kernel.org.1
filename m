Return-Path: <netdev+bounces-95454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94A8C24C8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302DD1C212B4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2B4595B;
	Fri, 10 May 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRufVSVy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3042D05D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343937; cv=none; b=c5Msnj8shEyL9i46Pl+EbUk+JsjKrq9h4TvIBADX09PWrlpx2vO/j6zOHUfp5ObcIYZ+mhRh+wjCP/nVzb/zQ/rejo33+Q23Mns2lVsMOviuJNCL904+fv7yhPc/TGcXSxv5vEU8BoSoeXQyrO/F42SiG77IEj2RaOtD2Z5k164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343937; c=relaxed/simple;
	bh=BXzKstGzxPqlbeNoIsIzZuUUYPUJ1HgsI3/6KyW9ISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqJ/sTKnqfh19YykaM1CLXr8xq12HP3D7gQStGspKVYrZYfZZozgqG/YmKzjdOR0Pj7O7RlbaIJet4G+8O2MHK8qvQbKUxMnmPP2+bgmv/d1b7MMWXLCrLJKX2DSREBnOAmYguxiagyaQyhGZElSBqvpU9+3zQoc0LwQxp/rlZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRufVSVy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715343936; x=1746879936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXzKstGzxPqlbeNoIsIzZuUUYPUJ1HgsI3/6KyW9ISs=;
  b=FRufVSVylAA/nTQVBo8S15J2o/CSk/RhOsG6MiINfbUnvnALOUy9Cwzy
   3mAC/2PGLoSXnBZYVooE/3uX2XdcAb2eqZMqqE3AESsn+ARR0a0cHi50u
   1xKxIcpE8x7t7cUKtB/TgORNvlnFIIcrs1Yb/tvcMFXQCmx9mDqv7hkhq
   PXgvJuiaGrEIYjToDrt+d6N17XhPX0NfG0uT2qPjCeQsHbRKOZX7dCOkj
   J659kyof9g2X5QPPad98x4XreqWowLikmAmjYNPgtzf2662RXcFT2Ul4n
   h+u5iUsUn0vuwHt4Wv6WzTYCkhSZZme40N5dv0/E5vmHl2fj7tqiPpFAO
   w==;
X-CSE-ConnectionGUID: QyS0m72FTt6S8ybHgHAffg==
X-CSE-MsgGUID: +MG4ULhySuWDRMjWbwhLFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22727895"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22727895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:25:35 -0700
X-CSE-ConnectionGUID: ozavnAW1Rg2nU4/Jp2i3Rw==
X-CSE-MsgGUID: 8sxR48oGT4igDeuoRSIU7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67079159"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:25:32 -0700
Date: Fri, 10 May 2024 14:25:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 03/14] ice: add basic devlink subfunctions support
Message-ID: <Zj4SHGvuxZWQEYuN@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-4-michal.swiatkowski@linux.intel.com>
 <ZjyuTA_zMXzZSa7L@nanopsycho.orion>
 <Zj3JLw/mT/MZJu9G@mev-dev>
 <Zj3_fVh2QD7awpWN@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3_fVh2QD7awpWN@nanopsycho.orion>

On Fri, May 10, 2024 at 01:05:33PM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 09:13:51AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, May 09, 2024 at 01:06:52PM +0200, Jiri Pirko wrote:
> >> Tue, May 07, 2024 at 01:45:04PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >
> >> >Implement devlink port handlers responsible for ethernet type devlink
> >> >subfunctions. Create subfunction devlink port and setup all resources
> >> >needed for a subfunction netdev to operate. Configure new VSI for each
> >> >new subfunction, initialize and configure interrupts and Tx/Rx resources.
> >> >Set correct MAC filters and create new netdev.
> >> >
> >> >For now, subfunction is limited to only one Tx/Rx queue pair.
> >> >
> >> >Only allocate new subfunction VSI with devlink port new command.
> >> >This makes sure that real resources are configured only when a new
> >> >subfunction gets activated. Allocate and free subfunction MSIX
> >> 
> >> Interesting. You talk about actitation, yet you don't implement it here.
> >> 
> >
> >I will rephrase it. I meant that new VSI needs to be created even before
> >any activation or configuration.
> >
> >> 
> >> 
> >> >interrupt vectors using new API calls with pci_msix_alloc_irq_at
> >> >and pci_msix_free_irq.
> >> >
> >> >Support both automatic and manual subfunction numbers. If no subfunction
> >> >number is provided, use xa_alloc to pick a number automatically. This
> >> >will find the first free index and use that as the number. This reduces
> >> >burden on users in the simple case where a specific number is not
> >> >required. It may also be slightly faster to check that a number exists
> >> >since xarray lookup should be faster than a linear scan of the dyn_ports
> >> >xarray.
> >> >
> >> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >> >Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> >> >Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> >---
> >> > .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
> >> > .../ethernet/intel/ice/devlink/devlink_port.c | 357 ++++++++++++++++++
> >> > .../ethernet/intel/ice/devlink/devlink_port.h |  33 ++
> >> > drivers/net/ethernet/intel/ice/ice.h          |   4 +
> >> > drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
> >> > drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
> >> > drivers/net/ethernet/intel/ice/ice_main.c     |   9 +-
> >> > 7 files changed, 410 insertions(+), 3 deletions(-)
> >> >
> >> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >index 10073342e4f0..3fb3a7e828a4 100644
> >> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >> >@@ -6,6 +6,7 @@
> >> > #include "ice.h"
> >> > #include "ice_lib.h"
> >> > #include "devlink.h"
> >> >+#include "devlink_port.h"
> >> > #include "ice_eswitch.h"
> >> > #include "ice_fw_update.h"
> >> > #include "ice_dcb_lib.h"
> >> >@@ -1277,6 +1278,8 @@ static const struct devlink_ops ice_devlink_ops = {
> >> > 
> >> > 	.rate_leaf_parent_set = ice_devlink_set_parent,
> >> > 	.rate_node_parent_set = ice_devlink_set_parent,
> >> >+
> >> >+	.port_new = ice_devlink_port_new,
> >> > };
> >> > 
> >> >+
> >
> >[...]
> >
> >> >+/**
> >> >+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
> >> >+ * @port: pointer to devlink port
> >> >+ * @hw_addr: hw address to set
> >> >+ * @hw_addr_len: hw address length
> >> >+ * @extack: extack for reporting error messages
> >> >+ *
> >> >+ * Sets mac address for the port, verifies arguments and copies address
> >> >+ * to the subfunction structure.
> >> >+ *
> >> >+ * Return: zero on success or an error code on failure.
> >> >+ */
> >> >+static int
> >> >+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
> >> >+				int hw_addr_len,
> >> >+				struct netlink_ext_ack *extack)
> >> >+{
> >> >+	struct ice_dynamic_port *dyn_port;
> >> >+
> >> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >> >+
> >> >+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
> >> >+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
> >> >+		return -EADDRNOTAVAIL;
> >> >+	}
> >> >+
> >> >+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
> >> 
> >> How does this work? You copy the address to the internal structure, but
> >> where you update the HW?
> >>
> >
> >When the basic MAC filter is added in HW.
> 
> When is that. My point is, user can all this function at any time, and
> when he calls it, he expect it's applied right away. In case it can't be
> for example applied on activated SF, you should block the request.
> 
> 

Good point, I will block the request in this case. The filter is added
during VSI configuration, in this case during SF activation.

> >
> >> 
> >> >+
> >> >+	return 0;
> >> >+}
> >
> >[...]
> >
> >> > 
> >> >@@ -5383,6 +5389,7 @@ static void ice_remove(struct pci_dev *pdev)
> >> > 		ice_remove_arfs(pf);
> >> > 
> >> > 	devl_lock(priv_to_devlink(pf));
> >> >+	ice_dealloc_all_dynamic_ports(pf);
> >> > 	ice_deinit_devlink(pf);
> >> > 
> >> > 	ice_unload(pf);
> >> >@@ -6677,7 +6684,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
> >> > 
> >> > 	if (vsi->port_info &&
> >> > 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> >> >-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
> >> >+	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {
> >> 
> >> I think this is some leftover, remove.
> >>
> >
> >Yeah, thanks, will remove it.
> >
> >> 
> >> > 		ice_print_link_msg(vsi, true);
> >> > 		netif_tx_start_all_queues(vsi->netdev);
> >> > 		netif_carrier_on(vsi->netdev);
> >> >-- 
> >> >2.42.0
> >> >
> >> >


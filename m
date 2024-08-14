Return-Path: <netdev+bounces-118387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F363951717
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DC51F245DD
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2C1428EA;
	Wed, 14 Aug 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4U1aYx5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266001411E9
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625749; cv=none; b=A8Ro2SuS1mFmav0c9120pvvnbMC3YrxD8qvbb8/TRKYV40xSeCuIZHboT1P3i3T+OGGLW2k+sGTUhVe6oJkWEWsm9YEU56zSXPNU+FFkFzK/Go6gOWVSjgFY8xo6BuD2wfBRzenxbqPQWfjSyKQMi4/zyof5Mvul8vifmiGDwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625749; c=relaxed/simple;
	bh=C1dMs36+E3TXogs8HudNJbDCgjUYy7TbqetEx22zIpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMCPSPkegf1LwbtosC87DPMH3JW9zCpPrCpHBURYZIlsvl9gxkAECuAYIy1Jx+LVLo0vlAqPdlOeNFqREqV3ipky4AwSyG9WF1MbbeMPifvwXY7F8bHcMGMYi4rEodQJ75IP4CE146k8fjJwo8FuFPLGgxI9PMxx5tfqNfokUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4U1aYx5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723625748; x=1755161748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C1dMs36+E3TXogs8HudNJbDCgjUYy7TbqetEx22zIpA=;
  b=Z4U1aYx5CQB8wYbP/t3yuwkakFN10S6XvKx/WFaxi6W0/rC6tqBClp7j
   vHbRRGRDB+bSh/cr+ZhZa7GMhUKiuOO9aepDAPp4j7ZyLQRJu9gwAWozs
   KEm8HEgFJeAauxDxAw4uoSMDBgJ2Sos3/K9b6kiuOJqdXKgbz8AJB82Dk
   I88NhP6Ft63bFCEBmdKHwzyu0qjhFuevbvoWgDkoE36Pz5r26IQph3lZh
   waboi4q4zpe22QfInqItTgluHPtNWokjD5OBIR8D/PfPB/Ox8krern9cG
   /Y6cHGkOek+0zH64bDb/Rx1ayq03HaMF8nT27M9VZQLMWwwxnGIUMfTe7
   Q==;
X-CSE-ConnectionGUID: lLw8DFrwQjetog2l4XUb9g==
X-CSE-MsgGUID: wyEPVWtBS+SFDkXYSAIAIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25692861"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="25692861"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:55:47 -0700
X-CSE-ConnectionGUID: OaYC6PaaQ+mUfVTAK2Pcwg==
X-CSE-MsgGUID: 5fenbHiVRlCAEPtVD+XGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="59516877"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:55:43 -0700
Date: Wed, 14 Aug 2024 10:54:00 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v4 03/15] ice: add basic devlink subfunctions
 support
Message-ID: <ZrxwqMyIyfX1XcPn@mev-dev.igk.intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
 <20240813215005.3647350-4-anthony.l.nguyen@intel.com>
 <Zrxt64Ff5iG1W21p@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrxt64Ff5iG1W21p@nanopsycho.orion>

On Wed, Aug 14, 2024 at 10:42:19AM +0200, Jiri Pirko wrote:
> Tue, Aug 13, 2024 at 11:49:52PM CEST, anthony.l.nguyen@intel.com wrote:
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
> >Allocate and free subfunction MSIX interrupt vectors using new API
> >calls with pci_msix_alloc_irq_at and pci_msix_free_irq.
> >
> >Support both automatic and manual subfunction numbers. If no subfunction
> >number is provided, use xa_alloc to pick a number automatically. This
> >will find the first free index and use that as the number. This reduces
> >burden on users in the simple case where a specific number is not
> >required. It may also be slightly faster to check that a number exists
> >since xarray lookup should be faster than a linear scan of the dyn_ports
> >xarray.
> >
> >Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I don't think it is okay to carry the reviewed-by tag when you do
> changes to the patch. You should drop those.
> 
> 

I changed only warn messages, but ok, I will drop it.

> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> >Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> >Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> >Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> >---
> > .../net/ethernet/intel/ice/devlink/devlink.c  |   3 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 290 +++++++++++++++++-
> > .../ethernet/intel/ice/devlink/devlink_port.h |  34 ++
> > drivers/net/ethernet/intel/ice/ice.h          |   4 +
> > drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
> > drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
> > drivers/net/ethernet/intel/ice/ice_main.c     |   7 +
> > 7 files changed, 342 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >index 810a901d7afd..b7eb1b56f2c6 100644
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
> > static int
> >diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >index 00fed5a61d62..aae518399508 100644
> >--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
> >@@ -5,6 +5,9 @@
> > 
> > #include "ice.h"
> > #include "devlink.h"
> >+#include "devlink_port.h"
> >+#include "ice_lib.h"
> >+#include "ice_fltr.h"
> > 
> > static int ice_active_port_option = -1;
> > 
> >@@ -455,7 +458,7 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
> > 		return -EINVAL;
> > 
> > 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
> >-	attrs.pci_vf.pf = pf->hw.bus.func;
> >+	attrs.pci_vf.pf = pf->hw.pf_id;
> 
> You should do this in a separate patch, most probably -net targetted as
> it fixes a bug.
>

It is already on ML:
https://lore.kernel.org/netdev/20240813071610.52295-1-michal.swiatkowski@linux.intel.com/

> 
> 
> > 	attrs.pci_vf.vf = vf->vf_id;
> > 
> > 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
> 
> [...]


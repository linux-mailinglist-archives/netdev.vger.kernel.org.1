Return-Path: <netdev+bounces-43885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29607D51E5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0911F21F56
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06D29CE1;
	Tue, 24 Oct 2023 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxQdnjMb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEF134B1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:36:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABA1733
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698154559; x=1729690559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xQRn7rZeilK2OunzJ4Yh7VMYWV9hIWoDgOVfiQGK9/M=;
  b=kxQdnjMbx05OlCL8rZOvj2ceWPgDN6Q2iYz53j41mSJ/zfpCy3vRLCbN
   wAdHhW7I8Bbzmecb+as+HsAxMQTyxdT1ax/kjk4rYczFrKcrXsYXuurIb
   lIVnGPVm14QwDO8jliLYNP437w6MDJu6BcZH6QrCDkB8GjtGlbla5I8Ed
   Fkd0kkJUiJFMHBnZuyjX5u9PjB489+NRepcFqS36tegrsoAaHPNpYtMjk
   zyjVWl3XCtxNsq8VlxB3OWe4m5bBgAxCjHi7UXullsgFlhjyVIR4hZx9q
   WQ3DpEvzos6rlBH/zPzpXTP5xYrHZ0v33G4oKsKB1cVkQnSWiKXsCq/Ot
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="385949463"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="385949463"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824285712"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="824285712"
Received: from wasp.igk.intel.com (HELO wasp) ([10.102.20.192])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:35:57 -0700
Date: Tue, 24 Oct 2023 15:10:46 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	piotr.raczynski@intel.com, wojciech.drewek@intel.com,
	marcin.szycik@intel.com, jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com, jesse.brandeburg@intel.com
Subject: Re: [PATCH iwl-next v1 00/15] one by one port representors creation
Message-ID: <ZTfCVsYtbwSg9nZ/@wasp>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
 <ZTeveEZ1W/zejDuM@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTeveEZ1W/zejDuM@nanopsycho>

On Tue, Oct 24, 2023 at 01:50:16PM +0200, Jiri Pirko wrote:
> Tue, Oct 24, 2023 at 01:09:14PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >Hi,
> >
> >Currently ice supports creating port representors only for VFs. For that
> >use case they can be created and removed in one step.
> >
> >This patchset is refactoring current flow to support port representor
> >creation also for subfunctions and SIOV. In this case port representors
> >need to be createad and removed one by one. Also, they can be added and
> >removed while other port representors are running.
> >
> >To achieve that we need to change the switchdev configuration flow.
> >Three first patches are only cosmetic (renaming, removing not used code).
> >Next few ones are preparation for new flow. The most important one
> >is "add VF representor one by one". It fully implements new flow.
> >
> >New type of port representor (for subfunction) will be introduced in
> >follow up patchset.
> 
> Examples please. Show new outputs of devlink commands.
> 
> Thanks!
>

If you mean outputs after refactor to one by one solution nothing
has changed:

# devlink port show (after creating 4 VFs in switchdev mode)
pci/0000:18:00.0/0: type eth netdev ens785f0np0 flavour physical port 0 splittable true lanes 8
pci/0000:18:00.0/2: type eth netdev ens785f0np0_0 flavour pcivf controller 0 pfnum 0 vfnum 0 external false splittable false
pci/0000:18:00.0/4: type eth netdev ens785f0np0_3 flavour pcivf controller 0 pfnum 0 vfnum 3 external false splittable false
pci/0000:18:00.0/5: type eth netdev ens785f0np0_1 flavour pcivf controller 0 pfnum 0 vfnum 1 external false splittable false
pci/0000:18:00.0/6: type eth netdev ens785f0np0_2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false

According subfunction, it will also be in cover latter for patchset that
is implementing subfunction.

Commands:
# devlink dev eswitch set pci/0000:18:00.0 mode switchdev
# devlink port add pci/0000:18:00.0 flavour pcisf pfnum 0 sfnum 1000
# devlink port function set pci/0000:18:00.0/3 state active

Outputs:
Don't have it saved, will send it here after rebasing subfunction of top
of this one.

Thanks,
Michal

> >
> >Michal Swiatkowski (15):
> >  ice: rename switchdev to eswitch
> >  ice: remove redundant max_vsi_num variable
> >  ice: remove unused control VSI parameter
> >  ice: track q_id in representor
> >  ice: use repr instead of vf->repr
> >  ice: track port representors in xarray
> >  ice: remove VF pointer reference in eswitch code
> >  ice: make representor code generic
> >  ice: return pointer to representor
> >  ice: allow changing SWITCHDEV_CTRL VSI queues
> >  ice: set Tx topology every time new repr is added
> >  ice: realloc VSI stats arrays
> >  ice: add VF representors one by one
> >  ice: adjust switchdev rebuild path
> >  ice: reserve number of CP queues
> >
> > drivers/net/ethernet/intel/ice/ice.h          |  13 +-
> > drivers/net/ethernet/intel/ice/ice_devlink.c  |  29 +
> > drivers/net/ethernet/intel/ice/ice_devlink.h  |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  | 562 ++++++++++--------
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> > .../net/ethernet/intel/ice/ice_eswitch_br.c   |  22 +-
> > drivers/net/ethernet/intel/ice/ice_lib.c      |  81 ++-
> > drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++---
> > drivers/net/ethernet/intel/ice/ice_repr.h     |   9 +-
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
> > drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   9 +-
> > drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
> > 14 files changed, 553 insertions(+), 422 deletions(-)
> >
> >-- 
> >2.41.0
> >
> >


Return-Path: <netdev+bounces-115214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C9C945730
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4813284FA0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4D1BC4B;
	Fri,  2 Aug 2024 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAIqyPtu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BE8836
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574205; cv=none; b=pyrDk/jYimpoN86av1DmPYAy39ZGBa3dGgCAO/d860uR1TCcvWISqKx+j2qBe4ZeVI6sRX7FevjPaIrDYW4rMbhqYMltfLtqVpfw3fHnOQC/4QWDhiqPUZk/8PF0bPNtS1h74gSBRq9BVGnOq1AzyAaisRQe73reUfsXE3vjQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574205; c=relaxed/simple;
	bh=YwN1J+tgJfDo398OsvFkLF5oYUEn81mv9aSjwXHj+Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucVY2eIGJolUFKkvdOJyBX9oYtWag7edXOMQcwdS35jrsualTwXU5K1QjT5b1IVf61Ih9+MEFELDj6GkqD2ZE/izSxtW9CQSo7Rcm9vU8LoIaHkBZLqjL7VpLAES6z3yiVwQsPDw69HdFwV6LjsHpI/QvMop0a0tJFLvb1vjnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAIqyPtu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722574203; x=1754110203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwN1J+tgJfDo398OsvFkLF5oYUEn81mv9aSjwXHj+Bc=;
  b=ZAIqyPtu3bLvAyT7pC+kkPM5Jfr/eHxmhgXE98j2UVckXg85U7lJGnoo
   yvsqY0ukG90ifZFVDFerdlEYXgZp5pV0nh1ihQSAEz5DCUOW55FmWO9+F
   NsBx+XkXeja4k69yS/U8bXi64hEVLmIkui3JuzLymCtM2CXvUUUzsfxl5
   d8Q9flIvsiMrR4skAKSsOxY0TSIVA3lopoREUtv/VrvoXY8m4+jienPBl
   I76tRQGe5enD5N6qNMy5MMbqBG1MuIU06OdeHgZNI5dkaTT9JJn+5J6Ds
   Z1aMKVlpf2CpANk89S1HEFHuKij6LmswYhH8C+yGZLUjcZgZYxBMch9y6
   A==;
X-CSE-ConnectionGUID: uh+c0vaQS4e4D/p2hO10oA==
X-CSE-MsgGUID: SfkmH2fbTVOibR4zb7sscA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20458537"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="20458537"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 21:50:02 -0700
X-CSE-ConnectionGUID: 1vqVkfbQQda1k7q1W+GBHg==
X-CSE-MsgGUID: WoDRvdwMRWe/ll55lSjxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="59610184"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 21:49:58 -0700
Date: Fri, 2 Aug 2024 06:48:20 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, jiri@nvidia.com, shayd@nvidia.com,
	wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqxlFI1djZmssdmN@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqudI07D4XfNZlkO@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqudI07D4XfNZlkO@nanopsycho.orion>

On Thu, Aug 01, 2024 at 04:35:15PM +0200, Jiri Pirko wrote:
> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
> >Michal Swiatkowski says:
> >
> >Currently ice driver does not allow creating more than one networking
> >device per physical function. The only way to have more hardware backed
> >netdev is to use SR-IOV.
> >
> >Following patchset adds support for devlink port API. For each new
> >pcisf type port, driver allocates new VSI, configures all resources
> >needed, including dynamically MSIX vectors, program rules and registers
> >new netdev.
> >
> >This series supports only one Tx/Rx queue pair per subfunction.
> >
> >Example commands:
> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> >devlink port function set pci/0000:31:00.1/1 state active
> >devlink port function del pci/0000:31:00.1/1
> 
> Hmm, interesting. Did you run these commands or just made that up? There
> is no "devlink port function del", in case you wonder why I'm asking. I
> would expect you run all the commands you put into examples. Could you?

I run all commands, there is mistake in copying, should be:
devlink port del pci/0000:31:00.1/1
of course.

> 
> 
> >
> >Make the port representor and eswitch code generic to support
> >subfunction representor type.
> >
> >VSI configuration is slightly different between VF and SF. It needs to
> >be reflected in the code.
> >---
> >v2:
> >- Add more recipients
> >
> >v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
> >
> >The following are changes since commit 990c304930138dcd7a49763417e6e5313b81293e:
> >  Add support for PIO p flag
> >and are available in the git repository at:
> >  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> >
> >Michal Swiatkowski (8):
> >  ice: treat subfunction VSI the same as PF VSI
> >  ice: make representor code generic
> >  ice: create port representor for SF
> >  ice: don't set target VSI for subfunction
> >  ice: check if SF is ready in ethtool ops
> >  ice: implement netdevice ops for SF representor
> >  ice: support subfunction devlink Tx topology
> >  ice: basic support for VLAN in subfunctions
> >
> >Piotr Raczynski (7):
> >  ice: add new VSI type for subfunctions
> >  ice: export ice ndo_ops functions
> >  ice: add basic devlink subfunctions support
> >  ice: allocate devlink for subfunction
> >  ice: base subfunction aux driver
> >  ice: implement netdev for subfunction
> >  ice: allow to activate and deactivate subfunction
> >
> > drivers/net/ethernet/intel/ice/Makefile       |   2 +
> > .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
> > .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> > .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
> > .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
> > drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> > drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> > drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> > drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> > drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> > drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> > drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> > drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> > drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
> > drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> > drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> > drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> > .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> > drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> > 26 files changed, 1396 insertions(+), 137 deletions(-)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
> >
> >-- 
> >2.42.0
> >
> >


Return-Path: <netdev+bounces-115232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE79458E4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6231F23B07
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317F1BF305;
	Fri,  2 Aug 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nqa43LUL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A7482EF
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583911; cv=none; b=YzwmSj3yRAMMWE3CK3bMfWoB614uw+QL9uVaKYOyaEpRWaosIOfN8Y1HkIr9WUg4Pw1UYfllZF9kVANYttur4nHRgnYgwgrnej39M5fGeqyGZksZC+Vvu3pDCNDjFx0gMVYaaqdpKsdbvQx/kDEogHy4Q6zsG5UdUYNA0i0eELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583911; c=relaxed/simple;
	bh=9DFZsntO69vLTXgI4Wfi0cToeeZQEomTOnp3iVaRlvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjmkUGHHv5sxSRlsxSwp2gHbzoRB5d1+yLqytC/N8RLrRLli7qwOL2/m9bfLLuBtz/zKbb1ssm/vp03rD/s8kIk+tgj/+6WOYdz9lK8Qr8mSJ8l0bpq0OvbzIqpcrM3YFcs058V0Vk+QhtCPL1uXh02GNTor/PD2uPtnrSckuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nqa43LUL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722583909; x=1754119909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9DFZsntO69vLTXgI4Wfi0cToeeZQEomTOnp3iVaRlvI=;
  b=Nqa43LULe04uvPrRu0A+c/Q348qg921cO+e0fi1DTrKweoo7LHMPvrwW
   GLlk/OY5XBmys0BdDKUtLcLBkMNQnTvjHFCIRe0mJxiVSXLyjvX2dq+L1
   b7Qakbmx+QihnO+gZyBxMzrXxzVdPMH5EIKRlEcf0GTFnngUvV2vWrZmU
   qyY3irxWisN1IK+2vyJvDFFpfNpi8bCENKSOibBvJekkpvlSxPkbZ78N8
   vSg+Jk3DfyLmEqNU9jgrEndK7J31w/Dg+a+86qj/N8+wvBhwHZ73g3gDW
   bdEKlcpgryzH9GYpX9tCNxdEceelIX2TfLovEtWlB25vPZvsL3g83byDL
   g==;
X-CSE-ConnectionGUID: ttRNp9A9R3m1lxm04VAepA==
X-CSE-MsgGUID: Ml+jKHBYSLWJ9zahF7MbHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="45991344"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="45991344"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:31:49 -0700
X-CSE-ConnectionGUID: hd2/IfwMR4mztDJQQFAzKw==
X-CSE-MsgGUID: Y8+1o2KiSXi2lIy3TxukvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="54955477"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:31:45 -0700
Date: Fri, 2 Aug 2024 09:30:07 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZqyK/xHkGEFEX+8Q@mev-dev.igk.intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>

On Wed, Jul 31, 2024 at 03:10:11PM -0700, Tony Nguyen wrote:
> Michal Swiatkowski says:
> 
> Currently ice driver does not allow creating more than one networking
> device per physical function. The only way to have more hardware backed
> netdev is to use SR-IOV.
> 
> Following patchset adds support for devlink port API. For each new
> pcisf type port, driver allocates new VSI, configures all resources
> needed, including dynamically MSIX vectors, program rules and registers
> new netdev.
> 
> This series supports only one Tx/Rx queue pair per subfunction.
> 
> Example commands:
> devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> devlink port function set pci/0000:31:00.1/1 state active
> devlink port function del pci/0000:31:00.1/1
> 
> Make the port representor and eswitch code generic to support
> subfunction representor type.
> 
> VSI configuration is slightly different between VF and SF. It needs to
> be reflected in the code.
> ---
> v2:
> - Add more recipients
> 
> v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
> 
> The following are changes since commit 990c304930138dcd7a49763417e6e5313b81293e:
>   Add support for PIO p flag
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> Michal Swiatkowski (8):
>   ice: treat subfunction VSI the same as PF VSI
>   ice: make representor code generic
>   ice: create port representor for SF
>   ice: don't set target VSI for subfunction
>   ice: check if SF is ready in ethtool ops
>   ice: implement netdevice ops for SF representor
>   ice: support subfunction devlink Tx topology
>   ice: basic support for VLAN in subfunctions
> 
> Piotr Raczynski (7):
>   ice: add new VSI type for subfunctions
>   ice: export ice ndo_ops functions
>   ice: add basic devlink subfunctions support
>   ice: allocate devlink for subfunction
>   ice: base subfunction aux driver
>   ice: implement netdev for subfunction
>   ice: allow to activate and deactivate subfunction
> 
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +
>  .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
>  .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
>  .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
>  .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
>  drivers/net/ethernet/intel/ice/ice.h          |  19 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
>  drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
>  drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
>  drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
>  drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
>  .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
>  .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
>  26 files changed, 1396 insertions(+), 137 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
> 
> -- 
> 2.42.0
> 

[offlist]

Hi Tony,

Am I correct that now I should send v6 to iwl (+CC netdev) when you
remove the patchset from dev-queue? I am little confused with Jiri
comment about versioning PR. I though it is usuall thing.

I already have done the changes that Jiri asked for (and Maciej from
previous version).

Thanks,
Michal


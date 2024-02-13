Return-Path: <netdev+bounces-71276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F032852E4E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE52D1F25B51
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871124B23;
	Tue, 13 Feb 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXc2Ps+w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D62C68A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821295; cv=none; b=Vd7zQ7nEFr8l8iVqIMOWSOodNWMyQQBdo9fJ8WaJ7Zr5j24ol3NXQqPZ/h3OYGfByn/eq7+9LijdAZUVkXja0Ijque5nEvIJufW6w2TkLLOMLKVIpFaIlcaS6/iLvmDa87fPtEMcfmGVWI53LAcTyihl3piEUEMbgA/M80/mZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821295; c=relaxed/simple;
	bh=4GUHNDaRCENI+49HL5C3GvSf7Y5oYykz9STLkEm7TsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqk5XP4O8DNDWG7hUugWJ5LDl9Ofo/3WTYVeSr50O5+TouT4g77ijtFKjekAUCTOffYNCl/S2wO5i4+HSARUtgm2DHpSJ8PHMUYcPWnYEE9Gd2Bx29hyhZ5OGRl8A49oekf/VUA9x5mFpI3mdIjmUUawhz6YnHjZ2UhKbTidsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXc2Ps+w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707821294; x=1739357294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GUHNDaRCENI+49HL5C3GvSf7Y5oYykz9STLkEm7TsU=;
  b=dXc2Ps+wUfMakYm+pfIGOoWs8J5ovV/x1h7qI3aaAethZUiGxJkFl5br
   eZ9OCS1+OXJXnAADVuug3AdGIjobibgD5RgwWK8AjbFD58ihoqcS7WwXI
   xWJXci7K2u56ixKhvd6CfuEjlNFjOD9Ui+RwnRtKWO6UkEjNpjMMmE9lE
   Y5rzUjSjUuDTvk5+rEVB2z1D73X+auoA2E8scwhB6idmJU+8/SpZfmUY5
   UIRZq/Muqf2IaoEFa9v5K1ZmA/eYY83+Eopc154lCqbckmRstiU9rAHHm
   qgVA2QzBBZZwsw6gllyhyQrl8h8ZeQCBvpB8mF1wflXwwkA82alj5DPtc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1965507"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1965507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2805482"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:48:10 -0800
Date: Tue, 13 Feb 2024 11:48:06 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [iwl-next v1 6/7] ice: enable_rdma devlink param
Message-ID: <ZctI5v99LmGx285J@mev-dev>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>
 <ZcsxRRrVvnhjLxn3@nanopsycho>
 <Zcs9XeZmd2E1IHKs@mev-dev>
 <bb501538-29d5-4930-97b6-1c02f1b7ecba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb501538-29d5-4930-97b6-1c02f1b7ecba@intel.com>

On Tue, Feb 13, 2024 at 11:19:49AM +0100, Wojciech Drewek wrote:
> 
> 
> On 13.02.2024 10:58, Michal Swiatkowski wrote:
> > On Tue, Feb 13, 2024 at 10:07:17AM +0100, Jiri Pirko wrote:
> >> Tue, Feb 13, 2024 at 08:35:08AM CET, michal.swiatkowski@linux.intel.com wrote:
> >>> Implement enable_rdma devlink parameter to allow user to turn RDMA
> >>> feature on and off.
> >>>
> >>> It is useful when there is no enough interrupts and user doesn't need
> >>> RDMA feature.
> >>>
> >>> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> >>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>> ---
> >>> drivers/net/ethernet/intel/ice/ice_devlink.c | 32 ++++++++++++++++++--
> >>> drivers/net/ethernet/intel/ice/ice_lib.c     |  8 ++++-
> >>> drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++------
> >>> 3 files changed, 45 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >>> index b82ff9556a4b..4f048268db72 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> >>> @@ -1675,6 +1675,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> >>> 	return 0;
> >>> }
> >>>
> >>> +static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
> >>> +					    union devlink_param_value val,
> >>> +					    struct netlink_ext_ack *extack)
> >>> +{
> >>> +	struct ice_pf *pf = devlink_priv(devlink);
> >>> +	bool new_state = val.vbool;
> >>> +
> >>> +	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
> >>> +		return -EOPNOTSUPP;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> static const struct devlink_param ice_devlink_params[] = {
> >>> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> >>> 			      ice_devlink_enable_roce_get,
> >>> @@ -1700,6 +1713,8 @@ static const struct devlink_param ice_devlink_params[] = {
> >>> 			      ice_devlink_msix_min_pf_get,
> >>> 			      ice_devlink_msix_min_pf_set,
> >>> 			      ice_devlink_msix_min_pf_validate),
> >>> +	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
> >>> +			      NULL, NULL, ice_devlink_enable_rdma_validate),
> >>> };
> >>>
> >>> static void ice_devlink_free(void *devlink_ptr)
> >>> @@ -1776,9 +1791,22 @@ ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
> >>> int ice_devlink_register_params(struct ice_pf *pf)
> >>> {
> >>> 	struct devlink *devlink = priv_to_devlink(pf);
> >>> +	union devlink_param_value value;
> >>> +	int err;
> >>> +
> >>> +	err = devlink_params_register(devlink, ice_devlink_params,
> >>
> >> Interesting, can't you just take the lock before this and call
> >> devl_params_register()?
> >>
> > I mess up a locking here and also in subfunction patchset. I will follow
> > you suggestion and take lock for whole init/cleanup. Thanks.
> > 
> >> Moreover, could you please fix your init/cleanup paths for hold devlink
> >> instance lock the whole time?
> >>
> > You right, I will prepare patch for it.
> 
> I think my patch implements your suggestion Jiri:
> https://lore.kernel.org/netdev/20240212211202.1051990-5-anthony.l.nguyen@intel.com/
> 

Right, I based my patchset before your changes was applied to Tony's
tree. Thanks Wojtek.

So, in v2 there will be dev_version.

Thanks
Michal
> > 
> >>
> >> pw-bot: cr
> >>
> >>
> >>> +				      ARRAY_SIZE(ice_devlink_params));
> >>> +	if (err)
> >>> +		return err;
> >>>
> >>> -	return devlink_params_register(devlink, ice_devlink_params,
> >>> -				       ARRAY_SIZE(ice_devlink_params));
> >>> +	devl_lock(devlink);
> >>> +	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >>> +	devl_param_driverinit_value_set(devlink,
> >>> +					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
> >>> +					value);
> >>> +	devl_unlock(devlink);
> >>> +
> >>> +	return 0;
> >>> }
> >>>
> >>> void ice_devlink_unregister_params(struct ice_pf *pf)
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> index a30d2d2b51c1..4d5c3d699044 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> >>> @@ -829,7 +829,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
> >>>  */
> >>> bool ice_is_rdma_ena(struct ice_pf *pf)
> >>> {
> >>> -	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> >>> +	union devlink_param_value value;
> >>> +	int err;
> >>> +
> >>> +	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
> >>> +					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
> >>> +					      &value);
> >>> +	return err ? false : value.vbool;
> >>> }
> >>>
> >>> /**
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> >>> index 824732f16112..4dd59d888ec7 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> >>> @@ -5177,23 +5177,21 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> >>> 	if (err)
> >>> 		goto err_init;
> >>>
> >>> +	err = ice_init_devlink(pf);
> >>> +	if (err)
> >>> +		goto err_init_devlink;
> >>> +
> >>> 	devl_lock(priv_to_devlink(pf));
> >>> 	err = ice_load(pf);
> >>> 	devl_unlock(priv_to_devlink(pf));
> >>> 	if (err)
> >>> 		goto err_load;
> >>>
> >>> -	err = ice_init_devlink(pf);
> >>> -	if (err)
> >>> -		goto err_init_devlink;
> >>> -
> >>> 	return 0;
> >>>
> >>> -err_init_devlink:
> >>> -	devl_lock(priv_to_devlink(pf));
> >>> -	ice_unload(pf);
> >>> -	devl_unlock(priv_to_devlink(pf));
> >>> err_load:
> >>> +	ice_deinit_devlink(pf);
> >>> +err_init_devlink:
> >>> 	ice_deinit(pf);
> >>> err_init:
> >>> 	pci_disable_device(pdev);
> >>> @@ -5290,12 +5288,12 @@ static void ice_remove(struct pci_dev *pdev)
> >>> 	if (!ice_is_safe_mode(pf))
> >>> 		ice_remove_arfs(pf);
> >>>
> >>> -	ice_deinit_devlink(pf);
> >>> -
> >>> 	devl_lock(priv_to_devlink(pf));
> >>> 	ice_unload(pf);
> >>> 	devl_unlock(priv_to_devlink(pf));
> >>>
> >>> +	ice_deinit_devlink(pf);
> >>> +
> >>> 	ice_deinit(pf);
> >>> 	ice_vsi_release_all(pf);
> >>>
> >>> -- 
> >>> 2.42.0
> >>>
> >>>


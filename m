Return-Path: <netdev+bounces-65871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A90A83C1A1
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80279B20B7C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884B1CA83;
	Thu, 25 Jan 2024 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SzlNVZnY"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8445022
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184384; cv=none; b=Y556cb3+xU+YyIURJ6UsfbqF1IknfCszbaMvVqG2ldw4le3X55U6nZLlhI/9fDoR9y2avd2PZ4L3tMHRr/oJfoh0lueWSccLzpC6dfGPcwdyOYERyTN1MG6IzUXOWZgWjv3W6lsVgkDB1cGVaLkydwxbuiOdpz7DTIzEJ0dHJc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184384; c=relaxed/simple;
	bh=w4QtGd0r0A+3sM+coc5rzirxAUNQqhhE+ipj/dv181A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxpIq65NH5/9sx6URlGo9f91iNRF+zDmIKznBqW+3H8yuO1K0/UyOiPX2zLByvA+FlYaZegSc2jOiaaJxAg+eEKh3CArIaIT5DK0PX1oMGFEV5MA8RQ7ZvZovsbstd0Rj0mzSwaLGE+g9GlVz1eWS8ul8EDQkTP+VeVe9kjzZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SzlNVZnY; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b5d00097-3a56-4644-8ed4-31e8d23cd77a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706184372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvaJHEuAhIOBwIMPk1YedyZ8h4+e1EBtLgHldS4xyLM=;
	b=SzlNVZnYftsKH9bb02ZTeUaDV7117uf/y8Osap/2YovKnIIK9IEb+n9J6pRfubDPLs6x2t
	t0o/c7EuQ9WI3pezAaFEU3cPQULLMsFhTUg7yABHtCmkmWx1AtW67Q/ahs/wEQXUqE5we9
	9a95om8RSsm0I8AQ4Eftk1hCXRYWjFQ=
Date: Thu, 25 Jan 2024 12:06:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next v2] ice: Remove and readd netdev during devlink
 reload
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, przemyslaw.kitszel@intel.com,
 paul.m.stillwell.jr@intel.com
References: <20240125085459.13096-1-wojciech.drewek@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240125085459.13096-1-wojciech.drewek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/01/2024 08:54, Wojciech Drewek wrote:
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
> 
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
> 
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: empty init removed in ice_devlink_reinit_up

Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   drivers/net/ethernet/intel/ice/ice.h         |   3 +
>   drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
>   drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
>   drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
>   drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
>   5 files changed, 139 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index e841f6c4f1c4..39734e5b9d56 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -897,6 +897,7 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
>   }
>   
>   void ice_debugfs_fwlog_init(struct ice_pf *pf);
> +void ice_debugfs_fwlog_deinit(struct ice_pf *pf);
>   void ice_debugfs_init(void);
>   void ice_debugfs_exit(void);
>   void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
> @@ -984,6 +985,8 @@ void ice_service_task_schedule(struct ice_pf *pf);
>   int ice_load(struct ice_pf *pf);
>   void ice_unload(struct ice_pf *pf);
>   void ice_adv_lnk_speed_maps_init(void);
> +int ice_init_dev(struct ice_pf *pf);
> +void ice_deinit_dev(struct ice_pf *pf);
>   
>   /**
>    * ice_set_rdma_cap - enable RDMA support
> diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> index c2bfba6b9ead..8fdcdfb804b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> @@ -647,6 +647,16 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
>   	kfree(fw_modules);
>   }
>   
> +/**
> + * ice_debugfs_fwlog_deinit - cleanup PF's debugfs
> + * @pf: pointer to the PF struct
> + */
> +void ice_debugfs_fwlog_deinit(struct ice_pf *pf)
> +{
> +	debugfs_remove_recursive(pf->ice_debugfs_pf);
> +	pf->ice_debugfs_pf = NULL;
> +}
> +
>   /**
>    * ice_debugfs_init - create root directory for debugfs entries
>    */
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 97182bacafa3..a428e24439d0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -444,6 +444,20 @@ ice_devlink_reload_empr_start(struct ice_pf *pf,
>   	return 0;
>   }
>   
> +/**
> + * ice_devlink_reinit_down - unload given PF
> + * @pf: pointer to the PF struct
> + */
> +static void ice_devlink_reinit_down(struct ice_pf *pf)
> +{
> +	/* No need to take devl_lock, it's already taken by devlink API */
> +	ice_unload(pf);
> +	rtnl_lock();
> +	ice_vsi_decfg(ice_get_main_vsi(pf));
> +	rtnl_unlock();
> +	ice_deinit_dev(pf);
> +}
> +
>   /**
>    * ice_devlink_reload_down - prepare for reload
>    * @devlink: pointer to the devlink instance to reload
> @@ -477,7 +491,7 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
>   					   "Remove all VFs before doing reinit\n");
>   			return -EOPNOTSUPP;
>   		}
> -		ice_unload(pf);
> +		ice_devlink_reinit_down(pf);
>   		return 0;
>   	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>   		return ice_devlink_reload_empr_start(pf, extack);
> @@ -1269,6 +1283,45 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
>   	return status;
>   }
>   
> +/**
> + * ice_devlink_reinit_up - do reinit of the given PF
> + * @pf: pointer to the PF struct
> + */
> +static int ice_devlink_reinit_up(struct ice_pf *pf)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +	struct ice_vsi_cfg_params params;
> +	int err;
> +
> +	err = ice_init_dev(pf);
> +	if (err)
> +		return err;
> +
> +	params = ice_vsi_to_params(vsi);
> +	params.flags = ICE_VSI_FLAG_INIT;
> +
> +	rtnl_lock();
> +	err = ice_vsi_cfg(vsi, &params);
> +	if (err)
> +		goto err_vsi_cfg;
> +	rtnl_unlock();
> +
> +	/* No need to take devl_lock, it's already taken by devlink API */
> +	err = ice_load(pf);
> +	if (err)
> +		goto err_load;
> +
> +	return 0;
> +
> +err_load:
> +	rtnl_lock();
> +	ice_vsi_decfg(vsi);
> +err_vsi_cfg:
> +	rtnl_unlock();
> +	ice_deinit_dev(pf);
> +	return err;
> +}
> +
>   /**
>    * ice_devlink_reload_up - do reload up after reinit
>    * @devlink: pointer to the devlink instance reloading
> @@ -1289,7 +1342,7 @@ ice_devlink_reload_up(struct devlink *devlink,
>   	switch (action) {
>   	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
>   		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
> -		return ice_load(pf);
> +		return ice_devlink_reinit_up(pf);
>   	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>   		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
>   		return ice_devlink_reload_empr_finish(pf, extack);
> @@ -1695,6 +1748,7 @@ static const struct devlink_port_ops ice_devlink_port_ops = {
>    * @pf: the PF to create a devlink port for
>    *
>    * Create and register a devlink_port for this PF.
> + * This function has to be called under devl_lock.
>    *
>    * Return: zero on success or an error code on failure.
>    */
> @@ -1707,6 +1761,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
>   	struct device *dev;
>   	int err;
>   
> +	devlink = priv_to_devlink(pf);
> +
>   	dev = ice_pf_to_dev(pf);
>   
>   	devlink_port = &pf->devlink_port;
> @@ -1727,10 +1783,9 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
>   	ice_devlink_set_switch_id(pf, &attrs.switch_id);
>   
>   	devlink_port_attrs_set(devlink_port, &attrs);
> -	devlink = priv_to_devlink(pf);
>   
> -	err = devlink_port_register_with_ops(devlink, devlink_port, vsi->idx,
> -					     &ice_devlink_port_ops);
> +	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
> +					  &ice_devlink_port_ops);
>   	if (err) {
>   		dev_err(dev, "Failed to create devlink port for PF %d, error %d\n",
>   			pf->hw.pf_id, err);
> @@ -1745,10 +1800,11 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
>    * @pf: the PF to cleanup
>    *
>    * Unregisters the devlink_port structure associated with this PF.
> + * This function has to be called under devl_lock.
>    */
>   void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>   {
> -	devlink_port_unregister(&pf->devlink_port);
> +	devl_port_unregister(&pf->devlink_port);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
> index 92b5dac481cd..b2acfa05f118 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
> @@ -188,6 +188,8 @@ void ice_fwlog_deinit(struct ice_hw *hw)
>   	if (hw->bus.func)
>   		return;
>   
> +	ice_debugfs_fwlog_deinit(hw->back);
> +
>   	/* make sure FW logging is disabled to not put the FW in a weird state
>   	 * for the next driver load
>   	 */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 77ba737a50df..5f9b616b90dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4574,90 +4574,6 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
>   	vsi->netdev = NULL;
>   }
>   
> -static int ice_start_eth(struct ice_vsi *vsi)
> -{
> -	int err;
> -
> -	err = ice_init_mac_fltr(vsi->back);
> -	if (err)
> -		return err;
> -
> -	err = ice_vsi_open(vsi);
> -	if (err)
> -		ice_fltr_remove_all(vsi);
> -
> -	return err;
> -}
> -
> -static void ice_stop_eth(struct ice_vsi *vsi)
> -{
> -	ice_fltr_remove_all(vsi);
> -	ice_vsi_close(vsi);
> -}
> -
> -static int ice_init_eth(struct ice_pf *pf)
> -{
> -	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> -	int err;
> -
> -	if (!vsi)
> -		return -EINVAL;
> -
> -	/* init channel list */
> -	INIT_LIST_HEAD(&vsi->ch_list);
> -
> -	err = ice_cfg_netdev(vsi);
> -	if (err)
> -		return err;
> -	/* Setup DCB netlink interface */
> -	ice_dcbnl_setup(vsi);
> -
> -	err = ice_init_mac_fltr(pf);
> -	if (err)
> -		goto err_init_mac_fltr;
> -
> -	err = ice_devlink_create_pf_port(pf);
> -	if (err)
> -		goto err_devlink_create_pf_port;
> -
> -	SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
> -
> -	err = ice_register_netdev(vsi);
> -	if (err)
> -		goto err_register_netdev;
> -
> -	err = ice_tc_indir_block_register(vsi);
> -	if (err)
> -		goto err_tc_indir_block_register;
> -
> -	ice_napi_add(vsi);
> -
> -	return 0;
> -
> -err_tc_indir_block_register:
> -	ice_unregister_netdev(vsi);
> -err_register_netdev:
> -	ice_devlink_destroy_pf_port(pf);
> -err_devlink_create_pf_port:
> -err_init_mac_fltr:
> -	ice_decfg_netdev(vsi);
> -	return err;
> -}
> -
> -static void ice_deinit_eth(struct ice_pf *pf)
> -{
> -	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> -
> -	if (!vsi)
> -		return;
> -
> -	ice_vsi_close(vsi);
> -	ice_unregister_netdev(vsi);
> -	ice_devlink_destroy_pf_port(pf);
> -	ice_tc_indir_block_unregister(vsi);
> -	ice_decfg_netdev(vsi);
> -}
> -
>   /**
>    * ice_wait_for_fw - wait for full FW readiness
>    * @hw: pointer to the hardware structure
> @@ -4683,7 +4599,7 @@ static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
>   	return -ETIMEDOUT;
>   }
>   
> -static int ice_init_dev(struct ice_pf *pf)
> +int ice_init_dev(struct ice_pf *pf)
>   {
>   	struct device *dev = ice_pf_to_dev(pf);
>   	struct ice_hw *hw = &pf->hw;
> @@ -4776,7 +4692,7 @@ static int ice_init_dev(struct ice_pf *pf)
>   	return err;
>   }
>   
> -static void ice_deinit_dev(struct ice_pf *pf)
> +void ice_deinit_dev(struct ice_pf *pf)
>   {
>   	ice_free_irq_msix_misc(pf);
>   	ice_deinit_pf(pf);
> @@ -5081,31 +4997,47 @@ static void ice_deinit(struct ice_pf *pf)
>   /**
>    * ice_load - load pf by init hw and starting VSI
>    * @pf: pointer to the pf instance
> + *
> + * This function has to be called under devl_lock.
>    */
>   int ice_load(struct ice_pf *pf)
>   {
> -	struct ice_vsi_cfg_params params = {};
>   	struct ice_vsi *vsi;
>   	int err;
>   
> -	err = ice_init_dev(pf);
> +	devl_assert_locked(priv_to_devlink(pf));
> +
> +	vsi = ice_get_main_vsi(pf);
> +
> +	/* init channel list */
> +	INIT_LIST_HEAD(&vsi->ch_list);
> +
> +	err = ice_cfg_netdev(vsi);
>   	if (err)
>   		return err;
>   
> -	vsi = ice_get_main_vsi(pf);
> +	/* Setup DCB netlink interface */
> +	ice_dcbnl_setup(vsi);
>   
> -	params = ice_vsi_to_params(vsi);
> -	params.flags = ICE_VSI_FLAG_INIT;
> +	err = ice_init_mac_fltr(pf);
> +	if (err)
> +		goto err_init_mac_fltr;
>   
> -	rtnl_lock();
> -	err = ice_vsi_cfg(vsi, &params);
> +	err = ice_devlink_create_pf_port(pf);
>   	if (err)
> -		goto err_vsi_cfg;
> +		goto err_devlink_create_pf_port;
> +
> +	SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
>   
> -	err = ice_start_eth(ice_get_main_vsi(pf));
> +	err = ice_register_netdev(vsi);
> +	if (err)
> +		goto err_register_netdev;
> +
> +	err = ice_tc_indir_block_register(vsi);
>   	if (err)
> -		goto err_start_eth;
> -	rtnl_unlock();
> +		goto err_tc_indir_block_register;
> +
> +	ice_napi_add(vsi);
>   
>   	err = ice_init_rdma(pf);
>   	if (err)
> @@ -5119,29 +5051,35 @@ int ice_load(struct ice_pf *pf)
>   	return 0;
>   
>   err_init_rdma:
> -	ice_vsi_close(ice_get_main_vsi(pf));
> -	rtnl_lock();
> -err_start_eth:
> -	ice_vsi_decfg(ice_get_main_vsi(pf));
> -err_vsi_cfg:
> -	rtnl_unlock();
> -	ice_deinit_dev(pf);
> +	ice_tc_indir_block_unregister(vsi);
> +err_tc_indir_block_register:
> +	ice_unregister_netdev(vsi);
> +err_register_netdev:
> +	ice_devlink_destroy_pf_port(pf);
> +err_devlink_create_pf_port:
> +err_init_mac_fltr:
> +	ice_decfg_netdev(vsi);
>   	return err;
>   }
>   
>   /**
>    * ice_unload - unload pf by stopping VSI and deinit hw
>    * @pf: pointer to the pf instance
> + *
> + * This function has to be called under devl_lock.
>    */
>   void ice_unload(struct ice_pf *pf)
>   {
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);
> +
> +	devl_assert_locked(priv_to_devlink(pf));
> +
>   	ice_deinit_features(pf);
>   	ice_deinit_rdma(pf);
> -	rtnl_lock();
> -	ice_stop_eth(ice_get_main_vsi(pf));
> -	ice_vsi_decfg(ice_get_main_vsi(pf));
> -	rtnl_unlock();
> -	ice_deinit_dev(pf);
> +	ice_tc_indir_block_unregister(vsi);
> +	ice_unregister_netdev(vsi);
> +	ice_devlink_destroy_pf_port(pf);
> +	ice_decfg_netdev(vsi);
>   }
>   
>   /**
> @@ -5239,27 +5177,23 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>   	if (err)
>   		goto err_init;
>   
> -	err = ice_init_eth(pf);
> +	devl_lock(priv_to_devlink(pf));
> +	err = ice_load(pf);
>   	if (err)
> -		goto err_init_eth;
> -
> -	err = ice_init_rdma(pf);
> -	if (err)
> -		goto err_init_rdma;
> +		goto err_load;
> +	devl_unlock(priv_to_devlink(pf));
>   
>   	err = ice_init_devlink(pf);
>   	if (err)
>   		goto err_init_devlink;
>   
> -	ice_init_features(pf);
> -
>   	return 0;
>   
>   err_init_devlink:
> -	ice_deinit_rdma(pf);
> -err_init_rdma:
> -	ice_deinit_eth(pf);
> -err_init_eth:
> +	devl_lock(priv_to_devlink(pf));
> +	ice_unload(pf);
> +err_load:
> +	devl_unlock(priv_to_devlink(pf));
>   	ice_deinit(pf);
>   err_init:
>   	pci_disable_device(pdev);
> @@ -5342,8 +5276,6 @@ static void ice_remove(struct pci_dev *pdev)
>   		msleep(100);
>   	}
>   
> -	ice_debugfs_exit();
> -
>   	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
>   		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
>   		ice_free_vfs(pf);
> @@ -5357,12 +5289,14 @@ static void ice_remove(struct pci_dev *pdev)
>   
>   	if (!ice_is_safe_mode(pf))
>   		ice_remove_arfs(pf);
> -	ice_deinit_features(pf);
> +
>   	ice_deinit_devlink(pf);
> -	ice_deinit_rdma(pf);
> -	ice_deinit_eth(pf);
> -	ice_deinit(pf);
>   
> +	devl_lock(priv_to_devlink(pf));
> +	ice_unload(pf);
> +	devl_unlock(priv_to_devlink(pf));
> +
> +	ice_deinit(pf);
>   	ice_vsi_release_all(pf);
>   
>   	ice_setup_mc_magic_wake(pf);
> @@ -5847,6 +5781,7 @@ module_init(ice_module_init);
>   static void __exit ice_module_exit(void)
>   {
>   	pci_unregister_driver(&ice_driver);
> +	ice_debugfs_exit();
>   	destroy_workqueue(ice_wq);
>   	destroy_workqueue(ice_lag_wq);
>   	pr_info("module unloaded\n");



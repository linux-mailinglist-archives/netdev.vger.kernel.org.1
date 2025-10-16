Return-Path: <netdev+bounces-230139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4CBE45DC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CBE1A64500
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678A34DCD2;
	Thu, 16 Oct 2025 15:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE61FC110
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630048; cv=none; b=Ewlu8HetEZN+wkxu8TvdmyM4WOBFWGrcssFcVB9YKERkNtBTGIExyYvjww06NQkBS3SAh9ZEqLGjOp2e9ipRjj+KB9Vlr2qh7Cwe9vzkSFDVXoyPTy9s9rYuX4GIEMJi3oHl6CPqpsKFgsZrzGDuswVggceMtUMCV+mHzANeD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630048; c=relaxed/simple;
	bh=8KwkF23fR9dolqVszLQ8s43SpYzIeQUasFjQJE9ELdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJxkYk3TnzuU67+THJYpvPiY29iFHD6pujRdM3/U5ftdC7hCtZLjJuGK5SyZUW0MT0T5mB+eeeuNuldhU6Y5kujuGlrabRnmfHifbT6wjfmwLvhHvXIXzhXbx0XVi7wIxxE4wxFNxy4QyAmNSBDeofTXTJeSc+qg3oH/0Gvk/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 94D706020FEFF;
	Thu, 16 Oct 2025 17:53:45 +0200 (CEST)
Message-ID: <834ff332-b41e-4418-a496-7ea51a2bcecf@molgen.mpg.de>
Date: Thu, 16 Oct 2025 17:53:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: unify PHY FW loading
 status handler for E800 devices
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251014084618.2746755-1-grzegorz.nitka@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251014084618.2746755-1-grzegorz.nitka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Grzegorz,


Thank you for your patch.

Am 14.10.25 um 10:46 schrieb Grzegorz Nitka:
> Unify handling of PHY firmware load delays across all E800 family
> devices. There is an existing mechanism to poll GL_MNG_FWSM_FW_LOADING_M
> bit of GL_MNG_FWSM register in order to verify whether PHY FW loading
> completed or not. Previously, this logic was limited to E827 variants
> only.
> 
> Also, inform a user of possible delay in initialization process, by
> dumping informational message in dmesg log.

Paste the message here?

> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 81 ++++++---------------
>   1 file changed, 24 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 8e56354332ad..d05d371a9944 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -203,42 +203,6 @@ bool ice_is_generic_mac(struct ice_hw *hw)
>   		hw->mac_type == ICE_MAC_GENERIC_3K_E825);
>   }
>   
> -/**
> - * ice_is_pf_c827 - check if pf contains c827 phy
> - * @hw: pointer to the hw struct
> - *
> - * Return: true if the device has c827 phy.
> - */
> -static bool ice_is_pf_c827(struct ice_hw *hw)
> -{
> -	struct ice_aqc_get_link_topo cmd = {};
> -	u8 node_part_number;
> -	u16 node_handle;
> -	int status;
> -
> -	if (hw->mac_type != ICE_MAC_E810)
> -		return false;
> -
> -	if (hw->device_id != ICE_DEV_ID_E810C_QSFP)
> -		return true;
> -
> -	cmd.addr.topo_params.node_type_ctx =
> -		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY) |
> -		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ICE_AQC_LINK_TOPO_NODE_CTX_PORT);
> -	cmd.addr.topo_params.index = 0;
> -
> -	status = ice_aq_get_netlist_node(hw, &cmd, &node_part_number,
> -					 &node_handle);
> -
> -	if (status || node_part_number != ICE_AQC_GET_LINK_TOPO_NODE_NR_C827)
> -		return false;
> -
> -	if (node_handle == E810C_QSFP_C827_0_HANDLE || node_handle == E810C_QSFP_C827_1_HANDLE)
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * ice_clear_pf_cfg - Clear PF configuration
>    * @hw: pointer to the hardware structure
> @@ -958,30 +922,35 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
>   }
>   
>   /**
> - * ice_wait_for_fw - wait for full FW readiness
> + * ice_wait_fw_load - wait for PHY firmware loading to complete
>    * @hw: pointer to the hardware structure
>    * @timeout: milliseconds that can elapse before timing out
>    *
> - * Return: 0 on success, -ETIMEDOUT on timeout.
> + * On some cards, FW can load longer than usual,
> + * and could still not be ready before link is turned on.
> + * In these cases, we should wait until all's loaded.
> + *
> + * Return:
> + * * 0 on success (FW load is completed)
> + * * negative - on timeout
>    */
> -static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
> +static int ice_wait_fw_load(struct ice_hw *hw, u32 timeout)
>   {
> -	int fw_loading;
> -	u32 elapsed = 0;
> +	int fw_loading_reg;
>   
> -	while (elapsed <= timeout) {
> -		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
> +	if (!timeout)
> +		return 0;
>   
> -		/* firmware was not yet loaded, we have to wait more */
> -		if (fw_loading) {
> -			elapsed += 100;
> -			msleep(100);
> -			continue;
> -		}
> +	fw_loading_reg = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
> +	/* notify the user only once if PHY FW is still loading */
> +	if (fw_loading_reg)
> +		dev_info(ice_hw_to_dev(hw), "Link initialization is blocked by PHY FW initialization. Link initialization will continue after PHY FW initialization completes.\n");
> +	else
>   		return 0;
> -	}
>   
> -	return -ETIMEDOUT;
> +	return rd32_poll_timeout(hw, GL_MNG_FWSM, fw_loading_reg,
> +				 !(fw_loading_reg & GL_MNG_FWSM_FW_LOADING_M),
> +				 10000, timeout * 1000);
>   }
>   
>   static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
> @@ -1171,12 +1140,10 @@ int ice_init_hw(struct ice_hw *hw)
>   	 * due to necessity of loading FW from an external source.
>   	 * This can take even half a minute.
>   	 */
> -	if (ice_is_pf_c827(hw)) {
> -		status = ice_wait_for_fw(hw, 30000);
> -		if (status) {
> -			dev_err(ice_hw_to_dev(hw), "ice_wait_for_fw timed out");
> -			goto err_unroll_fltr_mgmt_struct;
> -		}
> +	status = ice_wait_fw_load(hw, 30000);
> +	if (status) {
> +		dev_err(ice_hw_to_dev(hw), "ice_wait_fw_load timed out");
> +		goto err_unroll_fltr_mgmt_struct;
>   	}
>   
>   	hw->lane_num = ice_get_phy_lane_number(hw);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


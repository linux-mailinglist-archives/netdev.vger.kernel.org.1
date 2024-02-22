Return-Path: <netdev+bounces-73973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91685F840
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C08B26B43
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D380C0D;
	Thu, 22 Feb 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UHQHnkrI"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005280036
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605123; cv=none; b=HTqTTR3o0PaGMkvcpSZv6SvrU6ZMm+S2v23MVFz3hSbiYZodKdh4MzxndUaLs8P/BgyM8uExMVh+r9NWsKjheYKIql/hOFE8Mt8J2dxMwTVcaHcw0euWoTK/4mMnKeOgSbw9J9SQbRzrAMXvGw21luNRwgvFNSqtKvxYNDafHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605123; c=relaxed/simple;
	bh=PT/2Y2M776y/1q/IeBXcPGL/9t6IUYDpM3RZjH88NT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIwGRC7yjxDWSUGVYn+5ekvUKv/+1LYMWidoFylrhTjevg73xf8I+vSHkFv/v/fu3SDCwqkjBK7+wdDku/Ki3kDbsc+gRJ1802q3TPwm56TwLBhYpzxckOBM6EUkkAJ55/3YAiayhGeK/vYdZa6O5Cep3cNukDaHu0ebyZfIK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UHQHnkrI; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d4d91a0-5539-4cc0-850a-3ccd44fcc648@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708605119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLZsyDUt5hzSIBANqSbswDLcR/pxibtvZYotnbdDd4o=;
	b=UHQHnkrId3OWdbpx7gDPqZtJQpdhdwmrfZXOPmY8LFCiso+MXGEjv5O8/qr4hCi6+ACEjF
	v4iq6yfVzFDA2SklPro8Wx8bg1zg8tmLeZ1ggYsKfdibSO4DdVVzr/gsVVy3z/oZqFWfoQ
	fbm5Z4rtqMgH+LwscvuHBRWZcr3H/0M=
Date: Thu, 22 Feb 2024 12:31:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/6] ice: fix connection state of DPLL and out pin
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Yochai Hagvi <yochai.hagvi@intel.com>, jiri@resnulli.us,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Sunitha Mekala <sunithax.d.mekala@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
 <20240220214444.1039759-2-anthony.l.nguyen@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240220214444.1039759-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/02/2024 21:44, Tony Nguyen wrote:
> From: Yochai Hagvi <yochai.hagvi@intel.com>
> 
> Fix the connection state between source DPLL and output pin, updating the
> attribute 'state' of 'parent_device'. Previously, the connection state
> was broken, and didn't reflect the correct state.
> 
> When 'state_on_dpll_set' is called with the value
> 'DPLL_PIN_STATE_CONNECTED' (1), the output pin will switch to the given
> DPLL, and the state of the given DPLL will be set to connected.
> E.g.:
> 	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
> 						       "state": 1 }}'
> This command will connect DPLL device with id 1 to output pin with id 2.
> 
> When 'state_on_dpll_set' is called with the value
> 'DPLL_PIN_STATE_DISCONNECTED' (2) and the given DPLL is currently
> connected, then the output pin will be disabled.
> E.g:
> 	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
> 						       "state": 2 }}'
> This command will disable output pin with id 2 if DPLL device with ID 1 is
> connected to it; otherwise, the command is ignored.
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 43 +++++++++++++++++------
>   1 file changed, 32 insertions(+), 11 deletions(-)
> 

For the series:

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index b9c5eced6326..9c0d739be1e9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -254,6 +254,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>    * ice_dpll_pin_enable - enable a pin on dplls
>    * @hw: board private hw structure
>    * @pin: pointer to a pin
> + * @dpll_idx: dpll index to connect to output pin
>    * @pin_type: type of pin being enabled
>    * @extack: error reporting
>    *
> @@ -266,7 +267,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>    */
>   static int
>   ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
> -		    enum ice_dpll_pin_type pin_type,
> +		    u8 dpll_idx, enum ice_dpll_pin_type pin_type,
>   		    struct netlink_ext_ack *extack)
>   {
>   	u8 flags = 0;
> @@ -280,10 +281,12 @@ ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>   		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
>   		break;
>   	case ICE_DPLL_PIN_TYPE_OUTPUT:
> +		flags = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_SRC_SEL;
>   		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
>   			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>   		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
> -		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, dpll_idx,
> +						0, 0);
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -398,14 +401,27 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>   		break;
>   	case ICE_DPLL_PIN_TYPE_OUTPUT:
>   		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
> -						&pin->flags[0], NULL,
> +						&pin->flags[0], &parent,
>   						&pin->freq, NULL);
>   		if (ret)
>   			goto err;
> -		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0])
> -			pin->state[0] = DPLL_PIN_STATE_CONNECTED;
> -		else
> -			pin->state[0] = DPLL_PIN_STATE_DISCONNECTED;
> +
> +		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
> +		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
> +			pin->state[pf->dplls.eec.dpll_idx] =
> +				parent == pf->dplls.eec.dpll_idx ?
> +				DPLL_PIN_STATE_CONNECTED :
> +				DPLL_PIN_STATE_DISCONNECTED;
> +			pin->state[pf->dplls.pps.dpll_idx] =
> +				parent == pf->dplls.pps.dpll_idx ?
> +				DPLL_PIN_STATE_CONNECTED :
> +				DPLL_PIN_STATE_DISCONNECTED;
> +		} else {
> +			pin->state[pf->dplls.eec.dpll_idx] =
> +				DPLL_PIN_STATE_DISCONNECTED;
> +			pin->state[pf->dplls.pps.dpll_idx] =
> +				DPLL_PIN_STATE_DISCONNECTED;
> +		}
>   		break;
>   	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
>   		for (parent = 0; parent < pf->dplls.rclk.num_parents;
> @@ -570,7 +586,8 @@ ice_dpll_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
>   
>   	mutex_lock(&pf->dplls.lock);
>   	if (enable)
> -		ret = ice_dpll_pin_enable(&pf->hw, p, pin_type, extack);
> +		ret = ice_dpll_pin_enable(&pf->hw, p, d->dpll_idx, pin_type,
> +					  extack);
>   	else
>   		ret = ice_dpll_pin_disable(&pf->hw, p, pin_type, extack);
>   	if (!ret)
> @@ -603,6 +620,11 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
>   			  struct netlink_ext_ack *extack)
>   {
>   	bool enable = state == DPLL_PIN_STATE_CONNECTED;
> +	struct ice_dpll_pin *p = pin_priv;
> +	struct ice_dpll *d = dpll_priv;
> +
> +	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
> +		return 0;
>   
>   	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
>   				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
> @@ -669,10 +691,9 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
>   	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
>   	if (ret)
>   		goto unlock;
> -	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT)
> +	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT ||
> +	    pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
>   		*state = p->state[d->dpll_idx];
> -	else if (pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
> -		*state = p->state[0];
>   	ret = 0;
>   unlock:
>   	mutex_unlock(&pf->dplls.lock);



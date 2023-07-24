Return-Path: <netdev+bounces-20521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBDE75FEA4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459A32814AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4BFBFF;
	Mon, 24 Jul 2023 17:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47390E574
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:58:57 +0000 (UTC)
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08B212F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:58:49 -0700 (PDT)
Message-ID: <2334fb1e-fa0c-f883-b6b8-50fe0c4662e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690221527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrTGr3hGTr0a/s8F/iJ7/lzfka/LmejC665uB8ivuxM=;
	b=jlmlopQ05ntLNoxCwk8k0k3vVmu9CULbAgEpTZx+kY4pADSiJbwGx/0phvkntXs33egSU5
	KS4LyYH0FfM0ma+LhTmurdZsS9a3J+e6ieTMezzKnbYQRiZPb0mtCWSdihRRa2+5YCTPO3
	CkPJnbOVs9TMR1QcYO/tZskQumavH1g=
Date: Mon, 24 Jul 2023 18:58:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/11] ice: implement dpll interface to control cgu
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZL631F2MWdXVoM+y@corigine.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZL631F2MWdXVoM+y@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24.07.2023 18:41, Simon Horman wrote:
> On Thu, Jul 20, 2023 at 10:19:01AM +0100, Vadim Fedorenko wrote:
> 
> ...
> 
> Hi Vadim,
> 

Hi Simon!
Thanks for the review. I believe Arkadiusz as the author of the patch will
adjust the code accordingly

>> +/**
>> + * ice_dpll_cb_unlock - unlock dplls mutex in callback context
>> + * @pf: private board structure
>> + *
>> + * Unlock the mutex from the callback operations invoked by dpll subsystem.
>> + */
>> +static void ice_dpll_cb_unlock(struct ice_pf *pf)
>> +{
>> +	mutex_unlock(&pf->dplls.lock);
>> +}
>> +
>> +/**
>> + * ice_dpll_pin_freq_set - set pin's frequency
>> + * @pf: private board structure
>> + * @pin: pointer to a pin
>> + * @pin_type: type of pin being configured
>> + * @freq: frequency to be set
>> + * @extack: error reporting
>> + *
>> + * Set requested frequency on a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error on AQ or wrong pin type given
>> + */
>> +static int
>> +ice_dpll_pin_freq_set(struct ice_pf *pf, struct ice_dpll_pin *pin,
>> +		      enum ice_dpll_pin_type pin_type, const u32 freq,
>> +		      struct netlink_ext_ack *extack)
>> +{
>> +	int ret;
>> +	u8 flags;
> 
> Please arrange local variable declarations for new Networking
> code in reverse xmas tree order - longest line to shortest.
> 
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		flags = ICE_AQC_SET_CGU_IN_CFG_FLG1_UPDATE_FREQ;
>> +		ret = ice_aq_set_input_pin_cfg(&pf->hw, pin->idx, flags,
>> +					       pin->flags[0], freq, 0);
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		flags = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_FREQ;
>> +		ret = ice_aq_set_output_pin_cfg(&pf->hw, pin->idx, flags,
>> +						0, freq, 0);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ret) {
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to set pin freq:%u on pin:%u\n",
>> +				   ret,
>> +				   ice_aq_str(pf->hw.adminq.sq_last_status),
>> +				   freq, pin->idx);
>> +		return ret;
>> +	}
>> +	pin->freq = freq;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +/**
>> + * ice_dpll_pin_state_update - update pin's state
>> + * @pf: private board struct
>> + * @pin: structure with pin attributes to be updated
>> + * @pin_type: type of pin being updated
>> + * @extack: error reporting
>> + *
>> + * Determine pin current state and frequency, then update struct
>> + * holding the pin info. For input pin states are separated for each
>> + * dpll, for rclk pins states are separated for each parent.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +int
>> +ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
>> +			  enum ice_dpll_pin_type pin_type,
>> +			  struct netlink_ext_ack *extack)
> 
>> +/**
>> + * ice_dpll_frequency_set - wrapper for pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + * @pin_type: type of pin being configured
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Acquires pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +		       const struct dpll_device *dpll, void *dpll_priv,
>> +		       const u32 frequency,
>> +		       struct netlink_ext_ack *extack,
>> +		       enum ice_dpll_pin_type pin_type)
>> +{
>> +	struct ice_dpll_pin *p = pin_priv;
>> +	struct ice_dpll *d = dpll_priv;
>> +	struct ice_pf *pf = d->pf;
>> +	int ret;
>> +
>> +	ret = ice_dpll_cb_lock(pf, extack);
>> +	if (ret)
>> +		return ret;
>> +	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
>> +	ice_dpll_cb_unlock(pf);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ice_dpll_input_frequency_set - input pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_input_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     u64 frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_output_frequency_set - output pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_output_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +			      const struct dpll_device *dpll, void *dpll_priv,
>> +			      u64 frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_frequency_get - wrapper for pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + * @pin_type: type of pin being configured
>> + *
>> + * Wraps internal get frequency command of a pin.
>> + *
>> + * Context: Acquires pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +		       const struct dpll_device *dpll, void *dpll_priv,
>> +		       u64 *frequency, struct netlink_ext_ack *extack,
>> +		       enum ice_dpll_pin_type pin_type)
>> +{
>> +	struct ice_dpll_pin *p = pin_priv;
>> +	struct ice_dpll *d = dpll_priv;
>> +	struct ice_pf *pf = d->pf;
>> +	int ret;
>> +
>> +	ret = ice_dpll_cb_lock(pf, extack);
>> +	if (ret)
>> +		return ret;
>> +	*frequency = p->freq;
>> +	ice_dpll_cb_unlock(pf);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ice_dpll_input_frequency_get - input pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + *
>> + * Wraps internal get frequency command of a input pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_input_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     u64 *frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_output_frequency_get - output pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + *
>> + * Wraps internal get frequency command of a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +			      const struct dpll_device *dpll, void *dpll_priv,
>> +			      u64 *frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_pin_enable - enable a pin on dplls
>> + * @hw: board private hw structure
>> + * @pin: pointer to a pin
>> + * @pin_type: type of pin being enabled
>> + * @extack: error reporting
>> + *
>> + * Enable a pin on both dplls. Store current state in pin->flags.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +static int
>> +ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>> +		    enum ice_dpll_pin_type pin_type,
>> +		    struct netlink_ext_ack *extack)
>> +{
>> +	u8 flags = 0;
>> +	int ret;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>> +		flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
>> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>> +		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
>> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ret)
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to enable %s pin:%u\n",
>> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
>> +				   pin_type_name[pin_type], pin->idx);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ice_dpll_pin_disable - disable a pin on dplls
>> + * @hw: board private hw structure
>> + * @pin: pointer to a pin
>> + * @pin_type: type of pin being disabled
>> + * @extack: error reporting
>> + *
>> + * Disable a pin on both dplls. Store current state in pin->flags.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +static int
>> +ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>> +		     enum ice_dpll_pin_type pin_type,
>> +		     struct netlink_ext_ack *extack)
>> +{
>> +	u8 flags = 0;
>> +	int ret;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ret)
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to disable %s pin:%u\n",
>> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
>> +				   pin_type_name[pin_type], pin->idx);
>> +
>> +	return ret;
>> +}
> 
>> +/**
>> + * ice_dpll_frequency_set - wrapper for pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + * @pin_type: type of pin being configured
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Acquires pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +		       const struct dpll_device *dpll, void *dpll_priv,
>> +		       const u32 frequency,
>> +		       struct netlink_ext_ack *extack,
>> +		       enum ice_dpll_pin_type pin_type)
>> +{
>> +	struct ice_dpll_pin *p = pin_priv;
>> +	struct ice_dpll *d = dpll_priv;
>> +	struct ice_pf *pf = d->pf;
>> +	int ret;
>> +
>> +	ret = ice_dpll_cb_lock(pf, extack);
>> +	if (ret)
>> +		return ret;
>> +	ret = ice_dpll_pin_freq_set(pf, p, pin_type, frequency, extack);
>> +	ice_dpll_cb_unlock(pf);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ice_dpll_input_frequency_set - input pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_input_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     u64 frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_output_frequency_set - output pin callback for set frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: frequency to be set
>> + * @extack: error reporting
>> + *
>> + * Wraps internal set frequency command on a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't set in hw
>> + */
>> +static int
>> +ice_dpll_output_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>> +			      const struct dpll_device *dpll, void *dpll_priv,
>> +			      u64 frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_set(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_frequency_get - wrapper for pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + * @pin_type: type of pin being configured
>> + *
>> + * Wraps internal get frequency command of a pin.
>> + *
>> + * Context: Acquires pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +		       const struct dpll_device *dpll, void *dpll_priv,
>> +		       u64 *frequency, struct netlink_ext_ack *extack,
>> +		       enum ice_dpll_pin_type pin_type)
>> +{
>> +	struct ice_dpll_pin *p = pin_priv;
>> +	struct ice_dpll *d = dpll_priv;
>> +	struct ice_pf *pf = d->pf;
>> +	int ret;
>> +
>> +	ret = ice_dpll_cb_lock(pf, extack);
>> +	if (ret)
>> +		return ret;
>> +	*frequency = p->freq;
>> +	ice_dpll_cb_unlock(pf);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ice_dpll_input_frequency_get - input pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + *
>> + * Wraps internal get frequency command of a input pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_input_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +			     const struct dpll_device *dpll, void *dpll_priv,
>> +			     u64 *frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_INPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_output_frequency_get - output pin callback for get frequency
>> + * @pin: pointer to a pin
>> + * @pin_priv: private data pointer passed on pin registration
>> + * @dpll: pointer to dpll
>> + * @dpll_priv: private data pointer passed on dpll registration
>> + * @frequency: on success holds pin's frequency
>> + * @extack: error reporting
>> + *
>> + * Wraps internal get frequency command of a pin.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - error pin not found or couldn't get from hw
>> + */
>> +static int
>> +ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>> +			      const struct dpll_device *dpll, void *dpll_priv,
>> +			      u64 *frequency, struct netlink_ext_ack *extack)
>> +{
>> +	return ice_dpll_frequency_get(pin, pin_priv, dpll, dpll_priv, frequency,
>> +				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
>> +}
>> +
>> +/**
>> + * ice_dpll_pin_enable - enable a pin on dplls
>> + * @hw: board private hw structure
>> + * @pin: pointer to a pin
>> + * @pin_type: type of pin being enabled
>> + * @extack: error reporting
>> + *
>> + * Enable a pin on both dplls. Store current state in pin->flags.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +static int
>> +ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>> +		    enum ice_dpll_pin_type pin_type,
>> +		    struct netlink_ext_ack *extack)
>> +{
>> +	u8 flags = 0;
>> +	int ret;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>> +		flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_INPUT_EN;
>> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>> +		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
>> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ret)
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to enable %s pin:%u\n",
>> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
>> +				   pin_type_name[pin_type], pin->idx);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ice_dpll_pin_disable - disable a pin on dplls
>> + * @hw: board private hw structure
>> + * @pin: pointer to a pin
>> + * @pin_type: type of pin being disabled
>> + * @extack: error reporting
>> + *
>> + * Disable a pin on both dplls. Store current state in pin->flags.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - OK
>> + * * negative - error
>> + */
>> +static int
>> +ice_dpll_pin_disable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>> +		     enum ice_dpll_pin_type pin_type,
>> +		     struct netlink_ext_ack *extack)
>> +{
>> +	u8 flags = 0;
>> +	int ret;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_IN_CFG_FLG2_ESYNC_EN;
>> +		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
>> +			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
>> +		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	if (ret)
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to disable %s pin:%u\n",
>> +				   ret, ice_aq_str(hw->adminq.sq_last_status),
>> +				   pin_type_name[pin_type], pin->idx);
>> +
>> +	return ret;
>> +}
> 
> Should this function be static?
> 
>> +{
>> +	int ret;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		ret = ice_aq_get_input_pin_cfg(&pf->hw, pin->idx, NULL, NULL,
>> +					       NULL, &pin->flags[0],
>> +					       &pin->freq, NULL);
>> +		if (ret)
>> +			goto err;
>> +		if (ICE_AQC_GET_CGU_IN_CFG_FLG2_INPUT_EN & pin->flags[0]) {
>> +			if (pin->pin) {
>> +				pin->state[pf->dplls.eec.dpll_idx] =
>> +					pin->pin == pf->dplls.eec.active_input ?
>> +					DPLL_PIN_STATE_CONNECTED :
>> +					DPLL_PIN_STATE_SELECTABLE;
>> +				pin->state[pf->dplls.pps.dpll_idx] =
>> +					pin->pin == pf->dplls.pps.active_input ?
>> +					DPLL_PIN_STATE_CONNECTED :
>> +					DPLL_PIN_STATE_SELECTABLE;
>> +			} else {
>> +				pin->state[pf->dplls.eec.dpll_idx] =
>> +					DPLL_PIN_STATE_SELECTABLE;
>> +				pin->state[pf->dplls.pps.dpll_idx] =
>> +					DPLL_PIN_STATE_SELECTABLE;
>> +			}
>> +		} else {
>> +			pin->state[pf->dplls.eec.dpll_idx] =
>> +				DPLL_PIN_STATE_DISCONNECTED;
>> +			pin->state[pf->dplls.pps.dpll_idx] =
>> +				DPLL_PIN_STATE_DISCONNECTED;
>> +		}
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
>> +						&pin->flags[0], NULL,
>> +						&pin->freq, NULL);
>> +		if (ret)
>> +			goto err;
>> +		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0])
>> +			pin->state[0] = DPLL_PIN_STATE_CONNECTED;
>> +		else
>> +			pin->state[0] = DPLL_PIN_STATE_DISCONNECTED;
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
> 
> clang-16 complains that:
>   
>    drivers/net/ethernet/intel/ice/ice_dpll.c:461:3: error: expected expression
>                    u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
> 
> Which, I think means, it wants this case to be enclosed in { }
> 
>> +		u8 parent, port_num = ICE_AQC_SET_PHY_REC_CLK_OUT_CURR_PORT;
>> +
>> +		for (parent = 0; parent < pf->dplls.rclk.num_parents;
>> +		     parent++) {
>> +			u8 p = parent;
>> +
>> +			ret = ice_aq_get_phy_rec_clk_out(&pf->hw, &p,
>> +							 &port_num,
>> +							 &pin->flags[parent],
>> +							 NULL);
>> +			if (ret)
>> +				goto err;
>> +			if (ICE_AQC_GET_PHY_REC_CLK_OUT_OUT_EN &
>> +			    pin->flags[parent])
>> +				pin->state[parent] = DPLL_PIN_STATE_CONNECTED;
>> +			else
>> +				pin->state[parent] =
>> +					DPLL_PIN_STATE_DISCONNECTED;
>> +		}
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	if (extack)
>> +		NL_SET_ERR_MSG_FMT(extack,
>> +				   "err:%d %s failed to update %s pin:%u\n",
>> +				   ret,
>> +				   ice_aq_str(pf->hw.adminq.sq_last_status),
>> +				   pin_type_name[pin_type], pin->idx);
>> +	else
>> +		dev_err_ratelimited(ice_pf_to_dev(pf),
>> +				    "err:%d %s failed to update %s pin:%u\n",
>> +				    ret,
>> +				    ice_aq_str(pf->hw.adminq.sq_last_status),
>> +				    pin_type_name[pin_type], pin->idx);
>> +	return ret;
>> +}
> 
> ...
> 
>> +/**
>> + * ice_dpll_update_state - update dpll state
>> + * @pf: pf private structure
>> + * @d: pointer to queried dpll device
>> + * @init: if function called on initialization of ice dpll
>> + *
>> + * Poll current state of dpll from hw and update ice_dpll struct.
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - AQ failure
>> + */
>> +static int
>> +ice_dpll_update_state(struct ice_pf *pf, struct ice_dpll *d, bool init)
>> +{
>> +	struct ice_dpll_pin *p = NULL;
>> +	int ret;
>> +
>> +	ret = ice_get_cgu_state(&pf->hw, d->dpll_idx, d->prev_dpll_state,
>> +				&d->input_idx, &d->ref_state, &d->eec_mode,
>> +				&d->phase_shift, &d->dpll_state, &d->mode);
>> +
>> +	dev_dbg(ice_pf_to_dev(pf),
>> +		"update dpll=%d, prev_src_idx:%u, src_idx:%u, state:%d, prev:%d mode:%d\n",
>> +		d->dpll_idx, d->prev_input_idx, d->input_idx,
>> +		d->dpll_state, d->prev_dpll_state, d->mode);
>> +	if (ret) {
>> +		dev_err(ice_pf_to_dev(pf),
>> +			"update dpll=%d state failed, ret=%d %s\n",
>> +			d->dpll_idx, ret,
>> +			ice_aq_str(pf->hw.adminq.sq_last_status));
>> +		return ret;
>> +	}
>> +	if (init) {
>> +		if (d->dpll_state == DPLL_LOCK_STATUS_LOCKED &&
>> +		    d->dpll_state == DPLL_LOCK_STATUS_LOCKED_HO_ACQ)
> 
> Should this be '||' rather than '&&' ?
> 
> Flagged by a clang-16 W=1 build, Sparse and Smatch.
> 
>> +			d->active_input = pf->dplls.inputs[d->input_idx].pin;
>> +		p = &pf->dplls.inputs[d->input_idx];
>> +		return ice_dpll_pin_state_update(pf, p,
>> +						 ICE_DPLL_PIN_TYPE_INPUT, NULL);
>> +	}
> 
> ...
> 
>> +/**
>> + * ice_dpll_init_info_direct_pins - initializes direct pins info
>> + * @pf: board private structure
>> + * @pin_type: type of pins being initialized
>> + *
>> + * Init information for directly connected pins, cache them in pf's pins
>> + * structures.
>> + *
>> + * Context: Called under pf->dplls.lock.
>> + * Return:
>> + * * 0 - success
>> + * * negative - init failure reason
>> + */
>> +static int
>> +ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>> +			       enum ice_dpll_pin_type pin_type)
>> +{
>> +	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
>> +	struct ice_hw *hw = &pf->hw;
>> +	struct ice_dpll_pin *pins;
>> +	int num_pins, i, ret;
>> +	u8 freq_supp_num;
>> +	bool input;
>> +
>> +	switch (pin_type) {
>> +	case ICE_DPLL_PIN_TYPE_INPUT:
>> +		pins = pf->dplls.inputs;
>> +		num_pins = pf->dplls.num_inputs;
>> +		input = true;
>> +		break;
>> +	case ICE_DPLL_PIN_TYPE_OUTPUT:
>> +		pins = pf->dplls.outputs;
>> +		num_pins = pf->dplls.num_outputs;
>> +		input = false;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < num_pins; i++) {
>> +		pins[i].idx = i;
>> +		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
>> +		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
>> +		if (input) {
>> +			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
>> +						      &de->input_prio[i]);
>> +			if (ret)
>> +				return ret;
>> +			ret = ice_aq_get_cgu_ref_prio(hw, dp->dpll_idx, i,
>> +						      &dp->input_prio[i]);
>> +			if (ret)
>> +				return ret;
>> +			pins[i].prop.capabilities |=
>> +				DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE;
>> +		}
>> +		pins[i].prop.capabilities |= DPLL_PIN_CAPS_STATE_CAN_CHANGE;
>> +		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
>> +		if (ret)
>> +			return ret;
>> +		pins[i].prop.freq_supported =
>> +			ice_cgu_get_pin_freq_supp(hw, i, input, &freq_supp_num);
>> +		pins[i].prop.freq_supported_num = freq_supp_num;
>> +		pins[i].pf = pf;
>> +	}
>> +
> 
> I'm unsure if this can happen,
> but if the for loop above iterates zero times
> then ret will be null here.
> 
> Use of uninitialised variable flagged by Smatch.
> 
>> +	return ret;
>> +}
> 
> ...
> 
>> +/**
>> + * ice_dpll_init_info - prepare pf's dpll information structure
>> + * @pf: board private structure
>> + * @cgu: if cgu is present and controlled by this NIC
>> + *
>> + * Acquire (from HW) and set basic dpll information (on pf->dplls struct).
>> + *
>> + * Context: Called under pf->dplls.lock
>> + * Return:
>> + * * 0 - success
>> + * * negative - init failure reason
>> + */
>> +static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
>> +{
>> +	struct ice_aqc_get_cgu_abilities abilities;
>> +	struct ice_dpll *de = &pf->dplls.eec;
>> +	struct ice_dpll *dp = &pf->dplls.pps;
>> +	struct ice_dplls *d = &pf->dplls;
>> +	struct ice_hw *hw = &pf->hw;
>> +	int ret, alloc_size, i;
>> +
>> +	d->clock_id = ice_generate_clock_id(pf);
>> +	ret = ice_aq_get_cgu_abilities(hw, &abilities);
>> +	if (ret) {
>> +		dev_err(ice_pf_to_dev(pf),
>> +			"err:%d %s failed to read cgu abilities\n",
>> +			ret, ice_aq_str(hw->adminq.sq_last_status));
>> +		return ret;
>> +	}
>> +
>> +	de->dpll_idx = abilities.eec_dpll_idx;
>> +	dp->dpll_idx = abilities.pps_dpll_idx;
>> +	d->num_inputs = abilities.num_inputs;
>> +	d->num_outputs = abilities.num_outputs;
>> +	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj);
>> +	d->output_phase_adj_max = le32_to_cpu(abilities.max_out_phase_adj);
>> +
>> +	alloc_size = sizeof(*d->inputs) * d->num_inputs;
>> +	d->inputs = kzalloc(alloc_size, GFP_KERNEL);
>> +	if (!d->inputs)
>> +		return -ENOMEM;
>> +
>> +	alloc_size = sizeof(*de->input_prio) * d->num_inputs;
>> +	de->input_prio = kzalloc(alloc_size, GFP_KERNEL);
>> +	if (!de->input_prio)
>> +		return -ENOMEM;
>> +
>> +	dp->input_prio = kzalloc(alloc_size, GFP_KERNEL);
>> +	if (!dp->input_prio)
>> +		return -ENOMEM;
>> +
>> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_INPUT);
>> +	if (ret)
>> +		goto deinit_info;
>> +
>> +	if (cgu) {
>> +		alloc_size = sizeof(*d->outputs) * d->num_outputs;
>> +		d->outputs = kzalloc(alloc_size, GFP_KERNEL);
>> +		if (!d->outputs)
> 
> Should ret be set to -ENOMEM here?
> 
> Flagged by Smatch.
> 
>> +			goto deinit_info;
>> +
>> +		ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_OUTPUT);
>> +		if (ret)
>> +			goto deinit_info;
>> +	}
>> +
>> +	ret = ice_get_cgu_rclk_pin_info(&pf->hw, &d->base_rclk_idx,
>> +					&pf->dplls.rclk.num_parents);
>> +	if (ret)
>> +		return ret;
>> +	for (i = 0; i < pf->dplls.rclk.num_parents; i++)
>> +		pf->dplls.rclk.parent_idx[i] = d->base_rclk_idx + i;
>> +	ret = ice_dpll_init_pins_info(pf, ICE_DPLL_PIN_TYPE_RCLK_INPUT);
>> +	if (ret)
>> +		return ret;
>> +	de->mode = DPLL_MODE_AUTOMATIC;
>> +	dp->mode = DPLL_MODE_AUTOMATIC;
>> +
>> +	dev_dbg(ice_pf_to_dev(pf),
>> +		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
>> +		__func__, d->num_inputs, d->num_outputs, d->rclk.num_parents);
>> +
>> +	return 0;
>> +
>> +deinit_info:
>> +	dev_err(ice_pf_to_dev(pf),
>> +		"%s - fail: d->inputs:%p, de->input_prio:%p, dp->input_prio:%p, d->outputs:%p\n",
>> +		__func__, d->inputs, de->input_prio,
>> +		dp->input_prio, d->outputs);
>> +	ice_dpll_deinit_info(pf);
>> +	return ret;
>> +}
> 
> ...
> 
>> +/**
>> + * ice_dpll_init - initialize support for dpll subsystem
>> + * @pf: board private structure
>> + *
>> + * Set up the device dplls, register them and pins connected within Linux dpll
>> + * subsystem. Allow userpsace to obtain state of DPLL and handling of DPLL
> 
> nit: userpsace -> userspace
> 
>> + * configuration requests.
>> + *
>> + * Context: Function initializes and holds pf->dplls.lock mutex.
>> + */
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> new file mode 100644
>> index 000000000000..975066b71c5e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>> @@ -0,0 +1,104 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2022, Intel Corporation. */
>> +
>> +#ifndef _ICE_DPLL_H_
>> +#define _ICE_DPLL_H_
>> +
>> +#include "ice.h"
>> +
>> +#define ICE_DPLL_PRIO_MAX	0xF
>> +#define ICE_DPLL_RCLK_NUM_MAX	4
>> +
>> +/** ice_dpll_pin - store info about pins
>> + * @pin: dpll pin structure
>> + * @pf: pointer to pf, which has registered the dpll_pin
>> + * @idx: ice pin private idx
>> + * @num_parents: hols number of parent pins
>> + * @parent_idx: hold indexes of parent pins
>> + * @flags: pin flags returned from HW
>> + * @state: state of a pin
>> + * @prop: pin properities
> 
> nit: properities -> properties
> 
>> + * @freq: current frequency of a pin
>> + */
>> +struct ice_dpll_pin {
>> +	struct dpll_pin *pin;
>> +	struct ice_pf *pf;
>> +	u8 idx;
>> +	u8 num_parents;
>> +	u8 parent_idx[ICE_DPLL_RCLK_NUM_MAX];
>> +	u8 flags[ICE_DPLL_RCLK_NUM_MAX];
>> +	u8 state[ICE_DPLL_RCLK_NUM_MAX];
>> +	struct dpll_pin_properties prop;
>> +	u32 freq;
>> +};
> 
> ...



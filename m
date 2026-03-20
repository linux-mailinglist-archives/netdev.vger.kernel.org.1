Return-Path: <netdev+bounces-269818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH0xGu32vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:27:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C82D69B8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69CEF3012B4A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BB35CB67;
	Fri, 20 Mar 2026 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwCySEHZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4422D249E
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991658; cv=none; b=omV9l8a5vO8wVG2v5FnmKjE6q+KakEzlbWQxFV1xssHjA78tAoHLwGKDI8yKFeVjo5v/oU21WJtBp9TcaSHLf+VRrlIrkyETmCMZBFdF0J2P/CQq3dmPkdv+0+tr6g46SFU1ptCs2KtRn+o74OGhJMdV5mXCseiEfcYyljxDgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991658; c=relaxed/simple;
	bh=ZvuNQsPAG1DIuyhVKAFcieK0H4HppN+DZOo3qKB4spI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOJzmIB56AC0QjeEbFNb1dkW0Nsjs57WLLaXP3EqxwP5ZLSBms/Qb4wtFFTZbVqiLdoC8C+ocuXNTbd8w36fD5sdRHeA6NtMT2rv/Y6LTYchZExLLHuUbgHWiSvRSwBz4TpiXJUKEw0k8y7gaeHw2JxT2wn6tBQg5sYo3rJPzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwCySEHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773991655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvg9NvEmDP+fuDbIX9VVuONLbZYI0ChtqQABOODXlfw=;
	b=cwCySEHZyIumn+S2RTPF53CdyMZfO+8oxIJTHtkO2mKTr+67Em6zQunRQggEWckSYVQVLE
	X4Knp5kV62vFyhDL2gm91hyBWFfDBwllDXilMlXfJBECI77YonohilJHyGAgKmG1MurzuA
	MQAmDYdRX8nUaz4CYN+N9OkCWSztpsw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-tMBRQGkBPb2flvdNZmlMbw-1; Fri,
 20 Mar 2026 03:27:30 -0400
X-MC-Unique: tMBRQGkBPb2flvdNZmlMbw-1
X-Mimecast-MFC-AGG-ID: tMBRQGkBPb2flvdNZmlMbw_1773991648
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FB1F1944F01;
	Fri, 20 Mar 2026 07:27:28 +0000 (UTC)
Received: from [10.45.225.20] (unknown [10.45.225.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3E9330001A1;
	Fri, 20 Mar 2026 07:27:24 +0000 (UTC)
Message-ID: <e898f409-3424-46de-90b0-86c96300787c@redhat.com>
Date: Fri, 20 Mar 2026 08:27:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v4] ice: fix missing dpll notifications for SW
 pins
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20260319205256.998876-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260319205256.998876-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 195C82D69B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 9:52 PM, Petr Oros wrote:
> The SMA/U.FL pin redesign (commit 2dd5d03c77e2 ("ice: redesign dpll
> sma/u.fl pins control")) introduced software-controlled pins that wrap
> backing CGU input/output pins, but never updated the notification and
> data paths to propagate pin events to these SW wrappers.
> 
> There are three problems:
> 
> 1) ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
>     direct CGU input pin stored in d->active_input.  When the active
>     input changes, SW pins (SMA/U.FL) that wrap the old or new active
>     input never receive a change notification.  As a result, userspace
>     consumers such as synce4l that monitor SMA pins via dpll netlink
>     never learn when the pin state transitions (e.g. from SELECTABLE to
>     CONNECTED).
> 
> 2) ice_dpll_phase_offset_get() returns p->phase_offset for non-active
>     SW pins, but this field is never updated for SW pins.  The PPS phase
>     offset monitor updates the backing CGU input's phase_offset
>     (p->input->phase_offset), not the SW pin's own field.  As a result
>     non-active SW pins always report zero phase offset even when the
>     backing CGU input has valid PPS measurements.
> 
> 3) ice_dpll_pins_notify_mask() does not propagate phase offset change
>     notifications to SW pins either.  When a HW CGU pin gets a phase
>     offset change notification, the SMA/U.FL pin wrapping it is never
>     notified, so userspace consumers (ts2phc, synce4l) monitoring SW
>     pins via dpll netlink never receive phase offset updates.
> 
> Fix all three by:
> 
>   - In ice_dpll_phase_offset_get(), return the backing CGU input's
>     phase_offset for input-direction SW pins instead of the SW pin's own
>     (always zero) field.
> 
>   - Introduce ice_dpll_pin_ntf(), a thin wrapper around
>     dpll_pin_change_ntf() that also sends notifications to any
>     registered SMA/U.FL pin whose backing CGU input matches.  Replace
>     all direct dpll_pin_change_ntf() calls in the periodic notification
>     paths with ice_dpll_pin_ntf(), so SW pins are automatically notified
>     whenever their backing HW pin is.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v4:
>   - expanded scope to also fix phase offset reporting and phase offset
>     notifications for SW pins (problems 2 and 3 above)
>   - replaced ice_dpll_sw_pin_needs_notify() with ice_dpll_pin_ntf(),
>     a unified wrapper that covers all notification paths
>   - squashed into a single patch
> v3: https://lore.kernel.org/all/20260220140700.2910174-1-poros@redhat.com/
>   - added kdoc for ice_dpll_sw_pin_needs_notify() helper
> v2: https://lore.kernel.org/all/20260219131500.2271897-1-poros@redhat.com/
>   - extracted ice_dpll_sw_pin_needs_notify() helper for readability
>   - moved loop variable into for() scope
> v1: https://lore.kernel.org/all/20260218211414.1411163-1-poros@redhat.com/
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 47 +++++++++++++++++------
>   1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d65205..5cfa19da099bfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1915,7 +1915,10 @@ ice_dpll_phase_offset_get(const struct dpll_pin *pin, void *pin_priv,
>   				       d->active_input == p->input->pin))
>   		*phase_offset = d->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
>   	else if (d->phase_offset_monitor_period)
> -		*phase_offset = p->phase_offset * ICE_DPLL_PHASE_OFFSET_FACTOR;
> +		*phase_offset = (p->input &&
> +				 p->direction == DPLL_PIN_DIRECTION_INPUT ?
> +				 p->input->phase_offset :
> +				 p->phase_offset) * ICE_DPLL_PHASE_OFFSET_FACTOR;
>   	else
>   		*phase_offset = 0;
>   	mutex_unlock(&pf->dplls.lock);
> @@ -2609,6 +2612,27 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>   	return pci_get_dsn(pf->pdev);
>   }
>   
> +/**
> + * ice_dpll_pin_ntf - notify pin change including any SW pin wrappers
> + * @dplls: pointer to dplls struct
> + * @pin: the dpll_pin that changed
> + *
> + * Send a change notification for @pin and for any registered SMA/U.FL pin
> + * whose backing CGU input matches @pin.
> + */
> +static void ice_dpll_pin_ntf(struct ice_dplls *dplls, struct dpll_pin *pin)
> +{
> +	dpll_pin_change_ntf(pin);
> +	for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
> +		if (dplls->sma[i].pin && dplls->sma[i].input &&
> +		    dplls->sma[i].input->pin == pin)
> +			dpll_pin_change_ntf(dplls->sma[i].pin);
> +		if (dplls->ufl[i].pin && dplls->ufl[i].input &&
> +		    dplls->ufl[i].input->pin == pin)
> +			dpll_pin_change_ntf(dplls->ufl[i].pin);
> +	}
> +}
> +
>   /**
>    * ice_dpll_notify_changes - notify dpll subsystem about changes
>    * @d: pointer do dpll
> @@ -2617,6 +2641,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>    */
>   static void ice_dpll_notify_changes(struct ice_dpll *d)
>   {
> +	struct ice_dplls *dplls = &d->pf->dplls;
>   	bool pin_notified = false;
>   
>   	if (d->prev_dpll_state != d->dpll_state) {
> @@ -2625,17 +2650,17 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>   	}
>   	if (d->prev_input != d->active_input) {
>   		if (d->prev_input)
> -			dpll_pin_change_ntf(d->prev_input);
> +			ice_dpll_pin_ntf(dplls, d->prev_input);
>   		d->prev_input = d->active_input;
>   		if (d->active_input) {
> -			dpll_pin_change_ntf(d->active_input);
> +			ice_dpll_pin_ntf(dplls, d->active_input);
>   			pin_notified = true;
>   		}
>   	}
>   	if (d->prev_phase_offset != d->phase_offset) {
>   		d->prev_phase_offset = d->phase_offset;
>   		if (!pin_notified && d->active_input)
> -			dpll_pin_change_ntf(d->active_input);
> +			ice_dpll_pin_ntf(dplls, d->active_input);
>   	}
>   }
>   
> @@ -2664,6 +2689,7 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
>   
>   /**
>    * ice_dpll_pins_notify_mask - notify dpll subsystem about bulk pin changes
> + * @dplls: pointer to dplls struct
>    * @pins: array of ice_dpll_pin pointers registered within dpll subsystem
>    * @pin_num: number of pins
>    * @phase_offset_ntf_mask: bitmask of pin indexes to notify
> @@ -2673,15 +2699,14 @@ static bool ice_dpll_is_pps_phase_monitor(struct ice_pf *pf)
>    *
>    * Context: Must be called while pf->dplls.lock is released.
>    */
> -static void ice_dpll_pins_notify_mask(struct ice_dpll_pin *pins,
> +static void ice_dpll_pins_notify_mask(struct ice_dplls *dplls,
> +				      struct ice_dpll_pin *pins,
>   				      u8 pin_num,
>   				      u32 phase_offset_ntf_mask)
>   {
> -	int i = 0;
> -
> -	for (i = 0; i < pin_num; i++)
> -		if (phase_offset_ntf_mask & (1 << i))
> -			dpll_pin_change_ntf(pins[i].pin);
> +	for (int i = 0; i < pin_num; i++)
> +		if (phase_offset_ntf_mask & BIT(i))
> +			ice_dpll_pin_ntf(dplls, pins[i].pin);
>   }
>   
>   /**
> @@ -2857,7 +2882,7 @@ static void ice_dpll_periodic_work(struct kthread_work *work)
>   	ice_dpll_notify_changes(de);
>   	ice_dpll_notify_changes(dp);
>   	if (phase_offset_ntf)
> -		ice_dpll_pins_notify_mask(d->inputs, d->num_inputs,
> +		ice_dpll_pins_notify_mask(d, d->inputs, d->num_inputs,
>   					  phase_offset_ntf);
>   
>   resched:

Good catch, Petr.

Reviewed-by: Ivan Vecera <ivecera@redhat.com>



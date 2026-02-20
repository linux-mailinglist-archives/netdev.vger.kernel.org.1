Return-Path: <netdev+bounces-259736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH73CmOBmGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F6168FFC
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1983A30A808F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8734DCF9;
	Fri, 20 Feb 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXqKwvDX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F034C806
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602218; cv=none; b=qkT691ybpf7f7GxD1jUV6/FOZUyKPLxpCGqOlbDSfEYEU1sKsd6JirLTqUdt4Efjf1gItAgZRANabNiMdOSfhAPObhGXnoVwu0feyIqIGSAi9wQD0CbYWMxoSCQ1ma+eak5pwbHYi4uuKf4Mdn3hLSXFW3DytQ7BZHlH4rYLDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602218; c=relaxed/simple;
	bh=XancFSkqs9/j3HeLlQ6DxYHYeIvDSLV8aOi9rO0aggo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHd/mrph9Jr/A2Vzz+B5gLY2/RnVsll2+gAVpEFOdXOvqvcxd36m5tijY/cwpd0iGRBhZlsavVZKf2e1GI2VbOKbpTahF9LBpPDyNicMC1WHOj9WVpy8Dw46A2fMZnL4xw6U4Llyd4Oafeojl+cHQMw1/F9XAZ1dRRW4RPM4sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXqKwvDX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771602216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+Uv0d3wrPnSJ3SxLCH2RWTR/GFjVuhCCarj46UG2RM=;
	b=PXqKwvDX608w+/TNX1ixwHfUMyVlpU7zgb1WYcw8YQRJxdCpMIgkmR0nm5JaYJ/qtYmOa9
	MkQDE4B95JZTrMXHzyC2LFpbYhOXPcHksdKUlpK7xOEyG9sA5B01jV9T/KC2BjN5mw851C
	kke3+TzQ4rI/8JXg4koxR5fstd8Err8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-TU7hGJMAMh2LNowuTJn72A-1; Fri,
 20 Feb 2026 10:43:33 -0500
X-MC-Unique: TU7hGJMAMh2LNowuTJn72A-1
X-Mimecast-MFC-AGG-ID: TU7hGJMAMh2LNowuTJn72A_1771602211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 272A21956052;
	Fri, 20 Feb 2026 15:43:31 +0000 (UTC)
Received: from [10.44.32.156] (unknown [10.44.32.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F00081800361;
	Fri, 20 Feb 2026 15:43:25 +0000 (UTC)
Message-ID: <00243d05-7dda-4106-b56c-f772d3fa96be@redhat.com>
Date: Fri, 20 Feb 2026 16:43:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3] ice: fix missing dpll notification for SW pins
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 piotr.kwapulinski@intel.com
References: <20260220140700.2910174-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260220140700.2910174-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259736-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AB8F6168FFC
X-Rspamd-Action: no action

On 2/20/26 3:07 PM, Petr Oros wrote:
> ice_dpll_notify_changes() sends dpll_pin_change_ntf() only for the
> direct CGU input pin stored in d->active_input. Software-controlled
> pins (SMA/U.FL) are separate dpll_pin objects that wrap a backing CGU
> input, but they never receive a change notification. As a result,
> userspace consumers such as synce4l that monitor SMA pins via dpll
> netlink never learn when the pin state transitions (e.g. from
> SELECTABLE to CONNECTED), even though 'dpll pin show' reports the
> correct state on demand.
> 
> When the active input changes, also send dpll_pin_change_ntf() for any
> registered SMA/U.FL input pin whose backing CGU input matches the old
> or new active input.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602200046.SGwK2tWh-lkp@intel.com/
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v3:
> - Add kdoc for the helper.
> v2:
> - Extract ice_dpll_sw_pin_needs_notify() helper for readability,
> - Move loop variable into for() scope.
> 
> drivers/net/ethernet/intel/ice/ice_dpll.c | 29 +++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index c2ad39bfe177db..a9db85a1026388 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2462,6 +2462,24 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>   	return pci_get_dsn(pf->pdev);
>   }
>   
> +/**
> + * ice_dpll_sw_pin_needs_notify - check if SW pin needs change notification
> + * @p: pointer to SW pin (SMA or U.FL)
> + * @active: currently active input pin (or NULL)
> + * @old: previously active input pin (or NULL)
> + *
> + * Return: true if the SW pin is an input whose backing CGU pin matches either
> + * the old or new active input, meaning its state has changed.
> + */
> +static bool
> +ice_dpll_sw_pin_needs_notify(struct ice_dpll_pin *p,
> +			     struct dpll_pin *active, struct dpll_pin *old)
> +{
> +	return p->pin &&
> +	       p->direction == DPLL_PIN_DIRECTION_INPUT &&
> +	       (p->input->pin == active || p->input->pin == old);
> +}
> +
>   /**
>    * ice_dpll_notify_changes - notify dpll subsystem about changes
>    * @d: pointer do dpll
> @@ -2470,6 +2488,7 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>    */
>   static void ice_dpll_notify_changes(struct ice_dpll *d)
>   {
> +	struct ice_dplls *dplls = &d->pf->dplls;
>   	bool pin_notified = false;
>   
>   	if (d->prev_dpll_state != d->dpll_state) {
> @@ -2477,6 +2496,8 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>   		dpll_device_change_ntf(d->dpll);
>   	}
>   	if (d->prev_input != d->active_input) {
> +		struct dpll_pin *old = d->prev_input;
> +
>   		if (d->prev_input)
>   			dpll_pin_change_ntf(d->prev_input);
>   		d->prev_input = d->active_input;
> @@ -2484,6 +2505,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>   			dpll_pin_change_ntf(d->active_input);
>   			pin_notified = true;
>   		}
> +		for (int i = 0; i < ICE_DPLL_PIN_SW_NUM; i++) {
> +			if (ice_dpll_sw_pin_needs_notify(&dplls->sma[i],
> +							 d->active_input, old))
> +				dpll_pin_change_ntf(dplls->sma[i].pin);
> +			if (ice_dpll_sw_pin_needs_notify(&dplls->ufl[i],
> +							 d->active_input, old))
> +				dpll_pin_change_ntf(dplls->ufl[i].pin);
> +		}
>   	}
>   	if (d->prev_phase_offset != d->phase_offset) {
>   		d->prev_phase_offset = d->phase_offset;

LGMT...

Reviewed-by: Ivan Vecera <ivecera@redhat.com>



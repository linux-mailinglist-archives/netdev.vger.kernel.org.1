Return-Path: <netdev+bounces-259734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC5CLeaAmGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:42:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786FF168FBB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11DD23019396
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530934A765;
	Fri, 20 Feb 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOa669sK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C383164D4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602142; cv=none; b=uNPyIpzC1NbQM0Pxm+oYu5t1vvLFzELAwdTUVti4xRzfV3z7ISyspch/pwYb4Ip7yvtCBwbgW081KQOeZ4fkIHYDD1pImooEwmFd508uAoMDH/xe+6Kwr/zJoc/UTS1bJAdPv7lRu1w5jfcAq6O1tMZh9PjWzlhYXK1GOqE4hMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602142; c=relaxed/simple;
	bh=cF8njjO+AtJ3nhrs56F4R8cPSwNUG5F3WGj06O8uGXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLwgVTEt12L7yaeawnTA+kZLNhbkW8TvzikKzOlMk8t36nH4tK2g1g/m+qksrTIE4uJXIS74RQEUgqX6geWpaNmGci6UaK4BGm9r/zYuOtQBRKaqt+ekGUxL5Yulh4bNaYXwUx4SCXV8p801kla4yYMTTRHtkeINoW1vrY16lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOa669sK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771602139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67b6teLexKniaLcuw99MhHpDK/+wT7F7WVUO/b+g5RI=;
	b=aOa669sKM7Lfbt2cc+iKUmipu0M1hAENU8P9jzTwLY1A5B/rkUSIJOs3HX5+9xVWTLcrwN
	ayB/6uj/s0mUCIz35DnsbNWRpRhKIeUKD8bJP3O1YVThyuL77AzoOwKie5cx8orEcX33cz
	qXuhMzGPpJFfv2AE6N2GPZ2KrfGMuss=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-RCBguz5rOTOTqyCvsXWH3w-1; Fri,
 20 Feb 2026 10:42:16 -0500
X-MC-Unique: RCBguz5rOTOTqyCvsXWH3w-1
X-Mimecast-MFC-AGG-ID: RCBguz5rOTOTqyCvsXWH3w_1771602134
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E88F21956052;
	Fri, 20 Feb 2026 15:42:13 +0000 (UTC)
Received: from [10.44.32.156] (unknown [10.44.32.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 229D23000C26;
	Fri, 20 Feb 2026 15:42:09 +0000 (UTC)
Message-ID: <0226868b-ff1c-4923-8593-f1a8ed529a57@redhat.com>
Date: Fri, 20 Feb 2026 16:42:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: fix missing dpll notification for SW pins
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 piotr.kwapulinski@intel.com
References: <20260219131500.2271897-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260219131500.2271897-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 786FF168FBB
X-Rspamd-Action: no action



On 2/19/26 2:15 PM, Petr Oros wrote:
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
> v2:
> - Extract ice_dpll_sw_pin_needs_notify() helper for readability,
> - Move loop variable into for() scope.
> 
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index c2ad39bfe177db..2a505d924fcbae 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2468,8 +2468,18 @@ static u64 ice_generate_clock_id(struct ice_pf *pf)
>    *
>    * Once change detected appropriate event is submitted to the dpll subsystem.
>    */
> +static bool
> +ice_dpll_sw_pin_needs_notify(struct ice_dpll_pin *p,
> +			     struct dpll_pin *active, struct dpll_pin *old)
> +{
> +	return p->pin &&
> +	       p->direction == DPLL_PIN_DIRECTION_INPUT &&
> +	       (p->input->pin == active || p->input->pin == old);
> +}
> +

Move this function above comment that documents function
ice_dpll_notify_changes().

Ivan

>   static void ice_dpll_notify_changes(struct ice_dpll *d)
>   {
> +	struct ice_dplls *dplls = &d->pf->dplls;
>   	bool pin_notified = false;
>   
>   	if (d->prev_dpll_state != d->dpll_state) {
> @@ -2477,6 +2487,8 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
>   		dpll_device_change_ntf(d->dpll);
>   	}
>   	if (d->prev_input != d->active_input) {
> +		struct dpll_pin *old = d->prev_input;
> +
>   		if (d->prev_input)
>   			dpll_pin_change_ntf(d->prev_input);
>   		d->prev_input = d->active_input;
> @@ -2484,6 +2496,14 @@ static void ice_dpll_notify_changes(struct ice_dpll *d)
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



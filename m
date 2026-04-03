Return-Path: <netdev+bounces-275035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WADQJ+C7z2mj0AYAu9opvQ
	(envelope-from <netdev+bounces-275035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:08:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4339454A
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92B03030B31
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4375329E6A;
	Fri,  3 Apr 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhQc29t9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD423A5439
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221621; cv=none; b=ucUhG5huAY8WsrYMSnhmp2zlMetZ/vzg5aejpIfCo15Y9OVKkYufOW1UzVH8c38W8kqin9SdjNmsE00yAlZB0uXTTp8zr0p6W3GG8sPXJE2zSOJKaLhXcOcTVvJCqqYhmpXHcNqcKDHQGDWuS+injYUScg3F8sr+kVUdLbu1phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221621; c=relaxed/simple;
	bh=MvYZp7NV0bNnPtYiJFZfLQoMzo5b+sKc6tBosXsoARQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU2Vmq1lFwBJNkVZBGPMQogE+kVtBWt6MmLBPLeS/HMfO/EXdJqyB9HVxe0OMnexlbG78+/oSdp8wntzp/sM87E/e2rTKr85o79GclB9nZc1AgdJA7DH6yi0Wb37S6xB5W3PWkHfVqGNgaFyMWKINl6krMhL715kfCexB/D0Dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhQc29t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3F5C4CEF7;
	Fri,  3 Apr 2026 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775221621;
	bh=MvYZp7NV0bNnPtYiJFZfLQoMzo5b+sKc6tBosXsoARQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhQc29t9aN3aV20vOc5k64lTHEW45zjofrD97FHnigtk+rlCSt6BMhK3bgOPvlVKo
	 nnqQ0VYdOtLuB6opGrZdhre6IkqhEiFpSsB6NQzcvtSqEOvRYibnaT/SP/YcD0ksIi
	 yB0sfgFz451i0LdGQod6HTZb01faG2UYdi1YmFByyHRRktCz1Tq9UqtOMfSm0YxP+C
	 sODW71Kcws6NC5BdfhLrA8inCBvgYiHD5Yh8n45J8pEf2OQGfo8U9PSIJrsakzXhCU
	 n/4jFMNVCoqQY/u2gmVAe4+YD6u8CkeGP50ZyLAjq69Rb1JtLPoY2l+Ehhszp7aYNZ
	 WHH+gc9a+2eZw==
Date: Fri, 3 Apr 2026 14:06:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH net] ice: stop DCBNL requests during driver unload
Message-ID: <20260403130657.GA110554@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-8-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 02A4339454A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:23:31AM +0100, Aleksandr Loktionov wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> With a chatty lldpad, DCB configuration requests can arrive through
> the DCBNL API while the driver is tearing down PF resources, leading
> to use-after-free and NULL dereference crashes.
> 
> Set ICE_SHUTTING_DOWN in pf->state at the start of ice_remove() and
> check this bit at the beginning of every DCBNL callback that accesses
> resources freed during the remove path.
> 
> Fixes: b94b013eb626 ("ice: Implement DCBNL support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> @@ -308,6 +326,8 @@ ice_dcbnl_get_pfc_cfg(struct net_device *netdev, int prio, u8 *setting)
>  	struct ice_pf *pf = ice_netdev_to_pf(netdev);
>  	struct ice_port_info *pi = pf->hw.port_info;
>  
> +	if (test_bit(ICE_SHUTTING_DOWN, pf->state))
> +		return;
>  	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
>  	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_CEE))
>  		return;

I think this problem predates this patch. But AI review warns
that callers pass an setting without initialising the data it points to,
and expect it to be initialised on return. But that doesn't happen
if the function exits early.

It suggests that callers should initialise *setting, and the AI generated
review states this is the case for other callbacks. (I did not check this
claim.)

It seems to me this is not strictly an ICE problem, although a quick
scan showed up a mix of driver that ensure that the setting parameter
is always initialised before return, and those that don't.

I think this problem is orthogonal to this patch, but seems to want
fixing.

...


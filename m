Return-Path: <netdev+bounces-276660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJZqGqCO1mliGQgAu9opvQ
	(envelope-from <netdev+bounces-276660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:21:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6523BF690
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 953093028C06
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167113D668E;
	Wed,  8 Apr 2026 17:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA273D1CC5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668883; cv=none; b=TMp3t9FYv6r/wgikiy45qxw4Gm3HEKuLtJP6mCnL/0KeGssxXPvj2Lzz9R3QEY35qGwjeFq0JZ10USLE3vzRO0NsgAt7NjnuL5RRYevHtfHngDZi07n6UQ0nL+G4VIivz1d3LPLFYyVISX6/3l+ydZXCO4yREdjJ9yocsD6e4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668883; c=relaxed/simple;
	bh=vCNXCykf7ybXPjxf3Dpmoh7DYZSSC9LwbRiI6kbu0CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyZhEnwhIAnB4vLwwctXzkKy3IpssHw1OyjKx2P7y7rTktMSZu9BxJMVHKumiQiqM2Y7udkFmod2HLuVv6+6DxCAv3z5NxQEs08HIBM+vO3TNICbbCcAKo7oSpZMoUGuc6FldmyZlumlXPS3onh4f7oKo/In/oGz57+U3t9v+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7DA944C2C37D60;
	Wed, 08 Apr 2026 19:20:53 +0200 (CEST)
Message-ID: <d2a40b73-2019-479d-9eb0-3a0e9c440659@molgen.mpg.de>
Date: Wed, 8 Apr 2026 19:20:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: fix ice_init_link() error
 return preventing probe
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20260408141105.2781683-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260408141105.2781683-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.941];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,molgen.mpg.de:mid,intel.com:email]
X-Rspamd-Queue-Id: 0D6523BF690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Aleksandr, dear Paul,


Thank you for the patch.

Am 08.04.26 um 16:11 schrieb Aleksandr Loktionov:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> ice_init_link() can return an error status from ice_update_link_info()
> or ice_init_phy_user_cfg(), causing probe to fail.
> 
> An incorrect NVM update procedure can result in link/PHY errors, and
> the recommended resolution is to update the NVM using the correct
> procedure. If the driver fails probe due to link errors, the user
> cannot update the NVM to recover. The link/PHY errors logged are
> non-fatal: they are already annotated as 'not a fatal error if this
> fails'.
> 
> Since none of the errors inside ice_init_link() should prevent probe
> from completing, convert it to void and remove the error check in the
> caller. All failures are already logged; callers have no meaningful
> recovery path for link init errors.

Do you have a way to force the error path?

> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2:
>   - Rename the now-unused goto label err_init_link to err_deinit_pf_sw
>     to better describe the cleanup it performs (Simon Horman).
> 
>   drivers/net/ethernet/intel/ice/ice_main.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index cf116bb..a6b0c09 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4856,16 +4856,14 @@ static void ice_init_wakeup(struct ice_pf *pf)
>   	device_set_wakeup_enable(ice_pf_to_dev(pf), false);
>   }
>   
> -static int ice_init_link(struct ice_pf *pf)
> +static void ice_init_link(struct ice_pf *pf)
>   {
>   	struct device *dev = ice_pf_to_dev(pf);
>   	int err;
>   
>   	err = ice_init_link_events(pf->hw.port_info);
> -	if (err) {
> +	if (err)
>   		dev_err(dev, "ice_init_link_events failed: %d\n", err);
> -		return err;
> -	}
>   
>   	/* not a fatal error if this fails */
>   	err = ice_init_nvm_phy_type(pf->hw.port_info);
> @@ -4899,8 +4897,6 @@ static int ice_init_link(struct ice_pf *pf)
>   	} else {
>   		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
>   	}
> -
> -	return err;
>   }
>   
>   static int ice_init_pf_sw(struct ice_pf *pf)
> @@ -5043,11 +5039,9 @@ static int ice_init(struct ice_pf *pf)
>   
>   	ice_init_wakeup(pf);
>   
> -	err = ice_init_link(pf);
> -	if (err)
> -		goto err_init_link;
> +	ice_init_link(pf);
>   
>   	err = ice_send_version(pf);
>   	if (err)
> -		goto err_init_link;
> +		goto err_deinit_pf_sw;
>   
> @@ -5069,7 +5063,7 @@ static int ice_init(struct ice_pf *pf)
>   	return 0;
>   
> -err_init_link:
> +err_deinit_pf_sw:

The renaming of the label could be mentioned in the commit message.

>   	ice_deinit_pf_sw(pf);
>   err_init_pf_sw:
>   	ice_dealloc_vsis(pf);
>   unroll_pf_init:


Kind regards,

Paul


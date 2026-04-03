Return-Path: <netdev+bounces-274944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJuJKVN+z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F73924A4
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D5230A125A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23253286D5D;
	Fri,  3 Apr 2026 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR8PIdc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAA1D6DB5
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205717; cv=none; b=SRshGLwiG2rem+Ov2vVSdiFt0cJEfzePLHDDyUu9cjj+IXI4nEAxpEZgf0p/TqdIfw+lCIDLNxdk1S8pXOEK/nydRsE0CR+4EyNQdk+RH1Buh3hKpc7o+zgVXCDU7HDBGCTsXKyaxKLHEpDlvRV6S3B+cisl7hgjHZ5FTMw98sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205717; c=relaxed/simple;
	bh=t4B5nxYfc/0Isd7sIgSmwbGveNKqQ2CZvNKcMjwldZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+1ID6FmZ+Ld5XcyYz1e/qV4fInU6ojcu+C6qU76cXoEt4b23gDLOLV3OYGrgsqesT5K7W+WDtzOnznaX5ah8nO+mYN2i/H4svLiw16cqtjdWYzD39Wxxyv8wh8VrtMBImMsKH9B3Jwwi1poYxvUuCRJPTBy+rcAKBzt/2gbAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR8PIdc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA4EC4CEF7;
	Fri,  3 Apr 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775205716;
	bh=t4B5nxYfc/0Isd7sIgSmwbGveNKqQ2CZvNKcMjwldZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aR8PIdc/0OYUWDHYLfzYOL7T+43v0LiELV1mJRUJFsno+S5We93x0eKxVC+dE5RJ9
	 6RCEI0GiY/CQTNm/+8p65OJ11f8XQSrVHotYNBrecnRFs/qYFHn2cGeYk4/2UBs50s
	 0Nc/ivsvphyiV7weLu/jnEQq3nMNqzXgE8cpkp1lB/QZN3zyv8h6k6WBoMesRkt91m
	 z9hGLuPKOw2/7hE9ybpcbt1yoq+PSc98aGQi2MERu1SOen9pgBIOP/toxfmwQFbA+1
	 kTiA1eTK9WvqcJOl57y63IkkyA71wjKttDSWyG5yk0bPffol8t/GUAhs3LzvcLcxc3
	 oz44ZXBfHjY2A==
Date: Fri, 3 Apr 2026 09:41:53 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: fix integer overflow and wrong bit
 position in ixgbe_validate_rtr()
Message-ID: <20260403084153.GA18306@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-10-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-10-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274944-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 005F73924A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:44AM +0100, Aleksandr Loktionov wrote:
> Two bugs in the same loop in ixgbe_validate_rtr():

If these are bugs then they should have a Fixes tag.
If there is more than one bug, possibly split into two patches.
And if these are present in net, then probably they are iwl-net material.

OTOH, if they are not bugs, then please don't describe them as such.

> 
> 1. When extracting 3-bit traffic class values from the IXGBE_RTRUP2TC
>    register the shifted value was assigned directly to a u8, silently
>    truncating any bits above bit 7.  Mask with IXGBE_RTRUP2TC_UP_MASK
>    before the assignment so only the intended 3 bits are kept.
> 
> 2. When clearing an out-of-bounds entry the mask was always shifted by
>    the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
>    which loop iteration was being processed.  This means only the entry
>    at bit position 3 was ever cleared; entries at bit positions 0, 6, 9,
>    ..., 21 were left unreset.  Use i * IXGBE_RTRUP2TC_UP_SHIFT to target
>    the correct field for each iteration.

This describes the effect at the register level.
But I think it would be useful to describe the effect that
users will experience.

> 
> Also replace the hardcoded 0x7 literal with the IXGBE_RTRUP2TC_UP_MASK
> constant for consistency with other parts of the driver.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This does seem ripe for use of FIELD_GET and FIELD_PREP.

But if these are bug fixes, then this minimalist approach looks good to me.


> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 9aec66c..53b82a5 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9798,11 +9798,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
>  	rsave = reg;
>  
>  	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
> -		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
> +		u8 up2tc = IXGBE_RTRUP2TC_UP_MASK &
> +			   (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT));
>  
>  		/* If up2tc is out of bounds default to zero */
>  		if (up2tc > tc)
> -			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
> +			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
>  	}
>  
>  	if (reg != rsave)
> -- 
> 2.52.0
> 


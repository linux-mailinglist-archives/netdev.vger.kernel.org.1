Return-Path: <netdev+bounces-268888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCw3Ji5IumkFTwIAu9opvQ
	(envelope-from <netdev+bounces-268888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:37:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A22B67C4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84F33039696
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0D364054;
	Wed, 18 Mar 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDKhSlRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB125C80E;
	Wed, 18 Mar 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815851; cv=none; b=AyYDZ7C/69Bdbb7tsyVCa5r/OQ5mrNGpAxewJ0jb8HA37pNUV8hPf6RQqMXn5W1Vn81YmMYxk9PkX/f7akehksJuv4trn5LVEFTfR1VVBodccvDcd2e2RQoJoT53o3pBEeIkRCJlKTxQSfgvjBVkPgP6NsrEw1KSgVNteevUjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815851; c=relaxed/simple;
	bh=MmY12uRNDdhfGh7T/XYLMYSoZmpnUMejZkZjvuvpHRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmuq8w/FCI18FaWCS8/gopnMnikdTJ11bPpV1Z3O36lAwJz9RYGdIJ8G3e6uA0sEuR9vbzy5oYoBoB9pDhl9R6uEwSH3JO/rjHjHDaRQmJqciljPE1LloEEj8ZJcZ+ALaEMzTrJi4ytf0qvAlmIvNVjjIoAYUiHR2n9qjbsewrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDKhSlRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6937C19421;
	Wed, 18 Mar 2026 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773815851;
	bh=MmY12uRNDdhfGh7T/XYLMYSoZmpnUMejZkZjvuvpHRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yDKhSlRRPuRXcV2Imh7yPJa4eoRUif2NWvEvAr89riGfEopv7LrWSiSdg6kKGHYeS
	 O9MxU+45mwTKBoSFz/D+Cb9YorEH+XmCoygXU8bq27scrEclBOk+//aEUYZKdSi3Od
	 MEhu3AD96RBuEzd9MADNNXn/I8iLwbVoxLyoXFCo=
Date: Wed, 18 Mar 2026 07:37:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Omer Zalman <omerzalman42@gmail.com>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: usb: cdc_ncm: prevent silent u16 truncation in
 min_tx_pkt_store()
Message-ID: <2026031801-skiing-decade-eccd@gregkh>
References: <20260318040632.69531-1-omerzalman42@gmail.com>
 <20260318040632.69531-2-omerzalman42@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318040632.69531-2-omerzalman42@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268888-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 128A22B67C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:06:32PM -0500, Omer Zalman wrote:
> min_tx_pkt is a u16 field but the sysfs store handler accepted any
> unsigned long and assigned it directly. Values that do not fit in 16
> bits silently truncate: writing 65537 wraps to 1, turning a
> "never pad" intent into "always pad".
> 
> ctx->tx_max can itself reach 65537 because cdc_ncm_update_rxtx_max()
> increments the negotiated NTB size by one pad byte when it is an exact
> multiple of the USB maxpacket size.
> 
> Clamp the stored value to min(tx_max, U16_MAX). Any value above tx_max
> is already semantically equivalent to tx_max since frame lengths never
> exceed it; the U16_MAX cap ensures the result is always representable
> in the u16 field without wrapping.
> 
> Fixes: 39eb7e0e8c88 ("net: cdc_ncm: allow tuning min_tx_pkt")
> Signed-off-by: Omer Zalman <omerzalman42@gmail.com>
> ---
>  drivers/net/usb/cdc_ncm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 6fcb4d711a64..edd69f4e1596 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -242,11 +242,17 @@ static ssize_t min_tx_pkt_store(struct device *d,
>  	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
>  	unsigned long val;
>  
> -	/* no need to restrict values - anything from 0 to infinity is OK */
>  	if (kstrtoul(buf, 0, &val))
>  		return -EINVAL;
>  
> -	ctx->min_tx_pkt = val;
> +	/* Clamp to tx_max: the frame length can never exceed tx_max,
> +	 * so any threshold above it has the same effect (padding is
> +	 * never applied).  Also cap at U16_MAX since min_tx_pkt is
> +	 * a u16 - without this, values like 65537 silently wrap to 1
> +	 * and invert the intended behavior.
> +	 */
> +	ctx->min_tx_pkt = min_t(unsigned long, val,
> +				min_t(u32, ctx->tx_max, U16_MAX));
>  	return len;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


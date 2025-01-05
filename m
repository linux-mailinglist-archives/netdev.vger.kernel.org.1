Return-Path: <netdev+bounces-155255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3DA01877
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C23162437
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3613B58F;
	Sun,  5 Jan 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZ0dw23x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33212C7FD;
	Sun,  5 Jan 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736063195; cv=none; b=grDSnwRHFNk5kxaNB+Vi8yG8niOuVCytQSbyJJ9rVIB6fsf6vlt7tx2cZ4avh+bJkH6nkYQSFj8Z8KP5m2/OeMoOAbVmrSz+7prGuWiMiMLH1Ai2xcKHuT1fbpF5PBbWWhJ0JBQ6oO241Kg9Du+ttZ6jwObN52/QNC1b9sPG4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736063195; c=relaxed/simple;
	bh=D1wFwP/UROoNd1oDipEXKquppTZHgzzy3okomZEcXTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt6xjaoWrzXbRCZCxFCwmOOfFJVmDo6BIPjRWYCa340XS28xq4Q1x41Uu2YI5aVFGLkhBdRprSYfHrzM6bIpogv6uHf0/Y9dGV/tDRYeUJnrNxpykJ5RVUSPQQq0IMOfc5+dENFcQXgiRc04csZ9k/BfUqlEABysztpUkN6jojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZ0dw23x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA263C4CED0;
	Sun,  5 Jan 2025 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736063194;
	bh=D1wFwP/UROoNd1oDipEXKquppTZHgzzy3okomZEcXTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZ0dw23xz7R99qL5HQG2SMx6qeDTd++8JRSfizevhwPtMS0CT8oN2X+j28g3YgLMF
	 /UG0931Fw5wzbEx+bslgT3gK4tq4UTNtGUdvnlZN+nuMooFCsUIGbXm1szvgxVws04
	 WjsWWXS7hS7byQguRj7nuCFDlDN/ijoblkpjuDb0=
Date: Sun, 5 Jan 2025 08:46:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v4 4/7] usbnet: ipheth: use static NDP16 location in
 URB
Message-ID: <2025010521-pronto-coastland-1ac0@gregkh>
References: <20250105010121.12546-1-forst@pen.gy>
 <20250105010121.12546-5-forst@pen.gy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105010121.12546-5-forst@pen.gy>

On Sun, Jan 05, 2025 at 02:01:18AM +0100, Foster Snowhill wrote:
> Original code allowed for the start of NDP16 to be anywhere within the
> URB based on the `wNdpIndex` value in NTH16. Only the start position of
> NDP16 was checked, so it was possible for even the fixed-length part
> of NDP16 to extend past the end of URB, leading to an out-of-bounds
> read.
> 
> On iOS devices, the NDP16 header always directly follows NTH16. Rely on
> and check for this specific format.
> 
> This, along with NCM-specific minimal URB length check that already
> exists, will ensure that the fixed-length part of NDP16 plus a set
> amount of DPEs fit within the URB.
> 
> Note that this commit alone does not fully address the OoB read.
> The limit on the amount of DPEs needs to be enforced separately.
> 
> Fixes: a2d274c62e44 ("usbnet: ipheth: add CDC NCM support")
> Signed-off-by: Foster Snowhill <forst@pen.gy>
> ---
> v4:
>     Additionally check that ncmh->wNdpIndex points immediately after
>     NTH16. This covers an unexpected on real devices, and highly
>     unlikely otherwise, case where the bytes after NTH16 are set to
>     `USB_CDC_NCM_NDP16_NOCRC_SIGN`, yet aren't the beginning of the
>     NDP16 header.
> v3: https://lore.kernel.org/netdev/20241123235432.821220-4-forst@pen.gy/
>     Split out from a monolithic patch in v2 as an atomic change.
> v2: https://lore.kernel.org/netdev/20240912211817.1707844-1-forst@pen.gy/
>     No code changes. Update commit message to further clarify that
>     `ipheth` is not and does not aim to be a complete or spec-compliant
>     CDC NCM implementation.
> v1: https://lore.kernel.org/netdev/20240907230108.978355-1-forst@pen.gy/
> ---
>  drivers/net/usb/ipheth.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
> index 48c79e69bb7b..35f507db2c4a 100644
> --- a/drivers/net/usb/ipheth.c
> +++ b/drivers/net/usb/ipheth.c
> @@ -237,15 +237,14 @@ static int ipheth_rcvbulk_callback_ncm(struct urb *urb)
>  
>  	ncmh = urb->transfer_buffer;
>  	if (ncmh->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH16_SIGN) ||
> -	    le16_to_cpu(ncmh->wNdpIndex) >= urb->actual_length) {
> +	    /* On iOS, NDP16 directly follows NTH16 */
> +	    ncmh->wNdpIndex != cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16))) {
>  		dev->net->stats.rx_errors++;
>  		return retval;
>  	}
>  
> -	ncm0 = urb->transfer_buffer + le16_to_cpu(ncmh->wNdpIndex);
> -	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN) ||
> -	    le16_to_cpu(ncmh->wHeaderLength) + le16_to_cpu(ncm0->wLength) >=
> -	    urb->actual_length) {
> +	ncm0 = urb->transfer_buffer + sizeof(struct usb_cdc_ncm_nth16);
> +	if (ncm0->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
>  		dev->net->stats.rx_errors++;
>  		return retval;
>  	}
> -- 
> 2.45.1
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


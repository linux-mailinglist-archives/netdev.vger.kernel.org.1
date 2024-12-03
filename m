Return-Path: <netdev+bounces-148579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734EF9E2A81
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165DEB42175
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A02D1F8F1D;
	Tue,  3 Dec 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cw+tBO6K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B81FA27C;
	Tue,  3 Dec 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240056; cv=none; b=JE0aeA/D50a9gyLOipOT+Wial1t8O3HadrQNwZnvqFYl6VOvUyu9JMTM0z5N4xA/O23CdVZXDlOLPuUbyrF73vL05ff0GAgkpL3WeM0FlFNgwut37hsxtYREmDbF+fPbxLjPAlGYM7j9G5nRVqNGxRq6XvUdLAZRob15+p912/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240056; c=relaxed/simple;
	bh=JkY+5fOV9qIOnxsCxpI9LuFE3gW4OY/AYWWLkZk6dT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyGhDYywNgXcVhXiT9iaRIflXP3wrP0nbu/Xs+5gveU+cILHl7BJe8VrxCw6BT0Ed6SsyxZPp2N03gKtGP0YldXovpdorKtO+jl/4pJyVLISHpptUOPCZx8jnSigo+hoE57ZiqW8XDQk79cr4QKVU65DGtu736YHGzzC/qrMEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cw+tBO6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B548C4CED6;
	Tue,  3 Dec 2024 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240056;
	bh=JkY+5fOV9qIOnxsCxpI9LuFE3gW4OY/AYWWLkZk6dT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cw+tBO6K4ei6BBayeOiLRkFW07O1fa5MF9AkitxqR9pP9zKAp7HWJ+ED/tGNWCHw6
	 sCR+Dup7q6Bl/5guOfooulr0VAkud+sL2WAlfgORxiVnDmAyoyhgj4uN5xBUsM8d+y
	 E8V65kOlexnY0r23jyd5Np5jk1x3b/wAxwJ/ZjuM=
Date: Tue, 3 Dec 2024 15:48:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <2024120357-vertebrae-squatted-f670@gregkh>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203130457.904325-1-asmadeus@codewreck.org>

On Tue, Dec 03, 2024 at 10:04:55PM +0900, Dominique Martinet wrote:
> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> 
> The previous commit assumed that local addresses always came from the
> kernel, but some devices hand out local mac addresses so we ended up
> with point-to-point devices with a mac set by the driver, renaming to
> eth%d when they used to be named usb%d.
> 
> Userspace should not rely on device name, but for the sake of stability
> restore the local mac address check portion of the naming exception:
> point to point devices which either have no mac set by the driver or
> have a local mac handed out by the driver will keep the usb%d name.
> 
> Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>  drivers/net/usb/usbnet.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 44179f4e807f..d044dc7b7622 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
>  }
>  EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
>  
> +static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
> +{
> +	/* Point to point devices which don't have a real MAC address
> +	 * (or report a fake local one) have historically used the usb%d
> +	 * naming. Preserve this..
> +	 */
> +	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
> +		(is_zero_ether_addr(net->dev_addr) ||
> +		 is_local_ether_addr(net->dev_addr));
> +}
> +
>  static void intr_complete (struct urb *urb)
>  {
>  	struct usbnet	*dev = urb->context;
> @@ -1762,13 +1773,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		if (status < 0)
>  			goto out1;
>  
> -		// heuristic:  "usb%d" for links we know are two-host,
> -		// else "eth%d" when there's reasonable doubt.  userspace
> -		// can rename the link if it knows better.
> +		/* heuristic: rename to "eth%d" if we are not sure this link
> +		 * is two-host (these links keep "usb%d") */
>  		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
> -		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> -		     /* somebody touched it*/
> -		     !is_zero_ether_addr(net->dev_addr)))
> +		    !usbnet_needs_usb_name_format(dev, net))
>  			strscpy(net->name, "eth%d", sizeof(net->name));
>  		/* WLAN devices should always be named "wlan%d" */
>  		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
> -- 
> 2.47.0
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


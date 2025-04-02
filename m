Return-Path: <netdev+bounces-178736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A9A7898D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E24116F25B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255F23373E;
	Wed,  2 Apr 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9TICkSl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429923371F;
	Wed,  2 Apr 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581581; cv=none; b=pLY0w9YVwXVg3WX7f5HHXu5IeNMXuP2bn38p/dH2Vlc6yXO3GqRYWhAoDmKJB1PFxse46EwbLRPL5t7xG8E9eq2UUs3RyS5w9qsCFQu6/dhFf8hbL8mKcZKnIDLR07J8KbeFFKkfStt3txUwab5/yioZKHzflxlHCzNX+QkQCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581581; c=relaxed/simple;
	bh=Lyya/ZVyn5QzEBxnwriP42fEj//LfFO2/h8nHMyeiyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV5GwK0Wi87xKGK5lG2g4LX1isZOFJdQmhrVcChE5BoNGd0ssGIKI4n39uF8Aht+7rK2pRdacDO2b0XdUcAkK0ePbNx49syE5gFZgRsgPhkH/x36Dx5nLxE5Pgw0lMStsEnLgplDK3Z665vZbCa/ZaZBhlZ3vsC1FjCObWVJQkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9TICkSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA1AC4CEDD;
	Wed,  2 Apr 2025 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743581580;
	bh=Lyya/ZVyn5QzEBxnwriP42fEj//LfFO2/h8nHMyeiyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9TICkSlZ2eKvRQS+knKIop8M/MS6Q4dv1+j/VEHKLpqz8EK5WRuDnZrQFuW9db+T
	 DMyJVPx/Brg3RjeDtgpq6RpLQKNBhK/oU3ZAC8fXXjpbHFrk809/W6c4ShxaOmKyPf
	 VvouVoHFlat8fgMotqnKHEczfwJfURxeDut4qx/E=
Date: Wed, 2 Apr 2025 09:11:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ying Lu <luying526@gmail.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ying Lu <luying1@xiaomi.com>
Subject: Re: [PATCH v3 1/1] usbnet:fix NPE during rx_complete
Message-ID: <2025040218-uphill-mouth-c528@gregkh>
References: <cover.1743580881.git.luying1@xiaomi.com>
 <11211b6967816ce4eac2ff5341d78b09de4f6747.1743580881.git.luying1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11211b6967816ce4eac2ff5341d78b09de4f6747.1743580881.git.luying1@xiaomi.com>

On Wed, Apr 02, 2025 at 04:06:29PM +0800, Ying Lu wrote:
> From: Ying Lu <luying1@xiaomi.com>
> 
> Missing usbnet_going_away Check in Critical Path.
> The usb_submit_urb function lacks a usbnet_going_away
> validation, whereas __usbnet_queue_skb includes this check.
> 
> This inconsistency creates a race condition where:
> A URB request may succeed, but the corresponding SKB data
> fails to be queued.
> 
> Subsequent processes:
> (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
> attempt to access skb->next, triggering a NULL pointer
> dereference (Kernel Panic).
> 
> Fixes: 04e906839a05 ("usbnet: fix cyclical race on disconnect with work queue")
> Signed-off-by: Ying Lu <luying1@xiaomi.com>
> ---
>  drivers/net/usb/usbnet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 44179f4e807f..5161bb5d824b 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -519,7 +519,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
>  	    netif_device_present (dev->net) &&
>  	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
>  	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
> -	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags)) {
> +	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
> +	    !usbnet_going_away(dev)) {
>  		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
>  		case -EPIPE:
>  			usbnet_defer_kevent (dev, EVENT_RX_HALT);
> @@ -540,8 +541,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
>  			tasklet_schedule (&dev->bh);
>  			break;
>  		case 0:
> -			if (!usbnet_going_away(dev))
> -				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
> +			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
>  		}
>  	} else {
>  		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
> -- 
> 2.49.0
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


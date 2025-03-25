Return-Path: <netdev+bounces-177321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCCEA6F050
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0053A9990
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDB254B1B;
	Tue, 25 Mar 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIUEg0XD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70597A937;
	Tue, 25 Mar 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901281; cv=none; b=unEUzEMC7HB8dAnRuEdYB6tiy89shcCTO79s9a+Zi9BdtyevujY3uoL7fWI1GRMcCrqha3JmSfjY2c7uCDc9/gdoQDU+Rkvrq5VyU43dcjgRM4pqNclRDkUNL0FdV1v26HIy4PJOyhm8tNthPhonrgl6Whg9AwH1E0cPAhZhoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901281; c=relaxed/simple;
	bh=N7nNpkGG93O1d4OuWsSH/Z9bDtptyVB0AGTzGeZOesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txCX62/psfhLL3qnkgXDm2zVrpVwVQccdzuzMhrKhjLMwpfykE4zedkckta8c32KcTYPeQh5xX7fOPbpZ94yZ9fSjZTH1qZcqhLX1H0fBHX3TCy5ispwN5eLs0w4FjroGPvJzcs5PuubF2qd33SO15Erruul0+FLf4z3Rxc4WAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIUEg0XD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E64DC4CEE4;
	Tue, 25 Mar 2025 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742901280;
	bh=N7nNpkGG93O1d4OuWsSH/Z9bDtptyVB0AGTzGeZOesE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zIUEg0XDvxh/kBD441/02kLatp7dQAtVOeiZaXVE6t8nmnadP1ReVBkoW35co3uF8
	 qmWjVf6kcyiWA6jJTRalli8eyK983xMYsKg9tw0sSDN6gafp6q7eIBbNbfNAN9NbjK
	 pEvEeBINzafqONQpZB40cDQewTeK+jabUl5AgMKQ=
Date: Tue, 25 Mar 2025 07:13:18 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-usb@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net-next] rndis_host: Flag RNDIS modems as WWAN devices
Message-ID: <2025032559-dispersal-humvee-bdfb@gregkh>
References: <20250325095842.1567999-1-lkundrak@v3.sk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325095842.1567999-1-lkundrak@v3.sk>

On Tue, Mar 25, 2025 at 10:58:41AM +0100, Lubomir Rintel wrote:
> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
> Broadband Modems, as opposed to regular Ethernet adapters.
> 
> Otherwise NetworkManager gets confused, misjudges the device type,
> and wouldn't know it should connect a modem to get the device to work.
> What would be the result depends on ModemManager version -- older
> ModemManager would end up disconnecting a device after an unsuccessful
> probe attempt (if it connected without needing to unlock a SIM), while
> a newer one might spawn a separate PPP connection over a tty interface
> instead, resulting in a general confusion and no end of chaos.
> 
> The only way to get this work reliably is to fix the device type
> and have good enough version ModemManager (or equivalent).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Fixes: 63ba395cd7a5 ("rndis_host: support Novatel Verizon USB730L")
> 
> ---
> Changes since v1:
> * Added Fixes tag, as suggested by Paolo Abeni
> 
> Changes since v2:
> * Fixed Fixes tag... Suggested by Jakub Kicinski
> 
> ---
>  drivers/net/usb/rndis_host.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
> index 7b3739b29c8f7..bb0bf14158727 100644
> --- a/drivers/net/usb/rndis_host.c
> +++ b/drivers/net/usb/rndis_host.c
> @@ -630,6 +630,16 @@ static const struct driver_info	zte_rndis_info = {
>  	.tx_fixup =	rndis_tx_fixup,
>  };
>  
> +static const struct driver_info	wwan_rndis_info = {
> +	.description =	"Mobile Broadband RNDIS device",
> +	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
> +	.bind =		rndis_bind,
> +	.unbind =	rndis_unbind,
> +	.status =	rndis_status,
> +	.rx_fixup =	rndis_rx_fixup,
> +	.tx_fixup =	rndis_tx_fixup,
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct usb_device_id	products [] = {
> @@ -666,9 +676,11 @@ static const struct usb_device_id	products [] = {
>  	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
>  	.driver_info = (unsigned long) &rndis_info,
>  }, {
> -	/* Novatel Verizon USB730L */
> +	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
> +	 * Telit FN990A (RNDIS)
> +	 */
>  	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
> -	.driver_info = (unsigned long) &rndis_info,
> +	.driver_info = (unsigned long)&wwan_rndis_info,
>  },
>  	{ },		// END
>  };
> -- 
> 2.48.1
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


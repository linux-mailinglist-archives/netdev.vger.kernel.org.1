Return-Path: <netdev+bounces-228349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F4CBC8618
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2416A4E2FC0
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BF2D6E58;
	Thu,  9 Oct 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2JtDQ8l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8934BA49;
	Thu,  9 Oct 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003676; cv=none; b=cP847d0EtYVIMai4jqxb6VQwHs7Dmf9m843oxGjS6pmlDZa8IQrqMnUX2kqWL0wRynPOPJqfrwtr/E46WfoJtVqP3/EDAsDgquNdVLQsK5y18MheGjxNfBrh/FHK6ggqnx1GjlkrA+tEWA8yLR0GgGohKsqD+/VFlTyE5XrsrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003676; c=relaxed/simple;
	bh=1r8ZrXO6FZCz8lgLSeUUy6k+MSy8tL1yra+LYnXAQEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNfqdAkbgaY7zARL/Y7Fc7x5EJ5sF4fzHxhFBuLRWKBiyupjgxofCSand+Y7+8ruGaSuL5NSTqXeMu1SOgArOylxmCJnTV1BVpo56KE+t6MxMTuN8h+EOxFL3f9p0vqdtUUauDpOV63ZEF3XXPheRMkq2Wt48F1qWp3YQLEL+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2JtDQ8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B63C4CEE7;
	Thu,  9 Oct 2025 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760003675;
	bh=1r8ZrXO6FZCz8lgLSeUUy6k+MSy8tL1yra+LYnXAQEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2JtDQ8lS0g6y2LyZvcXdP+aSqSDrYfEmJD2E+tbAkwWkdznNjO66fWTfJqNGaXDy
	 Nad4VTMiSn9uhvC14ZqV0cM/YrJCipNFjKmTG+H80/BXeKAPAWfrs5L0XMWBnOkHpy
	 U+XZZSNDcQtPgiwyWlkdimPQKRy/hn/YFmln9Tg4=
Date: Thu, 9 Oct 2025 11:54:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	oneukum@suse.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH] net: usb: r8152: add error handling in
 rtl8152_driver_init
Message-ID: <2025100920-savanna-relatable-49ca@gregkh>
References: <20251009075833.103523-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075833.103523-1-yicongsrfy@163.com>

On Thu, Oct 09, 2025 at 03:58:33PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> rtl8152_driver_init missing error handling.
> If cannot register rtl8152_driver, rtl8152_cfgselector_driver
> should be deregistered.
> 
> Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/usb/r8152.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 44cba7acfe7d..a64bcb744fad 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10122,7 +10122,14 @@ static int __init rtl8152_driver_init(void)
>  	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
>  	if (ret)
>  		return ret;
> -	return usb_register(&rtl8152_driver);
> +
> +	ret = usb_register(&rtl8152_driver);
> +	if (ret) {
> +		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static void __exit rtl8152_driver_exit(void)
> -- 
> 2.25.1
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


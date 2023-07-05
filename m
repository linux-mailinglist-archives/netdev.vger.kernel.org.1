Return-Path: <netdev+bounces-15476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43D747E09
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBFC280F40
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6907137F;
	Wed,  5 Jul 2023 07:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C7ECF
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 07:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF19C433C7;
	Wed,  5 Jul 2023 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688541399;
	bh=rgJSmdWf7HZndKl2mOS2c4ZW2ja00reA75bqebA5N5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vH+XQSRQRzQ2GruZofvDvB4wgPWzbq6KDZ60x9IF+TdMAc72KsVQMSdd/J5vlrpLb
	 koKIOuYzR3rCPYvAXnswBrN17pKIOo03fken9BO2EQ/JvLf4X0gRgXQVUSB7GLsU53
	 3ZAZ2uRbwy1sF6S2nG20gedZB0BY9j9JWT2/hYko=
Date: Wed, 5 Jul 2023 08:16:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Hao <yhao016@ucr.edu>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: Fix possible uninit bug
Message-ID: <2023070522-stubbly-monthly-3fb1@gregkh>
References: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>

On Tue, Jul 04, 2023 at 06:15:09PM -0700, Yu Hao wrote:
> The variable buf should be initialized in the function lan78xx_read_reg.
> However, there is no return value check, which means the variable buf
> could still be uninit. But there is a read later.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/net/usb/lan78xx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c458c030fadf..4c9318c92fe6 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1091,8 +1091,11 @@ static int lan78xx_write_raw_otp(struct
> lan78xx_net *dev, u32 offset,
>     int i;
>     u32 buf;
>     unsigned long timeout;
> +   int ret;
> 
> -   lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
> +   ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
> +   if (ret < 0)
> +       return ret;
> 
>     if (buf & OTP_PWR_DN_PWRDN_N_) {
>         /* clear it and wait to be cleared */
> -- 
> 2.34.1

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


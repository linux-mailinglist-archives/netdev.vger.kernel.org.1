Return-Path: <netdev+bounces-18603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72988757D7C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32339281117
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B28DD306;
	Tue, 18 Jul 2023 13:28:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966DD50B
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 13:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7490C433C7;
	Tue, 18 Jul 2023 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689686905;
	bh=IfFSl5miGLKpU9JXTSuFV2QgCkNHFc9sfpnTtl033W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqD/Wnuj2EA3n7pncpARw/ceC8y0Td/v4T33XE3wJFp7AFE82WF+XRcrC7HLkQ4w8
	 RDGUiQqjoBI9ysrkSOwYTOlbgl7liq3K1ceqfy0hchsK8G/m862P+hNPQNCu2WYouv
	 lWq1GUzhAsF2jYZdv6FJf1a8zqqHv7lzkYrssxC0=
Date: Tue, 18 Jul 2023 15:28:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ross Maynard <bids.7405@bigpond.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] USB: zaurus: 3 broken Zaurus devices
Message-ID: <2023071846-salvation-frosting-e345@gregkh>
References: <4963f4df-e36d-94e2-a045-48469ab2a892@bigpond.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4963f4df-e36d-94e2-a045-48469ab2a892@bigpond.com>

On Tue, Jul 18, 2023 at 10:16:55AM +1000, Ross Maynard wrote:
> Hi Greg,
> 
> This is related to Oliver Neukum's patch
> 6605cc67ca18b9d583eb96e18a20f5f4e726103c (USB: zaurus: support another
> broken Zaurus) which you committed in 2022 to fix broken support for the
> Zaurus SL-6000.
> 
> Prior to that I had been able to track down the original offending patch
> using git bisect as you had suggested to me:
> 16adf5d07987d93675945f3cecf0e33706566005 (usbnet: Remove over-broad module
> alias from zaurus).
> 
> It turns out that the offending patch also broke support for 3 other Zaurus
> models: A300, C700 and B500/SL-5600. My patch adds the 3 device IDs to the
> driver in the same way Oliver added the SL-6000 ID in his patch.
> 
> Could you please review the attached patch? I tested it on all 3 devices and
> it fixed the problem. For your reference, the associated bug URL is
> https://bugzilla.kernel.org/show_bug.cgi?id=217632.
> 
> Thank you.
> 
> Regards,
> 
> Ross
> 

> Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
> Reported-by: Ross Maynard <bids.7405@bigpond.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
> ---
>  drivers/net/usb/cdc_ether.c | 21 +++++++++++++++++++++
>  drivers/net/usb/zaurus.c    | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> --- a/drivers/net/usb/cdc_ether.c
> +++ b/drivers/net/usb/cdc_ether.c
> @@ -616,6 +616,13 @@ static const struct usb_device_id	products[] = {
>  }, {
>  	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
>  			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8005,   /* A-300 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info        = 0,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
>  	.idVendor		= 0x04DD,
>  	.idProduct		= 0x8006,	/* B-500/SL-5600 */
>  	ZAURUS_MASTER_INTERFACE,
> @@ -623,12 +630,26 @@ static const struct usb_device_id	products[] = {
>  }, {
>  	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
>  			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8006,   /* B-500/SL-5600 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info        = 0,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
>  	.idVendor		= 0x04DD,
>  	.idProduct		= 0x8007,	/* C-700 */
>  	ZAURUS_MASTER_INTERFACE,
>  	.driver_info		= 0,
>  }, {
>  	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8007,   /* C-700 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info        = 0,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
>  		 | USB_DEVICE_ID_MATCH_DEVICE,
>  	.idVendor               = 0x04DD,
>  	.idProduct              = 0x9031,	/* C-750 C-760 */
> --- a/drivers/net/usb/zaurus.c
> +++ b/drivers/net/usb/zaurus.c
> @@ -289,9 +289,23 @@ static const struct usb_device_id	products [] = {
>  	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
>  			  | USB_DEVICE_ID_MATCH_DEVICE,
>  	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8005,	/* A-300 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info = (unsigned long)&bogus_mdlm_info,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
>  	.idProduct		= 0x8006,	/* B-500/SL-5600 */
>  	ZAURUS_MASTER_INTERFACE,
>  	.driver_info = ZAURUS_PXA_INFO,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8006,	/* B-500/SL-5600 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info = (unsigned long)&bogus_mdlm_info,
>  }, {
>  	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
>  	          | USB_DEVICE_ID_MATCH_DEVICE,
> @@ -301,6 +315,13 @@ static const struct usb_device_id	products [] = {
>  	.driver_info = ZAURUS_PXA_INFO,
>  }, {
>  	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
> +			  | USB_DEVICE_ID_MATCH_DEVICE,
> +	.idVendor		= 0x04DD,
> +	.idProduct		= 0x8007,	/* C-700 */
> +	ZAURUS_FAKE_INTERFACE,
> +	.driver_info = (unsigned long)&bogus_mdlm_info,
> +}, {
> +	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
>  		 | USB_DEVICE_ID_MATCH_DEVICE,
>  	.idVendor               = 0x04DD,
>  	.idProduct              = 0x9031,	/* C-750 C-760 */
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


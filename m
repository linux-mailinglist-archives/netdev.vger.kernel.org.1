Return-Path: <netdev+bounces-48480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0A7EE879
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533C11C2087E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484734644F;
	Thu, 16 Nov 2023 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7OxJWrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A45D49
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:48:57 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso672210fac.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700167737; x=1700772537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyLQeO6ktRRdjm4NCHxaev8frUkZMSxDVHmBr9qSRS8=;
        b=H7OxJWrCR2UmstSBTZPHaS9Et/r/NMPsX5lHlJ7Lf9d9HEQFi7yPhtPvNM4ug1NDsd
         0GhrEe71HbDGnI+TXRv19ps1982cLbZr+OMYUHGbOsJYqADg12JcL3bbzRy7NFbD+NTw
         omh1TEYIKFssDqT/vpFYz40+VZed1F1tFf644Lg7VchqGQvek9jDXolyvybQtk0BxMAR
         0+ouMsq1Vkm4Z4i+l5vKNoWevBz1ljppLL0sLJ4NhHewBgIxP6bidw51nYb/iwRfOyvG
         uy3nluUoz3BfPbB6vqcxtSNJqpmBsOWtS90QdcnnuxrfrnZrnRUbcM3gTaNugR7HDeRz
         a1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700167737; x=1700772537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyLQeO6ktRRdjm4NCHxaev8frUkZMSxDVHmBr9qSRS8=;
        b=N0YgZJxZu2RNYbcHNs+J1HYw288w6t63AW7f0U4GZ/2zB1NFDJRGDYng30ffz6TJeR
         s9lghKdHsNBTSwC77m/R2OlNcU412LVLMGrtMEQm+DMi9ngDqIpNO+hmZWeihUGlABIn
         pKbbwHCXfUpZDjTCJQAQi+3PeBhsq/Y+SbDjKtUug6/Y3VrpWKP/thxfj0am8ZO7FZcp
         rLDRQ+Acs+lQZrwioK16cIKa0JF5UF/WQofI2ZmhlPSy+0rIEmtzvGtFfus4jMPhC7PM
         4dVwTv+RGXhlYjhZOIHrTR8UO4Ool8ZLK0FeqdUyq1alfZzQynk/MAjgOn7Rrc6x3/V6
         ybNA==
X-Gm-Message-State: AOJu0YyvwXTNv9wbXFM+PLacA4X4RvHPSK93j32piBZennGWO6IkfYJV
	ekf88D+X0tgti3bom5U7GI6prKaL3AY=
X-Google-Smtp-Source: AGHT+IGL9wnzljRWGtHFd+lnhMgIT3eoZCwIxN8dEi64LBwjwj5NJFPseFA6/hleWoHVVzjBdxrtYw==
X-Received: by 2002:a05:6870:1d07:b0:1f0:3259:3ec0 with SMTP id pa7-20020a0568701d0700b001f032593ec0mr20379960oab.54.1700167736980;
        Thu, 16 Nov 2023 12:48:56 -0800 (PST)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id q14-20020ae9e40e000000b0077407e3d68asm80128qkc.111.2023.11.16.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:48:56 -0800 (PST)
Date: Thu, 16 Nov 2023 15:48:55 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: bjorn@mork.no, netdev@vger.kernel.org
Subject: Re: [RFC] usbnet: assign unique random MAC
Message-ID: <ZVaAN28EeKJeMKPJ@d3>
References: <20231116140616.4848-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116140616.4848-1-oneukum@suse.com>

On 2023-11-16 15:05 +0100, Oliver Neukum wrote:
> The old method had the bug of issuing the same
> random MAC over and over even to every device.
> This bug is as old as the driver.
> 
> This new method generates each device whose minidriver
> does not provide its own MAC its own unique random
> MAC.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 2d14b0d78541..37e3bb2170bc 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -61,9 +61,6 @@
>  
>  /*-------------------------------------------------------------------------*/
>  
> -// randomly generated ethernet address
> -static u8	node_id [ETH_ALEN];
> -
>  /* use ethtool to change the level for any given device */
>  static int msg_level = -1;
>  module_param (msg_level, int, 0);
> @@ -1731,7 +1728,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  
>  	dev->net = net;
>  	strscpy(net->name, "usb%d", sizeof(net->name));
> -	eth_hw_addr_set(net, node_id);
>  
>  	/* rx and tx sides can use different message sizes;
>  	 * bind() should set rx_urb_size in that case.
> @@ -1805,9 +1801,13 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
>  		goto out4;
>  	}
>  
> -	/* let userspace know we have a random address */
> -	if (ether_addr_equal(net->dev_addr, node_id))
> -		net->addr_assign_type = NET_ADDR_RANDOM;
> +	/*
> +	 * if the device does not come with a MAC

The patch's formatting has some problems. Please run checkpatch before
resubmitting.

> +	 * we ask the network core to generate us one
> +	 * and flag the device accordingly
> +	 */
> +	if (!is_valid_ether_addr(net->dev_addr))
> +			eth_hw_addr_random(net);

Before initialization, dev_addr is null (00:00:00:00:00:00). Since this
patch moves the fallback address initialization after the 
	if (info->bind) {
block, if the bind() did not initialize the address, this patch changes
the result of the
		     (net->dev_addr [0] & 0x02) == 0))
test within the block, no? The test now takes place on an uninitialized
address and the result goes from false to true.


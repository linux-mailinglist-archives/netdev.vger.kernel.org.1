Return-Path: <netdev+bounces-218493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFEB3CA4C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D04566EFE
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FD26980B;
	Sat, 30 Aug 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+pYRvpK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C423D2B2;
	Sat, 30 Aug 2025 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756551193; cv=none; b=NUdJMpXUQPlGfzTUHjaJ6LeNX12DcfOZVrkZv/QaUpFtbDruMAPaNVWZvyTTeJppRw8QBT3oTVHq282JG/baEm+a4+OwAtyadC9s4fqssfx5svO4+mB5rOik38v3BrQMUmSBk8stRzmGbq6Bj9aZ5S4Ci++TYPmYqDQR8Jj9g2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756551193; c=relaxed/simple;
	bh=6tj5SitoC1vZtWTu4pzefYAXr8XTw577Ykpl6aPWOvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4+3D663PD2hyruElKGWj7OfhSruCQeEIWmDM2sWDd1aUOt5UtjTs5/pCL+YTzNUuRB6ABRe4h9LyRAdP1vQGgK2vqhDXTDasqjmefFyy4n2je/dSA+WkyyRYnZngNxDx7toEvW7U6QlZrj0pVburXabNeQomh67udSE98raNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+pYRvpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9357AC4CEEB;
	Sat, 30 Aug 2025 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756551193;
	bh=6tj5SitoC1vZtWTu4pzefYAXr8XTw577Ykpl6aPWOvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+pYRvpKzsTu6o15jK2fsAJPwuEkT3sUmuwBc4S/FVggsu82i+pBPakOb7DkEOXRY
	 2gLVu+5txMrQxmLfMgcQ7Dm4xSrkgEKNmvVHDO4eP1sgQ7gkzvPFcWpEiDUfVqiDig
	 IImTuYJvrOaLCEzL+wTNIJU34mJQCMz+cTkM1h0E=
Date: Sat, 30 Aug 2025 12:53:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	David Hollis <dhollis@davehollis.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <david-b@pacbell.net>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: asix_devices: Check return value of
 usbnet_get_endpoints
Message-ID: <2025083031-lavender-rebel-ee20@gregkh>
References: <20250830103743.2118777-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830103743.2118777-1-linmq006@gmail.com>

On Sat, Aug 30, 2025 at 06:37:41PM +0800, Miaoqian Lin wrote:
> The code did not check the return value of usbnet_get_endpoints.
> Add checks and return the error if it fails to transfer the error.
> 
> Fixes: 933a27d39e0e ("USB: asix - Add AX88178 support and many other changes")
> Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/net/usb/asix_devices.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 9b0318fb50b5..92a5d6956cb3 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
>  	int i;
>  	unsigned long gpio_bits = dev->driver_info->data;
>  
> -	usbnet_get_endpoints(dev,intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		goto out;
>  
>  	/* Toggle the GPIOs in a manufacturer/model specific way */
>  	for (i = 2; i >= 0; i--) {
> @@ -832,7 +834,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
>  
>  	dev->driver_priv = priv;
>  
> -	usbnet_get_endpoints(dev, intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		return ret;
>  
>  	/* Maybe the boot loader passed the MAC address via device tree */
>  	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
> @@ -1256,7 +1260,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
>  	int ret;
>  	u8 buf[ETH_ALEN] = {0};
>  
> -	usbnet_get_endpoints(dev,intf);
> +	ret = usbnet_get_endpoints(dev, intf);
> +	if (ret)
> +		return ret;
>  
>  	/* Get the MAC address */
>  	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
> @@ -1609,4 +1615,3 @@ MODULE_AUTHOR("David Hollis");
>  MODULE_VERSION(DRIVER_VERSION);
>  MODULE_DESCRIPTION("ASIX AX8817X based USB 2.0 Ethernet Devices");
>  MODULE_LICENSE("GPL");
> -

Why did you remove this blank line?

Also, how was this tested?

And you forgot to add a cc: stable?

thanks,

greg k-h


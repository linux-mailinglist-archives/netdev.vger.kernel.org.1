Return-Path: <netdev+bounces-44216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FA7D71B6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B9B21250
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B3330CF3;
	Wed, 25 Oct 2023 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA6mwZfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61030CE5;
	Wed, 25 Oct 2023 16:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F4FC433C7;
	Wed, 25 Oct 2023 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698251311;
	bh=Cq+VIWjTxwk9AIHSxO+EKxI0YiYlA7eqMW6ugBM7bbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dA6mwZfv1lv8yN0h/VACi3UUkqoITwAQlD88QYHkYhcLJagVy2How3uwju0lVBOtd
	 s2c04ZEbd9PiuiyH51EtdlY/ibvi/oLPcABr8kUfYV//I4tQ92I/Su/bkz+VrpWQi4
	 pe4BlmFUm57IoHWFdl64cGzZZQEiRbHGuYSJ+erTGvbSKFkgeVCjrMIXTbeFOPulAo
	 ToyNag7vWJoQ3efNSJeXqbUrxNMpczuvDg7iotd159zo3ISF3b4VE3VCXHEhTPvFdK
	 5rwAylcIXfGddIf5pgaDr0deSYkyb2gZtWQ6KDcBpGUrWHpI/NWjCTvWa/wZwPcCsD
	 KHOkmoK8JPVaw==
Date: Wed, 25 Oct 2023 17:28:24 +0100
From: Simon Horman <horms@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Edward Hill <ecgh@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 8/8] r8152: Block future register access if register
 access fails
Message-ID: <20231025162824.GK57304@kernel.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>

On Fri, Oct 20, 2023 at 02:06:59PM -0700, Douglas Anderson wrote:

...

> @@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru(struct usb_device *udev)
>  	return 0;
>  }
>  
> -static int rtl8152_probe(struct usb_interface *intf,
> -			 const struct usb_device_id *id)
> +static int rtl8152_probe_once(struct usb_interface *intf,
> +			      const struct usb_device_id *id, u8 version)
>  {
>  	struct usb_device *udev = interface_to_usbdev(intf);
>  	struct r8152 *tp;
>  	struct net_device *netdev;
> -	u8 version;
>  	int ret;
>  
> -	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> -		return -ENODEV;
> -
> -	if (!rtl_check_vendor_ok(intf))
> -		return -ENODEV;
> -
> -	version = rtl8152_get_version(intf);
> -	if (version == RTL_VER_UNKNOWN)
> -		return -ENODEV;
> -
>  	usb_reset_device(udev);
>  	netdev = alloc_etherdev(sizeof(struct r8152));
>  	if (!netdev) {
> @@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *intf,
>  	else
>  		device_set_wakeup_enable(&udev->dev, false);
>  
> +	/* If we saw a control transfer error while probing then we may
> +	 * want to try probe() again. Consider this an error.
> +	 */
> +	if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> +		goto out2;

Sorry for being a bit slow here, but if this is an error condition,
sould ret be set to an error value?

As flagged by Smatch.

> +
> +	set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
>  	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
>  
>  	return 0;
>  
> +out2:
> +	unregister_netdev(netdev);
> +
>  out1:
>  	tasklet_kill(&tp->tx_tl);
>  	cancel_delayed_work_sync(&tp->hw_phy_work);

...


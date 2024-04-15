Return-Path: <netdev+bounces-87799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DE08A4ACB
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2981C2112F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5639FF4;
	Mon, 15 Apr 2024 08:49:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB9219F3
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170963; cv=none; b=AX3xJS73hh1Nqbi0vDD6I6vYdRJdORfLdMhk6UPphaZzNlRETA25LtRncs9athi1Hfc9AIOUuGwAdGmoRAN5M58hdoOsIOk5sd1r0MZCxe05SYe0OWPLxRVdsQTgpheEbJE9Hx9nAr+Zk4o5uHBks63i+U65xxsm4wEBVyYAl1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170963; c=relaxed/simple;
	bh=h5XfmTKa5UVtEMrpZjHn4xmXYv/rvneyRPyEAp/lWcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW2eGxzzrn53bU/MLMjUb48y1Ey+4j+lI0ohR9oOH5Zx1XCTKTtWLbCZdmlzEc1qW4QAh+JSJQ7xWpIolB0GXRSFHMP1QqYkab6trSCpS3KP2xMtpf3bhTNjyO6UADH1RFCHpzBfQPlNyiX1255rz33BaziJMHMVw5aNfwQfcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F159F100DE9C9;
	Mon, 15 Apr 2024 10:49:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 99F291BCE7; Mon, 15 Apr 2024 10:49:11 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:49:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <ZhzqB9_xvEKSkMB7@wunner.de>
References: <6b6b07f5-250c-415e-bdc4-bd08ac69b24d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6b07f5-250c-415e-bdc4-bd08ac69b24d@gmail.com>

On Mon, Apr 15, 2024 at 08:44:35AM +0200, Heiner Kallweit wrote:
> Binding devm_led_classdev_register() to the netdev is problematic
> because on module removal we get a RTNL-related deadlock.

More precisely the issue is triggered on driver unbind.

Module unload as well as device unplug imply driver unbinding.


> The original change was introduced with 6.8, 6.9 added support for
> LEDs on RTL8125. Therefore the first version of the fix applied on
> 6.9-rc only. This is the modified version for 6.8.

I guess the recipient of this patch should have been the stable
maintainers then, not netdev maintainers.


> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -72,6 +72,7 @@ enum mac_version {
>  };
>  
>  struct rtl8169_private;
> +struct r8169_led_classdev;

Normally these forward declarations are not needed if you're just
referencing the struct name in a pointer.  Usage of the struct name
in a pointer implies a forward declaration.


> +struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev)
>  {
> -	/* bind resource mgmt to netdev */
> -	struct device *dev = &ndev->dev;
>  	struct r8169_led_classdev *leds;
>  	int i;
>  
> -	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
> +	leds = kcalloc(RTL8168_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
>  	if (!leds)
> -		return;
> +		return NULL;
>  
>  	for (i = 0; i < RTL8168_NUM_LEDS; i++)
>  		rtl8168_setup_ldev(leds + i, ndev, i);
> +
> +	return leds;
> +}

If registration of some LEDs fails, you seem to continue driver binding.
So the leds allocation may stick around even if it's not used at all.
Not a big deal, but not super pretty either.

Thanks,

Lukas


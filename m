Return-Path: <netdev+bounces-85357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDC89A5E4
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387241F221C3
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50356174ED4;
	Fri,  5 Apr 2024 21:05:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51A172BD0
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351109; cv=none; b=KOYHMQWIU5sMIkZT9zWr3CSm1SdhzJ6e4960XaRODzQPTspRfdJQ1wxXkPqZ+Uy0XpyYmbQaqG4nYmw/CyjrDx4oznCBPtXWqaD+FOZ6cdNmSaiMR2apqv93pn3vP87MkWEjk2lzvt4lQvmJVpgVMnZYVKlecNxBaTf477eV0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351109; c=relaxed/simple;
	bh=dxoxhDPRHn61eghJ0+Yb17K/niqdMvU0sUPMPsWWcSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0OU8gtiZGYafhrw6FSGrCLbIxbtP0GanQKb2JyUsdLmkz+BiTQ6CM51xD7599qOd+0ui+Vzs2rfYsPdy1LSbYYBWCZtMxVfGGdL5plbxPD3/5ixU907v/OsaV9p3JYrv6jVIMmoshFfG6YpK6LwF2cZ5GcDjKzj6AgWjZCRH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6DC6E101920C4;
	Fri,  5 Apr 2024 22:58:30 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 38A4060276DD;
	Fri,  5 Apr 2024 22:58:30 +0200 (CEST)
Date: Fri, 5 Apr 2024 22:59:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <20240405205903.GA3458@wunner.de>
References: <bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcdbc1b-44bc-4cf8-86ef-6e6af2b009c3@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)

On Fri, Apr 05, 2024 at 10:29:15PM +0200, Heiner Kallweit wrote:
> --- a/drivers/net/ethernet/realtek/r8169_leds.c
> +++ b/drivers/net/ethernet/realtek/r8169_leds.c
> @@ -146,13 +146,12 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
>  	led_cdev->hw_control_get_device = r8169_led_hw_control_get_device;
>  
>  	/* ignore errors */
> -	devm_led_classdev_register(&ndev->dev, led_cdev);
> +	devm_led_classdev_register(ndev->dev.parent, led_cdev);

IIUC, devm_led_classdev_register() uses the first argument both
to manage unregistering on unbind, but also as parent of the LED device.

While the former is desired, the latter likely is not.
I assume the LEDs now appear as children of the PCI device in sysfs,
not as children of the netdev.  Probably not what you want.

The second patch I posted should handle that correctly.

Thanks,

Lukas


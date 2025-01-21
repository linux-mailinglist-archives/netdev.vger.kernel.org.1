Return-Path: <netdev+bounces-160094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7CA181BA
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D20C7A145F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B411F4270;
	Tue, 21 Jan 2025 16:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3611F4E31
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475814; cv=none; b=Sofd/9g42QzZ3RrJzdD6H/twgVNzEitp4Q97UnvpuvGdpTB2V2iYNRaH4i6jA26d4TdkDkDGgB3Ju1T2Z9t6GqGTUN2yBFfxXP/a1Y6L54nrEIEBTgl8wa7yloU91xtvDqDfU9hl+3S17Xkm0jWECngiTWESpLQ2v0yHJrsXEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475814; c=relaxed/simple;
	bh=1CNdK0ZwziHDMvp49QtbvJhzEBFH52RSONQKTbg3vKM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LfXerrL7GN/HObZOuJYA2lDWZuL7uXfcZKVfFEq3tCe6n9CMoO4dUvqDsAUWUCRjw5MQHfvcCs7LUK97ZNox5qiFcZ+8vJBxEKlH0hekBJXfVSKoJWNER7a3HQYEcxiYos5Vue8t7GyHmlKm8IuFZ9MYxnoIcqi8CQKKN6h+SQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5400:5628:9df0:d4b4])
	by albert.telenet-ops.be with cmsmtp
	id 3sA82E00R3QiWAT06sA8kx; Tue, 21 Jan 2025 17:10:09 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1taGpM-0000000Dvvz-26kX;
	Tue, 21 Jan 2025 17:10:08 +0100
Date: Tue, 21 Jan 2025 17:10:08 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
    David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
    Simon Horman <horms@kernel.org>, 
    Russell King - ARM Linux <linux@armlinux.org.uk>, 
    Andrew Lunn <andrew@lunn.ch>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support
 for temp sensor on RTL822x
In-Reply-To: <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
Message-ID: <a8da8aaf-adba-dbc4-3456-faae86eccd1e@linux-m68k.org>
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com> <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Heiner,

CC hwmon

On Sat, 11 Jan 2025, Heiner Kallweit wrote:
> This adds hwmon support for the temperature sensor on RTL822x.
> It's available on the standalone versions of the PHY's, and on
> the integrated PHY's in RTL8125B/RTL8125D/RTL8126.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for your patch, which is now commit 33700ca45b7d2e16
("net: phy: realtek: add hwmon support for temp sensor on
RTL822x") in net-next.

> --- a/drivers/net/phy/realtek/Kconfig
> +++ b/drivers/net/phy/realtek/Kconfig
> @@ -3,3 +3,9 @@ config REALTEK_PHY
> 	tristate "Realtek PHYs"
> 	help
> 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
> +
> +config REALTEK_PHY_HWMON
> +	def_bool REALTEK_PHY && HWMON
> +	depends on !(REALTEK_PHY=y && HWMON=m)
> +	help
> +	  Optional hwmon support for the temperature sensor

So this is optional, but as the symbol is invisible, it cannot be
disabled by the user. Is that intentional?

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds


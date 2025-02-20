Return-Path: <netdev+bounces-167992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10BDA3D0FA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 06:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BAF3BF5D4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A161E2613;
	Thu, 20 Feb 2025 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW77sYeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D34198E81;
	Thu, 20 Feb 2025 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030015; cv=none; b=m1qfQGG7FXr7Ykbf9o4vcpIEDqKKgV7YjAecKjpwBP0atQQfCZcHtJpqeSfBASjOyI7Yg5dKjkzJIG2mXpsKlEMZ+imZjaCcYCDvb822ahlNMhHHEY4ZF5BJIHHZaMbZWTfiIPkjYoisoz2N0NDuJCPM4ZcsNoKLJ4u97u0P7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030015; c=relaxed/simple;
	bh=9mFM3nb6TKERTPbkj3nryQtjk2XQRxIg1VTX5RNaE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMRepWGBK42iyEwW5S2pYrXZYYjQGAYkMoCDHqOVmd3//GrVSfw3p9x4HQE/6+WBPyOGBI68DtPWydl1Oo3GzeuW/xaIrC1F1xb4ZNX+brZw6F1eXX4nzclYjBfUpqU1imhwNIP+lg3zePGHrfQgQsb40igUjY7vSy1XUjeuwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW77sYeb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso778814a12.2;
        Wed, 19 Feb 2025 21:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030012; x=1740634812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ8OPti8TSr4jYHrtMLHhzqecFpgns6NefSJddULs04=;
        b=RW77sYebtWl3hhPOa/WdLMGavj2R68A/3tQHuJmcuAQOddMqjEcjvZvDepFA+MNrvr
         ID4klsp1gyQAaK0CN5vKOqKcLV0+yX2eisji6E+Ks9CzFfXwNsRtX82R7Dg0wnMMfjv7
         fY+hMRWhz1E35QqsCMfYhusgQK5JN+wX/o7A0UvA+tQs7E2JJhxxM29Hs8Sn6rFO1xE8
         sYBiEYScTSFyVOPVTEhHI1uaKlPPlEi/z3xf7A3WmCjF2lHlAm31hE4+uD+ocei+TuDb
         IofbIsnZdmiX58oyfRVLOqm16wA11OlNLuHRMsovNuqPLrunvT25QuBWbuyQ/SrmQ/xQ
         6l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030012; x=1740634812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ8OPti8TSr4jYHrtMLHhzqecFpgns6NefSJddULs04=;
        b=XhJ3pxIr0ja7/lYDtRgww26WA+poMo0pGYFL4r2omiREMPb8IUn1MtSFrUJQOI/hes
         hLg/QxFS8AKPo/4DZ4NHiskIhbn8l2rEosQlx0AovBObmrWioqK51AksFwoTykHO2hiq
         fqqFLdra46sBjmXzN2FTLA4YcY8w0Op0UXXHms/YRliG9qITiFK1Brv49kosTL6SVbkC
         wjBdE+oj/VzVIYtO68F3eUOnHeuZwNoas1dEFSmvthjm2K9R0Q9u40Kx3NRJDiGPM39F
         COHnq+H0fbEJO7QH2u0FRsSdWxa/1inHlWDJIUZESsmnjW6UBN8K/+hd6dovYZZbWlgm
         OwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LuvTGllm+Vj6yIXkwj7Lba4bgbWM9wB8JC5ucjBldVXhjWoorSqsTp2W7JhKhrby4Vk0nTe3@vger.kernel.org, AJvYcCVCl9yhP5Z3TFORozvemrBONI71qLaoQqyA5z8LUzfINpqivI15wSGoueotAg1fE9HDm8CPgRPJj2+v1w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84x1+kGP+lsJOdRp1YBXaDqF6srbdFtSwwHWnZaxmK2c1lCHj
	Bas2ixqucw4rxbFoGRem/rLFV4HWrKzB2jCtHrUbCmvAQuNoQLwtN9eBzw==
X-Gm-Gg: ASbGncvZ9gsNWXeAwp5DAOCmiB77bmpqIWTsNhHtR5vqCphBa4mgk9dUcujwKgnH/Z0
	VQJEQL/pmNohd1iw6DSoWqWydEV75TcN+D4nrS30gCJ8aWv7esS24F4wveLZic3y2b+/KED/7VW
	FqQQqqZEJ0+X8fHbV4kxOpWwmuZvvtrdA5oLDN9U7r8KaSLEIUAhAnHRWo+IQXvKVjhD01FyJTP
	J1gFoNh1/lFgr8nzxs7VtGWbIvNJASR4ech8GptphaIw/DbuBcX18t4ThtlcBAw/q07nzy6FlSa
	HCMWQzym9SX9
X-Google-Smtp-Source: AGHT+IFTyMh82Ah2PjscTmeIt5Ld9AlDInrUJdH8ZXJiD5DVrRJ1cPIXQifWprmRg3vjINRgQTfbYg==
X-Received: by 2002:a05:6402:50d3:b0:5e0:67a7:f994 with SMTP id 4fb4d7f45d1cf-5e0a4b2d1cbmr1013454a12.19.1740030011494;
        Wed, 19 Feb 2025 21:40:11 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d48c5sm11980898a12.47.2025.02.19.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:40:10 -0800 (PST)
Date: Thu, 20 Feb 2025 06:40:07 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: marvell-88q2xxx: Prevent reading
 temperature with asserted reset
Message-ID: <20250220054007.GB3914@debian>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>
 <48c4cd14-be56-438e-9561-c85b0245178c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c4cd14-be56-438e-9561-c85b0245178c@lunn.ch>

Hi Andrew,

Am Wed, Feb 19, 2025 at 02:21:23PM +0100 schrieb Andrew Lunn:
> On Tue, Feb 18, 2025 at 07:33:10PM +0100, Dimitri Fedrau wrote:
> > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > Prevent reading the temperature in this case and return with an I/O error.
> > Write operations are ignored by the device.
> 
> I think the commit message could be improved. Explain why the PHY
> reset would be asserted. You are saying it is because the interface is
> admin down. That is a concept the user is more likely to understand.
> 
Will improve the commit message.

> > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> 
> Is this really a fix? My personal reason for this change was
> architecture, it seemed odd to probe the hwmon device in one spot and
> then enable it later. But is it really broken? Stable rules say:
> 
>   It must either fix a real bug that bothers people or just add a device ID
> 
That's fine for me. I don't think it is something that is really
bothering people. Will remove the fixes tag and switch to net-next.
Thanks for pointing out.

> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index 30d71bfc365597d77c34c48f05390db9d63c4af4..c1ae27057ee34feacb31c2e3c40b2b1769596408 100644
> > --- a/drivers/net/phy/marvell-88q2xxx.c
> > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > @@ -647,6 +647,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
> >  	struct phy_device *phydev = dev_get_drvdata(dev);
> >  	int ret;
> >  
> > +	/* If the PHYs reset is asserted it returns 0xffff for any read
> > +	 * operation. Return with an I/O error in this case.
> > +	 */
> > +	if (phydev->mdio.reset_state == 1)
> > +		return -EIO;
> 
> Maybe ENETDOWN is better?
>
That is way better than EIO, so users could actually know why the sensor
doesn't return the temperature. Thanks again.

Best regards,
Dimitri Fedrau


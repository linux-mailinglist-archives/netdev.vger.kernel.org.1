Return-Path: <netdev+bounces-167678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD8A3BBDA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01747A576D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47591BCA11;
	Wed, 19 Feb 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gahZUNlF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10B195FE8;
	Wed, 19 Feb 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962015; cv=none; b=U9SMMzhyjDvGJ2mEPhAZ6tsDR6hse0Opo1uhE2z3T+Gz1FWtbAr5xgb66q+V7p+/XGpr93nCzbPYy0G2vWunwpc2DeJH5IELafqrhajrqcxpUPrnNeHUvB0bc63RPDrLCKjdU/y1N2mzkBBwG1cvLVky8fhdxckPGr1A0hXeDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962015; c=relaxed/simple;
	bh=31ENOo68558J8kka2dIh2wZxxlZYzqoWhM6K0uGoJbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJmSkybnQuJXrqqET7DvKiEQASUI5I4iIHXG/xBovzYTNAeDh7h7fR5+CYAGRmp7TQr/pfeHCGUloDF5jqzVRRgQi9eDHCIOaQMPsIQe/2nGS8Scyrz4koDXWF2o25SAO/0uzGajrAKL8ovmPhK6ZSZj8bsd4EVyWZxZz9RLw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gahZUNlF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so7548828a12.0;
        Wed, 19 Feb 2025 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962012; x=1740566812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAkVyyk317tc30zj9Sr7h1NT9KbCBzbLvARlSySyLSQ=;
        b=gahZUNlFNv3/uzBPuJDqawqY1LvGA8bg4dqq9LODeNKuS88HOJHWjUJcQmGipB9BHV
         uKWX3dwy8dwp49o121/SJrtWEvoiRJ7CKBfMMH3SzeC5IFDcXfSUOgQbiWh7splCfjBs
         bj0tKAwkl5YSvEogdlewVNTtmgoWRmqd2jwZOTYJ6OfEwsFDQflVtA3uu5CoNzlZPa9K
         HjLBkMo6KSqic4uyEWV22EE2O5exD6hlmdUFZj79XQOl26vTxxcXQ8SElhRpOP9ectkA
         ZQZSsQfIyQ0FHDQVZGPGyqvi/MYyIFaoA4wiqKDfSF7s61OKq+JYHoLZ6b/0HTp1oFzY
         ATGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962012; x=1740566812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAkVyyk317tc30zj9Sr7h1NT9KbCBzbLvARlSySyLSQ=;
        b=LUDIYUD7+B+gpvZUpG0zy5xMxYXakt1M6zXJCs4L/yll/F9bm7jZXg+ReNIJxacjE0
         MuUBPHRx3qBNVxayogb+yM33hWUBJE/bSSNOBdVHrV/TePVTjn0If57P18rfeAuHMcQU
         E0VzNBix4CS0ax/icNMWqX8u4CmGsfFYDIlylMJ0/MlQlJMce8rzVttWnvAW1S6UOlYZ
         8aHmaDwlFJ5zssr5hx17la+PAFzH/HvwNOP5CupMo9TSwacKgYWdLTZZYwdpFKzy4Zhs
         I/eQkqpyXFM9cRpzxe8dyALDQPwaCAYfTKhcKkyXJZ4KiYWzBXGb8orNcrX4SO392mT1
         u8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe2nzdRAQsfpCUrsWN9E1oszI5W4M2eF/+dCtXvm9HsNwuijxi9/9WYamiSda06Lx7S/h/vCIX@vger.kernel.org, AJvYcCX7XiJhqP3u674SCecLzlUqVp4rSTRa2ISp75mRwAmfXWLfMnjJrcmZf14kaCBFu1Hge+kw3kpjhrpqdx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFAl/bQ8Vd490YuwI923JQMFATQyID064rI5DVCFbDAgXnT8g
	jyVEwD4TjVUlFvqKrmlKuBkq8uxD8u/BIc3wZlvmsPDBh9HidF5Oaergqw==
X-Gm-Gg: ASbGncv5qrgaAJpfxU3BFZ+xWms0eV5R2yhwa+DXFafNdS6jAgR3RyO22Db6wqcLO87
	9bxaF+q91OMx0QniyAF6AHVW5RFM6QQrpYAxGzv6+1Wocfe6yRRleI/P/gsZszkJV9v279g1tMo
	rZHuGQ4AAS3jAhmCWHowetYr+WTeLAlOyjgQVaEaqZId4i02CEWqDsNED8b3X44T87B+b+0o6hu
	Lw/ieyq5JFR5F/X1KaUSKEUsVt64+vpZJHBPQz7X6A7dNeneqbHTd2pUPhLZo6hbzZDQV9RxQPP
	IgNdYpmQtlHD
X-Google-Smtp-Source: AGHT+IEk6j9RjgMgxPzqQgj2U0wvTr1YPwgyRsxzroqQYOzDLgg2d2MU6KU9FGvblfBJOjSEIhCBog==
X-Received: by 2002:a05:6402:5246:b0:5de:39fd:b2ff with SMTP id 4fb4d7f45d1cf-5e035f49943mr19003699a12.0.1739962012125;
        Wed, 19 Feb 2025 02:46:52 -0800 (PST)
Received: from debian ([2a00:79c0:646:8200:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2709a9sm10169900a12.53.2025.02.19.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:46:50 -0800 (PST)
Date: Wed, 19 Feb 2025 11:46:47 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Message-ID: <20250219104647.GC3888@debian>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>
 <Z7V3Wsex1G7-zEYc@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7V3Wsex1G7-zEYc@eichest-laptop>

Hi Stefan,

thanks for reviewing.

Am Wed, Feb 19, 2025 at 07:16:58AM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
> 
> On Tue, Feb 18, 2025 at 07:33:09PM +0100, Dimitri Fedrau wrote:
> > Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> > mv88q222x_config_init with the consequence that the sensor is only
> > usable when the PHY is configured. Enable the sensor in
> > mv88q2xxx_hwmon_probe as well to fix this.
> > 
> > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..30d71bfc365597d77c34c48f05390db9d63c4af4 100644
> > --- a/drivers/net/phy/marvell-88q2xxx.c
> > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > @@ -718,6 +718,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> >  	struct device *dev = &phydev->mdio.dev;
> >  	struct device *hwmon;
> >  	char *hwmon_name;
> > +	int ret;
> > +
> > +	/* Enable temperature sense */
> > +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	priv->enable_temp = true;
> >  	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
> 
> Is it necessary to have it enabled in probe and in config? Is that
> because of the soft reset? Can it happen that the phy is reset but
> config is not called, then we would end up in the same situation right?
>
Even if the phy is not configured yet, it is probed and the PHYs hard reset
is deasserted, so I can read the temperature. I think the situation you
mean is when the PHY is brought up and down again. In this case the hard
reset of the PHY is asserted and I can't read the temperature. That's
the second patch of the series that fixes this issue.

Best regards,
Dimitri


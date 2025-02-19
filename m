Return-Path: <netdev+bounces-167802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDCAA3C639
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9B1899EAD
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF22147EF;
	Wed, 19 Feb 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD8UzGxH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA102144D7;
	Wed, 19 Feb 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986127; cv=none; b=nv29lZebVoujQhHZlM5P6mTFSmJ6C261C16piiN404TyH3QeO/lu44zcK7MWI5c/7CuzxA82RFapM012A/RjTQEpIYJbnxw1eKZjR4CO+XHXct5RiDA2tmxV3o/J86SNFCIuhPiqbXDFx+sDOaLfNEmtFYHnBYVzDFVUFX6hm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986127; c=relaxed/simple;
	bh=KeHrbq9+/KLUuc3o4CRJqpjQacIlopX9KXp8AMmZgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQvte8rGbwqmXOiebGC76wko8ObsUfyTysM6YzKqLpHbNsnXNoQLNuXoJXYWjGg5oRjGXAJX/ky7UbHUjZrsnJaUx2INV02zQnO+ILo4soFYg8aBbm7HiKfROsAJ7pjPMGRsgSAqBhhne+/ODdFdwZAxX+u37wF89dx35YpAk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD8UzGxH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbc38adeb1so13870966b.1;
        Wed, 19 Feb 2025 09:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739986123; x=1740590923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJvk3PzO8UJcQqRvZYSLjrxNTJFPtwx8YpqkUT72Kbo=;
        b=gD8UzGxH3B+/K6WcJhXfXNoL+WnEi7+M3TSTtwsitytCRbW7HuuTt9CGL31hfe3Nau
         89StpOx7xQkdy9cj6wfNK0tof1I9nTXUAzVwVpgM1NFuNuXv/Fl8YZeorDg0yMghpJ3v
         x4j1gpOcSkHuewEoPDRbnAAUFRdmUIvVETYQlJrkwbbWcXTGfEwbAr4psbsudAZaHRpT
         zHFhK0ojsT4MSSHYZ7uFwOgXh2ieoBrG7eWipjJBCWsN3UwsiFKg7TooDXSG86/qfghs
         34I3AsO70qRrr2nPlyBI0OB9ViKmvjEIQebfaZTw2f0/5wVysJDA2keu7UrIfuC41ssJ
         Efmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986123; x=1740590923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJvk3PzO8UJcQqRvZYSLjrxNTJFPtwx8YpqkUT72Kbo=;
        b=jDP0IsDlLhR3BcVDEHBP/Jpw2X6TB+b2+crCfBm7+INgMPF9RxTTOAgLV9dWF12OIb
         XsA5ICo+Msx2aAbvJeGS4XD6HaxCSt25/7jbjwAE7ROS5zncI0lReJxpmZjtnRtIzxgf
         UA2DWkS1SGp45Tp/jnpHhE4fbCfvlEVxb4KZK22alsNTicgFgAAL5e5av29a55arZwLc
         DC2K/zCe5dgirbGtUyATRPe2PZrgPGFHFTyK7GyFKDum0RRc/JRRoNUaC9nH18Ps/riL
         IpbGZN77CsiwOlpKxLudR5ZLyxXUsy1ICeTeT7vIs48hu5/++FIO+IkJJonY/WKQ+Plj
         mk1g==
X-Forwarded-Encrypted: i=1; AJvYcCVjkN0SltzWwgNPJ4W514PhhK2Cn8s+sCMQLBTtt1nEiA1EcAWwzM8m4SD12+7Sn0dogvvmPJj+CesuiLE=@vger.kernel.org, AJvYcCXS7rnKJuQtEsL23yeGou6/u2r5TvoUihDZaNSf4zpf167F5KavL+b0M90Slv4HpbSHTNZV+TI2@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTA7Fk1XQ4tM/iA1J8AReLIFmRTZfsRHvIQ9h0ZZRuuxojgBM
	COlQsabXmheNivGYX8SogM0S5wpFuNLTdJN7ZdluBLA93APL5mOW
X-Gm-Gg: ASbGnct6x22L1gSKskr3/gMDW54aw/KF0pkYDGnpDAXMAx+Ns7+vmsZrfDKOicGE0UK
	uOr4F3eesO4BwVsPe4ObrreS4GywJCZpedf2pjK7WuFKXW7skHYPhiVDEKAdQmtgq2vjX+DJFnP
	cStUtbJscrcxWUOakGg6xuUViIYx0vz8p7uE1y6FmBcpOph8gd9rUeiRNpyECbiws8ItsIvY2Z8
	5cwqkcZ7Bv0PVm306jLD/kCX6gTCTXKxn5USndpeF1J3mw3MkP+1WMUxVuA/Y3ODxUa3bNamxrI
	9e0kNe/7j9rmTL8/Bw==
X-Google-Smtp-Source: AGHT+IFNf4fdkqEc+24rmFUK+6430USqOj02thhBl42cygp+gf745aITOrh4dTndmQTFda58zcNp5A==
X-Received: by 2002:a17:906:2718:b0:abb:ebfe:d5eb with SMTP id a640c23a62f3a-abbebfed7admr25133666b.18.1739986123228;
        Wed, 19 Feb 2025 09:28:43 -0800 (PST)
Received: from eichest-laptop ([178.197.206.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbab339807sm496018966b.162.2025.02.19.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:28:42 -0800 (PST)
Date: Wed, 19 Feb 2025 18:28:40 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: marvell-88q2xxx: Prevent reading
 temperature with asserted reset
Message-ID: <Z7YUyNVR3mI35pel@eichest-laptop>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>
 <Z7V6XZ7VRTkYNi2G@eichest-laptop>
 <20250219105458.GD3888@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219105458.GD3888@debian>

Hi Dimitri,

On Wed, Feb 19, 2025 at 11:54:58AM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> Am Wed, Feb 19, 2025 at 07:29:49AM +0100 schrieb Stefan Eichenberger:
> > Hi Dimitri,
> > 
> > On Tue, Feb 18, 2025 at 07:33:10PM +0100, Dimitri Fedrau wrote:
> > > If the PHYs reset is asserted it returns 0xffff for any read operation.
> > > Prevent reading the temperature in this case and return with an I/O error.
> > > Write operations are ignored by the device.
> > > 
> > > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > >  drivers/net/phy/marvell-88q2xxx.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > index 30d71bfc365597d77c34c48f05390db9d63c4af4..c1ae27057ee34feacb31c2e3c40b2b1769596408 100644
> > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > @@ -647,6 +647,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
> > >  	struct phy_device *phydev = dev_get_drvdata(dev);
> > >  	int ret;
> > >  
> > > +	/* If the PHYs reset is asserted it returns 0xffff for any read
> > > +	 * operation. Return with an I/O error in this case.
> > > +	 */
> > > +	if (phydev->mdio.reset_state == 1)
> > > +		return -EIO;
> > > +
> > >  	switch (attr) {
> > >  	case hwmon_temp_input:
> > >  		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > > 
> > 
> > It makes sense to me. However, aren't most phys that allow reading
> > sensors over MDIO affected by this issue? I couldn't find anything
> > similar, are they ignoring that use-case?
> >
> Yes, you are right, but only if the PHYs hard reset is controlled with
> "reset-gpios" or similar. I didn't find anything about it too.

Okay, I see. Maybe at one point it can be generalized, but for now this
sounds good to me. Just address the inputs from Andrew.

Regards,
Stefan


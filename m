Return-Path: <netdev+bounces-167991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E40A3D0CB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050CA1762E1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EB72AEF5;
	Thu, 20 Feb 2025 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+xcpIkP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8D524F;
	Thu, 20 Feb 2025 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029552; cv=none; b=VsEQAe3kY4Jl5m97DrDLbGV1JDIUYQE9PJcWZMPyJVUApJhQ1ELVj8W6a6kA0mVJaNi2wdiLNJrGAglh4VIp63brgV3JF7LpY6okU0b9Mb3T6/nHCO9yV4+1s85MXKzX53S1OYfklIMccLWpaPq41qCKWk/1qstSTq55pKjhqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029552; c=relaxed/simple;
	bh=3e9ITB0v0vv4TVkNHrbax69/+NT3q8n5gFLHHx7q1H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwHpVir8rZvuhfuIShtFy/CHg91m6/kR013ZV3uCj9hvd7Jj1UcyIfiindtpP3SJHFdG3LKuj2E90UnF5TtpoKvRX5qlq2bDEs8oz0G/hWkQpLdIaKzz5EvID7E81N1WrFsZ2sNqgoBhlCwYOEON1FOitSMq8a8i+8A7pBU8Kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+xcpIkP; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so1058793a12.1;
        Wed, 19 Feb 2025 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740029549; x=1740634349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t59XJ1OOcCF4nLjXJy5R2daGlLc6nwlV0JhixHTmrLs=;
        b=f+xcpIkPMjAwzWyNdpRMWKu03myVdRhfHQYHeraQmnjNca8cLKBLrA+w9B4RXzPHpO
         DjMdqs2WAZ4wNTOHoCVmQrSVqFiiqHsiUBf+UFf6pEndNB1YLrYlgRggE8OarkMOhspg
         4e2u11OoIvTM5UjCp/UObGwQPD9uvKgzNeMOgH2Ay2FOist1LWDBNgC1g17HHpdIMA6A
         5sAs6adSVV/A4CJ5NP8DFk6iJ5ILRyk8VdnBR2xKMhZJOg8qqqbNFGOENdjufr70FJg4
         PMLOjYP6uy/2BQrvFFTLDfmpwoPAunOFiy2wVbNyMW3rfKsHosX7bcS2CalgUy28MHhE
         WLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740029549; x=1740634349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t59XJ1OOcCF4nLjXJy5R2daGlLc6nwlV0JhixHTmrLs=;
        b=iC+FKYxJ4luFUtb1WIdYoLwr90viBlQ8gr8OGr+K8YpRrSGHxt+dkOQDhzVPAd8TbR
         6hGz84bKDqCITEWBH66nladgK9MgT5C6Gcca/cYxMSD/BMswXox5oGeJpS6vxd/Dgiha
         1xWMOFQEP+uEXbh98R56WVIp1SfMY0OxuZOeK5nLr5psXoyl2GmdcSsndEdswEHODAyF
         jJgxBRf4+zPz1TZvsPxqo6dAfWHuBbb8ewDtGS69gu5wk4DS9Aibux/Bh1fjw4m0TNaM
         ej+m6NOJI67P4LhmFbBAeBGcfncrbimSBGsTjHg9OUAfqB4IMj6xV8owqLG50FiqCFaV
         Flzg==
X-Forwarded-Encrypted: i=1; AJvYcCW4GybqrEzhKI2wO6Gpyo4qk9afX7VD7i4dubZApZqJ5zlkDx8R0LmHnbYJyMt3o6BLmL5FtoXF@vger.kernel.org, AJvYcCWVut1s3LWjkfrXmuKqsycni3SQy08D7a1vNA15QFzJ0zUEN5mJiRuPeGzDQjl6YBf+EFVTxfSH2r4uTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElIiQXvu+KBYnvBCetu8LQpq3OAfbs1Ikp4ptZ/lRrCww/KdO
	6SQFCxLsqSrvSZmih9fUDBmp+4rY1V4FH+7L4QEpti0RgvzBTgF/
X-Gm-Gg: ASbGnculMVmbhtpp3oFdKS6Wk8kWlofhu9TRlJu1zW6bvPXlpzTZASMh8rKfUAXnXuT
	gYE+6CibE2yrRhKiJqWiKGpwN07GrfrdsWVAhaCKIKAN4zXnVpbL+WcJ+NwFSpbGhofRIsQkiT+
	erhSMZYSEMJosZ4sZ5xRlK8wOMlPgSeATtO31uaIeUgM+EUPkYLA51B5jph2kLpisv4chH1EXVp
	BSMMpYPMroyQL4/enSmI5WIQld5ZamjkEJ2Gnnwn0Si1NZ5HAJGLpiw4ExUNfbGtEr1RtZwZG4P
	BRv5hw5N7q6J
X-Google-Smtp-Source: AGHT+IG5X+Oirh4JKvNeSMlWoYa1IlfqRECBCeBBySZcsJ3c+Cct98CBZ/HOrW3zk4EV+wdO7JttHA==
X-Received: by 2002:a05:6402:34c6:b0:5db:7353:2b5c with SMTP id 4fb4d7f45d1cf-5e0a1280fe2mr1684309a12.11.1740029548538;
        Wed, 19 Feb 2025 21:32:28 -0800 (PST)
Received: from debian ([2a00:79c0:604:ea00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e076048c05sm4121660a12.35.2025.02.19.21.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:32:26 -0800 (PST)
Date: Thu, 20 Feb 2025 06:32:23 +0100
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
Message-ID: <20250220053223.GA3914@debian>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>
 <Z7V3Wsex1G7-zEYc@eichest-laptop>
 <20250219104647.GC3888@debian>
 <Z7YUG2RjpBImivqF@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7YUG2RjpBImivqF@eichest-laptop>

Am Wed, Feb 19, 2025 at 06:25:47PM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
> 
> On Wed, Feb 19, 2025 at 11:46:47AM +0100, Dimitri Fedrau wrote:
> > Hi Stefan,
> > 
> > thanks for reviewing.
> > 
> > Am Wed, Feb 19, 2025 at 07:16:58AM +0100 schrieb Stefan Eichenberger:
> > > Hi Dimitri,
> > > 
> > > On Tue, Feb 18, 2025 at 07:33:09PM +0100, Dimitri Fedrau wrote:
> > > > Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> > > > mv88q222x_config_init with the consequence that the sensor is only
> > > > usable when the PHY is configured. Enable the sensor in
> > > > mv88q2xxx_hwmon_probe as well to fix this.
> > > > 
> > > > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > ---
> > > >  drivers/net/phy/marvell-88q2xxx.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > > index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..30d71bfc365597d77c34c48f05390db9d63c4af4 100644
> > > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > > @@ -718,6 +718,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > > >  	struct device *dev = &phydev->mdio.dev;
> > > >  	struct device *hwmon;
> > > >  	char *hwmon_name;
> > > > +	int ret;
> > > > +
> > > > +	/* Enable temperature sense */
> > > > +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > > > +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > >  
> > > >  	priv->enable_temp = true;
> > > >  	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
> > > 
> > > Is it necessary to have it enabled in probe and in config? Is that
> > > because of the soft reset? Can it happen that the phy is reset but
> > > config is not called, then we would end up in the same situation right?
> > >
> > Even if the phy is not configured yet, it is probed and the PHYs hard reset
> > is deasserted, so I can read the temperature. I think the situation you
> > mean is when the PHY is brought up and down again. In this case the hard
> > reset of the PHY is asserted and I can't read the temperature. That's
> > the second patch of the series that fixes this issue.
> 
> Okay I see, thanks for the explaination. So the code in
> mv88q222x_config_init is required after a hard reset of the phy. I was
> just thinking, if we could avoid the duplication but I guess both
> enables are required. Could you maybe add a comment why we need to have
> it enabled in both places?
>
Will add the comment.


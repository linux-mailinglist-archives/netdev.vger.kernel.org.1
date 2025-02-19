Return-Path: <netdev+bounces-167798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B944A3C620
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FED71899A2A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D92144DA;
	Wed, 19 Feb 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAr/TNGA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE221423F;
	Wed, 19 Feb 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985953; cv=none; b=XGb3T8llqvtB1X8q/80ZY9tkobGc0gLrXBUe6fDdoG55rcC22EfBve3xvAYB75hsp5QmlUoKS+lMWF+J6f2M5jSpDrfa9+Hil9YAyX8tuHpJNXt/jJN+X3NSl20fqy5D0Zyryku0Ptjv4mEK+DQcMJ26REQ5h7zUWRD1193z//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985953; c=relaxed/simple;
	bh=7ETCUC3n9jKEnJ+iO4nAUrbhxmcwig6TA5+U07om6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob+Fw3uMmNe0VIhTYzyv60yKfcMuv3zFoC/eHzZq1LW8v0ml5/U2HdaXpgJ9iQWKsD7wkjNdiql7TfRMoRkdoAdtX1zDhf2rQCgFFs4hEueVOELZCvS8RvSkb04jMSNMFrgzmA20MzQnlcdPwrlF5mCnSb0x+bqxUeZJcNMOn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAr/TNGA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso6116122a12.2;
        Wed, 19 Feb 2025 09:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739985950; x=1740590750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5PEC0BrFt10K4qErCXNqYTbVTe+RJeRlveUcjV5ou4=;
        b=lAr/TNGATYXHQ0suAomGEs6jv+jZWOyDnY4GyNKNFrnq/U/vUkPTDD0GCipFTFKkbL
         QvglCPm5ODPBrIVd/3VOonoW0Vmrq/u4DWKAswgWmQmB9Zc6bUtpAQEqeT6y58hjD/hk
         QxGNTQhHy2vh1mWntbxSvdkTNF7VAOuRGhtCqFAHmIci+4F92F1un2EfFeBqB9c0ez1a
         uTIq91tlxmtw2eVksd8Jc8N/RrsX8IXdnxe9t3uTDoKU0K8vyknpWyByZTue2hj8UoIA
         oVtiHqz1xBzKbjf2MVHtwSftboJV/W22NHo0tLLKBnQENI+zcYEZfcWu4ETwmVoe5o9i
         ELqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739985950; x=1740590750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5PEC0BrFt10K4qErCXNqYTbVTe+RJeRlveUcjV5ou4=;
        b=SYkdMlZhY+/P3kVmMvRbizGm6ZEGwqF2+Zj5u0C1aLcvzbE2mDhNIsJgnUgUW/lgIA
         N4QFQuNGT62XQT29/xCwa0RjWqEFHnsv9/0Ma6t/XlSSAJAgLnqS3t5eRt9Q0SVd8CNa
         luMYoUgXS/kNd2XZddM8aD/MSohC4K7JX5tqFpj36DZu1cfIE8SK9AVy7sYQWbaH4QGd
         XqmOwLtrLuW2AsQFQmR8IYbLXUzufPpEffBySJ27d+pzxIi+DSzOMGAYt97te96cCeB2
         c9JHngzQmOqu2oIVASUqB4fWesr69/rt0tDUUU1aa223hYvjbJiJITp9o3/6zB4y6Aa4
         cFyg==
X-Forwarded-Encrypted: i=1; AJvYcCWqXZS4+DNAg/7gDWXSmlhD7d4ceboR06PpAL9wC0P46wm11j6lJ1bMcsOcqOqWp3xkheaU9Yr1Ip7fMiw=@vger.kernel.org, AJvYcCXEzYnIDV6qfIMZzIjlNGn6XzD3uHwGlkaHoBMs39sIapPd1dYeP5O8JEJvntq0XdWl0ihL+YQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iY9Zn94WXIkyEFmuPDAcvDS7iYAkWoSuLtQE/fJ3unRbtrf4
	scBJTVoITpvfS0BfTjsXsyp2zprXBhTgadjFLkQPoScb0wms/yLG
X-Gm-Gg: ASbGncsxwucOGI8W39miJR1HVjqU/ujj4Il4fUaLcHgvh+JL1Pu25nZa5+CkAN0R3YW
	3iAQhDO3M19uu0xBfsIS22KxRAVE2KxfRJ/xGe28X1z7cOroKGHiD+zfujJB0LTlXPjcI9AUQ0v
	tQYw57JqZUmnd2k1l+8fX35ZNmiCSBFvCu1Gu/CK7hA9OoKWzuzH2tlU8NU4FQrq+SkFjm54Gun
	3WbziaUYkgbBSOmKgEL3uFp3JyKjMaG0kDG3lInrtesn+1sD+nGoDHBf7m21P66FWltDzT+bNUR
	L3cTbbLlvn2KPI02lw==
X-Google-Smtp-Source: AGHT+IFDjX+CikA3gFGO5l7Ghr20tlOzIXEWYj7XotdxJfkXoSfxk+l4q42FIw7J9ykK9bG6vou4Ag==
X-Received: by 2002:a17:907:972a:b0:abb:d047:960b with SMTP id a640c23a62f3a-abbd04798b9mr482864066b.4.1739985949897;
        Wed, 19 Feb 2025 09:25:49 -0800 (PST)
Received: from eichest-laptop ([178.197.206.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232282sm1322055166b.12.2025.02.19.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:25:49 -0800 (PST)
Date: Wed, 19 Feb 2025 18:25:47 +0100
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
Subject: Re: [PATCH 1/2] net: phy: marvell-88q2xxx: Enable temperature
 measurement in probe again
Message-ID: <Z7YUG2RjpBImivqF@eichest-laptop>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
 <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-1-999a304c8a11@gmail.com>
 <Z7V3Wsex1G7-zEYc@eichest-laptop>
 <20250219104647.GC3888@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219104647.GC3888@debian>

Hi Dimitri,

On Wed, Feb 19, 2025 at 11:46:47AM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> thanks for reviewing.
> 
> Am Wed, Feb 19, 2025 at 07:16:58AM +0100 schrieb Stefan Eichenberger:
> > Hi Dimitri,
> > 
> > On Tue, Feb 18, 2025 at 07:33:09PM +0100, Dimitri Fedrau wrote:
> > > Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> > > mv88q222x_config_init with the consequence that the sensor is only
> > > usable when the PHY is configured. Enable the sensor in
> > > mv88q2xxx_hwmon_probe as well to fix this.
> > > 
> > > Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > >  drivers/net/phy/marvell-88q2xxx.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..30d71bfc365597d77c34c48f05390db9d63c4af4 100644
> > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > @@ -718,6 +718,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > >  	struct device *dev = &phydev->mdio.dev;
> > >  	struct device *hwmon;
> > >  	char *hwmon_name;
> > > +	int ret;
> > > +
> > > +	/* Enable temperature sense */
> > > +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > > +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > >  
> > >  	priv->enable_temp = true;
> > >  	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
> > 
> > Is it necessary to have it enabled in probe and in config? Is that
> > because of the soft reset? Can it happen that the phy is reset but
> > config is not called, then we would end up in the same situation right?
> >
> Even if the phy is not configured yet, it is probed and the PHYs hard reset
> is deasserted, so I can read the temperature. I think the situation you
> mean is when the PHY is brought up and down again. In this case the hard
> reset of the PHY is asserted and I can't read the temperature. That's
> the second patch of the series that fixes this issue.

Okay I see, thanks for the explaination. So the code in
mv88q222x_config_init is required after a hard reset of the phy. I was
just thinking, if we could avoid the duplication but I guess both
enables are required. Could you maybe add a comment why we need to have
it enabled in both places?

Regards,
Stefan


Return-Path: <netdev+bounces-159335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06036A15266
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ADE161F4E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE0C1802DD;
	Fri, 17 Jan 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZylHUeuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDA13D897;
	Fri, 17 Jan 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126490; cv=none; b=NfLS7ARLzpSMBobNAIdlUiKat6YN2MznOAbXfWKFgJ0DZV8lZtvfsLbjQKUVSrkX7RPHlQ+dLiCVwn4hue1yFlgp8EkP0fglCDT+x0U4rUMV+2UAOT0mxy56hr1dGDcwckNbObP+SoErEdALz5dma0pXjSUN2HWYeU06bYweDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126490; c=relaxed/simple;
	bh=nTdIxJ/cTly4zSkT48sSSZ44qqI1dYGyeW7/8Lru4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5GifC1tEOkUkTCGzexcf447QxBjvKve+CI2q1Fz1IZjHVlgAQtk6kd6e30vfq2ylJEDgvYhIE5VqyrY1jylh/szLix47nbCcgT1P0hUGiduo14OGDukY0FXRF13ncDLKf8a8igjSWMtz4VMFRIoumzpPuPIG3kecft2GxyTmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZylHUeuB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso20601305e9.0;
        Fri, 17 Jan 2025 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737126487; x=1737731287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfKfpweNy6fyTVfESj8jeg1dgRuNQ71ANl717/ic/Jg=;
        b=ZylHUeuBoMcUVBQReaMeMOA9grRTJyrOmkkh13hTi6AsaPr57ChQAhaO1cXUTtTqRL
         Kwui7f45X79repFoDVQzAOX1zvNOYTS/ixMXSY/NModaODIPEr4N7LD+4jpjlYGlYqL7
         XBW3Hhq4ZynJKQ1y40Bx8TJTFasZJPc/yARlfqDUKz8dsmrHgFJJQU+pZZk7bhMcqlaZ
         ZEPbQbK5c794nfG21h42PUyanz/MEcMfc6PILqNf/vDNodSyeNt/Desv8sO/7AxgTkzE
         fwqAWvaTxop/D18Aye14UWknxsmKcrxkVU1HZRsNNWfokiS+iRDH/Vym4/7oydA/yPKQ
         L81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126487; x=1737731287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfKfpweNy6fyTVfESj8jeg1dgRuNQ71ANl717/ic/Jg=;
        b=N2NaR9z+wYWrAvLHHUvBar9j5FLIZGhWVSRirZtG00orIM4nABu3mbitJcjY17Qump
         XXdesCOcPyrDosaZwbqE+kD2DuEf6QJzvTl+g3OOVsMpqUJXs5TViBPZRx6FVD6Ki4XD
         TdPabjEs1H2/bA1HwO9Ud4X3iWUHqFBCsKRlaVGjpX8L6Ys73GYkEP+yhVCwtJ8NHJAR
         mSAPs7O8peahzzMBpaNRrgw/9DNs30b/p+G4qz0zJhvOkfgHltPVPBAcBTZwv9R2v0PL
         ateMDqtO3c41yEBsvpcajs/00tdaAIQxn1nl8VXQvvCEftXUv2RwPkLVLnFoXGS0tW6W
         iiXg==
X-Forwarded-Encrypted: i=1; AJvYcCX9oTaVO9Igd1fjKWdkjBsUQ/V/lCYBvyaMw10uP9VPZGrDQiT2nI1gtmFY0dQ6olZy1QJT4lZ0QFglmIo=@vger.kernel.org, AJvYcCXNeFv4hmlBFpY33GoD1Fz/PC/RZJDU6O9m+xBTZk2kjOHZBymUA5D1J+a129ibEYPJoFB01urp@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQ04N0EtyBkwJP5SacZFdiuI9Vai0mR+glrzrYCpQY9PtNahK
	2jk9iVOzCQF+SstH28f2ZF+b0R/0m3oFYQnONTXCUJukTtU8pSou
X-Gm-Gg: ASbGncv3+qMgRfW93JpHLZCBns2i+ubv4CE7W9IRDdTLIOasadA2z/SS4AQ+HH82xIw
	p5H+HXpjBUxSK9zBHSRp5mPnOOwkwAOcC6rjbRWC/OAhr41lfRJXkTEQK92G3xMBaW9y1IZ0L3H
	bEcSHn2K7osPWmh/wUfQd/2IBblbfNP88oNpCZw81WDO68451Y1WdLcoG+1CaRH5G6ZCCBuHhnK
	IQJgnkx4hMDTlQbH05e4CkOaiUlIrtMJkChRXCWlf6ldNVqH4DeRw==
X-Google-Smtp-Source: AGHT+IE14pHDzBM0DodxbJm2mIHHp8Va/6+jz+InS9xGZW5snBTEht6+wyZNAsQcy7WjRwCdzwQwbQ==
X-Received: by 2002:a7b:cc06:0:b0:437:c453:ff19 with SMTP id 5b1f17b1804b1-437c6b4707cmr103731765e9.14.1737126486712;
        Fri, 17 Jan 2025 07:08:06 -0800 (PST)
Received: from debian ([2a00:79c0:613:cd00:33e3:777b:b764:1ed1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389040854bsm37549435e9.7.2025.01.17.07.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:08:06 -0800 (PST)
Date: Fri, 17 Jan 2025 16:08:04 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
Message-ID: <20250117150804.GA16023@debian>
References: <20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com>
 <cf5ab51b-ca82-4a06-befd-7ed359c07fc2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5ab51b-ca82-4a06-befd-7ed359c07fc2@lunn.ch>

Hi Andrew,

Am Fri, Jan 17, 2025 at 02:22:55PM +0100 schrieb Andrew Lunn:
> >  static int mv88q222x_config_init(struct phy_device *phydev)
> >  {
> > +	struct mv88q2xxx_priv *priv = phydev->priv;
> > +	int ret;
> > +
> > +	/* Enable temperature sense */
> > +	if (priv->enable_temp) {
> > +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> > +				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> 
> Does enabling the sensor when it is already enabled cause issues? I'm
> not sure if it is worth having priv->enable_temp just to save one
> write which is going to be performed very infrequently.

Tested it, there haven't been any issues with enabling it again.

You are right, but I would need struct mv88q2xxx_priv anyway for patch:
https://lore.kernel.org/netdev/20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com/

There I'm running into the same issue as here and have to fix it there
too. Then it makes sense to keep the priv->enable_temp. I just wanted to
fix this issue before I continue with the patch for LED driver.

By the way, I forgot to add the fixes tag:
Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
Will add it in V2.

Best regards,
Dimitri


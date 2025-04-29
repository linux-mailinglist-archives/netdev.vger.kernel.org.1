Return-Path: <netdev+bounces-186838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A91AA1BC1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519699A41DC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32102550AD;
	Tue, 29 Apr 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="RVntNIXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oO/GIdjM"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534201B0435;
	Tue, 29 Apr 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956995; cv=none; b=ZqQDK2qshZCv3k4kIIkkBmp7ipM2jwFu1bjkd5R2WSNW7Hk3R5NgXueDPpJ7aGu1v3FBkOOXaZBshTpRTSv3WaAxipOLaC/VDp0fwrxzIWJsKFso7aAZYy1Bb85nNP3yXHMXthC0lPpQNNw1tBu4l/EJ9ao/R2MMQcRLn+pDviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956995; c=relaxed/simple;
	bh=aO9aMrkZ5K2W18zUDGkZSijzehNQqwY1ybI6RLazBVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G56GcPsPBY7a6kVQQOEd8cmOJ64l/J7FrCHU2MKh502FSfgrOdm6Yfyf9GvemvBciS1pTQH5my1TJjZItiVbWPWQ/slKqDZaFxzbwkqL1GMwx6DLUJlT5MqCUVh4N6giC+rV2TMEDAMyv2PuRHug0/ka8evvPPHu2aMztp3Ya9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=RVntNIXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oO/GIdjM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF66B2540099;
	Tue, 29 Apr 2025 16:03:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 29 Apr 2025 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745956990;
	 x=1746043390; bh=YmGmxW/3EzBEDDM5WhrpnGIZNKJhitZq/d0jkwAbi7U=; b=
	RVntNIXZI5DUa/NhOsTi7BBEN9uooMtsj1c4cxYVme6T8PAtzYXiDZ9Apr08h85p
	zHXSNRQfQjF6rSRyXVqBJ6hhrQ0j9xsiX/eRbaV88iOGeDUXZjTbN9K6kuO1HdKj
	mM5C3zyjIvEyZMtIkC0EZFvedEGFL/y7DGpCo+1QtI7bymCTP7uNhWbW88n0g/cm
	rrODQEGEf8y3CPnI7ZCGJMo7psFycSVOZJHPEYpN+4WEq+KB5pzjbXwMLyS7jqI4
	Vhc2+bwUc0ak1lINuiedi/EkbHe1qhOFVw8u3cA5oFI9v171UdOK9/yReFtuFMoI
	Dkq7jMOYci5uw96avhXrxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745956990; x=
	1746043390; bh=YmGmxW/3EzBEDDM5WhrpnGIZNKJhitZq/d0jkwAbi7U=; b=o
	O/GIdjMLHB9F43IW4NmRrb5RA3G+qWhYxxNpZlNM/U7CWiOhFQPW2O0YRtbxgB0l
	Wwa+I3E0dOiwrmJ2USbma7Xap3eKu/lf/AwueFDM+XDzHlEHHpuC17dBQ0G/2u1b
	UBgEbPmWY0M21Vn2v4LidEW67jFuHU+Vty5K+E1wvUFQbOlnlCml5oBt6Fz6sHgl
	Ww+Znt6wB/IXFEPs5L7tQ+BmtGSvLfeuigQzCTOMyynmUoSdd81b7G4dO9njjji/
	iHC0BEJWb3JaaeO2Exd3N6XvmsiQ/fX+6QEXjKsdkTE0lTTkYpi3OeeajTKr2BgC
	eXFh8SJ+7yTPMFRNWk8kw==
X-ME-Sender: <xms:fTARaKBsboOy54XcIacVFqR3vRVwxDzHhIoBxYcf20U3csgpyFy2FA>
    <xme:fTARaEgcElcG1liI7GZiVb_5-rg9CvqUMc2SrVrnCSojibck4jGVHeyvLZgQUFMES
    M3nNoq57Fq5HtFxaCE>
X-ME-Received: <xmr:fTARaNkS39EiSajLdt1GKt7LOGxGINjM_WY85LrgGIiht787wbH28WrZSgRdeU5Sp5dSqCUgoTNTI-aJJ1phc6o2yTEvzjy33w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffr
    rghtthgvrhhnpeffkefgudekgefhhfejtedviedtgeetieekffeiudfhgeevteejvedtff
    dvkefftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunh
    guodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhmrgdrfhgvughrrghusehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthht
    ohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    esrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrhgvghhorhdrhhgvrhgsuhhrgh
    gvrhesvgifrdhtqhdqghhrohhuphdrtghomh
X-ME-Proxy: <xmx:fTARaIxo2ZmuRmLRE5unf8F5cOoXqX9kHFTVaFjQ2Y7JE01xFvXZtQ>
    <xmx:fTARaPQP09pwXxFc62ffpEZ0ZQvV7Oc9wDSf_C3FP2BqLuPt_KiuUg>
    <xmx:fTARaDafCZoiKrBWFsMBZVQrDihzHymFUD4CWUwyeujQVjwj8cd9gw>
    <xmx:fTARaITfiEfo0bs1VGqlVSTp8j5baoRqqL38IwsX-8tiLiTCcMVkSA>
    <xmx:fjARaJbV1xMi2gI21JHobFYGTCu1AyKCmbjjSGVXU8ICWQgJSHNvmP5U>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 16:03:08 -0400 (EDT)
Date: Tue, 29 Apr 2025 22:03:06 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v3] net: phy: marvell-88q2xxx: Enable
 temperature measurement in probe again
Message-ID: <20250429200306.GE1969140@ragnatech.se>
References: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429-marvell-88q2xxx-hwmon-enable-at-probe-v3-1-0351ccd9127e@gmail.com>

Hi Dimitri,

Thanks for your work.

On 2025-04-29 08:54:25 +0200, Dimitri Fedrau wrote:
> Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
> mv88q222x_config_init with the consequence that the sensor is only
> usable when the PHY is configured. Enable the sensor in
> mv88q2xxx_hwmon_probe as well to fix this.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
> Changes in v3:
> - Remove patch "net: phy: marvell-88q2xxx: Prevent hwmon access with asserted reset"
>   from series. There will be a separate patch handling this and I'm not
>   sure if it is going to be accepted. Separating this is necessary
>   because the temperature reading is somehow odd at the moment, because
>   the interface has to be brought up for it to work. See:
>   https://lore.kernel.org/netdev/20250418145800.2420751-1-niklas.soderlund+renesas@ragnatech.se/
> - Link to v2: https://lore.kernel.org/r/20250220-marvell-88q2xxx-hwmon-enable-at-probe-v2-0-78b2838a62da@gmail.com
> 
> Changes in v2:
> - Add comment in mv88q2xxx_config_init why the temperature sensor is
>   enabled again (Stefan)
> - Fix commit message by adding the information why the PHY reset might
>   be asserted. (Andrew)
> - Remove fixes tags (Andrew)
> - Switch to net-next (Andrew)
> - Return ENETDOWN instead of EIO when PHYs reset is asserted in
>   mv88q2xxx_hwmon_read (Andrew)
> - Add check if PHYs reset is asserted in mv88q2xxx_hwmon_write as it was
>   done in mv88q2xxx_hwmon_read
> - Link to v1: https://lore.kernel.org/r/20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 5c687164b8e068f3f09e91cd4dd198f24782682e..5d2fbbf332933ffe06f4506058e380fbc7c52921 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -513,7 +513,10 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> -	/* Enable temperature sense */
> +	/* Enable temperature sense again. There might have been a hard reset
> +	 * of the PHY and in this case the register content is restored to
> +	 * defaults and we need to enable it again.
> +	 */
>  	if (priv->enable_temp) {
>  		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
>  				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> @@ -765,6 +768,13 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  	struct mv88q2xxx_priv *priv = phydev->priv;
>  	struct device *dev = &phydev->mdio.dev;
>  	struct device *hwmon;
> +	int ret;
> +
> +	/* Enable temperature sense */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
> +			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
> +	if (ret < 0)
> +		return ret;

nit: I wonder if it make sens to create a helper function to enable the 
sensor? My worry being this procedure growing in the future and only 
being fixed in one location and not the other. It would also reduce code 
duplication and could be stubbed to be compiled out with the existing 
IS_ENABLED(CONFIG_HWMON) guard for other hwmon functions.

That being said I tested this with mv88q211x and the temp sensor and PHY 
keeps working as expected.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  
>  	priv->enable_temp = true;
>  
> 
> ---
> base-commit: 0d15a26b247d25cd012134bf8825128fedb15cc9
> change-id: 20250217-marvell-88q2xxx-hwmon-enable-at-probe-2a2666325985
> 
> Best regards,
> -- 
> Dimitri Fedrau <dima.fedrau@gmail.com>
> 

-- 
Kind Regards,
Niklas Söderlund


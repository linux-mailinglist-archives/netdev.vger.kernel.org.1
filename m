Return-Path: <netdev+bounces-177928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D0A72FB5
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CC9189A20E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB6213256;
	Thu, 27 Mar 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyWXwfiz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713929D05;
	Thu, 27 Mar 2025 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075422; cv=none; b=flEibNlNCYw3yoCkWa7LOnXEv8X3s7bwIL4L/JQ01fNasgKIcIeR81rY5gNh/I3PPbVtTPRQm+0mb9UBP7YbZz5Ak008ZoGkzjYc0iFsL5RcBatsyRXI/7r32091Eiys6d2UIaTEhc2skeMTkI4mIkYSRRfhy0ViD2X/QG2rT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075422; c=relaxed/simple;
	bh=0+rGNCVyE2G9Fo80VXIix7ZuxwzG0BYmCw021feCSeY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD7icDYauH9NiwwHG4nn+8PPxhNd5oFmATNSG+9uF6rDN7PMIwU++lrWpyYIqxPA973CFJ9RAQXMFnsLO1mY7x0TKoyWibLmgs/6fPT9zprkW0mC8PLnxhlTqFya60Yw3rR5sDhz5bUdcgKITccxlbxPUmAmmckgdu6dIswYNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyWXwfiz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-391342fc1f6so666090f8f.1;
        Thu, 27 Mar 2025 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743075418; x=1743680218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cqx+VFV0EXqTaKDgpq5Iyn20kPWrHWuJdjfhxvwFdVI=;
        b=AyWXwfizXe583+wBW7oW1SgSrJtBzCSr1KKAMhPscXklBxjvovtl4Bddo+3oyhFxrG
         861a0trTbr8SbdcwEJlURMBwhXxObgsoHHAa9exYOgbR1rGQX0BXwgzH79X2NwzFSQna
         et+L6tv0A9YNY6PDlm1By6LNGbfjKTM7pXi7HH3kbFwxHA03CA3u9FWbzIvSOvrqfynC
         9wmPVGw9UNeBTblOUfqUhQcNobxVtkmNvx4SHcEOw1cH+BFXMTmWAcIlIciv1kHiEuGR
         +C2FGC6cJFRKoEFuyusGEvF11ZiTcXrN/ooPt6uCAtILG4ck7PBvOdbMtyZob1MTC0oA
         N5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743075418; x=1743680218;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqx+VFV0EXqTaKDgpq5Iyn20kPWrHWuJdjfhxvwFdVI=;
        b=oSSAvwyrma3j/LIKgISEpOZt9euLro2TNkUFfL9i2GKJ8XNq8xrOe65a2tYP1LMNBZ
         rshr7P0cV6t8wRM0dFP5/NlNFKCACgSF15tGpfC7HqmmE0rTUxOP+/qbCr8RmGC230eu
         IoabeHXjLEbJ6a9Hfv7AUJ4FPNSLxU/6cEtlApFyjKYlP4BHPOg0Ix8sdYmzrT3Izx7v
         4PnC1w6JsVwMyhYhU0W7yanHeqK/8nOZnRkhuy4QyzO+d+7EbKv5AQBrvfyD0dAho8ll
         ejP8uFWKf08joQfComK6FMScLuD7tEpDQ38+kQ9KTLsZsTlFyrN6m93HgTNsPWTvrzY+
         bzIA==
X-Forwarded-Encrypted: i=1; AJvYcCUcaIdmBTN0yo7XapKj8qIi0P8Sl4q01QQFyJhD3CzCwyR0muXDz/zBnW8B///UnxniL7TFEXro@vger.kernel.org, AJvYcCUuretTVykn9tGUUKuN2NtcYm+OJHpccE18+sGYWT4Dpt1R3XU0ZMoy9BtH97M55qQrggE+c5RYtni34P/9@vger.kernel.org, AJvYcCXalx+mjIjX1BB9j8lcnuaG0MjAAtsjaF10JEnSWfMvhzHxanfTMSFMxpDWLhm/gMy7Xh+sxsp/PHyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4wIEi+2H4WVT+JYcOe35haNny9M/8PjMIUXaGgtD1Hdtnl1E
	Kvk9+uDM5tSk7cBHTmuKFBNOQiCNhPg4Zmp0Kf/wwtIONG5Yr8D4
X-Gm-Gg: ASbGnct7o6Ac6fGYDIhZW7C3jRgzoE8lZiERnyFR8jLdk+sWdwBMC1ABCGVLaOJHgzY
	/iR6DkQO+xcV1kocW0dyeamVINfrv4a0A9q3tP4QWokMLOQ2hoi08n2R6cXo3jTDOo+qGAKMcQ5
	UfkXU8Tf8MiPs2s4N3xjrfM7CwpMDmYTwZSKdB5QpzKBE9rJCr3Tw1qG/TbEQhepb+ZqjPF6o0T
	PlCG5sKQ1YaVQTofflbXkHvENCZIUu+928J3icI//ADoI01j58MEJRz10ZJ944ILqplfIvjqKmW
	cqEGfKcSkrUAFaCHveG0STug74Q9sk24fJY0va8MdPjfkxCJtK9NijIXeQPx0S8id0tQbCSYahB
	1
X-Google-Smtp-Source: AGHT+IFgzcoHC81rvATMB3h3fjlry0xOIqdHCrTj77Z7v0BjoDD08znY3EjjRZf87ytCvtoB6xecYw==
X-Received: by 2002:a05:6000:1888:b0:390:e535:8758 with SMTP id ffacd0b85a97d-39ad173d214mr2871537f8f.9.1743075418298;
        Thu, 27 Mar 2025 04:36:58 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe9d1sm34898635e9.24.2025.03.27.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:36:57 -0700 (PDT)
Message-ID: <67e53859.050a0220.1a855c.24af@mx.google.com>
X-Google-Original-Message-ID: <Z-U4WLA-j_lvU90h@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 12:36:56 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-4-ansuelsmth@gmail.com>
 <Z-U1anj6IbSdPGoD@shell.armlinux.org.uk>
 <67e536e4.df0a0220.52fd8.a470@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e536e4.df0a0220.52fd8.a470@mx.google.com>

On Thu, Mar 27, 2025 at 12:30:42PM +0100, Christian Marangi wrote:
> On Thu, Mar 27, 2025 at 11:24:26AM +0000, Russell King (Oracle) wrote:
> > On Thu, Mar 27, 2025 at 12:35:03AM +0100, Christian Marangi wrote:
> > > +static int as21xxx_match_phy_device(struct phy_device *phydev,
> > > +				    const struct phy_driver *phydrv)
> > > +{
> > > +	struct as21xxx_priv *priv;
> > > +	u32 phy_id;
> > > +	int ret;
> > > +
> > > +	/* Skip PHY that are not AS21xxx or already have firmware loaded */
> > > +	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
> > > +		return phydev->phy_id == phydrv->phy_id;
> > 
> > Isn't phydev->phy_id zero here for a clause 45 PHY? If the firmware
> > has been loaded, I believ eyou said that PHY_ID_AS21XXX won't be
> > used, so the if() will be true, and because we've read clause 45
> > IDs, phydev->phy_id will be zero meaning this will never match. So
> > a PHY with firmware loaded won't ever match any of these drivers.
> > This is probably not what you want.
> 
> You are right. I will generalize the function to skip having to redo the
> logic. With FW loaded either c45 and c22 ID are filled in.
> 
> > 
> > I'd suggest converting the tail of phy_bus_match() so that you can
> > call that to do the standard matching using either C22 or C45 IDs
> > as appropriate without duplicating that code.
> > 
> > > +
> > > +	/* Read PHY ID to handle firmware just loaded */
> > > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	phy_id = ret << 16;
> > > +
> > > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID2);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	phy_id |= ret;
> > > +
> > > +	/* With PHY ID not the generic AS21xxx one assume
> > > +	 * the firmware just loaded
> > > +	 */
> > > +	if (phy_id != PHY_ID_AS21XXX)
> > > +		return phy_id == phydrv->phy_id;
> > > +
> > > +	/* Allocate temp priv and load the firmware */
> > > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&priv->ipc_lock);
> > > +
> > > +	ret = aeon_firmware_load(phydev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = aeon_ipc_sync_parity(phydev, priv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Enable PTP clk if not already Enabled */
> > > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> > > +			       VEND1_PTP_CLK_EN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = aeon_dpc_ra_enable(phydev, priv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_destroy(&priv->ipc_lock);
> > > +	kfree(priv);
> > > +
> > > +	/* Return not maching anyway as PHY ID will change after
> > > +	 * firmware is loaded.
> > 
> > Also "This relies on the driver probe order."
> > 
> > > +	 */
> > > +	return 0;
> > > +}
> > > +
> > > +static struct phy_driver as21xxx_drivers[] = {
> > > +	{
> > > +		/* PHY expose in C45 as 0x7500 0x9410
> > > +		 * before firmware is loaded.
> > 
> > Also "This driver entry must be attempted first to load the firmware and
> > thus update the ID registers."
> > 
> > > +		 */
> > > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> > > +		.name		= "Aeonsemi AS21xxx",
> > > +		.match_phy_device = as21xxx_match_phy_device,
> > > +	},
> > > +	{
> > > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
> > > +		.name		= "Aeonsemi AS21011JB1",
> > > +		.probe		= as21xxx_probe,
> > > +		.match_phy_device = as21xxx_match_phy_device,
> > > +		.read_status	= as21xxx_read_status,
> > > +		.led_brightness_set = as21xxx_led_brightness_set,
> > > +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> > > +		.led_hw_control_set = as21xxx_led_hw_control_set,
> > > +		.led_hw_control_get = as21xxx_led_hw_control_get,
> > > +		.led_polarity_set = as21xxx_led_polarity_set,
> > 
> > If I'm reading these driver entries correctly, the only reason for
> > having separate entries is to be able to have a unique name printed
> > for each - the methods themselves are all identical.
> > 
> > My feeling is that is not a sufficient reason to duplicate the driver
> > entries, which adds bloat (not only in terms of static data, but also
> > the data structures necessary to support each entry in sysfs.) However,
> > lets see what Andrew says.
> >
> 
> If you remember that was one of my crazy project in trying to reduce the
> array but I remember it did end up bad or abbandoned with the problem of
> having to reinvent each PHY. Probably my changes caused too much patch
> delta.
> 
> The proposal was exactly to pack all the struct that have similar OPs
> with introducing an array of PHY ID for each driver.
>

Found the old series. [1]

[1] https://lore.kernel.org/all/20240218190034.15447-1-ansuelsmth@gmail.com/

-- 
	Ansuel


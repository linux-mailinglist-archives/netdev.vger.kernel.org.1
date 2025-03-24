Return-Path: <netdev+bounces-177082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5EA6DCB3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1D5189150B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3025F985;
	Mon, 24 Mar 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4YrT3jJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631C25F96A;
	Mon, 24 Mar 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825777; cv=none; b=rUSLDQ5rUAA3hzbAHvJ0diQh4JlfX3KhaPitISvbIuDkOamC3WRGcmUUDBmjwtoJwaqacTYLhJR+CyKv3erjdJVJrZ81aaVM5U86Df/HqqThFMY2sE3uuI/c2rPlyWpEC3aTuq2+b2SZs6fwHEJAOi4CMplO9qOiKNuzsoTaUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825777; c=relaxed/simple;
	bh=UI+at1dE6F2/SG3eztaHvJ/gzEpXMxXX5flueMwlAAU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+8olWOAjSwhyklPmUbf0wPGTo7togPxApBderd419b8dFjVNfYD7Bc/3waLPHtHReWQiqJHBCsUe4bC2WXe1YeH4Y8rvYv3iVa0j2MQ5ud91YTP7Zq9dZ0EW84bertCaA+NOmVlwAx85HwkNInri1FT933c7YVgb8R7TgSaQMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4YrT3jJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso48924595e9.3;
        Mon, 24 Mar 2025 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825774; x=1743430574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sn62CaSajxktUQEvbcaHHO5zrosvUywDGqo16T1V0x4=;
        b=Y4YrT3jJPybiKxFgr40LbRFakMGYLhL89KZTi7/F+p9lg/ZOFvIlYdsP9BU61qy5Dx
         dF6JrIkS/z9r7nqlrJRgIEyj+Syc04yEqLyL6u0AXLvkP+V4wQhE/TAs+pWmJ4wZJV3Y
         Oc3hXUUpHnrYU3OIoKNOJZZGfho16gXxqAqg0Q6w2sEA49jd/kWGzy9/lORtatSRUoVU
         9sRSh44vxLsXkiv53bm3t7RXsyKRTIUv+XxMeJrIBPYYCNRMhnNQYEoEGyqExnn9d6q/
         /Ovm4cBXarFe0xy5IhVPPZua4PaHlJSSKOQzqI777vExkJY3byeRz6ECAqIBvQqhvqut
         ruPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825774; x=1743430574;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn62CaSajxktUQEvbcaHHO5zrosvUywDGqo16T1V0x4=;
        b=jynr/54K0oOgqifeU479ZkhGpHk+9/Mky8++M6ZUz9cGrMhbL9i1JUKsLIqoMWF6bS
         tXxhFewiAMa8cFb32ROwngeeNEaQIXBQdhIVTILAqd1EwifLltNTe/ipJHf/X9Owfs6z
         MgPmY1qn0qLMEMXxHO1T+zXEuGAzji366wV3/HPgpsf59EyiJOCRZxbIn738Mws59WNY
         1dVuDRcBzqHVYinPg9PzpmKtx4zsX9Pkicqoc6dsmbjr+JByVcAxnvadzbq4HWTYcWDp
         9eKOgq8zKRX6vtWVPtTTYkWxofwB76wOcuFC07fUv42h6PqISKJd7qJKn/T5j4z5wRWZ
         UbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURjhDeNGYx5Q2WWrNuknOpYFgWBoXW6uyNK35cjWXkg8t9gCksN82RKYMjNyLfOhf8Q3iOeeHfY2c/@vger.kernel.org, AJvYcCV+jbdzuLf4D0UbC8dfquBS5NXxbBWMpqiD/6jM6tLt0d+/zaPoJSFb+bI52j567i5f8K2wGq+dQiiYuY7t@vger.kernel.org, AJvYcCWh6Hrhj3M07XOxF+ex/fDahFG1+3Q4LZvChj1cxaL+3wO8zSJ6AC6aglAlKu9qJYv9QymLyXkg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy71xyAxTTyjb5jaWdCn0j/ClJhkG4MNi3arG8sAks0L4n1IBq
	VmdVGUhDwSF+XLa5vBLoy+5mUiCCAnJB+/qqrtDc6C39QQksCmBwiYiA+w==
X-Gm-Gg: ASbGnctbt8RQMnX1U7wRuTWanjifswy/47U/3ZFMej2BfKuCZH7BR/jeo4ObDTusN1j
	HP0QLcgV5lQxOhNdoDz3eSZyaRhkLmaRMH5jj7JmfMptN/xxOsFBUdIZHwXee6nJA+IPrpfajF4
	i0ilx5e8Ww1ceLU+/H34I5kEkkb2W1hJNk2K0/6y7vskqM5u1lNlS+1lOC4M1vlIjhLtdD2lyu1
	aacGhUT2+MQL4GM9XHTCo4RzNHr20ylkFyHen2HW9p+AYZ3pVnz25IhJcVlFomE6XoCWiJMVekf
	errkO4i/oRLr/P0+/VsmSa7OphdJRn8P+ZEI+jNpYtIW8cdoPBxRf+7cimMTzz8s2VsnUF72SZy
	lBOpn5nng4Xs=
X-Google-Smtp-Source: AGHT+IGRDlxtLOe5nyLYEFHw3JcD4BHEdGapRFbF/ncFnaTMRaniJ1CuJjp6h641TdEbHgEnMxVE5w==
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3997f8fc43dmr11439623f8f.15.1742825773176;
        Mon, 24 Mar 2025 07:16:13 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957aasm11253270f8f.10.2025.03.24.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:12 -0700 (PDT)
Message-ID: <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
X-Google-Original-Message-ID: <Z-FpKHG_WWOI8150@Ansuel-XPS.>
Date: Mon, 24 Mar 2025 15:16:08 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>

On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > before the firmware is loaded.
> 
> Does the value change after the firmware is loaded? Is the same
> firmware used for all variants?
>

Yes It does... Can PHY subsystem react on this? Like probe for the
generic one and then use the OPs for the real PHY ID?

> > +++ b/drivers/net/phy/Kconfig
> > @@ -121,6 +121,18 @@ config AMCC_QT2025_PHY
> >  
> >  source "drivers/net/phy/aquantia/Kconfig"
> >  
> > +config AS21XXX_PHY
> > +	tristate "Aeonsemi AS21xxx PHYs"
> 
> The sorting is based on the tristate value, so that when you look at
> 'make menuconfig' the menu is in alphabetical order. So this goes
> before aquantia.
> 

Tought it was only alphabetical, will move.

> > +/* 5 LED at step of 0x20
> > + * FE: Fast-Ethernet (100)
> > + * GE: Gigabit-Ethernet (1000)
> > + * NG: New-Generation (2500/5000/10000)
> > + * (Lovely ChatGPT managed to translate meaning of NG)
> 
> It might be a reference to NBase-T Gigabit.
> 

A better LED table was provided for this confirming ChatGPT assumption.
Will update the LED pattern as there were some mistake for activity
blink.

Also confirmed no way to make the LED only blink... It's sad cause the
blink time can be configured...

> Please add a comment somewhere about how locking works for IPCs. As
> far as i see, the current locking scheme is that IPCs are only called
> from probe, so no locking is actually required. But:
> 
> > +#define IPC_CMD_NG_TESTMODE		0x1b /* Set NG test mode and tone */
> > +#define IPC_CMD_TEMP_MON		0x15 /* Temperature monitoring function */
> > +#define IPC_CMD_SET_LED			0x23 /* Set led */
> 
> suggests IPCs might in the future be needed outside of probe, and then
> a different locking scheme might be needed, particularly for
> temperature monitoring.
> 

Indeed I will push temperature monitor in a followup patch so yes I will
add locking just for preparation of the additional feature.

> > +static int as21xxx_get_features(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	ret = genphy_read_abilities(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
> > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> > +			   phydev->supported);
> > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > +			   phydev->supported);
> > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> > +			   phydev->supported);
> 
> Does this mean the registers genphy_read_abilities() reads are broken
> and report link modes it does not actually support?
> 
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > +			 phydev->supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > +			 phydev->supported);
> 
> and it is also not reporting modes it does actually support? Is
> genphy_read_abilities() actually doing anything useful? Some more
> comments would be good here.
> 
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > +			 phydev->supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> > +			 phydev->supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> > +			 phydev->supported);
> 
> Does this mean genphy_c45_pma_read_abilities() also returns the wrong
> values?
> 

Honestly I followed what the SDK driver did for the get_feature. I will
check the register making sure correct bits are reported.

Looking at the get_status It might be conflicting as they map C22 in C45
vendor regs.

> > +static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
> > +{
> > +	int status;
> > +
> > +	*bmcr = phy_read_mmd(phydev, MDIO_MMD_AN,
> > +			     MDIO_AN_C22 + MII_BMCR);
> > +	if (*bmcr < 0)
> > +		return *bmcr;
> > +
> > +	/* Autoneg is being started, therefore disregard current
> > +	 * link status and report link as down.
> > +	 */
> > +	if (*bmcr & BMCR_ANRESTART) {
> > +		phydev->link = 0;
> > +		return 0;
> > +	}
> > +
> > +	status = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
> 
> No MDIO_AN_C22 + here? Maybe add a comment about which C22 registers
> are mapped into C45 space.
>

Nope, not a typo... They took the vendor route for some register but for
BMSR they used the expected one.

Just to make it clear, using the AN_C22 wasn't a choice... the C45 BMCR
reports inconsistent data compared to the vendor C22 one.

-- 
	Ansuel


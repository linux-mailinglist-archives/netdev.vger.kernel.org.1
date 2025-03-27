Return-Path: <netdev+bounces-177927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8CAA72F59
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FC23A6291
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E683210F4A;
	Thu, 27 Mar 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6uwCht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F519DF9A;
	Thu, 27 Mar 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075049; cv=none; b=KY/h9EOhiQEaVxmNruNbaVf7mYGmNZhc5VKwF98SAWwKDd5hVWSwYLlo3jW9aLkf0ppcRQY9/4y6fz/HmpPFQcDC94Y46VEqn5Z7IwQz4FVvqG0JQZdS6yEJe7PfhCtZgysuPHIcPZxYGED1evtyYSFkrnWkwnBu/aN/jmLSxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075049; c=relaxed/simple;
	bh=EHPAPo+AZfwZG+1db8kOeFFoN830kLP8ik9EeD2EBWs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtp8c2eST8JULsGmb0ZeNFgTD25MwdNO+LnhKwVAGIu7yi3pnkmiSvP2pdLIr5L9PVN/z1TqVl402WScZPf/i5XJ4N7lpuCm05SJRljhfRI5trppyKFrboCSLXvX8qqrBYrnYlS2+g8fJiCcec77UXui9BAxMjLF19AusT8fURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja6uwCht; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so8038585e9.3;
        Thu, 27 Mar 2025 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743075046; x=1743679846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z3xK7wMqbKOhgIgcAQyqb9TgqKuAwkkNyWljbOv4M7E=;
        b=Ja6uwChtVvY3Pl/Rk48iIZvJgrbKUkWOUD/yXskslDRBgMdjA3uWsDLVRuNRC358x7
         Tmx00rh3y5sMbTgJPIWlW3VIaH2fHrUK8WjnyCweN+nlvBktWEcC27ZSc+48XuHw+roD
         qZ0Uewdu8y4GxwkC56kVpPPEHRr55LZwsh2CzX8fkiiomYM1Y+sCCMJsNy+IGOSGR/Kp
         +KWPTzFIEhC2rN/KQ+2aYl7AFHq7WWANTLDDsot3vWwmu3yI6MD7QBWlRXzvp1mgubEH
         IDaldCYdaTytXTAPHhsj+ejGK5xZ2vgnQTlH7on3VZ/tXyNDq4J9dSsedgdeqDfZp0Fr
         ROSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743075046; x=1743679846;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3xK7wMqbKOhgIgcAQyqb9TgqKuAwkkNyWljbOv4M7E=;
        b=B4U0EjKhTzOy41GQS403ETfHE0zm+oRceBeeisSWcfiCAnkgPO+yIh6O5qGi4Dehr/
         vtdFAjaGSDhoLQ57Z+iUpDYXtdVEkyY3j0W8ONP3hn305BuuAUzyaIbyDNvmaRY/jfYB
         2mKArWygzJNd83nAbUyDSgFiquw3xPqy20+Q7ulMzwa9o/vL1gQXK6S+2THPoKjK5fWP
         hTZy5YdiqxovS0YUnWOrE8KvJUuVWaJ7QV0A7nabdvB5UIbAJBw3qKVDbOKVS+KtE+S5
         dLkPjXkTrz0ch6P4fPg2eN7fzf6kl7bDbsMJM0/1MA7zTRqctNoU5Sbxu0aVl8Lxzci2
         higQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv87ypUVQ0qfqjB1BP7Xbp8xNomh8AC+ylf7QJoVLs3EcE+XRBRMu/HHGkk57s60pSwq9pNShX@vger.kernel.org, AJvYcCWKd+LjXrZtpp7zFj9XJ034VKW1F9tjjN9gs04uZUoc4hAgqanKxsj6TBj42T+SkXw+SR38znbPktd3k5uJ@vger.kernel.org, AJvYcCXtYkfyjtkPgSQXGGtWSKVI0vrohfVnTJyIdzC75utVQdjtft6dRAOZhq9M7f+FM5A9kSo33Uyb3sGj@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5cJ1crHBfXh9bf9DAiQrx5nRSDZmDgurYbhrnHaGHKyZg4dQ
	NMjfVPkBTAmweGfa7zOfvAOlEhQZhXhhyDxwQd7J0eYtJCPQTjFM
X-Gm-Gg: ASbGncvRUixoMtzWKcL+sGRfiGiTfPRheuDnXh76ydlWpE2JCGLngbB6s9HAGEjG+GW
	lC5QSdRaO1BL7ED10zotUSXPT0FqXhl+0I3T1JLRe0i6wyVD2xUp3eEns48i50XWnDml6Xa1lAs
	vsN67w7T85E0FqZK3GmVjrYIUgk3rZteikp6vyDBUsZemYJ2kEFi9/PiviFWrTDC7OLsG/JOIRP
	cjaaVTN3vX9Fgr0H5OCJ8Tr1ldZSuAm2Q1upv9NcdHVdP/7YbPJ1IG+IPfUKLG3bbG8eUKrJ7hM
	OtccIy1N3HPYuTb1uUYgWydfMijnpeWIkuNaB/gdMn9ewxqjSsVDCAb8njQ+p489S0qqhWPD2af
	a
X-Google-Smtp-Source: AGHT+IGAF7W6hH8zbCBen6FZhnftGci+tZTH4OAUOvOOonp0UwrzmwJR8ICQX/L+6Dos+txRbTtdpQ==
X-Received: by 2002:a5d:64c7:0:b0:391:298c:d673 with SMTP id ffacd0b85a97d-39ad1783f3fmr3156801f8f.40.1743075045500;
        Thu, 27 Mar 2025 04:30:45 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c90sm20197828f8f.36.2025.03.27.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:30:44 -0700 (PDT)
Message-ID: <67e536e4.df0a0220.52fd8.a470@mx.google.com>
X-Google-Original-Message-ID: <Z-U24pdejqZ7uOY_@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 12:30:42 +0100
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-U1anj6IbSdPGoD@shell.armlinux.org.uk>

On Thu, Mar 27, 2025 at 11:24:26AM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 27, 2025 at 12:35:03AM +0100, Christian Marangi wrote:
> > +static int as21xxx_match_phy_device(struct phy_device *phydev,
> > +				    const struct phy_driver *phydrv)
> > +{
> > +	struct as21xxx_priv *priv;
> > +	u32 phy_id;
> > +	int ret;
> > +
> > +	/* Skip PHY that are not AS21xxx or already have firmware loaded */
> > +	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
> > +		return phydev->phy_id == phydrv->phy_id;
> 
> Isn't phydev->phy_id zero here for a clause 45 PHY? If the firmware
> has been loaded, I believ eyou said that PHY_ID_AS21XXX won't be
> used, so the if() will be true, and because we've read clause 45
> IDs, phydev->phy_id will be zero meaning this will never match. So
> a PHY with firmware loaded won't ever match any of these drivers.
> This is probably not what you want.

You are right. I will generalize the function to skip having to redo the
logic. With FW loaded either c45 and c22 ID are filled in.

> 
> I'd suggest converting the tail of phy_bus_match() so that you can
> call that to do the standard matching using either C22 or C45 IDs
> as appropriate without duplicating that code.
> 
> > +
> > +	/* Read PHY ID to handle firmware just loaded */
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
> > +	if (ret < 0)
> > +		return ret;
> > +	phy_id = ret << 16;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID2);
> > +	if (ret < 0)
> > +		return ret;
> > +	phy_id |= ret;
> > +
> > +	/* With PHY ID not the generic AS21xxx one assume
> > +	 * the firmware just loaded
> > +	 */
> > +	if (phy_id != PHY_ID_AS21XXX)
> > +		return phy_id == phydrv->phy_id;
> > +
> > +	/* Allocate temp priv and load the firmware */
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&priv->ipc_lock);
> > +
> > +	ret = aeon_firmware_load(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_ipc_sync_parity(phydev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable PTP clk if not already Enabled */
> > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> > +			       VEND1_PTP_CLK_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_dpc_ra_enable(phydev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_destroy(&priv->ipc_lock);
> > +	kfree(priv);
> > +
> > +	/* Return not maching anyway as PHY ID will change after
> > +	 * firmware is loaded.
> 
> Also "This relies on the driver probe order."
> 
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static struct phy_driver as21xxx_drivers[] = {
> > +	{
> > +		/* PHY expose in C45 as 0x7500 0x9410
> > +		 * before firmware is loaded.
> 
> Also "This driver entry must be attempted first to load the firmware and
> thus update the ID registers."
> 
> > +		 */
> > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> > +		.name		= "Aeonsemi AS21xxx",
> > +		.match_phy_device = as21xxx_match_phy_device,
> > +	},
> > +	{
> > +		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
> > +		.name		= "Aeonsemi AS21011JB1",
> > +		.probe		= as21xxx_probe,
> > +		.match_phy_device = as21xxx_match_phy_device,
> > +		.read_status	= as21xxx_read_status,
> > +		.led_brightness_set = as21xxx_led_brightness_set,
> > +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> > +		.led_hw_control_set = as21xxx_led_hw_control_set,
> > +		.led_hw_control_get = as21xxx_led_hw_control_get,
> > +		.led_polarity_set = as21xxx_led_polarity_set,
> 
> If I'm reading these driver entries correctly, the only reason for
> having separate entries is to be able to have a unique name printed
> for each - the methods themselves are all identical.
> 
> My feeling is that is not a sufficient reason to duplicate the driver
> entries, which adds bloat (not only in terms of static data, but also
> the data structures necessary to support each entry in sysfs.) However,
> lets see what Andrew says.
>

If you remember that was one of my crazy project in trying to reduce the
array but I remember it did end up bad or abbandoned with the problem of
having to reinvent each PHY. Probably my changes caused too much patch
delta.

The proposal was exactly to pack all the struct that have similar OPs
with introducing an array of PHY ID for each driver.

-- 
	Ansuel


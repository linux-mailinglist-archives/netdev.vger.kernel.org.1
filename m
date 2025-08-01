Return-Path: <netdev+bounces-211351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7223B1821E
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B41883E88
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3078247284;
	Fri,  1 Aug 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6yOPVay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D055247281;
	Fri,  1 Aug 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053468; cv=none; b=Ub2Ww2nbG9hsWD4pVSutHZrPwZXejkrMs0KzXoYxEIREkPDUbbC4tDlDdc+UkcDroFTCI2Aa++nPu4zXVrB37M1H2qWa8653CnDkZw5LKM+Tq4vF2aYnraDgDuz2Hov7OhpfD+4fBR97ecdHpT61KOB6tyX1jNrX/ZZc4MZ3a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053468; c=relaxed/simple;
	bh=hklL07b+0CTtkzWczUoSMbRgIk1dCU4/BW8hVpuQ3v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlgxMljXaB29snvsGZNtkY7Sb2XUPvHcfNsNWwyGe9xJFAmXpufy2ZrjAassXD2A62XiRRjdbFDMcXxZhmRoiAdbiwDHswdktShzlwhuXwsTjZ3au2h5qj0h+6aYgTlrqQ7p+efdXUR4Y3TYL+iNSPJo83s024cyqEM4WW02gVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6yOPVay; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45617a1bcdcso3593595e9.1;
        Fri, 01 Aug 2025 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053464; x=1754658264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUesSOzkSssAd9HS+Z1SdyOtRSbJf7OIvCg+b7BgFww=;
        b=E6yOPVayIWfY+yUTxGEK31MCXQIBRWzajSTDj6m7qhRStSfKHbJ0EidmrctCuT+1DS
         KzmoF4oldmRSY2VcBraMOnHPQUSM2EktNdbToyZNTi85SmLDHp3XDNB/lHlEDCPjw1AS
         NgCJY/Ry6yYs2p/XORQ9HCVHMmfpxBmgoXjxjl/ztQ/BGHQyqyI7eABrCWjPMGXT6Zuo
         0fSMaCuKSrAWZm7zChwWehxJf8b21tNr/YTDQJv5Q1WGA+NXh/2Iok4jJzo+csQuso5l
         JpwJLhWrlZy1sWfHD+JfKLpvSShkLGqMhn4/O+nsb4u5vo9THj3nr6Vy3NajIkB8gmPI
         F0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053464; x=1754658264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUesSOzkSssAd9HS+Z1SdyOtRSbJf7OIvCg+b7BgFww=;
        b=wXppgecvxQyjwKEy1x1D59xf2ZbpZo5aLuvF9/F4zkpQbwe9phi8fwQaI3IEU0XYpG
         UUL5eEK/yjKarr3uRy82W+en1ivKaEZhT/565A7BipK4HzNkEuorB+KaGz3ifR8jEB0t
         gSS2HJer37FBajgyp8B03xdZDkrmZZOa/wKdM0OOnTcm0yN2ycLC5hhdKADFvq+hOnNI
         8I7l7huFtGnJRXo8+9TOqjzddPy3yAh5ZINa7R2JMwIAQoKNsaNfWsMZiDeKq+d6MS40
         vNaP86lGCpAHb/54ZU9wic+duaY17Y+cwBlZpdwon1woF+Aub+gDpI8epQ2fspWiJqEo
         nzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUafVbN7zbxaqWzTF3afIWeWGQSP7CzYeAH8PdlUWuB5vfxgw6rfZrEqnqB3NNx236d/ilkw4LG@vger.kernel.org, AJvYcCWYz25moR1CACguwiRw2vbRPXJXQEoRqx79zVDC34eoGwC9sWof7BjCKUgfm2nIKFsnrSEOc1bzlOfuvGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITVShQ60EblUFSPnKHE4QZySivmLKk8wnq3QckzuEtrOSTI7W
	HwicEV6mul+Ycv3D68Z6ISviVZwxMpq7J9jx07GDncJerT2gxyyXO+4f
X-Gm-Gg: ASbGnctlA0whLDfkPa5jM8lbkh5a2jhjZfwvgWNg76P+pwARo5auT+MNTVujc0BFDMd
	HiCaHJ3O1gJAzlUuiojBDesogAvhwPFnP3ZB2ltlAreKGE/T5VAxeN0iwLzHLNpBJyTtq5IKNqq
	bgxnyPo8tAGb0cgSrNJqu8vRg0W+4Ar3mqNy0qKUszW7Z5eQBZlx2J+mc4206D9isXPEqlA4VgJ
	BUdOYrxyz1H3cUUTsLJvEDM1L1PXWWaGUGUALwn1cYfrfea8+Uclfu1bQLMcxilJW/248L/3gGC
	Muq72FFW2PHCP3VlZrWLRcArcbNDuboeTxOqRLscW6H86sSmCIuRk+sDj6XTlgw0l76kHPUtgRo
	jDApbTNf16poV7l0=
X-Google-Smtp-Source: AGHT+IHoHoSxN4+QLjvax37vtM5tSSfg4yuohG5h/kV9PN+wb0rNdj6QW5yv5GbkTQHJxma6MC0/ow==
X-Received: by 2002:a05:600c:4e0e:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-4589e9ff525mr11864175e9.5.1754053463842;
        Fri, 01 Aug 2025 06:04:23 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:b5a7:e112:cd90:eb82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c467994sm5796209f8f.50.2025.08.01.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:04:23 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:04:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
 <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>

On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> It looks like memac_select_pcs() and memac_prepare() fail to
> handle 2500BASEX despite memac_initialization() suggesting the
> SGMII PCS supports 2500BASEX.

Thanks for pointing this out, it seems to be a regression introduced by
commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").

If there are no other volunteers, I can offer to submit a patch if
Alexander confirms this fixes his setup.

> It would also be good if the driver can also use
> pcs->supported_interfaces which states which modes the PCS layer
> supports as well.

The current algorithm in lynx_pcs_create() is too optimistic and
advertises host interfaces which the PCS may not actually support.

static const phy_interface_t lynx_interfaces[] = {
	PHY_INTERFACE_MODE_SGMII,
	PHY_INTERFACE_MODE_QSGMII,
	PHY_INTERFACE_MODE_1000BASEX,
	PHY_INTERFACE_MODE_2500BASEX,
	PHY_INTERFACE_MODE_10GBASER,
	PHY_INTERFACE_MODE_USXGMII,
};

	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);

I am concerned that if we add logic to the MAC driver which does:

		phy_interface_or(config->supported_interfaces,
				 config->supported_interfaces,
				 pcs->supported_interfaces);

then we depart from the physical reality of the board and may end up
accepting a host interface which we should have rejected.

There is downstream code which refines lynx_pcs_create() to this:

	/* In case we have access to the SerDes phy/lane, then ask the SerDes
	 * driver what interfaces are supported based on the current PLL
	 * configuration.
	 */
	for (int i = 0; i < ARRAY_SIZE(lynx_interfaces); i++) {
		phy_interface_t iface = lynx_interfaces[i];

		err = phy_validate(lynx->serdes[PRIMARY_LANE],
				   PHY_MODE_ETHERNET, iface, NULL);
		if (err)
			continue;

		__set_bit(iface, supported_interfaces);
	}

but the infrastructure (the SerDes driver) is currently lacking upstream.


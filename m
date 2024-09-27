Return-Path: <netdev+bounces-130144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00D988936
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EEB281A29
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AC1C0DDC;
	Fri, 27 Sep 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQvCQpdU"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F05234;
	Fri, 27 Sep 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455088; cv=none; b=HHjMGopdS5AGFaXiWbu7pk+agvOdn47k5BZG5GHkgcjSsbFOWTg3MuhCLSAsqOCmJT1chFoH0kz3EKk8stEXhsUwcTrcXdzLLJfBQEwHViUr1mEKcFNvpxsLY9YytYHdiGC+1vbIl0EIhbllih+tTGQenkTEFiayWdtunoAvMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455088; c=relaxed/simple;
	bh=oMMgZasyjwbgBtBbPugjBrjHCR3Muzq/t56L9musDps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqgLjCjMORx2gp/YoVaHqDpGkEanAAzJlX9xgdwUvqoBZolXecveNmEx5tp6EFVIB4qs2VOFQ3WxQtNM6tEy4SWQrUhL7mC7LGKbXBdUZNvCfTA/He6mFus3mYx2/HwxJOltLXoNH+uwfQ88HQcp7Si3rY0HvDtH352Rauf4YaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQvCQpdU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 555AC1BF207;
	Fri, 27 Sep 2024 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727455079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glVgptwsGapTQILgbrhz4NgHpHzm+T7wOD6Ai2rnQlc=;
	b=VQvCQpdUQB8nsXkeePUDxdZRYIIhuF3ipBrUk2agR49KZQEpR16Iv8t3BppRm1VH7SF1Y/
	GiyddKX71Oj0w4NHzjXN+jidGweaMGtMxE49/Mk1KVTjTl/cT0hR3AOKaMpiaVnUPFLgJq
	OfreJOuJN/PzhRtoNV4sjY+ooVxs2XL9oVC6aSjS2fwvJcoKM2QB5umJPtiKFKydaiIHlQ
	gXkMYE7R8v74SPEo0FYn9hb5MHF8AX220l/xCUkZ7618LApPcld9+STwNCfYQl5d/nWStS
	Cmx/ABwfoMmdVVlMrnXAjQ6eqJf0IENkWtie5xNIKe7aVXTrIdmjD7RW480hrg==
Date: Fri, 27 Sep 2024 18:37:56 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jon Hunter <jonathanh@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, kernel@quicinc.com
Subject: Re: [PATCH net v4 2/2] net: phy: aquantia: remove usage of
 phy_set_max_speed
Message-ID: <20240927183756.16d3c6a3@fedora.home>
In-Reply-To: <20240927010553.3557571-3-quic_abchauha@quicinc.com>
References: <20240927010553.3557571-1-quic_abchauha@quicinc.com>
	<20240927010553.3557571-3-quic_abchauha@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Thu, 26 Sep 2024 18:05:53 -0700
Abhishek Chauhan <quic_abchauha@quicinc.com> wrote:

> Remove the use of phy_set_max_speed in phy driver as the
> function is mainly used in MAC driver to set the max
> speed.
> 
> Instead use get_features to fix up Phy PMA capabilities for
> AQR111, AQR111B0, AQR114C and AQCS109
> 
> Fixes: 038ba1dc4e54 ("net: phy: aquantia: add AQR111 and AQR111B0 PHY ID")
> Fixes: 0974f1f03b07 ("net: phy: aquantia: remove false 5G and 10G speed ability for AQCS109")
> Fixes: c278ec644377 ("net: phy: aquantia: add support for AQR114C PHY ID")
> Link: https://lore.kernel.org/all/20240913011635.1286027-1-quic_abchauha@quicinc.com/T/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

[...]

> +static int aqr111_get_features(struct phy_device *phydev)
> +{
> +	unsigned long *supported = phydev->supported;
> +	int ret;
> +
> +	/* Normal feature discovery */
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* PHY FIXUP */
> +	/* Although the PHY sets bit 12.18.19, it does not support 10G modes */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, supported);
> +
> +	/* Phy supports Speeds up to 5G with Autoneg though the phy PMA says otherwise */
> +	linkmode_or(supported, supported, phy_gbit_features);
> +	/* Set the 5G speed if it wasn't set as part of the PMA feature discovery */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);

As you are moving away from phy_set_max_speed(phydev, 5000), it should mean
that what used to be in the supported bits already contained the
5GBaseT bit, as phy_set_max_speed simply clears the highest speeds.

In such case, calling the newly introduced function from
patch 1 should be enough ?

Thanks,

Maxime


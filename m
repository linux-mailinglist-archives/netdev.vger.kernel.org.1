Return-Path: <netdev+bounces-113859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC299401C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E251C2200A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4F18F2DC;
	Mon, 29 Jul 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vZoE0vtI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CE7E1;
	Mon, 29 Jul 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296373; cv=none; b=ZJO+PyxB8ZN0kbN+ZmP1ArajhKUW14ngsW6Lmh9CSNzeOhfGl6CIlBTiVJdqGUmt3JE0NezhW2pCujdw28UE2IHm3jgBfi7/ZqOworQfArcqKxf5g69WExovtSq0/T5u80hahwSXMULqNW9sdhIKm5xfwbd3+DT9t8QpFMvhnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296373; c=relaxed/simple;
	bh=oWZ3IYgzKT6CnlOSYJcLs3DHWI2QuVDBZuog8IoRvSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKQec8xhXKL5owo0Po/qsWrh7YK7kKio2tn7M7C+1xYX+XIhh68H4xol0fBaGy4WiZN7Vku78UOLi+jXkRqE9B1C+FmvldEzI19fLhxmrib675aGBm8P1gxpEut9so24l8tcCBKLrULTIYJO1HfJCYOcSqE5NCLlf7v6T42QWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vZoE0vtI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LMjXLw4I49235k9Hi/bPaVIFeEwbQQwxpJC/Qsvb5RM=; b=vZoE0vtIZ8SERB9oJeOXQG8egc
	LH5Zwd5UEAcgcRE3dQCoDuiC1Ibj3eiPsORN/wGhtWQVaoNH/kNtpkb5ULWuJnF48XyON1nyUopMp
	9EABDD38l4GxZWwq/Xs9WletZO6og7dmJHA5PS/6VQOcxdgbLQHUiPRFkli4MjrJP9mGe2OfiezYk
	f5oYeSU/Xm9uz6Vy5cbxumOuIij9nD65roF2aeT6gSDVfg0lWf7Dt5/qNGc7mM1U9UKP03YZ0dOgb
	fNIt9J9+E1ImiMlReaIsDIEQ4h6kZsBPP/PbQSJu9QsWnZL/A19cnZtXqWl0+f7PBsu2KZXK4RLZc
	wwZTTR9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55872)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYZxY-0005c5-2d;
	Tue, 30 Jul 2024 00:39:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYZxc-0004jq-Bs; Tue, 30 Jul 2024 00:39:24 +0100
Date: Tue, 30 Jul 2024 00:39:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: phy: vitesse: implement downshift in
 vsc73xx phys
Message-ID: <ZqgoLC77GeJ1yyYq@shell.armlinux.org.uk>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-10-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-10-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 29, 2024 at 11:06:15PM +0200, Pawel Dembicki wrote:
> +static int vsc73xx_get_downshift(struct phy_device *phydev, u8 *data)
> +{
> +	int page, val, cnt, enable;
> +
> +	page = phy_select_page(phydev, MII_VSC73XX_EXT_PAGE_1E);
> +	if (page < 0)
> +		return page;
> +
> +	val = __phy_read(phydev, MII_VSC73XX_PHY_CTRL_EXT3);
> +	if (val < 0)
> +		goto restore_page;
> +
> +	enable = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN, val);
> +	cnt = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT, val) + 2;
> +
> +	*data = enable ? cnt : DOWNSHIFT_DEV_DISABLE;
> +
> +restore_page:
> +	phy_restore_page(phydev, page, val);
> +	return 0;

If you're going to use phy_select_page()..phy_restore_page(), please
read the documentation. If the __phy_read() fails, then you're
returning zero from this function, but leaving *data uninitialised.
Surely not what you want.

In any case, this complexity is unnecessary.

static int vsc73xx_get_downshift(struct phy_device *phydev, u8 *data)
{
	int val, enable, cnt;

	val = phy_read_paged(phydev, MII_VSC73XX_EXT_PAGE_1E,
			     MII_VSC73XX_PHY_CTRL_EXT3);
	if (val < 0)
		return val;

	enable = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN, val);
	cnt = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT, val) + 2;

	*data = enable ? cnt : DOWNSHIFT_DEV_DISABLE;

	return 0;
}

is all that it needs.

> +}
> +
> +static int vsc73xx_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	int page, ret, val;
> +
> +	if (cnt > MII_VSC73XX_DOWNSHIFT_MAX)
> +		return -E2BIG;
> +	else if (cnt == MII_VSC73XX_DOWNSHIFT_INVAL)
> +		return -EINVAL;
> +
> +	page = phy_select_page(phydev, MII_VSC73XX_EXT_PAGE_1E);
> +	if (page < 0)
> +		return page;
> +
> +	if (!cnt) {
> +		ret = __phy_clear_bits(phydev, MII_VSC73XX_PHY_CTRL_EXT3,
> +				       MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN);
> +	} else {
> +		val = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
> +		      FIELD_PREP(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
> +				 cnt - 2);
> +
> +		ret = __phy_modify(phydev, MII_VSC73XX_PHY_CTRL_EXT3,
> +				   MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
> +				   MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
> +				   val);
> +	}
> +
> +	ret = phy_restore_page(phydev, page, ret);
> +	if (ret < 0)
> +		return ret;

This is also needlessly over-complex.

	u16 mask, val;

	...

	mask = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN;

	if (!cnt) {
		val = 0;
	} else {
		mask |= MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT;
		val = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
		      FIELD_PREP(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
				 cnt - 2);
	}

	ret = phy_modify_paged(phydev, MII_VSC73XX_EXT_PAGE_1E,
			       MII_VSC73XX_PHY_CTRL_EXT3, mask, val);
	if (ret < 0)
		return ret;

Would be equivalent to your code above, only simpler.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


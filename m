Return-Path: <netdev+bounces-143264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4623A9C1BE1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16EFB22424
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550501E2831;
	Fri,  8 Nov 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c1xowD7s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620891D0400;
	Fri,  8 Nov 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064187; cv=none; b=r8qBa7BEp8qcbp+ey2slxp4LfXJnh6tCpLq0i4LYYF8bgAkS8HEbkJcR18R2lbG6Hm4zoWqxaMaaW1HYxsyUeWAcUJM/DIiGKQ9L4qWsaRVM7pqxODaeG44RZ5hSBe1ue1UhrP+Sf8GVhboN7VsgQpq5aiBq0FbGKNbNM5ApqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064187; c=relaxed/simple;
	bh=clnanh8taykWM/pNRBjvl0RzxbskTo+dn00sfc90TeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQKDlRjI/tdTWiO95k+7WMRiMYgUjpEN8LSJwhX3Lnyd7/1kexVNRmieSxfa/kbVwF4O2wEXCIYd5kQtkrFzOkgL66bUgaGTuH7G96eUYU2O3he/VU2D8tJN5QI8JP9VALaAghKo56C1MBDXDO5m2apFJ6oHtcA3P8aQBEYqtws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c1xowD7s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XulOllBIkuytFC+Y8jjBL4AZiw+lKhgqpGZMJSaBx5k=; b=c1xowD7s4OuJURB6/lfb3SpnaM
	WCf+aB8UmNdac55vpex+o8Z4RQxK3FPf7BaUvS3r9k4rnVslK0z49jwLb/WjuUCazjE78wGNNcQUg
	U+i9FcmUCfXGvWlFZcYTXhbH5QEcuEQ2BlyxacYunkZSSOpiiTYje7VyI7PZYl+xIUls7OsGhYEcE
	SOjOS2pZ1DhtQv8jGu5HWWtkQH3/E2DHnEdNnZyoFKKgoF9pALFMgjUsgGY9QM1wUpUaMa20JI0fb
	qGDoN0d4LJmWqcP22iXd73XqPWk92zq073ALIAv2fKHzkJkRt4jqD5EhycRwy3VBshLroYG63IjGr
	X85XvVKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43764)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9Mrt-0004yj-0n;
	Fri, 08 Nov 2024 11:09:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9Mrq-0002ER-17;
	Fri, 08 Nov 2024 11:09:30 +0000
Date: Fri, 8 Nov 2024 11:09:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v3 3/3] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <Zy3xaviqqT6X8Ows@shell.armlinux.org.uk>
References: <20241106122254.13228-1-ansuelsmth@gmail.com>
 <20241106122254.13228-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106122254.13228-4-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 06, 2024 at 01:22:38PM +0100, Christian Marangi wrote:
> +/* MII Registers Page 1 */
> +#define AN8855_PHY_EXT_REG_14			0x14
> +#define   AN8855_PHY_EN_DOWN_SHFIT		BIT(4)

Shouldn't "AN8855_PHY_EN_DOWN_SHFIT" be "AN8855_PHY_EN_DOWN_SHIFT"
(notice the I and F are swapped) ?

> +static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
> +{
> +	int saved_page;
> +	int val;
> +	int ret;
> +
> +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> +	if (saved_page >= 0)
> +		val = __phy_read(phydev, AN8855_PHY_EXT_REG_14);
> +	ret = phy_restore_page(phydev, saved_page, val);
> +	if (ret)
> +		return ret;

This function is entirely broken.

phy_restore_page() will return "val" if everything went successfully,
so here you end up returning "val" via this very return statement
without executing any further code in the function. The only time
further code will be executed is if "val" was successfully read as
zero.

Please use the helpers provided:

	ret = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
			     AN8855_PHY_EXT_REG_14);
	if (ret < 0)
		return ret;

ret now contains what you're using as "val" below. No need to open code
phy_read_paged().

> +
> +	*data = val & AN8855_PHY_EXT_REG_14 ? DOWNSHIFT_DEV_DEFAULT_COUNT :
> +					      DOWNSHIFT_DEV_DISABLE;

Here, the test is against the register number rather than the bit that
controls downshift. Shouldn't AN8855_PHY_EXT_REG_14 be
AN8855_PHY_EN_DOWN_SH(F)I(F)T ?

> +static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	int saved_page;
> +	int ret;
> +
> +	saved_page = phy_select_page(phydev, AN8855_PHY_PAGE_EXTENDED_1);
> +	if (saved_page >= 0) {
> +		if (cnt != DOWNSHIFT_DEV_DISABLE)
> +			ret = __phy_set_bits(phydev, AN8855_PHY_EXT_REG_14,
> +					     AN8855_PHY_EN_DOWN_SHFIT);
> +		else
> +			ret = __phy_clear_bits(phydev, AN8855_PHY_EXT_REG_14,
> +					       AN8855_PHY_EN_DOWN_SHFIT);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);

This entire thing can be simplified to:

	u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHFIT: 0;

	return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
				AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHFIT,
				ds);

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-69653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949384C112
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D96B211DA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11D1CD2C;
	Tue,  6 Feb 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H9fADHq1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4C1CD28;
	Tue,  6 Feb 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263662; cv=none; b=uZT84RizyAMB5j6CZvws/L5qD4hX309NPFKzlyBqG3jHN2CL0zbeczn3DrtTfhsU/XVWOiBPIHT6bbV8zVuT4cFf4AvCV3TWGULSi/Hom4+ezk/+CXeTJzZHhMBYWq4FlqAuSKT1+9sGUzqQ0/APkX2rqoyRRadhp75xxfenqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263662; c=relaxed/simple;
	bh=wzHdeRKX9FrJ0vRX8/2rbMQdh6OntB2aO6NkRNnexNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHMVOvd7MFhIjxZFLDB83l2Xp3jGfgFmyVledzTbJR0XQKGsJJTQqdNZROnVpS36IRw5ZvPq0OoDvEcgTOZ2ITYjRxSKuESzOd5WkM3BKLGWmyXrvLun33jf6ES5pg+gZKyGl13iFhBub3VDvHn1GQ7YjwF/A8fgP6TPDScuRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H9fADHq1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UZHyvLiT6YFAkY/ZGVAo0Ex/+fn1TlnEbxC5OBnf7gM=; b=H9fADHq1GJXTnJ1SQL7W2q/0ga
	McvqYR4Rsv53xUrWysAWoYaYtoiGX43nWOw+zrWfiOrtETtF3PUB5P33qQP72v2CibuIZ4i6h8Sp4
	f15ROyTz+2nRW/EUBkZqCTKhifs92bHv6WjerB4dIpa60s5s/emRZo4rxHH0VN6GUz0/cSJl4t9SK
	rm2aIksDt68dlklnPqeEYfJlDN0TAE74YeEBqOjFCqiWyTwxpyN36TDqIhZfuCbzhqvyqgKM5f4Ri
	HKO44mN1q2faLg1NCXtt9bcGnxKfr+pjrrmAvKbIlRkuhCteZfgMoh6gB+xPrr/h9YHYAWpLLjq8v
	mRtr4SBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rXVGK-0002dJ-1m;
	Tue, 06 Feb 2024 23:54:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rXVGE-00041V-Ea; Tue, 06 Feb 2024 23:53:54 +0000
Date: Tue, 6 Feb 2024 23:53:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <ZcLGkmavpBAN02xq@shell.armlinux.org.uk>
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206194751.1901802-3-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 06, 2024 at 08:47:51PM +0100, Eric Woudstra wrote:
> +static const unsigned long en8811h_led_trig = (BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +					       BIT(TRIGGER_NETDEV_LINK)        |
> +					       BIT(TRIGGER_NETDEV_LINK_10)     |
> +					       BIT(TRIGGER_NETDEV_LINK_100)    |
> +					       BIT(TRIGGER_NETDEV_LINK_1000)   |
> +					       BIT(TRIGGER_NETDEV_LINK_2500)   |
> +					       BIT(TRIGGER_NETDEV_RX)          |
> +					       BIT(TRIGGER_NETDEV_TX));

Cosmetic: extra parens around bitwise OR is not necessary.

...
> +static int air_buckpbus_reg_write(struct phy_device *phydev,
> +				  u32 pbus_address, u32 pbus_data)
> +{
> +	int ret, saved_page;

	int saved_page;
	int ret = 0;

> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);

	if (saved_page >= 0) {
> +
> +	ret = __air_buckpbus_reg_write(phydev, pbus_address, pbus_data);
> +	if (ret < 0)
> +		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +			   pbus_address, ret);

	}

> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +;

Cosmetic: unnecessary ;

> +}
> +
> +static int __air_buckpbus_reg_read(struct phy_device *phydev,
> +				   u32 pbus_address, u32 *pbus_data)
> +{
> +	int pbus_data_low, pbus_data_high;
> +	int ret;
> +
> +	ret = __phy_write(phydev, AIR_PBUS_MODE, AIR_PBUS_MODE_ADDR_FIXED);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_PBUS_RD_ADDR_HIGH, HIWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_PBUS_RD_ADDR_LOW,  LOWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	pbus_data_high = __phy_read(phydev, AIR_PBUS_RD_DATA_HIGH);
> +	if (pbus_data_high < 0)
> +		return ret;
> +
> +	pbus_data_low = __phy_read(phydev, AIR_PBUS_RD_DATA_LOW);
> +	if (pbus_data_low < 0)
> +		return ret;
> +
> +	*pbus_data = (u16)pbus_data_low | ((u32)(u16)pbus_data_high << 16);

I don't think you need the u16 casts here.

> +	return 0;
> +}
> +
> +static int air_buckpbus_reg_read(struct phy_device *phydev,
> +				 u32 pbus_address, u32 *pbus_data)
> +{
> +	int ret, saved_page;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
> +	if (ret < 0)
> +		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +			   pbus_address, ret);

Same as air_buckpbus_reg_write().

...
> +static int air_write_buf(struct phy_device *phydev, u32 address,
> +			 const struct firmware *fw)
> +{
> +	int ret, saved_page;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	ret = __air_write_buf(phydev, address, fw);
> +	if (ret < 0)
> +		phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +			   address, ret);

Same as air_buckpbus_reg_write().

...
> +
> +	cl45_data = phy_read_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR);
> +	if (cl45_data < 0)
> +		return cl45_data;
> +
> +	switch (mode) {
> +	case AIR_LED_MODE_DISABLE:
> +		cl45_data &= ~AIR_PHY_LED_BCR_EXT_CTRL;
> +		cl45_data &= ~AIR_PHY_LED_BCR_MODE_MASK;
> +		break;
> +	case AIR_LED_MODE_USER_DEFINE:
> +		cl45_data |= AIR_PHY_LED_BCR_EXT_CTRL;
> +		cl45_data |= AIR_PHY_LED_BCR_CLK_EN;
> +		break;
> +	default:
> +		phydev_err(phydev, "LED mode %d is not supported\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR, cl45_data);
> +	if (ret < 0)
> +		return ret;

Please always use phy_modify_mmd() rather than a
phy_read_mmd()...phy_write_mmd():

	cl45_data = 0;

	if (mode == AIR_LED_MODE_USER_DEFINE)
		cl45_data = AIR_PHY_LED_BCR_EXT_CTRL |
			    AIR_PHY_LED_BCR_CLK_EN;

	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR,
			     AIR_PHY_LED_BCR_EXT_CTRL |
			     AIR_PHY_LED_BCR_CLK_EN, cl45_data);
	if (ret < 0)
		return ret;

This ensures that the read/modify/write is done atomically on the bus.

...
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_GPIO_OUTPUT, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +	pbus_value |= EN8811H_GPIO_OUTPUT_345;
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_GPIO_OUTPUT, pbus_value);
> +	if (ret < 0)
> +		return ret;

Searching the driver for "air_buckpbus_reg_read", there are four
instances where you read-modify-write, and only one instance which is
just a read.

I wonder whether it would make more sense to structure the accessors as

	__air_buckpbus_set_address(phydev, addr)
	__air_buckpbus_read(phydev, *data)
	__air_buckpbus_write(phydev, data)

which would make implementing reg_read, reg_write and reg_modify()
easier, and the addition of reg_modify() means that (a) there are less
bus cycles (through having to set the address twice) and (b) ensures
that the read-modify-write can be done atomically on the bus. This
assumes that reading data doesn't auto-increment the address (which
you would need to check.)

...
> +static int en8811h_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int err, val;
> +
> +	val = 0;
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		val |= MDIO_AN_10GBT_CTRL_ADV2_5G;

While you only support 2500base-T, is there any reason not to use
linkmode_adv_to_mii_10gbt_adv_t() ?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


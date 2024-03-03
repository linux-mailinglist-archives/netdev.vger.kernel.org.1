Return-Path: <netdev+bounces-76917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8D586F66B
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C131B20D2B
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12E76409;
	Sun,  3 Mar 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pdUS7eCf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399DBA5F;
	Sun,  3 Mar 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486956; cv=none; b=KOzeAeSV51ShsmcG2mUXxncCjlPILyKaibB01nv95lvpw6Glm1ejkj5+uDOAMbM255xQTfYnclBKLJXn7DVp/l6Nvpu5jhPE02Mkb7EClfP9vq67pQTogFdNz/dai8wVcQy8z5eik8akvJ8wKKDzPS7MmdaRLeq/iGbPT56o3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486956; c=relaxed/simple;
	bh=rnYw+AOo8cpE6gLKNrgHSIclcBJojMCpzxczKpn2Y0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEfbq3KmQnqmWRxmoe91ew0mFhFNtIyV89GdlnsikP7Y3PtOAsaiF10F4FcYNSNx1POHEVB/Gf1wB6Tl+CahYRqxIR+BoOuN/l818h2qSdyboD2JXWA3NqhssIFyAOY/UH9FtyjjXrvMIVTacjXzyM4cVbaUflcZjawBHX3aH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pdUS7eCf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eTGSsx2NfF37A4LhU0Ufa0dc3CdGXwjkN6RA+oF6vbw=; b=pdUS7eCfDQfBdVBXU4exTVoJTt
	nZqV8wTfpD9weOVo5rxwA5taqmgWYFcbgnqfCOkqj8R4Bzvg4FwfX7uLxu2A4x0AvhBAbvqCstDI1
	U0mc4/Ub4nDDF2ME3i73HrOEfDD6KaWvrzMTSVTd5Ty+qN7LIniucypq3D6kINA7wJIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgpeK-009F8A-Dv; Sun, 03 Mar 2024 18:29:20 +0100
Date: Sun, 3 Mar 2024 18:29:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <89f237e0-75d4-4690-9d43-903e087e4f46@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302183835.136036-3-ericwouds@gmail.com>

> +enum {
> +	AIR_PHY_LED_DUR_BLINK_32M,
> +	AIR_PHY_LED_DUR_BLINK_64M,
> +	AIR_PHY_LED_DUR_BLINK_128M,
> +	AIR_PHY_LED_DUR_BLINK_256M,
> +	AIR_PHY_LED_DUR_BLINK_512M,
> +	AIR_PHY_LED_DUR_BLINK_1024M,

DUR meaning duration? It has a blinks on for a little over a
kilometre? So a wave length of a little over 2 kilometres, or a
frequency of around 0.0005Hz :-)

> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> +				    u32 pbus_address, u32 pbus_data,
> +				    bool set_mode)
> +{
> +	int ret;
> +
> +	if (set_mode) {
> +		ret = __phy_write(phydev, AIR_BPBUS_MODE,
> +				  AIR_BPBUS_MODE_ADDR_FIXED);
> +		if (ret < 0)
> +			return ret;
> +	}

What does set_mode mean?

> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw1, *fw2;
> +	int ret;
> +
> +	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_rel1;
> +

How big are these firmwares? This will map the entire contents into
memory. There is an alternative interface which allows you to get the
firmware in chunks. I the firmware is big, just getting 4K at a time
might be better, especially if this is an OpenWRT class device.

> +static int en8811h_restart_host(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_FINISH);
> +}

What is host in this context?

> +static int air_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				  unsigned long rules)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	u16 on = 0, blink = 0;
> +	int ret;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	priv->led[index].rules = rules;
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_10)   | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK10;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_10RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_10TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_100)  | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK100;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_100RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_100TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK1000;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_1000RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_1000TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK2500;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_2500RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_2500TX;
> +	}
> +
> +	if (on == 0) {
> +		if (rules & BIT(TRIGGER_NETDEV_RX)) {
> +			blink |= AIR_PHY_LED_BLINK_10RX   |
> +				 AIR_PHY_LED_BLINK_100RX  |
> +				 AIR_PHY_LED_BLINK_1000RX |
> +				 AIR_PHY_LED_BLINK_2500RX;
> +		}
> +		if (rules & BIT(TRIGGER_NETDEV_TX)) {
> +			blink |= AIR_PHY_LED_BLINK_10TX   |
> +				 AIR_PHY_LED_BLINK_100TX  |
> +				 AIR_PHY_LED_BLINK_1000TX |
> +				 AIR_PHY_LED_BLINK_2500TX;
> +		}
> +	}

Vendors do like making LED control unique. I've not seen any other MAC
or PHY where you can blink for activity at a given speed. You cannot
have 10 and 100 at the same time, so why are there different bits for
them?

I _think_ this can be simplified

+	if (rules & (BIT(TRIGGER_NETDEV_LINK_10)   | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK10;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_100)  | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK100;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK1000;
+	}
+
+	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK))) {
+		on |= AIR_PHY_LED_ON_LINK2500;
+	}
+
+	if (rules & BIT(TRIGGER_NETDEV_RX)) {
+		blink |= AIR_PHY_LED_BLINK_10RX   |
+			 AIR_PHY_LED_BLINK_100RX  |
+			 AIR_PHY_LED_BLINK_1000RX |
+			 AIR_PHY_LED_BLINK_2500RX;
+	}
+	if (rules & BIT(TRIGGER_NETDEV_TX)) {
+		blink |= AIR_PHY_LED_BLINK_10TX   |
+			 AIR_PHY_LED_BLINK_100TX  |
+			 AIR_PHY_LED_BLINK_1000TX |
+			 AIR_PHY_LED_BLINK_2500TX;

Does this work?


    Andrew

---
pw-bot: cr


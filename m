Return-Path: <netdev+bounces-47193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA517E8C20
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D051F20F14
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 18:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995731C68F;
	Sat, 11 Nov 2023 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UoA2oUmR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3E1C29F
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 18:29:37 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ACA3A82
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 10:29:36 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id 1sjbrFCzsRLkd1sjbrU473; Sat, 11 Nov 2023 19:29:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1699727374;
	bh=I5HzB/jwVmlnGROcId21O+TerN49GBJXbA7q7P5MvQs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=UoA2oUmRHZBPp2souQT/iF6cO7DcbmZTAbTuSISl/0vsHFMJWpkX4Jhu/kZPK0q+N
	 MotBPcd8kq+0YrNRWCdybh2TsNOgMDuEvPgXlVLl5NPKVHUqPpZscki+cdMVsz9mzg
	 /VCp8Rhlw/be9b/XolPpCpp9yPQdC1WIV0SBu2pYN1ICTasuzQI+viMtOEWR8qx03t
	 Rqz+6g3cjkf0fTOeSOyhBmgzrGMe6Lu3lUHXYZ+GCcl/yROW9++ZFwTxfJLtTzGSMk
	 94qNa1J7PT5Bpoia9e1HjVbjp8c9un2YGADBFoRZtbKF9qDA/w0h+fBd2UlKa30rEK
	 b0ta5BwIkS6lQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Nov 2023 19:29:34 +0100
X-ME-IP: 86.243.2.178
Message-ID: <ddd7bd7a-806f-4853-a428-e551cff1e2e1@wanadoo.fr>
Date: Sat, 11 Nov 2023 19:29:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC PATCH v6 3/4] net: phy: aquantia: add firmware load
 support
To: Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Robert Marko <robimarko@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
 <20231109123253.3933-3-ansuelsmth@gmail.com>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231109123253.3933-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/11/2023 à 13:32, Christian Marangi a écrit :
> From: Robert Marko <robimarko@gmail.com>
> 
> Aquantia PHY-s require firmware to be loaded before they start operating.
> It can be automatically loaded in case when there is a SPI-NOR connected
> to Aquantia PHY-s or can be loaded from the host via MDIO.
> 
> This patch adds support for loading the firmware via MDIO as in most cases
> there is no SPI-NOR being used to save on cost.
> Firmware loading code itself is ported from mainline U-boot with cleanups.
> 
> The firmware has mixed values both in big and little endian.
> PHY core itself is big-endian but it expects values to be in little-endian.
> The firmware is little-endian but CRC-16 value for it is stored at the end
> of firmware in big-endian.
> 
> It seems the PHY does the conversion internally from firmware that is
> little-endian to the PHY that is big-endian on using the mailbox
> but mailbox returns a big-endian CRC-16 to verify the written data
> integrity.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

...

> +static int aqr_firmware_load_fs(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw;
> +	const char *fw_name;
> +	int ret;
> +
> +	ret = of_property_read_string(dev->of_node, "firmware-name",
> +				      &fw_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_firmware(&fw, fw_name, dev);
> +	if (ret) {
> +		phydev_err(phydev, "failed to find FW file %s (%d)\n",
> +			   fw_name, ret);
> +		goto exit;

Harmless, but a direct return looks correct as-well.
No need to call release_firmware() here.

> +	}
> +
> +	ret = aqr_fw_boot(phydev, fw->data, fw->size, AQR_FW_SRC_FS);
> +	if (ret)
> +		phydev_err(phydev, "firmware loading failed: %d\n", ret);
> +
> +exit:
> +	release_firmware(fw);
> +
> +	return ret;
> +}

...



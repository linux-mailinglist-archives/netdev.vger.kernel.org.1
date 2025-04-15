Return-Path: <netdev+bounces-182553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CACA8910D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C407A1FBF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808819CC0E;
	Tue, 15 Apr 2025 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bv9SyjWl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CEA14B086;
	Tue, 15 Apr 2025 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679672; cv=none; b=JYZbmUAt0T+/Vb9f6BX53/9j3qy1PAZWgxXOk1yYPLnCEMr3pBtjZA0ZLZN54IM+cWGIM99NrceYmw6ALU3yCK+mMXsIPq/+jnsIRw66IbWAKTgjqdtMYtY5l88lYGTrrOmvRurpXkpCUWRj2OQn2Ii8AQcjCfbnI/ffI27jkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679672; c=relaxed/simple;
	bh=rXmuGoKCamG0aferad+Cy5qugPfOd4555bj0JzARQhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZPZMluCbIzYf875GdBLOE4Dwj7HD1JLdk2KHQL6HJDTFIQPzMcb8/OhRGFJvUcB6aNdl2APR/zgs6cfYPdVyoHl5w5c1hak5LlLeQuQ0paSFmHKnLu4oKPJffJqbMkNFixf6lse2lT368OertCeW3Gt3ZpuyOw1T0zwcHGpZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bv9SyjWl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AG/3kjVmrNGLgYCiQZuEWEAuFBhu8RV+zxauPZqiHqs=; b=Bv9SyjWlDgWfsXr3YOTr8YLh7w
	1rimb65VwUpbf6+2hYKMOeMkY1eAT7bORo1AzoeFKRtbxu6a1DkTEvKmSDEoX/z2NDqC5r/4caVp3
	ah9BIbPu/YCjTLG9VSheWaWlqM6Rp3fb+IrOr4fdZaNIoosJsBoP/yP+EyHosVk9nzBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4UsP-009JeN-IZ; Tue, 15 Apr 2025 03:14:13 +0200
Date: Tue, 15 Apr 2025 03:14:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: Re: [net-next PATCH v7 5/6] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <8760a101-4536-474f-a0db-5b88ed4c0ec2@lunn.ch>
References: <20250410095443.30848-1-ansuelsmth@gmail.com>
 <20250410095443.30848-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410095443.30848-6-ansuelsmth@gmail.com>

> +#define AEON_MAX_LDES			5

AEON_MAX_LEDS?

> +#define AEON_IPC_DELAY			10000
> +#define AEON_IPC_TIMEOUT		(AEON_IPC_DELAY * 100)
> +#define AEON_IPC_DATA_MAX		(8 * sizeof(u16))

> +

> +static int aeon_ipc_rcv_msg(struct phy_device *phydev,
> +			    u16 ret_sts, u16 *data)
> +{

It would be good to add a comment here about what the return value
means. I'm having to work hard to figure out if it is bytes, or number
of u16s.

> +	struct as21xxx_priv *priv = phydev->priv;
> +	unsigned int size;
> +	int ret;
> +	int i;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> +		return -EINVAL;
> +
> +	/* Prevent IPC from stack smashing the kernel */
> +	size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> +	if (size > AEON_IPC_DATA_MAX)
> +		return -EINVAL;

This suggests size is bytes, and can be upto 16?

> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> +		if (ret < 0) {
> +			size = ret;
> +			goto out;
> +		}
> +
> +		data[i] = ret;

and this is looping up to 8 times reading words.

> +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> +{
> +	char fw_version[AEON_IPC_DATA_MAX + 1];
> +	u16 ret_data[8], data[1];

I think there should be a #define for this 8. It is pretty fundamental
to these message transfers.

> +	u16 ret_sts;
> +	int ret;
> +
> +	data[0] = IPC_INFO_VERSION;

Not a normal question i would ask for MDIO, but are there any
endianness issues here? Since everything is in u16, the base size for
MDIO, i doubt there is.

> +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data,
> +				sizeof(data), &ret_sts);
> +	if (ret)
> +		return ret;

> +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> +	if (ret < 0)
> +		return ret;
> +

but ret is in bytes, not words, so we start getting into odd
situations. Have you seen the firmware return an add number of bytes
in its message? If it does, is it clear which part of the last word
should be used.

> +
> +	/* Make sure FW version is NULL terminated */
> +	memcpy(fw_version, ret_data, ret);
> +	fw_version[ret] = '\0';


Given that ret is bytes, this works, despite ret_data being words.

	Andrew


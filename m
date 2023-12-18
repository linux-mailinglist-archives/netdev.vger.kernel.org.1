Return-Path: <netdev+bounces-58594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7E817666
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E304C1F27264
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458433A1B6;
	Mon, 18 Dec 2023 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEAxDwSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E21E57C;
	Mon, 18 Dec 2023 15:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443B0C433C7;
	Mon, 18 Dec 2023 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702914945;
	bh=gP2p7ltlGa5lLEG8JqiCPcXfF7ayw1/Vq76UN6hkMN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cEAxDwSXr+KBw0mipbIjWpGsdFTt4VDbgqixgZramwzYKIYPgdC8qqyK6pk/2cOBZ
	 0FjTKIHAtfpgovpSgLSLU/G2xVQZHR0Gq8guxJDXg8K+K1WUUqhbgfN4R9MuH9mItg
	 HRGdAS+NWrofzWXq45qiy0oAR75LCe2EswCUlJGOaHX2eavO61HWoLgRiDy1oX/FrK
	 nA8Xtxu5+kb8iEBD+KKhsxJKLnZs1x8qaues/DWR121CnkzlYFaI4QNc8M6Fv1RJeq
	 KFWKG+jMUkO74pgtUHMuDjfv/iu+vIWoupuROJUaCozRGlb1mdQ5MDmS8waIvdl60F
	 VefDjymjYTiJg==
Date: Mon, 18 Dec 2023 15:55:40 +0000
From: Simon Horman <horms@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: marvell10g: Add LED support for
 88X3310
Message-ID: <20231218155540.GF6288@kernel.org>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-4-tobias@waldekranz.com>

On Thu, Dec 14, 2023 at 09:14:41PM +0100, Tobias Waldekranz wrote:
> Pickup the LEDs from the state in which the hardware reset or
> bootloader left them, but also support further configuration via
> device tree. This is primarily needed because the electrical polarity
> and drive behavior is software controlled and not possible to set via
> hardware strapping.
> 
> Trigger support:
> - "none"
> - "timer": Map 60-100 ms periods to the fast rate (81ms) and 1000-1600
>   	   ms periods to the slow rate (1300ms). Defer everything else to
> 	   software blinking
> - "netdev": Offload link or duplex information to the solid behavior;
>   	    tx and/or rx activity to blink behavior.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

...

> +static int mv3310_leds_probe(struct phy_device *phydev)
> +{
> +	struct mv3310_priv *priv = dev_get_drvdata(&phydev->mdio.dev);
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	struct device_node *pnp, *np;
> +	int err, val, index;
> +
> +	/* Save the config left by HW reset or bootloader, to make
> +	 * sure that we do not loose any polarity config made by
> +	 * firmware. This will be overridden by info from DT, if
> +	 * available.
> +	 */
> +	for (index = 0; index < MV3310_N_LEDS; index++) {
> +		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
> +				   MV_V2_LED0_CONTROL + index);
> +		if (val < 0)
> +			return val;
> +
> +		priv->led[index] = (struct mv3310_led) {
> +			.index = index,
> +			.fw_ctrl = val,
> +		};
> +	}
> +
> +	if (!node)
> +		return 0;
> +
> +	pnp = of_get_child_by_name(node, "leds");
> +	if (!pnp)
> +		return 0;
> +
> +	for_each_available_child_of_node(pnp, np) {
> +		err = mv3310_led_probe_of(phydev, np);
> +		if (err)

Hi Tobias,

I think a call to of_node_put(np) is required here to avoid leaking a
reference.

Flagged by Coccinelle.

> +			return err;
> +	}
> +
> +	return 0;
> +}

...


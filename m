Return-Path: <netdev+bounces-142014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C89BCF42
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE81C22C5F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312B1D88D5;
	Tue,  5 Nov 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X519f1N7"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928691D2716;
	Tue,  5 Nov 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816892; cv=none; b=MoW6hv8R1S1+YgOmrJQSEEolel+6rCNhelyTtl85QPTpN8YQiGklb8Sr2JZ5wOXH3WtKHipn1QvNT9ZQVNm3oJkRy4bxj4+J8PtI8dyUL82g+8Okb1P1A2Bp3rS156wUcSwvJ1Rq79galpm9Xw8os9sCERuPXlUuFsXDEFEXHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816892; c=relaxed/simple;
	bh=sRu/2hY6/f6nJz3PWfsGf63AKy+vCNF5Yc9bNL1zAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQJ0rn7K0hB5casyCAOKesxRUJM11xMU8vmXV7eUilMZiaqFwuPAS4WnJclgyONdsmr2UUxdRvWOboPOV9+Dr3v/2NWiJjnvJDLukul2I69MtPtdb61YicDzzOLekwN/AlUT7zpQli0B/ggzw3UKCKw5eYoMYxgHgkPpXgDz0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X519f1N7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 442BA2000D;
	Tue,  5 Nov 2024 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730816887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EuwCKemNntiFUl0h9MOekWv295Bny26C7jMlRkpaQI=;
	b=X519f1N7bg31nSp6vgbfL/qtutO+2z4BDU9JI6mEWjcb5+aI2aNBzVCuVhpXWlSop3hJSh
	/41uUCZ7inbMSgUHQyUUwPNThJ2FjqMcWa1+UMZwTEoXgxFQ36UOK87TOcoORA6zk2YP2L
	IrXsLCygpnZ7F2UjQA+4ZMSrz7g+n9YoIDFEXa3sjHMGVlqXMH/M6WBNPSVp4x0Z6qDSHu
	qEUfb1JCh/kGZFUafyFdHxIQLKnFhBuokuaKqad72bNS6wi9JFIOEJTCGX5OdDqGEKpOXx
	5T7H88qWb0udNGDYIvbygyoDx2rqPGIeutBbFkpVKvNnQ/G86uTuENc2zMElIQ==
Date: Tue, 5 Nov 2024 15:28:05 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org, Marek Vasut
 <marex@denx.de>
Subject: Re: [PATCH net-next v3 6/6] net: dsa: microchip: parse PHY config
 from device tree
Message-ID: <20241105152805.25f8b065@fedora.home>
In-Reply-To: <20241105090944.671379-7-o.rempel@pengutronix.de>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
	<20241105090944.671379-7-o.rempel@pengutronix.de>
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

Hello Oleksij,

On Tue,  5 Nov 2024 10:09:44 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Introduce ksz_parse_dt_phy_config() to validate and parse PHY
> configuration from the device tree for KSZ switches. This function
> ensures proper setup of internal PHYs by checking `phy-handle`
> properties, verifying expected PHY IDs, and handling parent node
> mismatches. Sets the PHY mask on the MII bus if validation is
> successful. Returns -EINVAL on configuration errors.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 80 ++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 3909b55857430..cd1a466504180 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2373,6 +2373,77 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
>  			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
>  }
> 
> +/**
> + * ksz_parse_dt_phy_config - Parse and validate PHY configuration from DT
> + * @dev: pointer to the KSZ device structure
> + * @bus: pointer to the MII bus structure
> + * @mdio_np: pointer to the MDIO node in the device tree
> + *
> + * This function parses and validates PHY configurations for each user port
> + * defined in the device tree for a KSZ switch device. It verifies that the
> + * `phy-handle` properties are correctly set and that the internal PHYs match
> + * expected IDs and parent nodes. Sets up the PHY mask in the MII bus if all
> + * validations pass. Logs error messages for any mismatches or missing data.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
> +				   struct device_node *mdio_np)
> +{
> +	struct device_node *phy_node, *phy_parent_node;
> +	bool phys_are_valid = true;
> +	struct dsa_port *dp;
> +	u32 phy_id;
> +	int ret;
> +
> +	dsa_switch_for_each_user_port(dp, dev->ds) {
> +		if (!dev->info->internal_phy[dp->index])
> +			continue;
> +
> +		phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> +		if (!phy_node) {
> +			dev_err(dev->dev, "failed to parse phy-handle for port %d.\n",
> +				dp->index);
> +			phys_are_valid = false;
> +			continue;
> +		}
> +
> +		phy_parent_node = of_get_parent(phy_node);
> +		if (!phy_parent_node) {
> +			dev_err(dev->dev, "failed to get PHY-parent node for port %d\n",
> +				dp->index);
> +			phys_are_valid = false;
> +		} else if (dev->info->internal_phy[dp->index] &&
> +			   phy_parent_node != mdio_np) {

There's a check a few lines above that guarantees that at this point
dev->info->internal_phy[dp->index] will always evaluate as true,
so you could simplify that condition a bit :)

> +			dev_err(dev->dev, "PHY-parent node mismatch for port %d, expected %pOF, got %pOF\n",
> +				dp->index, mdio_np, phy_parent_node);
> +			phys_are_valid = false;
> +		} else {
> +			ret = of_property_read_u32(phy_node, "reg", &phy_id);
> +			if (ret < 0) {
> +				dev_err(dev->dev, "failed to read PHY ID for port %d. Error %d\n",
> +					dp->index, ret);
> +				phys_are_valid = false;
> +			} else if (phy_id != dev->phy_addr_map[dp->index]) {
> +				dev_err(dev->dev, "PHY ID mismatch for port %d, expected 0x%x, got 0x%x\n",
> +					dp->index, dev->phy_addr_map[dp->index],
> +					phy_id);

In this context, PHY ID might be a bit misleading, as PHY ID usually
refers to the identifier (OUI + model id used at probe to select the
driver). May I suggest phy_addr instead ?

Thanks,

Maxime


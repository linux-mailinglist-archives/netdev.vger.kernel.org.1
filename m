Return-Path: <netdev+bounces-259521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFceHvdCl2nzwAIAu9opvQ
	(envelope-from <netdev+bounces-259521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:05:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E3160EDC
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 732F0302A6A7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E52C21D3;
	Thu, 19 Feb 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ohJ69X4z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F806148850;
	Thu, 19 Feb 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520756; cv=none; b=Gxbh9CfyltkSv++hPGVJb+aK1dnAwqdsBfvXAHxDQrMzJfn84HZEQGc59xjHPlMUnuHQNsE7O7wLQQAww3A92/p320ZAaTuqVSrjeYWdyJZmDe8DTUNhQneKOuLDZ/W2xnUqykZ0frq4P/1LMfwl82Mhe9MA0eV/Ps5xf+WZmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520756; c=relaxed/simple;
	bh=/GwvltyCRoCDpXCR8WU6rgSQ5VOZ75Vw22nx6nIx3WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6D13DTBq3GmMuUDwv8hXf/eYbc6TXqnLJ1UY2XyU8ffX2C7D5TV5W5iQb7lAlFietHoEOBrzO4fWkgwzAbI9q1IymcFrkezoS6uTTTWjxa0t/Y1Rk9RV0fARAdVM4snd8MoNGML1/6e2vV45Qn84yz4jnbxMGU6uA2TIyVCSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ohJ69X4z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KaK0sntCMoSLZMQ6Q8ttvFUYVC/oQ1rIAiyZUvLuAWw=; b=ohJ69X4zchPR/hJgdat23qs4x9
	je1AI0NgCjI2+3lu3xdGlfDMgX23MfUDaOLEv5YKpOKWkQ/ANoMWJMjKGdSXzN6UeHdIqbzhTqKo+
	QkRPiygkNlBJSn9WcMtsgMHUdvXkTlN7BXWQCmTB7GHUtdJGFct+gYUJ4SJqYwUaqhJY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vt7TI-007wb9-0N; Thu, 19 Feb 2026 18:05:48 +0100
Date: Thu, 19 Feb 2026 18:05:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RFC PATCH 4/8] xilinx: tsn: Add Ethernet MAC (EMAC) and MDIO
 support to the TSN driver
Message-ID: <b408cad2-90de-44df-85a6-64a028216290@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-5-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219054911.2017362-5-srinivas.neeli@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259521-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: CB7E3160EDC
X-Rspamd-Action: no action

> +static int tsn_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	u32 rc;
> +	int ret;
> +	struct tsn_emac *emac = bus->priv;
> +	struct tsn_priv *common = emac->common;
> +
> +	scoped_guard(mutex, &common->mdio_lock) {

What is this mutex protecting?

> +		tsn_mdio_mdc_enable(emac);

It is unusual to stop MDC. I suspect some PHYs will not like this.
What is your reason for doing this.

> +/**
> + * tsn_mdio_setup - Setup MDIO bus for TSN EMAC
> + * @emac: Pointer to TSN EMAC structure
> + * @mac_np: Device tree node for MAC
> + *
> + * This function initializes the MDIO bus for the TSN EMAC interface.
> + * It allocates an MII bus structure, configures MDIO timing, finds
> + * the MDIO device tree node, and registers the MDIO bus with the kernel.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int tsn_mdio_setup(struct tsn_emac *emac, struct device_node *mac_np)
> +{
> +	struct tsn_priv *common = emac->common;
> +	struct device_node *mdio_node;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = mdiobus_alloc();
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "tsn-mac-%.8llx",
> +		 (unsigned long long)emac->regs_start);
> +
> +	bus->priv = emac;
> +	bus->name = "Xilinx TSN Ethernet MDIO";
> +	bus->read = tsn_mdio_read;
> +	bus->write = tsn_mdio_write;
> +	bus->parent = common->dev;
> +	emac->mii_bus = bus;
> +
> +	mdio_node = of_get_child_by_name(mac_np, "mdio");
> +	if (!mdio_node) {
> +		dev_err(common->dev, "MAC%d: missing 'mdio' child node\n",
> +			emac->emac_num);
> +		ret = -ENODEV;
> +		goto unregister;
> +	}

I forget, does the binding have a required: for the MDIO node?

> +	ret = tsn_mdio_enable(emac);
> +	if (ret < 0)
> +		goto unregister;
> +	ret = of_mdiobus_register(bus, mdio_node);

Having a node in DT is generally optional. You can pass NULL to
of_mdiobus_register() and it will do the right thing.

	Andrew


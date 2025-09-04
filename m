Return-Path: <netdev+bounces-219878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7AB438B1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B6F17EB5C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B822EC08B;
	Thu,  4 Sep 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Trk0VvDU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F22DCF77;
	Thu,  4 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981604; cv=none; b=kVL25/5PqB+gnWEetsoME1El5aSH6mtSh0l5Xl/2hR76OA/QZyKk+oIzcKkevwYxMddxpvW870m8OXnamnJmMEcqcZAx405DrWrxwXtk5nZ4ieCMlCToymnUHoFNErzCAtvc4WNKeRoNKOkZ5+LZlhUHDG44P5DruOLRiInfe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981604; c=relaxed/simple;
	bh=f86kPt3QUKPX4SAiopviBEOLYgqX3zboC6GjP3u5ikg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRJVl6O/MbSapaUOB81rLMEckyFL6mw6sJsbNIikm6sSoWQqICFwfbdtDZSWPmifrb5tQfIWHbfOZxXWKgj/03eNSsuMfaZopgu6FGVuRpOpMAdcOlN9mW6o/PWsIoKxEXl4Xn11XLsV56WBRdqB7RvGXjm3D1pJ13jCfUWQLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Trk0VvDU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r+PxUXRPBCegn7nxIw8aU+giwhqnR+X96ofMNS1C+qA=; b=Trk0VvDUUBQmIaaZkOwxKUs5VS
	bHr2Pr+4J8HGE+FsC2yCsBZDLX+r9WZpbXWs+78vPnDsuSed1DhzcYI2IDAuBC/3z2LE41Pc/SQA7
	rj2PyYhXRAlorckyYao+MnFL1x3CmS5iARyLuK9/N0cpMZ9cn46Ms9GZUx621z5gZz7JQzjGKQEr3
	RSc9Wbn/jBSIPNUOpnR6MDIueDXv926ba8t3ia+ES0+TROjpeMAPwVcKWLBy6PfQlSgX3ndnbGf9L
	GI9/0xvaLDAFYAgJC7e6gOdpmLkheX/ObZ0UNFEzJzt82MdP8SCU0lTARU6dZsrgDxtYZlCmupRz9
	C+Kt+qxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48290)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu7An-000000001oA-2KNv;
	Thu, 04 Sep 2025 11:26:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu7Af-000000001Qj-0fPd;
	Thu, 04 Sep 2025 11:26:25 +0100
Date: Thu, 4 Sep 2025 11:26:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	emil.renner.berthing@canonical.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v5 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <aLlpUOr3IJzTuV1g@shell.armlinux.org.uk>
References: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
 <20250904090125.2598-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904090125.2598-1-weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 05:01:25PM +0800, weishangjuan@eswincomputing.com wrote:
> +struct eic7700_qos_priv {
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct device *dev;
> +	struct regmap *hsp_regmap;
> +	u32 tx_delay_ps;
> +	u32 rx_delay_ps;
> +};
> +
> +/**
> + * eic7700_apply_delay - Apply TX or RX delay to a register value.
> + * @delay_ps: Delay in picoseconds, converted to 0.1ns units.
> + * @reg:      Pointer to register value to update in-place.
> + * @is_rx:    True for RX delay (bits 30:24), false for TX delay (bits 14:8).
> + *
> + * Converts delay from ps to 0.1ns units, capped by EIC7700_MAX_DELAY_UNIT.
> + * Updates only the RX or TX delay field (using FIELD_PREP), leaving all
> + * other bits in *@reg unchanged.
> + */
> +static void eic7700_apply_delay(u32 delay_ps, u32 *reg, bool is_rx)
> +{
> +	u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +
> +	if (is_rx) {
> +		*reg &= ~EIC7700_ETH_RX_ADJ_DELAY;
> +		*reg |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> +	} else {
> +		*reg &= ~EIC7700_ETH_TX_ADJ_DELAY;
> +		*reg |= FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, val);
> +	}
> +}

...

> +	/* Read rx-internal-delay-ps and update rx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "rx-internal-delay-ps",
> +				  &dwc_priv->rx_delay_ps)) {
> +		eic7700_apply_delay(dwc_priv->rx_delay_ps,
> +				    &eth_dly_param, true);

I've been trying to figure out the reasoning behind the following:

1. the presence of dwc_priv->rx_delay_ps and dwc_priv->tx_delay_ps
   rather than just using a local variable ("delay" ?)
2. the presence of eic7700_apply_delay() when we have to do something
   different to get the delay value anyway

It seems to me that this should either be:

static void eic7700_parse_delay(u32 *reg, struct device *dev,
				const char *name, bool is_rx)
{
	u32 delay;

	if (of_property_read_u32(dev->of_node, name, &delay)) {
		dev_warn(dev, "can't get %s\n", name);
		return
	}

	if (is_rx) {
		*reg &= ~EIC7700_ETH_RX_ADJ_DELAY;
		*reg |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, delay);
	} else {
		*reg &= ~EIC7700_ETH_TX_ADJ_DELAY;
		*reg |= FIELD_PREP(EIC7700_ETH_TX_ADJ_DELAY, delay);
	}
}

or just not bother with the function at all and just write it out
fully in the probe function.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


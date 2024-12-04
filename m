Return-Path: <netdev+bounces-148912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7F9E3650
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7A4167FAB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9C1A3A95;
	Wed,  4 Dec 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSpOueZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C19B3E2;
	Wed,  4 Dec 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303679; cv=none; b=qfIu7kW47/tIm1rdLcnlfKsYRHfkRwmYVGOzAbVLCn2j3FWGBOJOfDSaQywLoeznDoF+kYiMAc2NL04RtOepMQpnuHuY4nV634qUj/n6tUYgOjlL8HYFXO3C/HhhUrBwsUpzEWaNlAImJizgw2KlF/hGGNIDvgcDUTlAne0kR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303679; c=relaxed/simple;
	bh=ab4Rny72RRKv0zQXWCBDEkZeDmPU2OstlQxvJG5rCjQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+9Gl0Fnn3QObY2JrMjdT4GvwpKSotqHwAcpV2jQ00AiuAiHKaEdmToGB7BTX727vsYtilsIJDuRuRBDWXdyG9+ybe0d31wQ9DWGYXJrkb7TZIjzIT7iurNUgfCGjrllPUcv3Ng/KT0t5kG+WzdxHQuZ49TDc3+kkl6EHnbwCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSpOueZf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43494a20379so53950405e9.0;
        Wed, 04 Dec 2024 01:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733303676; x=1733908476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvtTNWTPc/MwJikfv9QFtUDvsT2fp5rcl3kz3CC/vKc=;
        b=NSpOueZf6JAMguZb6MhAKvPEvv5r9OQURNO9w7swQ+xY7j2WX3xOEjLIBtvYvBN6xS
         N575EyY/Ydz1igsl72wuCxUN7b6H81VHb+MgFGP+Mr3r5eFM2HLfBDgB47BeTm2xOXYf
         pfFlhjF+CxQuTqMG2TAJhoOmNeLhSFgdkpcsoNSMXCK7FDtRdKgNpsm//BG/ieM/SApm
         SSWZzukkuFG1Vd+nSZNRbKLNagQra8B9zaV9wZGuY5ofJErtqF/G4gerXwB+598njpL4
         KBjzBLnDVvureEZBMlMjm0Rr/AjHLqI8tCX33WugAqGG/yDDWa13YEUUu5dkeiBRiAVa
         fhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733303676; x=1733908476;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvtTNWTPc/MwJikfv9QFtUDvsT2fp5rcl3kz3CC/vKc=;
        b=jTtLTyiBZhC2XOeqZZ2Ne+FAz3dz69zAWX8a3jasF6YCrwi3hwDkOU9+gpVuC+rCsZ
         MJJCEvsKhiEPS1eCgN2NLL631G6Rvb7etH7JbSO859U5AMd6qKnWqK83XrKmTBZ1qHAZ
         gZCLBbIJJL0kcLgfIEJ6dM+ftFcbc7meilUdFHK25DWsJnsshk1VnlSFQ95sjKWFgOFz
         pvvp+cXYoAxcJFwhnB0m5UyckoTKbqTHMThU5jgtrczWqdBeaacDwBDEJ7Nr1gSE3ExN
         qCsg2mct2w7Q7/+T5acfplkSDCdA03j2L7KTY6GoQrQVWUBHZglpUSZ0UyiVx4rlk/4r
         auhw==
X-Forwarded-Encrypted: i=1; AJvYcCW687j9PduhF+Cof3kmOiedN12GdUcVAECkvz+YAjfAFTjOYPj6iu+VP8kGsUXJ4q11WUNSxkoMFj0U@vger.kernel.org, AJvYcCWia3Tc0cMKuB0U/5aIlJ2g5B5W1wQs07HAcLLtXacSjDnYfy837lM0CWbjxVA0kgC9ZVUY6COe@vger.kernel.org, AJvYcCX14pT68jrQTguE/wnHt/jBKLdmsThbC79oro41gWyTp5YmWAMxTmgpQLv2lGoRH0kHQ9ku340LQl8CcucO@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrvHINC8nADyt1Mh4Za578qXwx/c+59CFqFa2VvulQ6xrZHtD
	RQsznBp+fm94igUQA4oq+HGZH+u5psXs5vexOt4MqrtJ6Y+LYRh1
X-Gm-Gg: ASbGncvCaEEu2nDvyTR1hjig+EvTQZmH1p1a2q2NXY9QHug0Qfbfcbhyzt7l9+naeRv
	ScqeehREzhfO86Ih79E1o8waDdTSguLdv/kqMWhKONLZUYi1kHkzQ/72FesaTyGC2pCM91oRoFp
	TkWule+dgcgvk/TBCscGhvfVG6H2vhL+iZNWd461/Z/OjjhGaDNJbDT7Ce++5SQvcK7zTl/iE04
	lPQLjchEzAm35NZUQh+dKILOiqPSbw044Zj3exvpToiX6Q8SqregRdaRYpIZNhLnXEmqDIvPhtc
	iXRnKQ==
X-Google-Smtp-Source: AGHT+IEk4Q2Qy9esekPW46VIQ2OVa8vfFbzQhwNMR6Rub6oKpS1Vg6LBdV5PE4QojPqnPxXQyMt1YA==
X-Received: by 2002:a05:600c:314a:b0:434:9be8:6cb5 with SMTP id 5b1f17b1804b1-434d09c1ebbmr56644225e9.17.1733303675675;
        Wed, 04 Dec 2024 01:14:35 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm17195825e9.39.2024.12.04.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:14:35 -0800 (PST)
Message-ID: <67501d7b.050a0220.3390ac.353c@mx.google.com>
X-Google-Original-Message-ID: <Z1Add9YzgDcV4uvF@Ansuel-XPS.>
Date: Wed, 4 Dec 2024 10:14:31 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204100922.0af25d7e@fedora.home>

On Wed, Dec 04, 2024 at 10:09:22AM +0100, Maxime Chevallier wrote:
> Hello Christian,
> 
> On Wed,  4 Dec 2024 08:24:10 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add Airoha AN8855 5-Port Gigabit DSA switch.
> > 
> > The switch is also a nvmem-provider as it does have EFUSE to calibrate
> > the internal PHYs.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]
> 
> My two-cents review below :)
> 
> > +static void
> > +an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> > +			  const struct phylink_link_state *state)
> > +{
> > +	struct dsa_port *dp = dsa_phylink_to_port(config);
> > +	struct dsa_switch *ds = dp->ds;
> > +	struct an8855_priv *priv;
> > +	int port = dp->index;
> > +
> > +	priv = ds->priv;
> > +
> > +	if (port != 5) {
> > +		if (port > 5)
> > +			dev_err(ds->dev, "unsupported port: %d", port);
> > +		return;
> > +	}
> 
> Looks like the above condition can be simplified to :
> 
> 	if (port > 5)
> 		dev_err(...);
> 
>

Well.... yep AHHAHA.

> > +
> > +	regmap_update_bits(priv->regmap, AN8855_PMCR_P(port),
> > +			   AN8855_PMCR_IFG_XMIT | AN8855_PMCR_MAC_MODE |
> > +			   AN8855_PMCR_BACKOFF_EN | AN8855_PMCR_BACKPR_EN,
> > +			   FIELD_PREP(AN8855_PMCR_IFG_XMIT, 0x1) |
> > +			   AN8855_PMCR_MAC_MODE | AN8855_PMCR_BACKOFF_EN |
> > +			   AN8855_PMCR_BACKPR_EN);
> > +}
> > +
> > +static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
> > +				    struct phylink_config *config)
> > +{
> > +	switch (port) {
> > +	case 0:
> > +	case 1:
> > +	case 2:
> > +	case 3:
> > +	case 4:
> > +		__set_bit(PHY_INTERFACE_MODE_GMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +			  config->supported_interfaces);
> > +		break;
> > +	case 5:
> > +		phy_interface_set_rgmii(config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +			  config->supported_interfaces);
> > +		break;
> > +	}
> > +
> > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +				   MAC_10 | MAC_100 | MAC_1000FD;
> 
> For port 5, you may also add the MAC_2500FD capability as it supports
> 2500BASEX ?
> 

I didn't account for the CPU port that runs at 2.5. The LAN port are
only 1g. Will add or maybe add the 2500FD only for cpu port?

Maybe Russel can help in this?

> > +}
> > +
> 
> [...]
> 
> > +
> > +static void
> > +an8855_phylink_mac_link_up(struct phylink_config *config,
> > +			   struct phy_device *phydev, unsigned int mode,
> > +			   phy_interface_t interface, int speed, int duplex,
> > +			   bool tx_pause, bool rx_pause)
> > +{
> > +	struct dsa_port *dp = dsa_phylink_to_port(config);
> > +	struct an8855_priv *priv = dp->ds->priv;
> > +	int port = dp->index;
> > +	u32 reg;
> > +
> > +	reg = regmap_read(priv->regmap, AN8855_PMCR_P(port), &reg);
> > +	if (phylink_autoneg_inband(mode)) {
> > +		reg &= ~AN8855_PMCR_FORCE_MODE;
> > +	} else {
> > +		reg |= AN8855_PMCR_FORCE_MODE | AN8855_PMCR_FORCE_LNK;
> > +
> > +		reg &= ~AN8855_PMCR_FORCE_SPEED;
> > +		switch (speed) {
> > +		case SPEED_10:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_10;
> > +			break;
> > +		case SPEED_100:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_100;
> > +			break;
> > +		case SPEED_1000:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_1000;
> > +			break;
> > +		case SPEED_2500:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_2500;
> > +			break;
> > +		case SPEED_5000:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> > +			break;
> 
> There's no mention of any mode that can give support for the 5000Mbps
> speed, is it a leftover from previous work on the driver ?
> 

Added 5000 as this is present in documentation bits but CPU can only go
up to 2.5. Should I drop it? Idea was to futureproof it since it really
seems they added these bits with the intention of having a newer switch
with more advanced ports.

> > +		}
> > +
> > +		reg &= ~AN8855_PMCR_FORCE_FDX;
> > +		if (duplex == DUPLEX_FULL)
> > +			reg |= AN8855_PMCR_FORCE_FDX;
> > +
> > +		reg &= ~AN8855_PMCR_RX_FC_EN;
> > +		if (rx_pause || dsa_port_is_cpu(dp))
> > +			reg |= AN8855_PMCR_RX_FC_EN;
> > +
> > +		reg &= ~AN8855_PMCR_TX_FC_EN;
> > +		if (rx_pause || dsa_port_is_cpu(dp))
> > +			reg |= AN8855_PMCR_TX_FC_EN;
> > +
> > +		/* Disable any EEE options */
> > +		reg &= ~(AN8855_PMCR_FORCE_EEE5G | AN8855_PMCR_FORCE_EEE2P5G |
> > +			 AN8855_PMCR_FORCE_EEE1G | AN8855_PMCR_FORCE_EEE100);
> > +	}
> > +
> > +	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
> > +
> > +	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> > +}
> > +
> > +static void an8855_pcs_get_state(struct phylink_pcs *pcs,
> > +				 struct phylink_link_state *state)
> > +{
> > +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = regmap_read(priv->regmap, AN8855_PMSR_P(AN8855_CPU_PORT), &val);
> > +	if (ret < 0) {
> > +		state->link = false;
> > +		return;
> > +	}
> > +
> > +	state->link = !!(val & AN8855_PMSR_LNK);
> > +	state->an_complete = state->link;
> > +	state->duplex = (val & AN8855_PMSR_DPX) ? DUPLEX_FULL :
> > +						  DUPLEX_HALF;
> > +
> > +	switch (val & AN8855_PMSR_SPEED) {
> > +	case AN8855_PMSR_SPEED_10:
> > +		state->speed = SPEED_10;
> > +		break;
> > +	case AN8855_PMSR_SPEED_100:
> > +		state->speed = SPEED_100;
> > +		break;
> > +	case AN8855_PMSR_SPEED_1000:
> > +		state->speed = SPEED_1000;
> > +		break;
> > +	case AN8855_PMSR_SPEED_2500:
> > +		state->speed = SPEED_2500;
> > +		break;
> > +	case AN8855_PMSR_SPEED_5000:
> > +		state->speed = SPEED_5000;
> 
> Same here for the SPEED_5000, unless i'm missing something :)
>

Ditto same explaination above.

-- 
	Ansuel


Return-Path: <netdev+bounces-173469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4CAA59224
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B26D3AFD54
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248AD22A7F2;
	Mon, 10 Mar 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlHxb33F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747E22A4F2;
	Mon, 10 Mar 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604270; cv=none; b=cx2JRddgYeo96RmXKvKxA3C+oprUmm/3iUrS/vxi72vqthp405GScbxreY6pH+2SeirKmp5sWAY0TGTjCM+ba/AWcnZ7lQ1LnWiYbVVr0cFaAj3b7YKop8PKu0XHh/psDiVf49z6BVx6y5lt5YQYY0slJmWso5DY1gwmkaD8yMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604270; c=relaxed/simple;
	bh=uJw9kg+WhrQUC7QeXnlkc/WQDIPvPu+MedSuKX9lsr8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp8Bk7aJb0875OV4ZyQECwJdK3bs6YLmaiPbWSMenbPpvtVZVkIhxCVrdS6UkS7xv02u99L5jB0vcL6TGKNXkBF+8aJnbxNf3UjUPMVPGFVF2zcTHwHth3CntNTsjEu0ezKYq3MFYKggQJq5TXt5NKeFBB5mGipHT0L56Polwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlHxb33F; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so1883723a12.2;
        Mon, 10 Mar 2025 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741604266; x=1742209066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xOafrjis4rlmeWlptFsFh4bdDZx32GpWyV/5UBeU/58=;
        b=jlHxb33FBbeXqj69/Y6HC1kBy3cJPLikdjGq7C/Nv5uVXEnHXawr6dujFDynFkH3fo
         uzl3X6ZjhAhxjWrw79CUTNqMVkQtHK7z0oDZfgxCznJVDYPMM1vz7qXLUF9uVoBuHCvS
         bmit1bGA7hSmPmkI1hj2qIE9RJ3salxRFIHKglaqj6toyz9g7PyYVT3f6BvKwkqxlliW
         BMP1g7V74g5PTAUXQ2AaF6bryPqtT4VSCBcY/3/CDbzgarHSGVu/olllU7L2BMby4AGR
         b4ZoWeT6bBOd3TATD5/HB6AHcVfVv72QXSh0FVvzMWWB9ww6rpXCSgR+gfaIDHyHhudO
         lqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604266; x=1742209066;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOafrjis4rlmeWlptFsFh4bdDZx32GpWyV/5UBeU/58=;
        b=YE9Ty67KnaPDYQRk4URBS2pgyJlqW+XXj4i4SvtJbpa/MxzAJP/E2OCS+zEGJc83RD
         JzqROlOnLsi4ZpsteZDy3+z2pNTbmV+Ge/fWgbOBTKN8B8uRUVaVqkb/1MxBsA4GcZMx
         f8vuyyuIfFlenXPUIRB4eL48y2QZKwyH530/BUhKxSV54yRNKSZNTD6UeJ7kCePx5X7a
         0q3LcvjegLtycp/05Rii7892ujFfe3f2yO9h8vWlSmOEQs5Gax9d5o17ceyCeHINNgPT
         4fjMzDzVXdvJH0W98gu0cvhE2rmG+NyUPnA3lftBQ+wmgRfwdS6Dk3Qbl+vqSABdvFe1
         OeVA==
X-Forwarded-Encrypted: i=1; AJvYcCWDUMa+n5t6E6B+bkOzVYcS9f7LhA88QVD6AC92DBgO7jpLuMjPFTiwr7WLvNbQEdCJDWGxSsFS@vger.kernel.org, AJvYcCX8S6i7ggDarWaCHNx59T9qSV7s7vsgni0K6WmM8GlB6H3Cwznyx2X+VQO9kquAg6xuwLyLeIJsl95JhsJ7@vger.kernel.org, AJvYcCXsyzP+TVbcZ8IKP32ZxqFEGSXuLYCK+05FVHOBUPMQhqrmnwcXIhRdt3ZRiMtrZZA8bpjUCitTylKo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqdr0qa/AEwm8fYfjzDEoNAvWrhiLiSRmE2m49Zpq4kuvxEVqs
	LD5crBQNkhkKtIfCTeAos6pLBuhrlqlAw9VR99KeK+FLBC5/OCNq
X-Gm-Gg: ASbGncvrHoOCIQZr8OBOnP0RjUnQcFkSKbxZf0AP8FYA3yNSUGGumbrf6IeT9H7Ur48
	xKP6790UCsS0+xbJoWUkxfbXTngZQ52zdLhVBQm/+kWr4JD69ho+tKO1s7JTqiFDXz1bYQJkEwf
	Vr9SzQJh7pQ0bS5rSfrXobioasvh6u9hZc6opEnrYvYuwcufFKApg+4txppebRYY2XDtyw6tmHi
	NlykuphJtCo6o8JYGQHbO038Q4Au+DFcjbApQkwwdcMgjEzG9BfGsQ18A7tKi1iZGYqunYcxHfL
	uZXegbu9vfeM7m7mYJXG80wH40779Gz9eFZeMX9hNQ==
X-Google-Smtp-Source: AGHT+IGLrFwyyNplAxUO1/Ogn4TU95VnBR/ptGo3XUAJNa2IReXJQVvMshhinBV/v52EUsoHkt8Upg==
X-Received: by 2002:a17:907:94cb:b0:abf:40a2:40c8 with SMTP id a640c23a62f3a-ac252ae1b6emr1330310766b.28.1741604266018;
        Mon, 10 Mar 2025 03:57:46 -0700 (PDT)
Received: from Ansuel-XPS. ([85.119.46.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2856445b1sm321901566b.60.2025.03.10.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:57:45 -0700 (PDT)
Message-ID: <67cec5a9.170a0220.93f86.9dcf@mx.google.com>
X-Google-Original-Message-ID: <Z87FpUEtUUQYB6s-@Ansuel-XPS.>
Date: Mon, 10 Mar 2025 11:57:41 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 12/13] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-13-ansuelsmth@gmail.com>
 <Z83WgMeg_IxgbxhO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z83WgMeg_IxgbxhO@shell.armlinux.org.uk>

On Sun, Mar 09, 2025 at 05:57:20PM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 09, 2025 at 06:26:57PM +0100, Christian Marangi wrote:
> > +static int an8855_port_enable(struct dsa_switch *ds, int port,
> > +			      struct phy_device *phy)
> > +{
> > +	struct an8855_priv *priv = ds->priv;
> > +
> > +	return regmap_set_bits(priv->regmap, AN8855_PMCR_P(port),
> > +			       AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> 
> Shouldn't you wait for phylink to call your mac_link_up() method?
>

Did something change recently for this? I checked the pattern for other
driver and port enable normally just enable TX/RX traffic for the port.

Any hint for this?

> > +}
> > +
> > +static void an8855_port_disable(struct dsa_switch *ds, int port)
> > +{
> > +	struct an8855_priv *priv = ds->priv;
> > +	int ret;
> > +
> > +	ret = regmap_clear_bits(priv->regmap, AN8855_PMCR_P(port),
> > +				AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN);
> > +	if (ret)
> > +		dev_err(priv->ds->dev, "failed to disable port: %d\n", ret);
> 
> Doesn't the link get set down before this is called? IOW, doesn't
> phylink call your mac_link_down() method first?
> 
> ...
> 
> > +static void an8855_phylink_mac_link_up(struct phylink_config *config,
> > +				       struct phy_device *phydev, unsigned int mode,
> > +				       phy_interface_t interface, int speed,
> > +				       int duplex, bool tx_pause, bool rx_pause)
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
> > +			dev_err(priv->ds->dev, "Missing support for 5G speed. Aborting...\n");
> > +			return;
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
> 
> Why? Maybe consider implementing the phylink tx_lpi functions for EEE
> support.
> 

Will do, I disabled this as the EEE rework was being approved.

> > +	}
> > +
> > +	reg |= AN8855_PMCR_TX_EN | AN8855_PMCR_RX_EN;
> > +
> > +	regmap_write(priv->regmap, AN8855_PMCR_P(port), reg);
> > +}
> > +
> > +static unsigned int an8855_pcs_inband_caps(struct phylink_pcs *pcs,
> > +					   phy_interface_t interface)
> > +{
> > +	/* SGMII can be configured to use inband with AN result */
> > +	if (interface == PHY_INTERFACE_MODE_SGMII)
> > +		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> > +
> > +	/* inband is not supported in 2500-baseX and must be disabled */
> > +	return  LINK_INBAND_DISABLE;
> 
> Spurious double space.
> 

Will drop.

> > +}
> > +
> > +static void an8855_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
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
> > +		dev_err(priv->ds->dev, "Missing support for 5G speed. Setting Unknown.\n");
> > +		fallthrough;
> 
> Which is wrong now, we have SPEED_5000.
> 

Maybe the comments weren't so clear. The Switch doesn't support the
speed... Even if it does have bits, the switch doesn't support it. And
the 2500 speed is really only for the CPU port. The user port are only
gigabit.

> > +	default:
> > +		state->speed = SPEED_UNKNOWN;
> > +		break;
> > +	}
> > +
> > +	if (val & AN8855_PMSR_RX_FC)
> > +		state->pause |= MLO_PAUSE_RX;
> > +	if (val & AN8855_PMSR_TX_FC)
> > +		state->pause |= MLO_PAUSE_TX;
> > +}
> > +
> > +static int an8855_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +			     phy_interface_t interface,
> > +			     const unsigned long *advertising,
> > +			     bool permit_pause_to_mac)
> > +{
> > +	struct an8855_priv *priv = container_of(pcs, struct an8855_priv, pcs);
> > +	u32 val;
> > +	int ret;
> > +
> > +	/*                   !!! WELCOME TO HELL !!!                   */
> > +
> [... hell ...]

Will drop :( It was an easter egg for the 300 lines to configure PCS.

> > +	ret = regmap_write(priv->regmap, AN8855_MSG_RX_LIK_STS_2,
> > +			   AN8855_RG_RXFC_AN_BYPASS_P3 |
> > +			   AN8855_RG_RXFC_AN_BYPASS_P2 |
> > +			   AN8855_RG_RXFC_AN_BYPASS_P1 |
> > +			   AN8855_RG_TXFC_AN_BYPASS_P3 |
> > +			   AN8855_RG_TXFC_AN_BYPASS_P2 |
> > +			   AN8855_RG_TXFC_AN_BYPASS_P1 |
> > +			   AN8855_RG_DPX_AN_BYPASS_P3 |
> > +			   AN8855_RG_DPX_AN_BYPASS_P2 |
> > +			   AN8855_RG_DPX_AN_BYPASS_P1 |
> > +			   AN8855_RG_DPX_AN_BYPASS_P0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> Is this disruptive to the link if the link is up, and this is called
> (e.g. to change the advertisement rather than switch interface mode).
> If so, please do something about that - e.g. only doing the bulk of
> the configuration if the interface mode has changed.

Airoha confirmed this is not disruptive, applying these config doesn't
terminate or disrupt the link.

> 
> I guess, however, that as you're only using SGMII with in-band, it
> probably doesn't make much difference, but having similar behaviour
> in the various drivers helps with ongoing maintenance.

Do we have some driver that implement the logic of skipping the bulk of
configuration if the mode doesn't change?

Maybe we can introduce some kind of additional OP like .init to apply
the very initial configuration that are not related to the mode.
Or something like .setup?

-- 
	Ansuel


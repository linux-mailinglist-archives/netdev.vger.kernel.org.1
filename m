Return-Path: <netdev+bounces-233369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A89C1287A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB3DA4E488D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB46221723;
	Tue, 28 Oct 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0vWyiOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF691F3BAC
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614679; cv=none; b=MckTD1sNn0W6PTMc4voG2cBrjz3SWg0zqgXV4i0cNl57qgeV1T0iOc+5FSxmVIzOBKblkcY+smNK4GcT6x7bsB+20alQmibCpSZEeiDBJSNVlO6M2Ow15ro9DFaTrU2IIdM3S70Y6mNrxAnPq243xArAEa8DbtMEZR9Nf1Ur5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614679; c=relaxed/simple;
	bh=4NynEzoNyOfOs8XyWeTXvjhSF0u2cim6vJPFRBLI9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgxHZ1QVfWY7OA9Voy0IqDKuj0DW0VCET9TFHRjANWCHoHwosB702H9ESv8AauxH+wCNakKkRfqkis9jjiWjuUU8TNhLWxOUf3X7TlF+zuswCAl0mgjOEd+m8oOyaXOjGzekp1Uj+R5217LTO89j3wbhUvbseYYYNObinyEN3Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0vWyiOX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-40d0c517f90so405821f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761614676; x=1762219476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6ZUZTL7e8DmbC5jX0PFFaJJw/WLsr+LBeNutmHi75Q=;
        b=U0vWyiOXFdS9xWx9iPhxP8CO8sDbMQfTOV7rsbYJkDhDS6PtbYVb0Ffld5O/rR0lP8
         k7XWkd8a/ql282mxQbXFhjIudFEqg14+u3qdwXyXYrvHri5q0yNq8E4qZ6GvXGqW+a3k
         NIRd/cv1GMgyqI2+Z2wpj+jzEN/84Kpw34f4zjp5hmYOXNuIGMGJ/3gfPPkHLMWCumv5
         +ggkMYNg9zgkj2O5dEwY8UV/8nj7vHW2Zioni4eTw0DWczZw5CUWjUsQwdRF60y/XIwo
         ds822BcfAeVpSXHUaduOF9D2A0bNZUB8hHzfyTc5nq8Hwn1MYOhYKVKGHBnh33DMcJjL
         CNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614676; x=1762219476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ZUZTL7e8DmbC5jX0PFFaJJw/WLsr+LBeNutmHi75Q=;
        b=XXPY2/+OMYp/9Gx2JMU9QzEfhgs16UCMgFcwLh3+pssY91wQ6f/EB9u0PTPCyHeHqy
         6Lfs1hyJW0U1/m8K7E4jyPeHJcTL55UUJk8Jt60r/wpSQcTUXYKRJU5l16sqN81+fXAG
         cCkpOZFFSAZ+wXXB5ELY1ZKmS8C4ccT83JfT6yLWH2LWx29YlQwhcPvzYecrwEbRY5DM
         5VT/UJwH7Z5D6gfLGtJlH7ADCFIltHZ/eM5QX6NP8dVMSGJ7qVvPZXBqRWfQwJe7079Z
         y54mqSBH6clSgLSnQ4106e6AfoirfSA5MGy8UfvMIcZsHfzT4JCA58l/4NwKfi9ATfA+
         ggHg==
X-Forwarded-Encrypted: i=1; AJvYcCXrFW+/YZhdk0bH3cQcF94XMd7nn9Lg1s4nDCtYozMm9xwUccv9vSZSyDDORHD75zkGytqmtxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJiV6ECb+tOSoSxRpjJYo1r4eoYTFf3Rr61pU0OEQC1M2vYRrg
	jVrcO3IrGvJvcPGgVK6oPxBmgunWDHgRbY1So2+XQSUWJvaQf+MQLDO/
X-Gm-Gg: ASbGnctp5Jjp+TnsZQhrOrx2SBOxiSqtqB/PW6U9f56siB62hUonq+eRIdtKPkHjxVa
	rFLJWLS3f7KtagMozUf+/Zqn50suPAurtr9uihe2o11B1MgtyR4YgePKc7Ynf3AaBfId4sFq2hB
	u9tuD2RwYQaMZyAo4bYOskjE8v0F+yXv/BDSnMhshUE/K4G1fl+MeuQhyeESXKL8ywTC/QrIRRH
	j5BhI13+fgVpjzaYQ5j4IJKFU+O/CS3eQL8Wr/S5NGAzCgbEjpbLXCp4SYknXeT22LQN9r66LsO
	0v71DcCpJrFABO6ciJkjCjhaM05vpYWuf6dqYNsGICs6rBKoEe7gWes8ReVXJsuk2vPRCUrtG4U
	WCroBF7UhgF7ER3RjVTe0VAHIDmkBcsWWPiOByJn3vwEnafLTePzYo9nqjihgogqgSjjz
X-Google-Smtp-Source: AGHT+IG/sB2R//ACIIQwX3tQN8RaWUDP77vJKaawkbWCs1s/0AV7Jp1petBnpZs8/SYh4yt0C2qaFQ==
X-Received: by 2002:a05:600c:45c7:b0:46b:938b:6897 with SMTP id 5b1f17b1804b1-47717df84a7mr8002495e9.1.1761614675505;
        Mon, 27 Oct 2025 18:24:35 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cd5dsm164144055e9.4.2025.10.27.18.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 18:24:34 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:24:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <20251028012430.2khnl6hts2twyrz3@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>
 <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>
 <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:49:10PM +0000, Daniel Golle wrote:
> Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
> are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
> and Intel GRX MIPS router SoCs. The main difference is that instead of
> using memory-mapped I/O to communicate with the host CPU these ICs are
> connected via MDIO (or SPI, which isn't supported by this driver).
> Implement the regmap API to access the switch registers over MDIO to allow
> reusing lantiq_gswip_common for all core functionality.
> 
> The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
> 2500Base-X, which can either be used to connect an external PHY or SFP
> cage, or as the CPU port. Support for the SerDes interface is implemented
> in this driver using the phylink_pcs interface.

I opened the GSW145 datasheet and it seems borderline in terms of what
I'd suggest to implement via MFD, keeping the DSA driver to be just for
the switch fabric, vs implementing everything in the DSA driver.

Just to know what to expect in the future. Are there higher-spec'd
switches with an embedded CPU, waiting to be supported by Linux?
Linux running outside, but also potentially inside? Maybe you'll need
full-fledged clock, pinmux, GPIO drivers, due to IPs reused in other
parts? Interrupt controller support? The SGMII "PHY" block also seems
distinct from the "PCS" block, more like a driver in drivers/phy/ would
control.

> +
> +static int gsw1xx_pcs_phy_xaui_write(struct gsw1xx_priv *priv, u16 addr,
> +				     u16 data)
> +{
> +	int ret, val;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_D, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_A, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_C,
> +			   GSW1XX_SGMII_PHY_WRITE |
> +			   GSW1XX_SGMII_PHY_RESET_N);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(priv->sgmii, GSW1XX_SGMII_PHY_C,
> +					val, val & GSW1XX_SGMII_PHY_STATUS,
> +					1000, 100000);
> +}
> +
> +static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
> +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds,
> +					       GSW1XX_SGMII_PORT);

In lack of the phy-mode = "revsgmii" that you also mention, can we just
assume that any port with phy-mode = "sgmii" is in "MAC mode"?

> +	struct dsa_port *dp = dsa_to_port(priv->gswip.ds,
> +					  GSW1XX_SGMII_PORT);
> +	u16 txaneg, anegctl, val, nco_ctrl;
> +	bool reconf = false;
> +	int ret;
> +
> +	/* do not unnecessarily disrupt link and skip resetting the hardware in
> +	 * case the PCS has previously been successfully configured for this
> +	 * interface mode
> +	 */
> +	if (priv->tbi_interface == interface)
> +		reconf = true;
> +
> +	/* mark PCS configuration as incomplete */
> +	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
> +
> +	if (reconf)
> +		goto skip_init_reset;
> +
> +	/* Assert and deassert SGMII shell reset */
> +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +			      GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +				GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Hardware Bringup FSM Enable  */
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_HWBU_CTRL,
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM |
> +			   GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure SGMII PHY Receiver */
> +	val = FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_EQ,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF) |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN |
> +	      GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN |
> +	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
> +			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
> +
> +	if (of_property_read_bool(dp->dn, "maxlinear,rx-inverted"))
> +		val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_PREP(GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL,
> +			 GSW1XX_SGMII_PHY_TX0_CFG3_VBOOST_LEVEL_DEF);
> +
> +	if (of_property_read_bool(dp->dn, "maxlinear,tx-inverted"))
> +		val |= GSW1XX_SGMII_PHY_TX0_CFG3_INVERT;
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_TX0_CFG3, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Reset and Release TBI */
> +	val = GSW1XX_SGMII_TBI_TBICTL_INITTBI | GSW1XX_SGMII_TBI_TBICTL_ENTBI |
> +	      GSW1XX_SGMII_TBI_TBICTL_CRSTRR | GSW1XX_SGMII_TBI_TBICTL_CRSOFF;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
> +	if (ret < 0)
> +		return ret;
> +	val &= ~GSW1XX_SGMII_TBI_TBICTL_INITTBI;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TBICTL, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Release Tx Data Buffers */
> +	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
> +			      GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_TXB_CTL,
> +				GSW1XX_SGMII_PCS_TXB_CTL_INIT_TX_TXB);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Release Rx Data Buffers */
> +	ret = regmap_set_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
> +			      GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_clear_bits(priv->sgmii, GSW1XX_SGMII_PCS_RXB_CTL,
> +				GSW1XX_SGMII_PCS_RXB_CTL_INIT_RX_RXB);
> +	if (ret < 0)
> +		return ret;
> +
> +skip_init_reset:
> +	/* override bootstrap pin settings
> +	 * OVRANEG sets ANEG Mode, Enable ANEG and restart ANEG to be
> +	 * taken from bits ANMODE, ANEGEN, RANEG of the ANEGCTL register.
> +	 * OVERABL sets ability bits in tx_config_reg to be taken from
> +	 * the TXANEGH and TXANEGL registers.
> +	 */
> +	anegctl = GSW1XX_SGMII_TBI_ANEGCTL_OVRANEG |
> +		  GSW1XX_SGMII_TBI_ANEGCTL_OVRABL;
> +
> +	switch (phylink_get_link_timer_ns(interface)) {
> +	case 10000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10US);
> +		break;
> +	case 1600000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_1_6MS);
> +		break;
> +	case 5000000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_5MS);
> +		break;
> +	case 10000000:
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_LT,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_LT_10MS);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (neg_mode & PHYLINK_PCS_NEG_INBAND)
> +		anegctl |= GSW1XX_SGMII_TBI_ANEGCTL_ANEGEN;
> +
> +	if (interface == PHY_INTERFACE_MODE_SGMII) {
> +		if (sgmii_mac_mode) {
> +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_MAC);
> +			txaneg = ADVERTISE_SGMII | ADVERTISE_LPACK;
> +		} else {
> +			/* lacking a defined reverse-SGMII interface mode this
> +			 * driver decides whether SGMII (MAC side) or SGMII (PHY side)
> +			 * is being used based on the port being a user port.
> +			 */
> +			anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +					      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_SGMII_PHY);
> +			txaneg = LPA_SGMII | LPA_SGMII_1000FULL;
> +		}
> +	} else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> +		   interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		anegctl |= FIELD_PREP(GSW1XX_SGMII_TBI_ANEGCTL_ANMODE,
> +				      GSW1XX_SGMII_TBI_ANEGCTL_ANMODE_1000BASEX);
> +		txaneg = phylink_mii_c22_pcs_encode_advertisement(interface,
> +								  advertising);
> +	} else {
> +		dev_err(priv->gswip.dev, "%s: wrong interface mode %s\n",
> +			__func__, phy_modes(interface));
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGH,
> +			   FIELD_GET(GENMASK(15, 8), txaneg));
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_TXANEGL,
> +			   FIELD_GET(GENMASK(7, 0), txaneg));
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_TBI_ANEGCTL, anegctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!reconf) {
> +		/* setup SerDes clock speed */
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
> +		else
> +			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
> +
> +		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
> +					 GSW1XX_SGMII_HSP_MASK |
> +					 GSW1XX_SGMII_SEL,
> +					 nco_ctrl);
> +		if (ret)
> +			return ret;
> +
> +		ret = gsw1xx_pcs_phy_xaui_write(priv, 0x30, 0x80);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* PCS configuration has now been completed, set mode to prevent
> +	 * disrupting the link in case of future calls of this function for the
> +	 * same interface mode.
> +	 */
> +	priv->tbi_interface = interface;
> +
> +	return 0;
> +}

Can you split up this function in multiple smaller logical blocks?
The control flow with "reconf" and "skip_init_reset" is a bit difficult
to follow. I can't say I understood what's going on. Ideally
gsw1xx_pcs_config() fits in one-two screen.

> +static int gsw1xx_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct gsw1xx_priv *priv;
> +	u32 version;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->mdio_dev = mdiodev;
> +	priv->smdio_badr = GSW1XX_SMDIO_BADR_UNKNOWN;
> +
> +	priv->gswip.dev = dev;
> +	priv->gswip.hw_info = of_device_get_match_data(dev);
> +	if (!priv->gswip.hw_info)
> +		return -EINVAL;
> +
> +	priv->gswip.gswip = gsw1xx_regmap_init(priv, "switch",
> +					       GSW1XX_SWITCH_BASE, 0xfff);
> +	if (IS_ERR(priv->gswip.gswip))
> +		return PTR_ERR(priv->gswip.gswip);
> +
> +	priv->gswip.mdio = gsw1xx_regmap_init(priv, "mdio", GSW1XX_MMDIO_BASE,
> +					      0xff);
> +	if (IS_ERR(priv->gswip.mdio))
> +		return PTR_ERR(priv->gswip.mdio);
> +
> +	priv->gswip.mii = gsw1xx_regmap_init(priv, "mii", GSW1XX_RGMII_BASE,
> +					     0xff);
> +	if (IS_ERR(priv->gswip.mii))
> +		return PTR_ERR(priv->gswip.mii);
> +
> +	priv->sgmii = gsw1xx_regmap_init(priv, "sgmii", GSW1XX_SGMII_BASE,
> +					 0xfff);
> +	if (IS_ERR(priv->sgmii))
> +		return PTR_ERR(priv->sgmii);
> +
> +	priv->gpio = gsw1xx_regmap_init(priv, "gpio", GSW1XX_GPIO_BASE, 0xff);
> +	if (IS_ERR(priv->gpio))
> +		return PTR_ERR(priv->gpio);
> +
> +	priv->clk = gsw1xx_regmap_init(priv, "clk", GSW1XX_CLK_BASE, 0xff);
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
> +	priv->shell = gsw1xx_regmap_init(priv, "shell", GSW1XX_SHELL_BASE,
> +					 0xff);
> +	if (IS_ERR(priv->shell))
> +		return PTR_ERR(priv->shell);
> +
> +	priv->pcs.ops = &gsw1xx_pcs_ops;
> +	priv->pcs.poll = true;
> +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> +		  priv->pcs.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +		  priv->pcs.supported_interfaces);
> +	if (priv->gswip.hw_info->supports_2500m)
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  priv->pcs.supported_interfaces);
> +	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
> +
> +	/* assert SGMII reset to power down SGMII unit */
> +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> +			      GSW1XX_RST_REQ_SGMII_SHELL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* configure GPIO pin-mux for MMDIO in case of external PHY connected to

Can you explain that MMDIO stands for MDIO master interface? On first
sight it looks like a typo.

> +	 * SGMII or RGMII as slave interface
> +	 */
> +	regmap_set_bits(priv->gpio, GPIO_ALTSEL0, 3);
> +	regmap_set_bits(priv->gpio, GPIO_ALTSEL1, 3);
> +
> +	ret = regmap_read(priv->gswip.gswip, GSWIP_VERSION, &version);
> +	if (ret)
> +		return ret;
> +
> +	ret = gswip_probe_common(&priv->gswip, version);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(dev, &priv->gswip);
> +
> +	return 0;
> +}


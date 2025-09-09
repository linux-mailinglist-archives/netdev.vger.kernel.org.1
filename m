Return-Path: <netdev+bounces-221133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B3B4A6DF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E427BB130
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5728726B;
	Tue,  9 Sep 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Lneve32F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB1285CB8;
	Tue,  9 Sep 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408985; cv=none; b=CSlILncR9BCkifprj0rgrdTXqsdaupV+7U61nTIfTngZ36vBdlNQxUrlKwnC7cL3xfA3N2KIBpEUCKuPSB+hmauyB4TPg+UaC7kGQ7J2laWjafUBxtCDtVEWnCLCwtK9hS7qIBOPPyCJNt8jS3T9nhjUMcOAbr0Jfd8pMQOHV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408985; c=relaxed/simple;
	bh=odf1DGWgfqUGLkUILOerYDdH/AciEovfcZ6Q/o+Xyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG+q9HePOlpuwePcuc6nGLk3lEqf86ifQv6Ht5IbQwL7fcg0yYGx0qfihM+9/+D0JKn1GusLlT2ODCxEUEVuawqOn9InoyO5OgnNGGThPH7RHlUASFuGHZcg5aatiENz4ztAFrR48HoN5UFHSsCPVTP2xQNtiPwoODKW/RQb2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Lneve32F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W5yCldw9Ui0PQdaUryQ7+dVXsj2JWAh+weDkVvcZLVM=; b=Lneve32F7PjadMleGWG34WGj6d
	VnT/OKOi/tMc+rXvp5mD1Ff9J5b9lK9TQnfudYPDmao6s68OS37tEK9qZTxsOpDiphIHxZ2GPD930
	j7Fr+D+VOsdEQUxC5dTOt8ZyiJPRtgiR61Yps7a8pn4+qocE8D91wLbOYeWdw7CoTNmvChiZrjht8
	x7VAMoi7i1ABsLOtxD0mU5LSTEqdf8dy/s5V9xnyf1R+hzhaL/5h9vwj1Y0XO2uBdD0VNhJ7CqZzc
	TmQX78staw+O8AMvMqWmCYwhx+xMJPFJCxyPdS0laLJ7JUCaM8EsGDIWbrjzi9l7eyWr9/RB8jNB6
	oLBzX/1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37982)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uvuLb-000000007vX-2AJK;
	Tue, 09 Sep 2025 10:09:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uvuLS-000000000Gl-1UJ2;
	Tue, 09 Sep 2025 10:08:58 +0100
Date: Tue, 9 Sep 2025 10:08:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v16 06/10] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <aL_uqX90oP_3hbK6@shell.armlinux.org.uk>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
 <20250909004343.18790-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909004343.18790-7-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 09, 2025 at 02:43:37AM +0200, Christian Marangi wrote:
> +static void an8855_phylink_get_caps(struct dsa_switch *ds, int port,
> +				    struct phylink_config *config)
> +{
> +	struct an8855_priv *priv = ds->priv;
> +	u32 reg;
> +	int ret;
> +
> +	switch (port) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +		__set_bit(PHY_INTERFACE_MODE_GMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		break;
> +	case 5:
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		break;
> +	}
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
> +
> +	ret = regmap_read(priv->regmap, AN8855_CKGCR, &reg);
> +	if (ret)
> +		dev_err(ds->dev, "failed to read EEE LPI timer\n");
> +
> +	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
> +	/* Global LPI TXIDLE Threshold, default 60ms (unit 2us) */
> +	config->lpi_timer_default = FIELD_GET(AN8855_LPI_TXIDLE_THD_MASK, reg) *
> +				    AN8855_TX_LPI_UNIT;

You're not filling in config->lpi_interfaces, which means phylink won't
LPI won't be functional.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


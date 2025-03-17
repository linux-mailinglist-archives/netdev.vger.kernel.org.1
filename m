Return-Path: <netdev+bounces-175236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37058A647D9
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABE23B1D49
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F121A426;
	Mon, 17 Mar 2025 09:44:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD0191499
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204674; cv=none; b=HRX3VtY2DNaaJ0KbBHy3eG6dV3H/885SvzGLiltRdAkp6ZKzw+GJapLz99UMD7O9sd0H23nWX1Pe1QROzAs8BXm4W8CIMOuqv+WzpLUe5SbOA1hJcKl3FHBK6WsJaz7l3Nm9osmD4Cy/jT3LvY4GxDHBs3KpqQX5hnH4sR4s8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204674; c=relaxed/simple;
	bh=LIWRdeVeAfVd98ngyW8UtjnpWxzx1XoS06rstlg+cN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o97df17dlPfenOXBbOYEBGSGT3V1DRnHYS0iXthvlCOAvMwr1rUKgCxBkGpBhEG+blU6zsAGirF2Sj0E4iZ/i+9SpYeR1M8gvtSjOaH39MVvPj23rd9v/AIv0lw8FbE0auuKuNZAG7yUf25BlZ3uZDCfQM7Bdd+boFSko8keqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70q-0003jl-Cx; Mon, 17 Mar 2025 10:44:00 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70o-000DrX-12;
	Mon, 17 Mar 2025 10:43:58 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tu70o-0018B3-1s;
	Mon, 17 Mar 2025 10:43:58 +0100
Date: Mon, 17 Mar 2025 10:43:58 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 03/12] net: pse-pd: tps23881: Add support for
 PSE events and interrupts
Message-ID: <Z9fu3u34K3-OeDis@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-feature_poe_port_prio-v6-3-3dc0c5ebaf32@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Mar 04, 2025 at 11:18:52AM +0100, Kory Maincent wrote:
> +static int tps23881_irq_handler(int irq, struct pse_controller_dev *pcdev,
> +				unsigned long *notifs,
> +				unsigned long *notifs_mask)
> +{
> +	struct tps23881_priv *priv = to_tps23881_priv(pcdev);
> +	struct i2c_client *client = priv->client;
> +	int ret, it_mask;
> +
> +	/* Get interruption mask */
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT_MASK);
> +	if (ret < 0)
> +		return ret;
> +	it_mask = ret;
> +
> +	/* Read interrupt register until it frees the interruption pin. */
> +	while (true) {

If the hardware has a stuck interrupt, this could result in an infinite
loop. max_retries with some sane value would be good.

> +		ret = i2c_smbus_read_word_data(client, TPS23881_REG_IT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* No more relevant interruption */
> +		if (!(ret & it_mask))
> +			return 0;
> +
> +		ret = tps23881_irq_event_handler(priv, (u16)ret, notifs,
> +						 notifs_mask);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int tps23881_setup_irq(struct tps23881_priv *priv, int irq)
> +{
> +	struct i2c_client *client = priv->client;
> +	struct pse_irq_desc irq_desc = {
> +		.name = "tps23881-irq",

here or in devm_pse_irq_helper() it would be good to add intex suffix to
the irq handler name.

v> +		.map_event = tps23881_irq_handler,
> +	};
> +	int ret;
> +	u16 val;
> +
> +	val = TPS23881_REG_IT_IFAULT | TPS23881_REG_IT_SUPF;
> +	val |= val << 8;
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_IT_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, TPS23881_REG_GEN_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (u16)(ret | TPS23881_REG_INTEN | TPS23881_REG_INTEN << 8);
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_GEN_MASK, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_pse_irq_helper(&priv->pcdev, irq, 0, &irq_desc);
> +}
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


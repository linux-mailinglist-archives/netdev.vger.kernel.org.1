Return-Path: <netdev+bounces-148438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84E9E193F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723E22879A1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD01E1C2D;
	Tue,  3 Dec 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbygLMXz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA51E1C14;
	Tue,  3 Dec 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221760; cv=none; b=Wiz7laHlsGfdBpPv+LrtzcZ4czVUPZhCHuXOqdpCQ+wnQ1o5j0Zk2zCPPqvcmBNni3a7HmpXOo42AjtW71+oKSRyeGV7+2zgDuiQfc1l3e2Syc9pdhm2Ndg6vxzKkaZ9+2bO2QwRN951vurIOICk+yXFJAJJ76zgXxrVXtdRXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221760; c=relaxed/simple;
	bh=XUuRyTfQ3tYPh31NVuis3MXPsprCUj4fXIe4ghTE6So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j88wqb+hIDlfTslcgHT87w5zPUW3tbX1EEXTNJ+RqKLJ895TSJwChQ7ZETfvEGZT0Qx2wCybDURVReXvSjXuhaZg/V8oI2PCc8jj/ZPd9iC04cFyoPn2WKLXsYJ507eVe09JJfjK3u5Mpf1Syvu4Sz+jcysL7ZKEKOghi+baQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbygLMXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D373C4CECF;
	Tue,  3 Dec 2024 10:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733221759;
	bh=XUuRyTfQ3tYPh31NVuis3MXPsprCUj4fXIe4ghTE6So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbygLMXzt9cb60YsDKViS7r1gNVigl/Kx3QUYu5UwTarb4ULm26quG8I4f0MkRjff
	 6nRFKJq/BG+8IhbhyDc6K7qWgboVadib7eo5IeqbCrMXUDkI6HirEK1DyGM2C31SX+
	 khqMuHahuG0zH7dH+6hZom80jd1BEuSZC+vYHT9KCkePYHHa46ioaq71ad6MaAhVpj
	 3gD4Nt6/ZPoYExKYcQ/sASZZd8DaIdHNZEF0cmkFKfKQNq8nwxX/fBzpmW/+Rliuu0
	 Z28ywNIdJP5MPgUFqhwlc607CJYPKEIqf/93kpzYLcS2s6zLT9e5W4ZyPsbh3FfR0J
	 ATSXQ4hU9J1qA==
Date: Tue, 3 Dec 2024 10:29:13 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 26/27] net: pse-pd: tps23881: Add support
 for static port priority feature
Message-ID: <20241203102913.GD9361@kernel.org>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
 <20241121-feature_poe_port_prio-v3-26-83299fa6967c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-feature_poe_port_prio-v3-26-83299fa6967c@bootlin.com>

On Thu, Nov 21, 2024 at 03:42:52PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch enhances PSE callbacks by introducing support for the static
> port priority feature. It extends interrupt management to handle and report
> detection, classification, and disconnection events. Additionally, it
> introduces the pi_get_pw_req() callback, which provides information about
> the power requested by the Powered Devices.
> 
> Interrupt support is essential for the proper functioning of the TPS23881
> controller. Without it, after a power-on (PWON), the controller will
> no longer perform detection and classification. This could lead to
> potential hazards, such as connecting a non-PoE device after a PoE device,
> which might result in magic smoke.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> We may need a fix for the interrupt support in old version of Linux.
> 
> Change in v3:
> - New patch
> ---
>  drivers/net/pse-pd/tps23881.c | 197 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 188 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c

...

> +static int tps23881_irq_event_detection(struct tps23881_priv *priv,
> +					u16 reg_val,
> +					unsigned long *notifs,
> +					unsigned long *notifs_mask)
> +{
> +	enum ethtool_pse_events event;
> +	int reg, ret, i, val;
> +	u8 chans;
> +
> +	chans = tps23881_it_export_chans_helper(reg_val, 0);
> +	for_each_set_bit(i, (unsigned long *)&chans, TPS23881_MAX_CHANS) {

Hi Kory,

The storage size of chans is only 1 byte, but here we are pretending that
it has more space. Which seems to be a bit of a stretch. Perhaps it would
be better to simply use unsigned long as the type of chans here and in
tps23881_irq_event_classification().

W=1 build with gcc-14 on x86_64 complains about this line as follows:

In function 'find_next_bit',
    inlined from 'tps23881_irq_event_detection' at drivers/net/pse-pd/tps23881.c:1281:2,
    inlined from 'tps23881_irq_event_handler' at drivers/net/pse-pd/tps23881.c:1363:9,
    inlined from 'tps23881_irq_handler' at drivers/net/pse-pd/tps23881.c:1400:9:
./include/linux/find.h:65:23: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'u8[1]' {aka 'unsigned char[1]'} [-Warray-bounds=]
   65 |                 val = *addr & GENMASK(size - 1, offset);
      |                       ^~~~~
drivers/net/pse-pd/tps23881.c: In function 'tps23881_irq_handler':
drivers/net/pse-pd/tps23881.c:1278:12: note: object 'chans' of size 1
 1278 |         u8 chans;
      |            ^~~~~

> +		reg = TPS23881_REG_DISC + (i % 4);
> +		ret = i2c_smbus_read_word_data(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		val = tps23881_calc_val(ret, i, 0, 0xf);
> +		/* If detection valid */
> +		if (val == 0x4)
> +			event = ETHTOOL_C33_PSE_EVENT_DETECTION;
> +		else
> +			event = ETHTOOL_C33_PSE_EVENT_DISCONNECTION;
> +
> +		tps23881_set_notifs_helper(priv, BIT(i), notifs,
> +					   notifs_mask, event);
> +	}
> +
> +	return 0;
> +}

...


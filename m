Return-Path: <netdev+bounces-41011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226227C9598
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945C1B20BE0
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC821A580;
	Sat, 14 Oct 2023 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4UvxYq2L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83518648;
	Sat, 14 Oct 2023 17:15:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E29B7;
	Sat, 14 Oct 2023 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RFB4W/lttFFinZCRqI4fRcVdzoARXKXzSN2cTHpzOiU=; b=4UvxYq2LoZB9hmBramhrJxr9TV
	MQG05VmIisD6eTWMOjK6FIQvuunnFy5O++YvV8RNrFDSckdOc17rjC/m3fWw0hjfXuzvb230F1kKi
	P2j1GHn9XnOpi3/dT9xh38LcWYjagiYKpEaD3uL+9fTryWc2MEnGYQquLzOU9hQF4NTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qriE5-002BvQ-M3; Sat, 14 Oct 2023 19:14:57 +0200
Date: Sat, 14 Oct 2023 19:14:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <877cd674-dbb8-4786-891e-1652eee16f46@lunn.ch>
References: <20231013122405.3745475-1-o.rempel@pengutronix.de>
 <20231013122405.3745475-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013122405.3745475-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> + * ksz9477_get_wol - Get Wake-on-LAN settings for a specified port.
> + * @dev: The device structure.
> + * @port: The port number.
> + * @wol: Pointer to ethtool Wake-on-LAN settings structure.
> + *
> + * This function checks the PME Pin Control Register to see if  PME Pin Output
> + * Enable is set, indicating PME is enabled. If enabled, it sets the supported
> + * and active WoL flags.

I'm missing something here: Why would the PME Pin Output Enable not be
set?

I also wounder if there should be one additional test. Is the MAC
address on the user interface the same as the one programmed in the
switch? If it is different supported should not be set.

> +void ksz9477_get_wol(struct ksz_device *dev, int port,
> +		     struct ethtool_wolinfo *wol)
> +{
> +	u8 pme_ctrl, pme_conf;
> +	int ret;
> +
> +	ret = ksz_read8(dev, REG_SW_PME_CTRL, &pme_conf);
> +	if (ret)
> +		return;
> +
> +	if (!(pme_conf & PME_ENABLE))
> +		return;
> +
> +	wol->supported = WAKE_MAGIC;
> +
> +	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
> +	if (ret)
> +		return;
> +
> +	if (pme_ctrl & PME_WOL_MAGICPKT)
> +		wol->wolopts |= WAKE_MAGIC;
> +}

> +static void ksz_get_wol(struct dsa_switch *ds, int port,
> +			struct ethtool_wolinfo *wol)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	memset(wol, 0, sizeof(*wol));

Drivers should not need this, i would expect the core to zero the
structure.


    Andrew

---
pw-bot: cr


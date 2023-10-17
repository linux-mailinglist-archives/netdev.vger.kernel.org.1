Return-Path: <netdev+bounces-41636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F47CB809
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1423281412
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAE17D8;
	Tue, 17 Oct 2023 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="szqc4imp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815215DA;
	Tue, 17 Oct 2023 01:36:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9FA2;
	Mon, 16 Oct 2023 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PdmCK+QKhB4J65trAM73Xd6W0JFw+BGZhKeUw6mvorg=; b=szqc4imp7+Ln1Gn6z8hPn9agRW
	L6hW29IERHrs1GYLIQ0pre21at26HTGXenCxq4CSSXaiJOZc/EUKQZGuwWR6lLhk5OoyVEkrneGY/
	tKFxVMrNdf7HqrEx8GbQ0VvNyBTYtjC7Nh6hwIiWx47g9vDKfJgC7TI96qq2FfQMSZ2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qsZ07-002Q9Y-Tk; Tue, 17 Oct 2023 03:36:03 +0200
Date: Tue, 17 Oct 2023 03:36:03 +0200
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
Subject: Re: [PATCH net-next v4 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <c0403dc3-db3b-4167-8abb-d920299762e7@lunn.ch>
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016141256.2011861-6-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> @@ -155,6 +158,14 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
> +		if (ret)
> +			return ret;
> +
> +		pme_ctrl |= PME_WOL_MAGICPKT;
> +	}

There is no matching ksz_switch_macaddr_put() here when the user turns
WAKE_MAGIC off. Ideally you need to keep track of the WoL state per
port, and when the user disables it, release the MAC address.

> +
>  	if (wol->wolopts & WAKE_PHY)
>  		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
>  
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 3f7c86e545a7..4601aaca5179 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3569,6 +3569,7 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
>  				    const unsigned char *addr)
>  {
>  	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct ethtool_wolinfo wol;
>  
>  	if (dp->hsr_dev) {
>  		dev_err(ds->dev,
> @@ -3577,6 +3578,14 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
>  		return -EBUSY;
>  	}
>  
> +	ksz_get_wol(ds, dp->index, &wol);
> +	if (wol.wolopts & WAKE_MAGIC) {
> +		dev_err(ds->dev,
> +			"Cannot change MAC address on port %d with active Wake on Magic Packet\n",
> +			port);

This is not really an error, as in something went wrong. Its just a
hardware restriction. So dev_warn() would be better, or nothing at all
in the logs.

   Andrew


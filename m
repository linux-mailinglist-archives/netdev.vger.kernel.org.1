Return-Path: <netdev+bounces-107477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098B91B257
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9697BB21DCC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CD1A2573;
	Thu, 27 Jun 2024 22:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88A811FE;
	Thu, 27 Jun 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528180; cv=none; b=juqqwkpvyuanz4g5ZHyJGjIRXRy2FQSSZ0aKdSl8sy3l/ch5bmsCS1nG9YbNpvw9HGb3CQf+6F91/LaAurtPsjTICfAXxmWAmAC6wMjdcW8ILy705G4zH2rJG0TQUnk1WONKy71OpKNUlTyo9iW7Zay4UBmVx1NmWj56h2dA7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528180; c=relaxed/simple;
	bh=jegK8+qk0NkM0+R20Z2W1+OFc/xAx0R0zsz5OSf1N2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svy+TFSxL25YkHt/1IVyZYuYZjLFT08/rofXyFV1K338oJJwKSLfRLJgBOeNoNOc0sq0SlEX65w5mL2tz1ABy9oW2+kio4VUUQ2carosU2v+c3B7J0cUjZln2m7pDcZZHM3j5/0iXKm1Rp5xv+vJccOiwpwRb2l3eUcYdlf8veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMxpJ-0000000089v-2ETT;
	Thu, 27 Jun 2024 22:42:49 +0000
Date: Thu, 27 Jun 2024 23:42:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <Zn3q5f5yWznMjAXd@makrotopia.org>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113018.25083-4-brgl@bgdev.pl>

Hi Bartosz,

On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for a new model to the Aquantia driver. This PHY supports
> Overlocked SGMII mode with 2.5G speeds.

I don't think that there is such a thing as "Overclocked SGMII mode with
2.5G speed".

Lets take a short look at Cisco SGMII, which is defined as a serialzed
version of the Gigabit Media-Independent Interface. As such, it supports
10M, 100M and 1000M speed. There is negotiation for speed, duplex,
flow-control and link status (up/down).

The data signals always operate at 1.25 Gbaud and the clocks operate at
625 MHz (a DDR interface), and there is a 10:8 FEC coding applied,
resulting in 1 Gbit/s usable bandwidth.

For lower speeds lower than 1 Gbit/s each symbol is repeated 10x for
100M and 100x for 10M.

Now, assuming SGMII running at 2.5x the clock speed of actual Cisco
SGMII would exist, how would that look like for lower speeds like 1000M,
100M or 10M? Obviously you cannot repeat a symbol 2.5 times, which would
make it impossible to support 1000M links with the same strategy used
for lower speeds in regular SGMII.

Hence I assume that what you meant to say here is that the PHY uses
2500Base-X as interface mode and performs rate-adaptation for speeds
less than 2500M (or half-duplex) using pause frames.

This is also what e.g. AQR112 is doing, which I would assume is fairly
similar to the newer AQR115.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 39 +++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 974795bd0860..98ccefd355d5 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -29,6 +29,7 @@
>  #define PHY_ID_AQR113	0x31c31c40
>  #define PHY_ID_AQR113C	0x31c31c12
>  #define PHY_ID_AQR114C	0x31c31c22
> +#define PHY_ID_AQR115C	0x31c31c33
>  #define PHY_ID_AQR813	0x31c31cb2
>  
>  #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
> @@ -111,7 +112,6 @@ static u64 aqr107_get_stat(struct phy_device *phydev, int index)
>  	int len_h = stat->size - len_l;
>  	u64 ret;
>  	int val;
> -
>  	val = phy_read_mmd(phydev, MDIO_MMD_C22EXT, stat->reg);
>  	if (val < 0)
>  		return U64_MAX;
> @@ -721,6 +721,18 @@ static int aqr113c_config_init(struct phy_device *phydev)
>  	return aqr107_fill_interface_modes(phydev);
>  }
>  
> +static int aqr115c_config_init(struct phy_device *phydev)
> +{
> +	/* Check that the PHY interface type is compatible */
> +	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
> +	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX)
> +		return -ENODEV;
> +
> +	phy_set_max_speed(phydev, SPEED_2500);
> +
> +	return 0;
> +}
> +
>  static int aqr107_probe(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -999,6 +1011,30 @@ static struct phy_driver aqr_driver[] = {
>  	.led_hw_control_get = aqr_phy_led_hw_control_get,
>  	.led_polarity_set = aqr_phy_led_polarity_set,
>  },
> +{
> +	PHY_ID_MATCH_MODEL(PHY_ID_AQR115C),
> +	.name           = "Aquantia AQR115C",
> +	.probe          = aqr107_probe,
> +	.get_rate_matching = aqr107_get_rate_matching,
> +	.config_init    = aqr115c_config_init,
> +	.config_aneg    = aqr_config_aneg,
> +	.config_intr    = aqr_config_intr,
> +	.handle_interrupt = aqr_handle_interrupt,
> +	.read_status    = aqr107_read_status,
> +	.get_tunable    = aqr107_get_tunable,
> +	.set_tunable    = aqr107_set_tunable,
> +	.suspend        = aqr107_suspend,
> +	.resume         = aqr107_resume,
> +	.get_sset_count = aqr107_get_sset_count,
> +	.get_strings    = aqr107_get_strings,
> +	.get_stats      = aqr107_get_stats,
> +	.link_change_notify = aqr107_link_change_notify,
> +	.led_brightness_set = aqr_phy_led_brightness_set,
> +	.led_hw_is_supported = aqr_phy_led_hw_is_supported,
> +	.led_hw_control_set = aqr_phy_led_hw_control_set,
> +	.led_hw_control_get = aqr_phy_led_hw_control_get,
> +	.led_polarity_set = aqr_phy_led_polarity_set,
> +},
>  {
>  	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
>  	.name		= "Aquantia AQR813",
> @@ -1042,6 +1078,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
> +	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR115C) },
>  	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
>  	{ }
>  };
> -- 
> 2.43.0
> 
> 


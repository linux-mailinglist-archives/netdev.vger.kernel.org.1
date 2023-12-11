Return-Path: <netdev+bounces-55956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5F580CF59
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6517F1F21672
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FA4AF75;
	Mon, 11 Dec 2023 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1gHoyuRt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A437EB;
	Mon, 11 Dec 2023 07:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YcekLTjh5+mk+lg76W+7hew/vEd7NOWaaenP7iwljuk=; b=1gHoyuRtBp6OwbKss/KRVZRgTx
	sitogZHN0shuA9eFrOI+8VEWHffM/iBomO4CuhwApypwyYqt/41wPkzxPuoP97UqdiylyQhzGN9X2
	bOUbmeHrtcj2+cUQjbE8gzPxRetCjMcwU5kb1dIFwBM5ZxtbzatjKnHkMh4U3GGAMZS0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCi6H-002dIn-QD; Mon, 11 Dec 2023 16:21:41 +0100
Date: Mon, 11 Dec 2023 16:21:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: phy: Add support for the DP83TG720S
 Ethernet PHY
Message-ID: <cfd4f8bd-a06a-4489-8304-e9576151dbce@lunn.ch>
References: <20231208151159.2791794-1-o.rempel@pengutronix.de>
 <20231208151159.2791794-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208151159.2791794-2-o.rempel@pengutronix.de>

On Fri, Dec 08, 2023 at 04:11:59PM +0100, Oleksij Rempel wrote:
> The DP83TG720S-Q1 device is an IEEE 802.3bp and Open Alliance compliant
> automotive Ethernet physical layer transceiver.
> 
> This driver was tested with i.MX8MP EQOS (stmmac) on the MAC side and
> TI same PHY on other side.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/Kconfig     |  13 +++
>  drivers/net/phy/Makefile    |   1 +
>  drivers/net/phy/dp83tg720.c | 190 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/net/phy/dp83tg720.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 25cfc5ded1da..bab10c796f24 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -372,6 +372,19 @@ config DP83TC811_PHY
>  	help
>  	  Supports the DP83TC811 PHY.
>  
> +config DP83TG720_PHY
> +	tristate "Texas Instruments DP83TG720 Ethernet 1000Base-T1 PHY"
> +	help
> +	  The DP83TG720S-Q1 is an automotive Ethernet physical layer
> +	  transceiver compliant with IEEE 802.3bp and Open Alliance
> +	  standards. It supports key functions necessary for
> +	  transmitting and receiving data over both unshielded and
> +	  shielded single twisted-pair cables. This device offers
> +	  flexible xMII interface options, including support for both
> +	  RGMII and SGMII MAC interfaces. It's suitable for applications
> +	  requiring high-speed data transmission in automotive
> +	  networking environments.
> +
>  config DP83848_PHY
>  	tristate "Texas Instruments DP83848 PHY"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index f65e85c91fc1..defaef190962 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
>  obj-$(CONFIG_DP83867_PHY)	+= dp83867.o
>  obj-$(CONFIG_DP83869_PHY)	+= dp83869.o
>  obj-$(CONFIG_DP83TC811_PHY)	+= dp83tc811.o
> +obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
>  obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o

Maybe it should come after CONFIG_DP83TD510_PHY in a strict sort ? I
also wounder about the Kconfig, which should be sorted on the tristate
string.

>  obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
>  obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
> +		/* After HW reset we need to restore master/slave configuration.
> +		 */
> +		if (phydev->drv->config_aneg) {

This test is a bit strange. You know it exists, its this driver and
the function is there. Why not call it directly?

> +			ret = phydev->drv->config_aneg(phydev);
> +			if (ret)
> +				return ret;
> +		}


    Andrew

---
pw-bot: cr


Return-Path: <netdev+bounces-39605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304537C007C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5800E1C20925
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472652745D;
	Tue, 10 Oct 2023 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG+srMFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC12744D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE456C433C7;
	Tue, 10 Oct 2023 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696952274;
	bh=ccn0ErrI3BKGdflhAH1/B0pSw0wAE/4xTGwBpyvuDHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kG+srMFaKg3Sy4x78n9VSvAOJFgmN0tdjNSTW/JeDSUZzFPLVe3WowEvrDEfZ+JSv
	 DegXXrPaqpdMdctSGVLgHgU2EsUP9+VL0GbCMLEuA27pJl2InJCFBZnTdq+OCQE7m3
	 7dNritxb+Rz0HFEy0DvIWu+OWocGqGTSKH8pVS2BL1pO7s85X40JdKsKaLC4dHuuqE
	 6BOR5JmgtWj5yM8HibBVEJems72H2ueDl2y4Ph2mcebhKw/g6AcnAqKMIuF3K8zlKJ
	 JIbFWypFUL53+BB3R4sIBMKQoV1iih1afXuD6Zflj2N+sUaIM3Lvrq/FPs2WYICkrZ
	 M3cIxSC17Pn1Q==
Date: Tue, 10 Oct 2023 17:37:47 +0200
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback to
 use kernel_hwtstamp_config
Message-ID: <ZSVvywM8OLG12OhR@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-2-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-2-kory.maincent@bootlin.com>

...

> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 7ab080ff02df..416484ea6eb3 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -1022,24 +1022,21 @@ static bool nxp_c45_rxtstamp(struct mii_timestamper *mii_ts,
>  }
>  
>  static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
> -			    struct ifreq *ifreq)
> +			    struct kernel_hwtstamp_config *config,
> +			    struct netlink_ext_ack *extack)
>  {
>  	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
>  						mii_ts);
>  	struct phy_device *phydev = priv->phydev;
>  	const struct nxp_c45_phy_data *data;
> -	struct hwtstamp_config cfg;
>  
> -	if (copy_from_user(&cfg, ifreq->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> -
> -	if (cfg.tx_type < 0 || cfg.tx_type > HWTSTAMP_TX_ON)
> +	if (cfg->tx_type < 0 || cfg->tx_type > HWTSTAMP_TX_ON)

Hi Köry,

cfg is removed from this function by this patch, but is used here.

>  		return -ERANGE;
>  
>  	data = nxp_c45_get_data(phydev);
> -	priv->hwts_tx = cfg.tx_type;
> +	priv->hwts_tx = cfg->tx_type;
>  
> -	switch (cfg.rx_filter) {
> +	switch (cfg->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		priv->hwts_rx = 0;
>  		break;
> @@ -1047,7 +1044,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
>  	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>  		priv->hwts_rx = 1;
> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
>  		break;
>  	default:
>  		return -ERANGE;
> @@ -1074,7 +1071,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
>  		nxp_c45_clear_reg_field(phydev, &data->regmap->irq_egr_ts_en);
>  
>  nxp_c45_no_ptp_irq:
> -	return copy_to_user(ifreq->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>  }
>  

...


Return-Path: <netdev+bounces-54816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD68085B9
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505FEB21B05
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2C13FF3;
	Thu,  7 Dec 2023 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Na4rlRqc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241D7D54;
	Thu,  7 Dec 2023 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ktSp3moRHDdSXNk4zatlXahnF9on1Y5nS6HFXFMtcVg=; b=Na4rlRqcXs2nWrU581A6dAgX2x
	07SymGbQ/HN6yFJA/oNvRSNsAvs7N8uJ5RiS3r7O53wPI/bHYwG8AqY0F/wEAiy6lAd6ycLS49unL
	1tBIm0Q+BIvG3qGhATdNJfMyaXDEuBeVAtZHgmjYZRQ+K3YKF8s/Ph3yEc+Sxpdc5147mtAu6lk//
	gK3vmB51KulGre9ujF0l1WUioSof18HF2jtI6vDA7iiSQI8mx8F8bdjV7FjnEdMcQk8H5dQRqGOd5
	ZjUU6UtXVuZL6h0uDfANcu1VG5zbRnGvqUEvVzXg2y4o54AQYD/o4KZM6WXvGCNSdyZeVRUfTdISv
	BvpB6JDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60806)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rBBur-0000yU-18;
	Thu, 07 Dec 2023 10:47:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rBBus-0003fg-C7; Thu, 07 Dec 2023 10:47:38 +0000
Date: Thu, 7 Dec 2023 10:47:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 02/13] net: phy: at803x: move disable WOL to
 specific at8031 probe
Message-ID: <ZXGiysQvYXb9YJBT@shell.armlinux.org.uk>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
 <20231206235728.6985-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206235728.6985-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 07, 2023 at 12:57:17AM +0100, Christian Marangi wrote:
> Move the WOL disable call to specific at8031 probe to make at803x_probe
> more generic and drop extra check for PHY ID.
> 
> Keep the same previous behaviour by first calling at803x_probe and then
> disabling WOL.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/at803x.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index ef203b0807e5..85302d96d133 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -886,15 +886,6 @@ static int at803x_probe(struct phy_device *phydev)
>  			priv->is_fiber = true;
>  			break;
>  		}
> -
> -		/* Disable WoL in 1588 register which is enabled
> -		 * by default
> -		 */
> -		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> -				     AT803X_PHY_MMD3_WOL_CTRL,
> -				     AT803X_WOL_EN, 0);
> -		if (ret)
> -			return ret;
>  	}
>  
>  	return 0;
> @@ -1591,6 +1582,24 @@ static int at803x_cable_test_start(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int at8031_probe(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = at803x_probe(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable WoL in 1588 register which is enabled
> +	 * by default
> +	 */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +			     AT803X_PHY_MMD3_WOL_CTRL,
> +			     AT803X_WOL_EN, 0);
> +
> +	return ret;

	return phy_modify_mmd(...) ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


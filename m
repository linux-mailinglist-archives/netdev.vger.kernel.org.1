Return-Path: <netdev+bounces-57318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C839812DFE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4E1C21550
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE91F3E475;
	Thu, 14 Dec 2023 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sgeHfjBH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396971A3;
	Thu, 14 Dec 2023 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Popi+890fZ1lHbXbLEHSlXolpjJo3sDNBxoaukvvxzM=; b=sgeHfjBHWSa4Ai8ohwsLkr9bLX
	exGWirdgfG0oHmhTbF3/gok3kfORbPiMrVHzOqnkjt7M4Ix3XQTMImnSyqz4idtzHLbs+Ydb+yLyd
	Y4ECRzgfFoX7137PTSav157ABqjC3u3JaqNHd3GCIaPUaRN/LOYEOujiIYlpnUJlve4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDjT4-002ul8-GY; Thu, 14 Dec 2023 12:01:26 +0100
Date: Thu, 14 Dec 2023 12:01:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 03/14] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <c05e4756-0b33-4c97-ba88-1e14f459bbe3@lunn.ch>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
 <20231214094813.24690-4-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214094813.24690-4-quic_luoj@quicinc.com>

On Thu, Dec 14, 2023 at 05:48:02PM +0800, Luo Jie wrote:
> Add qca8084 PHY support, which is four-port PHY with maximum
> link capability 2.5G, the features of each port is almost same
> as QCA8081 and slave seed config is not needed.
> 
> Three kind of interface modes supported by qca8084.
> PHY_INTERFACE_MODE_10G_QXGMII, PHY_INTERFACE_MODE_2500BASEX and
> PHY_INTERFACE_MODE_SGMII.
> 
> The PCS(serdes) and clock are also needed to be configured to
> bringup qca8084 PHY, which will be added in the pcs driver.
> 
> The additional CDT configurations used for qca8084.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/phy/at803x.c | 49 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 37fb033e1c29..8dfdf2ff56a5 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -176,6 +176,7 @@
>  #define AT8030_PHY_ID_MASK			0xffffffef
>  
>  #define QCA8081_PHY_ID				0x004dd101
> +#define QCA8084_PHY_ID				0x004dd180
>  
>  #define QCA8327_A_PHY_ID			0x004dd033
>  #define QCA8327_B_PHY_ID			0x004dd034
> @@ -1760,6 +1761,9 @@ static bool qca808x_is_prefer_master(struct phy_device *phydev)
>  
>  static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
>  {
> +	if (phydev_id_compare(phydev, QCA8084_PHY_ID))
> +		return false;
> +
>  	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
>  }


It looks like these patches need rebasing on net-next/main. It appears
you are missing Christians patches.


    Andrew

---
pw-bot: cr


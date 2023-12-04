Return-Path: <netdev+bounces-53438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A2E802FBD
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4951F211A5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447EF1EB4D;
	Mon,  4 Dec 2023 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VBigK6DX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D8FD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yd14O6+i6BzJWosvpAqQhFNP5pgHdikJuIrKAQzKS2Y=; b=VBigK6DXN/MAHDa3xLfu93jcTo
	GH6UqsZ2/JYqUOOpvltCHSZasbtmGEIH+XmkOrFiSpIHZmGnWhnyu+g7ucG/phIOIlMYHFQCuAziP
	qMnbPeASx1EKuEs2jn0Xr4LcP9VZWSqj9kuCXsn4NE/bquxgtAkf0Q1xAVYecNFVtUgh9Z6otC1GL
	c/SLB++n5ueI6tnZ/uuIx00zNnOUuTsSzsudHDdolhRO9D05HEtjf/2Cf3MuEFvm1G+XRz/5HqQkL
	yQrdD0z/28o7mhmrb6B94clqtjPjlUyO51vsa7ZvbgdgNGQrqqZCfdmi0aLlqPdUTzL8P+5FS4X5T
	5zb/zOZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54472)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rA5uW-0005OT-14;
	Mon, 04 Dec 2023 10:10:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rA5uV-0000bn-Md; Mon, 04 Dec 2023 10:10:43 +0000
Date: Mon, 4 Dec 2023 10:10:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/7] net: ngbe: implement phylink to handle
 PHY device
Message-ID: <ZW2loxTO6oKNYLew@shell.armlinux.org.uk>
References: <20231204091905.1186255-1-jiawenwu@trustnetic.com>
 <20231204091905.1186255-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204091905.1186255-2-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 04, 2023 at 05:18:59PM +0800, Jiawen Wu wrote:
> Add phylink support for Wangxun 1Gb Ethernet controller.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  21 ++-
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 127 +++++++++++-------
>  3 files changed, 88 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 165e82de772e..4088637440c6 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -940,6 +940,7 @@ struct wx {
>  	int speed;
>  	int duplex;
>  	struct phy_device *phydev;

If you also embed struct phylink_config() in struct wx, then you can get
to it in the MAC operations using an inline function in wx_type.h:

static inline struct wx *phylink_to_wx(struct phylink_config *config)
{
	return container_of(config, struct wx, phylink_config);
}

which will be more efficient than doing the
netdev_priv(to_net_dev(config->dev)) dance. It's also what other network
drivers that use phylink do, so it brings consistency of implementation.

...
> -static void ngbe_handle_link_change(struct net_device *dev)
> +static void ngbe_phy_fixup(struct wx *wx)
>  {
> -	struct wx *wx = netdev_priv(dev);
> -	struct phy_device *phydev;
> -	u32 lan_speed, reg;
> +	struct phy_device *phydev = wx->phydev;
> +	struct ethtool_eee eee;
>  
> -	phydev = wx->phydev;
> -	if (!(wx->link != phydev->link ||
> -	      wx->speed != phydev->speed ||
> -	      wx->duplex != phydev->duplex))
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);

Phylink restricts the advertisement according to the capabilities
provided, do you should not need to do this. Please remove.

> +
> +	phydev->mac_managed_pm = true;

Please don't bypass phylink's management of this, instead set the
"mac_managed_pm" boolean in struct phylink_config.

...
> +static int ngbe_phylink_init(struct wx *wx)
>  {
> -	int ret;
> +	struct phylink_config *config;
> +	phy_interface_t phy_mode;
> +	struct phylink *phylink;
>  
> -	ret = phy_connect_direct(wx->netdev,
> -				 wx->phydev,
> -				 ngbe_handle_link_change,
> -				 PHY_INTERFACE_MODE_RGMII_ID);
> -	if (ret) {
> -		wx_err(wx, "PHY connect failed.\n");
> -		return ret;
> -	}
> +	config = devm_kzalloc(&wx->pdev->dev, sizeof(*config), GFP_KERNEL);
> +	if (!config)
> +		return -ENOMEM;
>  
> -	return 0;
> -}
> +	config->dev = &wx->netdev->dev;
> +	config->type = PHYLINK_NETDEV;
> +	config->mac_capabilities = MAC_1000FD | MAC_100FD |
> +				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>  
> -static void ngbe_phy_fixup(struct wx *wx)
> -{
> -	struct phy_device *phydev = wx->phydev;
> -	struct ethtool_eee eee;
> +	phy_mode = PHY_INTERFACE_MODE_RGMII_ID;
> +	__set_bit(PHY_INTERFACE_MODE_RGMII_ID, config->supported_interfaces);

As mentioned above, also set config->mac_managed_pm.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


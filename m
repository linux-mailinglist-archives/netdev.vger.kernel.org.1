Return-Path: <netdev+bounces-114200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D34941528
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956A81C21250
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBE1A2C16;
	Tue, 30 Jul 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A+mrM7MV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE751A2553;
	Tue, 30 Jul 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352278; cv=none; b=ExbvHKgV16ploJYZh0ZpEdtnhVep4U1UY/XKGFpHywH0seQ9PXAeX34sq/QPjUKtQzXvudPhXjg9MQUNr4Ks3HpxCvUx0kz03LOq1bpkuZw6fsOeC6Ajgg9qUcMcFouNlxxaboeu8aEkuEge+AtR0AhRteNs0lXg1miP2VlA0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352278; c=relaxed/simple;
	bh=7drJBd4vPAXeOYN4Bu2gVS5O0LnnsSk7ZDISvuwDoQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJjlWWYZPTO2o0Cauc0gVqmezB2NulXfjAq2MLQKqhSebhfI71bhQw9uK/9S68y2HiX7tBNprp1eOKjW3Q42uIqbXKbU7b3jPP7x0jUvLsvBndz9RsmVMhEbt4bnXPvQ/C1z9UfIIts2A89duG8tesU39URys0wkLJy3VLxkqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A+mrM7MV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=443IySO6h1genY6Yw2BSH0jKpFakov/7cWHx1qwPkTk=; b=A+mrM7MVeYF57oDlHFJE4uIsfn
	A2CZV/hJVhLXT/t92lJ6UwfQujQswwTEcS0ztAJhloKPx+wmt41URcHLbcsM3Bsw1WnC9WaznP1pI
	JB8JiYTXObUXmVBwxDfnmK7rXalmzbNlDnrakVh+U79h4M1vXQQ4rbfPLY1cBBS6E9/ksmjziCjtw
	Y0SJbkSZkl8T37XBt8uektg6oBh/1ILtoyn3C155fzwCzVoz3ch2Ygab8/xlUmf7xcCDfsXjGWLTX
	rpV1wpz3sM1REbebZCQI4AP96Egi5TVaQ70iG17ECXvawehMm3yU4eW9A1hvWJBSCYyqXrtZpMtj4
	8Bq6EmZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYoVH-0007CP-0s;
	Tue, 30 Jul 2024 16:11:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYoVL-0005M3-9k; Tue, 30 Jul 2024 16:11:11 +0100
Date: Tue, 30 Jul 2024 16:11:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	Bryan.Whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 4/4] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <ZqkCj9gENW5ILWED@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-5-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730140619.80650-5-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 07:36:19PM +0530, Raju Lakkaraju wrote:
> diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> index 3a63ec091413..a649ea7442a4 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> @@ -1058,61 +1058,48 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
>  				   struct ethtool_keee *eee)
>  {
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
> -	struct phy_device *phydev = netdev->phydev;
> -	u32 buf;
> -	int ret;
> -
> -	if (!phydev)
> -		return -EIO;
> -	if (!phydev->drv) {
> -		netif_err(adapter, drv, adapter->netdev,
> -			  "Missing PHY Driver\n");
> -		return -EIO;
> -	}
>  
> -	ret = phy_ethtool_get_eee(phydev, eee);
> -	if (ret < 0)
> -		return ret;
> -
> -	buf = lan743x_csr_read(adapter, MAC_CR);
> -	if (buf & MAC_CR_EEE_EN_) {
> -		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
> -		buf = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
> -		eee->tx_lpi_timer = buf;
> -	} else {
> -		eee->tx_lpi_timer = 0;
> -	}
> +	eee->tx_lpi_timer = lan743x_csr_read(adapter,
> +					     MAC_EEE_TX_LPI_REQ_DLY_CNT);
> +	eee->eee_enabled = adapter->eee_enabled;
> +	eee->eee_active = adapter->eee_active;
> +	eee->tx_lpi_enabled = adapter->tx_lpi_enabled;

You really need to start paying attention to the commits other people
make as a result of development to other parts of the kernel.

First, see:

commit ef460a8986fa0dae1cdcb158a06127f7af27c92d
Author: Andrew Lunn <andrew@lunn.ch>
Date:   Sat Apr 6 15:16:00 2024 -0500

    net: lan743x: Fixup EEE

and note that the assignment of eee->eee_enabled, eee->eee_active, and
eee->tx_lpi_enabled were all removed.

Next...

>  
> -	return 0;
> +	return phylink_ethtool_get_eee(adapter->phylink, eee);

phylink_ethtool_get_eee() will call phy_ethtool_get_eee(), which
in turn calls genphy_c45_ethtool_get_eee() and eeecfg_to_eee().

genphy_c45_ethtool_get_eee() will do this:

        data->eee_enabled = is_enabled;
        data->eee_active = ret;

thus overwriting your assignment to eee->eee_enabled and
eee->eee_active.

eeecfg_to_eee() will overwrite eee->tx_lpi_enabled and
eee->eee_enabled.

Thus, writing to these fields and then calling
phylink_ethtool_get_eee() results in these fields being overwritten.

>  static int lan743x_ethtool_set_eee(struct net_device *netdev,
>  				   struct ethtool_keee *eee)
>  {
> -	struct lan743x_adapter *adapter;
> -	struct phy_device *phydev;
> -	u32 buf = 0;
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
>  
> -	if (!netdev)
> -		return -EINVAL;
> -	adapter = netdev_priv(netdev);
> -	if (!adapter)
> -		return -EINVAL;
> -	phydev = netdev->phydev;
> -	if (!phydev)
> -		return -EIO;
> -	if (!phydev->drv) {
> -		netif_err(adapter, drv, adapter->netdev,
> -			  "Missing PHY Driver\n");
> -		return -EIO;
> -	}
> +	if (eee->tx_lpi_enabled)
> +		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
> +				  eee->tx_lpi_timer);
> +	else
> +		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, 0);
>  
> -	if (eee->eee_enabled) {
> -		buf = (u32)eee->tx_lpi_timer;
> -		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
> -	}
> +	adapter->eee_enabled = eee->eee_enabled;
> +	adapter->tx_lpi_enabled = eee->tx_lpi_enabled;

Given that phylib stores these and overwrites your copies in the get_eee
method above, do you need to store these?

> @@ -3013,7 +3025,12 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
>  					  unsigned int link_an_mode,
>  					  phy_interface_t interface)
>  {
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +
>  	netif_tx_stop_all_queues(to_net_dev(config->dev));
> +	adapter->eee_active = false;

phylib tracks this for you.

> +	lan743x_set_eee(adapter, false);
>  }
>  
>  static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> @@ -3055,6 +3072,14 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
>  					  cap & FLOW_CTRL_TX,
>  					  cap & FLOW_CTRL_RX);
>  
> +	if (phydev && adapter->eee_enabled) {
> +		bool enable;
> +
> +		adapter->eee_active = phy_init_eee(phydev, false) >= 0;
> +		enable = adapter->eee_active && adapter->tx_lpi_enabled;

No need. Your enable should be conditional on phydev->enable_tx_lpi
here. See Andrew's commit and understand his changes, rather than
just ignoring Andrew's work and continuing with your old pattern of
EEE support. Things have moved forward.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


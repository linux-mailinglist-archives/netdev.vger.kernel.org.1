Return-Path: <netdev+bounces-132547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61570992189
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937331C209F7
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE5518A6D9;
	Sun,  6 Oct 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fwj0nePp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041743AB3;
	Sun,  6 Oct 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728248721; cv=none; b=Gkv6Q28DJOH1UwUoHDD23F42f1hjhP7k6emOCvEXvViemAtAWqb9FK4DMKCOMJLAfbj6pvBtf9whHAsmFLXXlvJvXvT2l7fEzE+AxMW3AJ+XV6wiXsU0ZqumaFDjNqpeVXngIHXKJZH5eOUR0EsQhjgdsRoZ+YpUdoArGzYjV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728248721; c=relaxed/simple;
	bh=1b4rtbL7OW5DpMpVeQL5yzdrfaWV0z6syuOt+xVm06w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx9k286x1vp1FzrMdfCv/7FSlN+cOybSTk2peiGZ/4kHhkUHne7inLAPh5Y6VlkUEDBZbtwpD7mIIc3YO0giy8aiheiH0xek3QtYrdSsBdMT+S6p+Xq/PDfJAwzRGWAEPiNy3qpxqHq05sOpI5d7opJNHXtDWymHVNOyZjdIG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fwj0nePp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1JAkRDqm08ZTr5id+HbGcpelsGCywNBvISK0F54yzvs=; b=Fwj0nePpEB4mfpoplLqmEnA+r/
	DqfnJaBvNu+UKzsu8F6nlfoH0CXY9NRFSQBdm+Bs8Y5oKFvzwgAx5DYaesyCyTh10eXC/IYvF94dx
	tS8TfC6lDHo3YUzrV4Wh17ig8IqyKgMAXNWBT33h6IIhgF30C4vZFKsTM4iNJteC2Wwk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYR5-009CtP-LB; Sun, 06 Oct 2024 23:05:03 +0200
Date: Sun, 6 Oct 2024 23:05:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liel Harel <liel.harel@gmail.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] smsc95xx: Add implementation for set_pauseparam for
 enabling to pause RX path.
Message-ID: <659a571e-2760-4028-ba08-0040aeea4aff@lunn.ch>
References: <20241004112000.421681-1-liel.harel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004112000.421681-1-liel.harel@gmail.com>

On Fri, Oct 04, 2024 at 02:20:00PM +0300, Liel Harel wrote:
> Enable userspace applications to pause RX path by IOCTL.

The legacy API probably does still work, but netlink is used now a
days for pause.

>  
>  /* Loop until the read is completed with timeout
> - * called with phy_mutex held */
> + * called with phy_mutex held
> + */

Please don't mix checkpatch style changes with functional changes in
one patch. Please break this up into a patchset.

>  static int __must_check smsc95xx_phy_wait_not_busy(struct usbnet *dev)
>  {
>  	unsigned long start_time = jiffies;
> @@ -470,7 +471,8 @@ static int __must_check smsc95xx_write_reg_async(struct usbnet *dev, u16 index,
>  
>  /* returns hash bit number for given MAC address
>   * example:
> - * 01 00 5E 00 00 01 -> returns bit number 31 */
> + * 01 00 5E 00 00 01 -> returns bit number 31
> + */
>  static unsigned int smsc95xx_hash(char addr[ETH_ALEN])
>  {
>  	return (ether_crc(ETH_ALEN, addr) >> 26) & 0x3f;
> @@ -772,6 +774,45 @@ static int smsc95xx_ethtool_get_sset_count(struct net_device *ndev, int sset)
>  	}
>  }
>  
> +/* Starts the Receive path */
> +static int smsc95xx_start_rx_path(struct usbnet *dev)
> +{
> +	struct smsc95xx_priv *pdata = dev->driver_priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
> +	pdata->mac_cr |= MAC_CR_RXEN_;
> +	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
> +
> +	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
> +}
> +
> +/* Stops the Receive path */
> +static int smsc95xx_stop_rx_path(struct usbnet *dev)
> +{
> +	struct smsc95xx_priv *pdata = dev->driver_priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
> +	pdata->mac_cr &= ~MAC_CR_RXEN_;
> +	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
> +
> +	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
> +}
> +
> +static int smsc95xx_ethtool_set_pauseparam(struct net_device *netdev,
> +									struct ethtool_pauseparam *pause)

indentation is wrong here.

> +{
> +	struct usbnet *dev = netdev_priv(netdev);
> +
> +	if (!pause->tx_pause || !pause->autoneg)
> +		return -EINVAL;
> +
> +	if (pause->rx_pause)
> +		return smsc95xx_start_rx_path(dev);
> +	return smsc95xx_stop_rx_path(dev);

This does not make much sense to me. What does pause mean to you?

> +}
> +
>  static const struct ethtool_ops smsc95xx_ethtool_ops = {
>  	.get_link	= smsc95xx_get_link,
>  	.nway_reset	= phy_ethtool_nway_reset,
> @@ -791,6 +832,7 @@ static const struct ethtool_ops smsc95xx_ethtool_ops = {
>  	.self_test	= net_selftest,
>  	.get_strings	= smsc95xx_ethtool_get_strings,
>  	.get_sset_count	= smsc95xx_ethtool_get_sset_count,
> +	.set_pauseparam = smsc95xx_ethtool_set_pauseparam,
>  };
>  
>  static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
> @@ -863,26 +905,13 @@ static int smsc95xx_start_tx_path(struct usbnet *dev)
>  	return smsc95xx_write_reg(dev, TX_CFG, TX_CFG_ON_);
>  }
>  
> -/* Starts the Receive path */
> -static int smsc95xx_start_rx_path(struct usbnet *dev)
> -{
> -	struct smsc95xx_priv *pdata = dev->driver_priv;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&pdata->mac_cr_lock, flags);
> -	pdata->mac_cr |= MAC_CR_RXEN_;
> -	spin_unlock_irqrestore(&pdata->mac_cr_lock, flags);
> -
> -	return smsc95xx_write_reg(dev, MAC_CR, pdata->mac_cr);
> -}

If you need to move a function earlier in the code, please do that as
a separate patch, making it clear in the commit message that all it is
doing is moving code.

You want lots of small patches which are obviously correct.

> @@ -1076,7 +1105,7 @@ static const struct net_device_ops smsc95xx_netdev_ops = {
>  	.ndo_tx_timeout		= usbnet_tx_timeout,
>  	.ndo_change_mtu		= usbnet_change_mtu,
>  	.ndo_get_stats64	= dev_get_tstats64,
> -	.ndo_set_mac_address 	= eth_mac_addr,
> +	.ndo_set_mac_address = eth_mac_addr,

This hunk looks wrong.

	Andrew


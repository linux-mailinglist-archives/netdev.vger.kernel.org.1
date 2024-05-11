Return-Path: <netdev+bounces-95739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9808C3384
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2417D1C20D75
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A161CD37;
	Sat, 11 May 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DhPwpPvY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98401366;
	Sat, 11 May 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715456077; cv=none; b=qbC1Fgw4iEFodqJ7uy+OvR0MFUayTQA1OBQw+2rt0NxMuIQNZzcV/sYGE9knPdBTfaDS2+F5Gammdz49GY1O/8t8FYtyBR2O4GxEZmI35PxOoy8Q8vbJzyHGkNiT01aNAH84pUJPkjz1tIPYbdaj/kyyMON8DHpPUdFkzyZ7XVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715456077; c=relaxed/simple;
	bh=654Bu+ZWTA8dRAlTroxF0ate7xSXj5crY54eC/GD0PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbUHp3PML2/Z3jVizAIku5LYIRa2S1gtrePcNg6ZG/gVyLaES9OyshLIQuT817A9zkWGoj5+6lzWGHOhl5NHuS4WvICVWqbFrS6xQb9qV4dlyunQudpGch/Rrm8IVfYQM7xT4e2h343oZwQOKYEcSYNzMgZN8AZQBMQQ1Yw9Is0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DhPwpPvY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w0vU8RMKEb5MAwtOYOzKjXM4x8mAAk3i9b0LbBNQJ0c=; b=DhPwpPvYtTPMPM5y2NYb+kLshS
	FsmAdMpbWJOJQCl8LDe713iU8PEoyMf61+gp3VRpsxUTzKCPJ5gSOFPZ1zdFn1qr2r7K9GJvP0Z0c
	1/c7gpeKs2tpmCwn/bGuPr8rqN6imEtd6SLS6wiPGDexUq4BXuKxKlbdFrrjtbyUOoYBkUIDpfsIe
	sKCt42Y/G1yMRmI5kx2H4RnZUgR7eUDj/bWYFLRdUhZgCIwxRiClnrY07cPgEeHRSX8TvGdO5/WOg
	vMPQZ8itsE/BUtHV5MrTCj6/jheHx8Z3dauR8+rgbWUCXrFXc+DG+9XX/VyiOkhilKdbik/2p7eIl
	bYXTYKug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57162)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s5sUD-0000B6-0D;
	Sat, 11 May 2024 20:34:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s5sUA-0004VK-W4; Sat, 11 May 2024 20:34:23 +0100
Date: Sat, 11 May 2024 20:34:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <Zj/IPpub11OL3jBo@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Thanks for the patch,. but there are things that need some improvement.

On Fri, May 10, 2024 at 06:59:24PM -0700, Jitendra Vegiraju wrote:
> +static void dwxgmac_brcm_dma_init_tx_chan(struct stmmac_priv *priv,
> +					  void __iomem *ioaddr,
> +					  struct stmmac_dma_cfg *dma_cfg,
> +					  dma_addr_t phy, u32 chan)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value &= ~XGMAC_TxPBL;
> +	value &= ~GENMASK(6, 4);
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +
> +	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> +	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));

Please use "dma_addr" not "phy" here. "phy" could mean ethernet phy.
I personally dislike "physical address" for DMA stuff because if
there's an IOMMU or other translation layer present, what you have
here is *not* a physical address.

> +static void dwxgmac_brcm_dma_init_rx_chan(struct stmmac_priv *priv,
> +					  void __iomem *ioaddr,
> +					  struct stmmac_dma_cfg *dma_cfg,
> +					  dma_addr_t phy, u32 chan)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value &= ~XGMAC_RxPBL;
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +
> +	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> +	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));

Ditto.

...

> +static void dwxgmac_brcm_fix_speed(void *priv, unsigned int speed,
> +				   unsigned int mode)
> +{
> +}

If this is empty, do you really need it? The method is optional.

...

> +static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
> +				  const struct pci_device_id *id)
> +{
...
> +	/* This device interface is directly attached to the switch chip on
> +	 *  the SoC. Since no MDIO is present, register fixed_phy.
> +	 */
> +	brcm_priv->phy_dev =
> +		 fixed_phy_register(PHY_POLL,
> +				    &dwxgmac_brcm_fixed_phy_status, NULL);
> +	if (IS_ERR(brcm_priv->phy_dev)) {
> +		dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __func__);
> +		return -ENODEV;
> +	}
> +	phy_attached_info(brcm_priv->phy_dev);

As pointed out in the other sub-thread, you don't need this. If you need
a fixed-link and you don't have a firmware description of it, you can
provide a swnode based description through plat->port_node that will be
passed to phylink. Through that, you can tell phylink to create a
fixed link.

> +	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
> +	if (ret)
> +		goto err_disable_msi;
> +
> +	/* The stmmac core driver doesn't have the infrastructure to
> +	 * support fixed-phy mdio bus for non-platform bus drivers.
> +	 * Until a better solution is implemented, initialize the
> +	 * following entries after priv structure is populated.
> +	 */
> +	ndev = dev_get_drvdata(&pdev->dev);
> +	priv = netdev_priv(ndev);
> +	priv->mii = mdio_find_bus("fixed-0");
> +
> +	ndev->hw_features &= ~NETIF_F_HW_VLAN_CTAG_RX;
> +	priv->hw->hw_vlan_en = false;

Basically... no. Do not do any setup after stmmac_dvr_probe(), because
the network device has already been registered and published to
userspace, and userspace may have already opened the network device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


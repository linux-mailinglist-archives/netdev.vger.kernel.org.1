Return-Path: <netdev+bounces-210714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACAB14719
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 06:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BAA7AE374
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 04:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E8A22F386;
	Tue, 29 Jul 2025 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eCKLlBSB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E49126F0A;
	Tue, 29 Jul 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762665; cv=none; b=n4zno0dN/MZxuIGd19EFsUe0bqr2myfY9HzArbJtf+L6i+tGgeVFQExF7BCvxKB15urBZDnSVSRxiO6jmOAojAYCAI1gf4ZYFhmBTZFuSjEBR7wvjbHsjLflxZb0m1zvGu7fpwG3k8HI30eAJZBM46ed98zh6mJeQWEVm/DeQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762665; c=relaxed/simple;
	bh=7tDgtFJR8cyaykCgjJwGJxSs9d0nX1Uds0jJrgq1/tg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXV3vrZKNotsjzm6gdwlMQicHg9SzWr08nv3ifVTXqgsiHi0lwU+MoVvgCAjdZHIgBjnyyqUHgbgNwigUD4NnrJgCvpC6ssDZRUpamP+3y7hPl+ltVe7Rs6RejlHNl5qCcDYTcteqCmw+ArsKBtd7pepHLjG0/07fiT0H8H7AE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eCKLlBSB; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SNUboE016510;
	Mon, 28 Jul 2025 21:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Gvi7s92rUntYoojpXac9T2xE/
	ZfXd4PWAkMHrgNru74=; b=eCKLlBSBdNvrwbdD4O3LJ3mCzkFJFS+6lYNVNI2n7
	MYFTeEhAd93ZbgDMmXej5X5wsnjQGb1zH7f8nvx/TUJHmfN44/yHNuic0vT026kx
	x5+BO1u0FgZKQeMIZgke3rMcr/0VIpNpcSUP47WDcec2Av4Tu55HkmS+mPCFapOc
	YEWIYrbqrKLvQsEKN0VriNSEKHkJa6ACDeNJ1Lgj3dIkw237mtidvA5lt5i8CtQv
	Vtnr8dUn/xLAfB2IWA+3H+4DFIUE2mIFZq2+2bx97jL6yDXF0by5qDcDvNnLYAUP
	aOYFkyqG98M+G29hG8AgujzsKfPYNRR3Jkj0eSkR+7eAg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 486jxk0es1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 21:17:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Jul 2025 21:17:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Jul 2025 21:17:00 -0700
Received: from opensource (unknown [10.29.20.14])
	by maili.marvell.com (Postfix) with SMTP id C8E983F707C;
	Mon, 28 Jul 2025 21:16:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 04:16:53 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Sean Anderson <sean.anderson@linux.dev>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next v3 7/7] net: axienet: Split into MAC and MDIO
 drivers
Message-ID: <aIhLNUMENeh_Ayq2@opensource>
References: <20250728221823.11968-1-sean.anderson@linux.dev>
 <20250728221823.11968-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250728221823.11968-8-sean.anderson@linux.dev>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAyOSBTYWx0ZWRfXwJS0De+2k5oR OavDbQZ69pXmUhOvOk+H2nhm8PK1HliJV5WNxBojr3splPK5N/IlToQkfQ5hBj/XTZXyw70rXVh 3R2YJri5waw+hOHxXKGf41I3zgSlEBAfGn9uG/2qqFnm5EhVuxaBFZf2f+mplTCkdQI65Z/M62Y
 Mutoz3R1srugICIfrJkmJ4CjWMbf9sH9oousZ8ThQW5P5nmCHyLSjmV3qjQPNCZYd5mr/4fiM6a jWjnFhrnfvA1slTUDrCoIQzXrDzF9I+8KVx2keBqlcabLrx9bbZgDnLYqNBey425zS1Y+9tSOv0 AoVL/K9MYJ+PUR9xp8b5IrWnvZi7jky8QobRd3EBEGWzGdJw4+Iw1Tw2/Gd25qaZKMJ8K/+OVHX
 LLV/ThMrQL8llJJe8tkOF4LVy2lpaqy0Cob0imWaP7dVPO68r6XW/9rKAqdvxjQyqfV0Uzf/
X-Proofpoint-GUID: 8EZwDNfMYH-bFI54Dd0liSLBQgKX62w8
X-Proofpoint-ORIG-GUID: 8EZwDNfMYH-bFI54Dd0liSLBQgKX62w8
X-Authority-Analysis: v=2.4 cv=dduA3WXe c=1 sm=1 tr=0 ts=68884b3c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=IUMJal29XTB9L78AV0wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01

On 2025-07-28 at 22:18:23, Sean Anderson (sean.anderson@linux.dev) wrote:
> Returning EPROBE_DEFER after probing a bus may result in an infinite
> probe loop if the EPROBE_DEFER error is never resolved. There are two
> mutually-exclusive scenarios (that can both occur in the same system).
> First, the PCS can be attached to our own MDIO bus:
> 
> MAC
>  |
>  +->MDIO
>      |
>      +->PCS
>      +->PHY (etc)
> 
> In this scenario, we have to probe the MDIO bus before we can look up
> the PCS, since otherwise the PCS will always be missing when we look for
> it. But if we do things in the right order then we can't get
> EPROBE_DEFER, and so there's no risk of a probe loop.
> 
> Second, the PCS can be attached to some other MDIO bus:
> 
> MAC              MDIO
>  |                 |
>  +->MDIO           +->PCS
>       |
>       +->PHY (etc)
> 
> In this scenario, the MDIO bus might not be present for whatever reason
> (module not loaded, error in probe, etc.) and we have the possibility of
> an EPROBE_DEFER error. If that happens, we will end up in a probe loop
> because the PHY on our own MDIO bus incremented deferred_trigger_count
> when it probed successfully:
> 
> deferred_probe_work_func()
>   driver_probe_device(MAC)
>     axienet_probe(MAC)
>       mdiobus_register(MDIO)
>         device_add(PHY)
>           (probe successful)
>           driver_bound(PHY)
>             driver_deferred_probe_trigger()
>       return -EPROBE_DEFER
>     driver_deferred_probe_add(MAC)
>     // deferred_trigger_count changed, so...
>     driver_deferred_probe_trigger()
> 
> As I see it, this problem could be solved in the following four ways:
> 
> - Modify the driver core to detect and mitigate this sort of scenario
>   (NACKed by Greg).
> - Split the driver into MAC and MDIO parts (this commit).
> - Modify phylink to allow connecting a PCS after phylink_create but
>   before phylink_start. This is tricky because the PCS can affect the
>   supported phy interfaces, and phy interfaces are validated in
>   phylink_create.
> - Defer phylink_create to ndo_open. This means that all the
>   netdev/ethtool ops that use phylink now need to check ip the netdev is
>   open and fall back to some other implementation. I don't think we can
>   just return -EINVAL or whatever because using ethtool on a down device
>   has historically worked. I am wary of breaking userspace because some
>   tool assumes it can get_ksettings while the netdev is down.
> 
> Aside from the first option, the second one (this commit) has the best
> UX. With the latter two, you could have a netdev that never comes up and
> the user may not have very good insight as to why. For example, it may
> not be obvious that the user should try to bring the netdev up again
> after the PCS is probed. By waiting to create the netdev until after we
> successfully probe the PCS we show up in devices_deferred and the netdev
> can be brought up as usual.
> 
> Per the second bullet point above, split the MAC and MDIO functionality
> into separate auxiliary devices. If the MAC fails with EPROBE_DEFER,
> then the MDIO bus will remain bound, preventing a probe loop.
> 
> Fixes: 1a02556086fc ("net: axienet: Properly handle PCS/PMA PHY for 1000BaseX mode")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v3:
> - Rework to use a separate axienet_common structure, as netdevs cannot
>   be reused once registered.
> - Use ida_alloc for aux id
> 
> Changes in v2:
> - Fix building as a module
> - Expand commit message with much more info on the problem and possible
>   solutions
> 
>  drivers/net/ethernet/xilinx/Kconfig           |   1 +
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  10 +-
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 168 ++++++++++++++----
>  .../net/ethernet/xilinx/xilinx_axienet_mdio.c |  59 +++---
>  4 files changed, 169 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
> index 7502214cc7d5..3b940d2d3115 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -27,6 +27,7 @@ config XILINX_AXI_EMAC
>  	tristate "Xilinx 10/100/1000 AXI Ethernet support"
>  	depends on HAS_IOMEM
>  	depends on XILINX_DMA
> +	select AUXILIARY_BUS
>  	select PHYLINK
>  	select DIMLIB
>  	help
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index d7215dd92ce9..69665c7f264a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -470,6 +470,7 @@ struct skbuf_dma_descriptor {
>  /**
>   * struct axienet_common - axienet private common data
>   * @pdev: Pointer to common platform device structure
> + * @mac: Pointer to MAC (netdev parent) device structure
>   * @axi_clk: AXI4-Lite bus clock
>   * @reset_lock: Lock held while resetting the device to prevent register access
>   * @mii_bus: Pointer to MII bus structure
> @@ -479,11 +480,12 @@ struct skbuf_dma_descriptor {
>   */
>  struct axienet_common {
>  	struct platform_device *pdev;
> +	struct auxiliary_device mac;
>  
>  	struct clk *axi_clk;
>  
>  	struct mutex reset_lock;
> -	struct mii_bus *mii_bus;
> +	struct auxiliary_device mii_bus;
>  	u8 mii_clk_div;
>  
>  	void __iomem *regs;
> @@ -493,7 +495,7 @@ struct axienet_common {
>  /**
>   * struct axienet_local - axienet private per device data
>   * @ndev:	Pointer for net_device to which it will be attached.
> - * @dev:	Pointer to device structure
> + * @dev:	Pointer to parent device structure for DMA access
>   * @phylink:	Pointer to phylink instance
>   * @phylink_config: phylink configuration settings
>   * @pcs_phy:	Reference to PCS/PMA PHY if used
> @@ -752,8 +754,6 @@ static inline void axienet_dma_out_addr(struct axienet_local *lp, off_t reg,
>  
>  #endif /* CONFIG_64BIT */
>  
> -/* Function prototypes visible in xilinx_axienet_mdio.c for other files */
> -int axienet_mdio_setup(struct axienet_common *lp);
> -void axienet_mdio_teardown(struct axienet_common *lp);
> +extern struct auxiliary_driver xilinx_axienet_mdio;
>  
>  #endif /* XILINX_AXI_ENET_H */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index f235ef15187c..23e5c8090d45 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -22,6 +22,7 @@
>   *  - Add support for extended VLAN support.
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/etherdevice.h>
> @@ -1907,8 +1908,11 @@ static const struct net_device_ops axienet_netdev_dmaengine_ops = {
>  static void axienet_ethtools_get_drvinfo(struct net_device *ndev,
>  					 struct ethtool_drvinfo *ed)
>  {
> +	struct axienet_local *lp = netdev_priv(ndev);
> +
>  	strscpy(ed->driver, DRIVER_NAME, sizeof(ed->driver));
>  	strscpy(ed->version, DRIVER_VERSION, sizeof(ed->version));
> +	strscpy(ed->bus_info, dev_name(lp->dev), sizeof(ed->bus_info));
>  }
>  
>  /**
> @@ -2749,10 +2753,12 @@ static void axienet_disable_misc(void *clocks)
>  	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks);
>  }
>  
> -static int axienet_mac_probe(struct axienet_common *cp)
> +static int axienet_mac_probe(struct auxiliary_device *auxdev,
> +			     const struct auxiliary_device_id *id)
>  {
> +	struct axienet_common *cp = auxdev->dev.platform_data;
>  	struct platform_device *pdev = cp->pdev;
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &auxdev->dev;
>  	struct axienet_local *lp;
>  	struct net_device *ndev;
>  	struct device_node *np;
> @@ -2765,7 +2771,7 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  	if (!ndev)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, ndev);
> +	auxiliary_set_drvdata(auxdev, ndev);
>  
>  	SET_NETDEV_DEV(ndev, dev);
>  	ndev->features = NETIF_F_SG;
> @@ -2777,7 +2783,7 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  
>  	lp = netdev_priv(ndev);
>  	lp->ndev = ndev;
> -	lp->dev = dev;
> +	lp->dev = &pdev->dev;
>  	lp->cp = cp;
>  	lp->regs = cp->regs;
>  	lp->options = XAE_OPTION_DEFAULTS;
> @@ -2909,8 +2915,11 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  			of_node_put(np);
>  			lp->eth_irq = platform_get_irq_optional(pdev, 0);
>  		} else {
> +			struct resource *dmares;
> +
>  			/* Check for these resources directly on the Ethernet node. */
> -			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
> +			dmares = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +			lp->dma_regs = devm_ioremap_resource(dev, dmares);
>  			lp->rx_irq = platform_get_irq(pdev, 1);
>  			lp->tx_irq = platform_get_irq(pdev, 0);
>  			lp->eth_irq = platform_get_irq_optional(pdev, 2);
> @@ -2925,7 +2934,9 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  		}
>  
>  		/* Reset core now that clocks are enabled, prior to accessing MDIO */
> +		axienet_lock_mii(lp);
>  		ret = __axienet_device_reset(lp);
> +		axienet_unlock_mii(lp);
>  		if (ret)
>  			return ret;
>  
> @@ -2957,7 +2968,8 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  			return -EINVAL;
>  		}
>  
> -		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(addr_width));
> +		ret = dma_set_mask_and_coherent(lp->dev,
> +						DMA_BIT_MASK(addr_width));
>  		if (ret) {
>  			dev_err(dev, "No suitable DMA available\n");
>  			return ret;
> @@ -3055,7 +3067,7 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  			  lp->phylink_config.supported_interfaces);
>  	}
>  
> -	lp->phylink = phylink_create(&lp->phylink_config, dev->fwnode,
> +	lp->phylink = phylink_create(&lp->phylink_config, dev_fwnode(dev),
>  				     lp->phy_mode,
>  				     &axienet_phylink_ops);
>  	if (IS_ERR(lp->phylink)) {
> @@ -3080,9 +3092,9 @@ static int axienet_mac_probe(struct axienet_common *cp)
>  	return ret;
>  }
>  
> -static void axienet_mac_remove(struct platform_device *pdev)
> +static void axienet_mac_remove(struct auxiliary_device *auxdev)
>  {
> -	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct net_device *ndev = auxiliary_get_drvdata(auxdev);
>  	struct axienet_local *lp = netdev_priv(ndev);
>  
>  	unregister_netdev(ndev);
> @@ -3091,9 +3103,9 @@ static void axienet_mac_remove(struct platform_device *pdev)
>  		put_device(&lp->pcs_phy->dev);
>  }
>  
> -static void axienet_mac_shutdown(struct platform_device *pdev)
> +static void axienet_mac_shutdown(struct auxiliary_device *auxdev)
>  {
> -	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct net_device *ndev = auxiliary_get_drvdata(auxdev);
>  
>  	rtnl_lock();
>  	netif_device_detach(ndev);
> @@ -3139,12 +3151,78 @@ static int axienet_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
>  				axienet_suspend, axienet_resume);
>  
> +static const struct auxiliary_device_id xilinx_axienet_mac_id_table[] = {
> +	{ .name = KBUILD_MODNAME ".mac", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(auxiliary, xilinx_axienet_mac_id_table);
> +
> +static struct auxiliary_driver xilinx_axienet_mac = {
> +	.name = "mac",
> +	.id_table = xilinx_axienet_mac_id_table,
> +	.probe = axienet_mac_probe,
> +	.remove = axienet_mac_remove,
> +	.shutdown = axienet_mac_shutdown,
> +	.driver = {
> +		.pm = &axienet_pm_ops,
> +	},
> +};
> +
> +static DEFINE_IDA(axienet_id);
> +
> +static void axienet_id_free(void *data)
> +{
> +	int id = (intptr_t)data;
> +
> +	ida_free(&axienet_id, id);
> +}
> +
> +static void auxenet_aux_release(struct device *dev) { }
> +
> +static void axienet_aux_destroy(void *data)
> +{
> +	struct auxiliary_device *auxdev = data;
> +
> +	auxiliary_device_delete(auxdev);
> +	auxiliary_device_uninit(auxdev);
> +	fwnode_handle_put(auxdev->dev.fwnode);
> +}
> +
> +static int axienet_aux_create(struct axienet_common *cp,
> +			      struct auxiliary_device *auxdev, const char *name,
> +			      int id, struct fwnode_handle *fwnode)
> +{
> +	struct device *dev = &cp->pdev->dev;
> +	int ret;
> +
> +	auxdev->name = name;
> +	auxdev->id = id;
> +	auxdev->dev.parent = dev;
> +	auxdev->dev.platform_data = cp;
> +	auxdev->dev.release = auxenet_aux_release;
> +	device_set_node(&auxdev->dev, fwnode);
> +	ret = auxiliary_device_init(auxdev);
> +	if (ret) {
> +		fwnode_handle_put(fwnode);
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(auxdev);
> +	if (ret) {
> +		fwnode_handle_put(fwnode);
> +		auxiliary_device_uninit(auxdev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, axienet_aux_destroy, auxdev);
> +}
> +
>  static int axienet_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct axienet_common *cp;
>  	struct resource *ethres;
> -	int ret;
> +	int ret, id;
>  
>  	cp = devm_kzalloc(dev, sizeof(*cp), GFP_KERNEL);
>  	if (!cp)
> @@ -3170,33 +3248,31 @@ static int axienet_probe(struct platform_device *pdev)
>  		return PTR_ERR(cp->regs);
>  	cp->regs_start = ethres->start;
>  
> -	ret = axienet_mdio_setup(cp);
> -	if (ret)
> -		dev_warn(dev, "error registering MDIO bus: %d\n", ret);
> +	id = ida_alloc(&axienet_id, GFP_KERNEL);
> +	if (id < 0)
> +		return dev_err_probe(dev, id, "could not allocate id\n");
>  
> -	ret = axienet_mac_probe(cp);
> -	if (!ret)
> -		return 0;
> +	ret = devm_add_action_or_reset(dev, axienet_id_free,
> +				       (void *)(intptr_t)id);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "could not register id free action\n");
>  
> -	if (cp->mii_bus)
> -		axienet_mdio_teardown(cp);
> -	return ret;
> -}
> +	ret = axienet_aux_create(cp, &cp->mii_bus, "mdio", id,
> +				 device_get_named_child_node(dev, "mdio"));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not create mdio bus\n");
>  
> -static void axienet_remove(struct platform_device *pdev)
> -{
> -	struct net_device *ndev = platform_get_drvdata(pdev);
> -	struct axienet_local *lp = netdev_priv(ndev);
> +	ret = axienet_aux_create(cp, &cp->mac, "mac", id,
> +				 fwnode_handle_get(dev_fwnode(dev)));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "could not create MAC\n");
>  
> -	axienet_mac_remove(pdev);
> -	if (lp->mii_bus)
> -		axienet_mdio_teardown(lp->cp);
> +	return 0;
>  }
>  
>  static struct platform_driver axienet_driver = {
>  	.probe = axienet_probe,
> -	.remove = axienet_remove,
> -	.shutdown = axienet_mac_shutdown,
>  	.driver = {
>  		 .name = "xilinx_axienet",
>  		 .pm = &axienet_pm_ops,
> @@ -3204,7 +3280,35 @@ static struct platform_driver axienet_driver = {
>  	},
>  };
>  
> -module_platform_driver(axienet_driver);
> +static int __init axienet_init(void)
> +{
> +	int ret;
> +
> +	ret = auxiliary_driver_register(&xilinx_axienet_mdio);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_driver_register(&xilinx_axienet_mac);
> +	if (ret)
> +		goto unregister_mdio;
> +
> +	ret = platform_driver_register(&axienet_driver);
> +	if (ret) {
> +		auxiliary_driver_unregister(&xilinx_axienet_mac);
> +unregister_mdio:
> +		auxiliary_driver_unregister(&xilinx_axienet_mdio);
> +	}
> +	return ret;
> +}
> +module_init(axienet_init);
> +
> +static void __exit axienet_exit(void)
> +{
> +	platform_driver_register(&axienet_driver);
platform_driver_unregister

Thanks,
Sundeep

> +	auxiliary_driver_unregister(&xilinx_axienet_mac);
> +	auxiliary_driver_unregister(&xilinx_axienet_mdio);
> +}
> +module_exit(axienet_exit);
>  
>  MODULE_DESCRIPTION("Xilinx Axi Ethernet driver");
>  MODULE_AUTHOR("Xilinx");
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> index d428ce6da639..cc8a2a70271b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> @@ -9,10 +9,10 @@
>   * Copyright (c) 2010 - 2012 Xilinx, Inc. All rights reserved.
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/clk.h>
>  #include <linux/of_address.h>
>  #include <linux/of_mdio.h>
> -#include <linux/platform_device.h>
>  #include <linux/jiffies.h>
>  #include <linux/iopoll.h>
>  
> @@ -271,19 +271,10 @@ static int axienet_mdio_enable(struct mii_bus *bus, struct device_node *np)
>  	return ret;
>  }
>  
> -/**
> - * axienet_mdio_setup - MDIO setup function
> - * @lp:		Pointer to axienet common data structure.
> - *
> - * Return:	0 on success, -ETIMEDOUT on a timeout, -EOVERFLOW on a clock
> - *		divisor overflow, -ENOMEM when mdiobus_alloc (to allocate
> - *		memory for mii bus structure) fails.
> - *
> - * Sets up the MDIO interface by initializing the MDIO clock.
> - * Register the MDIO interface.
> - **/
> -int axienet_mdio_setup(struct axienet_common *lp)
> +static int axienet_mdio_probe(struct auxiliary_device *auxdev,
> +			      const struct auxiliary_device_id *id)
>  {
> +	struct axienet_common *lp = auxdev->dev.platform_data;
>  	struct device_node *mdio_node;
>  	struct mii_bus *bus;
>  	int ret;
> @@ -299,36 +290,40 @@ int axienet_mdio_setup(struct axienet_common *lp)
>  	bus->name = "Xilinx Axi Ethernet MDIO";
>  	bus->read = axienet_mdio_read;
>  	bus->write = axienet_mdio_write;
> -	bus->parent = &lp->pdev->dev;
> -	lp->mii_bus = bus;
> +	bus->parent = &auxdev->dev;
> +	auxiliary_set_drvdata(auxdev, bus);
>  
> -	mdio_node = of_get_child_by_name(lp->pdev->dev.of_node, "mdio");
> -	scoped_guard(mutex, &lp->reset_lock)
> -		ret = axienet_mdio_enable(bus, mdio_node);
> +	mdio_node = dev_of_node(&auxdev->dev);
> +	ret = axienet_mdio_enable(bus, mdio_node);
>  	if (ret < 0)
>  		goto unregister;
>  
>  	ret = of_mdiobus_register(bus, mdio_node);
> -	of_node_put(mdio_node);
>  	scoped_guard(mutex, &lp->reset_lock)
>  		axienet_mdio_mdc_disable(lp);
> -	if (ret) {
> +	if (ret)
>  unregister:
>  		mdiobus_free(bus);
> -		lp->mii_bus = NULL;
> -	}
>  	return ret;
>  }
>  
> -/**
> - * axienet_mdio_teardown - MDIO remove function
> - * @lp:		Pointer to axienet common data structure.
> - *
> - * Unregisters the MDIO and frees any associate memory for mii bus.
> - */
> -void axienet_mdio_teardown(struct axienet_common *lp)
> +static void axienet_mdio_remove(struct auxiliary_device *auxdev)
>  {
> -	mdiobus_unregister(lp->mii_bus);
> -	mdiobus_free(lp->mii_bus);
> -	lp->mii_bus = NULL;
> +	struct mii_bus *mii_bus = auxiliary_get_drvdata(auxdev);
> +
> +	mdiobus_unregister(mii_bus);
> +	mdiobus_free(mii_bus);
>  }
> +
> +static const struct auxiliary_device_id xilinx_axienet_mdio_id_table[] = {
> +	{ .name = KBUILD_MODNAME ".mdio", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(auxiliary, xilinx_axienet_mdio_id_table);
> +
> +struct auxiliary_driver xilinx_axienet_mdio = {
> +	.name = "mdio",
> +	.id_table = xilinx_axienet_mdio_id_table,
> +	.probe = axienet_mdio_probe,
> +	.remove = axienet_mdio_remove,
> +};
> -- 
> 2.35.1.1320.gc452695387.dirty
> 


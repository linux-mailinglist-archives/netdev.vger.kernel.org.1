Return-Path: <netdev+bounces-123703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C12966395
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C0B1C21335
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD218FC81;
	Fri, 30 Aug 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TNOLma2S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CC14C583;
	Fri, 30 Aug 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026475; cv=none; b=gtGO/vZKFuOdEvwxTHA5zhN7QKGcgb3HH+GrZvDF7dlZtvU6MTM30co8l7MIcUkxZd4jj9PJI67fBTffp1B0V1dB+r/b01JvYpOH7ZILjbfcUAKCrf3Cxd0NHETLAYnL6yP92FXoVzC4/lW6az/63ud4rMxAg5SrizUb0d3UFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026475; c=relaxed/simple;
	bh=C3Z5y1dZOZfTSlzzdZ3/9AIABWli/jqJ/ZeVwJiVOQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdZnvU7jra3jzFDehsjF7GyajrPQdpw0naQ5lOj24K/78ohO/lNr3qx8TLTmyxAxdUCmVz5qpWv71fauDbAxkQMB7ibkiLxCwWUQz7Wb/iffNGdcNqa7NRn82qvtsZEd/BxesjtAKwHUAT4WCgk0qql7/PJ6PPbUo7BP4tj+B5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TNOLma2S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WqHlY3J3Gy3ZFqJuFIwq7pRT1lHolLR9IJzBOcAVQGY=; b=TNOLma2SJCXG8AVIBzYNlsD/xa
	G46eYL+kNlkblraHzw4xj3BvIhUjBKU0zFjC8/5uhvpkXLRpPiX0r4geWa2IL+AchJv+wxHeKHvOp
	O6jT3vxgUrot0IHKuv1DAFxHZ8l0+RZ89DCe19uS35vDVoEzlkgC4P0WwjzmaPk+g4Ow=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk2BH-0068Ei-UX; Fri, 30 Aug 2024 16:00:51 +0200
Date: Fri, 30 Aug 2024 16:00:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <177dd95f-8577-4096-a3e8-061d29b88e9c@lunn.ch>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
 <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>

On Fri, Aug 30, 2024 at 04:27:34PM +0300, Roger Quadros wrote:
> 
> 
> On 28/08/2024 12:18, MD Danish Anwar wrote:
> > Add support for offloading HSR port-to-port frame forward to hardware.
> > When the slave interfaces are added to the HSR interface, the PRU cores
> > will be stopped and ICSSG HSR firmwares will be loaded to them.
> > 
> > Similarly, when HSR interface is deleted, the PRU cores will be stopped
> > and dual EMAC firmware will be loaded to them.
> 
> And what happens if we first started with switch mode and then switched to HSR mode?
> Is this case possible and if yes should it revert to the last used mode
> instead of forcing to dual EMAC mode?
> 
> > 
> > This commit also renames some APIs that are common between switch and
> > hsr mode with '_fw_offload' suffix.
> > 
> > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> > ---
> >  .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
> >  drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
> >  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 117 +++++++++++++++++-
> >  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
> >  4 files changed, 130 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> > index 9ec504d976d6..833ca86d0b71 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> > @@ -290,6 +290,7 @@ void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
> >  		     mac[2] << 16 | mac[3] << 24));
> >  	regmap_write(miig_rt, MAC_INTERFACE_1, (u32)(mac[4] | mac[5] << 8));
> >  }
> > +EXPORT_SYMBOL_GPL(icssg_class_set_host_mac_addr);
> >  
> >  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
> >  {
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> > index dae52a83a378..7b2e6c192ff3 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> > @@ -107,7 +107,7 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
> >  	},
> >  };
> >  
> > -static void icssg_config_mii_init_switch(struct prueth_emac *emac)
> > +static void icssg_config_mii_init_fw_offload(struct prueth_emac *emac)
> >  {
> >  	struct prueth *prueth = emac->prueth;
> >  	int mii = prueth_emac_slice(emac);
> > @@ -278,7 +278,7 @@ static int emac_r30_is_done(struct prueth_emac *emac)
> >  	return 1;
> >  }
> >  
> > -static int prueth_switch_buffer_setup(struct prueth_emac *emac)
> > +static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
> >  {
> >  	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
> >  	struct icssg_rxq_ctx __iomem *rxq_ctx;
> > @@ -424,7 +424,7 @@ static void icssg_init_emac_mode(struct prueth *prueth)
> >  	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
> >  }
> >  
> > -static void icssg_init_switch_mode(struct prueth *prueth)
> > +static void icssg_init_fw_offload_mode(struct prueth *prueth)
> >  {
> >  	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
> >  	int i;
> > @@ -455,8 +455,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
> >  	struct icssg_flow_cfg __iomem *flow_cfg;
> >  	int ret;
> >  
> > -	if (prueth->is_switch_mode)
> > -		icssg_init_switch_mode(prueth);
> > +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> > +		icssg_init_fw_offload_mode(prueth);
> >  	else
> >  		icssg_init_emac_mode(prueth);
> >  
> > @@ -472,8 +472,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
> >  	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
> >  			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
> >  	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
> > -	if (prueth->is_switch_mode)
> > -		icssg_config_mii_init_switch(emac);
> > +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> > +		icssg_config_mii_init_fw_offload(emac);
> >  	else
> >  		icssg_config_mii_init(emac);
> >  	icssg_config_ipg(emac);
> > @@ -498,8 +498,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
> >  	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
> >  	writeb(0, config + QUEUE_NUM_UNTAGGED);
> >  
> > -	if (prueth->is_switch_mode)
> > -		ret = prueth_switch_buffer_setup(emac);
> > +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> > +		ret = prueth_fw_offload_buffer_setup(emac);
> >  	else
> >  		ret = prueth_emac_buffer_setup(emac);
> >  	if (ret)
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > index 641e54849762..f4fd346fe6f5 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma/ti-cppi5.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/genalloc.h>
> > +#include <linux/if_hsr.h>
> >  #include <linux/if_vlan.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -40,6 +41,8 @@
> >  #define DEFAULT_PORT_MASK	1
> >  #define DEFAULT_UNTAG_MASK	1
> >  
> > +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
> > +
> >  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
> >  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
> >  
> > @@ -118,6 +121,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +static struct icssg_firmwares icssg_hsr_firmwares[] = {
> > +	{
> > +		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
> > +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
> > +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
> > +	},
> > +	{
> > +		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
> > +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
> > +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
> > +	}
> > +};
> > +
> >  static struct icssg_firmwares icssg_switch_firmwares[] = {
> >  	{
> >  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
> > @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
> >  
> >  	if (prueth->is_switch_mode)
> >  		firmwares = icssg_switch_firmwares;
> > +	else if (prueth->is_hsr_offload_mode)
> > +		firmwares = icssg_hsr_firmwares;
> >  	else
> >  		firmwares = icssg_emac_firmwares;
> >  
> > @@ -726,6 +744,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
> >  	queue_work(emac->cmd_wq, &emac->rx_mode_work);
> >  }
> >  
> > +static int emac_ndo_set_features(struct net_device *ndev,
> > +				 netdev_features_t features)
> > +{
> > +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> > +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> > +	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);
> 
> This is quite hard to read for me.
> why not just do this instead?
> 
> 	netdev_features_t changed = netdev->features ^ feattures;
> 
> Then check and ack on individual features that you want to act upon.
> 
> 	if (changed & NETIF_F_HW_HSR_FWD) {
> 		if (features & NETIF_F_HW_HSR_FWD)
> 			/* enable HSR FWD feature */
> 		else
> 			/* disable HSR FWD feature */
> 	}
> 
> 	if (changed) {
> 		ndev->features = features;
> 		return 1;
> 	}
> 
> >From include/linux/netdevice.h
> 
>  * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
>  *	Called to update device configuration to new features. Passed
>  *	feature set might be less than what was returned by ndo_fix_features()).
>  *	Must return >0 or -errno if it changed dev->features itself.
> 
> Can you please check that if we are not in dual emac mode then we should
> error out if any HSR feature is requested to be set.

This is where all the shenanigans with firmware makes things complex.

One of these options say 'If the interface is used for HSR, offload it
to hardware if possible'. You should be able to set this flag
anytime. It only has any effect when an interface is put into HSR
mode, or if it is already in HSR mode. Hence, the firmware running
right now should not matter.

I suspect the same is true for many of these flags.

> As you mentioned there are some contstraints on what HSR features can be
> enabled individually.
> "2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
>    must also be enabled as these are tightly coupled in
>    the firmware implementation."
> You could do this check there by setting/clearing both features in tandem
> if either one was set/cleared.

Software HSR should always work. Offloading is generally thought as
accelerating this, if the hardware supports the current
configuration. When offloading, if the hardware cannot support the
current configuration, in general it should return -EOPNOTSUPP, and
the software will keep doing the work.

It is not particularly friendly, more of a documentation issue, but
the user needs to set the options the correct way for offload to
work. Otherwise it keeps chugging along in software. I would not
expect to see any error messages when offload is not possible.

	Andrew


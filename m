Return-Path: <netdev+bounces-118112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF69508C8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E622E1F2220F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3D1A0B04;
	Tue, 13 Aug 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kP/NkGyj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625E1A0722;
	Tue, 13 Aug 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562289; cv=none; b=ryBIN1DTFDhVlGRE4+D8D0KCcuJ9qUsTg0pTEdFtF63cekp34B7LSA83hFCgH/0FOiv8FuRF2NZ/T9brtFNBL/Qu3PejZirNVcl67OYByFm2/fRH3nIDxykiNCDUMB6Kr//JZUhJBSdCpX82vMmioB6drxLRyMOo1zlQIyhsudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562289; c=relaxed/simple;
	bh=bDQtUiyRqgXSrfcO2IpA6p2hoMfDdxPBCSaGfTJ8BA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxH5VeJ7frVsBdJKA6mSaLEE5b8YQqdWmxmdhftIFWfwF6Wu3ThOZcHnCCdChiixfBNh7yx8ByiP3NedqXb6sOhfThFPnhU130Hoebf9wjrR+ZPwpqe0ujGUbLo97EmsAnjxGvIJvk5MmWt1rdGHaAxk0aiyYQMzXBKsL1WSPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kP/NkGyj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dYqXKTE0pJmqsYJ3Ya6dkUmsddYDJwkWesi3gUrybOY=; b=kP/NkGyjtatFYvMgGblUbH53N5
	jSyscBcKbPqpIcDRMVd80u+koQXNzG1iact6gDC1JhX0yjPpr0iBS0uSrICsF2KTKXYdkvZmYMyXT
	S+Jtna8IsWgpgtHnfzgdkK7QGoMQg6vdnw24XygR2DL1yxAKFKhzsjDoJq2zrw7a05Fc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdtHV-004h7O-EP; Tue, 13 Aug 2024 17:17:53 +0200
Date: Tue, 13 Aug 2024 17:17:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
Message-ID: <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813074233.2473876-5-danishanwar@ti.com>

On Tue, Aug 13, 2024 at 01:12:30PM +0530, MD Danish Anwar wrote:
> Add support for offloading HSR port-to-port frame forward to hardware.
> When the slave interfaces are added to the HSR interface, the PRU cores
> will be stopped and ICSSG HSR firmwares will be loaded to them.
> 
> Similarly, when HSR interface is deleted, the PRU cores will be stopped
> and dual EMAC firmware will be loaded to them.

Maybe a dumb question, because i don't know HSR....

Can you have one interface in a HSR network, another interface in a
non-HSR network, and bridge packets between the two worlds? Do you
want the HSR firmware, the Switchdev firmware, or Dual EMAC and do the
bridge in software?

>  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>  {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index dae52a83a378..2f485318c940 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -455,7 +455,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  	struct icssg_flow_cfg __iomem *flow_cfg;
>  	int ret;
>  
> -	if (prueth->is_switch_mode)
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>  		icssg_init_switch_mode(prueth);

Maybe icssg_init_switch_mode() needs renaming if it is used for more
than switch mode? There are other functions which might need
generalising.

> +#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
> +
>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>  
> @@ -118,6 +121,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static struct icssg_firmwares icssg_hsr_firmwares[] = {
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
> +	},
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
> +	}
> +};
> +
>  static struct icssg_firmwares icssg_switch_firmwares[] = {
>  	{
>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  
>  	if (prueth->is_switch_mode)
>  		firmwares = icssg_switch_firmwares;
> +	else if (prueth->is_hsr_offload_mode)
> +		firmwares = icssg_hsr_firmwares;

Documentation/networking/netdev-features.rst

* hsr-fwd-offload

This should be set for devices which forward HSR (High-availability Seamless
Redundancy) frames from one port to another in hardware.

To me, this suggests if the flag is not set, you should keep in dual
EMACS or switchdev mode and perform HSR in software.

> +static int emac_ndo_set_features(struct net_device *ndev,
> +				 netdev_features_t features)
> +{
> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD;
> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD;

I would not add the _PRUETH_ alias. There is nothing _PRUETH_ specific
here, its just plain HSR offload.

> +static int prueth_hsr_port_link(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *emac0;
> +	struct prueth_emac *emac1;
> +
> +	emac0 = prueth->emac[PRUETH_MAC0];
> +	emac1 = prueth->emac[PRUETH_MAC1];
> +
> +	if (prueth->is_switch_mode) {
> +		dev_err(prueth->dev, "Switching from bridge to HSR mode not allowed\n");
> +		return -EINVAL;

I think you want EOPNOTSUPP, so that it is performed in software, not
offloaded to hardware. And this is not an error condition, it is just
a limitation of your hardware/firmware.

> +	prueth->hsr_members |= BIT(emac->port_id);
> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
> +		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
> +		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
> +			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
> +			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD)) {
> +				dev_err(prueth->dev, "Enable HSR offload on both interfaces\n");
> +				return -EINVAL;

Again, EOPNOTSUPP, so it falls back to software, and no dev_err().

> +			}
> +			prueth->is_hsr_offload_mode = true;
> +			prueth->default_vlan = 1;
> +			emac0->port_vlan = prueth->default_vlan;
> +			emac1->port_vlan = prueth->default_vlan;
> +			icssg_change_mode(prueth);
> +			dev_err(prueth->dev, "Enabling HSR offload mode\n");

This is not an error condition. dev_dbg().

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void prueth_hsr_port_unlink(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *emac0;
> +	struct prueth_emac *emac1;
> +
> +	emac0 = prueth->emac[PRUETH_MAC0];
> +	emac1 = prueth->emac[PRUETH_MAC1];
> +
> +	prueth->hsr_members &= ~BIT(emac->port_id);
> +	if (prueth->is_hsr_offload_mode) {
> +		prueth->is_hsr_offload_mode = false;
> +		emac0->port_vlan = 0;
> +		emac1->port_vlan = 0;
> +		prueth->hsr_dev = NULL;
> +		prueth_emac_restart(prueth);
> +		dev_info(prueth->dev, "Enabling Dual EMAC mode\n");

dev_dbg().

> +	}
> +}
> +
>  /* netdev notifier */
>  static int prueth_netdevice_event(struct notifier_block *unused,
>  				  unsigned long event, void *ptr)
> @@ -1047,6 +1141,8 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>  	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
>  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
>  	struct netdev_notifier_changeupper_info *info;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
>  	int ret = NOTIFY_DONE;
>  
>  	if (ndev->netdev_ops != &emac_netdev_ops)
> @@ -1056,6 +1152,26 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>  	case NETDEV_CHANGEUPPER:
>  		info = ptr;
>  
> +		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
> +		    is_hsr_master(info->upper_dev)) {
> +			if (info->linking) {
> +				if (!prueth->hsr_dev) {
> +					prueth->hsr_dev = info->upper_dev;
> +
> +					icssg_class_set_host_mac_addr(prueth->miig_rt,
> +								      prueth->hsr_dev->dev_addr);
> +				} else {
> +					if (prueth->hsr_dev != info->upper_dev) {
> +						dev_err(prueth->dev, "Both interfaces must be linked to same upper device\n");

dev_dbg()

	Andrew


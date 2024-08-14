Return-Path: <netdev+bounces-118341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E609514EA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD80B27963
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A213FD99;
	Wed, 14 Aug 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmR5NSp0"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E313E05F;
	Wed, 14 Aug 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618787; cv=none; b=HzlOgvuifhBvIaa+EFICToViIdkyxMYduwQLg1l83XjiSBkJjw93e4bWrs8nH5hE4QJVjFWdG3zDtchGdFbKXA+x9ICcyh3SevTg+x99dtWSuP1n3vWpntojUENGWUbk47gGkb2upYHOnIM4gKlUOdQ3ptUecJi0J8vBeRgJcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618787; c=relaxed/simple;
	bh=yJxTX0e3C7A2iAAsrOjVTu84fnLoW41cpOkIUZcui30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ucM7VWviB40Hls67O98bnU/CDTKS8UwQge5UJ5o7rkY6GyqOPiei8s5sQZxA5p0269D0WJsKhWnBCsInAZ0mDTZUzJYbNkHtauUOETiqs4awCErg6t2Q62GUZRjkeTV1FFIdO8YSGqlYDdTC+a4cJ5EkvZJRQPuLRece+tTYzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AmR5NSp0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E6xPFl021508;
	Wed, 14 Aug 2024 01:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723618765;
	bh=Z7MTqHzGAjJHMOBFwM8XRQ/n0QrHrup44XeckZXd0cg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AmR5NSp0f/bs5vdeTflKyumXr8ma8/gEOkklFD3RxHo1sxBKOkAsbjvp1JIhP7LNT
	 O9w9uMCW7RUzy4vPRoiHUfHLCGxuzQOrUs0ySeZZpyV/xkJP6krot/8AgCTNNBC+gD
	 G6A3kEEdvki5+ufKNQsF7Cy9zYrrnqtI23IRYOLE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E6xPdT021573
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 01:59:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 01:59:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 01:59:24 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E6xJm1083667;
	Wed, 14 Aug 2024 01:59:20 -0500
Message-ID: <1ae38c1d-1f10-4bb9-abd7-5876f710bcb7@ti.com>
Date: Wed, 14 Aug 2024 12:29:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier
 Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-5-danishanwar@ti.com>
 <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 13/08/24 8:47 pm, Andrew Lunn wrote:
> On Tue, Aug 13, 2024 at 01:12:30PM +0530, MD Danish Anwar wrote:
>> Add support for offloading HSR port-to-port frame forward to hardware.
>> When the slave interfaces are added to the HSR interface, the PRU cores
>> will be stopped and ICSSG HSR firmwares will be loaded to them.
>>
>> Similarly, when HSR interface is deleted, the PRU cores will be stopped
>> and dual EMAC firmware will be loaded to them.
> 
> Maybe a dumb question, because i don't know HSR....
> 
> Can you have one interface in a HSR network, another interface in a
> non-HSR network, and bridge packets between the two worlds? Do you
> want the HSR firmware, the Switchdev firmware, or Dual EMAC and do the
> bridge in software?
> 

As far as I know, when adding an hsr interface we need to specify both
the slave interfaces

` ip link add name hsr0 type hsr slave1 eth1 slave2 eth2 supervision 45
version 1`

HSR is only enabled when both the ports are added to hsr interface. If
hsr-fwd-offload is set, the firmware will be changed to HSR otherwise
Dual EMAC firmware will keep running and hsr forwarding will happen in
software.

>>  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>>  {
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index dae52a83a378..2f485318c940 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -455,7 +455,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>>  	struct icssg_flow_cfg __iomem *flow_cfg;
>>  	int ret;
>>  
>> -	if (prueth->is_switch_mode)
>> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>>  		icssg_init_switch_mode(prueth);
> 
> Maybe icssg_init_switch_mode() needs renaming if it is used for more
> than switch mode? There are other functions which might need
> generalising.
> 

Yes, the icssg_init_ and many other APIs are common for switch and hsr.
They can be renamed to indicate that as well.

How does icssg_init_switch_or_hsr_mode() sound?

>> +#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
>> +
>>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>>  
>> @@ -118,6 +121,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static struct icssg_firmwares icssg_hsr_firmwares[] = {
>> +	{
>> +		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
>> +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
>> +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
>> +	},
>> +	{
>> +		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
>> +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
>> +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
>> +	}
>> +};
>> +
>>  static struct icssg_firmwares icssg_switch_firmwares[] = {
>>  	{
>>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
>> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>  
>>  	if (prueth->is_switch_mode)
>>  		firmwares = icssg_switch_firmwares;
>> +	else if (prueth->is_hsr_offload_mode)
>> +		firmwares = icssg_hsr_firmwares;
> 
> Documentation/networking/netdev-features.rst
> 
> * hsr-fwd-offload
> 
> This should be set for devices which forward HSR (High-availability Seamless
> Redundancy) frames from one port to another in hardware.
> 
> To me, this suggests if the flag is not set, you should keep in dual
> EMACS or switchdev mode and perform HSR in software.


Correct. This is the expected behavior. If the flag is not set we remain
in dual EMAC firmware and do HSR in software. Please see
prueth_hsr_port_link() for detail on this.

> 
>> +static int emac_ndo_set_features(struct net_device *ndev,
>> +				 netdev_features_t features)
>> +{
>> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD;
>> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD;
> 
> I would not add the _PRUETH_ alias. There is nothing _PRUETH_ specific
> here, its just plain HSR offload.
> 

I see your query in this is resolved by
https://lore.kernel.org/all/985e10e4-49df-46d8-b9c2-d385dab569a9@lunn.ch/

>> +static int prueth_hsr_port_link(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>> +	struct prueth_emac *emac0;
>> +	struct prueth_emac *emac1;
>> +
>> +	emac0 = prueth->emac[PRUETH_MAC0];
>> +	emac1 = prueth->emac[PRUETH_MAC1];
>> +
>> +	if (prueth->is_switch_mode) {
>> +		dev_err(prueth->dev, "Switching from bridge to HSR mode not allowed\n");
>> +		return -EINVAL;
> 
> I think you want EOPNOTSUPP, so that it is performed in software, not
> offloaded to hardware. And this is not an error condition, it is just
> a limitation of your hardware/firmware.
> 

Sure.

>> +	prueth->hsr_members |= BIT(emac->port_id);
>> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
>> +		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
>> +		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
>> +			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
>> +			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD)) {
>> +				dev_err(prueth->dev, "Enable HSR offload on both interfaces\n");
>> +				return -EINVAL;
> 
> Again, EOPNOTSUPP, so it falls back to software, and no dev_err().

sure I will change this to EOPNOTSUPP and remove the print.

> 
>> +			}
>> +			prueth->is_hsr_offload_mode = true;
>> +			prueth->default_vlan = 1;
>> +			emac0->port_vlan = prueth->default_vlan;
>> +			emac1->port_vlan = prueth->default_vlan;
>> +			icssg_change_mode(prueth);
>> +			dev_err(prueth->dev, "Enabling HSR offload mode\n");
> 
> This is not an error condition. dev_dbg().

Sure.

> 
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void prueth_hsr_port_unlink(struct net_device *ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>> +	struct prueth_emac *emac0;
>> +	struct prueth_emac *emac1;
>> +
>> +	emac0 = prueth->emac[PRUETH_MAC0];
>> +	emac1 = prueth->emac[PRUETH_MAC1];
>> +
>> +	prueth->hsr_members &= ~BIT(emac->port_id);
>> +	if (prueth->is_hsr_offload_mode) {
>> +		prueth->is_hsr_offload_mode = false;
>> +		emac0->port_vlan = 0;
>> +		emac1->port_vlan = 0;
>> +		prueth->hsr_dev = NULL;
>> +		prueth_emac_restart(prueth);
>> +		dev_info(prueth->dev, "Enabling Dual EMAC mode\n");
> 
> dev_dbg().

Sure.

> 
>> +	}
>> +}
>> +
>>  /* netdev notifier */
>>  static int prueth_netdevice_event(struct notifier_block *unused,
>>  				  unsigned long event, void *ptr)
>> @@ -1047,6 +1141,8 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>>  	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
>>  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
>>  	struct netdev_notifier_changeupper_info *info;
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>>  	int ret = NOTIFY_DONE;
>>  
>>  	if (ndev->netdev_ops != &emac_netdev_ops)
>> @@ -1056,6 +1152,26 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>>  	case NETDEV_CHANGEUPPER:
>>  		info = ptr;
>>  
>> +		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
>> +		    is_hsr_master(info->upper_dev)) {
>> +			if (info->linking) {
>> +				if (!prueth->hsr_dev) {
>> +					prueth->hsr_dev = info->upper_dev;
>> +
>> +					icssg_class_set_host_mac_addr(prueth->miig_rt,
>> +								      prueth->hsr_dev->dev_addr);
>> +				} else {
>> +					if (prueth->hsr_dev != info->upper_dev) {
>> +						dev_err(prueth->dev, "Both interfaces must be linked to same upper device\n");
> 
> dev_dbg()

Sure. I will do these changes and send out a new version. Please let me
know if any other change is needed.

> 
> 	Andrew

-- 
Thanks and Regards,
Danish


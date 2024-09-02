Return-Path: <netdev+bounces-124082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA14967EC8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142A3280E68
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06C433C4;
	Mon,  2 Sep 2024 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OcvkvqHp"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD97382;
	Mon,  2 Sep 2024 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254952; cv=none; b=RtQFW4JC/YaAz2pNQeIXr2MKTJESew23wttzGx2kT2yr2pn04rguZR62whKQI2heErpx8JH9pHwy6YWjKBdVg/yyC1DueHlptKAh8HuLpeCfvEYJ8NTxq6fGWqkcsZ0/36Jo0IVyShuCE1N2UCMzSmxP29GJFgZguhGdF8J+y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254952; c=relaxed/simple;
	bh=JoKv3sSAVox56kv6h0rvjJleuZzBfXcJGqwWeG/ah9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F4RU4+LmzLz0Wv7+oDhcUbKfJfqCKmlBjh0wgane2Hz52GuChOeT76odoLVJTBNki4PH6Jk7giFapF0pCv9IWv4pfCG/4XU/VF85Et56Vx5GncROdzz2aXH72v77EoijCruaua9KXpsfLmsVcknv5Dd+HLdX5+TBXqFXPBJD8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OcvkvqHp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4825SkqC007836;
	Mon, 2 Sep 2024 00:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725254926;
	bh=1VXQ/4T/jTnrJNq2ED7OuuFuehVwkSER10p3wwNUe3M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OcvkvqHpBNoQ9do23f5sBKcRGQ2c59B/Q6MsRAvjquha7byCsyAqVPAMC1ILbR4rC
	 ZPMGHhuLYDwut/03KSXHkSn1GnxMM19f207AOtBhiz7i5sCsinm+yubvmGVeZy/bin
	 kIy2ZeAf7xVYr5rdbBmVcv3Jp86iBxxOWxQCoueQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4825SkCh002665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 00:28:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 00:28:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 00:28:45 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4825Sefs067572;
	Mon, 2 Sep 2024 00:28:40 -0500
Message-ID: <5909fc5d-ba18-4949-8594-caafef78d3f3@ti.com>
Date: Mon, 2 Sep 2024 10:58:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
 <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 8/30/2024 6:57 PM, Roger Quadros wrote:
> 
> 
> On 28/08/2024 12:18, MD Danish Anwar wrote:
>> Add support for offloading HSR port-to-port frame forward to hardware.
>> When the slave interfaces are added to the HSR interface, the PRU cores
>> will be stopped and ICSSG HSR firmwares will be loaded to them.
>>
>> Similarly, when HSR interface is deleted, the PRU cores will be stopped
>> and dual EMAC firmware will be loaded to them.
> 
> And what happens if we first started with switch mode and then switched to HSR mode?
> Is this case possible and if yes should it revert to the last used mode
> instead of forcing to dual EMAC mode?
> 

That is not supported by the firmware. In prueth_hsr_port_link()

+	if (prueth->is_switch_mode)
+		return -EOPNOTSUPP;

We will not change the prueth->mode or the firmware settings, driver
will return -EOPNOTSUPP and the offloading will happen in software as
suggested by Andrew L in v2 [1] . HW offloading is only supported from
dual EMAC mode to HSR.

Perhaps the commit message here is misleading, I will update the commit
message.

>>
>> This commit also renames some APIs that are common between switch and
>> hsr mode with '_fw_offload' suffix.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
>>  drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 117 +++++++++++++++++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
>>  4 files changed, 130 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> index 9ec504d976d6..833ca86d0b71 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
>> @@ -290,6 +290,7 @@ void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
>>  		     mac[2] << 16 | mac[3] << 24));
>>  	regmap_write(miig_rt, MAC_INTERFACE_1, (u32)(mac[4] | mac[5] << 8));
>>  }
>> +EXPORT_SYMBOL_GPL(icssg_class_set_host_mac_addr);
>>  
>>  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>>  {
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index dae52a83a378..7b2e6c192ff3 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -107,7 +107,7 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
>>  	},
>>  };
>>  
>> -static void icssg_config_mii_init_switch(struct prueth_emac *emac)
>> +static void icssg_config_mii_init_fw_offload(struct prueth_emac *emac)
>>  {
>>  	struct prueth *prueth = emac->prueth;
>>  	int mii = prueth_emac_slice(emac);
>> @@ -278,7 +278,7 @@ static int emac_r30_is_done(struct prueth_emac *emac)
>>  	return 1;
>>  }
>>  
>> -static int prueth_switch_buffer_setup(struct prueth_emac *emac)
>> +static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
>>  {
>>  	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
>>  	struct icssg_rxq_ctx __iomem *rxq_ctx;
>> @@ -424,7 +424,7 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>>  	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>>  }
>>  
>> -static void icssg_init_switch_mode(struct prueth *prueth)
>> +static void icssg_init_fw_offload_mode(struct prueth *prueth)
>>  {
>>  	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
>>  	int i;
>> @@ -455,8 +455,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>>  	struct icssg_flow_cfg __iomem *flow_cfg;
>>  	int ret;
>>  
>> -	if (prueth->is_switch_mode)
>> -		icssg_init_switch_mode(prueth);
>> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>> +		icssg_init_fw_offload_mode(prueth);
>>  	else
>>  		icssg_init_emac_mode(prueth);
>>  
>> @@ -472,8 +472,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>>  	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
>>  			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
>>  	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
>> -	if (prueth->is_switch_mode)
>> -		icssg_config_mii_init_switch(emac);
>> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>> +		icssg_config_mii_init_fw_offload(emac);
>>  	else
>>  		icssg_config_mii_init(emac);
>>  	icssg_config_ipg(emac);
>> @@ -498,8 +498,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>>  	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
>>  	writeb(0, config + QUEUE_NUM_UNTAGGED);
>>  
>> -	if (prueth->is_switch_mode)
>> -		ret = prueth_switch_buffer_setup(emac);
>> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>> +		ret = prueth_fw_offload_buffer_setup(emac);
>>  	else
>>  		ret = prueth_emac_buffer_setup(emac);
>>  	if (ret)
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 641e54849762..f4fd346fe6f5 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/dma/ti-cppi5.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/genalloc.h>
>> +#include <linux/if_hsr.h>
>>  #include <linux/if_vlan.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>> @@ -40,6 +41,8 @@
>>  #define DEFAULT_PORT_MASK	1
>>  #define DEFAULT_UNTAG_MASK	1
>>  
>> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
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
>>  	else
>>  		firmwares = icssg_emac_firmwares;
>>  
>> @@ -726,6 +744,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
>>  	queue_work(emac->cmd_wq, &emac->rx_mode_work);
>>  }
>>  
>> +static int emac_ndo_set_features(struct net_device *ndev,
>> +				 netdev_features_t features)
>> +{
>> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
>> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
>> +	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);
> 
> This is quite hard to read for me.
> why not just do this instead?
> 
> 	netdev_features_t changed = netdev->features ^ feattures;
> 
> Then check and ack on individual features that you want to act upon.
> 

Sure Roger, I will modfiy this function and implement it as you have
suggested below.

> 	if (changed & NETIF_F_HW_HSR_FWD) {
> 		if (features & NETIF_F_HW_HSR_FWD)
> 			/* enable HSR FWD feature */
> 		else
> 			/* disable HSR FWD feature */
> 	}
> 

Roger, there is no action needed here. In this function we should just
set / unset features related to HSR in ndev->features. We don't need to
do any action in if / else. Based on which HSR features are set / unset,
the different APIs will perform different actions. Perhaps we can do
something like below,

	if (changed & NETIF_F_HW_HSR_FWD)
		if (features & NETIF_F_HW_HSR_FWD)
			ndev->features |= NETIF_F_HW_HSR_FWD;
		else
			ndev->features &= ~NETIF_F_HW_HSR_FWD;

We can do this for all HSR related features. This will also elimnate
below if check and we can just `return changed`.

> 	if (changed) {
> 		ndev->features = features;
> 		return 1;
> 	}
> 
> From include/linux/netdevice.h
> 
>  * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
>  *	Called to update device configuration to new features. Passed
>  *	feature set might be less than what was returned by ndo_fix_features()).
>  *	Must return >0 or -errno if it changed dev->features itself.
> 
> Can you please check that if we are not in dual emac mode then we should
> error out if any HSR feature is requested to be set.
> 

Yes, the ndev->features should only be changed when we are in dual EMAC
mode / HSR offload mode. If we are in swicth mode these features
shouldn't be changed as hardware offloading is not supported in switch mode.

>> +
>> +	if (hsr_change_request)
>> +		ndev->features = features;
>> +
>> +	return 0;
> 
> 
> You may also want to check out
> 
>  * netdev_features_t (*ndo_fix_features)(struct net_device *dev,
>  *		netdev_features_t features);
>  *	Adjusts the requested feature flags according to device-specific
>  *	constraints, and returns the resulting flags. Must not modify
>  *	the device state.
> 
> As you mentioned there are some contstraints on what HSR features can be
> enabled individually.
> "2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
>    must also be enabled as these are tightly coupled in
>    the firmware implementation."
> You could do this check there by setting/clearing both features in tandem
> if either one was set/cleared.
> 

Sure I will look into that.

>> +}
>> +
>>  static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_open = emac_ndo_open,
>>  	.ndo_stop = emac_ndo_stop,
>> @@ -737,6 +768,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
>> +	.ndo_set_features = emac_ndo_set_features,
>>  };
>>  
>>  static int prueth_netdev_init(struct prueth *prueth,
>> @@ -865,6 +897,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>>  	ndev->ethtool_ops = &icssg_ethtool_ops;
>>  	ndev->hw_features = NETIF_F_SG;
>>  	ndev->features = ndev->hw_features;
>> +	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
>>  
>>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
>> @@ -953,7 +986,7 @@ static void prueth_emac_restart(struct prueth *prueth)
>>  	netif_device_attach(emac1->ndev);
>>  }
>>  
>> -static void icssg_enable_switch_mode(struct prueth *prueth)
>> +static void icssg_change_mode(struct prueth *prueth)
>>  {
>>  	struct prueth_emac *emac;
>>  	int mac;
>> @@ -973,8 +1006,12 @@ static void icssg_enable_switch_mode(struct prueth *prueth)
>>  					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
>>  					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
>>  					  true);
>> +			if (prueth->is_hsr_offload_mode)
>> +				icssg_vtbl_modify(emac, DEFAULT_VID, DEFAULT_PORT_MASK,
>> +						  DEFAULT_UNTAG_MASK, true);
>>  			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
>> -			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
>> +			if (prueth->is_switch_mode)
>> +				icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
>>  		}
>>  	}
>>  }
>> @@ -1012,7 +1049,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
>>  			prueth->is_switch_mode = true;
>>  			prueth->default_vlan = 1;
>>  			emac->port_vlan = prueth->default_vlan;
>> -			icssg_enable_switch_mode(prueth);
>> +			icssg_change_mode(prueth);
>>  		}
>>  	}
>>  
>> @@ -1040,6 +1077,59 @@ static void prueth_netdevice_port_unlink(struct net_device *ndev)
>>  		prueth->hw_bridge_dev = NULL;
>>  }
>>  
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
>> +	if (prueth->is_switch_mode)
>> +		return -EOPNOTSUPP;
>> +
>> +	prueth->hsr_members |= BIT(emac->port_id);
>> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
> 
> you already checked that is_switch_mode is not set earlier. No need to check again.
> 

Sure. Will remove this.

>> +		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
>> +		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
>> +			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
>> +			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES))
>> +				return -EOPNOTSUPP;
>> +			prueth->is_hsr_offload_mode = true;
>> +			prueth->default_vlan = 1;
>> +			emac0->port_vlan = prueth->default_vlan;
>> +			emac1->port_vlan = prueth->default_vlan;
>> +			icssg_change_mode(prueth);
>> +			dev_dbg(prueth->dev, "Enabling HSR offload mode\n");
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
>> +		dev_dbg(prueth->dev, "Enabling Dual EMAC mode\n");
>> +	}
>> +}
>> +

[...]

[1]
https://lore.kernel.org/all/082f81fc-c9ad-40d7-8172-440765350b48@lunn.ch/

-- 
Thanks and Regards,
Md Danish Anwar


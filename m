Return-Path: <netdev+bounces-153279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2224F9F789D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667B8166997
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C142206B3;
	Thu, 19 Dec 2024 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mPNqnIny"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8F221459;
	Thu, 19 Dec 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601053; cv=none; b=ugyjeReIPqiGZOVQfaQyFjZFT0u4x3o24Ap54GL9bCG1n0AerBZL2cbOZyXfV+KlvTu+gTFcMuYpWJ3fcKylCDA8UgpwhN4LQZh0DwM9OK1kAXTQUqGeZp4yzRqCYCsoa6Ou+vcOHV9BUHOPESQiGBXTRVUVZLDO6qPHop7vKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601053; c=relaxed/simple;
	bh=w+t9cdkFACXJrl3CLdLZjwUPKm8t+iY23m11ieZb1YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uX6Sc/lbL5tWan5kSBwIT/bxDt6YsKAH8LGkuI643fh/PKff+CUISczVeg2VT3pwJmdIftoNzP6BQODCGHApWEpgiZ2saFxXKnzccowOzgvdSfbtqbXsua5PtT/aCrO590unk3SdC2GNidOqZg3WYBtB6pU0KgdavhdOKz6yvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mPNqnIny; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ9aPAh297709
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 03:36:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734600985;
	bh=lRPtMlQGEws5Eh1SMwe1Ib+jNbK5W+VxEW7MX8ZGXs4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mPNqnInypvrn20eKc/miT1KKi2PvSwgyoWdvxGJsbyXe3K0zF9aqmH97R5JKSTRgH
	 w2Im/zqile/VuO7kxl90KH/7uEaWb54dUdCcHQiTKRbrhKKrC4P2bvjPkBuyrC3m1j
	 nPsot/eK//yXlMp8huh4ZzUJyCibaq22rvCoF9sk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ9aP2k082052
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Dec 2024 03:36:25 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 03:36:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 03:36:24 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ9aIR1122488;
	Thu, 19 Dec 2024 03:36:19 -0600
Message-ID: <cb319ffd-ac67-42b3-9786-e8c9970086d2@ti.com>
Date: Thu, 19 Dec 2024 15:06:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: ti: icssg-prueth: Add Multicast
 Filtering support for VLAN in MAC mode
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>,
        <schnelle@linux.ibm.com>, <vladimir.oltean@nxp.com>,
        <horms@kernel.org>, <rogerq@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-4-danishanwar@ti.com>
 <Z2PLDqqrLdXhLtAF@mev-dev.igk.intel.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <Z2PLDqqrLdXhLtAF@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 19/12/24 12:58 pm, Michal Swiatkowski wrote:
> On Mon, Dec 16, 2024 at 03:30:43PM +0530, MD Danish Anwar wrote:
>> Add multicast filtering support for VLAN interfaces in dual EMAC mode
>> for ICSSG driver.
>>
>> The driver uses vlan_for_each() API to get the list of available
>> vlans. The driver then sync mc addr of vlan interface with a locally
>> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
>> API.
>>
>> The driver then calls the sync / unsync callbacks and based on whether
>> the ndev is vlan or not, driver passes appropriate vid to FDB helper
>> functions.
>>
>> This commit also exports __hw_addr_sync_multiple() in order to use it
>> from the ICSSG driver.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 69 ++++++++++++++++----
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
>>  include/linux/netdevice.h                    |  3 +
>>  net/core/dev_addr_lists.c                    |  7 +-
>>  4 files changed, 68 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index e031bccf31dc..a18773ef6eab 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -472,30 +472,43 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>  
>>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>>  {
>> -	struct prueth_emac *emac = netdev_priv(ndev);
>> -	int port_mask = BIT(emac->port_id);
>> +	struct net_device *real_dev;
>> +	struct prueth_emac *emac;
>> +	int port_mask;
>> +	u8 vlan_id;
>>  
>> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> Looks like a helper for that can be nice to have.
>

I don't think that's neccessary. vlan_dev_real_dev() itself is a helper
function to give the real dev, only down side is vlan_dev_real_dev()
assumes that the dev is vlan only.

In this function, we don't know if ndev is vlan or not, hence the check.
Most drivers are using vlan_dev_real_dev() the same way.


>> +	emac = netdev_priv(real_dev);
>> +
>> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
>>  
>>  	return 0;
>>  }
>>  
>>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>>  {
>> -	struct prueth_emac *emac = netdev_priv(ndev);
>> -	int port_mask = BIT(emac->port_id);
>> +	struct net_device *real_dev;
>> +	struct prueth_emac *emac;
>>  	int other_port_mask;
>> +	int port_mask;
>> +	u8 vlan_id;
>> +
>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>> +	emac = netdev_priv(real_dev);
>>  
>> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
>> +	port_mask = BIT(emac->port_id);
>> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
>>  
>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
>>  
>>  	if (other_port_mask) {
>> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
>> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
>> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
>> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask, other_port_mask, true);
>>  	}
>>  
>>  	return 0;
>> @@ -531,6 +544,28 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>>  	return 0;
>>  }
>>  
>> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
>> +				   void *args)
>> +{
>> +	struct net_device *vport_ndev;
>> +	struct prueth_emac *emac;
>> +
>> +	if (!vdev || !vid)
>> +		return 0;
>> +
>> +	vport_ndev = vlan_dev_real_dev(vdev);
>> +	emac = netdev_priv(vport_ndev);
>> +
>> +	netif_addr_lock_bh(vdev);
>> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc, vdev->addr_len);
> Only question, why dev_mc_sync_multiple can't be used here?
> 

dev_mc_sync_multiple() doesn't work here.

Let's say we call dev_mc_sync_multiple() with emac->ndev (the netdevice
for current port say eth1) and vdev (the netdevice for the vlan
interface say eth1.x with x being the vid).

Now dev_mc_sync_multiple() will sync the mc list from vdev to ndev. And
ndev will have the address added to vdev. After this set_rx_mode() gets
called for ndev. Which eventually calls sync / unsync APIs
icssg_prueth_add/del_mcast.

Now in this API, we will have the address to add but we won't have the vid.

The sync/unsync API will be called for the emac->ndev (the *to* device)
and emac->ndev will have no information about vid. Since it is not a
vlan dev and is_vlan_dev() will be false for it as a result we will
fallback to default vid.

	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) :
PRUETH_DFLT_VLAN_HSR;

We don't want this. We want to capture the correct vid. Hence sync /
unsync needs to get called for the vlan device i.e. vdev.

Due to this dev_mc_sync_multiple() doesn't work and we need to call
__hw_addr_sync_multiple and __hw_addr_sync_dev on vdev so that our sync
/ unsync APIs are called for vdev.


>> +	netif_addr_unlock_bh(vdev);
>> +
>> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
>> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * emac_ndo_open - EMAC device open
>>   * @ndev: network adapter device
>> @@ -772,12 +807,17 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> -	if (emac->prueth->is_hsr_offload_mode)
>> +	if (emac->prueth->is_hsr_offload_mode) {
>>  		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
>>  			      icssg_prueth_hsr_del_mcast);
>> -	else
>> +	} else {
>>  		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
>>  			      icssg_prueth_del_mcast);
>> +		if (rtnl_trylock()) {
>> +			vlan_for_each(ndev, icssg_update_vlan_mcast, NULL);
>> +			rtnl_unlock();
>> +		}
>> +	}
>>  }
>>  
>>  /**
>> @@ -828,6 +868,7 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
>>  	if (prueth->is_hsr_offload_mode)
>>  		port_mask |= BIT(PRUETH_PORT_HOST);
>>  
>> +	__hw_addr_init(&emac->vlan_mcast_list[vid]);
>>  	netdev_err(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
>>  		   vid, port_mask, untag_mask);
>>  
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index f5c1d473e9f9..4da8b87408b5 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -83,6 +83,10 @@
>>  #define ICSS_CMD_ADD_FILTER 0x7
>>  #define ICSS_CMD_ADD_MAC 0x8
>>  
>> +/* VLAN Filtering Related MACROs */
>> +#define PRUETH_DFLT_VLAN_MAC	0
>> +#define MAX_VLAN_ID		256
>> +
>>  /* In switch mode there are 3 real ports i.e. 3 mac addrs.
>>   * however Linux sees only the host side port. The other 2 ports
>>   * are the switch ports.
>> @@ -201,6 +205,8 @@ struct prueth_emac {
>>  	/* RX IRQ Coalescing Related */
>>  	struct hrtimer rx_hrtimer;
>>  	unsigned long rx_pace_timeout_ns;
>> +
>> +	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
>>  };
>>  
>>  /**
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index d917949bba03..a5c169b19543 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -4685,6 +4685,9 @@ int devm_register_netdev(struct device *dev, struct net_device *ndev);
>>  /* General hardware address lists handling functions */
>>  int __hw_addr_sync(struct netdev_hw_addr_list *to_list,
>>  		   struct netdev_hw_addr_list *from_list, int addr_len);
>> +int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
>> +			    struct netdev_hw_addr_list *from_list,
>> +			    int addr_len);
>>  void __hw_addr_unsync(struct netdev_hw_addr_list *to_list,
>>  		      struct netdev_hw_addr_list *from_list, int addr_len);
>>  int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
>> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
>> index 166e404f7c03..90716bd736f3 100644
>> --- a/net/core/dev_addr_lists.c
>> +++ b/net/core/dev_addr_lists.c
>> @@ -242,9 +242,9 @@ static void __hw_addr_unsync_one(struct netdev_hw_addr_list *to_list,
>>  	__hw_addr_del_entry(from_list, ha, false, false);
>>  }
>>  
>> -static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
>> -				   struct netdev_hw_addr_list *from_list,
>> -				   int addr_len)
>> +int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
>> +			    struct netdev_hw_addr_list *from_list,
>> +			    int addr_len)
>>  {
>>  	int err = 0;
>>  	struct netdev_hw_addr *ha, *tmp;
>> @@ -260,6 +260,7 @@ static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
>>  	}
>>  	return err;
>>  }
>> +EXPORT_SYMBOL(__hw_addr_sync_multiple);
>>  
>>  /* This function only works where there is a strict 1-1 relationship
>>   * between source and destination of they synch. If you ever need to
>> -- 
>> 2.34.1

-- 
Thanks and Regards,
Danish


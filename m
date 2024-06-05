Return-Path: <netdev+bounces-100890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEE18FC78E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C2FB20AE5
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6118FC6F;
	Wed,  5 Jun 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cf+FpZYb"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F318F2EC;
	Wed,  5 Jun 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579263; cv=none; b=JfPnWP3MNB/tkrKYo0o1Mj9AZknKyGYx2H6yhBsjzkgc6UWRBhvRujzOPywmcbR58vd/3OLAQdY0cHlgzo+kyLlL41PdUGlPzc29u8q5TG+V3stuKlwIajLAofv2Z4IJhVmNxbfCZbSBsTg35uQnDc+FPAPGvCqfYtgQ+SlfTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579263; c=relaxed/simple;
	bh=TSWh+4fTbItxxafUNUTgwAm8SwpSQUL39qeXi526Ar8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kiRMn9hcR5rddUI6Ny1FNynnYaSUL5fSoDTXSRkvy3kST/S3PVCk7sT0eVJgdMbqSDDb9HL5HsDrbc8HiA35Kr2AiSIJgIy2UyFdVUlWgqNBtKiNaXe8zjC5boi4To7bsIa2zmC36GBZbTF42JvAUDRqRpf+SIxdw5Zpb2wpwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cf+FpZYb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4559Khbp076135;
	Wed, 5 Jun 2024 04:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717579243;
	bh=6jIN9q834lRQoVlqNmA+I3lhBIz7L/DRT8jBL0JXrpk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cf+FpZYbPMTNNfXVvSUatWH+M309QQZtTGk3veFkMr4rpzKKYnvnaZiw+1bRbcJ5L
	 aolTh75FRH3r4jUGXXtE//66gyyCy7uBPzSIOktousu7dTtYBeD1lVRWuXABJrcqRq
	 t7P0T7T2fPz9sYUTChQzDkEUFBPIzk1ESoR1Hgnk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4559Khrk071518
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 04:20:43 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 04:20:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 04:20:43 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4559Kd8f047120;
	Wed, 5 Jun 2024 04:20:39 -0500
Message-ID: <f722a100-0fc3-461c-95ad-2d0b9d0bd75e@ti.com>
Date: Wed, 5 Jun 2024 14:50:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add multicast
 filtering support
To: Wojciech Drewek <wojciech.drewek@intel.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240604114402.1835973-1-danishanwar@ti.com>
 <b95de69c-5b49-44af-95d3-fbcc0d75d449@intel.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <b95de69c-5b49-44af-95d3-fbcc0d75d449@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Wojciech,

On 04/06/24 8:19 pm, Wojciech Drewek wrote:
> 
> 
> On 04.06.2024 13:44, MD Danish Anwar wrote:
>> Add multicast filtering support for ICSSG Driver.
>>
>> The driver will keep a copy of multicast addresses in emac->mcast_list.
>> This list will be kept in sync with the netdev list and to add / del
>> multicast address icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast
>> APIs will be called.
>>
>> To add a mac_address for a port, driver need to call icssg_fdb_add_del()
>> and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
>> will then configure the rules and allow filtering.
>>
>> If a mac_address is added to port0 and the same mac_address needs to be
>> added for port1, driver needs to pass BIT(port0) | BIT(port1) to the
>> icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
>> port0 will be overwritten / lost. This is a design constraint on the
>> firmware side.
>>
>> To overcome this in the driver, to add any mac_address for let's say portX
>> driver first checks if the same mac_address is already added for any other
>> port. If yes driver calls icssg_fdb_add_del() with BIT(portX) |
>> BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with
>> BIT(portX).
>>
>> The same thing is applicable for deleting mac_addresses as well. This
>> logic is in icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast APIs.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> v1 -> v2:
>> *) Rebased on latest net-next/main.
>>
>> NOTE: This series can be applied cleanly on the tip of net-next/main. This
>> series doesn't depend on any other ICSSG driver related series that is
>> floating around in netdev.
>>
>> v1 https://lore.kernel.org/all/20240516091752.2969092-1-danishanwar@ti.com/
>>
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 50 ++++++++++++++++++--
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
>>  2 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 6e65aa0977d4..03dd49f0afb7 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -439,6 +439,37 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>  	.perout_enable = prueth_perout_enable,
>>  };
>>  
>> +static int icssg_prueth_mac_add_mcast(struct net_device *ndev, const u8 *addr)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	int port_mask = BIT(emac->port_id);
>> +
>> +	port_mask |= icssg_fdb_lookup(emac, addr, 0);
>> +	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
>> +	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
>> +
>> +	return 0;
>> +}
>> +
>> +static int icssg_prueth_mac_del_mcast(struct net_device *ndev, const u8 *addr)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	int port_mask = BIT(emac->port_id);
>> +	int other_port_mask;
>> +
>> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
>> +
>> +	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
>> +	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
>> +
>> +	if (other_port_mask) {
>> +		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
>> +		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * emac_ndo_open - EMAC device open
>>   * @ndev: network adapter device
>> @@ -547,6 +578,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>  
>>  	prueth->emacs_initialized++;
>>  
>> +	__hw_addr_init(&emac->mcast_list);
>> +
>>  	queue_work(system_long_wq, &emac->stats_work.work);
>>  
>>  	return 0;
>> @@ -599,6 +632,9 @@ static int emac_ndo_stop(struct net_device *ndev)
>>  
>>  	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>>  
>> +	__dev_mc_unsync(ndev, icssg_prueth_mac_del_mcast);
>> +	__hw_addr_init(&emac->mcast_list);
>> +
>>  	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
>>  	/* ensure new tdown_cnt value is visible */
>>  	smp_mb__after_atomic();
>> @@ -675,10 +711,15 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> -	if (!netdev_mc_empty(ndev)) {
>> -		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
>> -		return;
>> -	}
>> +	/* make a mc list copy */
>> +
>> +	netif_addr_lock_bh(ndev);
>> +	__hw_addr_sync(&emac->mcast_list, &ndev->mc, ndev->addr_len);
>> +	netif_addr_unlock_bh(ndev);
>> +
>> +	__hw_addr_sync_dev(&emac->mcast_list, ndev,
>> +			   icssg_prueth_mac_add_mcast,
>> +			   icssg_prueth_mac_del_mcast);
> 
> Is there a reason __dev_mc_sync can't be used here?
> net_device has mc list already, no need to keep your own list
> in prueth_emac.

I checked the code and __dev_mc_sync() can be used here. No need for
keeping local list as you pointed out. I will drop this and re post the
patch.

Thanks for the review.

> 
>>  }
>>  
>>  /**
>> @@ -767,6 +808,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>>  	SET_NETDEV_DEV(ndev, prueth->dev);
>>  	spin_lock_init(&emac->lock);
>>  	mutex_init(&emac->cmd_lock);
>> +	__hw_addr_init(&emac->mcast_list);
>>  
>>  	emac->phy_node = of_parse_phandle(eth_node, "phy-handle", 0);
>>  	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 5eeeccb73665..2bfda26b5901 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -155,6 +155,9 @@ struct prueth_emac {
>>  	unsigned int tx_ts_enabled : 1;
>>  	unsigned int half_duplex : 1;
>>  
>> +	/* List for storing multicast addresses */
>> +	struct netdev_hw_addr_list mcast_list;
>> +
>>  	/* DMA related */
>>  	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
>>  	struct completion tdown_complete;
>>
>> base-commit: 2589d668e1a6ebe85329f1054cdad13647deac06

-- 
Thanks and Regards,
Danish


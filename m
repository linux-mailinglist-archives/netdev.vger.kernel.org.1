Return-Path: <netdev+bounces-143779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE39C41D9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 16:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA860284E3F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CCA19E83D;
	Mon, 11 Nov 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8MhnEBo"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38B19E97A;
	Mon, 11 Nov 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339008; cv=none; b=uLS4t5TO2z+UfrVHXLgARNQ+zYD1R4wET5MTAZAl/8WUOqWshwWLJmE/ZyObQFXmDX4SggBbok+VpnX/vZTN+pKVOflZ9IPpIno/7EuGSsbiLfSIgKRFxnxomh4l6OO33NKX2dF3xCiQbJVSNmswR8Yy8I20TSl3foANjjVMNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339008; c=relaxed/simple;
	bh=jiTBO7ZfaJJyVn2+e85x5Q068g2O2C+9SG1ZgIDfijs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y0sOc+9sYGKdAObg0tayYwUUT0mgFnBRkKAypW/y7XxVASkXJZQcD2mE1nieACWrEYNa4kPvU9X3G4mZRaphzxSAOwGpE/dY7WeBxlaa0Yj/uDggMq0bfOf1D812vic1p422ISykUc0eynHje5HAqXr80AT1nZ3e1pOLAf9jTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I8MhnEBo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ABFTjXS125982;
	Mon, 11 Nov 2024 09:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731338985;
	bh=6ITKN9KZa1CRjZuEzbCX1tyeuQszXtXbK7hA14G4sVI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=I8MhnEBoPInKvzelqCKxXnR1cLinG5cpQMnsirlxU0ZV66A6ehapLsZhWvg53Zc29
	 q2RPJc78CucvCN4aQn/VprBon3cP7IoZ2P8Rs4QsvHfha6Q913xF7TdUI9mV+bHA6y
	 Z7VZK5qPjQ0NeLpxmJI1dcAXB41iv6stAwkLhPrk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABFTjpb082152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 09:29:45 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 09:29:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 09:29:44 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABFTblN018163;
	Mon, 11 Nov 2024 09:29:38 -0600
Message-ID: <de5b3499-7694-4f94-a1b9-2e926d2c2490@ti.com>
Date: Mon, 11 Nov 2024 20:59:36 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: Roger Quadros <rogerq@kernel.org>, Meghana Malladi <m-malladi@ti.com>,
        <vigneshr@ti.com>, <m-karicheri2@ti.com>, <jan.kiszka@siemens.com>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <horms@kernel.org>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <danishanwar@ti.com>
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-2-m-malladi@ti.com>
 <ad2afaa3-7e76-47e8-943b-7bea0c02c9c0@kernel.org>
 <0c6a3091-3b3d-4f41-83df-2183171200c8@ti.com>
 <17390fbf-7505-4e0a-8496-a6a4b22a261b@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <17390fbf-7505-4e0a-8496-a6a4b22a261b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/11/2024 7:55 PM, Roger Quadros wrote:
> 
> 
> On 11/11/2024 15:35, Anwar, Md Danish wrote:
>>
>>
>> On 11/11/2024 6:33 PM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 06/11/2024 09:40, Meghana Malladi wrote:
>>>> From: MD Danish Anwar <danishanwar@ti.com>
>>>>
>>>> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
>>>> and SLICE1. Currently whenever any ICSSG interface comes up we load the
>>>> respective firmwares to PRU cores and whenever interface goes down, we
>>>> stop the respective cores. Due to this, when SLICE0 goes down while
>>>> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
>>>> stopped. This results in clock jump for SLICE1 interface as the timesync
>>>> related operations are no longer running.
>>>>
>>>> Fix this by running both PRU0 and PRU1 firmwares as long as at least 1
>>>> ICSSG interface is up.
>>>>
>>>> rx_flow_id is updated before firmware is loaded. Once firmware is loaded,
>>>> it reads the flow_id and uses it for rx. emac_fdb_flow_id_updated() is
>>>> used to let firmware know that the flow_id has been updated and to use the
>>>> latest rx_flow_id.
>>>
>>> is rx_flow_id releated to timesync releated issue that this patch is fixing?
>>> If not please split it into separate patch and mention what functionality
>>> it is fixing.
>>>
>>
>> Roger, rx_flow_id is not related to timesync. However loading both
>> SLICE0 and SLICE1 firmware together results in wrong rx_flow_id used by
>> firmware for the interface that is brought later.
>>
>> When eth0 (SLICE0) is brought up, it's flow_id is obtained from dma and
>> written to SMEM. Slice0 and Slice1 both firmwares are loaded. Firmware
>> reads the flow_id from SMEM and uses it for RX.
>>
>> Second interface eth1 (SLICE1) comes up, it's flow id is obtained from
>> dma and written to SMEM. However firmware doesn't read the flow ID
>> again. It only reads it once when loaded and uses that through out. The
>> flow id for this interface remains 0 and that results in RX being broken.
>>
>> To fix this, emac_fdb_flow_id_updated() is added which will let firmware
>> know that we have updated the flow_id and use the latest one.
>>
>> This not related to timesync instead related to the fix of timesync
>> issue. Breaking this into separate patch will result in RX (ICSSG) being
>> broken at the former patch.
>>
>> In order to avoid feature breakage at the former patch, the change
>> related to flow_id update is kept in the same patch.
> 
> But setting the Flow ID should be taken care by icssg_config() which is
> done in prueth_emac_start()?
> 

Correct. But prueth_emac_start() is called once for both the slices.
When eth0 comes up prueth_emac_start() will be called for both slice0
and slice1. When eth1 comes up prueth_emac_start() will not get called.

In icssg_config() we write
`writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);`

By default emac->rx_flow_id_base = 0, it is populated during
prueth_init_rx_chns() which is called per port / slice. So the second
port's actual flow_id will be discarded without the
emac_fdb_flow_id_updated() API.

> is it really OK to provide wrong flow id to the Firmware or even start
> the second PRU core without DMA/IRQ resources allocated to it?
> 

It is ok as firmware doesn't transmit any packets until driver issues
ICSSG_EMAC_PORT_FORWARD command which is done during link up / down in
emac_adjust_link() so it would be okay for firmware to have wrong flow
id as we only issue ICSSG_EMAC_PORT_FORWARD after link is detected and
flow id is updated.

> I will suggest to introduce emac_ndo_common_open() and emac_ndo_common_stop()
> and move the common code there i.e. allocating/freeing resources for both
> cores and starting/stopping both cores.
> 

I don't think that will help much. There are certain things that need to
be done only once for both ports where as certain things needs to be
done on a per port basis. In order for driver to work it has to follow a
proper sequence in which first few common APIs are called then
individual APIs and then again common APIs. I think trying to
consolidate all common within a function will result in this sequence
getting not followed properly.

The fairly simple way is to put all common code inside `if
(!prueth->emacs_initialized)` where as keep all the individual port code
without any condition.

>>
>> If you think having the feature broken is OK, the patch can be splitted.
>> However IMO, these chanegs should be together in one patch.
>>
>>>>
>>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>>> ---
>>>>  drivers/net/ethernet/ti/icssg/icssg_config.c | 28 ++++++++++
>>>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  1 +
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 58 ++++++++++++++++----
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>>>>  4 files changed, 77 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> index 5d2491c2943a..f1f0c8659e2d 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>>> @@ -786,3 +786,31 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
>>>>  		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(icssg_set_pvid);
>>>> +
>>>> +int emac_fdb_flow_id_updated(struct prueth_emac *emac)
>>>> +{
>>>> +	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
>>>> +	int slice = prueth_emac_slice(emac);
>>>> +	struct mgmt_cmd fdb_cmd = { 0 };
>>>> +	int ret = 0;
>>>> +
>>>> +	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
>>>> +	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
>>>> +	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
>>>> +	fdb_cmd.param  = 0;
>>>> +
>>>> +	fdb_cmd.param |= (slice << 4);
>>>> +	fdb_cmd.cmd_args[0] = 0;
>>>> +
>>>> +	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
>>>> +
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
>>>> +	if (fdb_cmd_rsp.status == 1)
>>>> +		return 0;
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(emac_fdb_flow_id_updated);
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> index 92c2deaa3068..c884e9fa099e 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>>> @@ -55,6 +55,7 @@ struct icssg_rxq_ctx {
>>>>  #define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
>>>>  #define ICSSG_FW_MGMT_CMD_TYPE		0x04
>>>>  #define ICSSG_FW_MGMT_PKT		0x80000000
>>>> +#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW	0x05
>>>>  
>>>>  struct icssg_r30_cmd {
>>>>  	u32 cmd[4];
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> index 0556910938fa..9df67539285b 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> @@ -534,6 +534,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>>>  {
>>>>  	struct prueth_emac *emac = netdev_priv(ndev);
>>>>  	int ret, i, num_data_chn = emac->tx_ch_num;
>>>> +	struct icssg_flow_cfg __iomem *flow_cfg;
>>>>  	struct prueth *prueth = emac->prueth;
>>>>  	int slice = prueth_emac_slice(emac);
>>>>  	struct device *dev = prueth->dev;
>>>> @@ -549,8 +550,12 @@ static int emac_ndo_open(struct net_device *ndev)
>>>>  	/* set h/w MAC as user might have re-configured */
>>>>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>>>>  
>>>> +	if (!prueth->emacs_initialized) {
>>>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
>>>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
>>>> +	}
>>>> +
>>>>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>> -	icssg_class_default(prueth->miig_rt, slice, 0, false);
>>>>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>>  
>>>>  	/* Notify the stack of the actual queue counts. */
>>>> @@ -588,10 +593,31 @@ static int emac_ndo_open(struct net_device *ndev)
>>>>  		goto cleanup_napi;
>>>>  	}
>>>>  
>>>> -	/* reset and start PRU firmware */
>>>> -	ret = prueth_emac_start(prueth, emac);
>>>> -	if (ret)
>>>> -		goto free_rx_irq;
>>>> +	if (!prueth->emacs_initialized) {
>>>> +		if (prueth->emac[ICSS_SLICE0]) {
>>>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE0]);
>>>> +			if (ret) {
>>>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE0);
>>>> +				goto free_rx_irq;
>>>> +			}
>>>> +		}
>>>> +		if (prueth->emac[ICSS_SLICE1]) {
>>>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE1]);
>>>> +			if (ret) {
>>>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE1);
>>>> +				goto halt_slice0_prus;
>>>> +			}
>>>
>>> Did I understand right: SLICE0 needs to be always running if any of the
>>> interface is up but SLICE0 doesn't need to be running if only SLICE0
>>
>> I think you meant `but SLICE1 doesn't need to be running if only SLICE0`
>>
>>> interface is running.
>>>
>>> If yes then you need to update the patch so SLICE1 is not always running.
>>>
>>
>> For Timesync - YES. Only slice0 is needed to be always running. However
>> these both firmwares have some more inter dependencies, timesync is just
>> one of them. As a result, firmware team has recommended to keep both
>> Slice0 and Slice1 firmware running as long as at least one ICSSG
>> interface is up. Stop both firmware only if no ICSSG interface is up.
>>
>> I think the commit message can be modified to state that the dependecy
>> is not only SLICE0 but on SLICE1 as well and they both need to be running.
>>
> 
> OK Please mention this in commit log.
> 
>>>> +		}
>>>> +	}
>>>> +
>>>> +	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
>>>> +	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
>>>> +	ret = emac_fdb_flow_id_updated(emac);
>>>> +
>>>> +	if (ret) {
>>>> +		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
>>>> +		goto stop;
>>>> +	}
>>>>  
>>>>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>>>>  
>>>> @@ -644,7 +670,11 @@ static int emac_ndo_open(struct net_device *ndev)
>>>>  free_tx_ts_irq:
>>>>  	free_irq(emac->tx_ts_irq, emac);
>>>>  stop:
>>>> -	prueth_emac_stop(emac);
>>>> +	if (prueth->emac[ICSS_SLICE1])
>>>> +		prueth_emac_stop(prueth->emac[ICSS_SLICE1]);
>>>> +halt_slice0_prus:
>>>> +	if (prueth->emac[ICSS_SLICE0])
>>>> +		prueth_emac_stop(prueth->emac[ICSS_SLICE0]);
>>>>  free_rx_irq:
>>>>  	free_irq(emac->rx_chns.irq[rx_flow], emac);
>>>>  cleanup_napi:
>>>> @@ -680,7 +710,10 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>>  	if (ndev->phydev)
>>>>  		phy_stop(ndev->phydev);
>>>>  
>>>> -	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>>>> +	if (prueth->emacs_initialized == 1) {
>>>> +		icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
>>>> +		icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
>>>> +	}
>>>>  
>>>>  	if (emac->prueth->is_hsr_offload_mode)
>>>>  		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
>>>> @@ -719,11 +752,14 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>>  	/* Destroying the queued work in ndo_stop() */
>>>>  	cancel_delayed_work_sync(&emac->stats_work);
>>>>  
>>>> -	if (prueth->emacs_initialized == 1)
>>>> +	if (prueth->emacs_initialized == 1) {
>>>>  		icss_iep_exit(emac->iep);
>>>> -
>>>> -	/* stop PRUs */
>>>> -	prueth_emac_stop(emac);
>>>> +		/* stop PRUs */
>>>> +		if (prueth->emac[ICSS_SLICE0])
>>>> +			prueth_emac_stop(prueth->emac[ICSS_SLICE0]);
>>>> +		if (prueth->emac[ICSS_SLICE1])
>>>> +			prueth_emac_stop(prueth->emac[ICSS_SLICE1]);
>>>> +	}
>>>>  
>>>>  	free_irq(emac->tx_ts_irq, emac);
>>>>  
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> index 8722bb4a268a..c4f5f0349ae7 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>>> @@ -365,6 +365,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
>>>>  		       u8 untag_mask, bool add);
>>>>  u16 icssg_get_pvid(struct prueth_emac *emac);
>>>>  void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>>>> +int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>>>>  #define prueth_napi_to_tx_chn(pnapi) \
>>>>  	container_of(pnapi, struct prueth_tx_chn, napi_tx)
>>>>  
>>>
>>
> 

-- 
Thanks and Regards,
Md Danish Anwar


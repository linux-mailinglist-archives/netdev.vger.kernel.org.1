Return-Path: <netdev+bounces-143721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A79C3DC8
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77481C2189D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93BC18BBA8;
	Mon, 11 Nov 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="waGp0b5+"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EE18A6C2;
	Mon, 11 Nov 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326051; cv=none; b=FjjXztx+QW42gE5pMYaMuHdgDxPv2L8gr9iGI0KgGmGnhIq8uRW/DX68TbFdjGYR3QUItttSN3IBhVV2hauoStjXTO/9RLPRCdpYoDq5+NNXhf2Z0y3dH3H4iGYlMg7qgm3yB+m9W4zs6qlq11cck1EvSPv8TMKdq02bFsGcuL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326051; c=relaxed/simple;
	bh=BMB7rrVMA5etCIU0o/7ur3ujEMLysqRk5+jjFjoyFfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ga5wZVINxr89LwhvbwSeUD8Ft3tUrG3ZN1GF0CCaygfwSN5RI2uFeHuRV6/dB93zT8AIvTeCEZfUnbWe9KjYxh97dI4YDoCCL/GQgtfXyw69CT3PCI9TjOxiEY/lOXIg1xotMH8p+K/XhZrMXA3A9e5Brxa15w7UmU/dbgwVHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=waGp0b5+; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABBrosx2498289
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 05:53:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731326030;
	bh=ZgYilRS3+fXEklYEgYiYwwxkuzYogqpLeaAN+pnNcuE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=waGp0b5+pByg3V3Pb9thQH/Dyzi7sNqiXvjgYR2bILZGyNGrE25cDlFP6+Fb5oFaj
	 goxxOtQJo18IAQFpTY48ER22ivhUWki2fzcjFZxK6BBdB/VdwwX3FNc05nlknxNvVD
	 BY4CdJBgo21Im8SkP2q0GwItF1s4KL2CHMNTTVQI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABBroTb010807
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 05:53:50 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 05:53:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 05:53:50 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABBrin4029503;
	Mon, 11 Nov 2024 05:53:45 -0600
Message-ID: <cb39d07b-ad4b-4e87-bba4-daf77b583659@ti.com>
Date: Mon, 11 Nov 2024 17:23:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: Simon Horman <horms@kernel.org>
CC: <vigneshr@ti.com>, <m-karicheri2@ti.com>, <jan.kiszka@siemens.com>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-2-m-malladi@ti.com>
 <20241108133044.GB4507@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20241108133044.GB4507@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 08/11/24 19:00, Simon Horman wrote:
> On Wed, Nov 06, 2024 at 01:10:39PM +0530, Meghana Malladi wrote:
>> From: MD Danish Anwar <danishanwar@ti.com>
>>
>> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
>> and SLICE1. Currently whenever any ICSSG interface comes up we load the
>> respective firmwares to PRU cores and whenever interface goes down, we
>> stop the respective cores. Due to this, when SLICE0 goes down while
>> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
>> stopped. This results in clock jump for SLICE1 interface as the timesync
>> related operations are no longer running.
>>
>> Fix this by running both PRU0 and PRU1 firmwares as long as at least 1
>> ICSSG interface is up.
>>
>> rx_flow_id is updated before firmware is loaded. Once firmware is loaded,
>> it reads the flow_id and uses it for rx. emac_fdb_flow_id_updated() is
>> used to let firmware know that the flow_id has been updated and to use the
>> latest rx_flow_id.
>>
>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 0556910938fa..9df67539285b 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -534,6 +534,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>   {
>>   	struct prueth_emac *emac = netdev_priv(ndev);
>>   	int ret, i, num_data_chn = emac->tx_ch_num;
>> +	struct icssg_flow_cfg __iomem *flow_cfg;
>>   	struct prueth *prueth = emac->prueth;
>>   	int slice = prueth_emac_slice(emac);
>>   	struct device *dev = prueth->dev;
>> @@ -549,8 +550,12 @@ static int emac_ndo_open(struct net_device *ndev)
>>   	/* set h/w MAC as user might have re-configured */
>>   	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>>   
>> +	if (!prueth->emacs_initialized) {
>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
>> +	}
>> +
>>   	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>> -	icssg_class_default(prueth->miig_rt, slice, 0, false);
>>   	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>   
>>   	/* Notify the stack of the actual queue counts. */
>> @@ -588,10 +593,31 @@ static int emac_ndo_open(struct net_device *ndev)
>>   		goto cleanup_napi;
>>   	}
>>   
>> -	/* reset and start PRU firmware */
>> -	ret = prueth_emac_start(prueth, emac);
>> -	if (ret)
>> -		goto free_rx_irq;
>> +	if (!prueth->emacs_initialized) {
>> +		if (prueth->emac[ICSS_SLICE0]) {
>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE0]);
> 
> I wonder if it is worth simplifying this by having prueth_emac_start()
> check if it's 2nd parameter is NULL. Likewise for prueth_emac_stop().
> 
Yes right, I will update this.
>> +			if (ret) {
>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE0);
>> +				goto free_rx_irq;
>> +			}
>> +		}
>> +		if (prueth->emac[ICSS_SLICE1]) {
>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE1]);
>> +			if (ret) {
>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE1);
>> +				goto halt_slice0_prus;
>> +			}
>> +		}
>> +	}
>> +
>> +	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
>> +	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
>> +	ret = emac_fdb_flow_id_updated(emac);
>> +
>> +	if (ret) {
>> +		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
>> +		goto stop;
> 
> Branching to stop may result in calls to prueth_emac_stop() which does not
> seem symmetrical with the condition on prueth->emacs_initialized for calls
> to prueth_emac_start() above.
> 
> If so, is this intended?
> 
Yes this is intended. This change is made to run all the cores during 
init and in case of any failure, stop all the cores. And even if one 
interface is up, all the cores should run.
>> +	}
>>   
>>   	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>>   
> 
> ...


Return-Path: <netdev+bounces-124974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4096B782
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E337B20B0C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF81CEE86;
	Wed,  4 Sep 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H0oQ2+ni"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEC1CCEE3;
	Wed,  4 Sep 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443794; cv=none; b=PCUL6Sxu6yq0iGA3pyDUQPNKSFMIWUQoIsZXpDv6I92coTkXn43cdi5/M0o7JNIrrNVgwkSXY3IgTcWC81yLb+rIFUHhDWPLVoCwaasIA5Dn73uc6dUr8oL0ObCXDyvG6M0Kdw5pvHo3zRpEugDL8RUWfKgUDnum7Ydauu8Ufps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443794; c=relaxed/simple;
	bh=b+VG+y8/EeELaj+DVH73S5jqCe4g2c1FGRO/OQSnkBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sekq9/DEVvV6QhweCeO5DJHj9WCn6I3GeF/939cxfRlLoY8ZqGo/fHtdTCpNr1GFf/wsgkUEh+KZr6NyZWa9KIbd6mya43fRVV1CON2DLY10llBIDi/28v3jiRKwpKOUpaHoFC4Ze/0dsNIpZYQPhYgfQMR8nLh+bDfcPupDUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H0oQ2+ni; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4849t4gR015914;
	Wed, 4 Sep 2024 04:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725443704;
	bh=leQqt0S+BZ+0AYSKerK6oNOErEuBl/fdVJ+s3xmPtZY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H0oQ2+niyv12xQo3I/wmT4r6MDzVFhx+CaqwNTEj4wJBkqH71MUw1T3dklu5VNJ93
	 rUo7dksI772ovMz87eF2gWlIWlSJNBSvxNdKnSfN2np0bblv/akpoC6Xb1iUGq5qM0
	 hZfZkx0Kkt0ZBREn4Wdp2jOnyMlgSEg7j/YwAO14=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4849t4mO005543;
	Wed, 4 Sep 2024 04:55:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 04:55:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 04:55:03 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4849swTp061080;
	Wed, 4 Sep 2024 04:54:59 -0500
Message-ID: <69cb37ae-0f38-487d-bb16-a3709353fc09@ti.com>
Date: Wed, 4 Sep 2024 15:24:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
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
 Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
 <728d4ad3-bd32-4bbe-bbd1-cd2c62df1fad@intel.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <728d4ad3-bd32-4bbe-bbd1-cd2c62df1fad@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Alexander

On 30/08/24 7:37 pm, Alexander Lobakin wrote:
> From: Md Danish Anwar <danishanwar@ti.com>
> Date: Wed, 28 Aug 2024 14:48:58 +0530
> 
>> Add support for offloading HSR port-to-port frame forward to hardware.
>> When the slave interfaces are added to the HSR interface, the PRU cores
>> will be stopped and ICSSG HSR firmwares will be loaded to them.
>>
>> Similarly, when HSR interface is deleted, the PRU cores will be stopped
>> and dual EMAC firmware will be loaded to them.
>>
>> This commit also renames some APIs that are common between switch and
>> hsr mode with '_fw_offload' suffix.
> 
> [...]
> 
>> @@ -726,6 +744,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
>>  	queue_work(emac->cmd_wq, &emac->rx_mode_work);
>>  }
>>  
>> +static int emac_ndo_set_features(struct net_device *ndev,
>> +				 netdev_features_t features)
>> +{
>> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> 
> Maybe you could give this definition and/or this variable shorter names,
> so that you won't cross 80 cols?
> 

I will use Roger's feedback here [1] and modify this API. This will
contain this line within 80 cols.

I will  try to containig line length within 80 cols wherever possible.
There are however some instances where line length of 80 cols is not
possible. There the line length will exceed.

>> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> 
> (same)
> 
>> +	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);
> 
> You don't need to compare with zero. Just = a ^ b. Type `bool` takes
> care of this.
> 

Sure.

>> +
>> +	if (hsr_change_request)
>> +		ndev->features = features;
> 
> Does it mean you reject any feature change except HSR?
> 

Currently only HSR features are supported. So we will modify
ndev->features only for HSR features request. For any other feature
request ndev->features will not be modified.

>> +
>> +	return 0;
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
> 
> Why not HSR_OFFLOAD right away, so that you wouldn't need to replace
> this line with the mentioned def a commit later?
> 

Sure Will do that.

>>  
>>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
> 
> [...]
> 
>> +	prueth->hsr_members |= BIT(emac->port_id);
>> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
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
> 
> netdev_dbg()?
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
>> +		dev_dbg(prueth->dev, "Enabling Dual EMAC mode\n");
> 
> (same here and in all the places below)
> 

Sure will use netdev_dbg instead of dev_dbg.

>> +	}
>> +}
> 
> Thanks,
> Olek


[1]
https://lore.kernel.org/all/22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org/

-- 
Thanks and Regards,
Danish


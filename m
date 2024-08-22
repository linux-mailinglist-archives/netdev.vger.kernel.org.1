Return-Path: <netdev+bounces-120812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE195AD1A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C661C21788
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE3E7581D;
	Thu, 22 Aug 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LiNx0AQE"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A614F98;
	Thu, 22 Aug 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306235; cv=none; b=QR9MfxdsXptokdOWX5/hwSfjJ/PCOZcEiFRVmWkwzEr1sWjBmSusfQVhKh/pbhJvMR41bgY5P3KG8uzaJyOVTx/aVWrfjIzjfJPmzkLMkkeQlBMP2w69/Jjcc4GReccod43p7JWTVm7GwE/JPSiLSp9VAjsNn9XREK1myF9Hs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306235; c=relaxed/simple;
	bh=Qv/FIG4tECBbGOVhaiFcD/vclJuvfVYKTVvZXXEkz5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MbPVgZuXCaewDQKOOBs9NTTUsY60RSSWR+8ox1oijRvg5EljNBZoFwXFleAmNMPPMP+QCXh6NZX9s4IEfwtplf+HaIK3pA8ucnO+ZDFf53Dv6eu8uxdxH9/QLV5d2ciKHnlJRAEmnxkzLogvn6BB76Ftvp2GKJ8maAPoBO7zt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LiNx0AQE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5utJr098589;
	Thu, 22 Aug 2024 00:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724306215;
	bh=TuRNmcBKxnCIB7jBUuUSZF9+fWiW8nFGT+64IFkt8RQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LiNx0AQERHZqfpjPVyU1BjaoKb8cCBbWQl9Vi1kycC8MYnwWC/njF1QzVHxQUcxGd
	 cyq+pAjpfOC612Oxv+uQ4mGYzN1eDaVEd0AbiNlElrfep7dFWVad1fdiHKXQ9UZsJl
	 xZEgJ0R3a9ZUbIZP4G/9CySfenm1YnpMzuLwW2K0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5utvc014013
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:56:55 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:56:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:56:55 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5unfZ063464;
	Thu, 22 Aug 2024 00:56:50 -0500
Message-ID: <ac6e47f1-5d60-4fc2-8138-5cddc17f0c4c@ti.com>
Date: Thu, 22 Aug 2024 11:26:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: ti: icssg-prueth: Add multicast
 filtering support in HSR mode
To: Roger Quadros <rogerq@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Jan Kiszka
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
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-7-danishanwar@ti.com>
 <aa3d740f-403e-4bd3-a74a-d077b163dbdd@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <aa3d740f-403e-4bd3-a74a-d077b163dbdd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 21/08/24 5:40 pm, Roger Quadros wrote:
> 
> 
> On 13/08/2024 10:42, MD Danish Anwar wrote:
>> Add support for multicast filtering in HSR mode
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 38 +++++++++++++++++++-
>>  1 file changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index b32a2bff34dc..521e9f914459 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -490,6 +490,36 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>>  	return 0;
>>  }
>>  
>> +static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>> +
>> +	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
>> +			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_BLOCK, true);
>> +
>> +	icssg_vtbl_modify(emac, emac->port_vlan, BIT(emac->port_id),
>> +			  BIT(emac->port_id), true);
>> +	return 0;
>> +}
>> +
>> +static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>> +
>> +	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
>> +			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
>> +			  ICSSG_FDB_ENTRY_BLOCK, false);
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * emac_ndo_open - EMAC device open
>>   * @ndev: network adapter device
>> @@ -651,6 +681,7 @@ static int emac_ndo_stop(struct net_device *ndev)
>>  	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>>  
>>  	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
> 
> Above unsync call will already remove all MC addresses so nothing
> is left to unsync in the below unsync call.
>> +	__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
> 
> Do you have to use an if/else like you do while calling __dev_mc_sync?
> 

Yes Roger, we will need and if/else here and remove MC addresses based
on the current mode.

if (emac->prueth->is_hsr_offload_mode)
	__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
else
	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);

I will make this change and update the series.

>>  
>>  	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
>>  	/* ensure new tdown_cnt value is visible */
>> @@ -728,7 +759,12 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> -	__dev_mc_sync(ndev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>> +	if (emac->prueth->is_hsr_offload_mode)
>> +		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
>> +			      icssg_prueth_hsr_del_mcast);
>> +	else
>> +		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
>> +			      icssg_prueth_del_mcast);
>>  }
>>  
>>  /**
> 

-- 
Thanks and Regards,
Danish


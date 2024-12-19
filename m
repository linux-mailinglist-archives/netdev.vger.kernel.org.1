Return-Path: <netdev+bounces-153276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D99F783E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C1516607A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372C221DAC;
	Thu, 19 Dec 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lhlr1qX/"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BE221DB2;
	Thu, 19 Dec 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734600037; cv=none; b=AJLvcL5BZoXjAH/M8B2IEf4jCrfZIZ9LzFaEeoo/pfemjVAJwYRX7GhjvcPH+aVNdFYzB18fHeQ5OcT7IPHLcicVI+vwI9nxxfXDVKIytMBEgOOX583ocj+tmoP+8MqW3/2oaNahrYoKzmd/P1ST4MDmpvjbo5v291V48wRTyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734600037; c=relaxed/simple;
	bh=HyJr5XSGfYNWutYETgmFhaqaRhsBMTcVmrrtrJCA6lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPSJdI+biTtI8FBKSRTBEbXCKJ9ERNg6G8uH/z4jTVkadNm8zvl0/EkyFJbEwP6CDy0/RSv1jFZ6iRhbkThrUyCltabB5/VtBX56hrDoHXFhn+73p00NymQ4RAQmQHN4hg4DhPF8a8hiQ4wv6LBeofnS8UH774MF0+BdW1m20t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lhlr1qX/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ9K3ce048749;
	Thu, 19 Dec 2024 03:20:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734600003;
	bh=gsnH79CaQlp66NWw62f+jHDtlXUygpjnPNoSMN2nv0A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Lhlr1qX/N2FQtNADzobSMU+l/B3Y3Py9OZRf7FtwVDYsmtTA+WuPxrFZrf51irXOI
	 vZGIRKTJ76aggF38GfC+n9FaeY8ZKuAkr+XTLnAHX6i4trwoymgSl940ntHRaJsez7
	 xzpJB2GAz96fN0JICjCat3c82zEYE4PKO5e8MIuc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ9K2jD002828
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Dec 2024 03:20:02 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 03:20:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 03:20:01 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ9JtfB023256;
	Thu, 19 Dec 2024 03:19:56 -0600
Message-ID: <06886be4-5f35-4785-bc63-a5c84887adfb@ti.com>
Date: Thu, 19 Dec 2024 14:49:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: ti: icssg-prueth: Add VLAN support in
 EMAC mode
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
 <20241216100044.577489-3-danishanwar@ti.com>
 <Z2PE5m8R5lM4/YRT@mev-dev.igk.intel.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <Z2PE5m8R5lM4/YRT@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 19/12/24 12:32 pm, Michal Swiatkowski wrote:
> On Mon, Dec 16, 2024 at 03:30:42PM +0530, MD Danish Anwar wrote:
>> Add support for vlan filtering in dual EMAC mode.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 29 +++++++++-----------
>>  1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index c568c84a032b..e031bccf31dc 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -822,19 +822,18 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
>>  {
>>  	struct prueth_emac *emac = netdev_priv(ndev);
>>  	struct prueth *prueth = emac->prueth;
>> +	int port_mask = BIT(emac->port_id);
>>  	int untag_mask = 0;
>> -	int port_mask;
>>  
>> -	if (prueth->is_hsr_offload_mode) {
>> -		port_mask = BIT(PRUETH_PORT_HOST) | BIT(emac->port_id);
>> -		untag_mask = 0;
>> +	if (prueth->is_hsr_offload_mode)
>> +		port_mask |= BIT(PRUETH_PORT_HOST);
>>  
>> -		netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
>> -			   vid, port_mask, untag_mask);
>> +	netdev_err(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
>> +		   vid, port_mask, untag_mask);
>> +
>> +	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
>> +	icssg_set_pvid(emac->prueth, vid, emac->port_id);
>>  
>> -		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
>> -		icssg_set_pvid(emac->prueth, vid, emac->port_id);
>> -	}
>>  	return 0;
>>  }
>>  
>> @@ -843,18 +842,16 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
>>  {
>>  	struct prueth_emac *emac = netdev_priv(ndev);
>>  	struct prueth *prueth = emac->prueth;
>> +	int port_mask = BIT(emac->port_id);
>>  	int untag_mask = 0;
>> -	int port_mask;
>>  
>> -	if (prueth->is_hsr_offload_mode) {
>> +	if (prueth->is_hsr_offload_mode)
>>  		port_mask = BIT(PRUETH_PORT_HOST);
>> -		untag_mask = 0;
>>  
>> -		netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
>> -			   vid, port_mask, untag_mask);
>> +	netdev_err(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
>> +		   vid, port_mask, untag_mask);
> Why error? It doesn't look like error path, previously there was
> netdev_dbg (made more sense in my opinion)
> 

My bad. It should be netdev_dbg(). I'll change it in v2. Thanks

>> +	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
>>  
>> -		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
>> -	}
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.34.1

-- 
Thanks and Regards,
Danish


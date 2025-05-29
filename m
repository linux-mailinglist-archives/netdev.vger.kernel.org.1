Return-Path: <netdev+bounces-194207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494DAAC7DAC
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38D59E1561
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667222425D;
	Thu, 29 May 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XWTLZMYW"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51747223DFB;
	Thu, 29 May 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521446; cv=none; b=dQkPRssb5e3nDYx3Pr/mEer+OAMh+4TCxvZzrFIEKUuFGjmiAO9BL1aPRovnC3f3fNLwHC02OoERAB7ahyWKo7wYSfOPyrTMaLBClDGzWC0r0IaaRTx/+RG7vZ25+1kYWb3X6p+b0a9qX2MXdLGMhVwz9veGr4DH6RVlgAiY9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521446; c=relaxed/simple;
	bh=aL7PDHsdbl98Zwe5JrbfOa0jfngJ16F8YNA8swE/f/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFGWldn83g0Pw3UlRFQXAU3dw3jTNCTduRIH7LcYP8GuA0Gtj+EHzwKTVmttI6i+vq0bfbWla+yJq5QS53OtVQk+2CdA0zBxZYQjXfOCPw4nN6sME5mthBRTyM2d8BJlyTOUHEWfLnEAxXycgBrVVLICA4lF5bzc1XPfqfiKguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XWTLZMYW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54TCNmcb3516960;
	Thu, 29 May 2025 07:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748521428;
	bh=t6cER3ficNDF4FhcfcYO1N7q4wJKI5SWkwqRzuLuAeM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XWTLZMYWWFxT/mYUd2ZX48f7/r7RmX7tip+47bt6JQcGFi1zglwp/Zh3ir8ayywkP
	 GpE/ARyRWvCj0LePc/WpKJ0+gi+Ww6G4+F3KN5KhtUFYZqqu6nw0DqrjdvPOPc5uk9
	 V/1fbn/XThiX3Qe6G39d0mvrWcEvsQodZSCja+7w=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54TCNm7c2164812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 29 May 2025 07:23:48 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 May 2025 07:23:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 May 2025 07:23:48 -0500
Received: from [172.24.18.242] (lt9560gk3.dhcp.ti.com [172.24.18.242])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54TCNhtB1577009;
	Thu, 29 May 2025 07:23:44 -0500
Message-ID: <c9cd4687-0959-4e1f-8a44-a34b74da43a7@ti.com>
Date: Thu, 29 May 2025 17:53:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix swapped TX stats for MII
 interfaces.
To: Simon Horman <horms@kernel.org>
CC: <saikrishnag@marvell.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250527121325.479334-1-m-malladi@ti.com>
 <20250528161250.GE1484967@horms.kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <20250528161250.GE1484967@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Simon,

On 5/28/2025 9:42 PM, Simon Horman wrote:
> On Tue, May 27, 2025 at 05:43:25PM +0530, Meghana Malladi wrote:
>> In MII mode, Tx lines are swapped for port0 and port1, which means
>> Tx port0 receives data from PRU1 and the Tx port1 receives data from
>> PRU0. This is an expected hardware behavior and reading the Tx stats
>> needs to be handled accordingly in the driver. Update the driver to
>> read Tx stats from the PRU1 for port0 and PRU0 for port1.
>>
>> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icssg_stats.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> index 6f0edae38ea2..0b77930b2f08 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
>> @@ -29,6 +29,10 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>>   	spin_lock(&prueth->stats_lock);
>>   
>>   	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
> 
> Hi Meghana,
> 
> Perhaps it would be nice to include a comment here.
> 

That makes sense, sure will do that.

>> +		if (emac->phy_if == PHY_INTERFACE_MODE_MII &&
>> +		    icssg_all_miig_stats[i].offset >= ICSSG_TX_PACKET_OFFSET &&
>> +		    icssg_all_miig_stats[i].offset <= ICSSG_TX_BYTE_OFFSET)
>> +			base = stats_base[slice ^ 1];
>>   		regmap_read(prueth->miig_rt,
>>   			    base + icssg_all_miig_stats[i].offset,
>>   			    &val);
>>
>> base-commit: 32374234ab0101881e7d0c6a8ef7ebce566c46c9
>> -- 
>> 2.43.0
>>
>>

-- 
Thanks,
Meghana Malladi



Return-Path: <netdev+bounces-119631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46651956651
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7881B209D3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917715B999;
	Mon, 19 Aug 2024 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bUquSnXb"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7A15B560;
	Mon, 19 Aug 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058356; cv=none; b=uMd7OEZZSxjzP0TIPMLdyl2EzyffXN6WWyvm7V9yBllipBiMz980gtAf1Cq0LNPNseREDB/jftlfughOll+KYLZtmrP0YxQOl2VrqTkGnUyFuTzNPr9SSKq/cz8JlExd6leUj9MoXrDCLUhO2qJoK3rHAcPwtiL0dWi5B7KRYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058356; c=relaxed/simple;
	bh=lR2WZd/P0NWVFQpF5VOo611F5KnOE/Raog9Y5v8jRSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pwp0oCnxAI8jpIHgmdCyvJCp7Bu06ZeiFL+V8emg+U28VBrNr1CMunOBL8XJtbi5O6IehlzHuTrJXKksyN+Zch1D5suNd5lMcugA5p75VePuwv1oPkxFpZx56FOSwgMeZpTKa01vcCxAHRj4BWl0NQmFOVcESmAW3pbKqleOSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bUquSnXb; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J7FfIb014306;
	Mon, 19 Aug 2024 02:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724051741;
	bh=0vsrItiP+UOuGajC7NCZTlPPCFYcRA8XAnCYPGpz6CY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bUquSnXby+EIUCpW7ZzEe4Ar3hHMOjtdKafPUf7hARC5ZjzvIJT73k+Rlyqz+4eIc
	 mrjWcdP9ay9xONwaeGiMN0/96GxVUoMs+SkPhtY+O7gvOj73xKmUW2ZI274f8FA/tw
	 h4OSozP0aJ8YN33a2OvxkoyPZHyFlEpEGBaRZlp4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J7Ff7S013071
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 02:15:41 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 02:15:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 02:15:41 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J7FVGi056124;
	Mon, 19 Aug 2024 02:15:32 -0500
Message-ID: <2ee6f2eb-9a3f-4e04-a6d5-059c4381cbd8@ti.com>
Date: Mon, 19 Aug 2024 12:45:30 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: Dan Carpenter <dan.carpenter@linaro.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
CC: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Heiner
 Kallweit <hkallweit1@gmail.com>,
        Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roger Quadros
	<rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240814092033.2984734-1-danishanwar@ti.com>
 <20240814092033.2984734-3-danishanwar@ti.com>
 <cd15268f-f6d3-4fca-bd7f-c94011f55996@stanley.mountain>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <cd15268f-f6d3-4fca-bd7f-c94011f55996@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/15/2024 4:58 PM, Dan Carpenter wrote:
> On Wed, Aug 14, 2024 at 02:50:33PM +0530, MD Danish Anwar wrote:
>> Add support for dumping PA stats registers via ethtool.
>> Firmware maintained stats are stored at PA Stats registers.
>> Also modify emac_get_strings() API to use ethtool_puts().
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 17 +++++-----
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  5 ++-
>>  drivers/net/ethernet/ti/icssg/icssg_stats.c   | 19 +++++++++--
>>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 32 +++++++++++++++++++
>>  5 files changed, 67 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> index 5688f054cec5..51bb509d37c7 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
>> @@ -83,13 +83,11 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>>  
>>  	switch (stringset) {
>>  	case ETH_SS_STATS:
>> -		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
>> -			if (!icssg_all_stats[i].standard_stats) {
>> -				memcpy(p, icssg_all_stats[i].name,
>> -				       ETH_GSTRING_LEN);
>> -				p += ETH_GSTRING_LEN;
>> -			}
>> -		}
>> +		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
>> +			if (!icssg_all_stats[i].standard_stats)
>> +				ethtool_puts(&p, icssg_all_stats[i].name);
>> +		for (i = 0; i < ICSSG_NUM_PA_STATS; i++)
> 
> It would probably be better to use ARRAY_SIZE(icssg_all_pa_stats) so that it's
> consistent with the loop right before.

Sure Dan.

> 
>> +			ethtool_puts(&p, icssg_all_pa_stats[i].name);
>>  		break;
>>  	default:
>>  		break;
>> @@ -100,13 +98,16 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
>>  				   struct ethtool_stats *stats, u64 *data)
>>  {
>>  	struct prueth_emac *emac = netdev_priv(ndev);
>> -	int i;
>> +	int i, j;
>>  
>>  	emac_update_hardware_stats(emac);
>>  
>>  	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
>>  		if (!icssg_all_stats[i].standard_stats)
>>  			*(data++) = emac->stats[i];
>> +
>> +	for (j = 0; j < ICSSG_NUM_PA_STATS; j++)
>> +		*(data++) = emac->stats[i + j];
> 
> Here i is not an iterator.  It's a stand in for ARRAY_SIZE(icssg_all_stats).
> It would be more readable to do that directly.
> 
> 	for (i = 0; i < ICSSG_NUM_PA_STATS; i++)
> 		*(data++) = emac->stats[ARRAY_SIZE(icssg_all_stats) + i];
> 
> To be honest, putting the pa_stats at the end of ->stats would have made sense
> if we could have looped over the whole array, but since they have to be treated
> differently we should probably just put them into their own ->pa_stats array.
> 

Sure Dan. It will make more sense to have different array for pa_stats.
I will do this change and update.

> I haven't tested this so maybe I've missed something obvious.
> 
> The "all" in "icssg_all_stats" doesn't really make sense anymore btw...
> 

Correct, the "icssg_all_stats" should be renamed to "icssg_mii_g_rt_stats".

> Sorry for being so nit picky on a v5 patch. :(
> 

It's okay. Thanks for the review. I will address all these comments and
send out a v6.

> regards,
> dan carpenter
> 

-- 
Thanks and Regards,
Md Danish Anwar


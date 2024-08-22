Return-Path: <netdev+bounces-120808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102595ACDC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4342E1C225CD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 05:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356B55884;
	Thu, 22 Aug 2024 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fmv00iod"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BB36B11;
	Thu, 22 Aug 2024 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304528; cv=none; b=qYc79y/BaYacXUUgtbDRxNd20vCi5mbhKpg6tptNhL/gSoq/B4oY00pxTCk5pII19sar3u3/ngJN2OdtkHJvojRd4h4nH7qoi2WluAGXF4uIoXAobl5vEVjp6LAJ8S2ebZ0jV42uwm5Ge/sIq2ReZKEEwzj9Bo0kBzKvOAyAR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304528; c=relaxed/simple;
	bh=LjsVmZE/Ldhn8prY6yadpj5HWSrLvX4k/gMx1dazy48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jL6LlD9jQllPf2uXCWZROZgJdmM7lc823aSK1Y/gQuVZs5NqOEcV0wpwxGKN/mKJVuz5MYOqI0SgctuDV6jUjV1fTMtcsqR/pmDOxAlQmk+lGFurK8wjrtGqF7lr9+QvZEpXbvjTKEhcguxyeMQkAc1xP0e/1GOAAHzEzwcpV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fmv00iod; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5SOIk118943;
	Thu, 22 Aug 2024 00:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724304504;
	bh=UE4cJOuH5MHX8pNf1eCEqAASVsPMorLePVUImxNuZ2Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Fmv00iod0uKJGr5WzWMfNfMuCOwLT0b6Kx7If5RumNZWHxwc8zYN8+KW+Yw4nrkry
	 o/Xkcp4Qwf+b7eM1MritgTPKJxXFWmSzNuF7krA8qx0qh0p352lO5AP/3au29jSuR4
	 Pn2TWajJKWexTYHn400iOiYcEXAccnkIxfF2GpWk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5SOs8063192
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:28:24 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:28:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:28:24 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5SHdj050759;
	Thu, 22 Aug 2024 00:28:17 -0500
Message-ID: <79dfc7d2-d738-4899-aadf-a6b4df338c23@ti.com>
Date: Thu, 22 Aug 2024 10:58:16 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: Roger Quadros <rogerq@kernel.org>, Suman Anna <s-anna@ti.com>,
        Sai Krishna
	<saikrishnag@marvell.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent
	<kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>,
        Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
 <20240820091657.4068304-3-danishanwar@ti.com>
 <03172556-8661-4804-8a3b-0252d91fdf46@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <03172556-8661-4804-8a3b-0252d91fdf46@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 21/08/24 6:05 pm, Roger Quadros wrote:
> 
> 
> On 20/08/2024 12:16, MD Danish Anwar wrote:
>> Add support for dumping PA stats registers via ethtool.
>> Firmware maintained stats are stored at PA Stats registers.
>> Also modify emac_get_strings() API to use ethtool_puts().
>>
>> This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
>> and creates a new array named icssg_all_pa_stats for PA Stats.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---

[ ... ]

>> +
>>  #define ICSSG_STATS(field, stats_type)			\
>>  {							\
>>  	#field,						\
>> @@ -84,13 +98,24 @@ struct miig_stats_regs {
>>  	stats_type					\
>>  }
>>  
>> +#define ICSSG_PA_STATS(field)			\
>> +{						\
>> +	#field,					\
>> +	offsetof(struct pa_stats_regs, field),	\
>> +}
>> +
>>  struct icssg_stats {
> 
> icssg_mii_stats?
> 

Sure Roger. I will name it icssg_miig_stats to be consistent with
'struct miig_stats_regs'

>>  	char name[ETH_GSTRING_LEN];
>>  	u32 offset;
>>  	bool standard_stats;
>>  };
>>  
>> -static const struct icssg_stats icssg_all_stats[] = {
>> +struct icssg_pa_stats {
>> +	char name[ETH_GSTRING_LEN];
>> +	u32 offset;
>> +};
>> +
>> +static const struct icssg_stats icssg_mii_g_rt_stats[] = {
> 
> icssg_all_mii_stats? to be consistend with the newly added
> icssg_pa_stats and icssg_all_pa_stats.
> 
> Could you please group all mii_stats data strucutres and arrays together
> followed by pa_stats data structures and arrays?
> 

Sure Roger, I will group all mii stats related data structures and
pa_stats related data structures together.

The sequence and naming will be something like this,

struct miig_stats_regs
#define ICSSG_MIIG_STATS(field, stats_type)
struct icssg_miig_stats
static const struct icssg_miig_stats icssg_all_miig_stats[]

struct pa_stats_regs
#define ICSSG_PA_STATS(field)
struct icssg_pa_stats
static const struct icssg_pa_stats icssg_all_pa_stats[]

Let me know if this looks ok to you.

>>  	/* Rx */
>>  	ICSSG_STATS(rx_packets, true),
>>  	ICSSG_STATS(rx_broadcast_frames, false),
>> @@ -155,4 +180,11 @@ static const struct icssg_stats icssg_all_stats[] = {
>>  	ICSSG_STATS(tx_bytes, true),t
>>  };
>>  
>> +static const struct icssg_pa_stats icssg_all_pa_stats[] = > +	ICSSG_PA_STATS(fw_rx_cnt),
>> +	ICSSG_PA_STATS(fw_tx_cnt),
>> +	ICSSG_PA_STATS(fw_tx_pre_overflow),
>> +	ICSSG_PA_STATS(fw_tx_exp_overflow),
>> +};
>> +
>>  #endif /* __NET_TI_ICSSG_STATS_H */
> 

-- 
Thanks and Regards,
Danish


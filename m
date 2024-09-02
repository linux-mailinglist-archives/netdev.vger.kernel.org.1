Return-Path: <netdev+bounces-124100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6696809A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956221C220C8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDBD176ADE;
	Mon,  2 Sep 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X4F4WfbO"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3671547C3;
	Mon,  2 Sep 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262203; cv=none; b=n7K+TiaxGB4WfGMe1eHB067rc5bumdl06VJj4tBtjxxuuFhlVj0x8V4pLOISLnGvR9lMjVtcCOdKw9KPQ1KVdXs/jDHqadrepC85pkbNLFRF/vS/yjRUDoMVgpi/IWLwKO62MsLW2Ps3xwbwFyqJ+RPl45JH5um/Gs2Hu9YMDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262203; c=relaxed/simple;
	bh=ahIr6AVfOeYwJ3CqrBd4Y/eCtn9lh6QOChXCOWgN9mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HIEMXYTdhl1UiaIGZ/jrz5Cji9BaCRtYyZEZrfgu6JoWAIXiMwJ1oHIQnfrkIpK6PV3FHxDinRGPVDci3lvytsua1EMT+bvd3iVY18krMB6OVgb1YS8XJHdVNCKEAFvLIYt4FG/YVJyjt8nRvxbIV2YzeomHwZWJwqs990vRRJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X4F4WfbO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4827SDYV053359;
	Mon, 2 Sep 2024 02:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725262093;
	bh=eIUv/RODpMn5Qas3DCyob7qRkNVor37fxy/YVVVI9AI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X4F4WfbOFCXqENch9bUc9vtPc0Fi908kjducx+ZkPMlqFWj8Y/GFrf29AmWo/SV44
	 jTTqNPYjWfkTcWPuW71omaV/O+xz5iRs7DtRyJmFmxTTj8se6AaZ5cluf9U7OEp0Be
	 pPcJJGHS5DiO8qeLWulLVnvMhmpZv95r1wxblsPA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4827SDKv119403
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 02:28:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 02:28:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 02:28:13 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4827S45K091969;
	Mon, 2 Sep 2024 02:28:05 -0500
Message-ID: <e2333f3c-7481-446a-8293-6afac14a34a0@ti.com>
Date: Mon, 2 Sep 2024 12:58:04 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: Jan Kiszka <jan.kiszka@siemens.com>, MD Danish Anwar <danishanwar@ti.com>,
        Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Roger Quadros <rogerq@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240822122652.1071801-1-danishanwar@ti.com>
 <20240822122652.1071801-3-danishanwar@ti.com>
 <8cfcb7f7-1779-463a-9e77-e0e09234a35f@siemens.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <8cfcb7f7-1779-463a-9e77-e0e09234a35f@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 9/2/2024 12:52 PM, Jan Kiszka wrote:
> On 22.08.24 14:26, MD Danish Anwar wrote:
>> Add support for dumping PA stats registers via ethtool.
>> Firmware maintained stats are stored at PA Stats registers.
>> Also modify emac_get_strings() API to use ethtool_puts().
>>
>> This commit also maintains consistency between miig_stats and pa_stats by
>> - renaming the array icssg_all_stats to icssg_all_miig_stats
>> - renaming the structure icssg_stats to icssg_miig_stats
>> - renaming ICSSG_STATS() to ICSSG_MIIG_STATS()
>> - changing order of stats related data structures and arrays so that data
>>   structures of a certain stats type is clubbed together.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  19 ++-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   6 +
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +-
>>  drivers/net/ethernet/ti/icssg/icssg_stats.c   |  31 +++-
>>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 158 +++++++++++-------
>>  5 files changed, 140 insertions(+), 83 deletions(-)
>>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 53a3e44b99a2..f623a0f603fc 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1182,6 +1182,12 @@ static int prueth_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  	}
>>  
>> +	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
>> +	if (IS_ERR(prueth->pa_stats)) {
>> +		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
>> +		return -ENODEV;
> 
> I was just beaten for potentially not being backward compatible, but
> this is definitely not working with existing DTs, just ran into it.
> 

Jan, I had posted the DT patch needed for this [1]. But the DT patch
goes to different tree and it was dependent on binding patch of this
series. My intention was once the binding is in, I will post the DT
patch in the next window. Till then ICSSG driver will break here but
once DT gets merged it will be alright. If that's not the best solution,
I can post DT here, but it will need to get merged via net-next.

[1] https://lore.kernel.org/all/20240729113226.2905928-4-danishanwar@ti.com/

> Jan
> 

-- 
Thanks and Regards,
Md Danish Anwar


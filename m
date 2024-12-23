Return-Path: <netdev+bounces-154000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80419FAA77
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 07:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFFC1884C09
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DFB155398;
	Mon, 23 Dec 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X0JWgtwS"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790874BE1;
	Mon, 23 Dec 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734935541; cv=none; b=qgnKYw5v7codLWw1ikzFQxkPAvHUQNdlmpM6j8OExVUzsmIVlz1bs05f6rjGFmVbDritDl4+lLYfxhZWAUHX2AMmatg907R7Y2UFdednWur30TOW4j0azd1FxS/HvspJPxAlJjedVsefKiK06B0WQ3vnzv3HPtbyy0ITW/DqhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734935541; c=relaxed/simple;
	bh=GkvoTo5m5qJw53P8QLjuyLzK6CO2Oj8kZcSWYQYeLxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yjh/2xYWe+2Z1QtrkSsBgK0q7/lFyKLfP+TS7Bv8ei5VcO3BhpNYJwYJaTiOOEEqkCqiokl0KF+/qlHdEeacSdmUdSAcX8JcmE2ViE5+JQ2ojMJU/12BcM9WHmeySh1JXc1CH+2hS+m4+uQBevHPcOnaADb9wy5kEHBnXfeZO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X0JWgtwS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN6V5MR510161
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 00:31:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734935465;
	bh=3BTONUl+l/w2V7p4t45xjP7SXRaGcdXwytDe7TqTHw0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X0JWgtwSlUMMr1R4eRltxjmer9iekMBzMmT0b4KpELQ6RuBTGxP0AEI/+c6DEHE+q
	 fH+jUpL/vBbJlPZWu9sNhxcZQcEE3Eyjr36L6Blg7wed3+WFcRB7SH7pG+nweHJKRM
	 ouzUM4eN1JRr1H5RA2Um/OQFoVBmz9fu+VliTq1k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN6V53X030676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Dec 2024 00:31:05 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 00:31:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 00:31:04 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN6UwZc072455;
	Mon, 23 Dec 2024 00:30:59 -0600
Message-ID: <45ed487e-7489-4e4f-9e41-ac741ca7882d@ti.com>
Date: Mon, 23 Dec 2024 12:00:58 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG
 Driver
To: "Anwar, Md Danish" <a0501179@ti.com>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>,
        <schnelle@linux.ibm.com>, <vladimir.oltean@nxp.com>,
        <horms@kernel.org>, <rogerq@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
 <20241216100044.577489-2-danishanwar@ti.com>
 <Z2L/hwH5pgBV9pSB@lzaremba-mobl.ger.corp.intel.com>
 <c6254178-6e2a-47e1-ac16-22af5affc8ca@ti.com>
 <Z2RQ7xj6IwPXsqHO@lzaremba-mobl.ger.corp.intel.com>
 <73bc878e-a323-44ef-b90f-11723ce129e3@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <73bc878e-a323-44ef-b90f-11723ce129e3@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi,

On 20/12/24 11:01 am, Anwar, Md Danish wrote:
> Hi,
> 
> On 12/19/2024 10:29 PM, Larysa Zaremba wrote:
>> On Thu, Dec 19, 2024 at 10:36:57AM +0530, MD Danish Anwar wrote:
>>>
>>>
>>> On 18/12/24 10:29 pm, Larysa Zaremba wrote:
>>>> On Mon, Dec 16, 2024 at 03:30:41PM +0530, MD Danish Anwar wrote:
>>>>> HSR offloading is supported by ICSSG driver. Select the symbol HSR for
>>>>> TI_ICSSG_PRUETH. Also select NET_SWITCHDEV instead of depending on it to
>>>>> remove recursive dependency.
>>>>>
>>>>
>>>> 2 things:
>>>> 1) The explanation from the cover should have been included in the commit 
>>>>    message.
>>>
>>> I wanted to keep the commit message brief so I provided the actual
>>> errors in cover letter. I will add the logs here as well.
>>>
>>
>> Commit message has to be as verbose as needed to provide enough context for 
>> whoever needs to explore the code history later.
>>  
> 
> Sure I will update the commit message.
> 
>>>> 2) Why not `depends on HSR`?
>>>
>>> Adding `depends on HSR` in `config TI_ICSSG_PRUETH` is not setting HSR.
>>> I have tried below scenarios and only one of them work.
>>>
>>> 1) depends on NET_SWITCHDEV
>>>    depends on HSR
>>>
>>> 	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
>>> CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
>>> defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
>>> disabled.
>>
>> I do not understand your problem with this option, CONFIG_HSR is a visible 
>> option that you can enable manually only then you will be able to successfully 
>> set CONFIG_TI_ICSSG_PRUETH to m/y, this is how the relation with NET_SWITCHDEV 
>> currently works.
>>
> 
> The only problem with this option is that when I do `make defconfig`, it
> will unset CONFIG_TI_ICSSG_PRUETH.
> 
> I will have to manually change the arch/arm64/configs/defconfig to set
> HSR=m and then only `make defconfig` will enable CONFIG_TI_ICSSG_PRUETH
> 
> Currently HSR is not enabled in defconfig. I will have to send out a
> patch to set HSR=m in defconfig
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c62831e61586..ff3e5d960e2a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -129,6 +129,7 @@ CONFIG_MEMORY_FAILURE=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
> +CONFIG_HSR=m
>  CONFIG_UNIX=y
>  CONFIG_INET=y
>  CONFIG_IP_MULTICAST=y
> 
> 
> Since I am the only one needing HSR, I thought it would be better if I
> select HSR and it only gets built if CONFIG_TI_ICSSG_PRUETH is enabled
> instead of always getting built.
> 
> For this reason I thought selecting HSR would be good choice, since just
> selecting HSR wasn't enough and resulted in recursive dependency,  I had
> to change NET_SWITCHDEV also to select.
> 
> BTW `NET_DSA` selects `NET_SWITCHDEV` (net/dsa/Kconfig:9)
> 
>> Just 'depends on' is still a preferred way for me, as there is not a single 
>> driver that does 'select NET_SWITCHDEV'
>>
>>>
>>> 2) select NET_SWITCHDEV
>>>    depends on HSR
>>>
>>> 	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
>>> CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
>>> defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
>>> disabled.
>>>
>>> 3) depends on NET_SWITCHDEV
>>>    select HSR
>>> 	
>>> 	Results in recursive dependency
>>>
>>> error: recursive dependency detected!
>>> 	symbol NET_DSA depends on HSR
>>> 	symbol HSR is selected by TI_ICSSG_PRUETH
>>> 	symbol TI_ICSSG_PRUETH depends on NET_SWITCHDEV
>>> 	symbol NET_SWITCHDEV is selected by NET_DSA
>>> For a resolution refer to Documentation/kbuild/kconfig-language.rst
>>> subsection "Kconfig recursive dependency limitations"
>>>
>>> make[2]: *** [scripts/kconfig/Makefile:95: defconfig] Error 1
>>> make[1]: *** [/home/danish/workspace/net-next/Makefile:733: defconfig]
>>> Error 2
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>> 4) select NET_SWITCHDEV
>>>    select HSR
>>>
>>> 	HSR is set as `m` along with `CONFIG_TI_ICSSG_PRUETH`
>>>
>>> CONFIG_HSR=m
>>> CONFIG_NET_SWITCHDEV=y
>>> CONFIG_TI_ICSSG_PRUETH=m
>>>
>>> #4 is the only secnario where HSR gets built. That's why I sent the
>>> patch with `select NET_SWITCHDEV` and `select HSR`
>>>
> 
> I still think 4 is the best option. Only difference here is that we have
> to `select NET_SWITCHDEV` as well.
> 

I see there is some issue seen
https://lore.kernel.org/all/202412210336.BmgcX3Td-lkp@intel.com/ with
this patch.

For now I'll drop this patch and send out a separate patch to defconfig
to set HSR=m.

Once the defconfig patch gets merged, I will add `depends on HSR` in
Kconfig for TI_ICSSG_PRUETH (the method suggested by you)

Thanks for the review.

>>>>  
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  drivers/net/ethernet/ti/Kconfig | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>>>>> index 0d5a862cd78a..ad366abfa746 100644
>>>>> --- a/drivers/net/ethernet/ti/Kconfig
>>>>> +++ b/drivers/net/ethernet/ti/Kconfig
>>>>> @@ -187,8 +187,9 @@ config TI_ICSSG_PRUETH
>>>>>  	select PHYLIB
>>>>>  	select TI_ICSS_IEP
>>>>>  	select TI_K3_CPPI_DESC_POOL
>>>>> +	select NET_SWITCHDEV
>>>>> +	select HSR
>>>>>  	depends on PRU_REMOTEPROC
>>>>> -	depends on NET_SWITCHDEV
>>>>>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>>>>>  	depends on PTP_1588_CLOCK_OPTIONAL
>>>>>  	help
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>>
>>>
>>> -- 
>>> Thanks and Regards,
>>> Danish
> 

-- 
Thanks and Regards,
Danish


Return-Path: <netdev+bounces-153229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A19F73D8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115FF7A30BE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 05:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C41FCFE9;
	Thu, 19 Dec 2024 05:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EHkuGD2c"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2033EA;
	Thu, 19 Dec 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734584874; cv=none; b=hasxwTbe3MVqkcBLaU7rPuJ3CKpvaXLlgi8T91Xcq2gFjZj+6pjyvTXEJ9EiWvkSpnPw6efDWtW1KAQvgWSzENAhnNALa+g+rwj7FFyQqpxTY2dhAtykr0FvJJ72F+ZXAjT3sVkygoUWrsMhedzevfVbagTHcv1rgl2TYPEjhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734584874; c=relaxed/simple;
	bh=7NoOdyU3kSObR0gaoJaMfGX8M4QvnyCFhQ+t7AKeLjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=STWrkD6NiUe2TqqKoKIlNjshitva7uwMIa9KBrwvywDGB9UGVeaR0MBZ2NNDtJCfa/3R4ieSCefyF34VnzUQCM53fF2noOiVL5Q/oTRCyQf8x83ja3Ih136Zc+T1jo8vfIiwMuGHDnRstkiEWbE1mqVsDwhzRjfATHTTGvb075w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EHkuGD2c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ574Jl057189;
	Wed, 18 Dec 2024 23:07:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734584824;
	bh=mmc6jucBgZmDsYveNGNTIb7SUSQtNS9OQ5CWM+MIYl8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EHkuGD2cK1KIrMQOiTPVc+NKhuHjgOfjIIxCOiFERQWQrvIwekAcHMRlMwc9ncb+d
	 hNpTM12lzTbJXlEU/lo6KB7D1x1N4vpMG0C5Th24DbXuF7hi0NxpP/9jkTE/lUpGA0
	 FoFz44kA8xFovRRofuddNappjNudKPg+cBsLsCa0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ574IP100295;
	Wed, 18 Dec 2024 23:07:04 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 23:07:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 23:07:04 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ56wUm055129;
	Wed, 18 Dec 2024 23:06:59 -0600
Message-ID: <c6254178-6e2a-47e1-ac16-22af5affc8ca@ti.com>
Date: Thu, 19 Dec 2024 10:36:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG
 Driver
To: Larysa Zaremba <larysa.zaremba@intel.com>
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
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <Z2L/hwH5pgBV9pSB@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 18/12/24 10:29 pm, Larysa Zaremba wrote:
> On Mon, Dec 16, 2024 at 03:30:41PM +0530, MD Danish Anwar wrote:
>> HSR offloading is supported by ICSSG driver. Select the symbol HSR for
>> TI_ICSSG_PRUETH. Also select NET_SWITCHDEV instead of depending on it to
>> remove recursive dependency.
>>
> 
> 2 things:
> 1) The explanation from the cover should have been included in the commit 
>    message.

I wanted to keep the commit message brief so I provided the actual
errors in cover letter. I will add the logs here as well.

> 2) Why not `depends on HSR`?

Adding `depends on HSR` in `config TI_ICSSG_PRUETH` is not setting HSR.
I have tried below scenarios and only one of them work.

1) depends on NET_SWITCHDEV
   depends on HSR

	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
disabled.

2) select NET_SWITCHDEV
   depends on HSR

	HSR doesn't get set in .config - `# CONFIG_HSR is not set`. Even the
CONFIG_TI_ICSSG_PRUETH also gets unset although this is set to =m in
defconfig. But keeping both as `depends on` makes CONFIG_TI_ICSSG_PRUETH
disabled.

3) depends on NET_SWITCHDEV
   select HSR
	
	Results in recursive dependency

error: recursive dependency detected!
	symbol NET_DSA depends on HSR
	symbol HSR is selected by TI_ICSSG_PRUETH
	symbol TI_ICSSG_PRUETH depends on NET_SWITCHDEV
	symbol NET_SWITCHDEV is selected by NET_DSA
For a resolution refer to Documentation/kbuild/kconfig-language.rst
subsection "Kconfig recursive dependency limitations"

make[2]: *** [scripts/kconfig/Makefile:95: defconfig] Error 1
make[1]: *** [/home/danish/workspace/net-next/Makefile:733: defconfig]
Error 2
make: *** [Makefile:251: __sub-make] Error 2

4) select NET_SWITCHDEV
   select HSR

	HSR is set as `m` along with `CONFIG_TI_ICSSG_PRUETH`

CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_TI_ICSSG_PRUETH=m

#4 is the only secnario where HSR gets built. That's why I sent the
patch with `select NET_SWITCHDEV` and `select HSR`

>  
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index 0d5a862cd78a..ad366abfa746 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -187,8 +187,9 @@ config TI_ICSSG_PRUETH
>>  	select PHYLIB
>>  	select TI_ICSS_IEP
>>  	select TI_K3_CPPI_DESC_POOL
>> +	select NET_SWITCHDEV
>> +	select HSR
>>  	depends on PRU_REMOTEPROC
>> -	depends on NET_SWITCHDEV
>>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>>  	depends on PTP_1588_CLOCK_OPTIONAL
>>  	help
>> -- 
>> 2.34.1
>>
>>

-- 
Thanks and Regards,
Danish


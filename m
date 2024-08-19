Return-Path: <netdev+bounces-119628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0395663A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF61C21A00
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C115B55D;
	Mon, 19 Aug 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eygj7Yij"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856D15B98E;
	Mon, 19 Aug 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058072; cv=none; b=UpshA8IcbDFfXiCUgE6z1TgCjT1PYq/NRbMfs9IT49SeDEiKUPpeny+qEDdrVCIJDgESkqMsi1aCyCIeQemjTeBQJjVoihHy68VfTQBOXdbeUZc0Ddsik5S34se+1wyxxnClzqFEmdndMvzaXVodTyWQecw0j323wF9hdYWPnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058072; c=relaxed/simple;
	bh=Lq+ydDfznOmcMWbT1yc+dyI32orIecF/SoETsLnhKAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nmwVjYVHz+4IONwY3N7aPRIWjVmod3olQeEU5W96pJFL0inz+PAI4lPLGTsb3xFlmJ7Een7WdUvYxEI4v3B71uRmml3xVczm7fPHR3SOlejbeoJN+jywYR/NiS52KCffZp+Hzoa82oynE0B/o/+WsEtV/J4jBqdqLPNZgbejcQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eygj7Yij; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J7Aurm062385;
	Mon, 19 Aug 2024 02:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724051456;
	bh=CxLnSkhq1Od1x1Kfnk7IOtU84n8QvmEdWxueeGtj4e4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eygj7YijI4UHQfF7oolGjNczoKehIEyNPLVB39+5Hph0gjbycddOtoxvDT1H3QiAS
	 JJZiOzfN3GR68cKoMBtNdRW8bJuWRVGuP+oYyYKhLPDIPITNrK83sHipXWaVfceDDe
	 /eiuDqBTdHdZCRuK9px6hjGFH5g95ppIRFcJ509E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J7AuHJ040566
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 02:10:56 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 02:10:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 02:10:55 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J7Alrp051465;
	Mon, 19 Aug 2024 02:10:48 -0500
Message-ID: <e8aee03a-2141-4c96-968f-02e4c622c59c@ti.com>
Date: Mon, 19 Aug 2024 12:40:45 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: Simon Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Kory
 Maincent <kory.maincent@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Roger
 Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240814092033.2984734-1-danishanwar@ti.com>
 <20240814092033.2984734-3-danishanwar@ti.com>
 <20240815160109.GN632411@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240815160109.GN632411@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 8/15/2024 9:31 PM, Simon Horman wrote:
> On Wed, Aug 14, 2024 at 02:50:33PM +0530, MD Danish Anwar wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index f678d656a3ed..ac2291d22c42 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -50,8 +50,10 @@
>>  
>>  #define ICSSG_MAX_RFLOWS	8	/* per slice */
>>  
>> +#define ICSSG_NUM_PA_STATS 4
>> +#define ICSSG_NUM_MII_G_RT_STATS 60
>>  /* Number of ICSSG related stats */
>> -#define ICSSG_NUM_STATS 60
>> +#define ICSSG_NUM_STATS (ICSSG_NUM_MII_G_RT_STATS + ICSSG_NUM_PA_STATS)
>>  #define ICSSG_NUM_STANDARD_STATS 31
>>  #define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
>>  
>> @@ -263,6 +265,7 @@ struct prueth {
>>  	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
>>  	struct regmap *miig_rt;
>>  	struct regmap *mii_rt;
>> +	struct regmap *pa_stats;
> 
> Please add an entry for pa_stats to the Kernel doc for this structure.
> 
>>  
>>  	enum pruss_pru_id pru_id[PRUSS_NUM_PRUS];
>>  	struct platform_device *pdev;
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> index 999a4a91276c..e834316092c9 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
>> @@ -77,6 +77,20 @@ struct miig_stats_regs {
>>  	u32 tx_bytes;
>>  };
>>  
>> +/**
>> + * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
>> + * @u32 fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
>> + * @u32 fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
>> + * @u32 fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
>> + * @u32 fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
>> + */
> 
> ./scripts/kernel-doc -none doesn't seem to like the syntax above.
> Perhaps s/u32 // ?

Sure, I will drop u32 from comment.

> 
>> +struct pa_stats_regs {
>> +	u32 fw_rx_cnt;
>> +	u32 fw_tx_cnt;
>> +	u32 fw_tx_pre_overflow;
>> +	u32 fw_tx_exp_overflow;
>> +};
>> +
>>  #define ICSSG_STATS(field, stats_type)			\
>>  {							\
>>  	#field,						\
> 
> ...

-- 
Thanks and Regards,
Md Danish Anwar


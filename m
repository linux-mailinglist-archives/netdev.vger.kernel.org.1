Return-Path: <netdev+bounces-151745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C659F0C34
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116DE18886FF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10C1DF739;
	Fri, 13 Dec 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTl5zanL"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B11DF256;
	Fri, 13 Dec 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092843; cv=none; b=XF9FY//WUtI9VODVxrXlJAOpM+a/qoZrSHv0SNcu/tbasTMJAfwnFVLkXdMeFVUMoWao6zWpmRq8YOd+qqvs+a0sW1Dx58BNeEFYjqEfoHUrbuEAusIz68nwtjcW8GBbmr6SKIw7DJAjC/HO+l2ygluWsBvhdUu/f8DHUr/msek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092843; c=relaxed/simple;
	bh=RNe5ohNpUyEDQ89uT1QfgzBzs2jm2Vw0Oha4SoeU/gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QEGSi+JfUFGzrQKMhTOXYAeqPGOGc05P5XodtjBMScWFx3sfH+ajlnQ3uXfhxaEboIfBsOjMHOg36ZPluHhd5JPeUlT8LcY6HPhUGbKh0v/4OBXLm2OUO5S6DVEeqrSMuwoztQ6e9ZbV2Jp0R+mekjM4xB3RxbSXqNXXIMWNpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sTl5zanL; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDCQw6T3086016
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 06:26:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734092818;
	bh=STXJOLYyzLHgBSnUGBfmxsn3ExlIXLRjzN5ci1FD8As=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=sTl5zanLe+f9MmjsXgc64Z6gwv0BT6Xb9IJEroD+PQWyQ3Wb3TQTSLFBNrW6Icu+j
	 MgDdiIECu7HEfHocq029dHBmakeaKHVPuNTv+KGXNXG9uPh2E8t97i7Cp6Pmf8lJxa
	 n4xgq6x8iRAaMJ0tfvxlc8v6OjxQ4ACGJA/M//ig=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDCQwGc008976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 06:26:58 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 06:26:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 06:26:58 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDCQqoV123016;
	Fri, 13 Dec 2024 06:26:53 -0600
Message-ID: <5ed274f9-ca25-40a7-96c6-43b36b7663af@ti.com>
Date: Fri, 13 Dec 2024 17:56:52 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net v4 1/2] net: ti: icssg-prueth: Fix
 firmware load sequence.
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <vigneshr@ti.com>, <matthias.schiffer@ew.tq-group.com>, <robh@kernel.org>,
        <u.kleine-koenig@baylibre.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241211135941.1800240-1-m-malladi@ti.com>
 <20241211135941.1800240-2-m-malladi@ti.com>
 <304870d9-10c7-43b3-8255-8f2b0422d759@stanley.mountain>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <304870d9-10c7-43b3-8255-8f2b0422d759@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/12/24 21:16, Dan Carpenter wrote:
> On Wed, Dec 11, 2024 at 07: 29: 40PM +0530, Meghana Malladi wrote: > 
> -static int prueth_emac_start(struct prueth *prueth, struct prueth_emac 
> *emac) > +static int prueth_emac_start(struct prueth *prueth, int slice) 
>  > { > struct icssg_firmwares
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!uldqfRcOdo0RqyXEHNnjPxku43QuA2sRmrlczDVj-denyMX3qWPEeHokm6IS-fNmWZGSvK3Wn7nSFeNotanVMDOTlZZjZ8Ausf9AkMk$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Wed, Dec 11, 2024 at 07:29:40PM +0530, Meghana Malladi wrote:
>> -static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>> +static int prueth_emac_start(struct prueth *prueth, int slice)
>>  {
>>  	struct icssg_firmwares *firmwares;
>>  	struct device *dev = prueth->dev;
>> -	int slice, ret;
>> +	int ret;
>>  
>>  	if (prueth->is_switch_mode)
>>  		firmwares = icssg_switch_firmwares;
>> @@ -177,16 +177,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>  	else
>>  		firmwares = icssg_emac_firmwares;
>>  
>> -	slice = prueth_emac_slice(emac);
>> -	if (slice < 0) {
>> -		netdev_err(emac->ndev, "invalid port\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	ret = icssg_config(prueth, emac, slice);
>> -	if (ret)
>> -		return ret;
>> -
>>  	ret = rproc_set_firmware(prueth->pru[slice], firmwares[slice].pru);
>>  	ret = rproc_boot(prueth->pru[slice]);
> 
> This isn't introduced by this patch but eventually Colin King is going to
> get annoyed with you for setting ret twice in a row.
> 

Yeah ok, I will fix this as part of this patch.

>>  	if (ret) {
>> @@ -208,7 +198,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>  		goto halt_rtu;
>>  	}
>>  
>> -	emac->fw_running = 1;
>>  	return 0;
>>  
>>  halt_rtu:
>> @@ -220,6 +209,78 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>>  	return ret;
>>  }
>>  
>> +static int prueth_emac_common_start(struct prueth *prueth)
>> +{
>> +	struct prueth_emac *emac;
>> +	int ret = 0;
>> +	int slice;
>> +
>> +	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
>> +		return -EINVAL;
>> +
>> +	/* clear SMEM and MSMC settings for all slices */
>> +	memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
>> +	memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
>> +
>> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
>> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
>> +
>> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>> +		icssg_init_fw_offload_mode(prueth);
>> +	else
>> +		icssg_init_emac_mode(prueth);
>> +
>> +	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
>> +		emac = prueth->emac[slice];
>> +		if (emac) {
>> +			ret |= icssg_config(prueth, emac, slice);
>> +			if (ret)
>> +				return ret;
> 
> Here we return directly.
> 
>> +		}
>> +		ret |= prueth_emac_start(prueth, slice);
> 
> Here we continue.  Generally, I would expect there to be some clean up
> on this error path like this:
> 
> 		ret = prueth_emac_start(prueth, slice);
> 		if (ret)
> 			goto unwind_slices;
> 
> 	...
> 
> 	return 0;
> 
> unwind_slices:
> 	while (--slice >= 0)
> 		prueth_emac_stop(prueth, slice);
> 
> 	return ret;
> 
> I dread to see how the cleanup is handled on this path...
> 
> Ok.  I've looked at it and, nope, it doesn't work.  This is freed in
> prueth_emac_common_stop() but partial allocations are not freed.
> Also the prueth_emac_stop() is open coded as three calls to
> rproc_shutdown() which is ugly.
> 
> I've written a blog which describes a system for writing error
> handling code.  If each function cleans up after itself by freeing
> its own partial allocations then you don't need to have a variable
> like "prueth->prus_running = 1;" to track how far the allocation
> process went before failing.
> https://urldefense.com/v3/__https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/__;!!G3vK!T5VCna8tMLVZNSL49zSwJOQBnoAQEa2xqXUUsIYY78CYm5mEH2wAdMX9CDEfMHXWsjTn0sG4mwKevVIOrgfAuQ$  <https://urldefense.com/v3/__https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/__;!!G3vK!T5VCna8tMLVZNSL49zSwJOQBnoAQEa2xqXUUsIYY78CYm5mEH2wAdMX9CDEfMHXWsjTn0sG4mwKevVIOrgfAuQ$>
> 

I agree that current error handling is all over the place. But I wasn't 
sure what would be the cleanest approach here. Thanks for sharing the 
blog, I have looked into it and looks very promising. I will try this 
approach and get back to you.

thanks & regards,
Meghana Malladi.

> regards,
> dan carpenter
> 


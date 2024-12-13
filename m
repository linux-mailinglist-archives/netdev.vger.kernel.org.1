Return-Path: <netdev+bounces-151744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8959F0C26
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6441695C5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A111DF728;
	Fri, 13 Dec 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="go8+nm+S"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873B364D6;
	Fri, 13 Dec 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092593; cv=none; b=W90M2mOVv+i/HZzU8M0EumQHgKil5Sa6/0KZEX1X88UcpLLIRYtKt8hgYaL03eyTbA5xXGefwFW9kr+w3ZlXTZZCyQG2i14CHnSvlf+dLDFBJaxDppn2h0mMsMDJSs3g2AiwLMGeYgDP1dOz5Jc7RKNMc7la3WLRHYo0THtanTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092593; c=relaxed/simple;
	bh=9FhpDiE02t/1mLvmpuijYoGeEU6kID8DIhL0J5DHbn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jUDwNHrMkdx1DV+s2uG0S4xMoiYsev06ZFF/uUh2nSXGSRge0BGyD9q/LT3cJCi/Q6Nf34Y3YkuVoJFCqmBEhA9ceyVM34trc6qHj96CtRttwHp2xz8D0i7RWEGimojRu8qG+vMhIJa/NqEOcWVByrPH5AMB82YGrGuLTR4xdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=go8+nm+S; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BDCMZDU004162;
	Fri, 13 Dec 2024 06:22:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734092555;
	bh=YyFPqMKZRrKIg1oWIoiS8WyOAY1Z2VQsk+vK4yB1cIk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=go8+nm+SJ92VSD84e0sq5VN9fQCbHCChomk0DxqbNfRHclTZY0zXIYon6IhXtY/qD
	 nNgfOuFrWwXFSFApUFR/uo3s9vcBvvcJmSh8+350xgKwjmzMOD+bwE5l7UgKshnQHU
	 W4fhQycDw48c+zaBQHpAWKXnmfEBvl8aHKDgcJWE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDCMZ2N106743
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 06:22:35 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 06:22:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 06:22:35 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDCMTFB118902;
	Fri, 13 Dec 2024 06:22:30 -0600
Message-ID: <57545831-836c-4105-be59-212d01965110@ti.com>
Date: Fri, 13 Dec 2024 17:52:29 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net v4 2/2] net: ti: icssg-prueth: Fix
 clearing of IEP_CMP_CFG registers during iep_init
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <vigneshr@ti.com>, <matthias.schiffer@ew.tq-group.com>, <robh@kernel.org>,
        <u.kleine-koenig@baylibre.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241211135941.1800240-1-m-malladi@ti.com>
 <20241211135941.1800240-3-m-malladi@ti.com>
 <3b0b84f9-d51b-4075-9d1a-5c2042ee6c4e@stanley.mountain>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <3b0b84f9-d51b-4075-9d1a-5c2042ee6c4e@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/12/24 20:13, Dan Carpenter wrote:
> On Wed, Dec 11, 2024 at 07: 29: 41PM +0530, Meghana Malladi wrote: > 
> drivers/net/ethernet/ti/icssg/icss_iep. c | 9 +++++++++ > 1 file 
> changed, 9 insertions(+) > > diff --git 
> a/drivers/net/ethernet/ti/icssg/icss_iep. c 
> b/drivers/net/ethernet/ti/icssg/icss_iep. c
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!uldqd1eFN22R6yXOvHOpn5WAo9_VFQH5-v8XYKsQLuIl9SMCOgfm9hmv8Rr9Y_bMWd5wpdH9mAXBiUbw5VhHCnva7cOtZgfLcnsXKK4$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Wed, Dec 11, 2024 at 07:29:41PM +0530, Meghana Malladi wrote:
>>  drivers/net/ethernet/ti/icssg/icss_iep.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index 5d6d1cf78e93..a96861debbe3 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -215,6 +215,10 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
>>  	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
>>  		regmap_update_bits(iep->map, ICSS_IEP_CMP_STAT_REG,
>>  				   IEP_CMP_STATUS(cmp), IEP_CMP_STATUS(cmp));
>> +
>> +		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
>> +				   IEP_CMP_CFG_CMP_EN(cmp), 0);
>> +
> 
> Don't add this blank line.
> 
> You won't detect this by running checkpatch on the patch, but if you
> apply the patch and re-run checkpatch on the file then it will complain
> about this.
> 

I see, I will remove the blank line then.

>>  	}
>>  
>>  	/* enable reset counter on CMP0 event */
>> @@ -780,6 +784,11 @@ int icss_iep_exit(struct icss_iep *iep)
>>  	}
>>  	icss_iep_disable(iep);
>>  
>> +	if (iep->pps_enabled)
>> +		icss_iep_pps_enable(iep, false);
>> +	else if (iep->perout_enabled)
>> +		icss_iep_perout_enable(iep, NULL, false);
> 
> 
> Do we need the else?  Could be written as:
> 
> 	if (iep->pps_enabled)
> 		icss_iep_pps_enable(iep, false);
> 	if (iep->perout_enabled)
> 		icss_iep_perout_enable(iep, NULL, false);
> 

pps and perout and mutually exclusive, hence used if and else if.

> regards,
> dan carpenter
> 
> 


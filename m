Return-Path: <netdev+bounces-95870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F78C3B7D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1271F2144D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360B1465A3;
	Mon, 13 May 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fz8SeCcn"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9E52F9B;
	Mon, 13 May 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582437; cv=none; b=miIlUwV2raCMpekwBTZq9cASjYfLvQKH8H2xzDt1WVcSKJBLH8Ug+kcMbbw4k+sUKexYb1Y/YMdz5YtbdqVFbFyyrRNc4uDDjCRR+LVUyfYZ2zBN7r/8g1rxyWrOzFHERrlXUvu38kJD6yI2ZKdgG/JfTxp8H9FQij1y5dETQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582437; c=relaxed/simple;
	bh=lqcEe4hZIzl0ewoaZ/vN2AJJvQPMQLnu4BDGTpFrGFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jIkXsIyaDBok2JOgSNv/vPylwCutYrdXA0BORqoMQM8rmz4y5K7z+9IBCyCLVNOy4JiUbjBju3G3NAHiXGGwzLpOICoT1Zww6IXTyMyWERhwlXMqiy7waVutGRVVP2ONZ9Ul5uqSSaWWX9QkS8WVOjvH8vaF/+9BTc907HU/Z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fz8SeCcn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44D6e52h010669;
	Mon, 13 May 2024 01:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715582405;
	bh=EznlNRZRqFxgIXuvyRQEXYusN2dLWKllykgxYp3lDds=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fz8SeCcnbcWfSGP42Pl8maqcPtERRwY5/QbwF3ekjMm++Nmp/Vb3DgfX5OE41gQxj
	 Fxm+q3Z6jNGoNjXv5qUs5BC4wXl0ArxaC1WbVJsxpsLOIr4vyRCAzy+yPjb/fEdyxd
	 J+6r6C8ZJNrgkJWX+kzbrmdTS+yN4jEWYHfucYEU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44D6e5ob021930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 May 2024 01:40:05 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 May 2024 01:40:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 May 2024 01:40:05 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44D6dwwk076174;
	Mon, 13 May 2024 01:39:58 -0500
Message-ID: <7542d6ed-28aa-467d-a81a-ab44f82cef72@ti.com>
Date: Mon, 13 May 2024 12:09:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
        Simon
 Horman <horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Randy
 Dunlap <rdunlap@infradead.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram
 Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Roger Quadros
	<rogerq@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240429103022.808161-1-danishanwar@ti.com>
 <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
 <cc9eae8f17e3e0ad142c9efa3fe5dff7afe2554c.camel@redhat.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <cc9eae8f17e3e0ad142c9efa3fe5dff7afe2554c.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 02/05/24 5:32 pm, Paolo Abeni wrote:
> On Thu, 2024-05-02 at 13:59 +0200, Paolo Abeni wrote:
>> On Mon, 2024-04-29 at 16:00 +0530, MD Danish Anwar wrote:
>>> +static int emac_taprio_replace(struct net_device *ndev,
>>> +			       struct tc_taprio_qopt_offload *taprio)
>>> +{
>>> +	struct prueth_emac *emac = netdev_priv(ndev);
>>> +	struct tc_taprio_qopt_offload *est_new;
>>> +	int ret;
>>> +
>>> +	if (taprio->cycle_time_extension) {
>>> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
>>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
>>> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
>>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
>>> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (emac->qos.tas.taprio_admin)
>>> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>>
>> it looks like 'qos.tas.taprio_admin' is initialized from
>> taprio_offload_get(), so it should be free with taprio_offload_free(),
>> right?
>>
>>> +
>>> +	est_new = devm_kzalloc(&ndev->dev,
>>> +			       struct_size(est_new, entries, taprio->num_entries),
>>> +			       GFP_KERNEL);
>>> +	if (!est_new)
>>> +		return -ENOMEM;
>>
>> Why are you allocating 'est_new'? it looks like it's not used
>> anywhere?!? 
>>
>>> +
>>> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
>>> +	ret = tas_update_oper_list(emac);
>>> +	if (ret)
>>> +		return ret;
>>
>> Should the above clear 'taprio_admin' on error, as well? 
> 
> Side note: the patch itself is rather big, I guess it would be better
> split it. You can make a small series putting the the struct definition
> move in a separate patch. 


Sure Paolo, I will split the "struct definition move" to a separate
patch and post both the patches as a small series in v6.

> 
> Thanks,
> 
> Paolo
> 

-- 
Thanks and Regards,
Danish


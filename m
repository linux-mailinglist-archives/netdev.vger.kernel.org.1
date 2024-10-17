Return-Path: <netdev+bounces-136532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F259A205C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4001F276B2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886581DA632;
	Thu, 17 Oct 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="tUvW5+k9"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F985478E;
	Thu, 17 Oct 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162540; cv=none; b=oLAIAeKyLfeZdhGg/WqE9oZZ2SiD8xWHOrBMl+RU1XphGw8UCKj2Ao0Lw/HzzDD67Pq1SIkvO0g3n0pvpKOf00a3aTOBkI8Y8EmZ53tA4dsItDWQKVBBQpK+3AUIv/OpmDxyDY4ez3VPFoE4jtJnyTMauGQiJkP44sCfX7FakPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162540; c=relaxed/simple;
	bh=UpKFrmYGllYrsyMM/1lD6FUUlil9xbypcgaoXpIa9rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TjSrI+zAZwfXJ7V0oTwYuENzufcShCsBY9TxibX9h57n1yMXJDGRpCHAPRAVTilaicwF0ISAzUIIGAyB5qSFF0J83VcGN61Sv6WLPQEMwK2Xk0d5TxA/iRoHhhfc8qBCxs0a81vY0lP3JOee9KCU04tf2nsVZjTxwEGC+NW4cIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=tUvW5+k9; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 1B71C100009;
	Thu, 17 Oct 2024 13:55:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1729162517; bh=+QOrfWCVTQRkFZFpeklgdTnpXjePxMpWDQdvvcusiSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=tUvW5+k9qGoxLAcOAI1xJWl5fV2ilztGDXtq/ogzAnlzb1et9+EBPypzEA4DOCDE3
	 te/lIhEtjbS7cV9YCTYCgtmmbyLTN538c9X714J/DDdO8NHlgub/JnJpoX13YB+86M
	 hyx8HtjvRUD5Q0bugZ29pcqgEVkEn2p/iRFqtAqGobt33jsAb+Z5zXTr7IVAWIQ7Oc
	 kOnkkz6VzZpjAWNOWFh7HYEeuFgnvLipmfc8gWKHXzyhT90TGla+q4UJ1oFQNxluwJ
	 s9coMtWPa9RkHfLKUfrtbG3NWEei7gO97bwd0sR+HiPZ152RJIp0PXKoJXLCHJj2nT
	 lpfINW8PKdLRg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu, 17 Oct 2024 13:53:58 +0300 (MSK)
Received: from [172.17.44.122] (172.17.44.122) by ta-mail-02 (172.17.13.212)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 13:53:37 +0300
Message-ID: <72a4d2b0-3faf-46a3-84f2-fc93bdf19104@t-argos.ru>
Date: Thu, 17 Oct 2024 13:53:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] fsl/fman: Fix refcount handling of fman-related
 devices
To: Paolo Abeni <pabeni@redhat.com>, Igal Liberman
	<igal.liberman@freescale.com>
CC: Simon Horman <horms@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20241015060122.25709-1-amishin@t-argos.ru>
 <20241015060122.25709-3-amishin@t-argos.ru>
 <a0aec660-c18b-4d85-b85b-58fce3668e64@redhat.com>
Content-Language: ru
From: Aleksandr Mishin <amishin@t-argos.ru>
In-Reply-To: <a0aec660-c18b-4d85-b85b-58fce3668e64@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ta-mail-01.ta.t-argos.ru (172.17.13.211) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188507 [Oct 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/17 09:58:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/17 05:21:00 #26765332
X-KSMG-AntiVirus-Status: Clean, skipped


On 17.10.2024 13:01, Paolo Abeni wrote:
> On 10/15/24 08:01, Aleksandr Mishin wrote:
>> In mac_probe() there are multiple calls to of_find_device_by_node(),
>> fman_bind() and fman_port_bind() which takes references to of_dev->dev.
>> Not all references taken by these calls are released later on error path
>> in mac_probe() and in mac_remove() which lead to reference leaks.
>>
>> Add references release.
>>
>> Fixes: 3933961682a3 ("fsl/fman: Add FMan MAC driver")
>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>> ---
>> Compile tested only.
>>
>>   drivers/net/ethernet/freescale/fman/mac.c | 62 +++++++++++++++++------
>>   1 file changed, 47 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fman/mac.c 
>> b/drivers/net/ethernet/freescale/fman/mac.c
>> index 9b863db0bf08..11da139082e1 100644
>> --- a/drivers/net/ethernet/freescale/fman/mac.c
>> +++ b/drivers/net/ethernet/freescale/fman/mac.c
>> @@ -204,7 +204,7 @@ static int mac_probe(struct platform_device 
>> *_of_dev)
>>       if (err) {
>>           dev_err(dev, "failed to read cell-index for %pOF\n", 
>> dev_node);
>>           err = -EINVAL;
>> -        goto _return_of_node_put;
>> +        goto _return_dev_put;
>
> We are after a succesful of_find_device_by_node and prior to 
> fman_bind(), mac_dev->fman_dev refcount is 1


Indeed. refcounts = 1.


>
>> @@ -213,40 +213,51 @@ static int mac_probe(struct platform_device 
>> *_of_dev)
>>       if (!priv->fman) {
>>           dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
>>           err = -ENODEV;
>> -        goto _return_of_node_put;
>> +        goto _return_dev_put;
>>       }


refcounts: 1 + 1 = 2.


>>   +    /* Two references have been taken in of_find_device_by_node()
>> +     * and fman_bind(). Release one of them here. The second one
>> +     * will be released in mac_remove().
>> +     */
>> +    put_device(mac_dev->fman_dev);


refcounts: 2 - 1 = 1.


>>       of_node_put(dev_node);
>> +    dev_node = NULL;
>>         /* Get the address of the memory mapped registers */
>>       mac_dev->res = platform_get_mem_or_io(_of_dev, 0);
>>       if (!mac_dev->res) {
>>           dev_err(dev, "could not get registers\n");
>> -        return -EINVAL;
>> +        err = -EINVAL;
>> +        goto _return_dev_put;
>
> Here we are after a successful fman_bind(), mac_dev->fman_dev refcount 
> is 2. _return_dev_put will drop a single reference, this error path 
> looks buggy.


We released 1 reference above with "put_device(mac_dev->fman_dev);".


>
> Similar issue for the _return_dev_arr_put error path below.


Similar situation: we release 1 reference with 
"put_device(mac_dev->fman_port_devs[i]);".


>
> Cheers,
>
> Paolo
>
-- 
Kind regards
Aleksandr



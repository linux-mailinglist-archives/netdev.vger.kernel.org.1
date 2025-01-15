Return-Path: <netdev+bounces-158576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875DA128E3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278E53A502B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2220166F3A;
	Wed, 15 Jan 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad8QyAxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8209161321;
	Wed, 15 Jan 2025 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959142; cv=none; b=pTEOoB3hic6QO7ixsTE2fAvIJ1VNESa8bo+58cgUJyxoFjN1rnpmKYejThbwR9HtCm4Ybc3CBptEJiF4cIlUYOYmGWVkrRigY38PVS4J8EJPBkPiJRLV3twdHz6QSRQHzGSOR1KT5EZHUp1PPVO7nSdgy2rLdP8NF53HULlIkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959142; c=relaxed/simple;
	bh=FgPty/rV2Ym7FHRQ8IZ/fR8y4+fVfmTW3R67Z35EXsw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DtaWG0fiF6smK2taIecCkcklaLNUxEQcYoCSGFP2aFsNm0ZQcbsLCPpA2Yj49huPBKmr0V2jLBT3PFtVp7VW7Qmo3r0BZWURaznqgk16cOiCty2uB945PFRtkGTY6x1xgG8BBEOEuOV8HH0b1pDJxI7GRPi4nTlvfFa+M1PFCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad8QyAxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA24CC4CED1;
	Wed, 15 Jan 2025 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959142;
	bh=FgPty/rV2Ym7FHRQ8IZ/fR8y4+fVfmTW3R67Z35EXsw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ad8QyAxZtltvkQmeCXVgv/UwarTftRUz0G9/n2aSVfbJolIyc8O9EhGfk++TSQGqV
	 +MPyyy6VyxqLg6oZw+ac+kTcnoCLGYqnXSaPlL4EWUm0ZYGLZnAttltZvYqW9pj1hk
	 +TAuNTWQHaD1j+jHUvrQfrpfhPNb0a5AXIIo8GcJJbuxHNIBl5I3tRnBpD8QZP/i0M
	 MBrKXp3cHJWlChERkvkmqOI3HnsPfMTsiQ7WSsoTQFVgLG+QJcu4vj7HgrWasV3iJn
	 8p4a6Jga/+5XQHULFXNIW6V1MB87J+szwaLexLDOvw6tsiKk5h8qbg777moXZMSFMN
	 tpGbtDfasBA2A==
Message-ID: <8829d58b-fbfc-4040-93de-51970631d935@kernel.org>
Date: Wed, 15 Jan 2025 18:38:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
From: Roger Quadros <rogerq@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
 <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
 <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
Content-Language: en-US
In-Reply-To: <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Siddharth,

On 15/01/2025 17:49, Roger Quadros wrote:
> Hi Siddharth,
> 
> On 15/01/2025 12:38, Siddharth Vadapalli wrote:
>> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
>>> Hi Siddharth,
>>>
>>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
>>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
>>>>
>>>> Hello Roger,
>>>>
>>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
>>>>
>>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
>>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
>>>
>>> Yes I meant tx instead of rx.
>>>
>>>>
>>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>>>
>>>> Additionally, following the above section we have:
>>>>
>>>> 		if (tx_chn->irq < 0) {
>>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
>>>> 				tx_chn->irq);
>>>> 			ret = tx_chn->irq;
>>>> 			goto err;
>>>> 		}
>>>>
>>>> Could you please provide details on the code-path which will lead to a
>>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
>>>>
>>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
>>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
>>>> 2. am65_cpsw_nuss_suspend()
>>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
>>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
>>>> appears to me that "tx_chn->irq" will never be negative within
>>>> am65_cpsw_nuss_remove_tx_chns()
>>>>
>>>> Please let me know if I have overlooked something.
>>>
>>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
>>> repeatedly (by user changing number of TX queues) even if previous call
>>> to am65_cpsw_nuss_init_tx_chns() failed.
>>
>> Thank you for clarifying. So the issue/bug was discovered since the
>> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
>> misled me. Maybe the "Fixes" tag should be updated? Though we should
>> code to future-proof it as done in this patch, the "Fixes" tag pointing
>> to the very first commit of the driver might not be accurate as the
>> code-path associated with the bug cannot be exercised at that commit.
> 
> Fair enough. I'll change the Fixes commit.

Now that I check the code again, am65_cpsw_nuss_remove_tx_chns(),
am65_cpsw_nuss_update_tx_chns() and am65_cpsw_nuss_init_tx_chns()
were all introduced in the Fixes commit I stated.

Could you please share why you thought it is not accurate?

> 
>>
>> Independent of the above change suggested for the "Fixes" tag,
>>
>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> There seems to be a different bug in am65_cpsw_nuss_update_tx_rx_chns()
>> which I have described below.
>>
>>>
>>> Please try the below patch to simulate the error condition.
>>>
>>> Then do the following
>>> - bring down all network interfaces
>>> - change num TX queues to 2. IRQ for 2nd channel fails.
>>> - change num TX queues to 3. Now we try to free an invalid IRQ and we see warning.
>>>
>>> Also I think it is good practice to code for set value than to code
>>> for existing code paths as they can change in the future.
>>>
>>> --test patch starts--
>>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> index 36c29d3db329..c22cadaaf3d3 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> @@ -155,7 +155,7 @@
>>>  			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
>>>  			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
>>>  
>>> -#define AM65_CPSW_DEFAULT_TX_CHNS	8
>>> +#define AM65_CPSW_DEFAULT_TX_CHNS	1
>>>  #define AM65_CPSW_DEFAULT_RX_CHN_FLOWS	1
>>>  
>>>  /* CPPI streaming packet interface */
>>> @@ -2346,7 +2348,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
>>>  		tx_chn->dsize_log2 = __fls(hdesc_size_out);
>>>  		WARN_ON(hdesc_size_out != (1 << tx_chn->dsize_log2));
>>>  
>>> -		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>> +		if (i == 1)
>>> +			tx_chn->irq = -ENODEV;
>>> +		else
>>> +			tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>
>> The pair - am65_cpsw_nuss_init_tx_chns()/am65_cpsw_nuss_remove_tx_chns()
>> seem to be written under the assumption that failure will result in the
>> driver's probe failing.
>>
>> With am65_cpsw_nuss_update_tx_rx_chns(), that assumption no longer holds
>> true. Please consider the following sequence:
>>
>> 1.
>> am65_cpsw_nuss_probe()
>>   am65_cpsw_nuss_register_ndevs()
>>     am65_cpsw_nuss_init_tx_chns() => Succeeds
>>
>> 2.
>> Probe is successful
>>
>> 3.
>> am65_cpsw_nuss_update_tx_rx_chns() => Invoked by user
>>   am65_cpsw_nuss_remove_tx_chns() => Succeeds
>>     am65_cpsw_nuss_init_tx_chns() => Partially fails
>>       devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
>>       ^ DEVM Action is added, but since the driver isn't removed,
>>       the cleanup via am65_cpsw_nuss_free_tx_chns() will not run.
>>
>> Only when the user re-invokes am65_cpsw_nuss_update_tx_rx_chns(),
>> the cleanup will be performed. This might have to be fixed in the
>> following manner:
>>
>> @@ -3416,10 +3416,17 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
>>         common->tx_ch_num = num_tx;
>>         common->rx_ch_num_flows = num_rx;
>>         ret = am65_cpsw_nuss_init_tx_chns(common);
>> -       if (ret)
>> +       if (ret) {
>> +               devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
>> +               am65_cpsw_nuss_free_tx_chns(common);
>>                 return ret;
>> +       }
>>
>>         ret = am65_cpsw_nuss_init_rx_chns(common);
>> +       if (ret) {
>> +               devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
>> +               am65_cpsw_nuss_free_rx_chns(common);
>> +       }
>>
>>         return ret;
>>  }
>>
>>  Please let me know what you think.
> 
> I've already implemented a cleanup series to get rid of devm_add/remove_action,
> cleanup probe error path and streamline TX and RQ queue init/cleanup.
> I'll send out the series soon as soon as I finish some tests.
> 

-- 
cheers,
-roger



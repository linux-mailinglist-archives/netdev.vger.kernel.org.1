Return-Path: <netdev+bounces-158860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD86A1395D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E868168BE4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEC1DE4EC;
	Thu, 16 Jan 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOjCuGfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FC19FA92;
	Thu, 16 Jan 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028085; cv=none; b=Nf56YeM2PM42J967xs/r2bcThbgbm/S13SgJW+WeSqMN9XLOXXj1ribhqA4Kcsmwt5M/5r2JaH2jsEcdU+8tPSKqVieo2rseaATYI6q15DGtnXiMXIJcfGftwnus6r8AnK6oRtqMniRYddKlqPzGUtv6iBWqLV/rdQajADSfo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028085; c=relaxed/simple;
	bh=clOmASgvnqzZyxG7wHd+nBEyJHzoGXkbDU3R++H44KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8KnPoBrrh0i3P4LNKZWcJjRx11J3hvMHULsDsteaaX3WHr/+1t6Nc99gC7Zgu1c+ddFfOqItFeZ/QlOMHGULIQ0ascpqCLpcqgtPHkPFQHuBAQT8xFGHgnnDs88IoKC4+/1gc60np+7jva9o0ta1JOfJe6rea7LfOWruhOyczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOjCuGfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38507C4CEDF;
	Thu, 16 Jan 2025 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028084;
	bh=clOmASgvnqzZyxG7wHd+nBEyJHzoGXkbDU3R++H44KA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOjCuGfmk8z9jPNT/+J2jS7vCfY62IXHjcPg3KqTqNk37ycUVMHmA8kPHOhgLG6P7
	 td6ViX2UbN59kRAgHk5lk8+R/9p+3s2P/6Bd+ojfQRVGtI6+/RmW2SYQfjLu21rKsy
	 bWquoK3k8ZqnLDKhPXDWMscUejS8XvPEZGPifUmcn2l/H/+w+ED9iEkWUZtRdssqEy
	 dupnZgF6GaC+tlS9bGIxq7Ixd397VL4SIYgCwoTxG3ZpzVCchUKiTtFSpYIiYe2Ltv
	 q9xoAXB3+r178dqcHBxYsqSZmtvadfMndZWbc/ksDkUDQCyNIb9YDy/YgG66kAR5TJ
	 Jqa3rVhUdd83Q==
Message-ID: <e2d17324-39b8-4db5-85e7-bd66e67fcd52@kernel.org>
Date: Thu, 16 Jan 2025 13:47:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
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
 <8829d58b-fbfc-4040-93de-51970631d935@kernel.org>
 <2bhpxcdducequwchyobyinj3xp2vsnpxkshtwqy24swto6zqvz@mbnnn7calbhv>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2bhpxcdducequwchyobyinj3xp2vsnpxkshtwqy24swto6zqvz@mbnnn7calbhv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2025 07:15, Siddharth Vadapalli wrote:
> On Wed, Jan 15, 2025 at 06:38:57PM +0200, Roger Quadros wrote:
>> Siddharth,
>>
>> On 15/01/2025 17:49, Roger Quadros wrote:
>>> Hi Siddharth,
>>>
>>> On 15/01/2025 12:38, Siddharth Vadapalli wrote:
>>>> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
>>>>> Hi Siddharth,
>>>>>
>>>>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
>>>>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
>>>>>>
>>>>>> Hello Roger,
>>>>>>
>>>>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
>>>>>>
>>>>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
>>>>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
>>>>>
>>>>> Yes I meant tx instead of rx.
>>>>>
>>>>>>
>>>>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>>>>>
>>>>>> Additionally, following the above section we have:
>>>>>>
>>>>>> 		if (tx_chn->irq < 0) {
>>>>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
>>>>>> 				tx_chn->irq);
>>>>>> 			ret = tx_chn->irq;
>>>>>> 			goto err;
>>>>>> 		}
>>>>>>
>>>>>> Could you please provide details on the code-path which will lead to a
>>>>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
>>>>>>
>>>>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
>>>>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
>>>>>> 2. am65_cpsw_nuss_suspend()
>>>>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
>>>>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
>>>>>> appears to me that "tx_chn->irq" will never be negative within
>>>>>> am65_cpsw_nuss_remove_tx_chns()
>>>>>>
>>>>>> Please let me know if I have overlooked something.
>>>>>
>>>>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
>>>>> repeatedly (by user changing number of TX queues) even if previous call
>>>>> to am65_cpsw_nuss_init_tx_chns() failed.
>>>>
>>>> Thank you for clarifying. So the issue/bug was discovered since the
>>>> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
>>>> misled me. Maybe the "Fixes" tag should be updated? Though we should
>>>> code to future-proof it as done in this patch, the "Fixes" tag pointing
>>>> to the very first commit of the driver might not be accurate as the
>>>> code-path associated with the bug cannot be exercised at that commit.
>>>
>>> Fair enough. I'll change the Fixes commit.
>>
>> Now that I check the code again, am65_cpsw_nuss_remove_tx_chns(),
>> am65_cpsw_nuss_update_tx_chns() and am65_cpsw_nuss_init_tx_chns()
>> were all introduced in the Fixes commit I stated.
>>
>> Could you please share why you thought it is not accurate?
> 
> Though the functions were introduced in the Fixes commit that you have
> mentioned in the commit message, the check for "tx_chn->irq" being
> strictly positive as implemented in this patch, is not required until
> the commit which added am65_cpsw_nuss_update_tx_rx_chns(). The reason
> I say so is that a negative value for "tx_chn->irq" within
> am65_cpsw_nuss_remove_tx_chns() requires am65_cpsw_nuss_init_tx_chns()
> to partially fail *followed by* invocation of
> am65_cpsw_nuss_remove_tx_chns(). That isn't possible in the blamed
> commit which introduced them, since the driver probe fails when
> am65_cpsw_nuss_init_tx_chns() fails. The code path:
> 
> 	am65_cpsw_nuss_init_tx_chns() => Partially fails / Fails
> 	  am65_cpsw_nuss_remove_tx_chns() => Invoked later on
> 
> isn't possible in the blamed commit.

But, am65_cpsw_nuss_update_tx_chns() and am65_cpsw_set_channels() was
introduced in the blamed commit and the test case I shared to
test .set_channels with different channel counts can still
fail with warning if am65_cpsw_nuss_init_tx_chns() partially fails.

> 
> Regards,
> Siddharth.

-- 
cheers,
-roger



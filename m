Return-Path: <netdev+bounces-158888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59650A13A54
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BA188AF88
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD21DE899;
	Thu, 16 Jan 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAIXyiuD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27FB24A7C2;
	Thu, 16 Jan 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032453; cv=none; b=KcyndYB020TN+JtBGoDsY7TYNZwtvwnvx/7CHtpezxcnarF+Vka2KZHaUdTmG4M7HsgdHVtk/OTJlb90YKiyO3CjXZR2fvTtwPwJz+5TiZpH/8Oy0Q1uo57lj8ResJqr+wER0b1ZEiUoHEezqqeW3Wx86SLewxrDXB0LaQGxi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032453; c=relaxed/simple;
	bh=OayDs9CzsfamNNuo2QzEV1pwaK+L1bAdF0n6M33jwtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buGFAvAGkjjyWm5GGtyQDOLmNIsV/MIODO6wWtSns3sqnpoDCshs5MtDOBjZyIfjy/rguZTqGuAmhgYsdczSROVpR1zuyNbjQC45eENyrLp8a597YaKMS4EWVLZ4Pu1XTu6GH8tWFTsC5Sb03/2xhy38l9SBdDQH550tDSmcLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAIXyiuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89ECC4CED6;
	Thu, 16 Jan 2025 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737032452;
	bh=OayDs9CzsfamNNuo2QzEV1pwaK+L1bAdF0n6M33jwtg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eAIXyiuD55vnW2c334kLxAP++EwTvQ+RHchpHUJXIBknhGV3XtuBmrjDnFmBANMdL
	 fHkzcpZZBe4CDqSKQ9WZNqHY8YpaVMk+ZyNzLzEssyzGvC5OcOSNqQDA3zRawtL6iH
	 FUuL0xN54hUqHNzl6a5F8s4rHsH4BJJYYKAVQ+2x58qN8MOtGM7Akrkcz1n6WcIrTc
	 wL1xe+jJkcpeLzWtwG9kjdWf38ZgSJclZCLERF+HhXjA2nVdGFXgmBNhWcO0bEc3ER
	 iIayDpPi3BlToebxbxcHUXvuMBmx8WL9/KG0TYZNhFUDruds0RYCC27ZZeSPSx2aUC
	 ikk130rLsx3Eg==
Message-ID: <0004a78f-6802-4c47-9f1f-414cdecb2b2e@kernel.org>
Date: Thu, 16 Jan 2025 15:00:47 +0200
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
 <e2d17324-39b8-4db5-85e7-bd66e67fcd52@kernel.org>
 <yhxlrqqt4cuxp2hkv7nm7h5i25jjaxjhmuzhlvpfwb24jga7o2@f47d4wqe75tu>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <yhxlrqqt4cuxp2hkv7nm7h5i25jjaxjhmuzhlvpfwb24jga7o2@f47d4wqe75tu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2025 14:10, Siddharth Vadapalli wrote:
> On Thu, Jan 16, 2025 at 01:47:59PM +0200, Roger Quadros wrote:
>>
>>
>> On 16/01/2025 07:15, Siddharth Vadapalli wrote:
>>> On Wed, Jan 15, 2025 at 06:38:57PM +0200, Roger Quadros wrote:
>>>> Siddharth,
>>>>
>>>> On 15/01/2025 17:49, Roger Quadros wrote:
>>>>> Hi Siddharth,
>>>>>
>>>>> On 15/01/2025 12:38, Siddharth Vadapalli wrote:
>>>>>> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
>>>>>>> Hi Siddharth,
>>>>>>>
>>>>>>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
>>>>>>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
>>>>>>>>
>>>>>>>> Hello Roger,
>>>>>>>>
>>>>>>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
>>>>>>>>
>>>>>>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
>>>>>>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
>>>>>>>
>>>>>>> Yes I meant tx instead of rx.
>>>>>>>
>>>>>>>>
>>>>>>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>>>>>>>
>>>>>>>> Additionally, following the above section we have:
>>>>>>>>
>>>>>>>> 		if (tx_chn->irq < 0) {
>>>>>>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
>>>>>>>> 				tx_chn->irq);
>>>>>>>> 			ret = tx_chn->irq;
>>>>>>>> 			goto err;
>>>>>>>> 		}
>>>>>>>>
>>>>>>>> Could you please provide details on the code-path which will lead to a
>>>>>>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
>>>>>>>>
>>>>>>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
>>>>>>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
>>>>>>>> 2. am65_cpsw_nuss_suspend()
>>>>>>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
>>>>>>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
>>>>>>>> appears to me that "tx_chn->irq" will never be negative within
>>>>>>>> am65_cpsw_nuss_remove_tx_chns()
>>>>>>>>
>>>>>>>> Please let me know if I have overlooked something.
>>>>>>>
>>>>>>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
>>>>>>> repeatedly (by user changing number of TX queues) even if previous call
>>>>>>> to am65_cpsw_nuss_init_tx_chns() failed.
>>>>>>
>>>>>> Thank you for clarifying. So the issue/bug was discovered since the
>>>>>> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
>>>>>> misled me. Maybe the "Fixes" tag should be updated? Though we should
>>>>>> code to future-proof it as done in this patch, the "Fixes" tag pointing
>>>>>> to the very first commit of the driver might not be accurate as the
>>>>>> code-path associated with the bug cannot be exercised at that commit.
>>>>>
>>>>> Fair enough. I'll change the Fixes commit.
>>>>
>>>> Now that I check the code again, am65_cpsw_nuss_remove_tx_chns(),
>>>> am65_cpsw_nuss_update_tx_chns() and am65_cpsw_nuss_init_tx_chns()
>>>> were all introduced in the Fixes commit I stated.
>>>>
>>>> Could you please share why you thought it is not accurate?
>>>
>>> Though the functions were introduced in the Fixes commit that you have
>>> mentioned in the commit message, the check for "tx_chn->irq" being
>>> strictly positive as implemented in this patch, is not required until
>>> the commit which added am65_cpsw_nuss_update_tx_rx_chns(). The reason
>>> I say so is that a negative value for "tx_chn->irq" within
>>> am65_cpsw_nuss_remove_tx_chns() requires am65_cpsw_nuss_init_tx_chns()
>>> to partially fail *followed by* invocation of
>>> am65_cpsw_nuss_remove_tx_chns(). That isn't possible in the blamed
>>> commit which introduced them, since the driver probe fails when
>>> am65_cpsw_nuss_init_tx_chns() fails. The code path:
>>>
>>> 	am65_cpsw_nuss_init_tx_chns() => Partially fails / Fails
>>> 	  am65_cpsw_nuss_remove_tx_chns() => Invoked later on
>>>
>>> isn't possible in the blamed commit.
>>
>> But, am65_cpsw_nuss_update_tx_chns() and am65_cpsw_set_channels() was
>> introduced in the blamed commit and the test case I shared to
>> test .set_channels with different channel counts can still
>> fail with warning if am65_cpsw_nuss_init_tx_chns() partially fails.
> 
> I was looking for "am65_cpsw_nuss_update_tx_rx_chns()" in the blamed
> commit. I realize now that it was renamed from
> am65_cpsw_nuss_update_tx_chns() which indeed is present in the blamed
> commit. I apologize for the confusion caused.
> 

No worries at all. I'll respin the patch with the typo fix and add more
description in commit log to clarify this.

-- 
cheers,
-roger



Return-Path: <netdev+bounces-226754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B3CBA4BA9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C204A2F1F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFE30B539;
	Fri, 26 Sep 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zPmry0cB"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC730597F;
	Fri, 26 Sep 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905944; cv=none; b=Yr8fkLGha7rT3QW33QAjr3UhDAPoC1Q4NcziFFSbUAISUYVycV2DMKrx2poeQNN/RWq2UsMAiQfHuhI2fNqqcLe8yQA2Yh3MIgY0hATuja4iczmUDPW64SQTxUcAzdtlYeYSHPfz+5FE9EELNbOSlrDFyOBXPUABu0+ZYtMfjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905944; c=relaxed/simple;
	bh=Nv1y1fToKCLS5D56SGWW3Fu02+TSW9GRhBBGCOoj1CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L21c4xznzSwn8GBal+LEJ4pV8mLybURe7prtjrRzIba9W+jll5q8JWzPkLhQ/nAdCEKGrVD81Vcu1K8smFwnGISg2tCdy0Yvg/LGM+SJorZE5CF6VJrRXBqd+mSlSrnSUVAhOlwVZ0TrGQcRvtfwJwH5OgkZYc/nXuNfOfPm6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zPmry0cB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58QGwqoq1724430;
	Fri, 26 Sep 2025 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758905932;
	bh=I+fvoCdpVjcpW6UNDPo2u0wUq3wToFlQcHSjQljHVmc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zPmry0cBQUeAHT8RLuJArVnm2ZntV5ECbGa/ln5JQhEw3Zz9drcNLP3yK/M2hZvTp
	 FBk+5XfIN6xTdvygI6Y0dZ6jZM8c7tYLxvpO8vVxmfdnGz2LLMGYb2jSFZj6BBMToc
	 xHhzpbs46h779CU+nnRpAJvjEgvKW/Fqd5HefI28=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58QGwq3q3562496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 26 Sep 2025 11:58:52 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 26
 Sep 2025 11:58:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Sep 2025 11:58:52 -0500
Received: from [10.249.139.123] ([10.249.139.123])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58QGwm3w1617584;
	Fri, 26 Sep 2025 11:58:48 -0500
Message-ID: <08a13fb0-dd12-491e-98af-ef67d55cc403@ti.com>
Date: Fri, 26 Sep 2025 22:28:47 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: netcp: Fix crash in error path when DMA channel open
 fails
To: Simon Horman <horms@kernel.org>
CC: Nishanth Menon <nm@ti.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20250926150853.2907028-1-nm@ti.com>
 <aNa7rEQLJreJF58p@horms.kernel.org>
 <ef2bd666-f320-4dc5-b7ae-d12c0487c284@ti.com>
 <aNbCgK76kQqhcQY2@horms.kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <aNbCgK76kQqhcQY2@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 26/09/25 10:12 PM, Simon Horman wrote:
> On Fri, Sep 26, 2025 at 09:57:02PM +0530, Siddharth Vadapalli wrote:
>> On 26/09/25 9:43 PM, Simon Horman wrote:
>>> On Fri, Sep 26, 2025 at 10:08:53AM -0500, Nishanth Menon wrote:
>>>> When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
>>>> the rx_channel field is set to an ERR_PTR value. Later, when
>>>> netcp_free_navigator_resources() is called in the error path, it attempts
>>>> to close this invalid channel pointer, causing a crash.
>>>>
>>>> Add a check for ERR values to handle the failure scenario.
>>>>
>>>> Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>
>>>> Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz
>>>>
>>>>    drivers/net/ethernet/ti/netcp_core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
>>>> index 857820657bac..4ff17fd6caae 100644
>>>> --- a/drivers/net/ethernet/ti/netcp_core.c
>>>> +++ b/drivers/net/ethernet/ti/netcp_core.c
>>>> @@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
>>>>    {
>>>>    	int i;
>>>> -	if (netcp->rx_channel) {
>>>> +	if (!IS_ERR(netcp->rx_channel)) {
>>>>    		knav_dma_close_channel(netcp->rx_channel);
>>>>    		netcp->rx_channel = NULL;
>>>>    	}
>>>
>>> Hi Nishanth,
>>>
>>> Thanks for your patch.
>>>
>>> I expect that netcp_txpipe_close() has a similar problem too.
>>>
>>> But I also think that using IS_ERR is not correct, because it seems to me
>>> that there are also cases where rx_channel can be NULL.
>>
>> Could you please clarify where rx_channel is NULL? rx_channel is set by
>> invoking knav_dma_open_channel().
> 
> Hi Siddharth,
> 
> I am assuming that when netcp_setup_navigator_resources() is called, at
> least for the first time, that netcp->rx_channel is NULL. So any of the
> occurrence of 'goto fail' in that function before the call to
> knav_dma_open_channel().

I missed this. Thank you for pointing this out.

> 
>> Also, please refer to:
>> https://github.com/torvalds/linux/commit/5b6cb43b4d62
>> which specifically points out that knav_dma_open_channel() will not return
>> NULL so the check for NULL isn't required.
>>>
>>> I see that on error knav_dma_open_channel() always returns ERR_PTR(-EINVAL)
>>> (open coded as (void *)-EINVAL) on error. So I think a better approach
>>> would be to change knav_dma_open_channel() to return NULL, and update callers
>>> accordingly.
>>
>> The commit referred to above made changes to the driver specifically due to
>> the observation that knav_dma_open_channel() never returns NULL. Modifying
>> knav_dma_open_channel() to return NULL will effectively result in having to
>> undo the changes made by the commit.
> 
> I wasn't aware of that patch. But my observation is that the return value
> of knav_dma_open_channel() is still not handled correctly. E.g. the bug
> your patch is fixing.  And I'm proposing an alternate approach which I feel
> will be less error-prone.

Ok. If I understand correctly, you are proposing that the 'error codes' 
returned by knav_dma_open_channel() should be turned into a dev_err() 
print for the user and knav_dma_open_channel() should always return NULL 
in case of failure and a pointer to the channel in case of success. Is 
that right?


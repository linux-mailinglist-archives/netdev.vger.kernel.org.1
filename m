Return-Path: <netdev+bounces-210767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BEB14B97
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9BD189C040
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6D236A9C;
	Tue, 29 Jul 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mw/RjNVM"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF00230D35;
	Tue, 29 Jul 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782473; cv=none; b=q85aMdmIQ2zs6QxV/aMvz2kTIY/CEe2xRXCUbYR1kRmOldkVugVHCLwvG9CyifAV4NG01iX+sRZzGsaX5JXIX4fH5A9IGrDW11N+lyC5f6s1IBiFqc71IpITgBMdQIBDm8nHB3EpULtqdE5mYiELePugXTpkmZVmOAdytvAIp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782473; c=relaxed/simple;
	bh=kiAVxOybSUMykd1nOkBhLdpaX405dvJtvP0kD4q0ZUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UCZDNHU85gMM67RLfx/hGQik82oRMYg0E8zlPxVe1ZCZ4bUJo3Tyc/vyngaxJoo8eyOgHtZBlcfrk8gnFUO0czka6mpN3LjQfSSKXfuVbVNL0QBzDBhcbpWBrkDPj0Xj/ee60A3bT/fSFgaAqeRXs4WsdsUuY2dWHva3PEMxRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mw/RjNVM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56T9kaku2518997;
	Tue, 29 Jul 2025 04:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753782396;
	bh=rW2guRXzVdSnP3kefofJSWnAepPy1N5zFafQ9pBYRpE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mw/RjNVMo6aBuUR2RkpjfrSTMPitgl+f7aFpDFUxKhzsrVssKPY2b1hL+Ynt41I6K
	 AN9uVNpjfRShIoAdvJqECtMXtvknjRxYvDjg1szUFgPr2GmtyofClCn0HatJKKs24K
	 FkXziYWTbOakABGqOHO5lf2V9OSQHmjMjKJWTnfE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56T9kZQe2365503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 29 Jul 2025 04:46:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 04:46:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 04:46:35 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56T9kTTA3221409;
	Tue, 29 Jul 2025 04:46:30 -0500
Message-ID: <66377d5d-b967-451f-99d9-8aea5f8875d3@ti.com>
Date: Tue, 29 Jul 2025 15:16:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-3-danishanwar@ti.com>
 <296d6846-6a28-4e53-9e62-3439ac57d9c1@kernel.org>
 <5f4e1f99-ff71-443f-ba34-39396946e5b4@ti.com>
 <cabacd59-7cbf-403a-938f-371026980cc7@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <cabacd59-7cbf-403a-938f-371026980cc7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 28/07/25 6:10 pm, Krzysztof Kozlowski wrote:
> On 28/07/2025 10:10, MD Danish Anwar wrote:
>> Hi Krzysztof,
>>
>> On 25/07/25 12:48 am, Krzysztof Kozlowski wrote:
>>> On 23/07/2025 10:03, MD Danish Anwar wrote:
>>>> This patch introduces a basic RPMSG Ethernet driver skeleton. It adds
>>>
>>> Please do not use "This commit/patch/change", but imperative mood. See
>>> longer explanation here:
>>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>>
>>
>> Sure. I will fix this in v2.
>>
>>>> support for creating virtual Ethernet devices over RPMSG channels,
>>>> allowing user-space programs to send and receive messages using a
>>>> standard Ethernet protocol. The driver includes message handling,
>>>> probe, and remove functions, along with necessary data structures.
>>>>
>>>
>>>
>>> ...
>>>
>>>> +
>>>> +/**
>>>> + * rpmsg_eth_get_shm_info - Get shared memory info from device tree
>>>> + * @common: Pointer to rpmsg_eth_common structure
>>>> + *
>>>> + * Return: 0 on success, negative error code on failure
>>>> + */
>>>> +static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
>>>> +{
>>>> +	struct device_node *peer;
>>>> +	const __be32 *reg;
>>>> +	u64 start_address;
>>>> +	int prop_size;
>>>> +	int reg_len;
>>>> +	u64 size;
>>>> +
>>>> +	peer = of_find_node_by_name(NULL, "virtual-eth-shm");
>>>
>>>
>>> This is new ABI and I do not see earlier patch documenting it.
>>>
>>> You cannot add undocumented ABI... but even if you documented it, I am
>>> sorry, but I am pretty sure it is wrong. Why are you choosing random
>>> nodes just because their name by pure coincidence is "virtual-eth-shm"?
>>> I cannot name my ethernet like that?
>>>
>>
>> This series adds a new virtual ethernet driver. The tx / rx happens in a
>> shared memory block. I need to have a way for the driver to know what is
>> the address / size of this block. This driver can be used by any
>> vendors. The vendors can create a new node in their dt and specify the
>> base address / size of the shared memory block.
>>
>> I wanted to keep the name of the node constant so that the driver can
>> just look for this name and then grab the address and size.
> 
> You should not.
> 
>>
>> I can create a new binding file for this but I didn't create thinking
>> it's a virtual device not a physical and I wasn't sure if bindings can
>> be created for virtual devices.
> 
> So you added undocumented ABI intentionally, sorry, that's a no go.
> 
>>
>> In my use case, I am reserving this shared memory and during reserving I
>> named the node "virtual-eth-shm". The memory is reserved by the
>> ti_k3_r5_remoteproc.c driver. The DT change is not part of this series
>> but can be found
>> https://gist.github.com/danish-ti/cdd10525ad834fdb20871ab411ff94fb
>>
>> The idea is any vendor who want to use this driver, should name their dt
>> node as "virtual-eth-shm" (if they also need to reserve the memory) so
>> that the driver can take the address from DT and use it for tx / rx.
>>
>> If this is not the correct way, can you please let me know of some other
>> way to handle this.
>>
>> One idea I had was to create a new binding for this node, and use
>> compatible string to access the node in driver. But the device is
>> virtual and not physical so I thought that might not be the way to go so
>> I went with the current approach.
> 
> virtual devices do not go to DTS anyway. How do you imagine this works?
> You add it to DTS but you do not add bindings and you expect checks to
> succeed?
> 
> Provide details how you checked your DTS compliance.
> 
> 

This is my device tree patch [1]. I ran these two commands before and
after applying the patch and checked the diff.

	make dt_binding_check
	make dtbs_check

I didn't see any new error / warning getting introduced due to the patch

After applying the patch I also ran,

	make CHECK_DTBS=y ti/k3-am642-evm.dtb

I still don't see any warnings / error.


If you look at the DT patch, you'll see I am adding a new node in the
`reserved-memory`. I am not creating a completely new undocumented node.
Instead I am creating a new node under reserved-memory as the shared
memory used by rpmsg-eth driver needs to be reserved first. This memory
is reserved by the ti_k3_r5_remoteproc driver by k3_reserved_mem_init().

It's just that I am naming this node as "virtual-eth-shm@a0400000" and
then using the same name in driver to get the base_address and size
mentioned in this node.


> 
> Best regards,
> Krzysztof


[1]
https://gist.githubusercontent.com/danish-ti/fd3e630227ae5b165e12eabd91b0dc9d/raw/67d7c15cd1c47a29c0cfd3674d7cd6233ef1bea5/0001-arch-arm64-dts-k3-am64-Add-shared-memory-node.patch

-- 
Thanks and Regards,
Danish



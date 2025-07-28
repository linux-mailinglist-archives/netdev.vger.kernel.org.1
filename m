Return-Path: <netdev+bounces-210451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CAB13617
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15621727EC
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF0221FB1;
	Mon, 28 Jul 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ouV4AEEf"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F028DD0;
	Mon, 28 Jul 2025 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690327; cv=none; b=ctn5AcN4xR3TOGICa+ffdkwZiI6NOkqxNZJkVJXN01BG6C3gpMu3mFeevNO/HvHjRo+u0pGlhWp9i2q+0wJQTBMGKTgwdue82gPkzHsG5g7b9cXsGoVAsmErkQ7A4CGyXCK2XiKNeamKpEmendBymbq6mwooimfgY7oZx/O/oDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690327; c=relaxed/simple;
	bh=BEuewBk1IsEGl3eghjVYYbwM2YS0qLIe5ka6Gd1mDoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V1D9avu/6dFuCJxbZYcpbLsH3vrJkJrnMZTrrBKeprp903QV8Q9Tusoy3h2IicKcp3zy75hFWhYph38ylYKeOYcn8Qd4h2J2Tg9bOVhb8qbW3NE6/WxjfazO/JjoadOZxx0tuFHeHREmtuUBxHj52iz93ie8nOGZrA7r6gLbjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ouV4AEEf; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56S8B7ox2715293;
	Mon, 28 Jul 2025 03:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753690267;
	bh=KHcr5mpVfk9mCi5rZVeNOZkpkFw0VJp9vZS5ooiXtHE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ouV4AEEfdgbQ17atKqfIxb5OAjmal+19WqsEDUKuH4ZLcK9HQLJ7KQz1UiGBaR7AE
	 ow4YjJK+Edb2AJx4vXTNwYpPTKV7r1wqpAs33kEkbgoH2jRrbQELcIH8P7sitnfVQC
	 4YrOGJLZqXFm9TPdj62uYf9S4FnidrC2qo/RPKTw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56S8B6Af915220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 28 Jul 2025 03:11:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 28
 Jul 2025 03:11:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 28 Jul 2025 03:11:06 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56S8B08W1426296;
	Mon, 28 Jul 2025 03:11:01 -0500
Message-ID: <5f4e1f99-ff71-443f-ba34-39396946e5b4@ti.com>
Date: Mon, 28 Jul 2025 13:40:59 +0530
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
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <296d6846-6a28-4e53-9e62-3439ac57d9c1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 25/07/25 12:48 am, Krzysztof Kozlowski wrote:
> On 23/07/2025 10:03, MD Danish Anwar wrote:
>> This patch introduces a basic RPMSG Ethernet driver skeleton. It adds
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 

Sure. I will fix this in v2.

>> support for creating virtual Ethernet devices over RPMSG channels,
>> allowing user-space programs to send and receive messages using a
>> standard Ethernet protocol. The driver includes message handling,
>> probe, and remove functions, along with necessary data structures.
>>
> 
> 
> ...
> 
>> +
>> +/**
>> + * rpmsg_eth_get_shm_info - Get shared memory info from device tree
>> + * @common: Pointer to rpmsg_eth_common structure
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
>> +{
>> +	struct device_node *peer;
>> +	const __be32 *reg;
>> +	u64 start_address;
>> +	int prop_size;
>> +	int reg_len;
>> +	u64 size;
>> +
>> +	peer = of_find_node_by_name(NULL, "virtual-eth-shm");
> 
> 
> This is new ABI and I do not see earlier patch documenting it.
> 
> You cannot add undocumented ABI... but even if you documented it, I am
> sorry, but I am pretty sure it is wrong. Why are you choosing random
> nodes just because their name by pure coincidence is "virtual-eth-shm"?
> I cannot name my ethernet like that?
> 

This series adds a new virtual ethernet driver. The tx / rx happens in a
shared memory block. I need to have a way for the driver to know what is
the address / size of this block. This driver can be used by any
vendors. The vendors can create a new node in their dt and specify the
base address / size of the shared memory block.

I wanted to keep the name of the node constant so that the driver can
just look for this name and then grab the address and size.

I can create a new binding file for this but I didn't create thinking
it's a virtual device not a physical and I wasn't sure if bindings can
be created for virtual devices.

In my use case, I am reserving this shared memory and during reserving I
named the node "virtual-eth-shm". The memory is reserved by the
ti_k3_r5_remoteproc.c driver. The DT change is not part of this series
but can be found
https://gist.github.com/danish-ti/cdd10525ad834fdb20871ab411ff94fb

The idea is any vendor who want to use this driver, should name their dt
node as "virtual-eth-shm" (if they also need to reserve the memory) so
that the driver can take the address from DT and use it for tx / rx.

If this is not the correct way, can you please let me know of some other
way to handle this.

One idea I had was to create a new binding for this node, and use
compatible string to access the node in driver. But the device is
virtual and not physical so I thought that might not be the way to go so
I went with the current approach.

> Best regards,
> Krzysztof

-- 
Thanks and Regards,
Danish



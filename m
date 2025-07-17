Return-Path: <netdev+bounces-207798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F0B08969
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9BA172439
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89928A40C;
	Thu, 17 Jul 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jt+ZgRWa"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1219DFA2;
	Thu, 17 Jul 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745074; cv=none; b=HQ0tt6vnvFF7mtqd2bxLqUihNRiZSR2gps+b4f9gHv2N0ROpb79Nstn57yir0ExiWrWOgN2JIb/w+7GZA7QfjAcLGE+dJfgibd7MTzlcTj2e4LM0/4NcyJa90HEr1UBHlVQFRYWC9BvKmD/gSYCK/az3EJTyS0nCGqo7MtUCAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745074; c=relaxed/simple;
	bh=M8y+OfB3/gTGlHiZRmj3zVXgpIHR8e4nTN+jjclnz8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fAwQapQlmlwrIhTpyRwqT54pd7dA1kUN7lJgiFDT9Vj0wcI7Mprg1opyBx8BLQm1vYFSTVoCGa785CMxfxRVkMc5IcVbpSLwavxkMukxrUNVPyFOkdw7g9xh/j4P8tA7DksJLU18dkkOhS9DaIogProA5LDhEPye5p5ggovJ9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jt+ZgRWa; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56H9bMY33050978;
	Thu, 17 Jul 2025 04:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752745042;
	bh=rnORj6AwUklafQliia+PljSSSNZViblW/zSxNbyZ6Ks=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Jt+ZgRWaRZ9mL/QoDBRinVRNWfgjmmowSR6IC9lqeRJJRsT+As4WaU6+WafqPJuzf
	 e02vXZR4TEY59hWvhsAL1Hip/MTvyoJXyoTk3yrpg9dVQu9hHcCh0NIIpI4SpI8phA
	 xPs8ZgH2RnJpazm6Q9ldLMnN00LEMttHjOp51pS4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56H9bLWX128452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 17 Jul 2025 04:37:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 17
 Jul 2025 04:37:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 17 Jul 2025 04:37:21 -0500
Received: from [172.24.29.51] (ltpw0g6zld.dhcp.ti.com [172.24.29.51])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56H9bBNA1949782;
	Thu, 17 Jul 2025 04:37:12 -0500
Message-ID: <94196b50-1fd7-410e-83e8-b71bb6835acd@ti.com>
Date: Thu, 17 Jul 2025 15:07:10 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
To: Simon Horman <horms@kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
References: <20250710131250.1294278-1-h-mittal1@ti.com>
 <20250711144323.GV721198@horms.kernel.org>
 <b626dc40-e05b-40e0-b300-45ced82d2f97@ti.com>
 <20250715102943.GU721198@horms.kernel.org>
Content-Language: en-US
From: "MITTAL, HIMANSHU" <h-mittal1@ti.com>
In-Reply-To: <20250715102943.GU721198@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/15/2025 3:59 PM, Simon Horman wrote:
> On Tue, Jul 15, 2025 at 12:37:45PM +0530, MITTAL, HIMANSHU wrote:
>
> ...
>
>>>> +-----+-----------------------------------------------+
>>>> |     |       SLICE 0       |        SLICE 1          |
>>>> |     +------------+----------+------------+----------+
>>>> |     | Start addr | End addr | Start addr | End addr |
>>>> +-----+------------+----------+------------+----------+
>>>> | EXP | 70024000   | 70028000 | 7002C000   | 70030000 | <-- Overlapping
>>> Thanks for the detailed explanation with these tables.
>>> It is very helpful. I follow both the existing and new mappings
>>> with their help. Except for one thing.
>>>
>>> It's not clear how EXP was set to the values on the line above.
>>> Probably I'm missing something very obvious.
>>> Could you help me out here?
>> The root cause for this issue is that, buffer configuration for Express
>> Frames
>> in function: prueth_fw_offload_buffer_setup() is missing.
>>
>>
>> Details:
>> The driver implements two distinct buffer configuration functions that are
>> invoked
>> based on the driver state and ICSSG firmware:-
>> prueth_fw_offload_buffer_setup()
>> - prueth_emac_buffer_setup()
>>
>> During initialization, the driver creates standard network interfaces
>> (netdevs) and
>> configures buffers via prueth_emac_buffer_setup(). This function properly
>> allocates
>> and configures all required memory regions including:
>> - LI buffers
>> - Express packet buffers
>> - Preemptible packet buffers
>>
>> However, when the driver transitions to an offload mode (switch/HSR/PRP),
>> buffer reconfiguration is handled by prueth_fw_offload_buffer_setup().
>> This function does not reconfigure the buffer regions required for Express
>> packets,
>> leading to incorrect buffer allocation.
> Thanks for your patience, I see that now :)
>
> I'm sorry to drag this out, but I do think it would be useful to add
> information above the lines of the above to the patch description.
Thanks for the feedback, I will add this information and create an 
updated patch.
>>>> | PRE | 70030000   | 70033800 | 70034000   | 70037800 |
>>>> +-----+------------+----------+------------+----------+
>>>>
>>>> +---------------------+----------+----------+
>>>> |                     | SLICE 0  |  SLICE 1 |
>>>> +---------------------+----------+----------+
>>>> | Default Drop Offset | 00000000 | 00000000 |     <-- Field not configured
>>>> +---------------------+----------+----------+
>>> ...


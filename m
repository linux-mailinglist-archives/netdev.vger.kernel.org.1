Return-Path: <netdev+bounces-235769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52462C3522C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2760189178B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B20304BB3;
	Wed,  5 Nov 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="rNNKgbnU"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248333019B5;
	Wed,  5 Nov 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339222; cv=none; b=mE8+Kbvo4E1027hMC8HTu59FwXuTCYXWyPb5rxYMbi4I1H1bLE2DNXcF2aYG8xWrO1jcG4Y8XXmCLeTj1oEKNHbNaO6L2M3JQ7ST6sseHl8NlGVeVqXoEmZJSz8J3gt/gntKo73xJBeb3IeEfMrFK+IbKlRhsq7Yug2YVUU/6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339222; c=relaxed/simple;
	bh=R3jljbFqqFcfTTgDjbIDQG3Qtt+CFZVQsTMVYo1l9W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7TUX9t8AXzY26/rHFP4Lwe4YiNBxte20jl5D44xgmdRSsLvsyk93zzTliGuP2cjXego4WtrjCmz5CxVrldW9EBuh29RyNPYYFnK5bF0Hb7kZnZPJIWCRHr+HwrK2dzNON+/ZFrI5DA1UM5r4CqfPIFsJL3CHP+yBOfGE9AbtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=rNNKgbnU; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.196] ([129.217.186.196])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A5AeExP008316
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 11:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762339215;
	bh=R3jljbFqqFcfTTgDjbIDQG3Qtt+CFZVQsTMVYo1l9W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rNNKgbnUt0201zLpgnEFdqj227KVjRfp6YkWMKm/j4sCKlm2TV5vrmy6JXIlhDrW5
	 8Rsb7WzMJW6EWxuA9LUzbiOIIm0CbnfWp9CMvN7SZSOBR1gEoDWrexFObH0g/LxR0D
	 4wlrI/5SiQnD75r31xo5CRjMF+KFlM/nptTVSQYc=
Message-ID: <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
Date: Wed, 5 Nov 2025 11:40:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits
 (BQL)
To: Eric Dumazet <edumazet@google.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 18:02, Eric Dumazet wrote:
> On Tue, Nov 4, 2025 at 8:14 AM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
>>
>> During recent testing, I observed significant latency spikes when using
>> Quectel 5G modems under load. Investigation revealed that the issue was
>> caused by bufferbloat in the usbnet driver.
>>
>> In the current implementation, usbnet uses a fixed tx_qlen of:
>>
>> USB2: 60 * 1518 bytes = 91.08 KB
>> USB3: 60 * 5 * 1518 bytes = 454.80 KB
>>
>> Such large transmit queues can be problematic, especially for cellular
>> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
>> fully occupied USB3 transmit queue results in:
>>
>> 454.80 KB / (10 Mbit/s / 8 bit/byte) = 363.84 ms
>>
>> of additional latency.
> 
> Doesn't 5G need to push more packets to the driver to get good aggregation ?
> 

Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
aggregate enough packets for a frame but not of several hundred ms as
calculated in my example. And yes, there are situations where 5G,
especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
required. But the dynamic queue limit approach of BQL should be well
suited for these varying speeds.

>>
>> To address this issue, this patch introduces support for
>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
>> limits the amount of data queued in the driver, effectively reducing
>> latency without impacting throughput.
>> This implementation was successfully tested on several devices as
>> described in the commit.
>>
>>
>>
>> Future work
>>
>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
> 
> Only for rates > 500 Mbit. After BQL, we had many more improvements in
> the stack.
> https://lwn.net/Articles/564978/
> 
> 

I also saw these large SKBs, for example, for my USB2 Android tethering,
which advertises a network speed of < 500 Mbit/s.
I saw these large SKBs by looking at the file:

cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight

For UDP-only traffic, inflight always maxed out at MTU size.

Thank you for your replies!

>> To
>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO but it
>> did not have the intended effect in my tests. The only dirty workaround I
>> found so far was to call netif_stop_queue() whenever BQL sets
>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue would
>> be desirable.
>>
>> I also plan to publish a scientific paper on this topic in the near
>> future.
>>
>> Thanks,
>> Simon
>>
>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>> [2] https://lwn.net/Articles/469652/
>>
>> Simon Schippers (1):
>>   usbnet: Add support for Byte Queue Limits (BQL)
>>
>>  drivers/net/usb/usbnet.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> --
>> 2.43.0
>>


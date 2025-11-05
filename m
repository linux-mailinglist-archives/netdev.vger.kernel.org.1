Return-Path: <netdev+bounces-235771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08AC3549C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07FB234E5CE
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA4330F547;
	Wed,  5 Nov 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="hHOQqHd4"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A4E309F08;
	Wed,  5 Nov 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340707; cv=none; b=dpa9dScnrprIG/vIibDve3KYtCYENaYNHZ1s0OgZvatBVdWAp3Ovb+tDfWCIrFL62ZZUTFiY9JjvCd7LLhZMilcA435D2y8ue527nuHXNYVk7TuQEs1dogNDk648djDAkMYud5Kqz5EK6Gr7pJkaxChpPBj8OyJzrkaegrzD9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340707; c=relaxed/simple;
	bh=Fbrkx2MhU9lvTEzh05dOhsEKES26ch45OyV5zMyNgMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVXNod+QGrCcq8dE4RIrKZMzbcoPSeebS9CzN8HC9sXbLIVaM6j4u/N2PaFjZW4lPJuX/sT1oKZvXme1LU6DCbQoN/zexvSMsmHEpZIubThdOT8+Kz348lHIJ2MXZbgmogpYS4DQO6y7Lt3lJO4FjQ0gGPlK08ibuFbtTye9AuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=hHOQqHd4; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.196] ([129.217.186.196])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A5B4xbN012832
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Nov 2025 12:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762340700;
	bh=Fbrkx2MhU9lvTEzh05dOhsEKES26ch45OyV5zMyNgMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hHOQqHd46ywJlGrOjkw4ZGuyd/a+qflaNOEERuKc4UyJdpTNzc0JmATSFUhgd8zQZ
	 hCFEltifg3wb18xnLufVue3ya2r9dU+N6CaxDmn8vbgiwYBNGHVmSEmteKyI3hHtTQ
	 Wmv/FKRWXa1v4Na6wUJGfFmh3fmVU+4Sm0Bd8XUE=
Message-ID: <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
Date: Wed, 5 Nov 2025 12:04:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v1 0/1] usbnet: Add support for Byte Queue Limits
 (BQL)
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, oneukum@suse.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <CANn89iLLwWvbnCKKRrV2c7eo+4UduLVgZUWR=ZoZ+SPHRGf=wg@mail.gmail.com>
 <f2a363d3-40d7-4a5f-a884-ec147a167ef5@tu-dortmund.de>
 <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CAGRyCJERd93kE3BsoXCVRuRAVuvubt5udcyNMuEZBTcq2r+hcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/5/25 11:35, Daniele Palmas wrote:
> Hello Simon,
> 
> Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
> <simon.schippers@tu-dortmund.de> ha scritto:
>>
>> On 11/4/25 18:02, Eric Dumazet wrote:
>>> On Tue, Nov 4, 2025 at 8:14 AM Simon Schippers
>>> <simon.schippers@tu-dortmund.de> wrote:
>>>>
>>>> During recent testing, I observed significant latency spikes when using
>>>> Quectel 5G modems under load. Investigation revealed that the issue was
>>>> caused by bufferbloat in the usbnet driver.
>>>>
>>>> In the current implementation, usbnet uses a fixed tx_qlen of:
>>>>
>>>> USB2: 60 * 1518 bytes = 91.08 KB
>>>> USB3: 60 * 5 * 1518 bytes = 454.80 KB
>>>>
>>>> Such large transmit queues can be problematic, especially for cellular
>>>> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
>>>> fully occupied USB3 transmit queue results in:
>>>>
>>>> 454.80 KB / (10 Mbit/s / 8 bit/byte) = 363.84 ms
>>>>
>>>> of additional latency.
>>>
>>> Doesn't 5G need to push more packets to the driver to get good aggregation ?
>>>
>>
>> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
>> aggregate enough packets for a frame but not of several hundred ms as
>> calculated in my example. And yes, there are situations where 5G,
>> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
>> required. But the dynamic queue limit approach of BQL should be well
>> suited for these varying speeds.
>>
> 
> out of curiosity, related to the test with 5G Quectel, did you test
> enabling aggregation through QMAP (kernel module rmnet) or simply
> qmi_wwan raw_ip ?
> 
> Regards,
> Daniele
> 

Hi Daniele,

I simply used qmi_wwan. I actually never touched rmnet before.
Is the aggregation through QMAP what you and Eric mean with aggregation?
Because then I misunderstood it, because I was thinking about aggregating
enough (and not too many) packets in the usbnet queue.

Thanks

>>>>
>>>> To address this issue, this patch introduces support for
>>>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
>>>> limits the amount of data queued in the driver, effectively reducing
>>>> latency without impacting throughput.
>>>> This implementation was successfully tested on several devices as
>>>> described in the commit.
>>>>
>>>>
>>>>
>>>> Future work
>>>>
>>>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
>>>
>>> Only for rates > 500 Mbit. After BQL, we had many more improvements in
>>> the stack.
>>> https://lwn.net/Articles/564978/
>>>
>>>
>>
>> I also saw these large SKBs, for example, for my USB2 Android tethering,
>> which advertises a network speed of < 500 Mbit/s.
>> I saw these large SKBs by looking at the file:
>>
>> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
>>
>> For UDP-only traffic, inflight always maxed out at MTU size.
>>
>> Thank you for your replies!
>>
>>>> To
>>>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO but it
>>>> did not have the intended effect in my tests. The only dirty workaround I
>>>> found so far was to call netif_stop_queue() whenever BQL sets
>>>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue would
>>>> be desirable.
>>>>
>>>> I also plan to publish a scientific paper on this topic in the near
>>>> future.
>>>>
>>>> Thanks,
>>>> Simon
>>>>
>>>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>>>> [2] https://lwn.net/Articles/469652/
>>>>
>>>> Simon Schippers (1):
>>>>   usbnet: Add support for Byte Queue Limits (BQL)
>>>>
>>>>  drivers/net/usb/usbnet.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> --
>>>> 2.43.0
>>>>
>>


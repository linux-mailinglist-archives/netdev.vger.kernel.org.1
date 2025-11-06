Return-Path: <netdev+bounces-236242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5BC3A146
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFD642190B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954C30C602;
	Thu,  6 Nov 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="NHHG58p4"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0632D8379;
	Thu,  6 Nov 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423258; cv=none; b=XQLENm1zdARMhynHEEl7aYJZR4ISBe7jQUoJ9uzD95n1KhcnEck9m4pyhbX6/tfSnTHLx7Z/n6GKedHZg7sQfMrCVCvFLOLvO+tv1xPy+NM76TmXLtFnIwJsq/MfX3kQ3yWL0NeYMLZ1evOIR+C3xU0jv7awtG5vtPmvl9JID3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423258; c=relaxed/simple;
	bh=uph84l1p2vMYf1OKlZ++OkFEZdA0lZxvO6IihMHL0Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=damys9C2hVUxv1nIMFZhOf0Uggw1qb0zQA3gEHQ49Ph7t0iH3ANmmwegAK5ExrN1iFlNf1D1uWmJT71bbC6VSWghU4KkMO+3UkPGvx7qvMxwc2DnC/4weAIY45+CMkKXQKamEn1xmLHY6nuuq6rJ8f+MKaUb913Z6MxUp0HNQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=NHHG58p4; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [172.31.100.153] ([172.31.100.153])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 5A6A0h5s011136
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 11:00:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1762423244;
	bh=uph84l1p2vMYf1OKlZ++OkFEZdA0lZxvO6IihMHL0Ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NHHG58p4JXfq1ZbV6y29+dFlgpSJ5Uyeosnca4fqi9dfyAkvbmlkOc1+JJOvwEgSP
	 LOY0Tunrmn7EURLQ9A6wwT0sQFqJc11Dh4XejRmzcc+QBZjieDis77tEi/8Ej07fhR
	 Dp1kBfbNesSiMTNllUVF/30dlKDyL6/N+diImZEQ=
Message-ID: <676869a2-2e0d-4527-8494-db910b3a0018@tu-dortmund.de>
Date: Thu, 6 Nov 2025 11:00:43 +0100
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
 <c29f8763-6e0e-4601-90be-e88769d23d2a@tu-dortmund.de>
 <CAGRyCJE1_xQQDfu1Tk3miZX-5T-+6rarzgPGo3=K-1zsFKpr+g@mail.gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <CAGRyCJE1_xQQDfu1Tk3miZX-5T-+6rarzgPGo3=K-1zsFKpr+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 09:38, Daniele Palmas wrote:
> Hi Simon,
> 
> Il giorno mer 5 nov 2025 alle ore 12:05 Simon Schippers
> <simon.schippers@tu-dortmund.de> ha scritto:
>>
>> On 11/5/25 11:35, Daniele Palmas wrote:
>>> Hello Simon,
>>>
>>> Il giorno mer 5 nov 2025 alle ore 11:40 Simon Schippers
>>> <simon.schippers@tu-dortmund.de> ha scritto:
>>>>
>>>> On 11/4/25 18:02, Eric Dumazet wrote:
>>>>> On Tue, Nov 4, 2025 at 8:14 AM Simon Schippers
>>>>> <simon.schippers@tu-dortmund.de> wrote:
>>>>>>
>>>>>> During recent testing, I observed significant latency spikes when using
>>>>>> Quectel 5G modems under load. Investigation revealed that the issue was
>>>>>> caused by bufferbloat in the usbnet driver.
>>>>>>
>>>>>> In the current implementation, usbnet uses a fixed tx_qlen of:
>>>>>>
>>>>>> USB2: 60 * 1518 bytes = 91.08 KB
>>>>>> USB3: 60 * 5 * 1518 bytes = 454.80 KB
>>>>>>
>>>>>> Such large transmit queues can be problematic, especially for cellular
>>>>>> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
>>>>>> fully occupied USB3 transmit queue results in:
>>>>>>
>>>>>> 454.80 KB / (10 Mbit/s / 8 bit/byte) = 363.84 ms
>>>>>>
>>>>>> of additional latency.
>>>>>
>>>>> Doesn't 5G need to push more packets to the driver to get good aggregation ?
>>>>>
>>>>
>>>> Yes, but not 455 KB for low speeds. 5G requires a queue of a few ms to
>>>> aggregate enough packets for a frame but not of several hundred ms as
>>>> calculated in my example. And yes, there are situations where 5G,
>>>> especially FR2 mmWave, reaches Gbit/s speeds where a big queue is
>>>> required. But the dynamic queue limit approach of BQL should be well
>>>> suited for these varying speeds.
>>>>
>>>
>>> out of curiosity, related to the test with 5G Quectel, did you test
>>> enabling aggregation through QMAP (kernel module rmnet) or simply
>>> qmi_wwan raw_ip ?
>>>
>>> Regards,
>>> Daniele
>>>
>>
>> Hi Daniele,
>>
>> I simply used qmi_wwan. I actually never touched rmnet before.
>> Is the aggregation through QMAP what you and Eric mean with aggregation?
>> Because then I misunderstood it, because I was thinking about aggregating
>> enough (and not too many) packets in the usbnet queue.
>>
> 
> I can't speak for Eric, but, yes, that is what I meant for
> aggregation, this is the common way those high-cat modems are used:

Hi Daniele,

I think I *really* have to take a look at rmnet and aggregation through
QMAP for future projects :)

> it's not clear to me if the change you are proposing could have any
> impact when rmnet is used, that's why I was asking the test
> conditions.
> 
> Thanks,
> Daniele
> 

This patch has an impact on the underlying USB physical transport of
rmnet. From my understanding, the call stack is as follows:

rmnet_map_tx_aggregate or rmnet_send_skb

|
| Calling dev_queue_xmit(skb)
V

qmi_wwan used for USB modem

|
|  ndo_start_xmit(skb, net) is called
V

usbnet_start_xmit is executed where the size of the internal queue is
dynamically changed using the Byte Queue Limits algorithm by this patch.

Correct me if I am wrong, but I think in the end usbnet is used.

Thanks,
Simon

>> Thanks
>>
>>>>>>
>>>>>> To address this issue, this patch introduces support for
>>>>>> Byte Queue Limits (BQL) [1][2] in the usbnet driver. BQL dynamically
>>>>>> limits the amount of data queued in the driver, effectively reducing
>>>>>> latency without impacting throughput.
>>>>>> This implementation was successfully tested on several devices as
>>>>>> described in the commit.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Future work
>>>>>>
>>>>>> Due to offloading, TCP often produces SKBs up to 64 KB in size.
>>>>>
>>>>> Only for rates > 500 Mbit. After BQL, we had many more improvements in
>>>>> the stack.
>>>>> https://lwn.net/Articles/564978/
>>>>>
>>>>>
>>>>
>>>> I also saw these large SKBs, for example, for my USB2 Android tethering,
>>>> which advertises a network speed of < 500 Mbit/s.
>>>> I saw these large SKBs by looking at the file:
>>>>
>>>> cat /sys/class/net/INTERFACE/queues/tx-0/byte_queue_limits/inflight
>>>>
>>>> For UDP-only traffic, inflight always maxed out at MTU size.
>>>>
>>>> Thank you for your replies!
>>>>
>>>>>> To
>>>>>> further decrease buffer bloat, I tried to disable TSO, GSO and LRO but it
>>>>>> did not have the intended effect in my tests. The only dirty workaround I
>>>>>> found so far was to call netif_stop_queue() whenever BQL sets
>>>>>> __QUEUE_STATE_STACK_XOFF. However, a proper solution to this issue would
>>>>>> be desirable.
>>>>>>
>>>>>> I also plan to publish a scientific paper on this topic in the near
>>>>>> future.
>>>>>>
>>>>>> Thanks,
>>>>>> Simon
>>>>>>
>>>>>> [1] https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>>>>>> [2] https://lwn.net/Articles/469652/
>>>>>>
>>>>>> Simon Schippers (1):
>>>>>>   usbnet: Add support for Byte Queue Limits (BQL)
>>>>>>
>>>>>>  drivers/net/usb/usbnet.c | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>>


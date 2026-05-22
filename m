Return-Path: <netdev+bounces-290879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOThF7iEEGpJYgYAu9opvQ
	(envelope-from <netdev+bounces-290879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855A85B79CA
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCCB300F7A1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D013603EC;
	Fri, 22 May 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="XztVo92d"
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5737DE8D;
	Fri, 22 May 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467190; cv=none; b=W+/++vFYQSS/B74SVD5B+pASfwnjsHBCSLjsbbbanlxIcm8Yh+zSjAtCYRpYNv/BNTf9iTyQc8W+Uj/tCX6Bm+Fjer9fzVAP7sRwf1WjVPXLDI6mZzop6JZnREUCtnszuLJpFAfcqsxp5u4go63KOimRNaAd05SkEv0b1us0GLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467190; c=relaxed/simple;
	bh=Ajs7YUxaTn4mPKmHkLoC7uo5LsNlxjXEkGmyV7Wtdno=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jvN/l35ykVs3Je5rWtsbj5ifRcOSRKS+nENPz5zQT8EmmdHMixc/aCX5fc5GYZEkAMQ8XKWjZE1E/kk3loIW5e1xZ/mJOE3o1Sp3tvqer1vV5+iBm4JB95nIgk27QIarGqpLAh1XblZJMFuTw5onQ/Q7E2ebIRMQKqLal3y25rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=XztVo92d; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1779467186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kOniK47fLvxWZvX3WWpplpGrp6oNvEjUl2LeUR/KZYs=;
  b=XztVo92dhVK6RyzUZ8tdF5yLmApt7IFBLnnPZ7jY2Vz0GyYxPf+EcfDd
   Bpvy9dO+Orw9yYIT0Cz1dOWBU/qtZrmUKgyewXBB8I1tKELNd710LeFde
   H4wkP68PD7Uh/yUKB1zMWVj0vA1gt4Qrdfko4np2nzDxqNbKU5dZ6mQ73
   lRYe7XPgisG73bnJ9J1aktn/0ouxkYY2H4mgrpNLP3AFHrVykLJjFqM/X
   8FKhedvys/3AAIXkycAoTGPa1OTH5mAPK/bJbXpJ/BSsjcgvtmvFwLt/q
   D3/RU3t/wAPXejmszCt9nOWI4IUeew1hybGWIIao+Th7bFxAEsoKk4R8N
   A==;
X-CSE-ConnectionGUID: mT5I/dhBRmuIdaZcWKYrRA==
X-CSE-MsgGUID: 01SR6DxMQjup6X4j+Cb+Kg==
X-IronPort-AV: E=Sophos;i="6.24,162,1774306800"; 
   d="scan'208";a="47654805"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 22 May 2026 18:26:23 +0200
Message-ID: <463e91cb-6c45-4d91-8737-39779fec5a49@tu-berlin.de>
Date: Fri, 22 May 2026 18:26:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kernel-team@cloudflare.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
 <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
 <e3a91545-13cd-4f87-8375-d707865bdbca@schippers-hamm.de>
 <6a597dbd-70bf-4b14-b495-2f7248fd3220@kernel.org>
 <20260508190626.4285fac0@kernel.org>
 <f459b95c-80d5-4e05-84b2-f574c92724de@kernel.org>
 <20260510085602.57c7a081@kernel.org>
 <daa05c21-dcfc-4cc4-aa22-9e25c7f6c743@kernel.org>
 <41023c34-87a3-4e4f-b3ab-3ed53d171910@schippers-hamm.de>
 <b78f002a-8cb9-4857-bf8f-0137e790f644@kernel.org>
 <873511fa-4316-4411-a76b-ec4c5805abd3@schippers-hamm.de>
 <18855e57-f050-411f-9958-d4babcc81ba3@kernel.org>
 <14348957-d061-4124-9bac-45df9cf6686c@schippers-hamm.de>
 <9a57bb41-114e-492b-9eaa-52237675bb7c@schippers-hamm.de>
 <4ae9400a-8919-4ffc-8db3-0c334e2aa462@tu-berlin.de>
 <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <8e8b877b-a7ce-4b2f-9567-64c8dbb48411@schippers-hamm.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290879-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:mid,tu-berlin.de:dkim,veth_bql_bench.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,veth_bql_test_virtme.sh:url,medium.com:url]
X-Rspamd-Queue-Id: 855A85B79CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 10:41, Simon Schippers wrote:
> On 5/22/26 09:14, Jonas Köppeler wrote:
>> On 5/19/26 10:51 PM, Simon Schippers wrote:
>>> On 5/12/26 23:55, Simon Schippers wrote:
>>>> On 5/12/26 15:54, Jesper Dangaard Brouer wrote:
>>>>>>> Nope, I'm using a bpftrace program to keep track of the inflight/limit
>>>>>>> in a BPF hashmap.  Reading from /sys will not be accurate.
>>>>>> Ah nice.
>>>>> Add the option --hist to have both NAPI and BQL histograms printed when
>>>>> script ends.  This will give you an accurate pattern of how inflight and
>>>>> limit evolves.
>>>>>
>>>>>>> I moved the selftests into a github repo [1] to allow us to collaborate
>>>>>>> and evaluate the changes more easily.  I explicitly kept the new BPF
>>>>>>> based BQL tracking as a commit[2] for your benefit.
>>>>>>>
>>>>>>>     [1]https://github.com/netoptimizer/veth-backpressure-performance-testing/tree/main/selftests
>>>>>>>
>>>>>>>     [2]https://github.com/netoptimizer/veth-backpressure-performance-testing/commit/f25c5dc92977
>>>>>> Thanks for sharing. After minor issues I was able to set it up
>>>>>> (currently I am just using plain v5, will look at the coalescing patch
>>>>>> when I find the time):
>>>>>>
>>>>>> Can confirm the latency reduction with the default settings, in my case
>>>>>> 4.888ms to 0.241ms.
>>>>>>
>>>>>> With the same script I was also able to see a performance slow down:
>>>>>> veth_bql_test_virtme.sh --qdisc fq_codel --nrules 0
>>>>>> --> ~510 Kpps
>>>>>> Same with --bql-disable
>>>>>> --> ~570 Kpps
>>>>>> --> 12% faster
>>>>>>
>>>>> Thanks for running these benchmarks.
>>>>>
>>>>> Notice that --nrules 0 can easily result in no-queuing (on average),
>>>>> because the veth NAPI consumer is faster than the producer.  You will
>>>>> likely see BQL inflight=1 and sink reported avg latency very low
>>>>> (remember it okay that sink get high latency penalty as long at ping
>>>>> latency remains low, as that show AQM is working).
>>>> I ran the benchmarks with --hist and I see what you mean.
>>>> I have very similar results.
>>>>
>>>> Is Jonas way [1] of modifiying pktgen maybe the best option to ensure
>>>> that the producer is faster than the consumer?
>>>>
>>>> [1] Link:https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
>>>>
>>>>> Hi, so what I found is that pktgen does not respect
>>>>> __QUEUE_STATE_STACK_OFF. So the test data above is invalid, since it
>>>>> just sent packets even if the BQL "stopped" the queue. So I patched
>>>>> pktgen with the following:
>>>>>
>>>>> -       if (unlikely(netif_xmit_frozen_or_drv_stopped(txq))) {
>>>>> +       if (unlikely(netif_xmit_frozen_or_stopped(txq))) {
>>>> After thinking more about the implementation I see possible issues:
>>>>
>>>> 1. netdev_tx_completed_queue() never reports more than burst=64 packets:
>>>>
>>>> BQL only increments the limit if the queue was starved. That means:
>>>> "The queue was over-limit in the last interval (the last time completion
>>>> processing ran), and there is no more data in the queue (i.e. it’s
>>>> empty)" [2]
>>>> But as only 64 packets are reported at max, the queue can only grow when
>>>> it is <= 64 packets. And then it can only stay at a limit >64 until the
>>>> next decrease of the limit.
>>>>
>>>>
>>>> 2. netdev_tx_completed_queue() is called in irregular intervals:
>>>>
>>>> If the consumer is slow it is called approx each tx_coal_usecs.
>>>> But if the consumer is fast it is called way more frequent, probably
>>>> in irregular intervals depending on the scheduling.
>>>> However, "BQL depends on periodic completion interrupts" [2].
>>>>
>>>> --> How about adding something like an interrupt that triggers every
>>>>       10us and calls netdev_tx_completed_queue() with n_bql collected from
>>>>       (multiple) veth_xdp_rcv runs? That could solve 1. and 2.
>>> Hi,
>>>
>>> I worked on a new version (see attachment) that addresses both issues.
>>>
>>> The major change is that instead of tracking the timestamp and packet
>>> count as local variables in veth_xdp_rcv(), they are now stored
>>> persistently in veth_rq as struct veth_bql_state. This allows completions
>>> to accumulate across multiple NAPI poll calls, so
>>> netdev_tx_completed_queue() can report more than 64 packets at once
>>> (see point 1). To get the time I am using (the fast) sched_clock() with
>>> a trick to avoid issues when switching between CPUs.
>>>
>>> For point 2, the coalescing deadline is now checked both before the
>>> receive loop (to flush completions that timed out since the previous
>>> poll) and after each consumed packet, making completion intervals more
>>> regular. Still the intervals can be smaller than
>>> VETH_BQL_COAL_TX_USECS, but I guess this is fine.
>>>
>>> I also found out that the BQL limit correlates closely with
>>> VETH_BQL_COAL_TX_USECS. It essentially reflects the latency we are
>>> targeting. I raised the default to 100 µs to allow DQL to converge to a
>>> higher limit (for reaching 255 in the testing below).
>>>
>>> With the patched pktgen (respecting __QUEUE_STATE_STACK_XOFF), testing
>>> shows:
>>> - --nrules 0: DQL limit reaches (up to) ~255
>>> - --nrules 10000: DQL limit converges to ~0 (with --gro-disable)
>>>
>>> These results are what I would expect from a BQL algorithm, but more
>>> testing is needed of course.
>>>
>>> What do you think?
>> Hi,
>>
>> This is exactly what I had in mind for implementing the BQL algorithm
>> in this case. I did some testing with pktgen of this patch and also
>> compared it to the v5 version.
>>
>> You can find an extension of the benchmark script with pktgen here [1],
>> as well as a wrapper script (veth_bql_bench.sh) to run the test script
>> with and without --bql-disable to report the difference. I also
>> configured pktgen to use the qdisc as suggested by Jesper.
> Great, I will use your pktgen solution from now on.
>
> Didn't know about the qdisc option, is there a performance difference
> with/without it? Or is it to have ping working next to pktgen?

Did not see any big difference performance-wise, but as you say, ping
works better with pktgen then.

> Consider to do a pull request :)
>
>> Note: bpftrace needs to be disabled, otherwise it becomes the
>> bottleneck (at least on my machine) and pktgen throughput is halved
>> when enabled.
> Good to know.
>
>> Here are the results:
>>
>> v5 (not time-based):
>> --nrules 0 --pktgen --no-bpftrace
>> ========================================
>> Results (average over 10 runs):
>> ========================================
>>                         BQL on    BQL off
>> ---                    ------    -------
>> Throughput (pps)      1980871    2169898
>> Ping RTT avg (ms)       0.065      0.162
>> Throughput diff         -8.7%   // BQL 8.7% lower throughput
>> RTT diff               -59.9%   // BQL 60% lower latency
>> ========================================
>>
>> Simon's time-based version:
>>
>> Test args: --nrules 0 --pktgen --no-bpftrace
>> ========================================
>> Results (average over 10 runs):
>> ========================================
>>                             BQL on      BQL off
>> ---                        ------      -------
>> Throughput (pps)          2166335      2153398
>> Ping RTT avg (ms)           0.165        0.165
>> Throughput diff              0.6%
>> RTT diff                     0.0%
>>
>> --pktgen --no-bpftrace --nrules 3500
>> ========================================
>> Results (average over 10 runs):
>> ========================================
>>                             BQL on      BQL off
>> ---                        ------      -------
>> Throughput (pps)            28569        28696
>> Ping RTT avg (ms)           1.327        8.409
>> Throughput diff             -0.4%
>> RTT diff                   -84.2%
>>
> I think we should run benchmarks against the stock net-next to
> be safe.

--nrules 0 --pktgen --no-bpftrace
========================================
Results (average over 10 runs):
========================================
                      net-next
---                  -------
Throughput (pps)     2285421
Ping RTT avg (ms)    0.161

(slightly adjusted the output to better communicate the results)

So in my case this means BQL implementation has ~5% lower throughput
compared to net-next. But please double check.

>> Seems to work now as expected.
> Yes, but I think we have to keep these points in mind:
>
> 1. Limit/Inflight can be bigger than VETH_RING_SIZE, because
>     packets can be enqueued in the same time as they are read out,
>     so netdev_tx_completed_queue() can theoretically be called with
>     many number of packets.
>     I do not think it is deal-breaking though.
>     I could see such high limits/inflights when looking at the /sys
>     BQL statistics..

For me this makes sense, that inflight just means the number of
packets not yet 'completed' or the number of packets that you
can send between two completion calls. I think this is not specific
to this implementation. But for long intervals this might result in
some problems because you can just fill the veth_ring to its capacity
quickly, and increasing latency if the receiver is slow.
To illustrate this have a look at [1]. There are some plots that
show the rtt vs. tx-usec config depending on nrules.

[1] https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark/results/tx-usecs

> 2. sched_clock() is only valid on the same CPU. When a different
>     CPU starts executing its sched_clock() can be in the past compared
>     to the sched_clock() value saved by the previous CPU.
>     My trick...
>     min(s->time, sched_clock())
>     ... avoids potentially extremely long intervals between
>     netdev_tx_completed_queue() calls but is not perfect of course.
>     I think CPU hopping happens rarely enough for this to matter..
>     And also we have to keep this in mind [1]:
>     "An architecture may or may not provide an implementation of
>     sched_clock() on its own. If a local implementation is not provided,
>     the system jiffy counter will be used as sched_clock()."

So the problem with this is that with jiffies you have like millisecond
interval granularity, which might be too long in order to work properly.
Given the receiver completes 128 packet in 1ms (queue_completed interval),
the bql will set the limit at 256. Then the tx thread can quickly fill
the ring, and it then basically stopped until the 1ms interval is over.

I don't know how much this matters in practice. Not sure which 
architectures still hit the jiffies fallback.When in doubt we could 
disable BQL for those, or pin it to a "virtual queue size" via limit_min 
/ limit_max similar to the v5 behavior and call queue_completed for 
every packet. Wdyt?

> 3. Inflight can be stuck at a value>0 for a long time when packet
>     enqueueing stops. Only when packets are enqueued again,
>     (on the next veth_xdp_rcv() call,) netdev_tx_completed_queue() is
>     executed and inflight is set to 0 again.
>     Can also be seen when looking at the /sys BQL statistics.

This happens if the ring empties before the next queue_completed fires,
right?

Another thing: Is it counterintuitive to set the tx_usec_coal on the
receive device? Because this is a bql related config that is normally
configured on the TX side?

> BTW: Yesterday, I worked on and refactored the code into its own .h
>       file as a library and it also works fine for TUN/TAP (+vhost-net)
>       for me :)

Nice! Thank you.
Jonas

>
> Thanks for your work!
> Simon
>
> [1] Link: https://docs.kernel.org/timers/timekeeping.html
>
>> [1]https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark
>>
>> Thanks,
>> Jonas
>>
>>> Thanks!
>>>
>>> BTW: I think that this implementation could also work for other
>>>        software interfaces.
>>>
>>>> [2] Link:https://medium.com/@tom_84912/byte-queue-limits-the-unauthorized-biography-61adc5730b83
>>>>
>>>>> There is an important gotcha. We actually have micro-burst of queuing
>>>>> (likely due to scheduling noise). Reading BQL stats from /sys will show
>>>>> BQL inflight=1, but when using the option --hist is it visible that
>>>>> @inflight have a long tail (see below signature).  The "qdisc" output
>>>>> line also shows this happening via requeues increasing (approx 17/sec in
>>>>> a test with 567Kpps). (this was with the time-based BQL impl).
>>>> I understand..
>>>>


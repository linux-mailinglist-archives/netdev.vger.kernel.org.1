Return-Path: <netdev+bounces-297098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yDPhG6UxKGqb/wIAu9opvQ
	(envelope-from <netdev+bounces-297098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:30:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A5661C3D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:30:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=tu-dortmund.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297098-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297098-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1077323CFC8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190747DD6C;
	Tue,  9 Jun 2026 15:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2F43C05B;
	Tue,  9 Jun 2026 15:08:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017717; cv=none; b=kyM8e2+T0QEqovi5ozLkRgRE5u1qwCqXfe9UHJpWDtjE4mylEvlJW/Oa5XkvNH02BpVKIQdo9HIVK+6wFhXfWI7FCDG7Y7/Q3YeCAS6swrTU3iBoLZU+SWFu/meLBo2Jb9fQ1F5ZmcyMiQKy9wNn7GU3cxMkKgRBIKhNtebXOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017717; c=relaxed/simple;
	bh=6DkbYSHqspwZcj9nBK7hTUw+gO3qPLcjNxLLT0k8DW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5kwX4La7z6Sw1GZK3NAPwYvwq2GyWWNPY51ya7s0ogVTz0iTS34ON8Qvfn5b2aPR4fVjEQr4AS9wBcYlFp22Bc+Coy0UZHBtx5TPNN9Sb6s+egiqEwi5uJwG/1fUye1ygpu/wg+T0kHuFHE2FCsqp7wNZvd//3HzKnb+HJWj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Received: from [129.217.186.234] ([129.217.186.234])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 659F886r012405
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 9 Jun 2026 17:08:08 +0200 (CEST)
Message-ID: <5e6315b1-b734-4f5f-af5e-bc76612f0993@tu-dortmund.de>
Date: Tue, 9 Jun 2026 17:08:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
 <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
 <e8478d82-5af6-44f7-a481-584c09ae8337@tu-berlin.de>
 <b8569d0f-7a99-4488-a1bb-63d813231b7d@tu-dortmund.de>
 <90fc9fc1-f396-4ed1-888f-89a96294664e@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <90fc9fc1-f396-4ed1-888f-89a96294664e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[tu-dortmund.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:j.koeppeler@tu-berlin.de,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:kernel-team@cloudflare.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dql.limit:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 814A5661C3D

On 6/9/26 15:59, Jesper Dangaard Brouer wrote:
> 
> 
> On 08/06/2026 16.21, Simon Schippers wrote:
>> On 6/8/26 15:13, Jonas Köppeler wrote:
>>>
>>> On 6/8/26 3:04 PM, Jesper Dangaard Brouer wrote:
>>>>
>>>>
>>>> On 08/06/2026 12.38, Simon Schippers wrote:
>>>>> On 5/27/26 15:54, hawk@kernel.org wrote:
>>>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>>
>>>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>>>
>>>>>> Accumulate BQL completions and flush them when a configurable time
>>>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>>>> queuing delay to the configured interval. Coalescing state persists
>>>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>>>> beyond a single budget=64 cycle.
>>>>>>
>>>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>>>> completion.
>>>>>>
>>>>>>     ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>>>     ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>>>
>>>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>>> ---
>>>>>
>>>>> I found the issue that n_bql may become infinitly large if producer
>>>>> and consumer have the same speed (and tx_usecs is large). It could
>>>>> cause a potential BUG_ON if n_bql grows beyond INT_MAX...
>>>>> Also I figured that no hardware BQL driver ever completes more than
>>>>> BQL limit many elements.
>>>>>
>>>>> Therefore, I propose a simpler logic (see attachment) that completes
>>>>> either on the usual bql_flush_ns or if n_bql > dql.limit.
>>>>> If n_bql > dql.limit then we either have the case above that the
>>>>> producer is as fast as the consumer or we have BQL starvation.
>>>>>
>>>>> if (state->time + bql_flush_ns <= current_time ||
>>>>>      state->n_bql > peer_txq->dql.limit) {
>>>>>
>>>>> It must be n_bql *bigger than* dql.limit because the producer will
>>>>> always exceed the limit before it stops, see netdev_tx_sent_queue().
>>>>> It is fast because peer_txq->dql.limit is in the cacheline of the
>>>>> completion path, see dynamic_queue_limits.h.
>>>>>
>>>>> Another advantage is that we avoid the snippet checking for empty
>>>>> and BQL stopped which requires an smp_rmb() and an test_bit().
>>>>>
>>>>> Apart from that I:
>>>>> - Always call veth_bql_maybe_complete() in the for loop to have
>>>>>     more accurate completion intervals when having mixed XDP and
>>>>>     non-XDP packets.
>>>>> - Made it so tx_usecs = 0 is now also a normal case.
>>>>> - Change the type of n_bql to uint instead of int.
>>>>> - Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
>>>>> - Moved the bql_state init in __veth_napi_enable_range() in front
>>>>>     of napi_enable() to avoid a race (Sashiko).
>>>>> - Moved the bql_state reset in veth_napi_del_range() after the
>>>>>     ptr_ring_cleanup() (probably does not matter but makes sense to me)
>>>>>
>>>>> Benchmarks look just fine, see commit message.
>>>>>
>>>>> WDYT?
>>>
>>>>
>>>> Looks good to me, I will use this in my V7 patchset.
>>>>
>>>> A bike-shedding issue: We change the coalescing parameters for the veth
>>>> net_device, but should this be a TX or RX parameter?
>>>>
>>>
>>> Hi,
>>>
>>> The results look a little bit suspicious, that in some cases the p99 is smaller than the average, which can happen if you have really large max values. It feels something is off with the methodology. I think we should drop the avg, and include the max value. This would give a better picture.
>>
>> Luckily I saved the raw test result from /tmp (the raw ping output
>> is included).
>>
>> extract_ping_p99() seems to be broken. It has issues ordering the
>> numbers. So if there are 2 or 3 numbers after the point I think.
>> avg ping is fine.
>>
>> Claude Sonnet wrote a script for me to recalculate the p99 pings
>> from the raw ping output).
> 
> For programming switch to Claude Opus, as Sonnet cannot code IMHO.

Already used 95% of my Copilot Pro+ Tokens this month :P

> (Claude Opus wrote the selftest we placed in [1])
> 
> Is your script still based on our github[1] selftest ?
> If so, then please make some PR(s) against my repo.
> I want this to be easy reproducible for others.
> 
> [1] https://github.com/netoptimizer/veth-backpressure-performance-testing
> 

I forked Jonas latest branch [1] and ran the tests with that.

But I faced 2 issues that I then fixed:
- Ping fails in some runs (~20%) -> My fix: Retry the run until it
  works.
- extract_ping_p99() has a bug for me which caused wrong results,
  as pointed out by Jonas -> Also fixed it

Because of the inconsistencies I will rerun over night to have
clean benchmark results.

I will make a PR tomorrow.

[1] https://github.com/jkoeppeler/veth-backpressure-performance-testing/tree/pktgen-and-benchmark

>> Below is the new result. Not 100% sure but this seems right now.
>> Most pings are the same.
>>
>> Ping RTT ms (p99)
>> ===========================================================================
>> nrules |   0us |  50us | 100us | 500us | 1000us | 5000us | 10000us || stock
>> -------+-------+-------+-------+-------+--------+--------+---------++------
>>       0 | 0.028 | 0.115 | 0.159 | 0.161 |  0.163 |  0.161 |   0.163 || 0.154
>>       1 | 0.027 | 0.123 | 0.169 | 0.172 |  0.169 |  0.173 |   0.172 || 0.169
>>      10 | 0.030 | 0.117 | 0.189 | 0.193 |  0.195 |  0.192 |   0.196 || 0.186
>>     100 | 0.045 | 0.134 | 0.233 | 0.368 |  0.365 |  0.369 |   0.361 || 0.358
>>    1000 | 0.230 | 0.300 | 0.412 |  1.26 |   2.11 |   2.12 |    2.13 ||  2.07
>>   10000 |  2.04 |  2.55 |  2.54 |  2.72 |   3.77 |   12.1 |    20.1 ||  20.3
>>
>>>
>>> Is state->n_bql += veth_ptr_is_bql(ptr) something that is commonly done in the kernel? It relies on bool normalization which feels a bit implicit to me.
>>
>> Ok, we could swap for something like
>>
>> if (veth_ptr_is_bql(ptr))
>>     state->n_bql+;
> 
> I'll see if I can adjust the V7 patch to this feedback.

Yes, and also this snippet pointed out by Jonas below:

 -       struct veth_priv *priv;
 -       u64 bql_flush_ns;
 +       u64 bql_flush_ns = 0;

 -       priv = netdev_priv(rq->dev);
 -       bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
 +       if (peer_txq) {
 +           struct veth_priv *peer_priv = netdev_priv(peer_txq->dev);
 +           bql_flush_ns = (u64)READ_ONCE(peer_priv->tx_coal_usecs) * 1000;
 +       }

Or is peer_txq != 0 guaranteed in veth_xdp_rcv()?


And also I would change in the commit message:

"Flushing when n_bql exceeds dql.limit handles two cases:
- BQL starvation
- The steady-state case where the producer and consumer run at the
  same speed with a large tx-usecs, which would otherwise allow n_bql
  to grow without bound (and potentially overflow int)."

... to just...

"Flushing when n_bql exceeds dql.limit handles BQL starvation."

... because after rethinking I think I overstated here.
n_bql should also not grow infinitely for the v6 version.
Nevertheless the new method should be simpler and faster.

> 
> 
>>>
>>>> For physical NICs adjusting TX coalescing will affect the BQL as this
>>>> affect the TX completion of the transmitted packets. For veth, it is the
>>>> veth-peer's RX NAPI that is "completing" or emptying the ptr_ring, which
>>>> is where this patch adds netdev_tx_completed_queue calls for BQL.
>>>> Any opinions on the "TX" or "RX" color?
>>
>> Personally I would also say TX.
>>
> 
> Okay, we seem to have more votes for TX :-)
> 
> 
>>> I think I would prefer to configure it on the tx dev, and the recv
>>> side gets the value from the peer. Maybe something like this.
>>>
> 
> I'm considering if we should simplify the config by having veth pairs have the same tx-coal value. WDYT?

I can not think of a case where a user would like to have a different
tx-coal value on either side..
So it's fine for me.

> 
> 
>>> @@ -997,11 +998,12 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>          struct veth_bql_state *state = &rq->bql_state;
>>>          int i, done = 0, n_xdpf = 0;
>>>          void *xdpf[VETH_XDP_BATCH];
>>
>> Why this deletion?
>>
>>> -       struct veth_priv *priv;
>>> -       u64 bql_flush_ns;
>>> +       u64 bql_flush_ns = 0;
>>>
>>> -       priv = netdev_priv(rq->dev);
>>> -       bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;
>>
>> I see we should check if peer_txq exists.
>>
>>> +       if (peer_txq) {
>>> +           struct veth_priv *peer_priv = netdev_priv(peer_txq->dev);
>>> +           bql_flush_ns = (u64)READ_ONCE(peer_priv->tx_coal_usecs) * 1000;
>>> +       }
>>>
>>>          /* Clamp stored timestamp in case we migrated to a CPU with a behind
>>>           * sched_clock(); prevents the deadline from never firing.
>>>
>>> - Jonas
> 
> --Jesper
> 


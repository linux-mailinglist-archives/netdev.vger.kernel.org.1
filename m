Return-Path: <netdev+bounces-306154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XYqDA6F6T2oyhwIAu9opvQ
	(envelope-from <netdev+bounces-306154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:40:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A94272FBCC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:40:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-berlin.de header.s=dkim-tub26 header.b=CntqECQe;
	dmarc=pass (policy=quarantine) header.from=tu-berlin.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306154-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306154-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F9A4324ECDC
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953E406272;
	Thu,  9 Jul 2026 10:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928D404889;
	Thu,  9 Jul 2026 10:04:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591469; cv=none; b=aotJAzJ+wGl4ChqxU5Gf1BCvvZ2P3OYAOrJAthVcpZ50ARrlQh4smxBX93Sz0YZ28PVEU1aEG3ZltyjXnza5jlXOo2iJDi2qU3S7WvbYpeYMPuaYG1TAJw/bw1dZhCs7LTjxIpsNlLnmb5O+tCLb0R1V/Tz718rQ+vgWyAmXEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591469; c=relaxed/simple;
	bh=fNOd/eU3h/R1BAPcj10CY/Ovo1jrT3rHH23CB6iM2Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5juHH7VzGoKW9fHl6EV8di43Nsxg4evWvrq1wJSyo1PizSrbQADE6YO7diGbn2pAOPhjPfpI+rjl3AamurmZEwiFlTB8kDetswQbGze12dhB9qJc+c5GkHrTUz37SDtNMhX0A5Q7MfELm2n6bMgFY43rUPLm5RKFqofUHeum/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=CntqECQe; arc=none smtp.client-ip=130.149.7.70
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1783591462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/7o+ZshKyZOz5cy3k1R9QWg2vfjJNG7PkA6NFzyabaU=;
  b=CntqECQe6NTodwC1M6glZfGAc3WaxZurP/kFhrmE/UC9Xpa8jciojL74
   XYAJZan1jCXEdo/5COb0VDBY22ArSFuDhwOsz+L4R/3zKcItFtPRyITWb
   1derv0bzUsW+R15CRDBx3N48EtpEr/TNojUjwIAhlDJ8qcE/EGjQxhtgu
   yyowfF2x7/zkaspF0PiPjnI5r5fVUN7ujJKNvT6Lnpmgkpg90XVqfWHHo
   XkTEnJWzOw0O3aBrxKcHLPGlYDqZHrFKetDvvCdivSyn/kYWKqp3E9mY5
   qP/ER1hVGMMnBEUpDdAbPPkvs2G8nk5DH7Y2tyovzwYWDz/TPvVfVJD6N
   A==;
X-CSE-ConnectionGUID: C/PBFcK9RsSszigqwHHe5g==
X-CSE-MsgGUID: sl//wWv2Ra2BXCQO0pEOCg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779141600"; 
   d="scan'208";a="49745254"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 09 Jul 2026 12:03:10 +0200
Message-ID: <e025c9af-84e6-4549-bb65-0a6f9b6af98a@tu-berlin.de>
Date: Thu, 9 Jul 2026 12:03:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: Simon Schippers <simon.schippers@tu-dortmund.de>, <hawk@kernel.org>,
	<netdev@vger.kernel.org>
CC: <kernel-team@cloudflare.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20260612083530.1650245-1-hawk@kernel.org>
 <20260612083530.1650245-6-hawk@kernel.org>
 <f120fd22-1ee5-4d5b-9cdd-71804353e6a7@tu-dortmund.de>
 <c4154d9c-8930-436d-b8b8-01951e8bd9f4@tu-berlin.de>
 <9205d83f-2c9e-4abb-91a0-488704bcdef3@tu-dortmund.de>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Autocrypt: addr=j.koeppeler@tu-berlin.de; keydata=
 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
In-Reply-To: <9205d83f-2c9e-4abb-91a0-488704bcdef3@tu-dortmund.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-berlin.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-berlin.de:s=dkim-tub26];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306154-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-berlin.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.koeppeler@tu-berlin.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,dql.limit:url,tu-dortmund.de:email,tu-berlin.de:from_mime,tu-berlin.de:email,tu-berlin.de:mid,tu-berlin.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A94272FBCC

On 6/30/26 21:07, Simon Schippers wrote:
> On 6/30/26 16:00, Jonas Köppeler wrote:
>> On 6/13/26 4:14 PM, Simon Schippers wrote:
>>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>
>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>
>>>> Accumulate BQL completions and flush them when a configurable time
>>>> threshold (tx-usecs) is exceeded, letting DQL discover a limit that
>>>> bounds actual queuing delay to the configured interval. Coalescing
>>>> state persists across NAPI polls in struct veth_rq so completions can
>>>> accumulate beyond a single budget=64 cycle.
>>>>
>>>> The flush condition is:
>>>>
>>>> state->time + bql_flush_ns <= current_time || state->n_bql > dql.limit
>>>>
>>>> Flushing when n_bql exceeds dql.limit handles BQL starvation.
>>>>
>>>> The comparison is strictly greater-than because netdev_tx_sent_queue()
>>>> always lets the producer exceed the limit by one before it stops, so
>>>> n_bql == dql.limit is a normal in-flight state. dql.limit lives in
>>>> the same cacheline as the completion path, so the check is cheap.
>>>>
>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>> completion.
>>>>
>>>>     ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>     ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>
>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Co-developed-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
>>>> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>> ---
>>>>    drivers/net/veth.c | 123 ++++++++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 117 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>>> index 2473f730734b..c62d87a8402c 100644
>>>> --- a/drivers/net/veth.c
>>>> +++ b/drivers/net/veth.c
>>>> @@ -28,6 +28,7 @@
>>>>    #include <linux/bpf_trace.h>
>>>>    #include <linux/net_tstamp.h>
>>>>    #include <linux/skbuff_ref.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <net/page_pool/helpers.h>
>>>>      #define DRV_NAME    "veth"
>>>> @@ -50,6 +51,7 @@
>>>>     * delay => 64 * 250 ms = 16 s.
>>>>     */
>>>>    #define VETH_WATCHDOG_TIMEOUT_MS    (64 * 250)
>>>> +#define VETH_BQL_COAL_TX_USECS    100 /* default tx-usecs for BQL batching*/
>>>>      struct veth_stats {
>>>>        u64    rx_drops;
>>>> @@ -69,6 +71,11 @@ struct veth_rq_stats {
>>>>        struct u64_stats_sync    syncp;
>>>>    };
>>>>    +struct veth_bql_state {
>>>> +    u64    time;    /* sched_clock() when current coalescing window started */
>>>> +    uint    n_bql;    /* BQL completions batched in the current window */
>>>> +};
>>>> +
>>>>    struct veth_rq {
>>>>        struct napi_struct    xdp_napi;
>>>>        struct napi_struct __rcu *napi; /* points to xdp_napi when the latteris initialized */
>>>> @@ -76,6 +83,7 @@ struct veth_rq {
>>>>        struct bpf_prog __rcu    *xdp_prog;
>>>>        struct xdp_mem_info    xdp_mem;
>>>>        struct veth_rq_stats    stats;
>>>> +    struct veth_bql_state    bql_state;
>>>>        bool            rx_notify_masked;
>>>>        struct ptr_ring        xdp_ring;
>>>>        struct xdp_rxq_info    xdp_rxq;
>>>> @@ -88,6 +96,7 @@ struct veth_priv {
>>>>        struct bpf_prog        *_xdp_prog;
>>>>        struct veth_rq        *rq;
>>>>        unsigned int        requested_headroom;
>>>> +    unsigned int        tx_coal_usecs;    /* BQL completion coalescing */
>>>>    };
>>>>      struct veth_xdp_tx_bq {
>>>> @@ -272,7 +281,56 @@ static void veth_get_channels(struct net_device *dev,
>>>>    static int veth_set_channels(struct net_device *dev,
>>>>                     struct ethtool_channels *ch);
>>>>    +static int veth_get_coalesce(struct net_device *dev,
>>>> +                 struct ethtool_coalesce *ec,
>>>> +                 struct kernel_ethtool_coalesce *kernel_coal,
>>>> +                 struct netlink_ext_ack *extack)
>>>> +{
>>>> +    struct veth_priv *priv = netdev_priv(dev);
>>>> +
>>>> +    ec->tx_coalesce_usecs = priv->tx_coal_usecs;
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int veth_set_coalesce(struct net_device *dev,
>>>> +                 struct ethtool_coalesce *ec,
>>>> +                 struct kernel_ethtool_coalesce *kernel_coal,
>>>> +                 struct netlink_ext_ack *extack)
>>>> +{
>>>> +    struct veth_priv *priv = netdev_priv(dev);
>>>> +    struct net_device *peer;
>>>> +
>>>> +    /* The coalescing window delays BQL completions, so keep tx-usecs well
>>>> +     * below the tx_timeout watchdog; otherwise a large value could stall a
>>>> +     * stopped queue long enough to trip a false watchdog timeout. Cap at
>>>> +     * half the watchdog to leave a generous safety margin. tx-usecs is
>>>> +     * microseconds, the watchdog is milliseconds.
>>>> +     */
>>>> +    if (ec->tx_coalesce_usecs > VETH_WATCHDOG_TIMEOUT_MS / 2 * USEC_PER_MSEC) {
>>>> +        NL_SET_ERR_MSG_MOD(extack,
>>>> +                   "tx-usecs must stay below half the tx_timeout watchdog");
>>>> +        return -ERANGE;
>>>> +    }
>>>> +
>>>> +    /* Paired with READ_ONCE in veth_xdp_rcv(). */
>>>> +    WRITE_ONCE(priv->tx_coal_usecs, ec->tx_coalesce_usecs);
>>>> +
>>>> +    /* veth_xdp_rcv() reads each device's own value, so mirror it onto
>>>> +     * the peer to keep the pair symmetric: both directions coalesce
>>>> +     * with the same tx-usecs. Called under RTNL, rtnl_dereference() is safe.
>>>> +     */
>>>> +    peer = rtnl_dereference(priv->peer);
>>>> +    if (peer) {
>>>> +        struct veth_priv *peer_priv = netdev_priv(peer);
>>>> +
>>>> +        WRITE_ONCE(peer_priv->tx_coal_usecs, ec->tx_coalesce_usecs);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static const struct ethtool_ops veth_ethtool_ops = {
>>>> +    .supported_coalesce_params = ETHTOOL_COALESCE_TX_USECS,
>>>>        .get_drvinfo        = veth_get_drvinfo,
>>>>        .get_link        = ethtool_op_get_link,
>>>>        .get_strings        = veth_get_strings,
>>>> @@ -282,6 +340,8 @@ static const struct ethtool_ops veth_ethtool_ops ={
>>>>        .get_ts_info        = ethtool_op_get_ts_info,
>>>>        .get_channels        = veth_get_channels,
>>>>        .set_channels        = veth_set_channels,
>>>> +    .get_coalesce        = veth_get_coalesce,
>>>> +    .set_coalesce        = veth_set_coalesce,
>>>>    };
>>>>      /* general routines */
>>>> @@ -969,13 +1029,54 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>>>>        return NULL;
>>>>    }
>>>>    +static void veth_bql_maybe_complete(struct veth_bql_state *state,
>>>> +                    struct netdev_queue *peer_txq,
>>>> +                    u64 bql_flush_ns)
>>>> +{
>>>> +    u64 current_time;
>>>> +
>>>> +    /* There is no reason to complete with 0 and
>>>> +     * peer_txq could go away.
>>>> +     */
>>>> +    if (!state->n_bql || !peer_txq)
>>>> +        return;
>>>> +
>>>> +    current_time = sched_clock();
>>>> +
>>>> +    /* We complete if:
>>>> +     * 1. We reach bql_flush_ns.
>>>> +     * 2. We potentially have BQL starvation.
>>>> +     */
>>>> +    if (state->time + bql_flush_ns <= current_time ||
>>>> +        state->n_bql > peer_txq->dql.limit) {
>>>
>> Indeed, this does not compile when CONFIG_BQL is not set. I think we should just bring back the 'queue is empty + queue is stopped' check from v6 back at the end of the poll and remove the n_bql > dql.limit check.
> 
> We would put #ifdef CONFIG_BQL around that logic aswell.
> 
>> It also feels not obvious why this is handling the starvation case. This only works, because the producer has went overlimit previously and was stopped. So more than 'limit' packets have been enqueued to the ring, and they are eventually drained when this check is true.
> 
> I think it just needs some comment tweaking:
> 
> /* We complete if:
>   * 1. We reach bql_flush_ns.
>   * 2. We have BQL starvation. This means that the queue was over-limit
>   *    in the last interval, and there is no more data in the queue,
>   *    which is equivalent to we consumed more than limit items.
>   */
> 
>> By removing this we can also avoid accessing dql internal members, but if you don't think that's a problem we can leave as is.
> 
> I agree accessing dql internal variables is not perfect.
> 
> That is why I have locally implemented DQL for software interfaces in
> a generic way inside dynamic_queue_limits.{h,c}.
> I was able to squeeze the time and n_bql variables into the completion
> cacheline of the dql struct by moving around variables.
> The logic applies inside dql_completed() if enabled.
> With this we just have to call netdev_completed_queue().
> Also it allows for per-queue tweaking of tx_usecs via sysfs.
> Works well for me, can share it if we want to use it.
> 
>>
>> Further, this is only works if VETH_BQL_UNIT stays 1, otherwise it will never fire. Anyway, still its necessary to check for CONFIG_BQL. But we could solve this by adding VETH_BQL_UNIT to n_bql instead of 1. This is also safe from any overflows, since limit is bound to limit_max, inflight is always less than limit + 1*VETH_BQL_UNIT and n_bql <= inflight.
> 
> You are right.
> 
> But I think there is no reason for VETH_BQL_UNIT anyway.
> There should be no difference in the BQL algorithm, I personally
> would replace VETH_BQL_UNIT with a hard-coded 1.
> 
>>
>> In a version of bringing back the 'queue-empty' check and keeping most of the current logic (so a mixture of v6 and v7) resulted in the same performance on an x86_64 architecture.
>>
>>> Both Sashiko-Nipa and Sashiko-Gemini are right, this is missing a
>>> #ifdef CONFIG_BQL. Not sure what is the best way to add them.
>>> And for the struct we could maybe do:
>>>
>>> #ifdef CONFIG_BQL
>>> struct veth_bql_state {
>>>       u64    time;    /* sched_clock() when current coalescing window started */
>>>       uint    n_bql;    /* BQL completions batched in the current window */
>>> };
>>> #else
>>> struct veth_bql_state {};
>>> #endif
>> Regarding the configs: we can just do something along those lines.
>> struct veth_rq {
>> ...
>> #ifdef CONFIG_BQL
>>      struct veth_bql_state        dql;
>> #endif
>> ...
>> }
>>
>> and we put the rest of the code that accesses or performs an action regarding bql in some functions and do it like in netdev_* functions with
>>
>> Function-Signature()
>> {
>> #ifdef CONFIG_BQL
>> // Code
>> #endif
>> }
>>
>> Wdyt?
>> - Jonas
> 
> Yes, we have to. Unless we put it into dynamic_queue_limits.{h,c}
> of course :^)
> 
> Thanks,
> Simon
> I did implement the CONFIG_BQL guard, and reordered the completion call,
dropping the pre-loop completion call and moved the in-loop
completion call in front of the packet processing. I think we can drop
one of the completion calls, since the there is only a difference of one
packet more or less that is completed.

Two patches on top of 5/5, inline below as RFC (not for application):

   1) veth: simplify BQL completion condition
   2) veth: Add CONFIG_BQL guards

Patch 1 is the "bring back the queue-empty check" idea: it drops the
state->n_bql > dql.limit test and splits the flush into (a) the
time-based completion, kept per packet, and (b) an explicit post-loop
"ring drained + peer stopped" wake. So veth no longer touches dql.limit.
Basically the same we had in v6.

However, if we like we can just replace it in the eth_bql_flush_starved
with the barrier-free alternative:

	if (peer_txq &&
	    (u64)state->n_bql * VETH_BQL_UNIT > peer_txq->dql.limit)
		veth_bql_complete(...);

Once the producer is stopped, num_queued/num_completed/limit are frozen,
so as the ring drains n_bql rises to inflight and this becomes true
exactly when the ring empties under backpressure — same event, no
barrier.

So there are three options how to handle this case:

   a) barrier + STACK_XOFF (patch 1 as posted).

   b) n_bql * VETH_BQL_UNIT > dql.limit.

   c) Simon's generic DQL-for-software-interfaces in
      dynamic_queue_limits.{h,c}

I do not have a strong opinion. For a and b I could not measure any 
performance difference.

Patch 2 does the CONFIG_BQL wrapping the way I sketched (BQL-only 
helpers with no-op stubs so veth_xdp_rcv()/teardown stay ifdef-free) and 
rejects `ethtool -C tx-usecs` with -EOPNOTSUPP when BQL is compiled out.

Performance of !CONFIG_BQL+v7+patch-2 and net-next/main is the same.

Full diffs below.

- Jonas

---8<--- patch 1 ---8<---

From: =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Sun, 28 Jun 2026 10:26:15 +0200
Subject: [PATCH] veth: simplify BQL completion condition
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous patch flushed batched BQL completions when either the
coalescing window elapsed or the batch grew past the DQL limit
(state->n_bql > peer_txq->dql.limit). The latter test reaches into DQL
internals and is unit-fragile: it compares the raw count n_bql against
dql.limit, dropping the VETH_BQL_UNIT factor of the charge
(n_bql * VETH_BQL_UNIT), so it only holds because that unit is 1.

Replace that test. The time-based completion stays per packet in
veth_xdp_rcv(), issued before veth_xdp_rcv_skb() so the producer wake
overlaps with the first skb processing. The wake-a-stalled-producer case
becomes an explicit post-loop block: once the ring has drained, if the
peer TX queue is stopped by BQL backpressure (STACK_XOFF), release the
batched completions to unblock it. DRV_XOFF is left to the existing wake
in veth_poll().

Reading STACK_XOFF after the drain needs an smp_rmb(): the producer sets
STACK_XOFF before publishing into the ring, so a consumer on another CPU
that observed the packet must order its ring read ahead of the state
read, or it may read a stale, un-stopped state and drop the wakeup. 
Pairs with the set_bit()/smp_wmb() on the producer side.

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
  drivers/net/veth.c | 53 ++++++++++++++++++++++++++++++----------------
  1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index c62d87a8402c..2963f190988f 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1029,11 +1029,21 @@ static struct sk_buff *veth_xdp_rcv_skb(struct 
veth_rq *rq,
  	return NULL;
  }

+static void veth_bql_complete(struct veth_bql_state *state,
+			      struct netdev_queue *peer_txq,
+			      u64 now)
+{
+	netdev_tx_completed_queue(peer_txq, state->n_bql,
+				  state->n_bql * VETH_BQL_UNIT);
+	state->time = now;
+	state->n_bql = 0;
+}
+
  static void veth_bql_maybe_complete(struct veth_bql_state *state,
  				    struct netdev_queue *peer_txq,
  				    u64 bql_flush_ns)
  {
-	u64 current_time;
+	u64 now;

  	/* There is no reason to complete with 0 and
  	 * peer_txq could go away.
@@ -1041,19 +1051,12 @@ static void veth_bql_maybe_complete(struct 
veth_bql_state *state,
  	if (!state->n_bql || !peer_txq)
  		return;

-	current_time = sched_clock();
-
-	/* We complete if:
-	 * 1. We reach bql_flush_ns.
-	 * 2. We potentially have BQL starvation.
+	/* Release the batched completions once the coalescing window has
+	 * elapsed.
  	 */
-	if (state->time + bql_flush_ns <= current_time ||
-	    state->n_bql > peer_txq->dql.limit) {
-		netdev_tx_completed_queue(peer_txq, state->n_bql,
-					  state->n_bql * VETH_BQL_UNIT);
-		state->time = current_time;
-		state->n_bql = 0;
-	}
+	now = sched_clock();
+	if (state->time + bql_flush_ns <= now)
+		veth_bql_complete(state, peer_txq, now);
  }

  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
@@ -1075,9 +1078,6 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,
  	 */
  	state->time = min(state->time, sched_clock());

-	/* Flush completions that timed out since the previous NAPI poll. */
-	veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
-
  	for (i = 0; i < budget; i++) {
  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);

@@ -1105,8 +1105,12 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,

  			if (veth_ptr_is_bql(ptr))
  				state->n_bql++;
-			stats->xdp_bytes += skb->len;
+			/* Complete before processing so the producer wakes
+			 * sooner; ring-empty case handled after the loop.
+			 */
+			veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);

+			stats->xdp_bytes += skb->len;
  			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
  			if (skb) {
  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
@@ -1115,13 +1119,26 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,
  					napi_gro_receive(&rq->xdp_napi, skb);
  			}
  		}
-		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
  		done++;
  	}

  	if (n_xdpf)
  		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);

+	/* If the ring drained and the peer TX queue is stalled by BQL
+	 * backpressure (STACK_XOFF), release the batched completions now to
+	 * unblock the producer. DRV_XOFF is handled by the wake in veth_poll().
+	 */
+	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
+		/* The consume above observed the producer's publish; order it
+		 * before reading STACK_XOFF. Pairs with the smp_wmb() and XOFF
+		 * set_bit() on the producer side.
+		 */
+		smp_rmb();
+		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
+			veth_bql_complete(state, peer_txq, sched_clock());
+	}
+
  	u64_stats_update_begin(&rq->stats.syncp);
  	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
  	rq->stats.vs.xdp_bytes += stats->xdp_bytes;
-- 
2.53.0

---8<--- patch 2 ---8<---

From: =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Thu, 2 Jul 2026 10:13:02 +0000
Subject: [PATCH] veth: Add CONFIG_BQL guards
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wrap the BQL-only code under CONFIG_BQL and expose it to the driver
through a small set of helpers with no-op stubs for the !CONFIG_BQL
case, so veth_xdp_rcv() and the NAPI teardown path stay free of ifdefs:

   veth_bql_poll_prepare()   per-poll setup: clamps the coalescing window
                             timestamp and returns the interval length, so
                             !CONFIG_BQL builds never read tx_coal_usecs
   veth_bql_account()        counts a consumed BQL-tagged skb and releases
                             the batch once the interval window has elapsed
   veth_bql_flush_starved()  releases the batch early when the ring has
                             drained and the peer txq is stopped by BQL
                             backpressure (STACK_XOFF)
   veth_bql_state_init()
   veth_bql_drain_and_reset() per-queue state setup and teardown

Since tx-usecs only batches BQL completions, reject ethtool -C tx-usecs
with -EOPNOTSUPP when BQL is compiled out instead of silently storing an
inert value.

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
  drivers/net/veth.c | 173 +++++++++++++++++++++++++++++----------------
  1 file changed, 111 insertions(+), 62 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2963f190988f..5c3b7820c55c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -73,7 +73,7 @@ struct veth_rq_stats {

  struct veth_bql_state {
  	u64	time;	/* sched_clock() when current coalescing window started */
-	uint	n_bql;	/* BQL completions batched in the current window */
+	unsigned int	n_bql;	/* BQL completions batched in the current window */
  };

  struct veth_rq {
@@ -83,7 +83,9 @@ struct veth_rq {
  	struct bpf_prog __rcu	*xdp_prog;
  	struct xdp_mem_info	xdp_mem;
  	struct veth_rq_stats	stats;
+#ifdef CONFIG_BQL
  	struct veth_bql_state	bql_state;
+#endif
  	bool			rx_notify_masked;
  	struct ptr_ring		xdp_ring;
  	struct xdp_rxq_info	xdp_rxq;
@@ -300,6 +302,12 @@ static int veth_set_coalesce(struct net_device *dev,
  	struct veth_priv *priv = netdev_priv(dev);
  	struct net_device *peer;

+	/* tx-usecs only batches BQL completions; without BQL it is inert. */
+	if (!IS_ENABLED(CONFIG_BQL)) {
+		NL_SET_ERR_MSG_MOD(extack, "tx-usecs requires CONFIG_BQL");
+		return -EOPNOTSUPP;
+	}
+
  	/* The coalescing window delays BQL completions, so keep tx-usecs well
  	 * below the tx_timeout watchdog; otherwise a large value could stall a
  	 * stopped queue long enough to trip a false watchdog timeout. Cap at
@@ -351,11 +359,6 @@ static bool veth_is_xdp_frame(void *ptr)
  	return (unsigned long)ptr & VETH_XDP_FLAG;
  }

-static bool veth_ptr_is_bql(void *ptr)
-{
-	return (unsigned long)ptr & VETH_BQL_FLAG;
-}
-
  static struct sk_buff *veth_ptr_to_skb(void *ptr)
  {
  	return (void *)((unsigned long)ptr & ~VETH_BQL_FLAG);
@@ -384,25 +387,6 @@ static void veth_ptr_free(void *ptr)
  		kfree_skb(veth_ptr_to_skb(ptr));
  }

-/* Drain frames left in the ptr_ring at teardown, freeing each one and
- * returning the number of BQL-charged SKBs.  The caller completes these
- * via netdev_tx_completed_queue() to balance the DQL accounting, avoiding
- * the racy netdev_tx_reset_queue()/dql_reset().
- */
-static unsigned int veth_ptr_ring_drain(struct ptr_ring *ring)
-{
-	unsigned int n_bql = 0;
-	void *ptr;
-
-	while ((ptr = ptr_ring_consume(ring))) {
-		if (veth_ptr_is_bql(ptr))
-			n_bql++;
-		veth_ptr_free(ptr);
-	}
-
-	return n_bql;
-}
-
  static void __veth_xdp_flush(struct veth_rq *rq)
  {
  	/* Write ptr_ring before reading rx_notify_masked */
@@ -1029,6 +1013,31 @@ static struct sk_buff *veth_xdp_rcv_skb(struct 
veth_rq *rq,
  	return NULL;
  }

+#ifdef CONFIG_BQL
+static bool veth_ptr_is_bql(void *ptr)
+{
+	return (unsigned long)ptr & VETH_BQL_FLAG;
+}
+
+/* Drain frames left in the ptr_ring at teardown, freeing each one and
+ * returning the number of BQL-charged SKBs.  The caller completes these
+ * via netdev_tx_completed_queue() to balance the DQL accounting, avoiding
+ * the racy netdev_tx_reset_queue()/dql_reset().
+ */
+static unsigned int veth_bql_ring_drain(struct ptr_ring *ring)
+{
+	unsigned int n_bql = 0;
+	void *ptr;
+
+	while ((ptr = ptr_ring_consume(ring))) {
+		if (veth_ptr_is_bql(ptr))
+			n_bql++;
+		veth_ptr_free(ptr);
+	}
+
+	return n_bql;
+}
+
  static void veth_bql_complete(struct veth_bql_state *state,
  			      struct netdev_queue *peer_txq,
  			      u64 now)
@@ -1039,18 +1048,18 @@ static void veth_bql_complete(struct 
veth_bql_state *state,
  	state->n_bql = 0;
  }

-static void veth_bql_maybe_complete(struct veth_bql_state *state,
-				    struct netdev_queue *peer_txq,
-				    u64 bql_flush_ns)
+static void veth_bql_account(struct veth_rq *rq,
+			     struct netdev_queue *peer_txq,
+			     void *ptr, u64 bql_flush_ns)
  {
+	struct veth_bql_state *state = &rq->bql_state;
  	u64 now;

-	/* There is no reason to complete with 0 and
-	 * peer_txq could go away.
-	 */
-	if (!state->n_bql || !peer_txq)
+	if (!peer_txq || !veth_ptr_is_bql(ptr))
  		return;

+	state->n_bql++;
+
  	/* Release the batched completions once the coalescing window has
  	 * elapsed.
  	 */
@@ -1059,24 +1068,81 @@ static void veth_bql_maybe_complete(struct 
veth_bql_state *state,
  		veth_bql_complete(state, peer_txq, now);
  }

+/* Per-poll setup: clamp the window timestamp and return the length of the
+ * coalescing window in ns.
+ */
+static u64 veth_bql_poll_prepare(struct veth_rq *rq)
+{
+	struct veth_priv *priv = netdev_priv(rq->dev);
+	struct veth_bql_state *state = &rq->bql_state;
+
+	/* Clamp stored timestamp in case we migrated to a CPU with a behind
+	 * sched_clock(); tries to reduce late BQL flushes.
+	 */
+	state->time = min(state->time, sched_clock());
+
+	/* Mirrored to both peers; paired with WRITE_ONCE() in 
veth_set_coalesce */
+	return (u64)READ_ONCE(priv->tx_coal_usecs) * NSEC_PER_USEC;
+}
+
+static void veth_bql_flush_starved(struct veth_rq *rq,
+				   struct netdev_queue *peer_txq)
+{
+	struct veth_bql_state *state = &rq->bql_state;
+
+	if (!peer_txq)
+		return;
+
+	/* If the ring drained and the peer TX queue is stalled by BQL
+	 * backpressure (STACK_XOFF), release the batched completions now to
+	 * unblock the producer. DRV_XOFF is handled by the wake in veth_poll().
+	 */
+	if (state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
+		/* The consume above observed the producer's publish; order it
+		 * before reading STACK_XOFF. Pairs with the smp_wmb() and XOFF
+		 * set_bit() on the producer side.
+		 */
+		smp_rmb();
+		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
+			veth_bql_complete(state, peer_txq, sched_clock());
+	}
+}
+
+static void veth_bql_state_init(struct veth_rq *rq)
+{
+	rq->bql_state.time = sched_clock();
+	rq->bql_state.n_bql = 0;
+}
+
+static unsigned int veth_bql_drain_and_reset(struct veth_rq *rq)
+{
+	unsigned int n_bql = veth_bql_ring_drain(&rq->xdp_ring) + 
rq->bql_state.n_bql;
+
+	rq->bql_state.n_bql = 0;
+	rq->bql_state.time = 0;
+	return n_bql;
+}
+#else
+static inline void veth_bql_account(struct veth_rq *rq,
+				    struct netdev_queue *peer_txq,
+				    void *ptr, u64 bql_flush_ns) {}
+static inline u64 veth_bql_poll_prepare(struct veth_rq *rq) { return 0; }
+static inline void veth_bql_flush_starved(struct veth_rq *rq,
+					  struct netdev_queue *peer_txq) {}
+static inline void veth_bql_state_init(struct veth_rq *rq) {}
+static inline unsigned int veth_bql_drain_and_reset(struct veth_rq *rq) 
{ return 0; }
+#endif
+
  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
  			struct veth_xdp_tx_bq *bq,
  			struct veth_stats *stats,
  			struct netdev_queue *peer_txq)
  {
-	struct veth_priv *priv = netdev_priv(rq->dev);
-	struct veth_bql_state *state = &rq->bql_state;
  	int i, done = 0, n_xdpf = 0;
  	void *xdpf[VETH_XDP_BATCH];
  	u64 bql_flush_ns;

-	/* Mirrored to both peers; paired with WRITE_ONCE() in 
veth_set_coalesce */
-	bql_flush_ns = (u64)READ_ONCE(priv->tx_coal_usecs) * 1000;
-
-	/* Clamp stored timestamp in case we migrated to a CPU with a behind
-	 * sched_clock(); tries to reduce late BQL flushes.
-	 */
-	state->time = min(state->time, sched_clock());
+	bql_flush_ns = veth_bql_poll_prepare(rq);

  	for (i = 0; i < budget; i++) {
  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
@@ -1103,12 +1169,10 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,
  			/* ndo_start_xmit */
  			struct sk_buff *skb = veth_ptr_to_skb(ptr);

-			if (veth_ptr_is_bql(ptr))
-				state->n_bql++;
  			/* Complete before processing so the producer wakes
  			 * sooner; ring-empty case handled after the loop.
  			 */
-			veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
+			veth_bql_account(rq, peer_txq, ptr, bql_flush_ns);

  			stats->xdp_bytes += skb->len;
  			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
@@ -1125,19 +1189,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int 
budget,
  	if (n_xdpf)
  		veth_xdp_rcv_bulk_skb(rq, xdpf, n_xdpf, bq, stats);

-	/* If the ring drained and the peer TX queue is stalled by BQL
-	 * backpressure (STACK_XOFF), release the batched completions now to
-	 * unblock the producer. DRV_XOFF is handled by the wake in veth_poll().
-	 */
-	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
-		/* The consume above observed the producer's publish; order it
-		 * before reading STACK_XOFF. Pairs with the smp_wmb() and XOFF
-		 * set_bit() on the producer side.
-		 */
-		smp_rmb();
-		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
-			veth_bql_complete(state, peer_txq, sched_clock());
-	}
+	veth_bql_flush_starved(rq, peer_txq);

  	u64_stats_update_begin(&rq->stats.syncp);
  	rq->stats.vs.xdp_redirect += stats->xdp_redirect;
@@ -1241,8 +1293,7 @@ static int __veth_napi_enable_range(struct 
net_device *dev, int start, int end)
  	for (i = start; i < end; i++) {
  		struct veth_rq *rq = &priv->rq[i];

-		rq->bql_state.time = sched_clock();
-		rq->bql_state.n_bql = 0;
+		veth_bql_state_init(rq);

  		napi_enable(&rq->xdp_napi);
  		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
@@ -1298,10 +1349,8 @@ static void veth_napi_del_range(struct net_device 
*dev, int start, int end)
  		 * (consumed by NAPI but not yet flushed).  Both were charged
  		 * via netdev_tx_sent_queue() and are still outstanding.
  		 */
-		n_bql = veth_ptr_ring_drain(&rq->xdp_ring) + rq->bql_state.n_bql;
+		n_bql = veth_bql_drain_and_reset(rq);
  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
-		rq->bql_state.n_bql = 0;
-		rq->bql_state.time = 0;

  		if (!peer || i >= peer->num_tx_queues)
  			continue;
-- 
2.53.0
>>>
>>>> +        netdev_tx_completed_queue(peer_txq, state->n_bql,
>>>> +                      state->n_bql * VETH_BQL_UNIT);
>>>> +        state->time = current_time;
>>>> +        state->n_bql = 0;
>>>> +    }
>>>> +}
>>>> +
>>>>    static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>>                struct veth_xdp_tx_bq *bq,
>>>>                struct veth_stats *stats,
>>>>                struct netdev_queue *peer_txq)
>>>>    {
>>>> +    struct veth_priv *priv = netdev_priv(rq->dev);
>>>> +    struct veth_bql_state *state = &rq->bql_state;
>>>>        int i, done = 0, n_xdpf = 0;
>>>>        void *xdpf[VETH_XDP_BATCH];
>>>> +    u64 bql_flush_ns;
>>>> +
>>>> +    /* Mirrored to both peers; paired with WRITE_ONCE() in veth_set_coalesce */
>>>> +    bql_flush_ns = (u64)READ_ONCE(priv->tx_coal_usecs) * 1000;
>>>> +
>>>> +    /* Clamp stored timestamp in case we migrated to a CPU with a behind
>>>> +     * sched_clock(); tries to reduce late BQL flushes.
>>>> +     */
>>>> +    state->time = min(state->time, sched_clock());
>>>> +
>>>> +    /* Flush completions that timed out since the previous NAPI poll. */
>>>> +    veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);>>
>>>>        for (i = 0; i < budget; i++) {
>>>>            void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>>>> @@ -1000,12 +1101,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>>                }
>>>>            } else {
>>>>                /* ndo_start_xmit */
>>>> -            bool bql_charged = veth_ptr_is_bql(ptr);
>>>>                struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>>>    +            if (veth_ptr_is_bql(ptr))
>>>> +                state->n_bql++;
>>>>                stats->xdp_bytes += skb->len;
>>>> -            if (peer_txq && bql_charged)
>>>> -                netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
>>>>                  skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
>>>>                if (skb) {
>>>> @@ -1015,6 +1115,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>>>                        napi_gro_receive(&rq->xdp_napi, skb);
>>>>                }
>>>>            }
>>>> +        veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>>>>            done++;
>>>
>>> Sashiko-Nipa reports:
>>>
>>> "If veth_xdp_rcv() finishes and returns a done count less than the budget,
>>> NAPI will go to sleep in veth_poll(). Do we need to unconditionally flush
>>> any stranded BQL completions in veth_poll() before sleeping?
>>> If completions are left in rq->bql_state indefinitely across NAPI idle
>>> periods, it might present an artificially massive delay to DQL. This could
>>> cause DQL to mistakenly conclude the hardware is extremely slow and
>>> aggressively shrink dql.limit to its minimum, crippling throughput on
>>> subsequent bursts."
>>>
>>> Again the issue that I found to be non-problematic in [1] and can be
>>> seen by an BQL inflight > 0 when for example pktgen suddenly stops.
>>>
>>> If we would "unconditionally flush any stranded BQL completions in
>>> veth_poll() before sleeping" we would *not* accumulate BQL completions
>>> across NAPI polls but we want to do that.
>>>
>>> Do you agree?
>>>
>>> [1] https://lore.kernel.org/netdev/c8650d3a-e488-4279-b28f-549d766c23a1@tu-dortmund.de/
>>



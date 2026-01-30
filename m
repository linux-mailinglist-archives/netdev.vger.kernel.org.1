Return-Path: <netdev+bounces-255188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBrNBpvifGkQPQIAu9opvQ
	(envelope-from <netdev+bounces-255188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:55:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA7BCB54
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1A73030139
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A53352C5D;
	Fri, 30 Jan 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYCkOJDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BC3358B8;
	Fri, 30 Jan 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792050; cv=none; b=KkYm+ssQsPZsoaEAQciSI+/Wmnn9f+K/sq5p4looiQ0D1U5txaD4LRAWT0Zn0USeGbhw3eTqAhqwhox7M/zWv+ESW3trduPrQOFLcEo0oc6MeNwyihnK996LhpBXyzNYMMPyPkD1FV+sJ9TnsxxWQoaKbZ6pQrLJxnWUIE+L0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792050; c=relaxed/simple;
	bh=ephIT4v1KrY7rnsSJlQo+RxoFpbdo5aelPh8LwSP4Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wzr1zxKnHUmw5HiT0LTIfIXfAOD93kpg7M353xYoG87vicFNwzdBawZPvSWPlFt8BbxoecmSkCV7blbRlUmTSIgGAciIS+vdNFF7P31odW3wnqfcpTFS1KP/nN/Hq6iAPVWMU3+TjvOlbndBweQnALqhpgrNYc5zMyZ+87dCfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYCkOJDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AD1C4CEF7;
	Fri, 30 Jan 2026 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769792049;
	bh=ephIT4v1KrY7rnsSJlQo+RxoFpbdo5aelPh8LwSP4Lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tYCkOJDHKoHSYCl4GKsQWl4+Te6GuPmT5jLEFPmyWjCwi4wMtVvpCvkaux2IH6JdG
	 hSYz8LLKLaeAnzcxG9MKua54mWFv4Dx4ycRE3HT6srjxIJkv7OYc2FynIrTLEZ3I7i
	 nPsTuV5Xb6vSfMx/z1ItBfGHlLsPzvJAgrEsqM2Ib4oGJiBiwZfrJotyELTGk6t2+o
	 aQjwkDW5o1/7jFBIfpIZSanwxeQynrs7YwiHyPdLicVE717l3UdIs/VdPiSd7URI0M
	 u/41++oSrAPpcCqwKc2o9jCshSxwebAvezYo8xfziUY7/Krm20rcJQSbIXjjoPvWzO
	 yp/Fyqc49JzSA==
Message-ID: <6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org>
Date: Fri, 30 Jan 2026 17:54:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons
 for monitoring
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com
References: <176917072608.1186611.11185920960590396939.stgit@firesoul>
 <87zf5v3347.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87zf5v3347.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,vger.kernel.org,gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87DA7BCB54
X-Rspamd-Action: no action



On 30/01/2026 09.40, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> 
>> Add specific drop reasons to SFQ qdisc to improve packet drop
>> observability and monitoring capabilities. This change replaces
>> generic qdisc_drop() calls with qdisc_drop_reason() to provide
>> granular metrics about different drop scenarios in production
>> environments.
>>
>> Two new drop reasons are introduced:
>>
>> - SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
>>    be created because the maximum number of flows (flows parameter)
>>    has been reached and no free flow slots are available.
>>
>> - SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
>>    length exceeds the per-flow depth limit (depth parameter),
>>    triggering either tail drop or head drop depending on headdrop
>>    configuration.
>>
>> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
>> when the overall qdisc limit is exceeded and packets are dropped
>> from the longest queue.
>>
>> The naming uses qdisc-specific drop reasons tied to SFQ tunables,
>> following the pattern established by Eric's FQ commit 5765c7f6e317
>> ("net_sched: sch_fq: add three drop_reason") which introduced
>> FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.
>>
>> The new drop reasons are inserted in the middle of the enum after
>> SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
>> together. While drop reason enum values are not UAPI, the enum
>> names implicitly become UAPI as userspace tools rely on BTF to
>> resolve names to values. This makes middle-insertion safe as long
>> as names remain stable.
>>
>> These detailed drop reasons enable production monitoring systems
>> to distinguish between different SFQ drop scenarios and generate
>> specific metrics for:
>> - Flow table exhaustion (flows exceeded)
>> - Per-flow congestion (depth limit exceeded)
>> - Global qdisc congestion (overall limit exceeded)
>>
>> This granular visibility allows operators to identify capacity
>> planning needs, detect traffic patterns, and optimize SFQ
>> configuration based on real-world drop patterns.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> Okay, so I went looking for ways to get the information (which qdisc did
> the drop come from) with a generic drop reason and... it's not exactly
> trivial?
> 

(Correct, it is actually not possible to get the qdisc from the call
location (see below), because we don't have the txq.)

> My thought was that you could get it from the location, but that ends up
> being in the generic __dev_queue_xmit:
> 
>             ping-117101  [017] b.s2. 155651.231372: kfree_skb: skbaddr=0000000019495eb6 rx_sk=0000000000000000 protocol=34525 location=__dev_queue_xmit+0xcbd/0xee0 reason: QDISC_DROP
> 
> So you can't actually use the kfree_skb trace point to go backwards to
> the qdisc.

Thanks you for providing this example. Showing what info is provided by
the tracepoint to existing tools.  (The location=__dev_queue_xmit is
key, but realize this is actually __dev_xmit_skb being inlined)


> Given that we have a sometimes-NULL socket parameter to the kfree_skb
> tracepoint, I think it would make sense to augment it with a 'dev'
> parameter as well, but that would require some restructuring of the drop
> code, I guess.
> 

Adding 'dev' parameter to drop tracepoint is IMHO a can-of-worms.
I.e. do you mean the ingress or egress device?
The skb->dev pointer changes meaning ingress or egress depending on
where in the network stack code we are.  And sometimes it is not even a
net_device pointer, see the double union[1] skb->dev belongs to.
Besides having the 'dev' doesn't help my use-case, I need the qdisc.

  [1] 
https://elixir.bootlin.com/linux/v6.18.6/source/include/linux/skbuff.h#L886-L900

I've been looking over the code multiple times. A possible alternative
is to have a new tracepoint for qdisc drops (meaning it no-longer calls
trace_kfree_skb / skb:kfree_skb). We could argue that qdisc drops have
it's own meaning like "consume".  Would this be acceptable?

This will allow tracepoint to have it's own enum set of
qdisc_drop_reasons.  This new tracepoint should have the same arguments
as __dev_xmit_skb, and we know the 'dev' is egress :

  static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
				 struct net_device *dev,
				 struct netdev_queue *txq)

Doing this work involves removing all the qdisc specific drop_reason,
except SKB_DROP_REASON_QDISC_DROP.  Is that acceptable?

I need some buy-in from maintainers Paolo/Jakub/Eric if you want me to
go down this road.  It is a lot of churn and restructuring for
something, that might be overkill.  Current patch solves my use-case,
but it would be cool/powerful to have qdisc pointer readable by BPF,
although I don't have a use-case in mind.


> Another option would be to add new stats members to sfq for each of
> these drop reasons? Assuming you're only after the counts, that would
> allow you to get those without adding new drop reasons to the core code?
>

I'm fine with someone adding more stats members to SFQ, but it doesn't
solve my use-case.  As mentioned before, we also sample packets and have
different sample rates based on drop_reasons.  We also use this as a
cmdline troubleshooting tool when debugging a prod issue, e.g. just
using perf record.


> OTOH, since we already have per-qdisc specific drop reasons for FQ and
> CAKE, and adding more enums is cheap, I am also OK with adding these; so
> with that in mind:
> 
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>

Thanks a lot for your review.

--Jesper





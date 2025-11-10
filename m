Return-Path: <netdev+bounces-237143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031FC45F51
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44E01880637
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996272FFDFA;
	Mon, 10 Nov 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCeo2kxy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442B23D7FB
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770998; cv=none; b=J9tP9qCUO6ZK9owOYWK0P0vw1P545/azncConQQDREYaDZEoR+nPgjpHGKuomIYhw7DyJ552hZKocdPCBTCHoJ7XXxWqhFn1u2+LwwshVBGb/rs9hpu9itmx5giOuthQEFE8ZOvWEUdcn7IKxu6EiufRjV7V+3CLY2VqHD4Ox2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770998; c=relaxed/simple;
	bh=8Mj0KHlwOPwFBXeVxo5G2W5WpCbYGFNTFjMRo9JbPJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prTf5Mv6qbNaiS7xNuL1LHoJXBDE1KXLvT8qv66lsqIZ5yUoS6QBwTifidbY2jq7kch4d18yePzyq7kyfrctThJR+r2vtkf2pho1ni1p9A57B9iJf/GdSmO8RQfrbMSUJGq0jzgsv19nnnDtA9xpPQrQH5fNN169qJybD7fQNiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCeo2kxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56375C4CEF5;
	Mon, 10 Nov 2025 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762770998;
	bh=8Mj0KHlwOPwFBXeVxo5G2W5WpCbYGFNTFjMRo9JbPJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lCeo2kxyAkG8UmBylk/VHrBhpKQM4fHzkdhKYyZku0YaJQPt8r57bdVRjO5dRTZBV
	 W0Ma7OmgaJvwY+L9i6svQKaS3TBqyqm+icbfbkM9UYffnCuX0zKlflIq5nW2eYd2YL
	 fFao510Ud5swj3H6eJZvsX7A3EKpsPb5pOKVX4w8BiBQTfLH81PUjEgs2cs8cw5hUB
	 M/7Qi8WMZYaF4/VOklBDJxuEK9zGveSdtw9htlg+e0+WZB7PLTPWdYk0GmPTu8i4qR
	 1MDZoDNN2cClASerT1RXAcNkOAlZPxm6/6uN5SInG1TV5M+sHSDV2eOrKAC1OOM/DW
	 0mEawN5PDKh3g==
Message-ID: <cb568e91-9114-4e9a-ba88-eb4fc3772690@kernel.org>
Date: Mon, 10 Nov 2025 11:36:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20251109161215.2574081-1-edumazet@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251109161215.2574081-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/11/2025 17.12, Eric Dumazet wrote:
> After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> I started seeing many qdisc requeues on IDPF under high TX workload.
> 
> $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle 1:
> qdisc mq 1: root
>   Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 requeues 3532840114)
>   backlog 1056Kb 6675p requeues 3532840114
> qdisc mq 1: root
>   Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 requeues 3537737653)
>   backlog 781164b 4822p requeues 3537737653
> 
> This is caused by try_bulk_dequeue_skb() being only limited by BQL budget.
> 
> perf record -C120-239 -e qdisc:qdisc_dequeue sleep 1 ; perf script
> ...
>   netperf 75332 [146]  2711.138269: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1292 skbaddr=0xff378005a1e9f200
>   netperf 75332 [146]  2711.138953: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1213 skbaddr=0xff378004d607a500
>   netperf 75330 [144]  2711.139631: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1233 skbaddr=0xff3780046be20100
>   netperf 75333 [147]  2711.140356: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1093 skbaddr=0xff37800514845b00
>   netperf 75337 [151]  2711.141037: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1353 skbaddr=0xff37800460753300
>   netperf 75337 [151]  2711.141877: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1367 skbaddr=0xff378004e72c7b00
>   netperf 75330 [144]  2711.142643: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1202 skbaddr=0xff3780045bd60000
> ...
> 
> This is bad because :
> 
> 1) Large batches hold one victim cpu for a very long time.
> 
> 2) Driver often hit their own TX ring limit (all slots are used).
> 
> 3) We call dev_requeue_skb()
> 
> 4) Requeues are using a FIFO (q->gso_skb), breaking qdisc ability to
>     implement FQ or priority scheduling.
> 
> 5) dequeue_skb() gets packets from q->gso_skb one skb at a time
>     with no xmit_more support. This is causing many spinlock games
>     between the qdisc and the device driver.
> 
> Requeues were supposed to be very rare, lets keep them this way.
> 
> Limit batch sizes to /proc/sys/net/core/dev_weight (default 64) as
> __qdisc_run() was designed to use.
> 
> Fixes: 5772e9a3463b ("qdisc: bulk dequeue support for qdiscs with TCQ_F_ONETXQUEUE")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   net/sched/sch_generic.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index d9a98d02a55fc361a223f3201e37b6a2b698bb5e..852e603c17551ee719bf1c561848d5ef0699ab5d 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -180,9 +180,10 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
>   static void try_bulk_dequeue_skb(struct Qdisc *q,
>   				 struct sk_buff *skb,
>   				 const struct netdev_queue *txq,
> -				 int *packets)
> +				 int *packets, int budget)
>   {
>   	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
> +	int cnt = 0;

You patch makes perfect sense, that we want this budget limit.

But: Why isn't bytelimit saving us?


Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

>   	while (bytelimit > 0) {
>   		struct sk_buff *nskb = q->dequeue(q);
> @@ -193,8 +194,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>   		bytelimit -= nskb->len; /* covers GSO len */
>   		skb->next = nskb;
>   		skb = nskb;
> -		(*packets)++; /* GSO counts as one pkt */
> +		if (++cnt >= budget)
> +			break;
>   	}
> +	(*packets) += cnt;
>   	skb_mark_not_on_list(skb);
>   }
>   
> @@ -228,7 +231,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
>    * A requeued skb (via q->gso_skb) can also be a SKB list.
>    */
>   static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
> -				   int *packets)
> +				   int *packets, int budget)
>   {
>   	const struct netdev_queue *txq = q->dev_queue;
>   	struct sk_buff *skb = NULL;
> @@ -295,7 +298,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>   	if (skb) {
>   bulk:
>   		if (qdisc_may_bulk(q))
> -			try_bulk_dequeue_skb(q, skb, txq, packets);
> +			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
>   		else
>   			try_bulk_dequeue_skb_slow(q, skb, packets);
>   	}
> @@ -387,7 +390,7 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
>    *				>0 - queue is not empty.
>    *
>    */
> -static inline bool qdisc_restart(struct Qdisc *q, int *packets)
> +static inline bool qdisc_restart(struct Qdisc *q, int *packets, int budget)
>   {
>   	spinlock_t *root_lock = NULL;
>   	struct netdev_queue *txq;
> @@ -396,7 +399,7 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets)
>   	bool validate;
>   
>   	/* Dequeue packet */
> -	skb = dequeue_skb(q, &validate, packets);
> +	skb = dequeue_skb(q, &validate, packets, budget);
>   	if (unlikely(!skb))
>   		return false;
>   
> @@ -414,7 +417,7 @@ void __qdisc_run(struct Qdisc *q)
>   	int quota = READ_ONCE(net_hotdata.dev_tx_weight);
>   	int packets;
>   
> -	while (qdisc_restart(q, &packets)) {
> +	while (qdisc_restart(q, &packets, quota)) {
>   		quota -= packets;
>   		if (quota <= 0) {
>   			if (q->flags & TCQ_F_NOLOCK)



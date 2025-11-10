Return-Path: <netdev+bounces-237204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC2C4765E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5704E6EB4
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC131283C;
	Mon, 10 Nov 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf/hyEAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11122157B
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787056; cv=none; b=JcWp0thRByq0lOJdwO5TAeCjboPsxw7AHA1Q9nInDBno8I6RfK+mbm1exABXqFQqpKMgCB92cYiwX6wuNqoYrl9oJCpM3+3lUJCcKjd1ZSGdca+7b29cUsGbdnQ4YLsG5xdgiI28MmFsE2XH/uJ2JsQagPW5PqXZFDM1N0CTXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787056; c=relaxed/simple;
	bh=ccQJK+qNK/xZ8I5sakzdydyx3iVmp4exdj6jVtoqMfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwcjqUo6415163H1Jvu89Xl1Puh9o+lvdL+Ujc8P9lwHrnAeo+LKFmgxcncCeMj+zjqisxIB1XCkuGOEa0PwUUKyl8nvkh7+n7zPckvjRAHGsR+e+TPAWxt4tMQs3aXYJ7YnAb+m1YbR52164qhVgD5sLBb1WByPdGWl9FjgoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf/hyEAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD1C4CEFB;
	Mon, 10 Nov 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787055;
	bh=ccQJK+qNK/xZ8I5sakzdydyx3iVmp4exdj6jVtoqMfk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sf/hyEAdVWdfPHMUMixCZ62BwDvPjGPHYu0jDW870RErC1qvEkK+b24pzqmhF8LFJ
	 E/QhirGH/QQwMuXrF2JPJa2k5F8E4YVbAzgz8XtZd52ZTiz5aiMRrZb/GyPIYROD2s
	 SrKKUBKgqs3cqjHeW1vUa+cofBIi7VSZX8wFzPGXD4P0VSj0uS+d5SIwvjOTBVzbct
	 kbCDDJlC3HpQQLBVi9cU4ou926tzYHMVEnHtpx1YsIWv9yD0N+DnQKxMEPRRPUCNtF
	 6rUGAO3qJQXVfINHciOWv/iPqLO1F9k3CkRDGmhrj+C3ZpSs6CkvinEWnFwEixvxR2
	 9t2vh3EZ6wn3A==
Message-ID: <4fc5d598-606d-4053-887a-d9b23586e35a@kernel.org>
Date: Mon, 10 Nov 2025 16:04:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 kernel-team <kernel-team@cloudflare.com>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>
References: <20251109161215.2574081-1-edumazet@google.com>
 <cb568e91-9114-4e9a-ba88-eb4fc3772690@kernel.org>
 <CANn89iJtEhs=sGsRF+NATcLL9-F8oKWxN_2igJehP8RvZjT-Lg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CANn89iJtEhs=sGsRF+NATcLL9-F8oKWxN_2igJehP8RvZjT-Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/11/2025 12.06, Eric Dumazet wrote:
> On Mon, Nov 10, 2025 at 2:36 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 09/11/2025 17.12, Eric Dumazet wrote:
>>> After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
>>> I started seeing many qdisc requeues on IDPF under high TX workload.
>>>
>>> $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle 1:
>>> qdisc mq 1: root
>>>    Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 requeues 3532840114)
>>>    backlog 1056Kb 6675p requeues 3532840114
>>> qdisc mq 1: root
>>>    Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 requeues 3537737653)
>>>    backlog 781164b 4822p requeues 3537737653
>>>
>>> This is caused by try_bulk_dequeue_skb() being only limited by BQL budget.
>>>
>>> perf record -C120-239 -e qdisc:qdisc_dequeue sleep 1 ; perf script
>>> ...
>>>    netperf 75332 [146]  2711.138269: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1292 skbaddr=0xff378005a1e9f200

To Jesse, see how Eric is using tracepoint qdisc:qdisc_dequeue

>>>    netperf 75332 [146]  2711.138953: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1213 skbaddr=0xff378004d607a500
>>>    netperf 75330 [144]  2711.139631: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1233 skbaddr=0xff3780046be20100
>>>    netperf 75333 [147]  2711.140356: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1093 skbaddr=0xff37800514845b00
>>>    netperf 75337 [151]  2711.141037: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1353 skbaddr=0xff37800460753300
>>>    netperf 75337 [151]  2711.141877: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1367 skbaddr=0xff378004e72c7b00
>>>    netperf 75330 [144]  2711.142643: qdisc:qdisc_dequeue: dequeue ifindex=5 qdisc handle=0x80150000 parent=0x10013 txq_state=0x0 packets=1202 skbaddr=0xff3780045bd60000
>>> ...
>>>
>>> This is bad because :
>>>
>>> 1) Large batches hold one victim cpu for a very long time.
>>>
>>> 2) Driver often hit their own TX ring limit (all slots are used).
>>>
>>> 3) We call dev_requeue_skb()
>>>
>>> 4) Requeues are using a FIFO (q->gso_skb), breaking qdisc ability to
>>>      implement FQ or priority scheduling.
>>>
>>> 5) dequeue_skb() gets packets from q->gso_skb one skb at a time
>>>      with no xmit_more support. This is causing many spinlock games
>>>      between the qdisc and the device driver.
>>>
>>> Requeues were supposed to be very rare, lets keep them this way.
>>>
>>> Limit batch sizes to /proc/sys/net/core/dev_weight (default 64) as
>>> __qdisc_run() was designed to use.
>>>
>>> Fixes: 5772e9a3463b ("qdisc: bulk dequeue support for qdiscs with TCQ_F_ONETXQUEUE")
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
>>> ---
>>>    net/sched/sch_generic.c | 17 ++++++++++-------
>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>>> index d9a98d02a55fc361a223f3201e37b6a2b698bb5e..852e603c17551ee719bf1c561848d5ef0699ab5d 100644
>>> --- a/net/sched/sch_generic.c
>>> +++ b/net/sched/sch_generic.c
>>> @@ -180,9 +180,10 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
>>>    static void try_bulk_dequeue_skb(struct Qdisc *q,
>>>                                 struct sk_buff *skb,
>>>                                 const struct netdev_queue *txq,
>>> -                              int *packets)
>>> +                              int *packets, int budget)
>>>    {
>>>        int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
>>> +     int cnt = 0;
>>
>> You patch makes perfect sense, that we want this budget limit.
>>
>> But: Why isn't bytelimit saving us?
> 
> BQL can easily grow
> /sys/class/net/eth1/queues/tx-XXX/byte_queue_limits/limit to quite big
> values with MQ high speed devices.
> 
> Each TX queue is usually serviced with RR, meaning that some of them
> can get a long standing queue.
> 
> 
> tjbp26:/home/edumazet# ./super_netperf 200 -H tjbp27 -l 100 &
> [1] 198996
> 
> tjbp26:/home/edumazet# grep .
> /sys/class/net/eth1/queues/tx-*/byte_queue_limits/limit
> /sys/class/net/eth1/queues/tx-0/byte_queue_limits/limit:116826
> /sys/class/net/eth1/queues/tx-10/byte_queue_limits/limit:84534
> /sys/class/net/eth1/queues/tx-11/byte_queue_limits/limit:342924
> /sys/class/net/eth1/queues/tx-12/byte_queue_limits/limit:433302
> /sys/class/net/eth1/queues/tx-13/byte_queue_limits/limit:409254
> /sys/class/net/eth1/queues/tx-14/byte_queue_limits/limit:434112
> /sys/class/net/eth1/queues/tx-15/byte_queue_limits/limit:68304
> /sys/class/net/eth1/queues/tx-16/byte_queue_limits/limit:65610
> /sys/class/net/eth1/queues/tx-17/byte_queue_limits/limit:65772
> /sys/class/net/eth1/queues/tx-18/byte_queue_limits/limit:69822
> /sys/class/net/eth1/queues/tx-19/byte_queue_limits/limit:440634
> /sys/class/net/eth1/queues/tx-1/byte_queue_limits/limit:70308
> /sys/class/net/eth1/queues/tx-20/byte_queue_limits/limit:304824
> /sys/class/net/eth1/queues/tx-21/byte_queue_limits/limit:497856
> /sys/class/net/eth1/queues/tx-22/byte_queue_limits/limit:70308
> /sys/class/net/eth1/queues/tx-23/byte_queue_limits/limit:535408
> /sys/class/net/eth1/queues/tx-24/byte_queue_limits/limit:79419
> /sys/class/net/eth1/queues/tx-25/byte_queue_limits/limit:70170
> /sys/class/net/eth1/queues/tx-26/byte_queue_limits/limit:1595568
> /sys/class/net/eth1/queues/tx-27/byte_queue_limits/limit:579108
> /sys/class/net/eth1/queues/tx-28/byte_queue_limits/limit:430578
> /sys/class/net/eth1/queues/tx-29/byte_queue_limits/limit:647172
> /sys/class/net/eth1/queues/tx-2/byte_queue_limits/limit:345492
> /sys/class/net/eth1/queues/tx-30/byte_queue_limits/limit:612392
> /sys/class/net/eth1/queues/tx-31/byte_queue_limits/limit:344376
> /sys/class/net/eth1/queues/tx-3/byte_queue_limits/limit:154740
> /sys/class/net/eth1/queues/tx-4/byte_queue_limits/limit:60588
> /sys/class/net/eth1/queues/tx-5/byte_queue_limits/limit:71970
> /sys/class/net/eth1/queues/tx-6/byte_queue_limits/limit:70308
> /sys/class/net/eth1/queues/tx-7/byte_queue_limits/limit:695454
> /sys/class/net/eth1/queues/tx-8/byte_queue_limits/limit:101760
> /sys/class/net/eth1/queues/tx-9/byte_queue_limits/limit:65286
> 
> Then if we send many small packets in a row, limit/pkt_avg_len can go
> to arbitrary values.
> 

Thanks for sharing.

With these numbers it makes sense that BQL bytelimit isn't limiting this 
much code much.

e.g. 1595568 bytes / 1500 MTU = 1063 packets.

Our prod also have large numbers:

$ grep -H . /sys/class/net/REDACT0/queues/tx-*/byte_queue_limits/limit | 
sort -k2rn -t: | head -n 10
/sys/class/net/ext0/queues/tx-38/byte_queue_limits/limit:819432
/sys/class/net/ext0/queues/tx-95/byte_queue_limits/limit:766227
/sys/class/net/ext0/queues/tx-2/byte_queue_limits/limit:715412
/sys/class/net/ext0/queues/tx-66/byte_queue_limits/limit:692073
/sys/class/net/ext0/queues/tx-20/byte_queue_limits/limit:679817
/sys/class/net/ext0/queues/tx-61/byte_queue_limits/limit:647638
/sys/class/net/ext0/queues/tx-11/byte_queue_limits/limit:642212
/sys/class/net/ext0/queues/tx-10/byte_queue_limits/limit:615188
/sys/class/net/ext0/queues/tx-48/byte_queue_limits/limit:613745
/sys/class/net/ext0/queues/tx-80/byte_queue_limits/limit:584850

--Jesper

>>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>
>>>        while (bytelimit > 0) {
>>>                struct sk_buff *nskb = q->dequeue(q);
>>> @@ -193,8 +194,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
>>>                bytelimit -= nskb->len; /* covers GSO len */
>>>                skb->next = nskb;
>>>                skb = nskb;
>>> -             (*packets)++; /* GSO counts as one pkt */
>>> +             if (++cnt >= budget)
>>> +                     break;
>>>        }
>>> +     (*packets) += cnt;
>>>        skb_mark_not_on_list(skb);
>>>    }
>>>
>>> @@ -228,7 +231,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
>>>     * A requeued skb (via q->gso_skb) can also be a SKB list.
>>>     */
>>>    static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>>> -                                int *packets)
>>> +                                int *packets, int budget)
>>>    {
>>>        const struct netdev_queue *txq = q->dev_queue;
>>>        struct sk_buff *skb = NULL;
>>> @@ -295,7 +298,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
>>>        if (skb) {
>>>    bulk:
>>>                if (qdisc_may_bulk(q))
>>> -                     try_bulk_dequeue_skb(q, skb, txq, packets);
>>> +                     try_bulk_dequeue_skb(q, skb, txq, packets, budget);
>>>                else
>>>                        try_bulk_dequeue_skb_slow(q, skb, packets);
>>>        }
>>> @@ -387,7 +390,7 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
>>>     *                          >0 - queue is not empty.
>>>     *
>>>     */
>>> -static inline bool qdisc_restart(struct Qdisc *q, int *packets)
>>> +static inline bool qdisc_restart(struct Qdisc *q, int *packets, int budget)
>>>    {
>>>        spinlock_t *root_lock = NULL;
>>>        struct netdev_queue *txq;
>>> @@ -396,7 +399,7 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets)
>>>        bool validate;
>>>
>>>        /* Dequeue packet */
>>> -     skb = dequeue_skb(q, &validate, packets);
>>> +     skb = dequeue_skb(q, &validate, packets, budget);
>>>        if (unlikely(!skb))
>>>                return false;
>>>
>>> @@ -414,7 +417,7 @@ void __qdisc_run(struct Qdisc *q)
>>>        int quota = READ_ONCE(net_hotdata.dev_tx_weight);
>>>        int packets;
>>>
>>> -     while (qdisc_restart(q, &packets)) {
>>> +     while (qdisc_restart(q, &packets, quota)) {
>>>                quota -= packets;
>>>                if (quota <= 0) {
>>>                        if (q->flags & TCQ_F_NOLOCK)
>>



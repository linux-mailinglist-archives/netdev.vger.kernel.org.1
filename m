Return-Path: <netdev+bounces-281871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHPOHJK38GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:35:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6F485F18
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F88321C2AB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF544B672;
	Tue, 28 Apr 2026 13:10:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1F44A708;
	Tue, 28 Apr 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381857; cv=none; b=c1nlmAzvYVCgpRzhQAeMVgaZ3hlEkY22Ax2Sd05IqTK11feDdYqfxhARGwOW/QTlYL3L8y4NE86wV1dQ2WuMqGIFcdwL/rRw+rVZ2YjeC8zEd/J7b+G+Zl/RQvrQbvNZn5GulzccHrsjuyfEuo3iSG4FgkPA18+3PFJB4pgy29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381857; c=relaxed/simple;
	bh=nmszbhvlmW6fCGQOwQbFQYvBDmzyGhtjk20ogqwaHEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWnkvLQjYbnJpDCdrOG9eo7xEKghlTsesQ7zAhNkwL9V8Vmv+XtblzzocDggGIF3gRLKFKAJ2ib64aNhStLFMfvxlVEnnv/N7yreBDFO6UtfsZGI9Mhoimsr1Fk17g0ZcEh/Zhmfu6nGOKeNJikK6X/cJmFSiR9R5RmM2gsMv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.62] ([129.217.186.62])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63SDAig6017192
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:10:45 +0200 (CEST)
Message-ID: <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
Date: Tue, 28 Apr 2026 15:10:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260428084851-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C8F6F485F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[tu-dortmund.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.601];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 14:50, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
>> becomes full. Once an entry is successfully produced and the ptr_ring
>> reaches capacity, the netdev queue is stopped instead of dropping
>> subsequent packets.
>>
>> If producing an entry fails anyways due to a race, tun_net_xmit returns
>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
>> LLTX is enabled and the transmit path operates without the usual locking.
>>
>> If no qdisc is present, the previous tail-drop behavior is preserved.
>>
>> The existing __tun_wake_queue() function of the consumer races with the
>> producer for waking/stopping the netdev queue: the consumer may drain
>> the ring just as the producer stops the queue, leading to a permanent
>> stall. To avoid this, the producer re-checks the ring after stopping
>> and wakes the queue itself if space was just made. An
>> smp_mb__after_atomic() is required so the re-peek of the ring sees any
>> drain that the consumer performed.
>> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
>> netif_wake_subqueue():
>>
>> Consumer CPU                  Producer CPU
>> ========================      =========================
>> __ptr_ring_consume()
>> netif_wake_subqueue()         netif_tx_stop_queue()
>>           /\                  smp_mb__after_atomic()
>>           ||                  __ptr_ring_produce_peek()
>> contains RMW operation
>>  test_and_clear_bit()
>>           /\
>>           ||
>>  "Fully ordered RMW:
>> smp_mb() before + after"
>>     - atomic_t.txt
>>
>> Benchmarks:
>> The benchmarks show a slight regression in raw transmission performance,
>> though no packets are lost anymore.
> 
> Could you include the packets received as well?
> To demonstrate the gains/lack of loss. 
> 

Do you mean the number of packets received by the VM?
They should just be the same as the number sent (shown below), right?

I assume they would be visible as RX-DRP for TAP.
For TAP + vhost-net I would have to rewrite the XDP drop
program to count the number of dropped packets...
And I would have to automate it...

>>
>> The previously introduced threshold to only wake after the queue stopped
>> and half of the ring was consumed showed to be a descent choice:
>> Waking the queue whenever a consume made space in the ring strongly
>> degrades performance for tap, while waking only when the ring is empty
>> is too late and also hurts throughput for tap & tap+vhost-net.
>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
>> 1/2 was chosen for the sake of simplicity for both tun/tap and
>> tun/tap+vhost-net.
>>
>> Test setup:
>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
>> mitigations disabled.
>>
>> Note for tap+vhost-net:
>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
>>
>> +--------------------------+--------------+----------------+----------+
>> | 1 thread                 | Stock        | Patched with   | diff     |
>> | sending                  |              | fq_codel qdisc |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
>> |            +-------------+--------------+----------------+----------+
>> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
>> |            +-------------+--------------+----------------+----------+
>> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>>
>> +--------------------------+--------------+----------------+----------+
>> | 2 threads                | Stock        | Patched with   | diff     |
>> | sending                  |              | fq_codel qdisc |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
>> |            +-------------+--------------+----------------+----------+
>> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
>> |            +-------------+--------------+----------------+----------+
>> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
>> +------------+-------------+--------------+----------------+----------+
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index efe809597622..c2a1618cc9db 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	struct netdev_queue *queue;
>>  	struct tun_file *tfile;
>>  	int len = skb->len;
>> +	bool qdisc_present;
>> +	int ret;
>>  
>>  	rcu_read_lock();
>>  	tfile = rcu_dereference(tun->tfiles[txq]);
>> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>  
>>  	nf_reset_ct(skb);
>>  
>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>> +	queue = netdev_get_tx_queue(dev, txq);
>> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
>> +
>> +	spin_lock(&tfile->tx_ring.producer_lock);
>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
>> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
>> +		netif_tx_stop_queue(queue);
>> +		/* Re-peek and wake if the consumer drained the ring
>> +		 * concurrently in a race. smp_mb__after_atomic() pairs
>> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
>> +		 * in __tun_wake_queue().
>> +		 */
>> +		smp_mb__after_atomic();
>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
>> +			netif_tx_wake_queue(queue);
>> +	}
>> +	spin_unlock(&tfile->tx_ring.producer_lock);
>> +
>> +	if (ret) {
>> +		/* If a qdisc is attached to our virtual device,
>> +		 * returning NETDEV_TX_BUSY is allowed.
>> +		 */
>> +		if (qdisc_present) {
>> +			rcu_read_unlock();
>> +			return NETDEV_TX_BUSY;
>> +		}
>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>>  		goto drop;
>>  	}
>>  
>>  	/* dev->lltx requires to do our own update of trans_start */
>> -	queue = netdev_get_tx_queue(dev, txq);
>>  	txq_trans_cond_update(queue);
>>  
>>  	/* Notify and wake up reader process */
>> -- 
>> 2.43.0
> 


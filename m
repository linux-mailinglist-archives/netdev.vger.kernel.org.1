Return-Path: <netdev+bounces-285157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GfpOgoy/GmNMgAAu9opvQ
	(envelope-from <netdev+bounces-285157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F64E385B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E456530071F1
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854D32E72F;
	Thu,  7 May 2026 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Uv+XNuwt"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EE32AABC;
	Thu,  7 May 2026 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135560; cv=none; b=f20tW6F4C1zJVeFkg/HBSvXaTwkXd3mIICdJdjZPlI4pGtC/3gkb+MTO3Br4AEy3JaeRXzLiGK73X6deQrN4Z4mhlDqOUP6x6DOehuLA8HE5x/4VrYEaKJboVI0r1qS9ugopwHYx4lviyvJxeffMIxCjRXN/kMIAz7Kw0Zwc7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135560; c=relaxed/simple;
	bh=Ti8yEkrhkt81vSIOjm0xwK4bAht5BORVIbZaPrf40m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfOttXtJAYrVM60PnCXeA+eLGR6F1IT/rlq/E9f6FEWj1Kz7ymi2YEzZG7GdwdpSTeK8xV7OxnIZh5URBHTE+l0WkLWwYqYlScNbCTVxjYFz4sG+mz2blMVBjT3SrqAVzMPYd4a4hdntlCGqjNcRNiSJiSv36Xt+9opURKpsqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Uv+XNuwt; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778135549;
	bh=Ti8yEkrhkt81vSIOjm0xwK4bAht5BORVIbZaPrf40m0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uv+XNuwtbUeMpiL0iHzDpIOLs6uQ1lSmFxXTFym1g6jJa9dxfubuQC2Rfej538INX
	 kU/U2fgNiIlCC9C3Wl4vSim/gIANmqOxIVSsEfoeUqKlFIZJ0WeL6xTSKf5e6VoYCv
	 iRZdCi0CHu2UUHgiai3JyDMZXdGrpyvSzWZDnQDA=
Received: from [129.217.186.46] ([129.217.186.46])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 6476WSQi019222
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 May 2026 08:32:28 +0200 (CEST)
Message-ID: <c9fc9e0a-0837-49b4-91b9-4adb54c1a037@tu-dortmund.de>
Date: Thu, 7 May 2026 08:32:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
 <20260506181909-mutt-send-email-mst@kernel.org>
 <20260506185515-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260506185515-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8E1F64E385B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285157-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim]
X-Rspamd-Action: no action

On 5/7/26 00:56, Michael S. Tsirkin wrote:
> On Wed, May 06, 2026 at 06:28:06PM -0400, Michael S. Tsirkin wrote:
>> On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
>>> becomes full. Once an entry is successfully produced and the ptr_ring
>>> reaches capacity, the netdev queue is stopped instead of dropping
>>> subsequent packets. If no qdisc is present, the previous tail-drop
>>> behavior is preserved.
>>>
>>> If producing an entry fails anyways due to a race, tun_net_xmit() drops
>>> the packet. Such races are expected because LLTX is enabled and the
>>> transmit path operates without the usual locking.
>>>
>>> The __tun_wake_queue() function of the consumer races with the producer
>>> for waking/stopping the netdev queue, which could result in a stalled
>>> queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
>>> with the smp_mb() of the consumer. It follows the principle of store
>>> buffering described in tools/memory-model/Documentation/recipes.txt:
>>>
>>> - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
>>>   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
>>>   ring with __ptr_ring_produce_peek().
>>>
>>> - The consumer in __tun_wake_queue() first writes zero to the ring in
>>>   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
>>>   status with netif_tx_queue_stopped().
>>>
>>> => Following the aforementioned principle, it is impossible for the
>>>    producer to see a full ring (and therefore not wake the queue on the
>>>    re-check) while the consumer simultaneously fails to see a stopped
>>>    queue (and therefore also does not wake it).
>>>
>>> Benchmarks:
>>> The benchmarks show a slight regression in raw transmission performance
>>> when using two sending threads. Packet loss also occurs only in the
>>> two-thread sending case; no packet loss was observed with a single
>>> sending thread.
>>>
>>> Test setup:
>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
>>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
>>> mitigations disabled.
>>>
>>> Note for tap+vhost-net:
>>> XDP drop program active in VM -> ~2.5x faster; slower for tap due to
>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
>>>
>>> +--------------------------+--------------+----------------+----------+
>>> | 1 thread                 | Stock        | Patched with   | diff     |
>>> | sending                  |              | fq_codel qdisc |          |
>>> +------------+-------------+--------------+----------------+----------+
>>> | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
>>> |            +-------------+--------------+----------------+----------+
>>> |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
>>> +------------+-------------+--------------+----------------+----------+
>>> | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
>>> |            +-------------+--------------+----------------+----------+
>>> | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
>>> +------------+-------------+--------------+----------------+----------+
>>>
>>> +--------------------------+--------------+----------------+----------+
>>> | 2 threads                | Stock        | Patched with   | diff     |
>>> | sending                  |              | fq_codel qdisc |          |
>>> +------------+-------------+--------------+----------------+----------+
>>> | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
>>> |            +-------------+--------------+----------------+----------+
>>> |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
>>> +------------+-------------+--------------+----------------+----------+
>>> | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
>>> |            +-------------+--------------+----------------+----------+
>>> | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
>>> +------------+-------------+--------------+----------------+----------+
>>>
>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>> ---
>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
>>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>> index fc358c4c355b..d9ffbf88cfd8 100644
>>> --- a/drivers/net/tun.c
>>> +++ b/drivers/net/tun.c
>>> @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  	struct netdev_queue *queue;
>>>  	struct tun_file *tfile;
>>>  	int len = skb->len;
>>> +	int ret;
>>>  
>>>  	rcu_read_lock();
>>>  	tfile = rcu_dereference(tun->tfiles[txq]);
>>> @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  
>>>  	nf_reset_ct(skb);
>>>  
>>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>>> +	queue = netdev_get_tx_queue(dev, txq);
>>> +
>>> +	spin_lock(&tfile->tx_ring.producer_lock);
>>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
>>> +	if (!qdisc_txq_has_no_queue(queue) &&
>>> +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
>>> +		netif_tx_stop_queue(queue);
>>> +		/* Paired with smp_mb() in __tun_wake_queue() */
>>> +		smp_mb__after_atomic();
>>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
>>> +			netif_tx_wake_queue(queue);
>>> +	}
>>> +	spin_unlock(&tfile->tx_ring.producer_lock);
>>> +
>>
>> There's a weird corner case here when tx_queue_len is 0
>> but a qdisc has been configured - it looks like that
>> currently it just drops all packets, with this change,
>> the qdisc will get stuck permanently.
>>
>> I suspect just checking tx_ring.size should fix it.
>> Or if you feel adventurous, change return code for __ptr_ring_produce
>> to distinguish between "no ring" and "no space".
> 
> 
> __ptr_ring_produce_peek really.
> 

Yes, I like the approach of returning this from
__ptr_ring_produce_peek(). Then I will do a switch on the return value
in tun_net_xmit().

Additionally, I should wake up in tun_queue_resize() after calling
ptr_ring_resize_multiple_bh(). For a new dev->tx_queue_len > 0, it
should be fine without waking, but for 0 it is not.

> 
>>
>>> +	if (ret) {
>>> +		/* This should be a rare case if a qdisc is present, but
>>> +		 * can happen due to lltx.
>>> +		 * Since skb_tx_timestamp(), skb_orphan(),
>>> +		 * run_ebpf_filter() and pskb_trim() could have tinkered
>>> +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
>>> +		 * we must drop instead.
>>> +		 */
>>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>>>  		goto drop;
>>>  	}
>>>  
>>>  	/* dev->lltx requires to do our own update of trans_start */
>>> -	queue = netdev_get_tx_queue(dev, txq);
>>>  	txq_trans_cond_update(queue);
>>>  
>>>  	/* Notify and wake up reader process */
>>> -- 
>>> 2.43.0
> 


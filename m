Return-Path: <netdev+bounces-217236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4022B37EE9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A338E0770
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22930345721;
	Wed, 27 Aug 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="eEu4XHGh"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5863451AD;
	Wed, 27 Aug 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287306; cv=none; b=BYRVRMafFZ3vAmQVFoo2BFemNKqV+dtBvT4Ekg9cZlGIGF/FPBdFqyzGm0nkr0Ca/PKJqlxsIy/dvWnkAcDbCfFKCSVYIlOJM3Z9VktXP0OXFU6NswGeWAA0V5aeCCokeFHBZGQppVxdi32khAXSeFiXah6K1q7h6WzC7cdgWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287306; c=relaxed/simple;
	bh=vzvd2Cvmcar+3CFoTi/zJ5CsUim01bxEhVNGUrPYXFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuEfqEB27VP8MEc1qzK+ztw7nsZ0aqyaAsd4yWS+nIEvQBxBR8LFDXHb7eID+HUmtrRopSZh8DKc87Gq9QMjNoCuO7KZAZoK0OhtPATyCl7FJKQNu3RAEgl508QBfenrGujI5l/kwrmqKW3A0Q0JRm42syDoKL1FTMXPEyDuNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=eEu4XHGh; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.178] ([129.217.186.178])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPSA id 57R9YpF9010783
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 11:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1756287291;
	bh=vzvd2Cvmcar+3CFoTi/zJ5CsUim01bxEhVNGUrPYXFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eEu4XHGh+0SwkrtsuiGrH/E/phgUzpNkSMHNmMxUfr62eSTOJnQ/xLvn3dNR0VXnn
	 PhJuaFK6OEtRRI/VGnnhkjEMYDFE7G3IlPxhVzR39EafQYBf7/olFOakE9tioxHiW9
	 I4CGThf3M8C6nOYlLmL2O/aVy73Tog+09micS1Dc=
Message-ID: <74b28e67-da36-4bb4-b1eb-58dd51762bab@tu-dortmund.de>
Date: Wed, 27 Aug 2025 11:34:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v3] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, jasowang@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tim Gebauer <tim.gebauer@tu-dortmund.de>
References: <20250825211832.84901-1-simon.schippers@tu-dortmund.de>
 <willemdebruijn.kernel.2310f82f3e55a@gmail.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <willemdebruijn.kernel.2310f82f3e55a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Target net-next
> 
> Also please have the subject line summarize the functional change
> (only). Something like "tun: replace tail drop with queue pause
> when full."
> 

Thank you very much for your detailed reply!
Yes, I will target net-next instead and change the title.

> Simon Schippers wrote:
>> This patch is a result of our paper [1] and deals with the tun_net_xmit
>> function which drops SKB's with the reason SKB_DROP_REASON_FULL_RING
>> whenever the tx_ring (TUN queue) is full. This behavior results in reduced
>> TCP performance and packet loss for VPNs and VMs. In addition this patch
>> also allows qdiscs to work properly (see [2]) and to reduce buffer bloat
>> when reducing the TUN queue.
>>
>> TUN benchmarks:
>> +-----------------------------------------------------------------+
>> | Lab setup of our paper [1]:                                     |
>> | TCP throughput of VPN solutions at varying RTT (values in Mbps) |
>> +-----------+---------------+---------------+----------+----------+
>> | RTT [ms]  | wireguard-go  | wireguard-go  | OpenVPN  | OpenVPN  |
>> |           |               | patched       |          | patched  |
>> +-----------+---------------+---------------+----------+----------+
>> | 10        | 787.3         | 679.0         | 402.4    | 416.9    |
>> +-----------+---------------+---------------+----------+----------+
>> | 20        | 765.1         | 718.8         | 401.6    | 393.18   |
>> +-----------+---------------+---------------+----------+----------+
>> | 40        | 441.5         | 529.4         | 96.9     | 411.8    |
>> +-----------+---------------+---------------+----------+----------+
>> | 80        | 218.7         | 265.7         | 57.9     | 262.7    |
>> +-----------+---------------+---------------+----------+----------+
>> | 120       | 145.4         | 181.7         | 52.8     | 178.0    |
>> +-----------+---------------+---------------+----------+----------+
>>
>> +--------------------------------------------------------------------+
>> | Real-world setup of our paper [1]:                                 |
>> | TCP throughput of VPN solutions without and with the patch         |
>> | at a RTT of ~120 ms (values in Mbps)                               |
>> +------------------+--------------+--------------+---------+---------+
>> | TUN queue        | wireguard-go | wireguard-go | OpenVPN | OpenVPN |
>> | length [packets] |              | patched      |         | patched |
>> +------------------+--------------+--------------+---------+---------+
>> | 5000             | 185.8        | 185.6        | 184.7   | 184.8   |
>> +------------------+--------------+--------------+---------+---------+
>> | 1000             | 185.1        | 184.9        | 177.1   | 183.0   |
>> +------------------+--------------+--------------+---------+---------+
>> | 500 (default)    | 137.5        | 184.9        | 117.4   | 184.6   |
>> +------------------+--------------+--------------+---------+---------+
>> | 100              | 99.8         | 185.3        | 66.4    | 183.5   |
>> +------------------+--------------+--------------+---------+---------+
>> | 50               | 59.4         | 185.7        | 21.6    | 184.7   |
>> +------------------+--------------+--------------+---------+---------+
>> | 10               | 1.7          | 185.4        | 1.6     | 183.6   |
>> +------------------+--------------+--------------+---------+---------+
>>
>> TAP benchmarks:
>> +------------------------------------------------------------------+
>> | Lab Setup [3]:                                                   |
>> | TCP throughput from host to Debian VM using TAP (values in Mbps) |
>> +----------------------------+------------------+------------------+
>> | TUN queue                  | Default          | Patched          |
>> | length [packets]           |                  |                  |
>> +----------------------------+------------------+------------------+
>> | 1000 (default)             | 2194.3           | 2185.0           |
>> +----------------------------+------------------+------------------+
>> | 100                        | 1986.4           | 2268.5           |
>> +----------------------------+------------------+------------------+
>> | 10                         | 625.0            | 1988.9           |
>> +----------------------------+------------------+------------------+
>> | 1                          | 2.2              | 1112.7           |
>> +----------------------------+------------------+------------------+
>> |                                                                  |
>> +------------------------------------------------------------------+
>> | Measurement with 1000 packets queue and emulated delay           |
>> +----------------------------+------------------+------------------+
>> | RTT [ms]                   | Default          | Patched          |
>> +----------------------------+------------------+------------------+
>> | 60                         | 171.8            | 341.2            |
>> +----------------------------+------------------+------------------+
>> | 120                        | 98.3             | 255.0            |
>> +----------------------------+------------------+------------------+
>>
>> TAP+vhost_net benchmarks:
>> +----------------------------------------------------------------------+
>> | Lab Setup [3]:                                                       |
>> | TCP throughput from host to Debian VM using TAP+vhost_net            |
>> | (values in Mbps)                                                     |
>> +-----------------------------+--------------------+-------------------+
>> | TUN queue                   | Default            | Patched           |
>> | length [packets]            |                    |                   |
>> +-----------------------------+--------------------+-------------------+
>> | 1000 (default)              | 23403.9            | 23858.8           |
>> +-----------------------------+--------------------+-------------------+
>> | 100                         | 23372.5            | 23889.9           |
>> +-----------------------------+--------------------+-------------------+
>> | 10                          | 25837.5            | 23730.2           |
>> +-----------------------------+--------------------+-------------------+
>> | 1                           | 0.7                | 19244.8           |
>> +-----------------------------+--------------------+-------------------+
>> | Note: Default suffers from many retransmits, while patched does not. |
>> +----------------------------------------------------------------------+
>> |                                                                      |
>> +----------------------------------------------------------------------+
>> | Measurement with 1000 packets queue and emulated delay               |
>> +-----------------------------+--------------------+-------------------+
>> | RTT [ms]                    | Default            | Patched           |
>> +-----------------------------+--------------------+-------------------+
>> | 60                          | 397.1              | 397.8             |
>> +-----------------------------+--------------------+-------------------+
>> | 120                         | 200.7              | 199.9             |
>> +-----------------------------+--------------------+-------------------+
>>
>> Implementation details:
>> - The netdev queue start/stop flow control is utilized.
>> - Compatible with multi-queue by only stopping/waking the specific
>> netdevice subqueue.
>>
>> In the tun_net_xmit function:
>> - Stopping the subqueue is done when the tx_ring gets full after inserting
>> the SKB into the tx_ring.
>> - In the unlikely case when the insertion with ptr_ring_produce fails, the
>> old dropping behavior is used for this SKB.
>>
>> In the tun_ring_recv function:
>> - Waking the subqueue is done after consuming a SKB from the tx_ring when
>> the tx_ring is empty.
>> - When the tx_ring is configured to be small (for example to hold 1 SKB),
> 
> That's an exaggerated case that hopefully we do not have to support.
> Can this be configured? Maybe we should round_up user input to a sane
> lower bound instead.
> 

I do not think that this issue will disappear with a bigger tx_ring, it 
will just get more unlikely.
Just waking the netdev queue in the blocking wait queue is fine in my 
opinion.
And small tx_ring sizes like 1 might be used by a possible dynamic queue 
limits since my benchmarks showed that the performance can be okay with 
such small tx_ring sizes.

>> queuing might be stopped in the tun_net_xmit function while at the same
>> time, ptr_ring_consume is not able to grab a SKB. This prevents
>> tun_net_xmit from being called again and causes tun_ring_recv to wait
>> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
>> queue is woken in the wait queue.
>>
>> In the tap_do_read function:
>> - Same behavior as in tun_ring_recv: Waking the subqueue when the tx_ring
>> is empty & waking the subqueue in the blocking wait queue.
>> - Here the netdev txq is obtained with a rcu read lock instead.
>>
>> In the vhost_net_buf_produce function:
>> - Same behavior as in tun_ring_recv: Waking the subqueue when the tx_ring
>> is empty.
>> - Here the netdev_queue is saved in the vhost_net_virtqueue at init with
>> new helpers.
>>
>> We are open to suggestions regarding the implementation :)
>> Thank you for your work!
> 
> Similarly, in the commit message, lead with the technical explanation.
> Brief benchmark results are great, but this is not an academic paper.
> Best concise and below the main take-away. Or in the cover letter if a
> multi patch series. ..
> 

Okay, I will shorten the benchmarks to a minimum and lead with the 
technical explanation.

>>
>> [1] Link:
>> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [2] Link:
>> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
>> [3] Link: https://github.com/tudo-cni/nodrop
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>> V2 -> V3: Added support for TAP and TAP+vhost_net.
> 
> .. please split into a series, with separate patches for TUN, TAP and
> vhost-net.
> 
> Or, start with one and once that is merged after revisions, repeat
> for the others. That is likely less work.
> 

I will split it into a series with separate changes.
Merging one after another will not work since TUN, TAP and vhost-net share 
tun_net_xmit as a common method.
Stopping the netdev queue there without waking it again will break stuff.

>> V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
>> unnecessary netif_tx_wake_queue in tun_ring_recv.
>>
>>  drivers/net/tap.c      | 35 +++++++++++++++++++++++++++++++++++
>>  drivers/net/tun.c      | 39 +++++++++++++++++++++++++++++++++++----
>>  drivers/vhost/net.c    | 24 ++++++++++++++++++++++--
>>  include/linux/if_tap.h |  5 +++++
>>  include/linux/if_tun.h |  6 ++++++
>>  5 files changed, 103 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 1197f245e873..df7e4063fb7c 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -758,6 +758,8 @@ static ssize_t tap_do_read(struct tap_queue *q,
>>  			   int noblock, struct sk_buff *skb)
>>  {
>>  	DEFINE_WAIT(wait);
>> +	struct netdev_queue *txq;
>> +	struct net_device *dev;
>>  	ssize_t ret = 0;
>>  
>>  	if (!iov_iter_count(to)) {
>> @@ -785,12 +787,26 @@ static ssize_t tap_do_read(struct tap_queue *q,
>>  			ret = -ERESTARTSYS;
>>  			break;
>>  		}
>> +		rcu_read_lock();
>> +		dev = rcu_dereference(q->tap)->dev;
>> +		txq = netdev_get_tx_queue(dev, q->queue_index);
>> +		netif_tx_wake_queue(txq);
>> +		rcu_read_unlock();
>> +
> 
> This wakes the queue only once entirely empty? That seems aggressive.
> 

This waking of the netdev queue is only for the "exaggerated" case, see 
described above for TUN.
However you are right that only waking the netdev queue when the tx_ring 
is empty (which is done with the condition below) is aggressive.
In previous testing waking the queue when the tx_ring is not full anymore 
(instead of completely empty) showed crashes. But I will reevaluate this 
logic.

> Where is the matching netif_tx_stop_queue. I had expected that
> arund the ptr_ring_produce calls in tap_handle_frame.
> 

TAP uses tun_net_xmit as .ndo_start_xmit. However, tap_handle_frame is 
used by ipvtap and macvtap. It could also be considered in the patch 
series, I guess?

>>  		/* Nothing to read, let's sleep */
>>  		schedule();
>>  	}
>>  	if (!noblock)
>>  		finish_wait(sk_sleep(&q->sk), &wait);
>>  
>> +	if (ptr_ring_empty(&q->ring)) {
>> +		rcu_read_lock();
>> +		dev = rcu_dereference(q->tap)->dev;
>> +		txq = netdev_get_tx_queue(dev, q->queue_index);
>> +		netif_tx_wake_queue(txq);
>> +		rcu_read_unlock();
>> +	}
>> +
> 
> Why the second test for the same condition: ring empty?
> 

See previous comment.

>>  put:
>>  	if (skb) {
>>  		ret = tap_put_user(q, skb, to);
>> @@ -1176,6 +1192,25 @@ struct socket *tap_get_socket(struct file *file)
>>  }
>>  EXPORT_SYMBOL_GPL(tap_get_socket);
>>  
>> +struct netdev_queue *tap_get_netdev_queue(struct file *file)
>> +{
>> +	struct netdev_queue *txq;
>> +	struct net_device *dev;
>> +	struct tap_queue *q;
>> +
>> +	if (file->f_op != &tap_fops)
>> +		return ERR_PTR(-EINVAL);
>> +	q = file->private_data;
>> +	if (!q)
>> +		return ERR_PTR(-EBADFD);
>> +	rcu_read_lock();
>> +	dev = rcu_dereference(q->tap)->dev;
>> +	txq = netdev_get_tx_queue(dev, q->queue_index);
>> +	rcu_read_unlock();
> 
> If the dev is only safe to be accessed inside an RCU readside critical
> section, is it safe to use txq outside of it?
> 

You are right, this might be a bad idea as the queues might be messed with.
However, I am not sure how to access the txq in another way?

>> +	return txq;
>> +}
>> +EXPORT_SYMBOL_GPL(tap_get_netdev_queue);
>> +
>>  struct ptr_ring *tap_get_ptr_ring(struct file *file)
>>  {
>>  	struct tap_queue *q;
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index cc6c50180663..30ddcd20fcd3 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1060,13 +1060,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>  
>>  	nf_reset_ct(skb);
>>  
>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>> +	queue = netdev_get_tx_queue(dev, txq);
>> +	if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
>> +		netif_tx_stop_queue(queue);
>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> 
> again, stop the queue before dropping is needed. Which is what the
> new ptr_ring_full code below does I guess. If so, when is this reached?
> 

Yes, you are right this is what the ptr_ring_full code below does. It is 
reached when a SKB is successfully inserted into the tx_ring and with that 
the tx_ring becomes full. Then the queue is stopped which avoids packet 
drops.

>>  		goto drop;
>>  	}
>> +	if (ptr_ring_full(&tfile->tx_ring))
>> +		netif_tx_stop_queue(queue);
>>  
>>  	/* dev->lltx requires to do our own update of trans_start */
>> -	queue = netdev_get_tx_queue(dev, txq);
>>  	txq_trans_cond_update(queue);
>>  
>>  	/* Notify and wake up reader process */
>> @@ -2110,9 +2113,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>  	return total;
>>  }
>>  
>> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile, int noblock, int *err)
>>  {
>>  	DECLARE_WAITQUEUE(wait, current);
>> +	struct netdev_queue *txq;
>>  	void *ptr = NULL;
>>  	int error = 0;
>>  
>> @@ -2124,6 +2128,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>>  		goto out;
>>  	}
>>  
>> +	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
>>  	add_wait_queue(&tfile->socket.wq.wait, &wait);
>>  
>>  	while (1) {
>> @@ -2131,6 +2136,9 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>>  		ptr = ptr_ring_consume(&tfile->tx_ring);
>>  		if (ptr)
>>  			break;
>> +
>> +		netif_tx_wake_queue(txq);
>> +
>>  		if (signal_pending(current)) {
>>  			error = -ERESTARTSYS;
>>  			break;
>> @@ -2147,6 +2155,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>>  	remove_wait_queue(&tfile->socket.wq.wait, &wait);
>>  
>>  out:
>> +	if (ptr_ring_empty(&tfile->tx_ring)) {
>> +		txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
>> +		netif_tx_wake_queue(txq);
>> +	}
>>  	*err = error;
>>  	return ptr;
>>  }
>> @@ -2165,7 +2177,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>>  
>>  	if (!ptr) {
>>  		/* Read frames from ring */
>> -		ptr = tun_ring_recv(tfile, noblock, &err);
>> +		ptr = tun_ring_recv(tun, tfile, noblock, &err);
>>  		if (!ptr)
>>  			return err;
>>  	}
>> @@ -3712,6 +3724,25 @@ struct socket *tun_get_socket(struct file *file)
>>  }
>>  EXPORT_SYMBOL_GPL(tun_get_socket);
>>  
>> +struct netdev_queue *tun_get_netdev_queue(struct file *file)
>> +{
>> +	struct netdev_queue *txq;
>> +	struct net_device *dev;
>> +	struct tun_file *tfile;
>> +
>> +	if (file->f_op != &tun_fops)
>> +		return ERR_PTR(-EINVAL);
>> +	tfile = file->private_data;
>> +	if (!tfile)
>> +		return ERR_PTR(-EBADFD);
>> +	rcu_read_lock();
>> +	dev = rcu_dereference(tfile->tun)->dev;
>> +	txq = netdev_get_tx_queue(dev, tfile->queue_index);
>> +	rcu_read_unlock();
>> +	return txq;
>> +}
>> +EXPORT_SYMBOL_GPL(tun_get_netdev_queue);
>> +
>>  struct ptr_ring *tun_get_tx_ring(struct file *file)
>>  {
>>  	struct tun_file *tfile;
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 6edac0c1ba9b..045fc31c59ff 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -130,6 +130,7 @@ struct vhost_net_virtqueue {
>>  	struct vhost_net_buf rxq;
>>  	/* Batched XDP buffs */
>>  	struct xdp_buff *xdp;
>> +	struct netdev_queue *netdev_queue;
>>  };
>>  
>>  struct vhost_net {
>> @@ -182,6 +183,8 @@ static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
>>  	rxq->head = 0;
>>  	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>>  					      VHOST_NET_BATCH);
>> +	if (ptr_ring_empty(nvq->rx_ring))
>> +		netif_tx_wake_queue(nvq->netdev_queue);
>>  	return rxq->tail;
>>  }
>>  
>> @@ -1469,6 +1472,21 @@ static struct socket *get_raw_socket(int fd)
>>  	return ERR_PTR(r);
>>  }
>>  
>> +static struct netdev_queue *get_tap_netdev_queue(struct file *file)
>> +{
>> +	struct netdev_queue *q;
>> +
>> +	q = tun_get_netdev_queue(file);
>> +	if (!IS_ERR(q))
>> +		goto out;
>> +	q = tap_get_netdev_queue(file);
>> +	if (!IS_ERR(q))
>> +		goto out;
>> +	q = NULL;
>> +out:
>> +	return q;
>> +}
>> +
>>  static struct ptr_ring *get_tap_ptr_ring(struct file *file)
>>  {
>>  	struct ptr_ring *ring;
>> @@ -1570,10 +1588,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>>  		if (r)
>>  			goto err_used;
>>  		if (index == VHOST_NET_VQ_RX) {
>> -			if (sock)
>> +			if (sock) {
>>  				nvq->rx_ring = get_tap_ptr_ring(sock->file);
>> -			else
>> +				nvq->netdev_queue = get_tap_netdev_queue(sock->file);
>> +			} else {
>>  				nvq->rx_ring = NULL;
>> +			}
>>  		}
>>  
>>  		oldubufs = nvq->ubufs;
>> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
>> index 553552fa635c..b15c40c86819 100644
>> --- a/include/linux/if_tap.h
>> +++ b/include/linux/if_tap.h
>> @@ -10,6 +10,7 @@ struct socket;
>>  
>>  #if IS_ENABLED(CONFIG_TAP)
>>  struct socket *tap_get_socket(struct file *);
>> +struct netdev_queue *tap_get_netdev_queue(struct file *file);
>>  struct ptr_ring *tap_get_ptr_ring(struct file *file);
>>  #else
>>  #include <linux/err.h>
>> @@ -18,6 +19,10 @@ static inline struct socket *tap_get_socket(struct file *f)
>>  {
>>  	return ERR_PTR(-EINVAL);
>>  }
>> +static inline struct netdev_queue *tap_get_netdev_queue(struct file *f)
>> +{
>> +	return ERR_PTR(-EINVAL);
>> +}
>>  static inline struct ptr_ring *tap_get_ptr_ring(struct file *f)
>>  {
>>  	return ERR_PTR(-EINVAL);
>> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
>> index 80166eb62f41..552eb35f0299 100644
>> --- a/include/linux/if_tun.h
>> +++ b/include/linux/if_tun.h
>> @@ -21,6 +21,7 @@ struct tun_msg_ctl {
>>  
>>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>>  struct socket *tun_get_socket(struct file *);
>> +struct netdev_queue *tun_get_netdev_queue(struct file *file);
>>  struct ptr_ring *tun_get_tx_ring(struct file *file);
>>  
>>  static inline bool tun_is_xdp_frame(void *ptr)
>> @@ -50,6 +51,11 @@ static inline struct socket *tun_get_socket(struct file *f)
>>  	return ERR_PTR(-EINVAL);
>>  }
>>  
>> +static inline struct netdev_queue *tun_get_netdev_queue(struct file *f)
>> +{
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>>  static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
>>  {
>>  	return ERR_PTR(-EINVAL);
>> -- 
>> 2.43.0
>>
> 
> 


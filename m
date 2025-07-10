Return-Path: <netdev+bounces-205625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB5AFF6DF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91173AE12B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133927F00E;
	Thu, 10 Jul 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SW3yvwov"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E922301;
	Thu, 10 Jul 2025 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115036; cv=none; b=bq/hO8dyfpGiD1P8ZjHFwZ08DHr3X4/07rIE2YUv79mD29f7qeY3oBl+hTYH0L+9DnUqrbbEgeJaq2ZVDXcx8WLHWigY5ITmxq/mauJRVgN/lDk7h1lD2qzN59NeypN8AXnYnn96hE3jxao4R/xDANQnfsrg0NEoLufcrX/Uu4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115036; c=relaxed/simple;
	bh=8I4jJwxbyc5Wf4Bfe3JIRJ3cIJzDrrDbBswSK47keko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RADlDk8l90S52pafzA0WjpIulnOKRdG7bG5Jd/U75+P1HDxVsgN+XpXQs24H9qSYDkINpxr9eE8IiFvkenMWytDmfr7YLpJoBBT7VhYHmlFKCGYwcL0YutWTnTJ+2nUErCisZvds4piAGFlZJnYPb/KazJ3qyuXq37jsdJ8kvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SW3yvwov; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=QJeyLayR2wnqu06I+wNLQYd2tZdSLLwivP8EyeVyOE0=;
	b=SW3yvwovHR910rrGQ0sdq1jxB3GIwadvFL+u6RsgA+8EDnBO3subzjAszZs1We
	aJmSVO1tUy0iDgBq2qa0+2SQbzJ37y1xkOVU91rNnj85Nlee0xNK4QpVr22DrSt7
	aDeSfQUdlVtyShY3p8pZOKUBwX1Sw24z4oRwHT2Eihq00=
Received: from [172.21.20.151] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3saA+J29onVfODg--.18673S2;
	Thu, 10 Jul 2025 10:36:47 +0800 (CST)
Message-ID: <f9c1e53b-7956-44d2-8d8c-20dfd1671242@163.com>
Date: Thu, 10 Jul 2025 10:36:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-3-luyun_611@163.com>
 <686edbb8943d2_a6f49294e2@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <686edbb8943d2_a6f49294e2@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3saA+J29onVfODg--.18673S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr47Zw13KrW8Jw4DCFWfKrg_yoW7Ary8pa
	yYg390k3WDJr10yw1fGFs5tr1avw4rJFs5GrZYq34SyrnxtwnYvryI9rWj9FyDuFykta42
	vF4qvr15Cw1qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USiiDUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxCGzmhvJzICQwAAsI


在 2025/7/10 05:14, Willem de Bruijn 写道:
> Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
>> pending_refcnt to decrement to zero before returning. The pending_refcnt
>> is decremented by 1 when the skb->destructor function is called,
>> indicating that the skb has been successfully sent and needs to be
>> destroyed.
>>
>> If an error occurs during this process, the tpacket_snd() function will
>> exit and return error, but pending_refcnt may not yet have decremented to
>> zero. Assuming the next send operation is executed immediately, but there
>> are no available frames to be sent in tx_ring (i.e., packet_current_frame
>> returns NULL), and skb is also NULL
> This is a very specific edge case. And arguably the goal is to wait
> for any pending skbs still, even if from a previous call.
>
> skb is true for all but the first iterations of that loop. So your
> earlier patch
>
> -                       if (need_wait && skb) {
> +                       if (need_wait && packet_read_pending(&po->tx_ring)) {
>
> Is more concise and more obviously correct.
>
>> , the function will not execute
>> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
>> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
>> if the previous skb has completed transmission, the skb->destructor
>> function can only be invoked in the ksoftirqd thread (assuming NAPI
>> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
>> operation happen to run on the same CPU, and the CPU trapped in the
>> do-while loop without yielding, the ksoftirqd thread will not get
>> scheduled to run.
> Interestingly, this is quite similar to the issue that caused adding
> the completion in the first place. Commit 89ed5b519004 ("af_packet:
> Block execution of tasks waiting for transmit to complete in
> AF_PACKET") added the completion because a SCHED_FIFO task could delay
> ksoftirqd indefinitely.
>
>> As a result, pending_refcnt will never be reduced to
>> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
>> lockup issue.
>>
>> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
>> wait_for_completion_interruptible_timeout() should be executed to yield
>> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, move
>> the penging_refcnt check to the start of the do-while loop, and reuse ph
>> to continue for the next iteration.
>>
>> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
>> Cc: stable@kernel.org
>> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> ---
>> Changes in v3:
>> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
>> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/
> If the fix alone is more obvious without this optimization, and
> the extra packet_read_pending() is already present, not newly
> introduced with the fix, then I would prefer to split the fix (to net,
> and stable) from the optimization (to net-next).

Alright, referring to your suggestion, I will split this patch into two 
for the next version: one to fix the issue (as the first version, to 
net, and stable), and the other to optimize the code (to net-next).

Thanks for your review and suggestion.


>   
>> Changes in v2:
>> - Add a Fixes tag.
>> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
>> ---
>>   net/packet/af_packet.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 7089b8c2a655..89a5d2a3a720 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -2846,11 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>>   		ph = packet_current_frame(po, &po->tx_ring,
>>   					  TP_STATUS_SEND_REQUEST);
>>   		if (unlikely(ph == NULL)) {
>> -			if (need_wait && skb) {
>> +			/* Note: packet_read_pending() might be slow if we
>> +			 * have to call it as it's per_cpu variable, but in
>> +			 * fast-path we don't have to call it, only when ph
>> +			 * is NULL, we need to check pending_refcnt.
>> +			 */
>> +			if (need_wait && packet_read_pending(&po->tx_ring)) {
>>   				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>>   				if (timeo <= 0) {
>>   					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
>>   					goto out_put;
>> +				} else {
>> +					/* Just reuse ph to continue for the next iteration, and
>> +					 * ph will be reassigned at the start of the next iteration.
>> +					 */
>> +					ph = (void *)1;
>>   				}
>>   			}
>>   			/* check for additional frames */
>> @@ -2943,14 +2953,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>>   		}
>>   		packet_increment_head(&po->tx_ring);
>>   		len_sum += tp_len;
>> -	} while (likely((ph != NULL) ||
>> -		/* Note: packet_read_pending() might be slow if we have
>> -		 * to call it as it's per_cpu variable, but in fast-path
>> -		 * we already short-circuit the loop with the first
>> -		 * condition, and luckily don't have to go that path
>> -		 * anyway.
>> -		 */
>> -		 (need_wait && packet_read_pending(&po->tx_ring))));
>> +	} while (likely(ph != NULL))
>>   
>>   	err = len_sum;
>>   	goto out_put;
>> -- 
>> 2.43.0
>>



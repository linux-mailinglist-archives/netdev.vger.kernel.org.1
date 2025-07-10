Return-Path: <netdev+bounces-205615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060AAFF6B0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC831C46A3C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC227F010;
	Thu, 10 Jul 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X/+WT/NH"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93225B2FF;
	Thu, 10 Jul 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113969; cv=none; b=Aj7iJy/8R0gGhh3kGUZEqIwQpXUGV7sIt3S631TJiMuTA7JzEUSc9OEaNHvc768yByLLASkfaZbb7LiQlys7wazbS3cMzHcrVIyshfS2DLpBJk0b58rGBIP31TWQNtCvj6xeokvC/OBqBhO7dgMmF21h/OOHB0VFTcdDdIMvg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113969; c=relaxed/simple;
	bh=cSB99w/SqbEWmgPve49iwEXJpLeXlf+cCL1iCKJ5I+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzeJtkaeF0fvqFHSmdRR8uoJR8Zkh6uWk8Q509MTt8oHAhGL5r1rNmmy37GjNA9h2wl6nlobY/t66bhpuVZfO4DzM+KR3qZG1ORzVaUwgHrFr5qEL4qr6Ndzu4llleDlhjBmvqw+1fwYVJP8DjKJHgdLsVPhGJTkGiX6R6GCOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X/+WT/NH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rpPt3FqJrAS10GhpLq1LV7l5wgQr6FkDpZL8JmquHTo=;
	b=X/+WT/NHIC6qSwwdQ0bwV8a5l90B2jBgHfLOh19Vi8O82zE/DhLPzRfeW+fqSp
	YWZK6wgj/IIuESHXCqgerEfl8zKpwBBhRHu4iMHjrn7pyO3P9SGOWUEQwfOOjLcc
	QxX9i8XJaj/zbSO5vrIX4PjfburQhAySA1/Qc2bT0X6w8=
Received: from [172.21.20.151] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnfxMMI29oYdjKDg--.17049S2;
	Thu, 10 Jul 2025 10:18:54 +0800 (CST)
Message-ID: <6fc11584-a9ff-49cc-851d-6d0835e4ba65@163.com>
Date: Thu, 10 Jul 2025 10:18:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
To: Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709095653.62469-1-luyun_611@163.com>
 <20250709095653.62469-3-luyun_611@163.com>
 <CANn89iJZ=t6Fg4fjgPooyTAbD4Lxj9AKFQx_mnJty5nq9Ng9vw@mail.gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <CANn89iJZ=t6Fg4fjgPooyTAbD4Lxj9AKFQx_mnJty5nq9Ng9vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnfxMMI29oYdjKDg--.17049S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrykArykGF4UXrWxWrWxZwb_yoWrGrWDpa
	y5K3yaya1DJr1xtw1fKan5tF12vw4rJF4kGrZ8t34SvwnIy3sYvrWI9rWj9FyDZFWkta4a
	vF4qvryj934DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfOz-UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQxSGzmhvIaM84gAAsE


在 2025/7/9 20:44, Eric Dumazet 写道:
> On Wed, Jul 9, 2025 at 2:57 AM Yun Lu <luyun_611@163.com> wrote:
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
>> returns NULL), and skb is also NULL, the function will not execute
>> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
>> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
>> if the previous skb has completed transmission, the skb->destructor
>> function can only be invoked in the ksoftirqd thread (assuming NAPI
>> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
>> operation happen to run on the same CPU, and the CPU trapped in the
>> do-while loop without yielding, the ksoftirqd thread will not get
>> scheduled to run. As a result, pending_refcnt will never be reduced to
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
>>
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
>>                  ph = packet_current_frame(po, &po->tx_ring,
>>                                            TP_STATUS_SEND_REQUEST);
>>                  if (unlikely(ph == NULL)) {
>> -                       if (need_wait && skb) {
>> +                       /* Note: packet_read_pending() might be slow if we
>> +                        * have to call it as it's per_cpu variable, but in
>> +                        * fast-path we don't have to call it, only when ph
>> +                        * is NULL, we need to check pending_refcnt.
>> +                        */
>> +                       if (need_wait && packet_read_pending(&po->tx_ring)) {
>>                                  timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>>                                  if (timeo <= 0) {
>>                                          err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
>>                                          goto out_put;
>> +                               } else {
> nit (in case a new version is sent) : No need for an else {} after a
> "goto XXXXX;"
>
> if (....) {
>       .....
>       goto out_put;
> }
> /* Just reuse ph to continue for the next iteration, and...
>   * .....
>   */
> ph = (void *)1;

Yes, the code of "else {} " is redundant. I will remove it in the next 
version.

Thanks.

>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>



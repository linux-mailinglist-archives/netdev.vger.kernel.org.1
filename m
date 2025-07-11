Return-Path: <netdev+bounces-206086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B7B0146D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9654A35D0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C51F4CAA;
	Fri, 11 Jul 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mL5R8Od2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A31EFF9B;
	Fri, 11 Jul 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218458; cv=none; b=KHl8N1zhVC0s0+Ls0/xbSV/gC7m7xC2qmLMYxEne+RYcoAM4bh+ox+/UnK7m1jqXi5HSOm+AIIvkZgCRXqhmrbPNlTPan4IN1mH9ZI9Fa+81i+x+e7n5yTAfj4M4G86P29/VAEPsrenhV8UkwF8J4tx6cQ3mUMQ6Xp+jpvUmbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218458; c=relaxed/simple;
	bh=Sr42ywoQy8AyYBFRt7eUXbqxZakD2B6wyAnQRkhNU7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuoiEWeW76MEN0Gx0nJXMbltfnrt5qvHkn2bM0rFZ/sJN79nIs82sfLc/fyVZes9LVn0ZZvc2wxn7FTwO3P9dZ69OIcwvfFdW287y8IhFOAXxwnZ5f71hz6rMN0Ba/tJv3NWyEMG65Ka6eYvwPHBtNGxfenzgI0DrSfDIGJsPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mL5R8Od2; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=xhsgskadebniNmrBk5hnagfJTp/8LcUkYv/Wop6E+Qc=;
	b=mL5R8Od2fjhgwYt0/d92XP7chHPdOGXDY/mM/47u0mrud81MpH03wWeoYxlpGV
	vstbIDPxzzJgnuoKiB0YxfYGNyKH3SdkOZog5GdiogMWepjjJ0p/RWu+kA3evqDl
	wrO0o1184FrCcJkZEhDrrqYjFbyh3PVo2fnvyD1qxRjpk=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3Hw00u3Bo3oMJAA--.1286S2;
	Fri, 11 Jul 2025 15:20:21 +0800 (CST)
Message-ID: <515fc9c6-a4a2-4fdf-8d91-396e42c95767@163.com>
Date: Fri, 11 Jul 2025 15:20:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] af_packet: fix soft lockup issue caused by
 tpacket_snd()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710102639.280932-1-luyun_611@163.com>
 <20250710102639.280932-3-luyun_611@163.com>
 <686fc5051bdb8_fd38829485@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <686fc5051bdb8_fd38829485@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3Hw00u3Bo3oMJAA--.1286S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr47Zw13KrW8Jw18Kw1kGrg_yoWxGr4Dpa
	yUKrWqka1DXr1Iyw4xJF4kJF12vws5JFs3GrZ5X34SywnxtasavFWIkrWY9Fy8uFWkt3W2
	vF4qqr4UC34qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVxRgUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOh6HzmhwtTbNTQAAs2


在 2025/7/10 21:49, Willem de Bruijn 写道:
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
>> In fact, skb is true for all but the first iterations of that loop, and
>> as long as pending_refcnt is not zero, even if incremented by a previous
>> call, wait_for_completion_interruptible_timeout() should be executed to
>> yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
>> the execution condition of this function should be modified to check if
>> pending_refcnt is not zero, instead of check skb.
>>
>> As a result, packet_read_pending() may be called twice in the loop. This
>> will be optimized in the following patch.
>>
>> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
>> Cc: stable@kernel.org
>> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> ---
>> Changes in v4:
>> - Split to the fix alone. Thanks: Willem de Bruijn.
>> - Link to v3: https://lore.kernel.org/all/20250709095653.62469-3-luyun_611@163.com/
>>
>> Changes in v3:
>> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
>> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/
>>
>> Changes in v2:
>> - Add a Fixes tag.
>> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
>> ---
>> ---
>>   net/packet/af_packet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 7089b8c2a655..581a96ec8e1a 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -2846,7 +2846,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>>   		ph = packet_current_frame(po, &po->tx_ring,
>>   					  TP_STATUS_SEND_REQUEST);
>>   		if (unlikely(ph == NULL)) {
>> -			if (need_wait && skb) {
>> +			if (need_wait && packet_read_pending(&po->tx_ring)) {
> Unfortunately I did not immediately fully appreciate Eric's
> suggestion.
>
> My comments was
>
>      If [..] the extra packet_read_pending() is already present, not
>      newly introduced with the fix
>
> But of course that expensive call is newly introduced, so my
> suggestion was invalid.
>
> It's btw also not possible to mix net and net-next patches in a single
> series like this (see Documentation/process/maintainer-netdev.rst).

Sorry, I misunderstood your comments. In the next version, I will 
combine the second and third patches together.

>
> But, instead of going back entirely to v2, perhaps we can make the
> logic a bit more obvious by just having a while (1) at the end to show
> that the only way to exit the loop (except errors) is in the ph == NULL
> branch. And break in that loop directly.
>
> There are two other ways to reach that while statement. A continue
> on PACKET_SOCK_TP_LOSS, or by regular control flow. In both cases, ph
> is non-zero, so the condition is true anyway.

Following your suggestion, I tried modifying the code (as shown below),  
now the loop condition is still the same as origin, but the logic is now 
clearer and more obvious.

Thanks.

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7089b8c2a655..be608f07441f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2846,15 +2846,21 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
                 ph = packet_current_frame(po, &po->tx_ring,
                                           TP_STATUS_SEND_REQUEST);
                 if (unlikely(ph == NULL)) {
-                       if (need_wait && skb) {
+                       /* Note: packet_read_pending() might be slow if we
+                        * have to call it as it's per_cpu variable, but in
+                        * fast-path we don't have to call it, only when ph
+                        * is NULL, we need to check the pending_refcnt.
+                        */
+                       if (need_wait && 
packet_read_pending(&po->tx_ring)) {
                                 timeo = 
wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
                                 if (timeo <= 0) {
                                         err = !timeo ? -ETIMEDOUT : 
-ERESTARTSYS;
                                         goto out_put;
                                 }
-                       }
-                       /* check for additional frames */
-                       continue;
+                               /* check for additional frames */
+                               continue;
+                       } else
+                               break;
                 }

                 skb = NULL;
@@ -2943,14 +2949,7 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
                 }
                 packet_increment_head(&po->tx_ring);
                 len_sum += tp_len;
-       } while (likely((ph != NULL) ||
-               /* Note: packet_read_pending() might be slow if we have
-                * to call it as it's per_cpu variable, but in fast-path
-                * we already short-circuit the loop with the first
-                * condition, and luckily don't have to go that path
-                * anyway.
-                */
-                (need_wait && packet_read_pending(&po->tx_ring))));
+       } while (1);

         err = len_sum;
         goto out_put;



>
>>   				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>>   				if (timeo <= 0) {
>>   					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
>> -- 
>> 2.43.0
>>



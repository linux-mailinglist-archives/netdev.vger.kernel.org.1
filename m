Return-Path: <netdev+bounces-204980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD750AFCBC7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C087ADDAB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8EF220F5E;
	Tue,  8 Jul 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DV9KacRb"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA391EDA1E;
	Tue,  8 Jul 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980973; cv=none; b=PCOGoWaLkZ6fU5e5t1uJoBdI/IIn1DoZQ8uZPwBQs8pmG703d59upjLB8UJG4SWdFsjfXuSWbocZqb9RdFC2RF+x5iJDch+b2sj4hPbs5Uwj3lp3eYzFoB0Gwl9Imp0b6Wx+/4B0HkLhJSK3azEKZIH4qx/GpLAfSJ/xODDTjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980973; c=relaxed/simple;
	bh=vFutY4pAw9BjYeZxUdJBE07y21u5Qaeiv3vVnGMbVo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecgLqi8sVR2er6ERIhelgHn/3EuaK2CFp2nz18i0o6azQQK8L9ah2zUG6wk6bGTXhEyhrLw01UWttWMQckQXmjmH90iTsl1bpYfRRDRAZBXmc+9tyUMXgBM0PtW0wkAWSH5uJUcdMFnZkAy/bc8Px67V5c0v80ZSLCjdqg4El3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DV9KacRb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6OPhpqbDMbvXUp0/xBb9y556YAAYWuK38YSEVRKjDiE=;
	b=DV9KacRbK3K9JYOCWozi+uROJgdVoyIgYEvtTXNsFGpfTStH77JSrsIuhlt/I6
	DYioKy54XGIo76Au85clcO9ibpxukX0QuzMc08KulbyQAO8k0Hq08dgfYvxnfLmP
	SZKLd/sWzhXEdARUGQJR+Kuz2usXFYyYbC1s2z9mpM/uo=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX9W98G21o_gsSAA--.2762S2;
	Tue, 08 Jul 2025 21:22:06 +0800 (CST)
Message-ID: <7900a060-53b6-47b8-9ac5-59446b9cb700@163.com>
Date: Tue, 8 Jul 2025 21:22:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
To: Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708020642.27838-1-luyun_611@163.com>
 <CANn89i+6g+VwByu-xeJ-PVuaw8X_yQdC2buB7q=YO5S3MzMTUw@mail.gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <CANn89i+6g+VwByu-xeJ-PVuaw8X_yQdC2buB7q=YO5S3MzMTUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX9W98G21o_gsSAA--.2762S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4rAFWUGry8KFy3uw1kGrg_yoWxCF47pa
	y5Kry7Xa1DJry2gr4xJa1kXr1UXw4rJFZ7CrZ5Xa4Sywnrtr9aqr4xKrWj9FyUZFWkA3W7
	XF4vvr4UCw1Dta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf739UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOhKEzmhtGuEOmwAAsJ


在 2025/7/8 15:12, Eric Dumazet 写道:
> On Mon, Jul 7, 2025 at 7:06 PM Yun Lu <luyun_611@163.com> wrote:
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
>> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
>> execution condition of this function should be modified to check if
>> pending_refcnt is not zero.
>>
>> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
>> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>>
>> ---
>> Changes in v2:
>> - Add a Fixes tag.
>> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
>> ---
>>   net/packet/af_packet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 3d43f3eae759..7df96311adb8 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -2845,7 +2845,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>>                  ph = packet_current_frame(po, &po->tx_ring,
>>                                            TP_STATUS_SEND_REQUEST);
>>                  if (unlikely(ph == NULL)) {
>> -                       if (need_wait && skb) {
>> +                       if (need_wait && packet_read_pending(&po->tx_ring)) {
>>                                  timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
>>                                  timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>>                                  if (timeo <= 0) {
> packet_read_pending() is super expensive on hosts with 256 cpus (or more)

Yeah, the CPU is exactly stuck on packet_read_pending() when soft lockup 
occurs.


>
> We are going to call it a second time at the end of the block:
>
> do { ...
> } while (ph != NULL || (need_wait && packet_read_pending(&po->tx_ring)...
>
> Perhaps we can remove the second one ?

The first call to packet_read_pending() is only needed when skb is NULL 
(i.e., at the start of the loop),  to determine whether 
wait_for_completion_interruptible_timeout() should be executed for waiting.

If the first call to packet_read_pending() has already returned 0, then 
the second call at the end of the block can also be omitted.

So, the code might be modified as shown below:


diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7df96311adb8..15a37209f872 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2785,7 +2785,8 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
         int len_sum = 0;
         int status = TP_STATUS_AVAILABLE;
         int hlen, tlen, copylen = 0;
-       long timeo = 0;
+       long timeo;
+       bool pending = true;

         mutex_lock(&po->pg_vec_lock);

@@ -2839,18 +2840,22 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
         if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
                 size_max = dev->mtu + reserve + VLAN_HLEN;

+       timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
         reinit_completion(&po->skb_completion);

         do {
                 ph = packet_current_frame(po, &po->tx_ring,
                                           TP_STATUS_SEND_REQUEST);
                 if (unlikely(ph == NULL)) {
-                       if (need_wait && 
packet_read_pending(&po->tx_ring)) {
-                               timeo = sock_sndtimeo(&po->sk, 
msg->msg_flags & MSG_DONTWAIT);
-                               timeo = 
wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
-                               if (timeo <= 0) {
-                                       err = !timeo ? -ETIMEDOUT : 
-ERESTARTSYS;
-                                       goto out_put;
+                       if (need_wait) {
+                               if (skb == NULL)
+                                       pending = 
!!packet_read_pending(&po->tx_ring);
+                               if (skb || pending) {
+                                       timeo = 
wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
+                                       if (timeo <= 0) {
+                                               err = !timeo ? 
-ETIMEDOUT : -ERESTARTSYS;
+                                               goto out_put;
+                                       }
                                 }
                         }
                         /* check for additional frames */
@@ -2950,7 +2955,7 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
                  * condition, and luckily don't have to go that path
                  * anyway.
                  */
-                (need_wait && packet_read_pending(&po->tx_ring))));
+                (need_wait && pending && 
packet_read_pending(&po->tx_ring))));

         err = len_sum;
         goto out_put;

> Also I think there is another problem with the code.
>
> We should call sock_sndtimeo() only once, otherwise SO_SNDTIMEO
> constraint could be way off.
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index f6b1ff883c9318facdcb9c3112b94f0b6e40d504..486ade64bddfddb1af91968dbdf70015cfb93eb5
> 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2785,8 +2785,9 @@ static int tpacket_snd(struct packet_sock *po,
> struct msghdr *msg)
>          int len_sum = 0;
>          int status = TP_STATUS_AVAILABLE;
>          int hlen, tlen, copylen = 0;
> -       long timeo = 0;
> +       long timeo;
>
> +       timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
>          mutex_lock(&po->pg_vec_lock);
>
>          /* packet_sendmsg() check on tx_ring.pg_vec was lockless,
> @@ -2846,7 +2847,6 @@ static int tpacket_snd(struct packet_sock *po,
> struct msghdr *msg)
>                                            TP_STATUS_SEND_REQUEST);
>                  if (unlikely(ph == NULL)) {
>                          if (need_wait && skb) {
> -                               timeo = sock_sndtimeo(&po->sk,
> msg->msg_flags & MSG_DONTWAIT);
>                                  timeo =
> wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>                                  if (timeo <= 0) {
>                                          err = !timeo ? -ETIMEDOUT :
> -ERESTARTSYS;



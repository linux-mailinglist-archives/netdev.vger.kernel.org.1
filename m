Return-Path: <netdev+bounces-205282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DAAFE081
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC677A2455
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8826CE38;
	Wed,  9 Jul 2025 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pP6+Z8jq"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2236D143756;
	Wed,  9 Jul 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043633; cv=none; b=iL2PlHqNfpCqE4CwIg5dTgg4rYra6RsGWrL0vpFnLXtx6Aur0Yei6zQIollw52JbQrGSA3mAYQeCS+13Dj2DUSeOyoJ8WloqMjogPNVw2OBWvYBUXyOKznVZiaUwlgHNByT6T4N/K0kMB2DLrDPD0/QQF5mAMKj9d2YkC7Ob3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043633; c=relaxed/simple;
	bh=5MVuqaCQntb5JtIugF7A6fTbeoPf+3u2mNbPEF7Q8vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syhA3S0HlBcQRiq1AO2hFsq0kQT+VcrzLH30zvDkNNKxjDKfnJUSLskGYkX6tsJacoihgLBlgbgzxY6KWGyPlUPEXJRwFJ9y5qKRJK4qADbTplGGDoim46cfyN8cJ4blP5+HLtp+JKr3u3gVR8gSxZ0UMG+9MzE4F3dsWN+dQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pP6+Z8jq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=eXkWVq4EtCwhZq2i+eo9+Z/EXNvoL3Qh87oqx3qXN6c=;
	b=pP6+Z8jq7y8smai+St3plJP6dx3SmX4diMrVJz/lJz60RwoQeqJBl1UpBQFx+e
	5zsT8/pyFZp1gySMBTMnrYXA2UTtSes423P3c5LsXJhU/mvzD5qt31ArvaWzb3FY
	wxywTEiokbyh62uMFvtxyFB7Q98th2KFF2zuTIrZilvWk=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDH16G0DG5os4xFBg--.28968S2;
	Wed, 09 Jul 2025 14:31:18 +0800 (CST)
Message-ID: <ca2f65f5-0ec3-4bd2-af8b-530b9feff2ca@163.com>
Date: Wed, 9 Jul 2025 14:31:16 +0800
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
X-CM-TRANSID:QCgvCgDH16G0DG5os4xFBg--.28968S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4rAFWUGry8KFy3uw1kGrg_yoWxKF18pa
	y5Kryjva1DJry2gr4xJa1kXr12qw4rJFs3GrZ5Xa4Sywnrtr9aqr4xK34j9Fy8ZFWkAay3
	XF4vvr4UCw1Dta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfOz-UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiOg6FzmhuB+6luAAAsN


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
>
> We are going to call it a second time at the end of the block:
>
> do { ...
> } while (ph != NULL || (need_wait && packet_read_pending(&po->tx_ring)...
>
> Perhaps we can remove the second one ?

As mentioned in the commit message, the soft lockup issue only occurs 
when tpacket_snd() is called to send,  with the pending_refcnt is 
non-zero, and there are no available packets in the tx_ring.

Therefore, at the first start of the loop, packet_read_pending() only 
needs to be called once. If the return result is already 0, the loop can 
exit directly. Otherwise, wait_for_completion_interruptible_timeout() 
needs to be executed for waiting. Later, this function should only be 
called at the end to check whether the loop can exit.


>
> Also I think there is another problem with the code.
>
> We should call sock_sndtimeo() only once, otherwise SO_SNDTIMEO
> constraint could be way off.

Yes, due to the changes in commit 581073f626e3 ("af_packet: do not call 
packet_read_pending() from tpacket_destruct_skb()"), every time 
tpacket_destruct_skb is executed, the skb_completion is marked as 
completed. When wait_for_completion_interruptible_timeout returns 
completed, the pending_refcnt has not yet been reduced to 0. Therefore, 
when ph is NULL, the wait function may need to be called multiple times 
untill packet_read_pending finally returns 0.


I have revised the code (as shown below), and it seems to be more 
reasonable. I also look forward to any better suggestions you may have. 
Thank you!


diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7df96311adb8..401ae8f6481b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2785,7 +2785,9 @@ static int tpacket_snd(struct packet_sock *po, 
struct msghdr *msg)
         int len_sum = 0;
         int status = TP_STATUS_AVAILABLE;
         int hlen, tlen, copylen = 0;
-       long timeo = 0;
+       long timeo;
+       unsigned int pending;
+       bool first = true;

         mutex_lock(&po->pg_vec_lock);

@@ -2839,18 +2841,27 @@ static int tpacket_snd(struct packet_sock *po, 
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
+                               if (skb == NULL && fisrt) {
+                                       pending = 
packet_read_pending(&po->tx_ring);
+                                       if (!pending)
+                                               goto out_put;
+                                       else
+                                               first = false;
+                               }
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



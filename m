Return-Path: <netdev+bounces-96664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29D8C701D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 03:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53BAB22858
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 01:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA8137E;
	Thu, 16 May 2024 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMEDmnd8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E210FA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715824271; cv=none; b=WQldouszdgMuejNXHxcalgxzL1AApTG5e+VGNOFnxKsceTAOa7kUoesvsL6wYuHzXLC78mv6Z6t/CL42iTxgkg2+eOpRwx1yw0h9tJovXhtkaY6Nl1pxblUSdRHGXlR6VHo7FNGg66sUr6mee3y7plnANHESczdQYZl79gh6sFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715824271; c=relaxed/simple;
	bh=VZm8PwZdXz0Se0UJLcdGqy0jJcWJtMdx7ttUqmGReLs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OMqPexoOnuVddF+uEof9u27UTUjK6HGdsPJEyYCJHmwFg/Q61OjZKRHWOX62+iIJ0viixDFtTzDXlI2a3Xj2JxA92ruFg7Eq5a0rT/FA+oZwWOQg/AaKj5xakAHV7LzO2WkV/WjuRBO5zWy8UbEvde4Y+xBlKlsc1H04dXfT7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMEDmnd8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715824268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ8ZtpLdFwvSXvOYs4aVKSIy+B51env2242BIG2JHBs=;
	b=FMEDmnd8iAWl8P7CEAgyE8qaRNj0cK1bCje7YeEKRfP1+8Kf3DjlX+AgyvZ1SBmQL2VoDz
	aIuU+xdN89Ulaa8cccG8tLp8UjNcDgP2Ys5cMhlO2Qa/w2UAZNWE1fPZ6uOMOGA4+WFDrg
	987wDzs6lavVKX/RKV7wXa5u/OnH8Dc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-fjj2LyeiM7qf7Uwfn3UG7g-1; Wed, 15 May 2024 21:51:07 -0400
X-MC-Unique: fjj2LyeiM7qf7Uwfn3UG7g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792e7b1d6a7so403525085a.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 18:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715824266; x=1716429066;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OQ8ZtpLdFwvSXvOYs4aVKSIy+B51env2242BIG2JHBs=;
        b=hNHSPYPuWtuiQmScluv/NPxseICl6BqVD9KOB8Oi4sfy7qckTWqadGKU09SxKvIJrz
         ecYY1f89T82IVncYbiKbYuE2ir/qz4vEAiBjUga4FdfQ/cBgUWFfVPYh8PZnS9KASKc6
         ao0ESOcxvQiF4es1/vjAH6vGPkcX02uplvQeuptAZb8HE2Zv6ttn13PXxrnKhFh5vq6J
         GeGyVUO8cw3oSNEyMAll3OoZACkZR+vx9cXHtYHPNi0+Evf8qJicuTm0UyDC/1rPknRe
         QuXcQM3QEYAlIisVxDKfBIVDPmxvXG+vHjwgsCGaW0lNTze2pcnSxnEYBgnHBMVGLRUd
         fLqA==
X-Forwarded-Encrypted: i=1; AJvYcCWTgptCQ2wgsJ09ZUoS21mOSOh3rbCm4MrOSMLZMVl2DjPoHTYIi/81PiDwO86/8Qoq/Fc+Dopj8dvdCuEpdaJCkA2ohs/m
X-Gm-Message-State: AOJu0YyuhpQ5Gycxw5bi+NjGx5U24gtEm3dHV/61aiXftoaEEIL+ZDU0
	o4pnKx9SiXHP59afZXaCI3Z5RYMWkIVExpyHaynF9dLl/V0OnPdKF2HWbMhky+D56cMbmk+3n83
	ETvGpxBT1k/94am5iRbuTbtzb7A6/dPg8x6KWk5eLC3eXgzH8mrGQ8Q==
X-Received: by 2002:a05:620a:37a4:b0:793:6d0:b917 with SMTP id af79cd13be357-79306d0bb20mr19630485a.4.1715824266449;
        Wed, 15 May 2024 18:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpszCgqcR6xxxMjDi29UaMLDi5LzclgxtHYRx1KHW2oOb/Rwj4OmBJc4XHPJDsYb5LUUkVMA==
X-Received: by 2002:a05:620a:37a4:b0:793:6d0:b917 with SMTP id af79cd13be357-79306d0bb20mr19628385a.4.1715824265801;
        Wed, 15 May 2024 18:51:05 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:a03a:475d:8280:d9b7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310bc3sm748724785a.99.2024.05.15.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 18:51:05 -0700 (PDT)
Date: Thu, 16 May 2024 10:51:00 +0900 (JST)
Message-Id: <20240516.105100.743311612367936729.syoshida@redhat.com>
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: j1939: Initialize unused data in j1939_send_one()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <ZkG9zbYwd0BL7B2r@pengutronix.de>
References: <20240512160307.2604215-1-syoshida@redhat.com>
	<ZkG9zbYwd0BL7B2r@pengutronix.de>
X-Mailer: Mew version 6.9 on Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 09:14:21 +0200, Oleksij Rempel wrote:
> Hi,
> 
> On Mon, May 13, 2024 at 01:03:07AM +0900, Shigeru Yoshida wrote:
>> syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
>> creates full frame including unused data, but it doesn't initialize it.
>> This causes the kernel-infoleak issue. Fix this by initializing unused
>> data.
>> 
>> [1]
>> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
>> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>>  iterate_ubuf include/linux/iov_iter.h:29 [inline]
>>  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>>  _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
>>  copy_to_iter include/linux/uio.h:196 [inline]
>>  memcpy_to_msg include/linux/skbuff.h:4113 [inline]
>>  raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
>>  sock_recvmsg_nosec net/socket.c:1046 [inline]
>>  sock_recvmsg+0x2c4/0x340 net/socket.c:1068
>>  ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
>>  ___sys_recvmsg+0x223/0x840 net/socket.c:2845
>>  do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
>>  __sys_recvmmsg net/socket.c:3018 [inline]
>>  __do_sys_recvmmsg net/socket.c:3041 [inline]
>>  __se_sys_recvmmsg net/socket.c:3034 [inline]
>>  __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
>>  x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> 
>> Uninit was created at:
>>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>>  slab_alloc_node mm/slub.c:3845 [inline]
>>  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
>>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
>>  __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
>>  alloc_skb include/linux/skbuff.h:1313 [inline]
>>  alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
>>  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
>>  sock_alloc_send_skb include/net/sock.h:1842 [inline]
>>  j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
>>  j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
>>  j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg+0x30f/0x380 net/socket.c:745
>>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>>  __sys_sendmsg net/socket.c:2667 [inline]
>>  __do_sys_sendmsg net/socket.c:2676 [inline]
>>  __se_sys_sendmsg net/socket.c:2674 [inline]
>>  __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
>>  x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> 
>> Bytes 12-15 of 16 are uninitialized
>> Memory access of size 16 starts at ffff888120969690
>> Data copied to user address 00000000200017c0
>> 
>> CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>> 
>> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>> Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> Thank you for your investigation!
> 
>> ---
>>  net/can/j1939/main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
>> index a6fb89fa6278..df01628c6509 100644
>> --- a/net/can/j1939/main.c
>> +++ b/net/can/j1939/main.c
>> @@ -344,6 +344,9 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
>>  	/* make it a full can frame again */
>>  	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
>>  
>> +	/* initialize unused data  */
>> +	memset(cf->data + dlc, 0, 8 - dlc);
>> +
>>  	canid = CAN_EFF_FLAG |
>>  		(skcb->priority << 26) |
>>  		(skcb->addr.pgn << 8) |
>> -- 
>> 2.44.0
> 
> Can you please change it to:
> 
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
>  /* CAN_HDR: #bytes before can_frame data part */
>  #define J1939_CAN_HDR (offsetof(struct can_frame, data))
>  
> -/* CAN_FTR: #bytes beyond data part */
> -#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
> -		 sizeof(((struct can_frame *)0)->data))
> -
>  /* lowest layer */
>  static void j1939_can_recv(struct sk_buff *iskb, void *data)
>  {
> @@ -342,7 +338,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
>  	memset(cf, 0, J1939_CAN_HDR);
>  
>  	/* make it a full can frame again */
> -	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
> +	skb_put_zero(skb, 8 - dlc);
>  
>  	canid = CAN_EFF_FLAG |
>  		(skcb->priority << 26) |
> 
> With this change included, you can add my:
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you for your feedback! I will send v2 patch with the above
changes you suggested.

Thanks
Shigeru

> 
> Regards,
> Oleksij
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 



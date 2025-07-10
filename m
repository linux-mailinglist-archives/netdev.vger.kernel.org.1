Return-Path: <netdev+bounces-205816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07868B0044F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75E51C84129
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866112749C0;
	Thu, 10 Jul 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGWMxZGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E071274653;
	Thu, 10 Jul 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155401; cv=none; b=fpW3cY3pcUh8XrNZ9ys8CYnMnOMWzEge1tge4VPOi7GqtOn3Lk3kcYD+NpLNhxJqQQW8gdvHy2u6ImsRQJ58M7LVsnMWGP8hwQ8Q9zCz+NFbZHiqU63AN2j+XfyTEpegyAFFTrrDenYcbfZUZ5raG7+e4jtgSDrtfnXQKdDAaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155401; c=relaxed/simple;
	bh=xJ9LLOK7vdYqQ92RR/y8cWKEz0ovdvS3q8rMLjdi0qc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lMgq0oQWK6MWt5Nc0dX7CMHEeRN/NKSqEyyluDe8fVNxPeh4il5tK9gBaG4zcjSDzYVAF1chLo5jmc0r5YSL0j6v0Z/7dLMpVr2iCnUXNKL2Tv04RHZ2qFo61GOJvezt9Ql8O8UM/gMNW2AFqKBg+hRHVcdIZLFSDxkFVi9eYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGWMxZGH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-714066c7bbbso10537147b3.3;
        Thu, 10 Jul 2025 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155398; x=1752760198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP5gheny4co9DmrW9rXSw+OW22thQIAOq23f68c3yzQ=;
        b=IGWMxZGHZkaKbp0Hg6FdW2ge5YPd1zbI2iakgWRysZm0Rrq/7v165KL25w9YB770S9
         GAscOp9q5Gqz3hjvxUiD8RURkR9sbPSRiZlOIh0h9fOu2PxiT20SW6ekTvfVrTsyIkWr
         5V958DdlhDc09blUe8ol0YFLq1YWitHTlswSHqslaUyB4tmlFqJ44tZLHAQqJibOULGc
         RFh8F+zsLJKq6AwXwCJQvQnMsqucbhySSTB1N9O6CyotHjLK9CTMzj4y+1j3We/vRqA7
         av2L7OavZSIVnZM1G0rRIKo7huOSgfXhgBxAPvv+incGG5sELua6jbsiXl8izVhVQQIn
         f8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155398; x=1752760198;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oP5gheny4co9DmrW9rXSw+OW22thQIAOq23f68c3yzQ=;
        b=NwmGxa1CUaIfC6313TZ3OkwIsSqO7Gk6o3u+QufKWuwkdyGpVjxQ8LAUN7RXONPWP4
         SB75VVAsDfF3SNus5rTwZRrrFyhfMrAExFARbIKQtCC3wP/24FqOJxtY8VjOBOybNeyE
         YwjC761TbAuo8F/YboT35CCjdwnaJA4xrL47EufNpD6jCYqLwOadUPE01WDbmjxocnwb
         9eKiquogy1rW3R+r8RpUuMZmV8iz7n6Y8kt+LOyfJZ5hfEw+p7bR3xA5RPI+aeEG0y/Z
         FWsclxmT42AtYakCMgeAO1C8Z88M2smhVwNZxTta9Tbg0Py2JgoYZmu48kgsl/4TZ0yg
         UtHw==
X-Forwarded-Encrypted: i=1; AJvYcCWuGY27fr8LK2XSxrDXHT/hGOUnxT/gXjDseyR1tAgoKabl+EsFY1RVFd5OiqEW41xYsuZcBg5dLCHhN2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUESdeEoZwiyeuH7imwjhdv7Cew0ugDOH5RMxVQeFLi/pR+qbI
	G3gaWT0I2Hn2fxAAyqkg6lsDy5xMlASe3xegIBeTA4HvS3PZgeXPh+mk
X-Gm-Gg: ASbGncttI7XMucVD7rINf46gVqiq8VT6W/GSG8CBMTYieNdO0ignK+Doy8fCANqG33m
	nyJUd7KKPkwtsFvJIMXjpKCijQuOMe+hJkaTVD9dH+Dj+lhyEGZXwxl+qkfCwgmgUz07TK89T1z
	8hV5f/+4k8ibIBbfBqU8irkYNX9FcMkgUhZfh8uHYvVd6tjBQIv8Pa8QZXyD+6F7GUFGEl/BLhU
	qdBB1u9mmkxRgEAOHiQCOvi3WxkmIVRHLno7PljLZUQ2mad/Jd9FaDOL2N4Df0EpX1o65TpDW5Q
	fpzi1XMPnOL0m5SSdU3A5Jpzyx8ItH+r7ZJLOGIe8WgaqlkgH0IG2zX0MpOKubxjkU+RqYp9vEQ
	L4aETLCAqRyBKOLEk6aTVMPcZICVnLSaekjjb+ZfKK9UY3o2Lfg==
X-Google-Smtp-Source: AGHT+IGCe+Uu+QfKr2HTmmpsPsEqhzNKWcrcA7umfcUalR6t0fVI5/KW+nKFvEH+XH22D/8pLDACRQ==
X-Received: by 2002:a05:690c:3581:b0:714:250:833a with SMTP id 00721157ae682-717c175796bmr55938917b3.27.1752155397984;
        Thu, 10 Jul 2025 06:49:57 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c6216461sm2890597b3.115.2025.07.10.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:49:57 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:49:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <686fc5051bdb8_fd38829485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250710102639.280932-3-luyun_611@163.com>
References: <20250710102639.280932-1-luyun_611@163.com>
 <20250710102639.280932-3-luyun_611@163.com>
Subject: Re: [PATCH v4 2/3] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
> 
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run. As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
> 
> In fact, skb is true for all but the first iterations of that loop, and
> as long as pending_refcnt is not zero, even if incremented by a previous
> call, wait_for_completion_interruptible_timeout() should be executed to
> yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
> the execution condition of this function should be modified to check if
> pending_refcnt is not zero, instead of check skb.
> 
> As a result, packet_read_pending() may be called twice in the loop. This
> will be optimized in the following patch.
> 
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
> Cc: stable@kernel.org
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> ---
> Changes in v4:
> - Split to the fix alone. Thanks: Willem de Bruijn.
> - Link to v3: https://lore.kernel.org/all/20250709095653.62469-3-luyun_611@163.com/
> 
> Changes in v3:
> - Simplify the code and reuse ph to continue. Thanks: Eric Dumazet.
> - Link to v2: https://lore.kernel.org/all/20250708020642.27838-1-luyun_611@163.com/
> 
> Changes in v2:
> - Add a Fixes tag.
> - Link to v1: https://lore.kernel.org/all/20250707081629.10344-1-luyun_611@163.com/
> ---
> ---
>  net/packet/af_packet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7089b8c2a655..581a96ec8e1a 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2846,7 +2846,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		ph = packet_current_frame(po, &po->tx_ring,
>  					  TP_STATUS_SEND_REQUEST);
>  		if (unlikely(ph == NULL)) {
> -			if (need_wait && skb) {
> +			if (need_wait && packet_read_pending(&po->tx_ring)) {

Unfortunately I did not immediately fully appreciate Eric's
suggestion.

My comments was

    If [..] the extra packet_read_pending() is already present, not
    newly introduced with the fix

But of course that expensive call is newly introduced, so my
suggestion was invalid.

It's btw also not possible to mix net and net-next patches in a single
series like this (see Documentation/process/maintainer-netdev.rst).

But, instead of going back entirely to v2, perhaps we can make the
logic a bit more obvious by just having a while (1) at the end to show
that the only way to exit the loop (except errors) is in the ph == NULL
branch. And break in that loop directly.

There are two other ways to reach that while statement. A continue
on PACKET_SOCK_TP_LOSS, or by regular control flow. In both cases, ph
is non-zero, so the condition is true anyway.

>  				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
>  				if (timeo <= 0) {
>  					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
> -- 
> 2.43.0
> 




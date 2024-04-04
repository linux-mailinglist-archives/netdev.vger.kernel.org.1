Return-Path: <netdev+bounces-84667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F22897D39
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70BB1F243F3
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F714C6F;
	Thu,  4 Apr 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4fpo6rM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AF320E;
	Thu,  4 Apr 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192462; cv=none; b=jDFSRbZxHF3DbXq5maO8+QCZ8L59pfFO2zrSdiSJf32xLp1Zf0kp1G147VTZ2Gt1Ttn5RjejLZ+gjDzP0sO97pRnYpuHR/mkF+q7DjlCZWfKSQlLZIW93ZMr43VHTvt+T/6xIRyqYlGElLpWj/FGkt9JxoWd+42dA7wPUX7Qw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192462; c=relaxed/simple;
	bh=ZlMIa8ZmMETO1CKCMXAYfNg3Td5UXxBHClsGIRtfr6A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iogs3NbEuvRnTDbDmkq30PevChdkG4DVxD9mNvGPTzaCXN3lbcvkiI7HfKT+A9Q82Mkz9YVxCE9IGgTQNjZ8vyeT8DCIa2KfDLv6g1MvpWUvoBPPWhCGFrzRE1oKGhG1mKXje0IO8MsDOBasV3ab+BaFnZGeaoBBrEDIwFAzQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4fpo6rM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so346207b3a.1;
        Wed, 03 Apr 2024 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712192460; x=1712797260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L6hv9ElVyHxCNPjuDY2xtpLGoOXXZkVhMwmp1uyPQk=;
        b=H4fpo6rMKaySZSf6++MY/xeoQ4yTgA4d0746VOm+0F8RtpFoxvvHYeN/uCPptmy+AW
         suWr+TcFQuGiu5ABIPxktN1xkoWFNdN04cD9c3rsD9APQB93D892xoqWhvFvF3j1BRDp
         z/L99+bl48wUp7wH7ioWPiart3v7fWRn/LWwIaYhdq9NjbCFYmicA1XORQiZxjqEoV7w
         WQEIFno0Ds9rEnJP14R2KFKsqk+gcf880SsORNgMX8EIGGeIPNdgozroFfFMqElydgcj
         h3gPNQknD2nC+4KsWNFShBQZ7EJON9MKj5FsBRzIN9JRFH7MD1hq+wuH/ip8AA/8jfY9
         4tgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192460; x=1712797260;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7L6hv9ElVyHxCNPjuDY2xtpLGoOXXZkVhMwmp1uyPQk=;
        b=SXnIQbbM8Biv5LbEkLT92u8EV5SPQkh4R0jHfRa7SJ8D1uonouremSPFkYZ9OA+pYq
         eLpCQo4OrFjgo3MfQaJY7j3aR2aULKlQfmlrW/gIbFoSZ7g5awsswgYhvP56E3A3W0Lp
         9g4WVbQEU3m+noplXZYvn4ORMIqA/g4ULymFlJSto4ZXt1q8qz3cWGgpLptjZjZchuSi
         SwCTdohfa1IpdNSudl7OeYKrGYWizWjnCiTwzzd89BgN9QvH3k2qUQkXTDIk0lXrY4wc
         QkclUDlyliEKBEYIckuAIAO664qkper/9xMlVo7K6do78vJ86xwphoLzC8DWce8gFabr
         N2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWl3u6X/yUmRo7T5etyKeQA7GbdYtwjKzPT/hQuCc173XyvIQ6Afh8Zy5NgzPzW+ecKw/qcfQ4wRCKYjlM06G1/DBi3
X-Gm-Message-State: AOJu0YxnaNSBp+8f5l7tmh1Wnj3BBJgRacabPATLRB7hCv65nf9OKGVW
	9Rcl6cv0AgXWVnQoLllNkslDu5YZXEPVS0Xpj1fITBl4eiGY1epH
X-Google-Smtp-Source: AGHT+IEoLS215TCQBwgyVYuaeyYIOO18gxCt9Y6idJxKoN/wKoYQ1SHTtVOaj7G+BHXWxgbvmpVd6g==
X-Received: by 2002:a05:6a00:148e:b0:6ea:f7e2:49b8 with SMTP id v14-20020a056a00148e00b006eaf7e249b8mr1431891pfu.3.1712192460642;
        Wed, 03 Apr 2024 18:01:00 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id h23-20020aa786d7000000b006ece29ffb21sm330313pfo.70.2024.04.03.18.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 18:01:00 -0700 (PDT)
Date: Wed, 03 Apr 2024 18:00:59 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 john.fastabend@gmail.com, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 daniel@iogearbox.net, 
 ast@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Message-ID: <660dfbcb45cfc_23f4720810@john.notmuch>
In-Reply-To: <20240329134037.92124-1-kerneljasonxing@gmail.com>
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
Subject: RE: [PATCH net] bpf, skmsg: fix NULL pointer dereference in
 sk_psock_skb_ingress_enqueue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix NULL pointer data-races in sk_psock_skb_ingress_enqueue() which
> syzbot reported [1].
> 
> [1]
> BUG: KCSAN: data-race in sk_psock_drop / sk_psock_skb_ingress_enqueue
> 
> write to 0xffff88814b3278b8 of 8 bytes by task 10724 on cpu 1:
>  sk_psock_stop_verdict net/core/skmsg.c:1257 [inline]
>  sk_psock_drop+0x13e/0x1f0 net/core/skmsg.c:843
>  sk_psock_put include/linux/skmsg.h:459 [inline]
>  sock_map_close+0x1a7/0x260 net/core/sock_map.c:1648
>  unix_release+0x4b/0x80 net/unix/af_unix.c:1048
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0x68/0x150 net/socket.c:1421
>  __fput+0x2c1/0x660 fs/file_table.c:422
>  __fput_sync+0x44/0x60 fs/file_table.c:507
>  __do_sys_close fs/open.c:1556 [inline]
>  __se_sys_close+0x101/0x1b0 fs/open.c:1541
>  __x64_sys_close+0x1f/0x30 fs/open.c:1541
>  do_syscall_64+0xd3/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> read to 0xffff88814b3278b8 of 8 bytes by task 10713 on cpu 0:
>  sk_psock_data_ready include/linux/skmsg.h:464 [inline]
>  sk_psock_skb_ingress_enqueue+0x32d/0x390 net/core/skmsg.c:555
>  sk_psock_skb_ingress_self+0x185/0x1e0 net/core/skmsg.c:606
>  sk_psock_verdict_apply net/core/skmsg.c:1008 [inline]
>  sk_psock_verdict_recv+0x3e4/0x4a0 net/core/skmsg.c:1202
>  unix_read_skb net/unix/af_unix.c:2546 [inline]
>  unix_stream_read_skb+0x9e/0xf0 net/unix/af_unix.c:2682
>  sk_psock_verdict_data_ready+0x77/0x220 net/core/skmsg.c:1223
>  unix_stream_sendmsg+0x527/0x860 net/unix/af_unix.c:2339
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x140/0x180 net/socket.c:745
>  ____sys_sendmsg+0x312/0x410 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x1e9/0x280 net/socket.c:2667
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
>  do_syscall_64+0xd3/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> value changed: 0xffffffff83d7feb0 -> 0x0000000000000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W          6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> 
> Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer
> dereference in sk_psock_verdict_data_ready()") fixed one NULL pointer
> similarly due to no protection of saved_data_ready. Here is another
> different caller causing the same issue because of the same reason. So
> we should protect it with sk_callback_lock read lock because the writer
> side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lock);".
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa8c8ec2538929f18f2d
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/skmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 4d75ef9d24bf..67c4c01c5235 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
>  	msg->skb = skb;
>  
>  	sk_psock_queue_msg(psock, msg);
> +	read_lock_bh(&sk->sk_callback_lock);
>  	sk_psock_data_ready(sk, psock);
> +	read_unlock_bh(&sk->sk_callback_lock);
>  	return copied;
>  }

The problem is the check and then usage presumably it is already set
to NULL:

 static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
 {
	if (psock->saved_data_ready)
		psock->saved_data_ready(sk);


I'm thinking we might be able to get away with just a READ_ONCE here with
similar WRITE_ONCE on other side. Something like this,

  sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
  {
       saved_data_ready = READ_ONCE(psock->saved_data_ready)

       if (saved_data_ready)
             saved_data_ready(sk)
       ....

And then in sk_psock_stop_verdict,

	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
	WRITE_ONCE(psock->saved_data_ready, NULL);

And because we don't actually release the sock until a RCU grace period we
should be OK. The TCP stack manages to work correctly without wrapping
tcp_data_ready in locks like this. But nice thing there is you don't change
this callback on live sockets.

I think at least to keep backport simply above patch is ok, but lets move
the read_lock_bh()/unlock_bh() into the sk_psock_data_ready() call and then
we don't duplicate this error again. Does that make sense?

Thanks,
John



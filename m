Return-Path: <netdev+bounces-85079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491C289948A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 06:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A0F28D396
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 04:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919621CFB5;
	Fri,  5 Apr 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZs8JuEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DEE1CD23;
	Fri,  5 Apr 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292222; cv=none; b=oAgw+WepT1bfgfg2X5ENZoDdaKCLR36LecVeW5W/tZDHU8PB+4/ovLFL0sILDAKwV8yAhKX1OV63ybLSUdF1EeHulF4ekXvzMYl265/xTQXVgEfpke8oiyTpArtf/hh4jcvmxfqWZVBx+78MUaXAvn0hv5vZx1J6pp3OLbBKI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292222; c=relaxed/simple;
	bh=ItBpTuY1qBxZzLIIfBvspQ2OBDH7aFvzsC54M6CCwvs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MrNTqTENv8qlORRsDEhqEaWREwZ300Z1yrW6QS41GJ4E6g1AfHplscsoW9K07m4al9VyCS0NgVBVQynPOuqny2St7TreN8DHR735lPC1dtWRW4mJvFzPmUGg9A/AoFuVuXRbczrn36WnV+oyBG0e5xw73ywUvTK9Kc6XhEpdQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZs8JuEY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so969905a91.0;
        Thu, 04 Apr 2024 21:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292220; x=1712897020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztwv2Vgkba6NgmrfOAYLgmgpqx7EzIAvD/dhUW+MU1Q=;
        b=OZs8JuEYXB/MQIDHQaNrwLELWJMTejd0gVNz1JRlBesdNx/rwqB2sGzRhiR9jltH1c
         HfYJVSCGo8bE+h0MxRy6jNl7tQkQVJsMH6JEAlDcvn9t8g/3VWnq9u24SjQFhXGmkRW3
         VbmGohSPUwNFkWibIJ/ptzqOs1a86xM+mkDp/Ado8QRopI0yMuQ/KbgM/eObOjgX5WMv
         a6qJojto/Y3TwFbXiCNU1yk7yriQFDaGfTxPnKIO5s411UeM2YyN59YCNaYk4eQMebdT
         DWDcziFkZSkCYBr1F0ZfBG/kMg8tSsLVOmqA9ZOOjlPVSeaBabZXL0Q0h8vC7YU2ZMmv
         2GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292220; x=1712897020;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ztwv2Vgkba6NgmrfOAYLgmgpqx7EzIAvD/dhUW+MU1Q=;
        b=JZylSnaQPSlcECzX4jpocPQnUNTKjlFVYBkL5rMHWOrc9uzmVfcapxa/whNzZK3hYn
         yLrsVyqd13R2hU5lyf+cL2DWg+rCo69OgGpSPP93WfeWwP+N5apcqRiMz5cN/pq5sK7F
         yhFGFt6TuYW4QFjPEvCEMo8yt72ril/FroPP8jOGxf7fZ3/e3xBedB3Cy2NiMlBqmQaw
         zevNnmkNXviehWQpVYDgVQL6vrAuJ+Kc5eJ/83pTDc+EPHVsddcXthv9/1RFathtUDsB
         FmXwPg2dDPcE743XRz1xv08swKKsCjtfqbWKYyh1ozBg8U3YYSzk666BCqt98u6fV5oW
         cj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWxdEW4AFfRt2yovqXurZwK5cPwIkiKMf4K0v1h5dOopPrWG8D59vkY5l0KckSOMI6ENGojKQtPesIc8gOP08MK5qO
X-Gm-Message-State: AOJu0YzAiUrdVJyiWy9pnqqrR1kF0YrewK2hhapAJcLjAFC85eJRpBfs
	x71s/594iZbHZKcSCuyHmpCl0Hnu1m81pS99+lT9RYJQdeefFCNrwiAuQcYF
X-Google-Smtp-Source: AGHT+IFgdeVyr6TLILVudglYWwR6UVYpd53NRGpzrYHcYE3RArhA8GcTaM3e9SiIEzFt/4tIfnQT4A==
X-Received: by 2002:a17:90b:1905:b0:2a2:510f:fa4b with SMTP id mp5-20020a17090b190500b002a2510ffa4bmr351968pjb.10.1712292220186;
        Thu, 04 Apr 2024 21:43:40 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090b010c00b002a203bd94bfsm555131pjz.51.2024.04.04.21.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:43:39 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:43:38 -0700
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
Message-ID: <660f817ad9464_50b8720845@john.notmuch>
In-Reply-To: <20240404021001.94815-1-kerneljasonxing@gmail.com>
References: <20240404021001.94815-1-kerneljasonxing@gmail.com>
Subject: RE: [PATCH net v2] bpf, skmsg: fix NULL pointer dereference in
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
> To avoid errors that could happen in future, I move those two pairs of
> lock into the sk_psock_data_ready(), which is suggested by John Fastabend.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa8c8ec2538929f18f2d
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/20240329134037.92124-1-kerneljasonxing@gmail.com/
> 1. move the read_lock_bh()/unlock_bh() into the sk_psock_data_ready() call (John)
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>


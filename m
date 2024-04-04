Return-Path: <netdev+bounces-84666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F71897D2D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07B11F2151E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1D4689;
	Thu,  4 Apr 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESJ/LBrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473994400;
	Thu,  4 Apr 2024 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191491; cv=none; b=Rq+zB4uX/bpRjNG5gryw1IaFKXx5TuM+1aXbiOZ59k4zSdfwg07mPy68GtSkQ+pASGZ44fUaVK7qxdGhErGX2hchBYOF5doXr2pBaQO7sPfWaFZ7HceEy3/e6hMV7lcLNgAlqrWpMPlhbO9FQtdMIdXGRY1LCAJepNtJ40vJYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191491; c=relaxed/simple;
	bh=SmTsFNwze+qFk+ZBnumwEq+deOZgym+C/rK3ROx3eOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dne+hbBLJhbwfZkGrf7TO6IJYe+Pi0pKAcMtt/gCsB0SJEVg72ZNj9s+oTxrVGNqrK0AjWUjeW6QEEqp04Sp5/YYC7Cu9VVkonzGfGNf8oT0iaLcxzf6mp8Z8mN5L96OKPauqxchmtLCH7G58BqNEQCHx5DuYUved9YspO+dV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESJ/LBrW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4e65dec03eso61842966b.0;
        Wed, 03 Apr 2024 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712191487; x=1712796287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ongBL07xCA2tmt2N39sHOiy+4X4p/KUcdwXqcVjmBXw=;
        b=ESJ/LBrWGMcgNdYpB9BHAAWbSiW+LcEIW9IH4orHHcr9qdVh7GY+XlvMm8VFPBjX00
         mIBsWvmectd678BeOi8pxNO8lAoAGBhrSPwRCRMh2R+rzV1uO4iOFCr0/ulpbDA+DVkW
         xRJdGZkaTwZ9Rn7KGO9vwQZ4hbB5mYipF0iCRC1yG5lmb3VnvtuGmTFy02/CUuwi3Jy8
         IyAw1UuQomQh06H4DvbuVFjZ2YuuawLB/neF+oTl1qqo5UlUIJzBYqc8ienAvqfXe1+c
         5tTrJ2pUHOIj8T43Pxiogv3sQegtl6LxxaaWK9zWO/Ca75vUT001S5JO4IUfuUKo0ST3
         9odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712191487; x=1712796287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ongBL07xCA2tmt2N39sHOiy+4X4p/KUcdwXqcVjmBXw=;
        b=j9ekMsxq9KvIN4fgVQWUCU2XYIlcEkIv4oXWO0Ddfm/G9K9nVB9iEaLbWCbaWLbUqf
         icBpSjhGK2mF2r3O9FHxItw3VnQVS5n9052TttJtrjBj+ek4i/gByExCaMCq71gE//Fj
         XZjfsk9sutVUMQiRoSAopDuN02HVLdtgY/aR7/0ad31vY3MHD3x8RgCESf9c+3Xxh1oo
         fXMiKhqwnjfWIz9G4CM5OeGwa3TXYcKuinHWUn+bU7kswskqUYiF2+wtym50dDLmbGh/
         JGMF1tpM3OwMFUmCi/AWFD8NN7ZsUSeujJlKIIZYvj2oM6TRmHF9f16/S598ZjSOpYvl
         9KFA==
X-Forwarded-Encrypted: i=1; AJvYcCVaV4WTMqLY0eqhGHWStqAzuoT2gd2LI+NK+pXxZvAi3BRstqdXSaZ84mnhcc7KveM8yLsCUXZ4oAXkG5gKoB+Dm3bE
X-Gm-Message-State: AOJu0Yxe5Pzmnf+mravZRaKvvRSnHprAU8kf8iCGxfmlPF7zBNf+GyWb
	c1HTWTiuogghIB06W4fEjqQrpy0K5NkM6G2x4u6QFp9XG2REawqAOCiHdfNjlBbtGqPtFlexRDP
	9Td4yLgColbFk/d8/5lnLq29mEpc=
X-Google-Smtp-Source: AGHT+IGlB/g2jSaO0EOkM126c+fYytG5Ogs8KDYNnrsGBkrwZLoyN08LfjaHwgyxT13gShGPn/lqM9cNSSds4+u2tdk=
X-Received: by 2002:a17:906:789:b0:a4e:8956:5ee6 with SMTP id
 l9-20020a170906078900b00a4e89565ee6mr451226ejc.31.1712191487381; Wed, 03 Apr
 2024 17:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240329134037.92124-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Apr 2024 08:44:10 +0800
Message-ID: <CAL+tcoDjpi8FGWGGFmPY6W9_YYDYaMj+67amA3ZeQcQe0kWO+A@mail.gmail.com>
Subject: Re: [PATCH net] bpf, skmsg: fix NULL pointer dereference in sk_psock_skb_ingress_enqueue
To: john.fastabend@gmail.com, edumazet@google.com, jakub@cloudflare.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net, 
	ast@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 9:40=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
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
> CPU: 0 PID: 10713 Comm: syz-executor.4 Tainted: G        W          6.8.0=
-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
>
> Prior to this, commit 4cd12c6065df ("bpf, sockmap: Fix NULL pointer
> dereference in sk_psock_verdict_data_ready()") fixed one NULL pointer
> similarly due to no protection of saved_data_ready. Here is another
> different caller causing the same issue because of the same reason. So
> we should protect it with sk_callback_lock read lock because the writer
> side in the sk_psock_drop() uses "write_lock_bh(&sk->sk_callback_lock);".

Hello experts, any comments are welcome:) Did I miss something?

Thanks,
Jason

>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Reported-by: syzbot+aa8c8ec2538929f18f2d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa8c8ec2538929f18f2d
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/skmsg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 4d75ef9d24bf..67c4c01c5235 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -552,7 +552,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buf=
f *skb,
>         msg->skb =3D skb;
>
>         sk_psock_queue_msg(psock, msg);
> +       read_lock_bh(&sk->sk_callback_lock);
>         sk_psock_data_ready(sk, psock);
> +       read_unlock_bh(&sk->sk_callback_lock);
>         return copied;
>  }
>
> --
> 2.37.3
>


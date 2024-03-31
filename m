Return-Path: <netdev+bounces-83576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB18893120
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 11:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FFD1F21A4E
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794475804;
	Sun, 31 Mar 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEgd9mU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B5757E6;
	Sun, 31 Mar 2024 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711878339; cv=none; b=ZIa7eI86OMI0DoAC/l+C0JBx0r17V35WgUIUv7fb8mLrA9LYJXgBNKFMaWeY1eeBp1s09+lbPAqUPcM0vnQXCAzTfsTepwmiVSm9NirJXThxfGo0hZUVPPwkhmqGMUBauhgLuYNTGIcOn0UmJlMo6UDBb3GjMWGJUoqeyvjbc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711878339; c=relaxed/simple;
	bh=N4vnvTqeAlAn6JmV4Z6vFOV4lqVDcyG+FoyDCNbrDNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XryDGTznOo3dFjAbAKs/heah/g+WKc8JTZViTE872NSGsjuLFYXxQvhtqmB8b72wHx0JKrtw1ZMGpaj0VRELMJWf09ZBnjhidu1345Tl4z6iFnMnG2/xAxluGFhsag9ck4UIWhoK5LuVKqyqrRlYOnHQaiaKcpY18i6N5JO7m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEgd9mU6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4e61accceaso32611766b.2;
        Sun, 31 Mar 2024 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711878336; x=1712483136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukh0ZTJfrA6xX77cDNXcMVE26JamLLj3wpfAUbyE8mc=;
        b=BEgd9mU65NxDBWnaoNRMywDH7h1F6kF4bHHZIMaMxsNLFJPWQmPQLJLy9GUNx/0r3u
         cBUSPVm7Mjz2tp4N6C1qfe2Pr7nBOhX8N4Uly/3i2A4jlhvB0JtNkIaqc6gtIOKWZwFo
         bf3bkyvtvcSEsA6pQoOqAJZq5V+ro+p7ZJxip36w6ay7N15NP/OtHyKMWrC/NiFuI6Ll
         13CH0z6YWXRlgHqmZevtBtEfRmSA+q3/MLChOnM79MQwYnVJeDSjnxT4xuEUECg13JR6
         gSg4vsJySoqprKT5eZlepJrcM4p+AB9LWtlzGV8lBJ2fCKFXfNvftUYJO15JD0mjC1aO
         vApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711878336; x=1712483136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ukh0ZTJfrA6xX77cDNXcMVE26JamLLj3wpfAUbyE8mc=;
        b=elU8GOfn6WFHkbLYAgEj6XrLoom3UoTu288ruct0B486v2qaipa+NAmZI/AdZ6hfDZ
         Aqt426QfX7UtAw0I4WwA6Ih9qt2H2/Xy5aAXPEYuG5EbjI7hOkZDZ0C7fAOKG6iPPsK/
         GdeTTynZVTEvZcVQFRICz2QTmkMUV5V8ZGPqGo6gUK55VbkozrpLoTJJOLbDIt+VNKc/
         HDXbu8lILIdPuexFtUwABcaoBxf9/AI0B/NvV/5ScnSTODCY5KEkxzxsJhwPFXYrmbfj
         WVhv1mh43l+lbBZ1t9A29ldxsIwwgT7Fpe0F9Y5uvWcXArLRX8Typ1pi9Dwpoa2ivnSJ
         yqzw==
X-Forwarded-Encrypted: i=1; AJvYcCUuc8q+5wrqoapIVMuvKFkenPNoTv+RzpkTEOP+XTW/0pOX+jY+M+LeZ81yYfsy49BHHwf9+f+FLoOzUW2Fg9V7F7jn
X-Gm-Message-State: AOJu0YwsZMrWR5e+78brYfxioXtMfw7Ms8AASQ3oUOs3WVgQh3wlWMze
	cZ9tzRyFJAHUyOAkCcjz5M9XmJaws/MawBN78UnYt9z92N+tI11NBA2TfoHsGHUMBHNvsGJDvas
	aclrSdOXM3jKvpZ4f0aEJMJM+9ss=
X-Google-Smtp-Source: AGHT+IHzAecqJ0qab4ntl4tPlGW/4zRjO2MVXQLPmidrRodJRxn2Kgf8NE4swtcG8N4SqfLT1q6SneaiZRG3O3oue+w=
X-Received: by 2002:a17:906:300a:b0:a46:d041:28e0 with SMTP id
 10-20020a170906300a00b00a46d04128e0mr3763433ejz.59.1711878335928; Sun, 31 Mar
 2024 02:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329134037.92124-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240329134037.92124-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 Mar 2024 17:44:59 +0800
Message-ID: <CAL+tcoCo6i+=HJViR1UwFZ+6Ch7-0LCAAa7cP0+mUHSPEr+9bg@mail.gmail.com>
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

Should I use 'read_lock(&sk->sk_callback_lock);' in bpf_tcp_ingress()
to protect sk_callback_lock field? If it's ok, I will do it in another
patch.

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


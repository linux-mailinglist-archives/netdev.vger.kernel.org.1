Return-Path: <netdev+bounces-83676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F08934A7
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B5F1C237A3
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA381607BD;
	Sun, 31 Mar 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEgd9mU6"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A915FCEB;
	Sun, 31 Mar 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903436; cv=pass; b=m60ltxRE+9R/r5YNcqZ1WNQ9AJvHIeFpNy334JxnJvPBpZhQ8KswgmGb3LkncO17IawH0Bl+dBhS9gJaFoHl3nHBmlcc4tqobQ21Pp+7C+5Tr44Swb/XfZCl+Fzq6gkLUGnGwe9Fo9ddbQjlAZfzi19oNnxRMGKasnzKVZY4tgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903436; c=relaxed/simple;
	bh=N4vnvTqeAlAn6JmV4Z6vFOV4lqVDcyG+FoyDCNbrDNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqK8Xrc3x9C5nzoc8Bq7HepDmc2fPgHChSQHjkziCRAGho6tVAQQ7HlFfkd7BbHmv08OwBNtFtEtDluXQWKsAqJvlWIU6sBAqhslvIqAcsZ+hPtBFxrj1wU6eYssDwdf9uB4Dddvvs2x3JRT1c+cEWvqfCRikJmqgMeilB6Pp40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEgd9mU6; arc=none smtp.client-ip=209.85.218.48; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CD904208C7;
	Sun, 31 Mar 2024 18:43:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wXkl6T_SV5i; Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 08FDE208CC;
	Sun, 31 Mar 2024 18:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 08FDE208CC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id EFEBB800061;
	Sun, 31 Mar 2024 18:43:49 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:49 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:13 +0000
X-sender: <netdev+bounces-83576-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUAbAACAAAFAFgAFwBIAAAAnTlpvhaBCEeyp1ntZSMfKUNOPVNjaHVtYW5uIFBldGVyLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoASHcFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQ8AKgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuUmVzdWJtaXRDb3VudAcAAgAAAA8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAH4AAADwigAABQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 19246
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83576-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 85696202D2
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEgd9mU6"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711878339; cv=none; b=ZIa7eI86OMI0DoAC/l+C0JBx0r17V35WgUIUv7fb8mLrA9LYJXgBNKFMaWeY1eeBp1s09+lbPAqUPcM0vnQXCAzTfsTepwmiVSm9NirJXThxfGo0hZUVPPwkhmqGMUBauhgLuYNTGIcOn0UmJlMo6UDBb3GjMWGJUoqeyvjbc2E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711878339; c=relaxed/simple;
	bh=N4vnvTqeAlAn6JmV4Z6vFOV4lqVDcyG+FoyDCNbrDNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XryDGTznOo3dFjAbAKs/heah/g+WKc8JTZViTE872NSGsjuLFYXxQvhtqmB8b72wHx0JKrtw1ZMGpaj0VRELMJWf09ZBnjhidu1345Tl4z6iFnMnG2/xAxluGFhsag9ck4UIWhoK5LuVKqyqrRlYOnHQaiaKcpY18i6N5JO7m20=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEgd9mU6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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



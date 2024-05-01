Return-Path: <netdev+bounces-92835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3628B909A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB57F280EBC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86E1635B5;
	Wed,  1 May 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlB2HbZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E1F9EB
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595268; cv=none; b=sZCuLfwMraSXsXuvps1BpqDsrEi1ka+cgGhEPoov3R0/LlSF7Oqlje6f4/2NzJN/GoqdV5syc3QbQHTEK7mO11NPHYwdqpzQK4w9k6TKDeA9BkzAkQyx9gvHJB4Sc7+EUukgWwVd09Z3tSUTSB56Sdxio06+qonC8UGl94dXW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595268; c=relaxed/simple;
	bh=tX9sD7idlD2t5kOk02rIsY2Rb+Wa6pHloCCZVlm3R1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDPSCfvasVSJSldSObt8DhtG/JX5YET+P6Im2FBo/0SZbLxY8HqN21COcttaP7E7ugEj2fZTg87JEAkorBAFnrue3qXK9kXce9rObdLm+nRGfSHU8bET+Qm6AoOz32AAg7ilIVA8K7ryZ1suTgXBvoEDLOLoJq/jEs8TMO4g0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlB2HbZz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7f16ec9798cso722299241.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714595266; x=1715200066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbYVy19rr9hSh0zP7URUG1phLK/9UOWt/E/6JkqxPxc=;
        b=SlB2HbZzmUKWe3BXewV3yXXhc5VdmNWnfFHMuhwQ4jYkm4Ou5J5aHIdCLfesnFlqcH
         5pYlXlR95BzWifRi9DkK7LrlFLyOAHTa3KYqhDMdIB/lZNOgiFQSkM6pP1AUfWKqxPrQ
         7ifiYR6O8PTlpLQEnCztCXFSErsq7bHeWFdfg56KQAbX5TvkN6hrY0f8nZ85p9EucvHI
         RgEELExTnt47Rm9tkMn7LtiMnZyv0yakIptdm1YMO+vvVAKNkXl4BfFT2skKXPJ655CY
         xRqd1StZACCPwstpMZc0EyzSkOGO8FrQsSiOeRzTIuI//wa7PcSKqzmyw6wH6/qOjncV
         lLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595266; x=1715200066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbYVy19rr9hSh0zP7URUG1phLK/9UOWt/E/6JkqxPxc=;
        b=qob1zSVOS81tro9c/Jm0MiHKMvzPtvvv8tW4WcE3rUVoFPgF/ClmuIvjxwkP87Uwzt
         XZHPb27f9UxeqO23VX4wt8hmsUcC30/zS+ngUyiRq3RTTzTj5S4ZwCql5w+BVcXZoUSE
         xntgk2ZWq3BIlTS7KO1nC+ZbNIw2vAO2u/eApC0x+CMgtGQFNQZkF6pCjdcJNKcQZkPi
         oxrJYHNlErvfg+WAicCNlrDm0DYZL3/FfW8dtxa2gC1g5pyn1b3tbw6sg2IMaScQ6+0b
         XJx5ua8cYDG10XpD0expTSjsSVPDz5e3blm/EvSG2A9Wd2xAuXOhkuCVxx43nwFlqFrD
         W9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXLh0mg9TWnNKFJ18mYmipAo9jrOXoE1jiE+62q6qtuwrRmOmM7xXc3tOIp9lafdW4VHBkx+yk/npQKfAfjR9ngZoyoRF6w
X-Gm-Message-State: AOJu0YzL4vFTmjb5NjGWlyS1STXdFLi38taARE0GlKarE2699qi1otS0
	t6Ry61zbyhAnqVGPTwiKY7MKSyVj94p3KFgXsatlupYTWMWVnvRfSYQkd6RU8a2TNNX63pcxU2s
	+qU0C7vmTKnsZuEUN00ZyrQ7hLdTMsgZG9swg
X-Google-Smtp-Source: AGHT+IGH88bGRzRmGYMvaEtOijBDLwy2DcXHxfguG1IJHQZQVV/s4HU+f/MQZ0m5gW2sfU7s4Way4Js/8wph4ququGI=
X-Received: by 2002:a05:6122:8d5:b0:4d4:42c6:b08d with SMTP id
 21-20020a05612208d500b004d442c6b08dmr3821860vkg.5.1714595264090; Wed, 01 May
 2024 13:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501125448.896529-1-edumazet@google.com>
In-Reply-To: <20240501125448.896529-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 1 May 2024 16:27:24 -0400
Message-ID: <CADVnQynaY08aoy-BGHO6ybx6ijUUdzoppxe9gyNpq-tb7z91sQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 8:54=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> TCP_SYN_RECV state is really special, it is only used by
> cross-syn connections, mostly used by fuzzers.
>
> In the following crash [1], syzbot managed to trigger a divide
> by zero in tcp_rcv_space_adjust()
>
> A socket makes the following state transitions,
> without ever calling tcp_init_transfer(),
> meaning tcp_init_buffer_space() is also not called.
>
>          TCP_CLOSE
> connect()
>          TCP_SYN_SENT
>          TCP_SYN_RECV
> shutdown() -> tcp_shutdown(sk, SEND_SHUTDOWN)
>          TCP_FIN_WAIT1
>
> To fix this issue, change tcp_shutdown() to not
> perform a TCP_SYN_RECV -> TCP_FIN_WAIT1 transition,
> which makes no sense anyway.
>
> When tcp_rcv_state_process() later changes socket state
> from TCP_SYN_RECV to TCP_ESTABLISH, then look at
> sk->sk_shutdown to finally enter TCP_FIN_WAIT1 state,
> and send a FIN packet from a sane socket state.
>
> This means tcp_send_fin() can now be called from BH
> context, and must use GFP_ATOMIC allocations.
>
> [1]
> divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 5084 Comm: syz-executor358 Not tainted 6.9.0-rc6-syzkaller-00=
022-g98369dccd2f8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
>  RIP: 0010:tcp_rcv_space_adjust+0x2df/0x890 net/ipv4/tcp_input.c:767
> Code: e3 04 4c 01 eb 48 8b 44 24 38 0f b6 04 10 84 c0 49 89 d5 0f 85 a5 0=
3 00 00 41 8b 8e c8 09 00 00 89 e8 29 c8 48 0f af c3 31 d2 <48> f7 f1 48 8d=
 1c 43 49 8d 96 76 08 00 00 48 89 d0 48 c1 e8 03 48
> RSP: 0018:ffffc900031ef3f0 EFLAGS: 00010246
> RAX: 0c677a10441f8f42 RBX: 000000004fb95e7e RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000027d4b11f R08: ffffffff89e535a4 R09: 1ffffffff25e6ab7
> R10: dffffc0000000000 R11: ffffffff8135e920 R12: ffff88802a9f8d30
> R13: dffffc0000000000 R14: ffff88802a9f8d00 R15: 1ffff1100553f2da
> FS:  00005555775c0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1155bf2304 CR3: 000000002b9f2000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>   tcp_recvmsg_locked+0x106d/0x25a0 net/ipv4/tcp.c:2513
>   tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2578
>   inet6_recvmsg+0x16a/0x730 net/ipv6/af_inet6.c:680
>   sock_recvmsg_nosec net/socket.c:1046 [inline]
>   sock_recvmsg+0x109/0x280 net/socket.c:1068
>   ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
>   ___sys_recvmsg net/socket.c:2845 [inline]
>   do_recvmmsg+0x474/0xae0 net/socket.c:2939
>   __sys_recvmmsg net/socket.c:3018 [inline]
>   __do_sys_recvmmsg net/socket.c:3041 [inline]
>   __se_sys_recvmmsg net/socket.c:3034 [inline]
>   __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7faeb6363db9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcc1997168 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faeb6363db9
> RDX: 0000000000000001 RSI: 0000000020000bc0 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000001c
> R10: 0000000000000122 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Very nice find and fix! Thanks, Eric!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal


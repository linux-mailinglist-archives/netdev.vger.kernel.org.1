Return-Path: <netdev+bounces-14021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D7573E6C1
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0BD280DFC
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73D12B66;
	Mon, 26 Jun 2023 17:45:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004F125D7
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 17:45:53 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40742AF
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:45:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7dfb95761so5086175ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1687801549; x=1690393549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wxP8yyeYIk2ZNfZIneh53T7S8zm2GBIPJFIiPq+r4g=;
        b=ZIcCWq4VSQVOdDfgGsKCQTu22SozuF6iog3qE6qZ+NkgiihL24TskfIj5FxGjvOmjT
         5/B++ny5fZbcqFQzAkm/PyqhFuM0nHED6hO9wTj921baFqyDOArgGLSAdgy/B3YXMmvv
         jpe7Ta5B9yDTjzATwJ+PTv1l7TATK7KucDGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687801549; x=1690393549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wxP8yyeYIk2ZNfZIneh53T7S8zm2GBIPJFIiPq+r4g=;
        b=erwLOTB/ivNyp8TJC5j2quX9UkafIrgnjR7SIL0GGj76gC6A+bD9gyCLP6T/iDmiTV
         MirAi2+hc2w4FU0+Dmt/YcVVSlyfGXS1jyW4GsdKSTnEfHRPulh1ZbyLEBl4lxj3BAg1
         toxCxiT7dx5ncecrbY5SR+ZyEMo67mFF5W1LyMEm8D/U6CCUjRhtxaNaKv87oQp2nrro
         0Chx2x94qjKvE/BYv6v/3QSyg370R+B9hRLps+kw+qfm49biVssv0LOff2yOFssMTvYj
         G15saokaEH6Mn0/s4tt4wCwZarL9fX4SztR1l03cic5nIUCgIIJ2AWI+fhdAyZRlrMnL
         +yNA==
X-Gm-Message-State: AC+VfDx29CRthtr/xXswX7LAsrsIP96BtMr0DfJXd0IeD2ff+DWLRcQB
	6Lipq3uatGQ5yScDU+KJ378a8RDOLMl2iWhGtKbV3A==
X-Google-Smtp-Source: ACHHUZ60zGtailgdM4qMFrC7KHPS9StbmNAG/O2TFNqJCeuARB41t1Cd6/SW/VbSxdTuZMNqHQyTr8SEIhzpkSGo/0U=
X-Received: by 2002:a17:903:1105:b0:1b3:ebda:654e with SMTP id
 n5-20020a170903110500b001b3ebda654emr35027972plh.5.1687801548663; Mon, 26 Jun
 2023 10:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622184351.91544-1-kuniyu@amazon.com> <8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org>
In-Reply-To: <8c7f9abd-4f84-7296-2788-1e130d6304a0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 26 Jun 2023 19:45:37 +0200
Message-ID: <CAJqdLrouNF44h7La8YY7rGqo5aT6GjLr-GxWphaiQVthszk9Gg@mail.gmail.com>
Subject: Re: [PATCH v2] af_unix: Call scm_recv() only after scm_set_cred().
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, Oliver Smith <ollieparanoid@postmarketos.org>, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 7:39=E2=80=AFPM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
>
>
> On 22.06.2023 20:43, Kuniyuki Iwashima wrote:
> > syzkaller hit a WARN_ON_ONCE(!scm->pid) in scm_pidfd_recv().
> >
> > In unix_stream_read_generic(), if there is no skb in the queue, we coul=
d
> > bail out the do-while loop without calling scm_set_cred():
> >
> >   1. No skb in the queue
> >   2. sk is non-blocking
> >        or
> >      shutdown(sk, RCV_SHUTDOWN) is called concurrently
> >        or
> >      peer calls close()
> >
> > If the socket is configured with SO_PASSCRED or SO_PASSPIDFD, scm_recv(=
)
> > would populate cmsg with garbage.
> >
> > Let's not call scm_recv() unless there is skb to receive.
> >
> > WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_pidfd_recv inclu=
de/net/scm.h:138 [inline]
> > WARNING: CPU: 1 PID: 3245 at include/net/scm.h:138 scm_recv.constprop.0=
+0x754/0x850 include/net/scm.h:177
> > Modules linked in:
> > CPU: 1 PID: 3245 Comm: syz-executor.1 Not tainted 6.4.0-rc5-01219-gfa0e=
21fa4443 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:scm_pidfd_recv include/net/scm.h:138 [inline]
> > RIP: 0010:scm_recv.constprop.0+0x754/0x850 include/net/scm.h:177
> > Code: 67 fd e9 55 fd ff ff e8 4a 70 67 fd e9 7f fd ff ff e8 40 70 67 fd=
 e9 3e fb ff ff e8 36 70 67 fd e9 02 fd ff ff e8 8c 3a 20 fd <0f> 0b e9 fe =
fb ff ff e8 50 70 67 fd e9 2e f9 ff ff e8 46 70 67 fd
> > RSP: 0018:ffffc90009af7660 EFLAGS: 00010216
> > RAX: 00000000000000a1 RBX: ffff888041e58a80 RCX: ffffc90003852000
> > RDX: 0000000000040000 RSI: ffffffff842675b4 RDI: 0000000000000007
> > RBP: ffffc90009af7810 R08: 0000000000000007 R09: 0000000000000013
> > R10: 00000000000000f8 R11: 0000000000000001 R12: ffffc90009af7db0
> > R13: 0000000000000000 R14: ffff888041e58a88 R15: 1ffff9200135eecc
> > FS:  00007f6b7113f640(0000) GS:ffff88806cf00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6b7111de38 CR3: 0000000012a6e002 CR4: 0000000000770ee0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  unix_stream_read_generic+0x5fe/0x1f50 net/unix/af_unix.c:2830
> >  unix_stream_recvmsg+0x194/0x1c0 net/unix/af_unix.c:2880
> >  sock_recvmsg_nosec net/socket.c:1019 [inline]
> >  sock_recvmsg+0x188/0x1d0 net/socket.c:1040
> >  ____sys_recvmsg+0x210/0x610 net/socket.c:2712
> >  ___sys_recvmsg+0xff/0x190 net/socket.c:2754
> >  do_recvmmsg+0x25d/0x6c0 net/socket.c:2848
> >  __sys_recvmmsg net/socket.c:2927 [inline]
> >  __do_sys_recvmmsg net/socket.c:2950 [inline]
> >  __se_sys_recvmmsg net/socket.c:2943 [inline]
> >  __x64_sys_recvmmsg+0x224/0x290 net/socket.c:2943
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > RIP: 0033:0x7f6b71da2e5d
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
> > RSP: 002b:00007f6b7113ecc8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> > RAX: ffffffffffffffda RBX: 00000000004bc050 RCX: 00007f6b71da2e5d
> > RDX: 0000000000000007 RSI: 0000000020006600 RDI: 000000000000000b
> > RBP: 00000000004bc050 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000120 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000006e R14: 00007f6b71e03530 R15: 0000000000000000
> >  </TASK>
> >
> > Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Reviewed-by: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> > ---
> Hi, for $some_reason, this breaks reaching DE on the following setup:
>
> - postmarketOS (Alpine Linux w/ musl 1.2.4)
> - busybox 1.36.1
> - GNOME 44.1
> - networkmanager 1.42.6
> - openrc 0.47
>
> on at least 2 different Qualcomm boards.
>
> #regzbot introduced: 3f5f118bb657f94641ea383c7c1b8c09a5d46ea2
>
> Konrad

I can confirm. Right now I'm working on another patch for net-next and
this patch makes systemd-logind.service fail to start
in my test VM.

Kuniyuki, please let me know if you need any help with debugging this.
Probably we need to step on more conservative
approach that was originally proposed here
https://lore.kernel.org/netdev/CAJqdLrrmZGNE3NQ99_+rUkUMAWmWRo04VRhjdzGKBO3=
zmRmpjg@mail.gmail.com/

Kind regards,
Alex

> > v2:
> >   * Target to net-next (v1 was marked as ChangesRequested maybe
> >     due to one of the blamed commits is not in net.git)
> >
> >   * Update changelog to clarify skb is not in the queue
> >
> > v1: https://lore.kernel.org/netdev/20230620000009.9675-1-kuniyu@amazon.=
com/
> > ---
> >  net/unix/af_unix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 73c61a010b01..f9d196439b49 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2826,7 +2826,7 @@ static int unix_stream_read_generic(struct unix_s=
tream_read_state *state,
> >       } while (size);
> >
> >       mutex_unlock(&u->iolock);
> > -     if (state->msg)
> > +     if (state->msg && check_creds)
> >               scm_recv(sock, state->msg, &scm, flags);
> >       else
> >               scm_destroy(&scm);


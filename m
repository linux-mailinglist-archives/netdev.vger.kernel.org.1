Return-Path: <netdev+bounces-112739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7193AF13
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 11:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848F01F21C0F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5F140384;
	Wed, 24 Jul 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFxckAfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40613DDC2
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813544; cv=none; b=fLus1WVaL23UXdOFSLb8Ye8umq8P3dPdTGuKlzEVcP1Mi4GA/EBlg4Bj/+jdSaymBkRNLcNN+x8HA8ud+KaOenFTjdcUL9suHS+EU3YIvXEi0ciYj5zNG1yHpkSr+N9t5SmQ6LSFwTltBNQqBZPyi3LnCfEV9f/1ITja3C+NtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813544; c=relaxed/simple;
	bh=nbsttEFZRsajJTkfGh6KfS5gXlGA+1DIOgYIXOANRo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPzcsmvzWquMbhCZX2wCJaldxU890WQ9pwtWQ68P3UG0pd7M4lt6ud5ZrkYYorI6GPIlxCWrjQ1OUU6LiuR53GiWKR6Oejfdhmsrg0fHmPP/6ZmOD2jp2XnMSLShnKqpnSBFIOsVm6KX4xKBY6Dor2PK5Qx05lRCvf6RLIqizMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFxckAfk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so11137a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721813540; x=1722418340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upqSRJL6PhaSVhA69v+8gb6wWAdwrft2WQymdhF4HJ4=;
        b=MFxckAfkYz7eEKNui9XTjvgGv0rphTupbPUNM66ZSf+neC6g8GYRAFlEj2zVtvDA7d
         wcX2q4W+oiW8bmk5mx5uI5B53mFdPLg8JQNxjh5Ew2CCrCfCZjI9xQJv5ED5fBCaI80y
         EKwsHSRedw3TzscAJ/fA2MiFOrljlK/lNWE0KuBuH3fqeIuqreAIBwzeF3HLu/y/QAtn
         mc3DTIpPkl6GA6JNGyDK67BeXrDvOWIof93tw0wJUugrPh105YfY5fN2Y7rZHOXbxUVh
         mhl8UbYg47ttDWrAh4YRwQjDbHmZgGfh7i+VhdHwqR8hY0O+K/y4E5FQKK2kT/0G5mTQ
         bcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721813540; x=1722418340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upqSRJL6PhaSVhA69v+8gb6wWAdwrft2WQymdhF4HJ4=;
        b=Et6rtYZEuxMq02q/vfH/c8FnJEzZpmrB/jGMHlInEtx77Ehx+1N932DTocFOSX54Fv
         g9CbuYL/5VgumxfQ8eB/SvvsFAEZVN0iz8DnBFMBRuVL6TF53zX9N65uxEzswiP0gUAN
         rvUBbMzB4KfUSBAC4TIN7m4QlkanSi+XDEWhZtESJCQuFsoblxuB1F6ukk1dDDPULUqS
         AygdgXtedsOuCaEto4APoRuFEVhtO1Ut+O0rO2ZThvmfTRmb/k56YbHyZn+OSpNXFm8o
         GONzunrM5I5tOm9ifPS0pfH3HGiS1STxyP8aPzmIwPfSVOn1OesSRoaYispi2rtPtI4g
         QGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXIl2dfDRkYFgDOx8CbfScZFTicuORFOuWZ/jR7yqqci+S+q4cvR0KxlfmrQUJt+VXGPYz5IoVPceYgLwgbWCVkvMrVM2Zt
X-Gm-Message-State: AOJu0YyjTjkl28PRJp2zTeGzVIGsSYnGlmXJtVb7zhmS0xJXqPg0lsvN
	s4YeFUlOubfrY7QOrwd5zA2uxafLtadDTQJE/qMW6/pcvhAKMOeN8r6glJudSf/ROm9I8P/gKWG
	B2U7aSQVfIWTHdIUxNIi7GYeQHLn1SYZ+uIaD
X-Google-Smtp-Source: AGHT+IEboy0HtbdQLpjDGg/4fcI9/d2dAvwr2Wj57yxcB4XIPZP8q3PVzpK+mhByNJR3/7fBPEyUr4hkU4hFREWoeaQ=
X-Received: by 2002:a05:6402:270e:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5aacbfa0c33mr251536a12.5.1721813540101; Wed, 24 Jul 2024
 02:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723175809.537291-1-edumazet@google.com> <7250f49f-bfc0-4d7e-8de8-0468ff600a75@linux.alibaba.com>
In-Reply-To: <7250f49f-bfc0-4d7e-8de8-0468ff600a75@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 11:32:08 +0200
Message-ID: <CANn89iJXx_CG04cTaQE6ROAhvqpUOGHDQXbLc_pEY7PDiXVgxg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Dust Li <dust.li@linux.alibaba.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 4:30=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 7/24/24 1:58 AM, Eric Dumazet wrote:
> > Following syzbot repro crashes the kernel:
> >
> > socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
> >
> > Fix this by not calling sk_common_release() from smc_create_clcsk().
> >
> > Stack trace:
> > socket: no more sockets
> > ------------[ cut here ]------------
> > refcount_t: underflow; use-after-free.
> >   WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28 refcount_warn_saturate=
+0x15a/0x1d0 lib/refcount.c:28
> > Modules linked in:
> > CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted 6.10.0-syzkaller-044=
83-g0be9ae5486cd #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/27/2024
> >   RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> > Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6=
 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90 90 =
e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
> > RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
> > RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
> > R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
> > R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
> > FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   inet_create+0xbaf/0xe70
> >    __sock_create+0x490/0x920 net/socket.c:1571
> >    sock_create net/socket.c:1622 [inline]
> >    __sys_socketpair+0x2ca/0x720 net/socket.c:1769
> >    __do_sys_socketpair net/socket.c:1822 [inline]
> >    __se_sys_socketpair net/socket.c:1819 [inline]
> >    __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
> >    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fbcb9259669
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
> > RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
> > RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
> > RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
> > R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
> > R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
> >   </TASK>
>
> Oops, that's my bad, I forgot the differences in failure handling
> between smc_create and inet_create,
> thanks for your fix.
>
> >
> > Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: D. Wythe <alibuda@linux.alibaba.com>
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: Dust Li <dust.li@linux.alibaba.com>
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   net/smc/af_smc.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 73a875573e7ad5b7a95f7941e33f0d784a91d16d..31b5d8c8c34085b73b011c9=
13cfe032f025cd2e0 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -3319,10 +3319,8 @@ int smc_create_clcsk(struct net *net, struct soc=
k *sk, int family)
> >
> >       rc =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
> >                             &smc->clcsock);
> > -     if (rc) {
> > -             sk_common_release(sk);
> > +     if (rc)
> >               return rc;
> > -     }
>
> Since __smc_create (for AF_SMC) does not call sk_common_release on failur=
e,
> I think it should be moved to __smc_create instead of beingdeleted.

Please provide an updated and tested patch, thanks.


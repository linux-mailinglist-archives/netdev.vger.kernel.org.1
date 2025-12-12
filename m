Return-Path: <netdev+bounces-244511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9ECB9414
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 837C730076A0
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A287293B5F;
	Fri, 12 Dec 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oxQ98gTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E9274FD3
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556797; cv=none; b=lRnJbW8KzJFpuIrF+/oqr55qgrmUfgOXrXpcFWN0UPeXysJQQIlxyuGGi1BN0fwC5jo4te8nzWQVPDuKAmcIxz3vGS/fQxHNg+i6nCJsXD/sEBNGQvkIzdHAEH7+0W3mnM62vWvQj++x/QFyiEta/CfTAmG/BNMO7zzSG5uty58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556797; c=relaxed/simple;
	bh=mWZ66NIH1czvwOY8VhKo1zGPjmO675aRWP8Xq0BdjAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScqVP5rkPPEv8XHogRCKjN80APFbpU1IuFsUE3+eEttc9zwa0PZGg0QDk9/kmP2TmC9iJTXizIDocaw5muYrtt5UVSjCdczyNsB2gs9EpzzkP/KP5EGtTfSad9iaYX4sphMlYyeSDS3DSbltfxIlX88xOt9ZGkKZ8w9yLcI33aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oxQ98gTz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297ec50477aso6075715ad.1
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765556795; x=1766161595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDAxQ1Ir8FP4xWW6w5X333ka+DlpMoQla6BYdhqIoH4=;
        b=oxQ98gTzJhQPCpBG7X+lpij+z28yEwRNoYaB7nNdOxem/OgINPVgzRk38jNHLi+t/0
         L8mLInQrjUE2FRxgVFZ7y+a6BYHPu+TgG3kwj2C0cFmY5dd1SXkMs5zcZnaDa+iTm5ka
         2SwcI62xsT3v1tqQ1uOqBscUHrBUnVHQca9XxkEqXbEPFVPUTFKMebNwaPr7I22I/1x+
         JnJN2GP+VeSM2G6IC8y6Ao+tTFVH79XdJe62Utpn9ZKUNBor/XwHU0DqE2WtCAjYB7PP
         ev/He9pmaCadYjhFQiSVnlxq6/fddRsxCnwrfLWMyfssWKLkC+px0ick3ISihXwF7umt
         mAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765556795; x=1766161595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDAxQ1Ir8FP4xWW6w5X333ka+DlpMoQla6BYdhqIoH4=;
        b=YliNC2bvP2u7kO5zn+FMvRPLtSmPSKzEGBrUfwaaIbqVIT1LRsZMMJtuTaa01Q9X7G
         pOIeFW4h2CoPwcrxjTNa5wGrs3U9i1MYP5DlV7EMYKDHls5GrPSmu5R10ggIWKooDHcU
         ZqQZ7qIfDJubbPOlyEiYlm5qnqn4FSh9E8MIjURlSxNAm3GPNiCkUl7UlPcHK4W1jQHv
         yRJap36VmGDXjZVwdqBFAPYoW3Tfy/eGTEto8VsviYlBU8treK4jwgiFxlHS+gxdirNT
         PP3sz0ceZUBlXn9Zf1az8NvcaHxgpjznnqSxCR5jWgR3H3k7DD//d45G/I3VF/yXkY9w
         CyKg==
X-Forwarded-Encrypted: i=1; AJvYcCX4VrjokqbP1UPROAGVYB0N4iLuybKgGguyh082rABIOxPyGVqnuc2yAScMAGtKz42F8JD0c9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyK96ebeVS9Ckt/w2v4qjOSA1YZZ8KK+qf7trEAYBDICUrUHDP
	Dvepk3FflRGOqrkz5RMxOuLOAvIk10noSU0bFyRE0tEofl05XEFNQjQUWgWYe4MdSHBZzY6ALc9
	I5qpX0tsiWRCS6PXEfeBuNXF/XL4L6ae5rac8LGvQ7vmWswqu5T8ToQ==
X-Gm-Gg: AY/fxX6OztJztZbbFsGVTOpmGKZPuGyefJrfDFheCW7TFuJWz4h2p191iRngxL0JSZc
	Fj7gKq2yUZ8kj1tnP5zZ45tTx8oShmEhw1GhZ6i6dy1f116FRn2219azNB780T0jL6f6IwWBriW
	5OdL6iz1A2UfoiAM4Xm0EjH7jefzySWeWbBBSWq7I0sTno6/VXnhqT3zyNt61wFnFabB6v/fQbm
	6ToL6UnXTOMiyPQkhMNb1yAdu5My8rO0XO9SpXzRI3yCrd14Gp6j0dC0TpuC8iGCsOl/zg+VNMo
	PhtHu3TngVvyNA==
X-Google-Smtp-Source: AGHT+IFiVGCM1mGrWhTz/en2jvkO+HvQ5tCflwK6dMKJcSCjAuD+CqVERmPVkZ9EUG1Il5KosbAEHBHGm9V9l4Kj18I=
X-Received: by 2002:a17:903:4b28:b0:29e:d5ad:4e98 with SMTP id
 d9443c01a7336-29f24d952admr30180795ad.13.1765556794831; Fri, 12 Dec 2025
 08:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
In-Reply-To: <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Dec 2025 11:26:23 -0500
X-Gm-Features: AQt7F2ryRQOpM-Vb3oy4D-V5K1TIH0cXeA2qQazjeW7Q3ZLIFKmYG99dKaOvEN0
Message-ID: <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, linux-rt-devel@lists.linux.dev, 
	edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com, 
	horms@kernel.org, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> >
> > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> >
> > In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> > designatied initializer. While the padding bytes are reamined
> > uninitialized. nla_put() copies the entire structure into a
> > netlink message, these uninitialized bytes leaked to userspace.
> >
> > Initialize the structure with memset before assigning its fields
> > to ensure all members and padding are cleared prior to beign copied.
> >
> > This change silences the KMSAN report and prevents potential informatio=
n
> > leaks from the kernel memory.
> >
> > This fix has been tested and validated by syzbot. This patch closes the
> > bug reported at the following syzkaller link and ensures no infoleak.
> >
> > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > Fixes: ef6980b6becb ("introduce IFE action")
> > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > ---
> >  net/sched/act_ife.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > index 107c6d83dc5c..7c6975632fc2 100644
> > --- a/net/sched/act_ife.c
> > +++ b/net/sched/act_ife.c
> > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, stru=
ct tc_action *a, int bind,
> >       unsigned char *b =3D skb_tail_pointer(skb);
> >       struct tcf_ife_info *ife =3D to_ife(a);
> >       struct tcf_ife_params *p;
> > -     struct tc_ife opt =3D {
> > -             .index =3D ife->tcf_index,
> > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > -     };
> > +     struct tc_ife opt;
> >       struct tcf_t t;
> >
> > +     memset(&opt, 0, sizeof(opt));
> > +
> > +     opt.index =3D ife->tcf_index,
> > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
>
> Are you sure this is correct to delimit with commas instead of
> semicolons?
>
> This already causes build failures of 5.10.247-rt141 kernel, because
> their spin_lock_bh unrolls into do { .. } while (0):
>

Do you have access to this?
commit 205305c028ad986d0649b8b100bab6032dcd1bb5
Author: Chen Ni <nichen@iscas.ac.cn>
Date:   Wed Nov 12 15:27:09 2025 +0800

    net/sched: act_ife: convert comma to semicolon

cheers,
jamal

>      CC [M]  net/sched/act_ife.o
>    In file included from ./include/linux/spinlock.h:329,
>                     from ./include/linux/mmzone.h:8,
>                     from ./include/linux/gfp.h:6,
>                     from ./include/linux/mm.h:10,
>                     from ./include/linux/bvec.h:14,
>                     from ./include/linux/skbuff.h:17,
>                     from net/sched/act_ife.c:20:
>    net/sched/act_ife.c: In function 'tcf_ife_dump':
>    ./include/linux/spinlock_rt.h:44:2: error: expected expression before =
'do'
>       44 |  do {     \
>          |  ^~
>    net/sched/act_ife.c:655:2: note: in expansion of macro 'spin_lock_bh'
>      655 |  spin_lock_bh(&ife->tcf_lock);
>          |  ^~~~~~~~~~~~
>    make[2]: *** [scripts/Makefile.build:286: net/sched/act_ife.o] Error 1
>    make[2]: *** Waiting for unfinished jobs....
>
>
> Thanks,
>
> > +
> >       spin_lock_bh(&ife->tcf_lock);
> >       opt.action =3D ife->tcf_action;
> >       p =3D rcu_dereference_protected(ife->params,
> > --
> > 2.43.0
> >


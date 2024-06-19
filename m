Return-Path: <netdev+bounces-104874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE590EC97
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B042E282C24
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABC1474AD;
	Wed, 19 Jun 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dMDtwO8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B013D525
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802539; cv=none; b=b8bH2ZDc0aPrRIhGRORaHMLreHGBSOgDun/qTpqUZRljT1OTSxA+a2zCRRHExzaweAzoQukKASmSfw45tGTatHKMoRrfk6Vy5PUem6l+oBWHol8oFaavp+JjziHPKrk3vSOaDclshcbSjaC2Frl/fITTTISCJoVzf2M50DYZ4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802539; c=relaxed/simple;
	bh=5/ZgA8zhLrdVDYchq6/Y99NUFdbXaCiUTPCiwdCmYYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQDBy6O1hlv3Qii4cZ8I1L8ZRYDvLgOjIu0phO6h/luRTBBxZKk8ycTmdhRQk5VxBf9HSAlJCB7rTaW4WUGK3RqXh8ALi1vurxbbn5WW6T2dsype2gqqVPu6V8DzqZg6+XBM/HlTkjlpKgs67gVffpb+nghHr8nzLt2Qni1pij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dMDtwO8D; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so5122756a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718802536; x=1719407336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7QBxRjX6bK4nfQFtvwlMhqO1YN0X8hSMyp1M5GJNSs=;
        b=dMDtwO8D4rRZpxE+ZilOMCvkuFWoxd4wuZH1TLWWmsHrWGhQiBLL7pgZmlMF/Hi/ix
         jKXx+NGuNJGTgB0PnFO4OS1MW2wVJLbg4P+GVA8wW/ZL42ziX5fyceoEQByaKOrniZUx
         TGY1olKRSVSqDlAAm4qcGWj9e7CKNC9oq5TwBioL144/cr6k7ylufN5VVkD+fIEBLwyp
         jp2U6x6sUfG+QOiYrYHANmG0r2bt76P6rHSPgm3pXXeGsuJ5ntgP77/p6e1oMNCMHH6I
         cDqOmX3E4B3A+ckxF0Rb6qJQUgiQGibpDMT+Oi+572A0MYDetADXmFuV1rBW96QlcE/x
         15jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802536; x=1719407336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7QBxRjX6bK4nfQFtvwlMhqO1YN0X8hSMyp1M5GJNSs=;
        b=hLpfpSWi/laWsLymvNe/TfRiwMOczrHDRnLMLq36HYgB7uA4c832TYisw7Ac8EDgdo
         WbOZDIltxeDOyE4GOz2Gr6xXI5HTXKTUj3CxrQQX6lXuHQrqATQPqZza6bXmMp+vx4q0
         ghyWOXirgiFBh2vebBRzMwV0WhiKmvA6k+T4Napif4LyTGPPdOPXk+FZn4nVFeF7c4EX
         ip7QNhZitrOmPsFEm+icNLPf136Ef9FRwim7G7xPeHMXow4XaNOIKpA1rUTYnqdYvtJY
         9sOyZyUYEIksX3xLpzdb9/MgIwNz0DYVieLQFSwzTSbTLQZ9okWIWbVQL2ohCtX2Z18f
         uS0A==
X-Forwarded-Encrypted: i=1; AJvYcCUmoy40GRDhzG4HGUveL5SXRNhQ959Ld2I5tUmC3HDAdNxqQH2mazqF0AO0vjfoV5t5AzvDRdWeHMZG9mGPHIMnI4cCsxW6
X-Gm-Message-State: AOJu0YwHyoRiFSZfl3x/K8qdylL69MDD6qoSHVGKge13ZSp3rO2/JzEf
	oj2x47YEA4NjZYpeJvnWYiLO8y36vFQB4YkaTkZXkn1P32zoQpNqeOmO4lnLGQnf22wKIANkJGT
	VKCRxXokPwf2K3NEX+TwsP5Yl5VVQc5gm272qUg==
X-Google-Smtp-Source: AGHT+IE0FPXNumij9mjrz3O1ImHZTXZjz3dyjeywqSnPUCIu/Ng38CP6z8Kvps/xrN0z7q87QtndEIlgt/vVLUqsO7E=
X-Received: by 2002:a17:90a:f0d4:b0:2c2:fa5e:106a with SMTP id
 98e67ed59e1d1-2c7b5db2a3fmr2356670a91.48.1718802536199; Wed, 19 Jun 2024
 06:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617210205.67311-1-ignat@cloudflare.com> <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
In-Reply-To: <c9446790-9bac-4541-919b-0af396349c59@linux.alibaba.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 19 Jun 2024 14:08:45 +0100
Message-ID: <CALrw=nGSf49VnRVy--b5qSM7_rSRyDBUFe_t8taFs2tmRP2QTw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: do not leave a dangling sk pointer, when
 socket creation fails
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florent Revest <revest@chromium.org>, kernel-team@cloudflare.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:31=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 6/18/24 5:02 AM, Ignat Korchagin wrote:
> > It is possible to trigger a use-after-free by:
> >    * attaching an fentry probe to __sock_release() and the probe callin=
g the
> >      bpf_get_socket_cookie() helper
> >    * running traceroute -I 1.1.1.1 on a freshly booted VM
> >
> > A KASAN enabled kernel will log something like below (decoded and strip=
ped):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in __sock_gen_cookie (./arch/x86/includ=
e/asm/atomic64_64.h:15 ./include/linux/atomic/atomic-arch-fallback.h:2583 .=
/include/linux/atomic/atomic-instrumented.h:1611 net/core/sock_diag.c:29)
> > Read of size 8 at addr ffff888007110dd8 by task traceroute/299
> >
> > CPU: 2 PID: 299 Comm: traceroute Tainted: G            E      6.10.0-rc=
2+ #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debi=
an-1.16.2-1 04/01/2014
> > Call Trace:
> >   <TASK>
> > dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
> > print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
> > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/=
linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-inst=
rumented.h:1611 net/core/sock_diag.c:29)
> > kasan_report (mm/kasan/report.c:603)
> > ? __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/=
linux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-inst=
rumented.h:1611 net/core/sock_diag.c:29)
> > kasan_check_range (mm/kasan/generic.c:183 mm/kasan/generic.c:189)
> > __sock_gen_cookie (./arch/x86/include/asm/atomic64_64.h:15 ./include/li=
nux/atomic/atomic-arch-fallback.h:2583 ./include/linux/atomic/atomic-instru=
mented.h:1611 net/core/sock_diag.c:29)
> > bpf_get_socket_ptr_cookie (./arch/x86/include/asm/preempt.h:94 ./includ=
e/linux/sock_diag.h:42 net/core/filter.c:5094 net/core/filter.c:5092)
> > bpf_prog_875642cf11f1d139___sock_release+0x6e/0x8e
> > bpf_trampoline_6442506592+0x47/0xaf
> > __sock_release (net/socket.c:652)
> > __sock_create (net/socket.c:1601)
> > ...
> > Allocated by task 299 on cpu 2 at 78.328492s:
> > kasan_save_stack (mm/kasan/common.c:48)
> > kasan_save_track (mm/kasan/common.c:68)
> > __kasan_slab_alloc (mm/kasan/common.c:312 mm/kasan/common.c:338)
> > kmem_cache_alloc_noprof (mm/slub.c:3941 mm/slub.c:4000 mm/slub.c:4007)
> > sk_prot_alloc (net/core/sock.c:2075)
> > sk_alloc (net/core/sock.c:2134)
> > inet_create (net/ipv4/af_inet.c:327 net/ipv4/af_inet.c:252)
> > __sock_create (net/socket.c:1572)
> > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > __x64_sys_socket (net/socket.c:1718)
> > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >
> > Freed by task 299 on cpu 2 at 78.328502s:
> > kasan_save_stack (mm/kasan/common.c:48)
> > kasan_save_track (mm/kasan/common.c:68)
> > kasan_save_free_info (mm/kasan/generic.c:582)
> > poison_slab_object (mm/kasan/common.c:242)
> > __kasan_slab_free (mm/kasan/common.c:256)
> > kmem_cache_free (mm/slub.c:4437 mm/slub.c:4511)
> > __sk_destruct (net/core/sock.c:2117 net/core/sock.c:2208)
> > inet_create (net/ipv4/af_inet.c:397 net/ipv4/af_inet.c:252)
> > __sock_create (net/socket.c:1572)
> > __sys_socket (net/socket.c:1660 net/socket.c:1644 net/socket.c:1706)
> > __x64_sys_socket (net/socket.c:1718)
> > do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >
> > Fix this by clearing the struct socket reference in sk_common_release()=
 to cover
> > all protocol families create functions, which may already attached the
> > reference to the sk object with sock_init_data().
> >
> > Fixes: c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie to tracing prog=
rams")
> > Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/netdev/20240613194047.36478-1-kuniyu@amaz=
on.com/T/
> > ---
> > Changes in v3:
> >    * re-added KASAN repro steps to the commit message (somehow stripped=
 in v2)
> >    * stripped timestamps and thread id from the KASAN splat
> >    * removed comment from the code (commit message should be enough)
> >
> > Changes in v2:
> >    * moved the NULL-ing of the socket reference to sk_common_release() =
(as
> >      suggested by Kuniyuki Iwashima)
> >    * trimmed down the KASAN report in the commit message to show only r=
elevant
> >      info
> >
> >   net/core/sock.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 8629f9aecf91..100e975073ca 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -3742,6 +3742,9 @@ void sk_common_release(struct sock *sk)
> >
> >       sk->sk_prot->unhash(sk);
> >
> > +     if (sk->sk_socket)
> > +             sk->sk_socket->sk =3D NULL;
> > +
> >       /*
> >        * In this point socket cannot receive new packets, but it is pos=
sible
> >        * that some packets are in flight because some CPU runs receiver=
 and
>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>
>
> A small tip:
>
> It seems that you might have missed CCing some maintainers, using
> scripts/get_maintainer.pl "Your patch" can help you avoid this issue
> again.

Thanks. I did scripts/get_maintainer.pl <file I'm modifying>. Not sure
if it is different.

>
> D. Wythe
>
>
>


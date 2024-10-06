Return-Path: <netdev+bounces-132526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9AD992040
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934DA2819E6
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140E188721;
	Sun,  6 Oct 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWWwjQJE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BE231C8F;
	Sun,  6 Oct 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728238113; cv=none; b=kFjGod6Imbcu5EBWhVWlDDRXEIDAbebMNn9mY2upy++gXi3sGS0U5U9MW9y0JGKv2dUY6PMBXXUw+TFjlQsoNX2PCrNgCrdHeKfX2EHNUH7xr4HsD6FiDbybdq2EJPCLrpwuNWdYqqY0vk74ZVZiKUtFJKbx6AfcikN+pdIA0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728238113; c=relaxed/simple;
	bh=53UXy/Wsy/eyqwbSMkAX2y/6Vq1AggnjXk27VDMT6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkNo6UdsxwGo0UfqH49zpdgUkWIQ+QER2ZE5HJ6wInyVgvoICZmD4wHWMpNBd7NMFtXKuyQRG+Rr/id8TSDZtpRuFSDv/t8c1coYsnju71qKmpuexFDPQU72n0zsi0/7ul8grJVsBPYdXLf+ROEQjCvH5TV9HTq8up8D5C54wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWWwjQJE; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso146222839f.2;
        Sun, 06 Oct 2024 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728238110; x=1728842910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHLPIDyBDIX39Aq+JISksp/l8tDJ6o6m4AiXyw+2AvM=;
        b=EWWwjQJE6ValLgnQoVoYTY3xP16AtbX+6vfYY7VKh50EValsf651QLubSBLJDXmPpP
         HDOlMrhP9yEkz4VdIyf+yJ9r5WyzQbKjTqCOT08ARWqE/WRwlTETL/BvnlBJ1jeIRfv9
         DpyhQu0uezIDKH8k6xX/jJB0nB+ECLBt/NyfhL86i6ICYThh6JBf8Iupdlu7FybUu0Mt
         NQ5nDmeHGtWaE/EAO10olNFxela9ebR3mixoFeBUyuraw2EaecPz4g8LoT4egl9qEP7T
         VgO+SDLCPTb5CfJ9xwqzrfmqorktaGd34Rs1XeCdGBe1073WmgYcxNgknkUGPuElJdzf
         fxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728238110; x=1728842910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHLPIDyBDIX39Aq+JISksp/l8tDJ6o6m4AiXyw+2AvM=;
        b=Fy5mCUQYWBB1jKarRfobW1W1ACETmakBubLX8wTpvToL6hcZyyZc2mXvZbgWOfWTK0
         BZffsK31EDDu+3coNDZ1plre0XQT8O4Ro5oqYboDEPwJt9TiZyBVDKmvkf4Jk+KdA4yT
         5ru5U+EtDPROPC3s0HIUWVvQWXPmZb/WRuq6cF4h1hV12Wg8AMY6E7Zf3HuSpzVtzk+/
         DopBbWs5R0aSppH30TLHWqOYNxXwNXQUmCzOafrkdlVPgv93ByOHUttZM0XAbsmDgLBY
         OX+fBayWdhn6nVLfM41PEnZy0QeESrUWLHOZKXNFVfTcng2+fNOWduWohlShW8MLklCe
         fYiA==
X-Forwarded-Encrypted: i=1; AJvYcCUy1NNWcknX3TmgMn/LGKd3sB20MnoEJwe+ISm4eKlChtRg//1RNAqOXXntI1OuYTNoAigw7R5r@vger.kernel.org, AJvYcCVwAGzAug0q4eIEPl1a/7Q7N5TI1j2MHHIlRl56s4H3Ud1YgWGHZKnk1FCgLqJmGHehrIWwX6H5MpwyZd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYX1l93BofC8lOJ6u/v80MbR3lP4KznwHsRsfeTK3n6FOrceSD
	1CvhNFFbXFPMa8h81A4iQQb/kk060C2nirAEznWGXjD9qlV5IB+ItpT0MFnriS8AL+v6guiz6v/
	FoluG7GX3yuOXeFuWeTMz0MFzjkA=
X-Google-Smtp-Source: AGHT+IGX1UYk4wYIvHCMG7eKXLatbNc2dkda3EX/V7iuBSseYuLMr1CrzOQVYuDrwi3e+IiuEHI3BoXJdZ0juOSDjKA=
X-Received: by 2002:a05:6e02:1fc8:b0:3a3:44b2:acb2 with SMTP id
 e9e14a558f8ab-3a375be2a9dmr77777265ab.25.1728238110043; Sun, 06 Oct 2024
 11:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830112600.4483-1-hdanton@sina.com> <f607a7d5-8075-f321-e3c0-963993433b14@I-love.SAKURA.ne.jp>
 <20230831114108.4744-1-hdanton@sina.com> <CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com>
 <20230903005334.5356-1-hdanton@sina.com> <CANn89iJj_VR0L7g3-0=aZpKbXfVo7=BG0tsb8rhiTBc4zi_EtQ@mail.gmail.com>
 <20230905111059.5618-1-hdanton@sina.com> <CANn89iKvoLUy=TMxW124tiixhOBL+SsV2jcmYhH8MFh3O75mow@mail.gmail.com>
 <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
In-Reply-To: <CA+G9fYvskJfx3=h4oCTAyxDWO1-aG7S0hAxSk4Jm+xSx=P1dhA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 6 Oct 2024 14:08:18 -0400
Message-ID: <CADvbK_fxXdNiyJ3j0H+KHgMF11iOGhnjtYFy6R18NyBX9wB4Kw@mail.gmail.com>
Subject: Re: selftests: net: pmtu.sh: Unable to handle kernel paging request
 at virtual address
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Eric Dumazet <edumazet@google.com>, Hillf Danton <hdanton@sina.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Netdev <netdev@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for bringing up this issue, it recently occurred on my aarch64 kernel
with blackhole_netdev backported. I tracked it down, and when deleting
the netns, the path is:

In cleanup_net():

  default_device_exit_batch()
    unregister_netdevice_many()
      addrconf_ifdown() -> call_rcu(rcu, fib6_info_destroy_rcu) <--- [1]
    netdev_run_todo()
      rcu_barrier() <- [2]
  ip6_route_net_exit() -> dst_entries_destroy(net->ip6_dst_ops) <--- [3]

In fib6_info_destroy_rcu():

  dst_dev_put()
  dst_release() -> call_rcu(rcu, dst_destroy_rcu) <--- [5]

In dst_destroy_rcu():
  dst_destroy() -> dst_entries_add(dst->ops, -1); <--- [6]

fib6_info_destroy_rcu() is scheduled at [1], rcu_barrier() will wait
for fib6_info_destroy_rcu() to be done at [2]. However, another callback
dst_destroy_rcu() is scheduled() in fib6_info_destroy_rcu() at [5], and
there's no place calling rcu_barrier() to wait for dst_destroy_rcu() to
be done. It means dst_entries_add() at [6] might be run later than
dst_entries_destroy() at [3], then this UAF will trigger the panic.

On Tue, Oct 17, 2023 at 1:02=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Tue, 5 Sept 2023 at 17:55, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Sep 5, 2023 at 1:52=E2=80=AFPM Hillf Danton <hdanton@sina.com> =
wrote:
> > >
> > > On Mon, 4 Sep 2023 13:29:57 +0200 Eric Dumazet <edumazet@google.com>
> > > > On Sun, Sep 3, 2023 at 5:57=3DE2=3D80=3DAFAM Hillf Danton <hdanton@=
sina.com>
> > > > > On Thu, 31 Aug 2023 15:12:30 +0200 Eric Dumazet <edumazet@google.=
com>
> > > > > > --- a/net/core/dst.c
> > > > > > +++ b/net/core/dst.c
> > > > > > @@ -163,8 +163,13 @@ EXPORT_SYMBOL(dst_dev_put);
> > > > > >
> > > > > >  void dst_release(struct dst_entry *dst)
> > > > > >  {
> > > > > > -       if (dst && rcuref_put(&dst->__rcuref))
> > > > > > +       if (dst && rcuref_put(&dst->__rcuref)) {
> > > > > > +               if (!(dst->flags & DST_NOCOUNT)) {
> > > > > > +                       dst->flags |=3D DST_NOCOUNT;
> > > > > > +                       dst_entries_add(dst->ops, -1);
> > > > >
So I think it makes sense to NOT call dst_entries_add() in the path
dst_destroy_rcu() -> dst_destroy(), as it does on the patch above,
but I don't see it get posted.

Hi, Eric, would you like to move forward with your patch above ?

Or we can also move the dst_entries_add(dst->ops, -1) from dst_destroy()
to dst_release():

Note, dst_destroy() is not used outside net/core/dst.c, we may delete
EXPORT_SYMBOL(dst_destroy) in the future.

Thanks.

> > > > > Could this add happen after the rcu sync above?
> > > > >
> > > > I do not think so. All dst_release() should happen before netns rem=
oval.
> > >
> > >         cpu2                    cpu3
> > >         =3D=3D=3D=3D                    =3D=3D=3D=3D
> > >         cleanup_net()           __sys_sendto
> > >                                 sock_sendmsg()
> > >                                 udpv6_sendmsg()
> > >         synchronize_rcu();
> > >                                 dst_release()
> > >
> > > Could this one be an exception?
> >
> > No idea what you are trying to say.
> >
> > Please give exact locations, instead of being rather vague.
> >
> > Note that an UDP socket can not send a packet while its netns is disman=
tled,
> > because alive sockets keep a reference on the netns.
>
> Gentle reminder.
> This is still an open issue.
>
> # selftests: net: pmtu.sh
> # TEST: ipv4: PMTU exceptions                                         [ O=
K ]
> # TEST: ipv4: PMTU exceptions - nexthop objects                       [ O=
K ]
> # TEST: ipv6: PMTU exceptions                                         [ O=
K ]
> # TEST: ipv6: PMTU exceptions - nexthop objects                       [ O=
K ]
> # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ O=
K ]
> # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions - nexthop objects   [ O=
K ]
> # TEST: UDPv4 with DSCP and ECN: PMTU exceptions                      [ O=
K ]
> # TEST: UDPv4 with DSCP and ECN: PMTU exceptions - nexthop objects    [ O=
K ]
> # TEST: IPv4 over vxlan4: PMTU exceptions                             [ O=
K ]
> # TEST: IPv4 over vxlan4: PMTU exceptions - nexthop objects           [ O=
K ]
> # TEST: IPv6 over vxlan4: PMTU exceptions                             [ O=
K ]
> # TEST: IPv6 over vxlan4: PMTU exceptions - nexthop objects           [ O=
K ]
> # TEST: IPv4 over vxlan6: PMTU exceptions                             [ O=
K ]
> <1>[  155.820793] Unable to handle kernel paging request at virtual
> address ffff247020442000
> <1>[  155.821495] Mem abort info:
> <1>[  155.821719]   ESR =3D 0x0000000097b58004
> <1>[  155.822046]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> <1>[  155.822412]   SET =3D 0, FnV =3D 0
> <1>[  155.822648]   EA =3D 0, S1PTW =3D 0
> <1>[  155.822925]   FSC =3D 0x04: level 0 translation fault
> <1>[  155.823317] Data abort info:
> <1>[  155.823590]   Access size =3D 4 byte(s)
> <1>[  155.823886]   SSE =3D 1, SRT =3D 21
> <1>[  155.824167]   SF =3D 1, AR =3D 0
> <1>[  155.824450]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> <1>[  155.824847]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> <1>[  155.825345] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004=
1d84000
> <1>[  155.827244] [ffff247020442000] pgd=3D0000000000000000, p4d=3D000000=
0000000000
> <0>[  155.828511] Internal error: Oops: 0000000097b58004 [#1] PREEMPT SMP
> <4>[  155.829155] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel
> act_csum libcrc32c act_pedit cls_flower sch_prio veth vrf macvtap
> macvlan tap crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64
> fuse drm backlight dm_mod ip_tables x_tables [last unloaded:
> test_blackhole_dev]
> <4>[  155.832289] CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.6.0-rc6 =
#1
> <4>[  155.832896] Hardware name: linux,dummy-virt (DT)
> <4>[  155.833927] pstate: 824000c9 (Nzcv daIF +PAN -UAO +TCO -DIT
> -SSBS BTYPE=3D--)
> <4>[  155.834496] pc : percpu_counter_add_batch+0x24/0xcc
> <4>[  155.835735] lr : dst_destroy+0x44/0x1e4
>
> Links:
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6=
/testrun/20613439/suite/log-parser-test/test/check-kernel-oops/log
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.6-rc6=
/testrun/20613439/suite/log-parser-test/tests/
>
> - Naresh
>


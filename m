Return-Path: <netdev+bounces-213481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F61B25392
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CA38840F3
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CBE309DAC;
	Wed, 13 Aug 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eZSE3EXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A203093AD
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111646; cv=none; b=Othe3yJM87siPOfPdMEi7eQU4Ay+8oPVEZdyYgA5jPBCrZ/Cagjv1Bc72z9L8KWVLPOJFzaJJl+0uztc1J2L9F6iqyRQvwwzu0LvYEyOaxSvLV2eexKcPDR9cAMLSIX5AOo1fsxsLwLrWF7ic/FD6kDPSyUUw92SaoPcZrEMol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111646; c=relaxed/simple;
	bh=vWuweGk2fKQx2iloNpcbyqqqQCmH/osnc1DsMO0AQt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHiFLmzwa6mM3fyh+mLPIeGAtJqFCPH7Xgcvmt+xKwYbhP0XsckHxxqcZO77x9d0KTp+dhYsHwB32RpZy/cWehDhUEPa9i+iFBBSWD9vHZgYzyB6Bo/Xe/IjfuuXsgQLTApecMftRZz1Ygx13mLQ64naNwfU+4Us33/0hydz7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eZSE3EXc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266b2368so187840a91.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755111641; x=1755716441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiJACUDbUi4ft9IyTWq32K2CcvBRH83D47gCfhyH02s=;
        b=eZSE3EXckDVMSBJSC96M7oAuevrSxi/IKFBWDl9xVtdnaF4AhLSBipNqOb6G+T78ld
         oSli6cKBIQx5R2HVOVY9muLoI7ECNdkg30DB5PyfkW9PWte86q+TwvrvuDnxvKFNxF3O
         FdUaJ1tBMEZNKazoxN/iVM3S93Sr7OQIUhL162W9AoP+oniOruDP9P+0LsAM/HofUyuM
         zpcq2kXSzs020v/wUhJBGMM15FrtCIG9As9nu2m2d7kMfg0luCWi02Zzh1pbXtb42wIz
         f4m9kWu/5r/qjFLQtMdzrCM7usERAO/L2UM+WvfYU/lGybeibmdgMHkhHaWFECwEAvkb
         xvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755111641; x=1755716441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiJACUDbUi4ft9IyTWq32K2CcvBRH83D47gCfhyH02s=;
        b=sMJR79HOZdc2/YdEfu9leyedhUoN23qmEz8KLK6CkQPSgZZ3pFkSXLvYj1uIxWG0V8
         dn123UfJAOq4P01YFlbMF6rP7PJQGeynFayofY35Paj7erwOUZCeoGu9Q1seyLlYrSW+
         ODWd4JRgw8aFtmNZXdFvsr6rDTDzZBr6FUE67nKyBGbYGHXiFZMY82rClizGhz5OV1Xg
         RM+HjGTBvRR2b74fkdytpcr1AJyoTezG7FYrT+l4CpjrxKCAr6XPKrJv+1iHJ61gP9kx
         s9iXy9uYmGE+y5xVbw8ykrGGDoAvMq54vHYH4mOO7m316SD6uscBXUzsfWexMK3m8n4J
         Tejw==
X-Forwarded-Encrypted: i=1; AJvYcCUspztolegLuqP+vOl1ds69tFpt5xUcK75A2hCFg4y+b6qUV0/g/F2onVLX51D/42iHAQPYbcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaVBQL21zFrw8tmaole0Ms8O1z1KzH8n5C/E4gLexke2RBfZY
	Jdszkxc7J0Z7rQAAG6U2d9MyWgxqrfTaA9xCUULUyQCd9kvibhfVtu1nLDbrZ1ecWjNNYR4b5QI
	3yUmo9mOUST/3mzZOAJFqIBQM4mQyrD2eL1cCLuSQ0sV299bYqBgofw==
X-Gm-Gg: ASbGncvOxsOq4cxrOtZxqyrvM05+4QKT4x1j8J59ku6OJtUoi3mzWlWyCgH/Svg4Pza
	zAGtoxDDB84BWG4ErmC6/e2TsmDIVUYf+xlZFSUXSZ/U3q64Gtwvf/orrSXpxScRyBE+V2kUpAb
	p4+f4MFkhARhwp04+WerN9qjjcC2GOBoV6KVVJsZn2kAPnrXNXJbvIXi43TEf/JgVWjzI+xKwFg
	/LObwBNq41i+DEHlA==
X-Google-Smtp-Source: AGHT+IFJFrtR6xYfj9FPDNkTp+oXAAWwaahlwjf0IgIHmzy5Rxfpt0v7xQ+Oijc3sxcam4r7l+O4ItXU/CMp9Y29B8Y=
X-Received: by 2002:a17:90b:2745:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-323279dac7fmr667177a91.9.1755111641037; Wed, 13 Aug 2025
 12:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704054824.1580222-1-kuniyu@google.com> <20250808-parent-noise-53b1edaa@mheyne-amazon>
 <CAAVpQUAi6sQ+=S-5oYOPkuPEFk68g2zG81YOA3MYVnTSvTxcjg@mail.gmail.com>
In-Reply-To: <CAAVpQUAi6sQ+=S-5oYOPkuPEFk68g2zG81YOA3MYVnTSvTxcjg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Aug 2025 15:00:29 -0400
X-Gm-Features: Ac12FXzbndb9SOpNyruUTrhTkhOKiI6LDHDXAwTxHjwEDVRMDiibNLg5i00kJzI
Message-ID: <CAHC9VhRbLSJhz=5Wuyi1RE8xxXPAGcEVXMUyTevawhAFPUvUoA@mail.gmail.com>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
To: Kuniyuki Iwashima <kuniyu@google.com>, "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jason Baron <jbaron@akamai.com>, "Ahmed, Aaron" <aarnahmd@amazon.com>, 
	"Kumar, Praveen" <pravkmr@amazon.de>, Eric Paris <eparis@redhat.com>, 
	"linux-audit@redhat.com" <linux-audit@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:54=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> On Fri, Aug 8, 2025 at 6:59=E2=80=AFAM Heyne, Maximilian <mheyne@amazon.d=
e> wrote:
> > On Fri, Jul 04, 2025 at 05:48:18AM +0000, Kuniyuki Iwashima wrote:
> > > Netlink has this pattern in some places
> > >
> > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > >       atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> > >
> > > , which has the same problem fixed by commit 5a465a0da13e ("udp:
> > > Fix multiple wraparounds of sk->sk_rmem_alloc.").
> > >
> > > For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
> > > is always false as the two operands are of int.
> > >
> > > Then, a single socket can eat as many skb as possible until OOM
> > > happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.
> > >
> > > Let's fix it by using atomic_add_return() and comparing the two
> > > variables as unsigned int.
> > >
> > > Before:
> > >   [root@fedora ~]# ss -f netlink
> > >   Recv-Q      Send-Q Local Address:Port                Peer Address:P=
ort
> > >   -1668710080 0               rtnl:nl_wraparound/293               *
> > >
> > > After:
> > >   [root@fedora ~]# ss -f netlink
> > >   Recv-Q     Send-Q Local Address:Port                Peer Address:Po=
rt
> > >   2147483072 0               rtnl:nl_wraparound/290               *
> > >   ^
> > >   `--- INT_MAX - 576
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: Jason Baron <jbaron@akamai.com>
> > > Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@ak=
amai.com/
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > Hi Kuniyuki,
> >
> > We're seeing soft lockups with this patch in a variety of (stable)
> > kernel versions.
> >
> > I was able to reproduce it on a couple of different EC2 instances also
> > with the latest linux kernel 6.16-rc7 using the following steps:
> >
> > systemctl start auditd
> > sudo auditctl -D
> > sudo auditctl -b 512
> > sudo auditctl -a always,exit -F arch=3Db64 -S mmap,munmap,mprotect,brk =
-k memory_ops
> > sudo auditctl -e 1
> >
> > Then execute some programs that call some of these memory functions,
> > such as repeated calls of "sudo auditctl -s" or logging in via SSH.
> >
> > These settings are set in a way to create a lot audit messages. Once th=
e
> > backlog (see auditctl -s) overshoots the backlog_limit, the system soft
> > lockups:
> >
> > [  460.056244] watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kaudi=
td:32]
> > [  460.056249] Modules linked in: mousedev(E) nls_ascii(E) nls_cp437(E)=
 sunrpc(E) vfat(E) fat(E) psmouse(E) atkbd(E) libps2(E) vivaldi_fmap(E) i80=
42(E) serio(E) skx_edac_common(E) button(E) ena(E) ghash_clmulni_intel(E) s=
ch_fq_codel(E) drm(E) i2c_core(E) dm_mod(E) drm_panel_orientation_quirks(E)=
 backlight(E) fuse(E) loop(E) dax(E) configfs(E) dmi_sysfs(E) efivarfs(E)
> > [  460.056272] CPU: 1 UID: 0 PID: 32 Comm: kauditd Tainted: G          =
  EL      6.16.0-rc7+ #3 PREEMPT(none)
> > [  460.056275] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
> > [  460.056276] Hardware name: Amazon EC2 t3.medium/, BIOS 1.0 10/16/201=
7
> > [  460.056277] RIP: 0010:_raw_spin_unlock_irqrestore+0x1b/0x30
> > [  460.056284] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f=
 44 00 00 e8 16 07 00 00 90 f7 c6 00 02 00 00 74 01 fb 65 ff 0d b5 23 b6 01=
 <74> 05 c3 cc cc cc cc 0f 1f 44 00 00 e9 14 23 00 00 0f 1f 40 00 90
> > [  460.056285] RSP: 0018:ffffb762c0123d70 EFLAGS: 00000246
> > [  460.056287] RAX: 0000000000000001 RBX: ffff9b14c08eafc0 RCX: ffff9b1=
4c3337348
> > [  460.056288] RDX: ffff9b14c3337348 RSI: 0000000000000246 RDI: ffff9b1=
4c3337340
> > [  460.056289] RBP: ffff9b14c3337000 R08: ffffffff93cea880 R09: 0000000=
000000001
> > [  460.056290] R10: 0000000000000001 R11: 0000000000000080 R12: ffff9b1=
4c1b72500
> > [  460.056291] R13: ffffb762c0123de0 R14: ffff9b14c3337340 R15: ffff9b1=
4c3337080
> > [  460.056294] FS:  0000000000000000(0000) GS:ffff9b1563788000(0000) kn=
lGS:0000000000000000
> > [  460.056296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  460.056297] CR2: 00007f36fd5d21b4 CR3: 000000010241a002 CR4: 0000000=
0007706f0
> > [  460.056298] PKRU: 55555554
> > [  460.056299] Call Trace:
> > [  460.056300]  <TASK>
> > [  460.056302]  netlink_attachskb+0xb7/0x2f0
> > [  460.056308]  ? __pfx_default_wake_function+0x10/0x10
> > [  460.056313]  netlink_unicast+0xea/0x3b0
> ...
> >
> > We've bug reports from many users, so the issue is rather wide-spread.
> >
> > So far I don't know why the commit is causing this issue and will keep
> > investigating. However, when reverted (together with its 2 follow-up
> > patches), the issue goes away and host do not lock up.
>
> Thanks for the report, Max!
>
> Does your tree have this commit ?  This is the 3rd follow-up patch.
>
> commit 759dfc7d04bab1b0b86113f1164dc1fec192b859
> Author: Fedor Pchelkin <pchelkin@ispras.ru>
> Date:   Mon Jul 28 08:06:47 2025
>
>     netlink: avoid infinite retry looping in netlink_unicast()

Hopefully that resolves the problem, Maximilian?

Normally the audit subsystem is reasonably robust when faced with
significant audit loads.  An example I use for testing is to enable
logging for *every* syscall (from the command line, don't make this
persist via the config file!) and then shutdown the system; the system
will obviously slow quite a bit under the absurd load, but it should
shutdown gracefully without any lockups.

--=20
paul-moore.com


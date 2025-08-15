Return-Path: <netdev+bounces-214021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE2B27DC5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686EE16B65C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7552FE594;
	Fri, 15 Aug 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XhJkIMfe"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F38227E82;
	Fri, 15 Aug 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252043; cv=none; b=TEbC3bL2Hqkit4t6CYZWCF42kTY7NV63ki/RvWv7J2Kwt6PC8EZGt0BvzDqKxf0oSiNd8NUI1BBqI78Lj0hmecyyJ+4Sv8XMsqxbw+LSDEAd2Jebj+Aeo8UWeNdghmIr5w/r5E5/tEThv7E9KDuvo7XUja8AaYz4NOCNPAa6rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252043; c=relaxed/simple;
	bh=E7DJ0BR0UZJPAuQOHg0Es65htcrgoYS7wpkzPlJ/oVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D2ebknFx1EbbRHtFbbWUtzgWHDLrWCTb7D7z44cUM65XvNQyfuyZqiK9PuR11GlVzoyWQ2F83U3mb0mOiZVn9bzaCd449oG3ZAs2e8Kz9AAFIrYhfjEdMb2Eq2hurIvYsEJTbxoehwy55f54VoIkGo5gXg/cvNGW2nfQgMsp42c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XhJkIMfe; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755252041; x=1786788041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=SuDBHRL149zCixfFVAUqzYmtxiiXpLidwnvIdl1+bRc=;
  b=XhJkIMfeLpkVVA4dbks7Rc3TdMytO03GOepuqCvsi39ObssvnSRJMTsC
   ii4gDd64Kkae0yVApEhKoTfwPs9FOCp8tOFK2yCW7sJAFtsgU/pc8cEQs
   zC2G4mnXCQzWWH/NhTclswYZuL/wQDV5FlrDhV2wykfvYuYiqhYcCmJlm
   4pjN2JEbrNkGkG+QV95mTcx5s2HCVbt+35oJLLZWDPtRuJElS1836eTE4
   eD2Fpx1aTKv7aGYdhiN1QVQV8feNHwcnpcGeSKWBBDda328oPuOKFEwY9
   UM8oBdy3MtOpJRmuvgmKOcTajqiAZSVWE2Lk8WWYmnvKXbJtopcBwlLAS
   w==;
X-CSE-ConnectionGUID: JLRRJEMIQxey4tQ49EYQlw==
X-CSE-MsgGUID: qG4Nim78RnWv/efvnRtIpA==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="816125"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-west-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:00:30 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:4368]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.48:2525] with esmtp (Farcaster)
 id ebacf326-514f-4d1e-ada7-f9005e4c17be; Fri, 15 Aug 2025 10:00:30 +0000 (UTC)
X-Farcaster-Flow-ID: ebacf326-514f-4d1e-ada7-f9005e4c17be
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 15 Aug 2025 10:00:29 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 15 Aug 2025 10:00:29 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Fri, 15 Aug 2025 10:00:29 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Paul Moore <paul@paul-moore.com>
CC: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Baron
	<jbaron@akamai.com>, "Ahmed, Aaron" <aarnahmd@amazon.com>, "Kumar, Praveen"
	<pravkmr@amazon.de>, Eric Paris <eparis@redhat.com>, "linux-audit@redhat.com"
	<linux-audit@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Thread-Topic: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Thread-Index: AQHcDctu6YADZPH6Mkm2ogmhibpggQ==
Date: Fri, 15 Aug 2025 10:00:29 +0000
Message-ID: <20250815-herons-fair-c5f3b931@mheyne-amazon>
References: <20250704054824.1580222-1-kuniyu@google.com>
 <20250808-parent-noise-53b1edaa@mheyne-amazon>
 <CAAVpQUAi6sQ+=S-5oYOPkuPEFk68g2zG81YOA3MYVnTSvTxcjg@mail.gmail.com>
 <CAHC9VhRbLSJhz=5Wuyi1RE8xxXPAGcEVXMUyTevawhAFPUvUoA@mail.gmail.com>
In-Reply-To: <CAHC9VhRbLSJhz=5Wuyi1RE8xxXPAGcEVXMUyTevawhAFPUvUoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D16B22460FF444DACC87C3C48542B14@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 03:00:29PM -0400, Paul Moore wrote:
> On Fri, Aug 8, 2025 at 11:54???AM Kuniyuki Iwashima <kuniyu@google.com> w=
rote:
> > On Fri, Aug 8, 2025 at 6:59???AM Heyne, Maximilian <mheyne@amazon.de> w=
rote:
> > > On Fri, Jul 04, 2025 at 05:48:18AM +0000, Kuniyuki Iwashima wrote:
> > > > Netlink has this pattern in some places
> > > >
> > > >   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > > >       atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> > > >
> > > > , which has the same problem fixed by commit 5a465a0da13e ("udp:
> > > > Fix multiple wraparounds of sk->sk_rmem_alloc.").
> > > >
> > > > For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
> > > > is always false as the two operands are of int.
> > > >
> > > > Then, a single socket can eat as many skb as possible until OOM
> > > > happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.
> > > >
> > > > Let's fix it by using atomic_add_return() and comparing the two
> > > > variables as unsigned int.
> > > >
> > > > Before:
> > > >   [root@fedora ~]# ss -f netlink
> > > >   Recv-Q      Send-Q Local Address:Port                Peer Address=
:Port
> > > >   -1668710080 0               rtnl:nl_wraparound/293               *
> > > >
> > > > After:
> > > >   [root@fedora ~]# ss -f netlink
> > > >   Recv-Q     Send-Q Local Address:Port                Peer Address:=
Port
> > > >   2147483072 0               rtnl:nl_wraparound/290               *
> > > >   ^
> > > >   `--- INT_MAX - 576
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: Jason Baron <jbaron@akamai.com>
> > > > Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@=
akamai.com/
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >
> > > Hi Kuniyuki,
> > >
> > > We're seeing soft lockups with this patch in a variety of (stable)
> > > kernel versions.
> > >
> > > I was able to reproduce it on a couple of different EC2 instances also
> > > with the latest linux kernel 6.16-rc7 using the following steps:
> > >
> > > systemctl start auditd
> > > sudo auditctl -D
> > > sudo auditctl -b 512
> > > sudo auditctl -a always,exit -F arch=3Db64 -S mmap,munmap,mprotect,br=
k -k memory_ops
> > > sudo auditctl -e 1
> > >
> > > Then execute some programs that call some of these memory functions,
> > > such as repeated calls of "sudo auditctl -s" or logging in via SSH.
> > >
> > > These settings are set in a way to create a lot audit messages. Once =
the
> > > backlog (see auditctl -s) overshoots the backlog_limit, the system so=
ft
> > > lockups:
> > >
> > > [  460.056244] watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kau=
ditd:32]
> > > [  460.056249] Modules linked in: mousedev(E) nls_ascii(E) nls_cp437(=
E) sunrpc(E) vfat(E) fat(E) psmouse(E) atkbd(E) libps2(E) vivaldi_fmap(E) i=
8042(E) serio(E) skx_edac_common(E) button(E) ena(E) ghash_clmulni_intel(E)=
 sch_fq_codel(E) drm(E) i2c_core(E) dm_mod(E) drm_panel_orientation_quirks(=
E) backlight(E) fuse(E) loop(E) dax(E) configfs(E) dmi_sysfs(E) efivarfs(E)
> > > [  460.056272] CPU: 1 UID: 0 PID: 32 Comm: kauditd Tainted: G        =
    EL      6.16.0-rc7+ #3 PREEMPT(none)
> > > [  460.056275] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
> > > [  460.056276] Hardware name: Amazon EC2 t3.medium/, BIOS 1.0 10/16/2=
017
> > > [  460.056277] RIP: 0010:_raw_spin_unlock_irqrestore+0x1b/0x30
> > > [  460.056284] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f =
1f 44 00 00 e8 16 07 00 00 90 f7 c6 00 02 00 00 74 01 fb 65 ff 0d b5 23 b6 =
01 <74> 05 c3 cc cc cc cc 0f 1f 44 00 00 e9 14 23 00 00 0f 1f 40 00 90
> > > [  460.056285] RSP: 0018:ffffb762c0123d70 EFLAGS: 00000246
> > > [  460.056287] RAX: 0000000000000001 RBX: ffff9b14c08eafc0 RCX: ffff9=
b14c3337348
> > > [  460.056288] RDX: ffff9b14c3337348 RSI: 0000000000000246 RDI: ffff9=
b14c3337340
> > > [  460.056289] RBP: ffff9b14c3337000 R08: ffffffff93cea880 R09: 00000=
00000000001
> > > [  460.056290] R10: 0000000000000001 R11: 0000000000000080 R12: ffff9=
b14c1b72500
> > > [  460.056291] R13: ffffb762c0123de0 R14: ffff9b14c3337340 R15: ffff9=
b14c3337080
> > > [  460.056294] FS:  0000000000000000(0000) GS:ffff9b1563788000(0000) =
knlGS:0000000000000000
> > > [  460.056296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  460.056297] CR2: 00007f36fd5d21b4 CR3: 000000010241a002 CR4: 00000=
000007706f0
> > > [  460.056298] PKRU: 55555554
> > > [  460.056299] Call Trace:
> > > [  460.056300]  <TASK>
> > > [  460.056302]  netlink_attachskb+0xb7/0x2f0
> > > [  460.056308]  ? __pfx_default_wake_function+0x10/0x10
> > > [  460.056313]  netlink_unicast+0xea/0x3b0
> > ...
> > >
> > > We've bug reports from many users, so the issue is rather wide-spread.
> > >
> > > So far I don't know why the commit is causing this issue and will keep
> > > investigating. However, when reverted (together with its 2 follow-up
> > > patches), the issue goes away and host do not lock up.
> >
> > Thanks for the report, Max!
> >
> > Does your tree have this commit ?  This is the 3rd follow-up patch.
> >
> > commit 759dfc7d04bab1b0b86113f1164dc1fec192b859
> > Author: Fedor Pchelkin <pchelkin@ispras.ru>
> > Date:   Mon Jul 28 08:06:47 2025
> >
> >     netlink: avoid infinite retry looping in netlink_unicast()
> =


Hi Paul,

> Hopefully that resolves the problem, Maximilian?

sorry for the late reply. Just tested the commit yesterday and I can
confirm that this fixes our issues.

> Normally the audit subsystem is reasonably robust when faced with
> significant audit loads.  An example I use for testing is to enable
> logging for *every* syscall (from the command line, don't make this
> persist via the config file!) and then shutdown the system; the system
> will obviously slow quite a bit under the absurd load, but it should
> shutdown gracefully without any lockups.
> =


Thank you for suggesting this. Will add something like this to our
internal testing. Do you know whether there is already some stress test
that covers the audit subsystem or would have any selftest found this
issue?

Regards,
Maximilian



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



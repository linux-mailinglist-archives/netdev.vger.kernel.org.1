Return-Path: <netdev+bounces-212187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA97B1E9BF
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D66188D7AE
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058014F125;
	Fri,  8 Aug 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ihF+KW2j"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706F01494A8;
	Fri,  8 Aug 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661578; cv=none; b=g5EfFPqZe0/tl+DfVanz/oypq6VTXnK7dacbPOrjqWQ5fTReRDnmTZA3KLGdbRUZoQVf9itkqungd1ArfmzeGVT56QPOUlVwm4PUKx0mvI575uSHPjZBKCM4JWc2EVdV0nruP1LVPurjYHTKXRcDWBfI+U4rgcarA6zQEif4Fxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661578; c=relaxed/simple;
	bh=C4I8ZwWkAyx1uycwQXECQ5w6v1tFt7eDkgN7pvn+5wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EeRDvQIm4i9pNNuaAf8vvtbcCYBhm5ORLDe1hbWhcdif1WmSs5MlHIQ0fxMKuTNTjRrmuNk7x8Y83LQy5DW7sw7k7IVdpdUIssU02l2BczGcaovh/baiKglvLyc+SCeRgpsOqKR6vFdqZrVNTlJM50zdFL+4G6I0nw69lANqAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ihF+KW2j; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1754661575; x=1786197575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=xJZJuUgsPYXLjG0Q1sMyDQPxMdytDfyx4+etkYIY+4Y=;
  b=ihF+KW2jY2q5dlf3v9nqD3e9IEVsLAcP9soBGwBjBsc2R7oUTfL5rp7t
   o4RGUlCyhyHHtAyQjrDE4VwfE5+Hk+hdFXLHaHDSENVFK5JjWsEe+mF++
   DFX84P4F6IZj0anxWINU4YN9vDnHsPziW6kZ9mRBtzWsiU/rFhu6MUVHF
   KeE8lWxAYLxcdsLJb8kwWjMgWej4Zbvf0hbz/jzaGkPBACrfnzC9duymd
   Qkxddy7JGktrLZkZ+RjIEbH7Ffoz1dTVV9RavcLfUxTnu8q2jukjMKyJ1
   1c4Y7ImJ8eCiL7TifvOANguu96ku6jZaz5HF7nmAZl8NwAcqknsuvqob0
   Q==;
X-CSE-ConnectionGUID: 5YWSUmRyQvSK/RPrn/PIgQ==
X-CSE-MsgGUID: UmaCeM4aQli7ZqHCUBdFsw==
X-IronPort-AV: E=Sophos;i="6.17,274,1747699200"; 
   d="scan'208";a="644894"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-west-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 13:59:25 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:24848]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.234:2525] with esmtp (Farcaster)
 id d64e4ff0-0acd-4a13-ba05-3283d99892e6; Fri, 8 Aug 2025 13:59:25 +0000 (UTC)
X-Farcaster-Flow-ID: d64e4ff0-0acd-4a13-ba05-3283d99892e6
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 8 Aug 2025 13:59:24 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC001.ant.amazon.com (10.252.51.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 8 Aug 2025 13:59:24 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Fri, 8 Aug 2025 13:59:24 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jason Baron <jbaron@akamai.com>, "Ahmed, Aaron" <aarnahmd@amazon.com>,
	"Kumar, Praveen" <pravkmr@amazon.de>, Paul Moore <paul@paul-moore.com>, "Eric
 Paris" <eparis@redhat.com>, "linux-audit@redhat.com"
	<linux-audit@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Thread-Topic: [PATCH v1 net] netlink: Fix wraparounds of sk->sk_rmem_alloc.
Thread-Index: AQHcCGyleoQKX63b4UqpYHupXbZkcg==
Date: Fri, 8 Aug 2025 13:59:24 +0000
Message-ID: <20250808-parent-noise-53b1edaa@mheyne-amazon>
References: <20250704054824.1580222-1-kuniyu@google.com>
In-Reply-To: <20250704054824.1580222-1-kuniyu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <542C949FA8B8CC41B2431A116DF21512@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 05:48:18AM +0000, Kuniyuki Iwashima wrote:
> Netlink has this pattern in some places
> =

>   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>   	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
> =

> , which has the same problem fixed by commit 5a465a0da13e ("udp:
> Fix multiple wraparounds of sk->sk_rmem_alloc.").
> =

> For example, if we set INT_MAX to SO_RCVBUFFORCE, the condition
> is always false as the two operands are of int.
> =

> Then, a single socket can eat as many skb as possible until OOM
> happens, and we can see multiple wraparounds of sk->sk_rmem_alloc.
> =

> Let's fix it by using atomic_add_return() and comparing the two
> variables as unsigned int.
> =

> Before:
>   [root@fedora ~]# ss -f netlink
>   Recv-Q      Send-Q Local Address:Port                Peer Address:Port
>   -1668710080 0               rtnl:nl_wraparound/293               *
> =

> After:
>   [root@fedora ~]# ss -f netlink
>   Recv-Q     Send-Q Local Address:Port                Peer Address:Port
>   2147483072 0               rtnl:nl_wraparound/290               *
>   ^
>   `--- INT_MAX - 576
> =

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Jason Baron <jbaron@akamai.com>
> Closes: https://lore.kernel.org/netdev/cover.1750285100.git.jbaron@akamai=
.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Hi Kuniyuki,

We're seeing soft lockups with this patch in a variety of (stable)
kernel versions.

I was able to reproduce it on a couple of different EC2 instances also
with the latest linux kernel 6.16-rc7 using the following steps:

systemctl start auditd
sudo auditctl -D
sudo auditctl -b 512
sudo auditctl -a always,exit -F arch=3Db64 -S mmap,munmap,mprotect,brk -k m=
emory_ops
sudo auditctl -e 1

Then execute some programs that call some of these memory functions,
such as repeated calls of "sudo auditctl -s" or logging in via SSH.

These settings are set in a way to create a lot audit messages. Once the
backlog (see auditctl -s) overshoots the backlog_limit, the system soft
lockups:

[  460.056244] watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kauditd:3=
2]
[  460.056249] Modules linked in: mousedev(E) nls_ascii(E) nls_cp437(E) sun=
rpc(E) vfat(E) fat(E) psmouse(E) atkbd(E) libps2(E) vivaldi_fmap(E) i8042(E=
) serio(E) skx_edac_common(E) button(E) ena(E) ghash_clmulni_intel(E) sch_f=
q_codel(E) drm(E) i2c_core(E) dm_mod(E) drm_panel_orientation_quirks(E) bac=
klight(E) fuse(E) loop(E) dax(E) configfs(E) dmi_sysfs(E) efivarfs(E)
[  460.056272] CPU: 1 UID: 0 PID: 32 Comm: kauditd Tainted: G            EL=
      6.16.0-rc7+ #3 PREEMPT(none)
[  460.056275] Tainted: [E]=3DUNSIGNED_MODULE, [L]=3DSOFTLOCKUP
[  460.056276] Hardware name: Amazon EC2 t3.medium/, BIOS 1.0 10/16/2017
[  460.056277] RIP: 0010:_raw_spin_unlock_irqrestore+0x1b/0x30
[  460.056284] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 =
00 00 e8 16 07 00 00 90 f7 c6 00 02 00 00 74 01 fb 65 ff 0d b5 23 b6 01 <74=
> 05 c3 cc cc cc cc 0f 1f 44 00 00 e9 14 23 00 00 0f 1f 40 00 90
[  460.056285] RSP: 0018:ffffb762c0123d70 EFLAGS: 00000246
[  460.056287] RAX: 0000000000000001 RBX: ffff9b14c08eafc0 RCX: ffff9b14c33=
37348
[  460.056288] RDX: ffff9b14c3337348 RSI: 0000000000000246 RDI: ffff9b14c33=
37340
[  460.056289] RBP: ffff9b14c3337000 R08: ffffffff93cea880 R09: 00000000000=
00001
[  460.056290] R10: 0000000000000001 R11: 0000000000000080 R12: ffff9b14c1b=
72500
[  460.056291] R13: ffffb762c0123de0 R14: ffff9b14c3337340 R15: ffff9b14c33=
37080
[  460.056294] FS:  0000000000000000(0000) GS:ffff9b1563788000(0000) knlGS:=
0000000000000000
[  460.056296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  460.056297] CR2: 00007f36fd5d21b4 CR3: 000000010241a002 CR4: 00000000007=
706f0
[  460.056298] PKRU: 55555554
[  460.056299] Call Trace:
[  460.056300]  <TASK>
[  460.056302]  netlink_attachskb+0xb7/0x2f0
[  460.056308]  ? __pfx_default_wake_function+0x10/0x10
[  460.056313]  netlink_unicast+0xea/0x3b0
[  460.056315]  kauditd_send_queue+0xaf/0x170
[  460.056318]  ? __pfx_kauditd_send_multicast_skb+0x10/0x10
[  460.056320]  ? __pfx_kauditd_retry_skb+0x10/0x10
[  460.056321]  kauditd_thread+0x132/0x2b0
[  460.056323]  ? __pfx_autoremove_wake_function+0x10/0x10
[  460.056327]  ? __pfx_kauditd_thread+0x10/0x10
[  460.056328]  kthread+0xfb/0x230
[  460.056331]  ? __pfx_kthread+0x10/0x10
[  460.056332]  ? __pfx_kthread+0x10/0x10
[  460.056334]  ret_from_fork+0x142/0x160
[  460.056338]  ? __pfx_kthread+0x10/0x10
[  460.056339]  ret_from_fork_asm+0x1a/0x30
[  460.056343]  </TASK>
[  469.011800] audit_log_start: 120 callbacks suppressed
[  469.011805] audit: audit_backlog=3D513 > audit_backlog_limit=3D512
[  469.013154] audit: audit_lost=3D1 audit_rate_limit=3D0 audit_backlog_lim=
it=3D512
[  469.013967] audit: backlog limit exceeded
[  469.014617] audit: audit_backlog=3D513 > audit_backlog_limit=3D512
[  469.015313] audit: audit_lost=3D2 audit_rate_limit=3D0 audit_backlog_lim=
it=3D512
[  469.016112] audit: backlog limit exceeded

We've bug reports from many users, so the issue is rather wide-spread.

So far I don't know why the commit is causing this issue and will keep
investigating. However, when reverted (together with its 2 follow-up
patches), the issue goes away and host do not lock up.

Thanks,
Maximilian



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597



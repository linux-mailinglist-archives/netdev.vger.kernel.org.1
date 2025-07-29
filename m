Return-Path: <netdev+bounces-210783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242DB14C9E
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE87F18A2C7F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2F288502;
	Tue, 29 Jul 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RyLp+qwD"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D41E5710;
	Tue, 29 Jul 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786896; cv=none; b=auwBIcWbQuVEh6O7AyjrG2XMvAWHSTFOhZrFb32986TMxzdam0/ZRexGjmWmX5IAwhh/+JMVzBmXa1jDsQL607h5z4eVcXU82lDMJwi8rmhYYwF63qqE1a1lbgeF1ZP8oEmWfZaYzmRKGaJvBthicoiHCUDHsviQzi9k0uB4Bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786896; c=relaxed/simple;
	bh=JR86FCUM4EyNLcyNhnv5iGvt6uDxYbqpghhr4dFQgbs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPmVmB0DpUMwKxfsF5wKIx+Bz2Fet3WYB1pI7ee6SaFA0Y9u/R97MMx3qiYfZaZi7E3ASHn93Rhr1NT2OZ58Bk3ipimmvhsbYeNv71UmKrkKX5SutusSfX9rbdyTX3teeHJVbx1hMYOLrY+H2VIxX7jYJyJAdZd5JIaw49swqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RyLp+qwD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D99F82083E;
	Tue, 29 Jul 2025 13:01:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2a1P92NkRZdc; Tue, 29 Jul 2025 13:01:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D5FDF2074B;
	Tue, 29 Jul 2025 13:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D5FDF2074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753786883;
	bh=vbXXfjZq4B6R95kv8IPd1mcDO6vGP7fNAHLDuahRjqw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RyLp+qwDoDlyTWA+8iCE9lRR+Hz1ZRENuH2dxuCKyBW5SCJurt2oUZjYRhE01mO1s
	 H5H0y4JXKXZJOP21FeDQLbcCwvuE8bJ3+aRqxzuwR+G2mNnPK5fFJYbx5sw2jCemif
	 4cUHFPXJHg4TLECYYIBD+tZA0zdY2gegFqgRYlylhyvm/NA2muO6NI2+KvCRnXu10q
	 bDEx4cLwNplFpIAdpwUjqpK9DkSc51t3Z+ck4q6qpcmp/DaTNjvyZC8llaZHy1w2In
	 i80yzgEpDq2h9Bhy8MeEhFkKjZy0Fode6/AwXgB33bB0ynOGbgBn5SUqi+0ONAt5mC
	 mR/hyokT6hAjw==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 29 Jul
 2025 13:01:23 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E783931802B0; Tue, 29 Jul 2025 13:01:22 +0200 (CEST)
Date: Tue, 29 Jul 2025 13:01:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>
CC: <davem@davemloft.net>, <edumazet@google.com>,
	<herbert@gondor.apana.org.au>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
Message-ID: <aIiqAjZzjl7uNeSb@gauss3.secunet.de>
References: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6888736f.a00a0220.b12ec.00ca.GAE@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Jul 29, 2025 at 12:08:31AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    038d61fd6422 Linux 6.16
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b88cf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
> dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6505c612be11/disk-038d61fd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e466ef29c1ca/vmlinux-038d61fd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b6d3d8fc5cbb/bzImage-038d61fd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:3284 xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
> Modules linked in:
> CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.16.0-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Workqueue: netns cleanup_net
> RIP: 0010:xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3284
> Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 68 fa 0b f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 56 c8 ec f7 e8 51 e8 a9 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 43 e8 a9 f7 90 0f 0b 90 e9 60 fe ff ff
> RSP: 0018:ffffc90000ac7898 EFLAGS: 00010293
> RAX: ffffffff8a163e8f RBX: ffff888034008000 RCX: ffff888143299e00
> RDX: 0000000000000000 RSI: ffffffff8db8419f RDI: ffff888143299e00
> RBP: ffffc90000ac79b0 R08: ffffffff8f6196e7 R09: 1ffffffff1ec32dc
> R10: dffffc0000000000 R11: fffffbfff1ec32dd R12: ffffffff8f617760
> R13: 1ffff92000158f40 R14: ffff8880340094c0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888125d23000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbd9e960960 CR3: 00000000316d3000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4348
>  ops_exit_list net/core/net_namespace.c:200 [inline]
>  ops_undo_list+0x49a/0x990 net/core/net_namespace.c:253
>  cleanup_net+0x4c5/0x800 net/core/net_namespace.c:686
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

Hi Sabrina, your recent ipcomp patches seem to trigger this issue.
At least reverting them make it go away. Can you please look
into this?

Please note that

CONFIG_INET_DIAG_DESTROY=y

has to be set to trigger the warining.

Thanks!


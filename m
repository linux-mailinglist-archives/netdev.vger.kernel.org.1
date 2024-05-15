Return-Path: <netdev+bounces-96448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7271E8C5E49
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 02:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AA4B21D95
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 00:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638B1C17;
	Wed, 15 May 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nGsoiG2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EFAEAC8
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715731649; cv=none; b=L34nsaVIRE4iTzo1iHFAuphCRHCEyZkkiVYabyQ+3+xX6ZI6TVgAZYdaq3ibgcs4xyNLorvdG1+sGEHx9+E/l6/T5YeLQhKZS4BeAWRQOZT4MOhzOUNB2k9KpbuFV7JfQj4Y3G7mwKBVdS231icPqmxKwrN/eNGQwxSVDC85yQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715731649; c=relaxed/simple;
	bh=lW1fhkcupo8nwswH30vL1Calid4HvgCM7luaUZ/K0T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlUPx3qxmAnrBMDgD7JGn+AzcB4r3/+MK2+U7t012ZzyJDVo/btEslh/W92slvCIZmVm6l0gcwEo5oKmuJRXjiz11xPlvu8kbblzbcGSKYyK5jYysu0LVoPXD9C+FLW3PWugYtE5U66ELfbOWiJ8XWOBqD1qcD8M7HrP+ZgqN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nGsoiG2z; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715731647; x=1747267647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SovR4UjXhKlRsTbb18fsqsP19X76Ttw5lqDFTappqzg=;
  b=nGsoiG2zA6PSHb2K/KWT3LkwlHtO9RWqMVEfbbDYrqhLI3UxI7HVX30W
   Z7GE/gTiFj4JII1bT4zGMcyAc7CCVDGYsuTSxte9vqoBkxxknt3vSQV7B
   2mMhTD+VPU07eROGTZqmSYVyQn0nxg5M0EGGh8AX8gnUnH9QDsSlFpzEb
   c=;
X-IronPort-AV: E=Sophos;i="6.08,160,1712620800"; 
   d="scan'208";a="396470480"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:07:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:33705]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.228:2525] with esmtp (Farcaster)
 id 064625c8-43c6-4a3c-9019-3834b915c418; Wed, 15 May 2024 00:07:23 +0000 (UTC)
X-Farcaster-Flow-ID: 064625c8-43c6-4a3c-9019-3834b915c418
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 00:07:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.6.43) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 00:07:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v4 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Wed, 15 May 2024 09:07:09 +0900
Message-ID: <20240515000709.41004-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6915a10c-cc57-4a68-9f91-a5efdf42091d@rbox.co>
References: <6915a10c-cc57-4a68-9f91-a5efdf42091d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 14 May 2024 12:13:36 +0200
> On 5/14/24 04:52, Kuniyuki Iwashima wrote:
> > ...
> > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > index 0104be9d4704..b87e48e2b51b 100644
> > --- a/net/unix/garbage.c
> > +++ b/net/unix/garbage.c
> > @@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
> >  		scan_children(&u->sk, inc_inflight, &hitlist);
> >  
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > +		spin_lock(&u->sk.sk_receive_queue.lock);
> >  		if (u->oob_skb) {
> > -			kfree_skb(u->oob_skb);
> > +			WARN_ON_ONCE(skb_unref(u->oob_skb));
> >  			u->oob_skb = NULL;
> >  		}
> > +		spin_unlock(&u->sk.sk_receive_queue.lock);
> >  #endif
> >  	}
> 
> I've realised this part of GC is broken for embryos. And adding a rq lock
> here turns a warning into a possible deadlock, so below is my attempt at
> fixing the underlying problem.

Exactly, I missed that case.  It's memleak rather than deadlock.

We need to traverse embryos from listener to drop OOB skb refcount
in embroy recvq to drop listener fd's refcount.


> 
> It's based it on top of your patch, so should I post it now or wait until
> your patch lands in net?

I'll post your patch within v5 that will minimise the delay given
we are in rush for the merge window.


> ---
> Subject: [PATCH] af_unix: Fix garbage collection of embryos carrying
>  OOB/SCM_RIGHTS
> 
> GC attempts to explicitly drop oob_skb before purging the hit list. The

s/oob_skb/oob_skb's refcount/


> problem is with embryos: instead of trying to kfree_skb(u->oob_skb) of an
> embryo socket, GC goes for its parent-listener socket, which never carries
> u->oob_skb. Effectively oob_skb is removed from the receive queue, but
> remains reachable via u->oob_skb.

The last sentence is not correct as the listener does not have oob_skb and
kfree_skb() is not called.

I'll post this patch with some modification of commit message.

Thanks!


> 
> Tell GC to dispose the right socket's oob_skb.
> 
> Fixes: aa82ac51d633 ("af_unix: Drop oob_skb ref before purging queue in GC.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> from array import array
> from socket import *
> 
> addr = 'unix-oob-splat'
> lis = socket(AF_UNIX, SOCK_STREAM)
> lis.bind(addr)
> lis.listen(1)
> 
> s = socket(AF_UNIX, SOCK_STREAM)
> s.connect(addr)
> scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
> s.sendmsg([b'x'], [scm], MSG_OOB)
> lis.close()
> 
> [   22.208683] WARNING: CPU: 2 PID: 546 at net/unix/garbage.c:371 __unix_gc+0x50e/0x520
> [   22.208687] Modules linked in: 9p netfs kvm_intel kvm 9pnet_virtio 9pnet i2c_piix4 zram crct10dif_pclmul crc32_pclmul crc32c_intel virtio_blk ghash_clmulni_intel serio_raw fuse qemu_fw_cfg virtio_console
> [   22.208701] CPU: 2 PID: 546 Comm: kworker/u32:5 Not tainted 6.9.0-rc7nokasan+ #28
> [   22.208703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [   22.208704] Workqueue: events_unbound __unix_gc
> [   22.208706] RIP: 0010:__unix_gc+0x50e/0x520
> [   22.208708] Code: 83 fa 01 0f 84 07 fe ff ff 85 d2 0f 8f 01 fe ff ff be 03 00 00 00 e8 f1 f7 9a ff e9 f2 fd ff ff e8 b7 f9 ff ff e9 28 fd ff ff <0f> 0b e9 07 ff ff ff e8 36 0a 1a 00 66 0f 1f 44 00 00 90 90 90 90
> [   22.208710] RSP: 0018:ffffc9000051fd90 EFLAGS: 00010283
> [   22.208712] RAX: ffff88810b316f30 RBX: ffffffff83563230 RCX: 0000000000000001
> [   22.208713] RDX: 0000000000000001 RSI: ffffffff82956cfb RDI: ffffffff83563880
> [   22.208714] RBP: ffffc9000051fe38 R08: 00000000cba2db62 R09: 00000000000003e5
> [   22.208715] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000051fdb0
> [   22.208716] R13: ffff88810b316a00 R14: ffffc9000051fd90 R15: ffffffff83563860
> [   22.208717] FS:  0000000000000000(0000) GS:ffff88842fb00000(0000) knlGS:0000000000000000
> [   22.208718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.208719] CR2: 0000557b30b7406c CR3: 000000011e5be000 CR4: 0000000000750ef0
> [   22.208722] PKRU: 55555554
> [   22.208723] Call Trace:
> [   22.208724]  <TASK>
> [   22.208725]  ? __warn.cold+0xb1/0x13e
> [   22.208728]  ? __unix_gc+0x50e/0x520
> [   22.208730]  ? report_bug+0xe6/0x170
> [   22.208733]  ? handle_bug+0x3c/0x80
> [   22.208735]  ? exc_invalid_op+0x13/0x60
> [   22.208737]  ? asm_exc_invalid_op+0x16/0x20
> [   22.208741]  ? __unix_gc+0x50e/0x520
> [   22.208747]  process_one_work+0x21f/0x590
> [   22.208750]  ? move_linked_works+0x70/0xa0
> [   22.208753]  worker_thread+0x1bf/0x3d0
> [   22.208756]  ? __pfx_worker_thread+0x10/0x10
> [   22.208757]  kthread+0xdd/0x110
> [   22.208759]  ? __pfx_kthread+0x10/0x10
> [   22.208761]  ret_from_fork+0x2d/0x50
> [   22.208763]  ? __pfx_kthread+0x10/0x10
> [   22.208765]  ret_from_fork_asm+0x1a/0x30
> [   22.208770]  </TASK>
> [   22.208771] irq event stamp: 198563
> [   22.208772] hardirqs last  enabled at (198569): [<ffffffff811b617d>] console_unlock+0x10d/0x140
> [   22.208775] hardirqs last disabled at (198574): [<ffffffff811b6162>] console_unlock+0xf2/0x140
> [   22.208777] softirqs last  enabled at (196450): [<ffffffff81110f4d>] __irq_exit_rcu+0x9d/0x100
> [   22.208778] softirqs last disabled at (196445): [<ffffffff81110f4d>] __irq_exit_rcu+0x9d/0x100
> 
>  net/unix/garbage.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index b87e48e2b51b..beecd0bfbf48 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -170,10 +170,11 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
>  			/* Process the descriptors of this socket */
>  			int nfd = UNIXCB(skb).fp->count;
>  			struct file **fp = UNIXCB(skb).fp->fp;
> +			struct unix_sock *u;
>  
>  			while (nfd--) {
>  				/* Get the socket the fd matches if it indeed does so */
> -				struct unix_sock *u = unix_get_socket(*fp++);
> +				u = unix_get_socket(*fp++);
>  
>  				/* Ignore non-candidates, they could have been added
>  				 * to the queues after starting the garbage collection
> @@ -187,6 +188,14 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
>  			if (hit && hitlist != NULL) {
>  				__skb_unlink(skb, &x->sk_receive_queue);
>  				__skb_queue_tail(hitlist, skb);
> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +				u = unix_sk(x);
> +				if (u->oob_skb == skb) {
> +					WARN_ON_ONCE(skb_unref(u->oob_skb));
> +					u->oob_skb = NULL;
> +				}
> +#endif
>  			}
>  		}
>  	}
> @@ -338,19 +347,9 @@ static void __unix_gc(struct work_struct *work)
>  	 * which are creating the cycle(s).
>  	 */
>  	skb_queue_head_init(&hitlist);
> -	list_for_each_entry(u, &gc_candidates, link) {
> +	list_for_each_entry(u, &gc_candidates, link)
>  		scan_children(&u->sk, inc_inflight, &hitlist);
>  
> -#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> -		spin_lock(&u->sk.sk_receive_queue.lock);
> -		if (u->oob_skb) {
> -			WARN_ON_ONCE(skb_unref(u->oob_skb));
> -			u->oob_skb = NULL;
> -		}
> -		spin_unlock(&u->sk.sk_receive_queue.lock);
> -#endif
> -	}
> -
>  	/* not_cycle_list contains those sockets which do not make up a
>  	 * cycle.  Restore these to the inflight list.
>  	 */
> -- 
> 2.45.0


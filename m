Return-Path: <netdev+bounces-95888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF58C3C4E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634911C20307
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAE146A98;
	Mon, 13 May 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cwf2TheC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C48146A93
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586438; cv=none; b=lHFtI+PnUy7SApjIWMGwmVX06auZvDWYbktDe3dwIOpnExN6um1cK7/Ogao5JBAKCq3rxKFGCSrjoQaiZhEiRYudM9NigIFFZpLMRvgzU4NKzUZ1WqzYg+YpUyJX4dJCLImVeRlHGrtj/1v21y0m+E9ytRR3Gv3yaEHnijFaBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586438; c=relaxed/simple;
	bh=7u8iXm1dMXhWqci8K4kAROR5ScWYipYN2lJEtNPiVXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb0jcnURRFQQKn7lh+F52MWUnzXxN+CJRZVxXShC8AAn/qnxl3ynoxjzCEGjt1eWli9i+d5PTJ7D5+FuT0RGdOSNkzwdFYu8IX19TUXgbuwDzQJrIVpsqyxHztsrF/PrLbIUFEKYGC+7j4t1jUUR704m74Z1NBPpk08DcAQ8bsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cwf2TheC; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715586437; x=1747122437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VRKFZWsG8UmxpssZYjjocXdzpWny29SlArsxuzi7JQ=;
  b=Cwf2TheCdjuko9LqIujXARoITJ3AuVDQoGgrAcDb0b27nWs9xCuvOOBO
   nlw8aPUnwdchbVua7mH1bz6qrkoS8G5qfjxwyIOytMMR9PkyGdvWNTZf0
   S1D6VacgiCAwJOO6/AeaaJQ8CayuuOC2kxnXorg2jiWM4K2R1J6DRv8hv
   0=;
X-IronPort-AV: E=Sophos;i="6.08,157,1712620800"; 
   d="scan'208";a="418600790"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 07:47:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:48482]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id 53a560d4-74a6-43e5-8649-7c509bc6242e; Mon, 13 May 2024 07:47:11 +0000 (UTC)
X-Farcaster-Flow-ID: 53a560d4-74a6-43e5-8649-7c509bc6242e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 07:47:10 +0000
Received: from 88665a182662.ant.amazon.com (10.118.241.118) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 13 May 2024 07:44:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Mon, 13 May 2024 16:44:15 +0900
Message-ID: <20240513074415.9027-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a00d3993-c461-43f2-be6d-07259c98509a@rbox.co>
References: <a00d3993-c461-43f2-be6d-07259c98509a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 13 May 2024 08:40:34 +0200
> On 5/13/24 08:12, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Sun, 12 May 2024 16:47:11 +0200
> >> On 5/10/24 11:39, Kuniyuki Iwashima wrote:
> >>> @@ -2655,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >>>  		consume_skb(skb);
> >>>  		skb = NULL;
> >>>  	} else {
> >>> +		spin_lock(&sk->sk_receive_queue.lock);
> >>> +
> >>>  		if (skb == u->oob_skb) {
> >>>  			if (copied) {
> >>>  				skb = NULL;
> >>> @@ -2666,13 +2674,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >>>  			} else if (flags & MSG_PEEK) {
> >>>  				skb = NULL;
> >>>  			} else {
> >>> -				skb_unlink(skb, &sk->sk_receive_queue);
> >>> +				__skb_unlink(skb, &sk->sk_receive_queue);
> >>>  				WRITE_ONCE(u->oob_skb, NULL);
> >>>  				if (!WARN_ON_ONCE(skb_unref(skb)))
> >>>  					kfree_skb(skb);
> >>>  				skb = skb_peek(&sk->sk_receive_queue);
> >>>  			}
> >>>  		}
> >>> +
> >>> +		spin_unlock(&sk->sk_receive_queue.lock);
> >>>  	}
> >>>  	return skb;
> >>>  }
> >>
> >> Now it is
> >>   
> >>   spin_lock(&sk->sk_receive_queue.lock)
> >>   kfree_skb
> > 
> > This does not free skb actually and just drops a refcount by skb_get()
> > in queue_oob().
> 
> I suspect you refer to change in __unix_gc()
> 
>  	if (u->oob_skb) {
> -		kfree_skb(u->oob_skb);
> +		WARN_ON_ONCE(skb_unref(u->oob_skb));
>  	}
> 
> What I'm talking about is the quoted above (unchanged) part in manage_oob():
> 
> 	if (!WARN_ON_ONCE(skb_unref(skb)))
>   		kfree_skb(skb);

Ah, I got your point, good catch!

Somehow I was thinking of new GC where alive recvq is not touched
and lockdep would end up with false-positive.

We need to delay freeing oob_skb in that case like below.

I'll respin v3 later, thanks!

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c555464cf1fb..35ca2be2c984 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2661,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
                consume_skb(skb);
                skb = NULL;
        } else {
+               struct sk_buff *unlinked_skb = NULL;
+
                spin_lock(&sk->sk_receive_queue.lock);
 
                if (skb == u->oob_skb) {
@@ -2676,13 +2678,18 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
                        } else {
                                __skb_unlink(skb, &sk->sk_receive_queue);
                                WRITE_ONCE(u->oob_skb, NULL);
-                               if (!WARN_ON_ONCE(skb_unref(skb)))
-                                       kfree_skb(skb);
+                               unlinked_skb = skb;
                                skb = skb_peek(&sk->sk_receive_queue);
                        }
                }
 
                spin_unlock(&sk->sk_receive_queue.lock);
+
+               if (unlinked_skb) {
+                       WARN_ON_ONCE(skb_unref(unlinked_skb));
+                       kfree_skb(unlinked_skb);
+               }
+
        }
        return skb;
 }
---8<---




> 
> I might be missing something, but
> 
> from array import array
> from socket import *
> a, b = socketpair(AF_UNIX, SOCK_STREAM)
> scm = (SOL_SOCKET, SCM_RIGHTS, array("i", [b.fileno()]))
> b.sendmsg([b'x'], [scm], MSG_OOB)
> b.close()
> a.recv(MSG_DONTWAIT)
> 
> [   72.513125] ======================================================
> [   72.513148] WARNING: possible circular locking dependency detected
> [   72.513170] 6.9.0-rc7nokasan+ #25 Not tainted
> [   72.513193] ------------------------------------------------------
> [   72.513215] python/1054 is trying to acquire lock:
> [   72.513237] ffffffff83563898 (unix_gc_lock){+.+.}-{2:2}, at: unix_notinflight+0x23/0x100
> [   72.513266]
>                but task is already holding lock:
> [   72.513288] ffff88811eb10898 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_stream_read_generic+0x178/0xbc0
> [   72.513313]
>                which lock already depends on the new lock.
> 
> [   72.513336]
>                the existing dependency chain (in reverse order) is:
> [   72.513358]
>                -> #1 (rlock-AF_UNIX){+.+.}-{2:2}:
> [   72.513381]        _raw_spin_lock+0x2f/0x40
> [   72.513404]        scan_inflight+0x36/0x1e0
> [   72.513428]        __unix_gc+0x17c/0x4b0
> [   72.513450]        process_one_work+0x217/0x700
> [   72.513474]        worker_thread+0x1ca/0x3b0
> [   72.513497]        kthread+0xdd/0x110
> [   72.513519]        ret_from_fork+0x2d/0x50
> [   72.513543]        ret_from_fork_asm+0x1a/0x30
> [   72.513565]
>                -> #0 (unix_gc_lock){+.+.}-{2:2}:
> [   72.513589]        __lock_acquire+0x137b/0x20e0
> [   72.513612]        lock_acquire+0xc5/0x2c0
> [   72.513635]        _raw_spin_lock+0x2f/0x40
> [   72.513657]        unix_notinflight+0x23/0x100
> [   72.513680]        unix_destruct_scm+0x95/0xa0
> [   72.513702]        skb_release_head_state+0x20/0x60
> [   72.513726]        kfree_skb_reason+0x53/0x1e0
> [   72.513748]        unix_stream_read_generic+0xb69/0xbc0
> [   72.513771]        unix_stream_recvmsg+0x68/0x80
> [   72.513794]        sock_recvmsg+0xb9/0xc0
> [   72.513817]        __sys_recvfrom+0xa1/0x110
> [   72.513840]        __x64_sys_recvfrom+0x20/0x30
> [   72.513862]        do_syscall_64+0x93/0x190
> [   72.513886]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   72.513909]
>                other info that might help us debug this:
> 
> [   72.513932]  Possible unsafe locking scenario:
> 
> [   72.513954]        CPU0                    CPU1
> [   72.513976]        ----                    ----
> [   72.513998]   lock(rlock-AF_UNIX);
> [   72.514020]                                lock(unix_gc_lock);
> [   72.514043]                                lock(rlock-AF_UNIX);
> [   72.514066]   lock(unix_gc_lock);
> [   72.514088]
>                 *** DEADLOCK ***
> 
> [   72.514110] 3 locks held by python/1054:
> [   72.514133]  #0: ffff88811eb10cf0 (&u->iolock){+.+.}-{3:3}, at: unix_stream_read_generic+0xd4/0xbc0
> [   72.514158]  #1: ffff88811eb10de0 (&u->lock){+.+.}-{2:2}, at: unix_stream_read_generic+0x110/0xbc0
> [   72.514184]  #2: ffff88811eb10898 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_stream_read_generic+0x178/0xbc0
> [   72.514209]
>                stack backtrace:
> [   72.514231] CPU: 4 PID: 1054 Comm: python Not tainted 6.9.0-rc7nokasan+ #25
> [   72.514254] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
> [   72.514278] Call Trace:
> [   72.514300]  <TASK>
> [   72.514321]  dump_stack_lvl+0x73/0xb0
> [   72.514345]  check_noncircular+0x108/0x120
> [   72.514369]  __lock_acquire+0x137b/0x20e0
> [   72.514392]  lock_acquire+0xc5/0x2c0
> [   72.514415]  ? unix_notinflight+0x23/0x100
> [   72.514439]  _raw_spin_lock+0x2f/0x40
> [   72.514461]  ? unix_notinflight+0x23/0x100
> [   72.514484]  unix_notinflight+0x23/0x100
> [   72.514507]  unix_destruct_scm+0x95/0xa0
> [   72.514530]  skb_release_head_state+0x20/0x60
> [   72.514553]  kfree_skb_reason+0x53/0x1e0
> [   72.514575]  unix_stream_read_generic+0xb69/0xbc0
> [   72.514600]  unix_stream_recvmsg+0x68/0x80
> [   72.514623]  ? __pfx_unix_stream_read_actor+0x10/0x10
> [   72.514646]  sock_recvmsg+0xb9/0xc0
> [   72.514669]  __sys_recvfrom+0xa1/0x110
> [   72.514692]  ? lock_release+0x133/0x290
> [   72.514715]  ? syscall_exit_to_user_mode+0x11/0x280
> [   72.514739]  ? do_syscall_64+0xa0/0x190
> [   72.514762]  __x64_sys_recvfrom+0x20/0x30
> [   72.514784]  do_syscall_64+0x93/0x190
> [   72.514807]  ? clear_bhb_loop+0x45/0xa0
> [   72.514829]  ? clear_bhb_loop+0x45/0xa0
> [   72.514852]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   72.514875] RIP: 0033:0x7fc16bb3594d
> [   72.514899] Code: 02 02 00 00 00 5d c3 66 0f 1f 44 00 00 f3 0f 1e fa 80 3d 25 8a 0c 00 00 41 89 ca 74 20 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
> [   72.514925] RSP: 002b:00007fffae4ab2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
> [   72.514949] RAX: ffffffffffffffda RBX: 00007fffae4ab3c8 RCX: 00007fc16bb3594d
> [   72.514972] RDX: 0000000000000040 RSI: 00007fc15e298f30 RDI: 0000000000000003
> [   72.514994] RBP: 00007fffae4ab310 R08: 0000000000000000 R09: 0000000000000000
> [   72.515017] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc15e34af90
> [   72.515040] R13: 0000000000000000 R14: ffffffffc4653600 R15: 0000000000000000
> [   72.515064]  </TASK>
> 
> >>     unix_destruct_scm
> > 
> > So, here we don't reach unix_destruct_scm().
> > 
> > That's why I changed kfree_skb() to skb_unref() in __unix_gc().
> > 
> > Thanks!
> > 
> > 
> >>       unix_notinflight
> >>         spin_lock(&unix_gc_lock)
> >>
> >> I.e. sk_receive_queue.lock -> unix_gc_lock, inversion of what unix_gc() does.
> >> But that's benign, right?
> 


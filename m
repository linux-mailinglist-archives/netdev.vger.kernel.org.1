Return-Path: <netdev+bounces-105169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A257390FF18
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46A31C20E4E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83819939B;
	Thu, 20 Jun 2024 08:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18163A1AC;
	Thu, 20 Jun 2024 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872995; cv=none; b=XYR3mUm4GBs/vEGkKhlsIbnI6Dz2B6EtJiOkAxn+IEtKrkDGNSNHX5bJrCXtzqsQ/rbiPOKSzdlrM4xhhV8c0eApsFTKDzYX7NG07SP2FNlOB8TtEhrxDg40OrmBJtQmUb31ChM8H2W6dZA/FlPN0gmHRYefWNK0RanHXfWB/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872995; c=relaxed/simple;
	bh=nZJEaMbpFeoc/P5BBIcjevvUoedVneN/Gm5OjTef0IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLzyqld53Nq1S4wbPjTFEOHplakf0P4TQ4hg85/DwUO0sDUJQfvfyn6BkJqSiWHnLG7Y2ka/76cLkFrEYpg0WTQXDFEU58zvglVuoiFqqHMWBSEwsVq2LmhYxThzPDmoyTL0vsjbbsDpQ0ymRegrBxdwts69F4ZLUJ6WQXi7fZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=43974 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sKDNi-00GII9-Ou; Thu, 20 Jun 2024 10:43:01 +0200
Date: Thu, 20 Jun 2024 10:42:57 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: kadlec@netfilter.org, nnamrec@gmail.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	netdev@vger.kernel.org
Subject: Re: 6.10/bisected/regression - commits 4e7aaa6b82d6 cause appearing
 WARNING at net/netfilter/ipset/ip_set_core.c:1200 suspicious
 rcu_dereference_protected() usage
Message-ID: <ZnPrkcWkAxQrODju@calendula>
References: <CABXGCsND1HmAjCZNS_fg59_qbQfxfcHCD_OYD2tjTYdWFDSajw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsND1HmAjCZNS_fg59_qbQfxfcHCD_OYD2tjTYdWFDSajw@mail.gmail.com>
X-Spam-Score: -0.2 (/)

Hi,

A fix has been included in this batch:

https://lore.kernel.org/netfilter-devel/20240619170537.2846-1-pablo@netfilter.org/T/#m39095851d6fc9d1a04d9de66f5580f61c9593389

On Thu, Jun 20, 2024 at 11:55:05AM +0500, Mikhail Gavrilov wrote:
> Hi,
> between 2ef5971ff345 and rc4 I spotted a new regression.
> It is expressed in the appearance warning with stacktrace after one
> minute after boot.
> 
>  =============================
>  WARNING: suspicious RCU usage
>  6.10.0-0.rc4.20240618git14d7c92f8df9.40.fc41.x86_64+debug #1 Tainted:
> G        W    L    -------  ---
>  -----------------------------
>  net/netfilter/ipset/ip_set_core.c:1200 suspicious
> rcu_dereference_protected() usage!
> 
>  other info that might help us debug this:
> 
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  3 locks held by kworker/u128:1/264:
>   #0: ffff88810813c958 ((wq_completion)netns){+.+.}-{0:0}, at:
> process_one_work+0xeab/0x1460
>   #1: ffffc90001477da0 (net_cleanup_work){+.+.}-{0:0}, at:
> process_one_work+0x82b/0x1460
>   #2: ffffffff97d9ae98 (pernet_ops_rwsem){++++}-{3:3}, at:
> cleanup_net+0xb9/0xa90
> 
>  stack backtrace:
>  CPU: 30 PID: 264 Comm: kworker/u128:1 Tainted: G        W    L
> -------  ---  6.10.0-0.rc4.20240618git14d7c92f8df9.40.fc41.x86_64+debug
> #1
>  Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING
> WIFI, BIOS 2611 04/07/2024
>  Workqueue: netns cleanup_net
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x84/0xd0
>   lockdep_rcu_suspicious.cold+0xa1/0x134
>   _destroy_all_sets+0x1c7/0x560 [ip_set]
>   ip_set_net_exit+0x20/0x50 [ip_set]
>   ops_exit_list+0x99/0x170
>   cleanup_net+0x4d9/0xa90
>   ? __pfx_cleanup_net+0x10/0x10
>   process_one_work+0x8a4/0x1460
>   ? worker_thread+0xe3/0x1010
>   ? __pfx_process_one_work+0x10/0x10
>   ? assign_work+0x16c/0x240
>   worker_thread+0x5e6/0x1010
>   ? __kthread_parkme+0xb1/0x1d0
>   ? __pfx_worker_thread+0x10/0x10
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x2d2/0x3a0
>   ? _raw_spin_unlock_irq+0x28/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> 
>  =============================
>  WARNING: suspicious RCU usage
>  6.10.0-0.rc4.20240618git14d7c92f8df9.40.fc41.x86_64+debug #1 Tainted:
> G        W    L    -------  ---
>  -----------------------------
>  net/netfilter/ipset/ip_set_core.c:1211 suspicious
> rcu_dereference_protected() usage!
> 
>  other info that might help us debug this:
> 
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  3 locks held by kworker/u128:1/264:
>   #0: ffff88810813c958 ((wq_completion)netns){+.+.}-{0:0}, at:
> process_one_work+0xeab/0x1460
>   #1: ffffc90001477da0 (net_cleanup_work){+.+.}-{0:0}, at:
> process_one_work+0x82b/0x1460
>   #2: ffffffff97d9ae98 (pernet_ops_rwsem){++++}-{3:3}, at:
> cleanup_net+0xb9/0xa90
> 
>  stack backtrace:
>  CPU: 30 PID: 264 Comm: kworker/u128:1 Tainted: G        W    L
> -------  ---  6.10.0-0.rc4.20240618git14d7c92f8df9.40.fc41.x86_64+debug
> #1
>  Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING
> WIFI, BIOS 2611 04/07/2024
>  Workqueue: netns cleanup_net
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x84/0xd0
>   lockdep_rcu_suspicious.cold+0xa1/0x134
>   _destroy_all_sets+0x3a8/0x560 [ip_set]
>   ip_set_net_exit+0x20/0x50 [ip_set]
>   ops_exit_list+0x99/0x170
>   cleanup_net+0x4d9/0xa90
>   ? __pfx_cleanup_net+0x10/0x10
>   process_one_work+0x8a4/0x1460
>   ? worker_thread+0xe3/0x1010
>   ? __pfx_process_one_work+0x10/0x10
>   ? assign_work+0x16c/0x240
>   worker_thread+0x5e6/0x1010
>   ? __kthread_parkme+0xb1/0x1d0
>   ? __pfx_worker_thread+0x10/0x10
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0x2d2/0x3a0
>   ? _raw_spin_unlock_irq+0x28/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x31/0x70
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  workqueue: gc_worker [nf_conntrack] hogged CPU for >10000us 7 times,
> consider switching to WQ_UNBOUND
>  workqueue: gc_worker [nf_conntrack] hogged CPU for >10000us 11 times,
> consider switching to WQ_UNBOUND
> 
> Bisect blame this commit:
> commit 4e7aaa6b82d63e8ddcbfb56b4fd3d014ca586f10
> Author: Jozsef Kadlecsik <kadlec@netfilter.org>
> Date:   Tue Jun 4 15:58:03 2024 +0200
> 
>     netfilter: ipset: Fix race between namespace cleanup and gc in the
> list:set type
> 
>     Lion Ackermann reported that there is a race condition between
> namespace cleanup
>     in ipset and the garbage collection of the list:set type. The namespace
>     cleanup can destroy the list:set type of sets while the gc of the
> set type is
>     waiting to run in rcu cleanup. The latter uses data from the
> destroyed set which
>     thus leads use after free. The patch contains the following parts:
> 
>     - When destroying all sets, first remove the garbage collectors, then wait
>       if needed and then destroy the sets.
>     - Fix the badly ordered "wait then remove gc" for the destroy a single set
>       case.
>     - Fix the missing rcu locking in the list:set type in the userspace test
>       case.
>     - Use proper RCU list handlings in the list:set type.
> 
>     The patch depends on c1193d9bbbd3 (netfilter: ipset: Add list
> flush to cancel_gc).
> 
>     Fixes: 97f7cf1cd80e (netfilter: ipset: fix performance regression
> in swap operation)
>     Reported-by: Lion Ackermann <nnamrec@gmail.com>
>     Tested-by: Lion Ackermann <nnamrec@gmail.com>
>     Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
>     Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
>  net/netfilter/ipset/ip_set_core.c     | 81
> ++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
>  net/netfilter/ipset/ip_set_list_set.c | 30 ++++++++++++++----------------
>  2 files changed, 60 insertions(+), 51 deletions(-)
> 
> And I can confirm after reverting 4e7aaa6b82d6 the issue is gone.
> 
> I also attach the build config and full kernel log.
> 
> My hardware specs: https://linux-hardware.org/?probe=80512f0c04
> 
> Jozsef can you look into this please?
> 
> -- 
> Best Regards,
> Mike Gavrilov.





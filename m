Return-Path: <netdev+bounces-52639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004B7FF8EE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C412281733
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B2584F2;
	Thu, 30 Nov 2023 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SfgiHtfH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9710F8
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hi5xOY/yzD+nNtVv/LA5A/8c2ls73r2ReS5/32JxmTQ=; b=SfgiHtfHBl64CzpHgdLq733UIr
	BUxzkst7Sx4TPkRaIA5jaf68cnTqxnsu6sfZiXv4RwDa2/E9u8LYCMuf+59KhvtAxYQkoyF/6NuAt
	KIiFeop8oGftolr5gWq0wzJ0y6WEaNKKH5dIHbZbjzlwd98CL8gIHsYPH6FJrGzI8kbw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8lJH-001gsy-73; Thu, 30 Nov 2023 18:58:47 +0100
Date: Thu, 30 Nov 2023 18:58:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: page_pool: fix general protection fault in
 page_pool_unlist
Message-ID: <ab9ba504-467d-417a-ad52-ba1bd3bde37c@lunn.ch>
References: <20231130092259.3797753-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130092259.3797753-1-edumazet@google.com>

On Thu, Nov 30, 2023 at 09:22:59AM +0000, Eric Dumazet wrote:
> syzbot was able to trigger a crash [1] in page_pool_unlist()
> 
> page_pool_list() only inserts a page pool into a netdev page pool list
> if a netdev was set in params.
> 
> Even if the kzalloc() call in page_pool_create happens to initialize
> pool->user.list, I chose to be more explicit in page_pool_list()
> adding one INIT_HLIST_NODE().
> 
> We could test in page_pool_unlist() if netdev was set,
> but since netdev can be changed to lo, it seems more robust to
> check if pool->user.list is hashed  before calling hlist_del().
> 
> [1]
> 
> Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packet loss!
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00533-ga379972973a8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __page_pool_destroy net/core/page_pool.c:851 [inline]
>  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
>  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
>  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
>  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
>  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
>  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
>  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
>  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
> 
> Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
> Reported-and-tested-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>

This time Cc: to the list etc.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


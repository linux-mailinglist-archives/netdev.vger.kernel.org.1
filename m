Return-Path: <netdev+bounces-144905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42E9C8BB8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728C7B22228
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663901FAC4A;
	Thu, 14 Nov 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMYSag0s"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1718C32C;
	Thu, 14 Nov 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589693; cv=none; b=uCjf66Ei44B+6XJdBzemMba2239pZ5OfydoaELT0Zt/D7UJxQZnxa48JLPQ8qn2kFgHldXloQk72TOMBiOusj+Rk8TZKccgVkpsXST4dNdK+sF7FRDfSl7NYdJBj46U43phU9aXQ1TXQg8BWADDDkL33x1hSzjXGiPMNu6j8BtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589693; c=relaxed/simple;
	bh=/lPw8YuDV0AKrjoQl+M8qaGgzeSJaLFjQBu2/LAF8/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkqO4HtyjUOWD9xUMS69bXPlO0CXpGpFS9ADgtfybqPdqj2yiFQmZOiRyAs7IVEC3i5OYKf2CWFtRvXB7qu9ie2jd+AvfstHKa6GMJPLw5vmAm1zblGbDY//Uqy7vEXV3u+5sV0VezupGSOHnMjeql/Xm9Oyk5WdlAwXhHp4lGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMYSag0s; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B6BB11401EA;
	Thu, 14 Nov 2024 08:08:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 08:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731589690; x=1731676090; bh=VwZkikMX0WnYtizo581kPA9GVlUC0Tn9wyC
	7eMHPrQY=; b=EMYSag0st/FVrGspBN4hux+xKJQNWcci+5wpjfUcwoLa+WyMPyh
	w1XVWnjj4JLJXat7jxcJ3gRrbUW5xcNhWNxqXZ++1YrCOtswoRoFPHvfsz9eGEFh
	77PyjLShCUhkKPtkNZtRlD2a9rVItt0HZ/mdCgZ61kyj0/zsNOTKIBSC5LmDkGgE
	9bwcuf4cerneU18iQtMEN31nbm6S/PJavfavmwMqaUdX0Ux/fy6kRfzxJspmpwrA
	SSB8bJ9lyspwrQpsGh/XLX34NTmjpWW/AQunSrDwCgwjJfhcuG8yo2dnQrzf4ZAD
	Ke7RSGQqtofWmmuJN0R+3i4VbWre8FaIgQw==
X-ME-Sender: <xms:OfY1Z2B5fwzUq1-QMcGipr4FMlexIv9pzXp23h5wpaznW6i5L4LLRA>
    <xme:OfY1ZwgKyUUjQ7Q-qWyZbCDTayWK2XAmAAur-goiTC4Ic72es_2HjAyypyFEE5mHE
    LdcHQXajg7qSY0>
X-ME-Received: <xmr:OfY1Z5nNXHzMneHjyzf5Cytm48i871rCjSIYF52XqIEcQDdiPuuZR4G5vGTe51HGW_O_baYhiyW0lsj2E6Ax-36a6NWh4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomh
    grihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvhfevffeujefgieehgefhgeeihfekfffhfeetieek
    jeejieeijedvueffffdvvdenucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsph
    hothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmpdhgohhordhglhenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguoh
    hstghhrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehshiiisghothdofeehvgejvgdvkeduudgssggvheejjeejsgdvtdgvsehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughr
    vgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhise
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehshiiikhgrlhhlvghrqdgsuhhgshesghho
    ohhglhgvghhrohhuphhsrdgtohhm
X-ME-Proxy: <xmx:OfY1Z0xsKtDoLw49L740jTuA82UryiGMTQH8X7yAv6K2kDZ13LnFPg>
    <xmx:OfY1Z7QosLlKvKv8PYMYr-GrLMCXBIBoEs6zzn8UAmMCotd8WLdDWA>
    <xmx:OfY1Z_aoaXM0_HOpEQCB_cNW0TaL5f8gPtXv_cWYA88bu3zxIJXJeg>
    <xmx:OfY1Z0SGL5va8y3_xc8GzO1MwlIkaFMjVqJXKhE7zsdPQ06H-Q-bBw>
    <xmx:OvY1Z2FOLg5gFsxRFOCnsQhS0HaN43DLXNQ3pFYpRuu58bYUIkjmV0ym>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 08:08:09 -0500 (EST)
Date: Thu, 14 Nov 2024 15:08:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: syzbot <syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __vxlan_find_mac
Message-ID: <ZzX2NDWWYLYtvyAL@shredder>
References: <6735d39a.050a0220.1324f8.0096.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6735d39a.050a0220.1324f8.0096.GAE@google.com>

On Thu, Nov 14, 2024 at 02:40:26AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    de2f378f2b77 Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b170c0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=35e7e2811bbe5777b20e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f0ff1d637186/disk-de2f378f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1515128a919f/vmlinux-de2f378f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6624bf235bc6/bzImage-de2f378f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __vxlan_find_mac+0x497/0x4e0
>  __vxlan_find_mac+0x497/0x4e0
>  vxlan_find_mac drivers/net/vxlan/vxlan_core.c:436 [inline]
>  vxlan_xmit+0x1669/0x39f0 drivers/net/vxlan/vxlan_core.c:2753

Missing a check that we have enough bytes for the Ethernet header.
Will look into it.

>  __netdev_start_xmit include/linux/netdevice.h:4928 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4937 [inline]
>  xmit_one net/core/dev.c:3588 [inline]
>  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3604
>  __dev_queue_xmit+0x3562/0x56d0 net/core/dev.c:4432
>  dev_queue_xmit include/linux/netdevice.h:3094 [inline]
>  __bpf_tx_skb net/core/filter.c:2152 [inline]
>  __bpf_redirect_common net/core/filter.c:2196 [inline]
>  __bpf_redirect+0x148c/0x1610 net/core/filter.c:2203
>  ____bpf_clone_redirect net/core/filter.c:2477 [inline]
>  bpf_clone_redirect+0x37e/0x500 net/core/filter.c:2447
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
>  __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
>  bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
>  bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1095
>  bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4266
>  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5671
>  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
>  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5758
>  x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4091 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
>  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>  skb_ensure_writable+0x496/0x520 net/core/skbuff.c:6214
>  __bpf_try_make_writable net/core/filter.c:1677 [inline]
>  bpf_try_make_writable net/core/filter.c:1683 [inline]
>  bpf_try_make_head_writable net/core/filter.c:1691 [inline]
>  ____bpf_clone_redirect net/core/filter.c:2471 [inline]
>  bpf_clone_redirect+0x1c5/0x500 net/core/filter.c:2447
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:2010
>  __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2253
>  bpf_dispatcher_nop_func include/linux/bpf.h:1265 [inline]
>  __bpf_prog_run include/linux/filter.h:701 [inline]
>  bpf_prog_run include/linux/filter.h:708 [inline]
>  bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
>  bpf_prog_test_run_skb+0x182f/0x24d0 net/bpf/test_run.c:1095
>  bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4266
>  __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5671
>  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
>  __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5758
>  x64_sys_call+0x2cce/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 UID: 0 PID: 8041 Comm: syz.2.760 Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


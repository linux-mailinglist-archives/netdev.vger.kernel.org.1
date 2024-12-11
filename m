Return-Path: <netdev+bounces-151096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E259ECD74
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA22281BF1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25522C36A;
	Wed, 11 Dec 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKV1FXrE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144623FD00
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924532; cv=none; b=WkDTTYhb8dab/tu6g9Ct1DR8h8rzmTnuegsSY2UUw7F+iskcUk2vjy3To8sFvm3W6MkZ+JaLJqhoNYWwTkQmpQ+0p6KErPtZn7zFATBhVE+k/mpEeIe4+BS7mf4DX9gWb19ujLxNySnoFOaHDKakgAQpE3ihbTeOHYVAUz7SHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924532; c=relaxed/simple;
	bh=fQvx9IoIOPmjm81OWB2L8Oxobul7Z2EIruRtQADZsgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLv+QXKQUOACoZ8BhyRQuefioy8A5UPUDChMd4g9uQkYFGtz9ar42TkQTTVvVtTtFG3df7RqQnYb8Igh/fv02X9ZPL1C5Cd+jxD4WzT8t5/CDTnOI2hnKxzh2VlHLcKfclELjne5lM28jUTJJz7TRXwH9ios32O4q0GZGv7L7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKV1FXrE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f14626c5d3so11780727b3.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733924527; x=1734529327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmqrTX2UwqLqLhNxBmKhi5tJd0wPuelBfTopJ+YE7s0=;
        b=vKV1FXrEoY09fxGcokVgQLco7zEKkZfxPOZufW+XrreTP/zsWZgT8kttxPlfDJ+D+H
         Im/kCaT6pQgrv55cT4XqAdwz06+wGfjujyQiAJ0lAGBWuBdA622W4N1PoqqGU1Q6P8gb
         YOVflZDPbMNHswtKG12shXsDj6eH425TtjBhnWSc3SlQPr+uErsCL04jbPCH93cqQMLd
         d6gl2xJfucdwwCibiwN6/cK9+2QZPxfs+OwmQueVWSKuwSpHF3hCeQ1qXSfhe0wkhlMp
         pLojhQke7xHzb7JQY4EOt6pnDXsA2Dxnva/0A980kcrlGUa5yQZPefKK6Ja/ThdF5YIc
         F6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924527; x=1734529327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmqrTX2UwqLqLhNxBmKhi5tJd0wPuelBfTopJ+YE7s0=;
        b=CbX1jrXCxNb/Hsl1fktE0nwJG071OoQ2M8a5SzBs56CL3DqdI8IBxJ/9aw6cHb/+CE
         z77rlXnfuFXDNezLDYlR6RCthMiXJiYcid9tWuLmZjKURPaMQbTxUySYKfwFFqLbiKf2
         PS7gG8VdArAkq9mKB7z7GvD9oMpaZ8Lon1ApbDbJDdv77IXnbzwYqKbAFrIQO3IJ9WMc
         1sjmwSV11IA5MT+6aQf/8dC1nLF9ys+lqaSULaMODSZu51nEvW1hIsu5LUeaoPSQ8GDq
         9EYAFIYjF/KyyCW1QGerfASaiC2pEN0x9rD244YornCN2etyOcLB05Cv4tFG/s7EG5QV
         JTdA==
X-Forwarded-Encrypted: i=1; AJvYcCWzMABFvewSdcZku2CB3j+cyTYFaYBuiduE7qq/jMU/eIZ/F6kmyI8oUcnkGONbq9ZQmKKJkxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSOKYUPFKr2CdH2JXL0h1ZHshTUU0sSHcJTuTAhMrNB2N5mgY
	N7QhtBsmS7Y91ANZZLe74VPBNnsWxY2dJjnof8er9WrpW9wt1gsM1Y2D67qC7n8ufPFfClsZ4XO
	ZN0pfcf+oPc/4jBqvOr6ncwNIPu7Ul2NiGNSJZQ==
X-Gm-Gg: ASbGnct6EomwXd0lIREQy10qHgOfEt+lAREuBHQWZCQkdznvOruWOFiGdYCby1k/Q6q
	X1ekxjBBfYnN6qHnxJzgPx2HzHeF8DHXNL3s=
X-Google-Smtp-Source: AGHT+IECw0G9EkCr+eMhOTEyWwKxk61kxqAXUZs8prUAIEzzHfmAWhRvRTV0iqMh1Pk8uA4j5t6PcojZsuDNgnnqnTk=
X-Received: by 2002:a05:690c:6889:b0:6e9:e097:718c with SMTP id
 00721157ae682-6f147f96815mr34311157b3.6.1733924527219; Wed, 11 Dec 2024
 05:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6756c37b.050a0220.a30f1.019a.GAE@google.com> <Z1clxqJ2-q4xVRCH@lore-desk>
In-Reply-To: <Z1clxqJ2-q4xVRCH@lore-desk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Dec 2024 15:41:30 +0200
Message-ID: <CAC_iWjL2Ki7NAco-n0t01YRn_TMxnq2Fcx1Ot8fk1fh9XWrWrg@mail.gmail.com>
Subject: Re: [syzbot] [net?] BUG: Bad page state in skb_pp_cow_data
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: syzbot <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Mon, 9 Dec 2024 at 19:15, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7503345ac5f5 Merge tag 'block-6.13-20241207' of git://git...
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1784c820580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ff145014d6b0ce64a173
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a8b30580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d80c0f980000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/21582041bcc6/disk-7503345a.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3752facf1019/vmlinux-7503345a.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3b1c3c4d3bd9/bzImage-7503345a.xz
> >
> > The issue was bisected to:
> >
> > commit e6d5dbdd20aa6a86974af51deb9414cd2e7794cb
> > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date:   Mon Feb 12 09:50:56 2024 +0000
> >
> >     xdp: add multi-buff support for xdp running in generic mode
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129acb30580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=119acb30580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=169acb30580000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> > Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> >
> > BUG: Bad page state in process syz-executor285  pfn:2d302
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2d302
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999485029, free_ts 54592867285
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
>
> According to the stack trace above this seems an issue in the page_pool
> codebase since we are trying to get a new page from the page allocator
> (__page_pool_alloc_pages_slow()) but the new page we receive is already
> marked with PP_SIGNATURE in pp_magic field (bad reason is set to "page_pool
> leak" in page_bad_reason()) so it already belongs to the pool.
>
> @Jesper, Ilias: any input on it?

We are indeed trying to allocate a page that wasn't freed using the
page pool APIs here. More specifically, the page got freed without
calling page_pool_return_page() somewhere, which is responsible for
resetting the magic signature.

That's all I can see from the trace now, I'll try having a closer look

Cheers
/Ilias

>
> Regards,
> Lorenzo
>
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Not tainted 6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:2d301
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x8 pfn:0x2d301
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000008 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999478821, free_ts 55944947211
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5810 tgid 5810 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:2d300
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802d304000 pfn:0x2d300
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: ffff88802d304000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999472559, free_ts 55944400344
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5810 tgid 5810 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:72d3b
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3b
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999466297, free_ts 54575113729
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:72d3a
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d3a
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999460106, free_ts 54575122306
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:72d39
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d39
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999453972, free_ts 54575963863
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:72d38
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72d38
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999447572, free_ts 54575218247
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:76907
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76907
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999441200, free_ts 54582364655
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:76906
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76906
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999421067, free_ts 54582851254
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:76905
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76905
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999414838, free_ts 54582871367
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> > BUG: Bad page state in process syz-executor285  pfn:76904
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76904
> > flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000000000 dead000000000040 ffff888022ab2000 0000000000000000
> > raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
> > page dumped because: page_pool leak
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2820(GFP_ATOMIC|__GFP_NOWARN), pid 5820, tgid 5820 (syz-executor285), ts 62999408239, free_ts 54582895841
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3651/0x37a0 mm/page_alloc.c:3474
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
> >  alloc_pages_bulk_noprof+0x70b/0xcc0 mm/page_alloc.c:4699
> >  alloc_pages_bulk_array_node_noprof include/linux/gfp.h:239 [inline]
> >  __page_pool_alloc_pages_slow+0x122/0x690 net/core/page_pool.c:538
> >  page_pool_alloc_netmem net/core/page_pool.c:590 [inline]
> >  page_pool_alloc_pages+0xd0/0x1c0 net/core/page_pool.c:597
> >  page_pool_alloc include/net/page_pool/helpers.h:129 [inline]
> >  page_pool_dev_alloc include/net/page_pool/helpers.h:167 [inline]
> >  skb_pp_cow_data+0xc43/0x1640 net/core/skbuff.c:983
> >  netif_skb_check_for_xdp net/core/dev.c:5041 [inline]
> >  netif_receive_generic_xdp net/core/dev.c:5080 [inline]
> >  do_xdp_generic+0x505/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> > page last free pid 5807 tgid 5807 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xde3/0x1130 mm/page_alloc.c:2657
> >  __folio_put+0x2c7/0x440 mm/swap.c:112
> >  pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
> >  pipe_update_tail fs/pipe.c:224 [inline]
> >  pipe_read+0x6ed/0x13e0 fs/pipe.c:344
> >  new_sync_read fs/read_write.c:484 [inline]
> >  vfs_read+0x991/0xb70 fs/read_write.c:565
> >  ksys_read+0x18f/0x2b0 fs/read_write.c:708
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5820 Comm: syz-executor285 Tainted: G    B              6.13.0-rc1-syzkaller-00337-g7503345ac5f5 #0
> > Tainted: [B]=BAD_PAGE
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  bad_page+0x176/0x1d0 mm/page_alloc.c:501
> >  free_page_is_bad mm/page_alloc.c:923 [inline]
> >  free_pages_prepare mm/page_alloc.c:1119 [inline]
> >  free_unref_page+0x1048/0x1130 mm/page_alloc.c:2657
> >  bpf_xdp_shrink_data net/core/filter.c:4148 [inline]
> >  bpf_xdp_frags_shrink_tail+0x3ee/0x7e0 net/core/filter.c:4169
> >  ____bpf_xdp_adjust_tail net/core/filter.c:4194 [inline]
> >  bpf_xdp_adjust_tail+0x1c3/0x200 net/core/filter.c:4187
> >  bpf_prog_f476d5219b92964a+0x1e/0x20
> >  __bpf_prog_run include/linux/filter.h:701 [inline]
> >  bpf_prog_run_xdp include/net/xdp.h:514 [inline]
> >  bpf_prog_run_generic_xdp+0x686/0x1510 net/core/dev.c:4973
> >  netif_receive_generic_xdp net/core/dev.c:5086 [inline]
> >  do_xdp_generic+0x757/0xd30 net/core/dev.c:5148
> >  __netif_receive_skb_core+0x1ce9/0x4690 net/core/dev.c:5492
> >  __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
> >  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
> >  netif_receive_skb_internal net/core/dev.c:5871 [inline]
> >  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5930
> >  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
> >  tun_get_user+0x30d6/0x4890 drivers/net/tun.c:2007
> >  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
> >  new_sync_write fs/read_write.c:586 [inline]
> >  vfs_write+0xaeb/0xd30 fs/read_write.c:679
> >  ksys_write+0x18f/0x2b0 fs/read_write.c:731
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f941abf7db0
> > Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d f1 e2 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > RSP: 002b:00007ffc09852f28 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f941abf7db0
> > RDX: 0000000000011dc0 RSI: 00000000200004c0 RDI: 00000000000000c8
> > RBP: 0000000000000000 R08: 00007ffc09853058 R09: 00007ffc09853058
> > R10: 00007ffc09853058 R11: 0000000000000202 R12: 00007f941ac460de
> > R13: 0000000000000000 R14: 00007ffc09852f60 R15: 00007ffc09852f50
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup


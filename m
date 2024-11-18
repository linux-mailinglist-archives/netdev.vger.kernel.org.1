Return-Path: <netdev+bounces-145764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7D9D0AC8
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613791F21FE9
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA52170A26;
	Mon, 18 Nov 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fyt7DeDw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599D15B0F2
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918319; cv=none; b=JvpVY2hGxj3311rok+X4LKnGUc8ezP5hvrgWwEHliPdw+VILdMd8ieES0ThiJ98gbAN9TuwESx07Vv6YYrooUrSRyHYzTacXjLk1w7ZEUumwYiUibsQTHW9w3gwBgDyJYa74GGsERh+EVbC5SZ9HsOeVBl9fiXLXslvY55A9jq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918319; c=relaxed/simple;
	bh=UpgEHAAMjPRDhBcRyEpbCmBLETFsZ5uZYzMGEdIXXdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IQVjOQWvJScP9UpCLzUqOvnSyOjHriMcXArewBSHpejc9gE67HqKa3CeDju8px4R4VO6tYMONVSoQZipUqnUbT/RYDoP97cKe/QI3mGcxqiYfANf/Pv29eyTuwUPm/bQ1+SYLIrFfNz31yE4JuT6qjLOD6qjUzM7j4iraUflS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fyt7DeDw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731918315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur0rNqPMEaWqtffTSUQdmBAbFxPrMdDvukYK5hzARoE=;
	b=Fyt7DeDwqhG9vG9fgqw/m01b3aJfNc8etSryrux5Z6KVlV8C2jLBeELx0kER2uBEuXSmk0
	IoiKvFIdfuFgCZ5vpeiypewHRn6CJsb2V8hroJZL4oV6uHW8FHQfTVBvNdRo4lN1+jy7Zd
	MRz7ASE1fqubzE5OiN/0kKzWOrC/rR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-ya4V3FxDMp6LMyn3FOjAiw-1; Mon, 18 Nov 2024 03:25:13 -0500
X-MC-Unique: ya4V3FxDMp6LMyn3FOjAiw-1
X-Mimecast-MFC-AGG-ID: ya4V3FxDMp6LMyn3FOjAiw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431604a3b47so28148115e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 00:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918312; x=1732523112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur0rNqPMEaWqtffTSUQdmBAbFxPrMdDvukYK5hzARoE=;
        b=BS9lEmh9KGPbR5iqqLny7erKm9p7ibG9oksEHnz8vs5Mc9BB4sBITWS3kH/iCYyptX
         IY7L3exTxY9UIbGVgUv7zGk7R5+fWmduOy7UC+eKNsyW1qOPqf7ofmefWwrBmVS/a3SF
         hM8hCFxlrmIKea51njk3C9gVOox9DVQCW5UKcDwpjGD/8YH3TTP1AbQFSJ/yjTQqxtZ2
         5/80J4jhpz+qFtvpUvw9QS+jsBv9619avGXIebiTRYh1E/4mt6wi0iDqno9H3VTy+lUb
         MVW58Hb+prr44nebbRdfgdvvllomWrdwyXj7KGz+NuLUNNNVxcPTf6XRPUqA0PeLXgDX
         O9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXyJNuvMYYsGFuOkhLYqqP/92kqFOOSb+zPGWVvtPFLg/H+PEGDy2+sY3q62dtRbGr8XdXZpMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3RKXOUcVA3xlnOc0ayCJQ52uaaO6BcVc+UvICT0vXwl6Kmc9
	ez9ru6fIQbiQ3qAxKIAmsUnYCO68MYkJ+Wi/37QtIpLAsdtA/fBR0EtLaglKjQu8EJGUWTyUoyH
	2DkuV0vH8lQZ3AVQMaCUF618FaWfPlvD+rfaExccA1ig2B1ba05fMkQ==
X-Received: by 2002:a05:600c:3acf:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-432ebcd4267mr39842635e9.5.1731918312373;
        Mon, 18 Nov 2024 00:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEza8e7WfmfiQGOB8LfU45xyP/TDGBkfeYiEtOzDIS9FRI96odglx0FAos24VgLPYfVqDQoDA==
X-Received: by 2002:a05:600c:3acf:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-432ebcd4267mr39842375e9.5.1731918312052;
        Mon, 18 Nov 2024 00:25:12 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27ffafsm150140445e9.22.2024.11.18.00.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 00:25:11 -0800 (PST)
Message-ID: <6cbc88fa-1479-4e44-950a-6d3881197520@redhat.com>
Date: Mon, 18 Nov 2024 09:25:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in sk_skb_reason_drop
To: dongml2@chinatelecom.cn, menglong8.dong@gmail.com
References: <6738e539.050a0220.e1c64.0002.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6738e539.050a0220.e1c64.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/24 19:32, syzbot wrote:
> HEAD commit:    a58f00ed24b8 net: sched: cls_api: improve the error messag..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=140a735f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=47cb6c16bf912470
> dashboard link: https://syzkaller.appspot.com/bug?extid=52fbd90f020788ec7709
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132804c0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f481a7980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d28dcea68102/disk-a58f00ed.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8ec032ea06c6/vmlinux-a58f00ed.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/da9b8f80c783/bzImage-a58f00ed.xz
> 
> The issue was bisected to:
> 
> commit 82d9983ebeb871cb5abd27c12a950c14c68772e1
> Author: Menglong Dong <menglong8.dong@gmail.com>
> Date:   Thu Nov 7 12:55:58 2024 +0000
> 
>     net: ip: make ip_route_input_noref() return drop reasons
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ae41a7980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12ae41a7980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ae41a7980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
> Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")
> 
> netlink: 'syz-executor371': attribute type 4 has an invalid length.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Modules linked in:
> CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-syzkaller-01362-ga58f00ed24b8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb 5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
> RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
> RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
> RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
> RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
> R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
> R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
> FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
>  ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
>  ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
>  ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
>  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
>  __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
>  __netif_receive_skb_list net/core/dev.c:5814 [inline]
>  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
>  netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
>  xdp_recv_frames net/bpf/test_run.c:280 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>  bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
>  bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
>  bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
>  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f18af25a8e9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

@Menglong Dong: could you please have a look? The repro looks
deterministic, so it should be doable to pin-point the actual, bad
drop_reason and why/which function is triggering it. My wild guess is
that an ERRNO is type-casted to drop reason instead of being converted.

Cheers,

Paolo



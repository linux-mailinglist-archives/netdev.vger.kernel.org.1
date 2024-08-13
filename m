Return-Path: <netdev+bounces-117925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C294FE5F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D0B234AC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D950433DF;
	Tue, 13 Aug 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="fdYuIgOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD13DBB7;
	Tue, 13 Aug 2024 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532817; cv=none; b=dHl90kflAIRzHTSXqH2RCw2tEq1ZInuHoN0ygCcAhcknBP8MwAZ/wmRt+Y0hHowAeT7K2HLm7lSu9IgH1eiL4v6xe6CV1O1fETLPlTKdIWdpwA5qswbeXV7OIItU96HzP7k9GQJH4fipH9D9XJ60q9pVgNg36gRYQEOybPvcjSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532817; c=relaxed/simple;
	bh=RU+gPBhstdJgJCKCgyCoqhUIE27e7CbW1BUihp9JypQ=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=gZQhqOPSPMCOLDMa0k/uQqUUkDpkrz+cb9ZhFG1XUL8Q8NuQOi0rPsg6SfUOHKKWwChxovREBqsxgQsgWQuBRC1KfxMlOhtGGpv1nPXS1fSa/4f9/eoawsE8SR/WOh6knjlpFBBDcM4jyWNd3VLu7b9KRGpn2d3bfpalGYvL9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=fdYuIgOC; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 450CD7D948;
	Tue, 13 Aug 2024 08:06:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723532814; bh=RU+gPBhstdJgJCKCgyCoqhUIE27e7CbW1BUihp9JypQ=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<440a73c1-1e84-c959-bb5c-43c3d60cc1c5@katalix.com>|
	 Date:=20Tue,=2013=20Aug=202024=2008:06:52=20+0100|MIME-Version:=20
	 1.0|To:=20syzbot=20<syzbot+1ff81cc9c56e63938cf9@syzkaller.appspotm
	 ail.com>,=0D=0A=20davem@davemloft.net,=20edumazet@google.com,=20ku
	 ba@kernel.org,=0D=0A=20linux-kernel@vger.kernel.org,=20netdev@vger
	 .kernel.org,=20pabeni@redhat.com,=0D=0A=20syzkaller-bugs@googlegro
	 ups.com|References:=20<0000000000002edcf0061f541f85@google.com>|Fr
	 om:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20Re:=20[s
	 yzbot]=20[net?]=20WARNING=20in=20l2tp_udp_encap_destroy|In-Reply-T
	 o:=20<0000000000002edcf0061f541f85@google.com>;
	b=fdYuIgOC+0zI8IYIs63igj2pzsnbG4agVLojPVWYBKTxNRsCNZ3doCjo7we0bpj04
	 Z4EmlS5J8xM9HAcuRQy2Vn51DFEBG4o5lxOb7tc8lcP3HufhGqzxb/16ulfxcuiaLt
	 Ehwbmk2UgAbnLYAcEj3bN1M0uiQ1IdhkUdGUrKTOpnal2vjQkrlmzRL1WDZbfMEpOA
	 S6ATzVJBywr/Xh5SyJPy3F8p3xV+CA3iSYhWFcOF0duvdSKdOnFcjYWF8NNkZmT94Y
	 gwPF+PWPw+aZ/6RBQcNQxmfNLRNFDdfmbHyYnKlYhxaA5qKO6XnJZx/qEowD+0fAya
	 J7ZIy156et9zQ==
Message-ID: <440a73c1-1e84-c959-bb5c-43c3d60cc1c5@katalix.com>
Date: Tue, 13 Aug 2024 08:06:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: syzbot <syzbot+1ff81cc9c56e63938cf9@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <0000000000002edcf0061f541f85@google.com>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [syzbot] [net?] WARNING in l2tp_udp_encap_destroy
In-Reply-To: <0000000000002edcf0061f541f85@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2024 14:20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13589dbd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
> dashboard link: https://syzkaller.appspot.com/bug?extid=1ff81cc9c56e63938cf9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/451ec795f57e/disk-eb3ab13d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e6f090c32577/vmlinux-eb3ab13d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ac63cb5127b1/bzImage-eb3ab13d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1ff81cc9c56e63938cf9@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13137 at kernel/workqueue.c:2259 __queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
> Modules linked in:
> CPU: 0 UID: 0 PID: 13137 Comm: syz.1.2857 Not tainted 6.11.0-rc2-syzkaller-00271-geb3ab13d997a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> RIP: 0010:__queue_work+0xcd3/0xf50 kernel/workqueue.c:2258
> Code: ff e8 41 85 36 00 90 0f 0b 90 e9 1e fd ff ff e8 33 85 36 00 eb 13 e8 2c 85 36 00 eb 0c e8 25 85 36 00 eb 05 e8 1e 85 36 00 90 <0f> 0b 90 48 83 c4 60 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc
> RSP: 0018:ffffc900042b7ac8 EFLAGS: 00010093
> RAX: ffffffff815cf254 RBX: ffff88802a4abc00 RCX: ffff88802a4abc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff815ce6b4 R09: 0000000000000000
> R10: ffffc900042b7ba0 R11: fffff52000856f75 R12: ffff88802ac9d800
> R13: ffff88802ac9d9c0 R14: dffffc0000000000 R15: 0000000000000008
> FS:  0000555569316500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b3291aff8 CR3: 0000000074d8c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
>   l2tp_udp_encap_destroy+0x2a/0x40 net/l2tp/l2tp_core.c:1323
>   udpv6_destroy_sock+0x19e/0x240 net/ipv6/udp.c:1683
>   sk_common_release+0x72/0x320 net/core/sock.c:3742
>   inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
>   __sock_release net/socket.c:659 [inline]
>   sock_close+0xbc/0x240 net/socket.c:1421
>   __fput+0x24a/0x8a0 fs/file_table.c:422
>   task_work_run+0x24f/0x310 kernel/task_work.c:228
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0994d779f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe09b036c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 0000000000052632 RCX: 00007f0994d779f9
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007ffe09b037a0 R08: 0000000000000001 R09: 00007ffe09b039af
> R10: 00007f0994c00000 R11: 0000000000000246 R12: 0000000000000032
> R13: 00007ffe09b037c0 R14: 00007ffe09b037e0 R15: ffffffffffffffff
>   </TASK>
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

I think this is already fixed by c1b2e36b8776

#syz fix: l2tp: flush workqueue before draining it



Return-Path: <netdev+bounces-210402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEABB131A7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DE91661A7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47C1DFD9A;
	Sun, 27 Jul 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="OwdhLGdY"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E70126BF1
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646574; cv=none; b=eo5lwB9+GUK8ujphY5xuj0ft8urbpPSpWc6Xl4KqztTrQiRLU5CMpySqj93AcBGFRm/kokB0ZJkuJWrLzy1j9XteTq8LSb8Azdc/klpaopT96Q/4wYTXnfUtRqjt0oEHadYmiZW+JxFiVqAqUnDL5aT5+EmTY8IJKonnO+cqXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646574; c=relaxed/simple;
	bh=InICUzB5IYuMy5dVYKkleg4CpHJ+Ue6GlSrlIPevuUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aV5142dBvL1ADnRepZKo7BaJo8/zPe7AvsKvBAdzoZ3axyChaI3kPcXTYDLMydgc8opZh9O6nnyhNHm3bY9pgKSCZeBmpe1z4eC/OXcKOa6rwQy45YVFI6rz9LodmbGjzMMaKGCNPmSIiqKd43OYeWLfit+7i1pIYWK2XyKqPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=OwdhLGdY; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CB0D4240027
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 21:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753646020;
	bh=EBkCPCwivLcm++pduicUmpOXoIvgyMyHaCdpOJVGgW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=OwdhLGdYSXYqeWTygaN4dQpS3sFM9tsRsa1FOPSGrtDUI3mFX/53bpcE+ROc8x1/0
	 69FuQnACu4jrUYk6cNAoX/4eXDssC/Z8AAF5W0PxwrpO8xO1zH40ypkdoznFQvDlRP
	 vC+UHKBzXLwJGlsBkbDDLqVY7uZ6ktpp5zRCGKZ5Bgd0QWD+MN+NEK7tp2YcYFt/Fe
	 zjjDMpjNCUE7WcR3Ax6QgQo/P8VubEmga8Mw4Hln9OtppIFaP0UblHOFhwNY3eYU1A
	 slG8FOjO8THcQT8EXhpitN8pHRYvQY8L54g+cdRHxKR6BkFeVHhrxYb8GdpPDaa7Cx
	 fEBIWv3JzY/1YSwT2vv2zInOnZkeJzKvS99wuNW2RgBCnqmy0AE6SGT2mGgk/m9hPC
	 W3DtEMMxB/eyK7aaYdHtJm+V/gC3Vqs/paCrT4tR1XkXWxEzMdUiYxuvqOaQ4/vVfu
	 oJe+1gNO0Pg1tiaxclzKbcwYuQPHD4qPjscMai07c23i+PQpZHA
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bqsjs644wz9rxN;
	Sun, 27 Jul 2025 21:53:37 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: syzbot <syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com>
Cc: davem@davemloft.net,  dsahern@kernel.org,  edumazet@google.com,
  herbert@gondor.apana.org.au,  horms@kernel.org,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  pabeni@redhat.com,  steffen.klassert@secunet.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in ah6_output
In-Reply-To: <683265d3.a70a0220.253bc2.0079.GAE@google.com>
References: <683265d3.a70a0220.253bc2.0079.GAE@google.com>
Date: Sun, 27 Jul 2025 19:53:40 +0000
Message-ID: <878qk9csvy.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e89db3d847f Merge tag 'linux-can-fixes-for-6.15-20250520'..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1476d1f4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
> dashboard link: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8b09322b598e/disk-9e89db3d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/23ed08e707b5/vmlinux-9e89db3d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/be78b62450e7/bzImage-9e89db3d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
> WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
> Modules linked in:
> CPU: 0 UID: 0 PID: 8838 Comm: syz.1.814 Not tainted 6.15.0-rc6-syzkaller-00173-g9e89db3d847f #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
> Code: ff e8 36 80 9f f7 c6 05 bb 97 48 05 01 90 b9 10 00 00 00 48 c7 c7 a0 56 7e 8c 4c 89 fe 48 c7 c2 00 59 7e 8c e8 a3 dc 63 f7 90 <0f> 0b 90 90 e9 b5 fe ff ff e8 74 e4 35 01 48 8b 4c 24 10 80 e1 07
> RSP: 0018:ffffc900049f70e0 EFLAGS: 00010246
> RAX: 3fffcb5d3bcc7c00 RBX: 0000000000000028 RCX: 0000000000080000
> RDX: ffffc9000ece1000 RSI: 00000000000052e8 RDI: 00000000000052e9
> RBP: ffffc900049f7250 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffffbfff1bba944 R12: dffffc0000000000
> R13: 1ffff9200093ee38 R14: ffff8881452e8800 R15: 0000000000000028
> FS:  00007fc3a1d2c6c0(0000) GS:ffff8881260c7000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555569628808 CR3: 000000005cf4e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  xfrm_output_one net/xfrm/xfrm_output.c:555 [inline]
>  xfrm_output_resume+0x2c55/0x6170 net/xfrm/xfrm_output.c:590
>  __xfrm6_output+0x2eb/0x1070 net/ipv6/xfrm6_output.c:103
>  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>  xfrm6_output+0x1c6/0x4f0 net/ipv6/xfrm6_output.c:108
>  ip6_send_skb+0x1d5/0x390 net/ipv6/ip6_output.c:1981
>  l2tp_ip6_sendmsg+0x1378/0x1870 net/l2tp/l2tp_ip6.c:661
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x19c/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc3a0f8e969
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc3a1d2c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc3a11b6080 RCX: 00007fc3a0f8e969
> RDX: 0000000000000800 RSI: 0000200000000540 RDI: 0000000000000004
> RBP: 00007fc3a1010ab1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fc3a11b6080 R15: 00007ffc18a80a58
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

#syz test: https://github.com/charmitro/linux.git d4017cef5514575221234e65a2ff9b0713718274


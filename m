Return-Path: <netdev+bounces-141135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37889B9B5D
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38751C20FAC
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4E804;
	Sat,  2 Nov 2024 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ3yz2hL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67362191
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505969; cv=none; b=moj8bXjACgVBQc5iF7aMPquMNT7DwPk7AoU+YkXrVivSvi+atzQXm87e2L66W4Bb0iZNTmfghJh4xD5WxMWXltZyXYO7BhS2UxZk1oCjkFpdGEAylqowJqLg9JPLb3NjGyj1jTFLMPxg8h9fByeU5yCk98jFQOnn5z3EGwqIB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505969; c=relaxed/simple;
	bh=RFBCvAfRJZVPtrwDBWsGzzzaP6W6R/D2rPQqsCyLu0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7zIDV96gMfOi4qVJdM2QHWESwvS36eNIjuFh40Ei1Ilzgf14lnCd6qp2Ayw/B/erSZJIhn06vbHxXMBZn4MRReND+dy/Eo/4XQegCO5YLGMy260EkxravHysN30vO5nCugfEJdIg9V5LdG/EnzY0itEqmzlcA0dk4lR7PgslIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ3yz2hL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730505966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1PBfSrAzBxmUVqSgHsa1F6KHo6yq8ammotU0yHgYcQ=;
	b=TJ3yz2hLafBr28VDToZfgX0PUM4eRMYkJ3eqEhkRsfif8gbzNvHdnxOHEswKwoEWltySYR
	a0fFNVnjtQQApSM4vJVY88YgBmzIg9y38JsEBmMsd+nM2eQ11gj6qhR0qZB/buGPpqrIGo
	OPWvokAUKF8U7wsSSL3vQ5GRlPDVbQY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-JEQr7_kkMe6sYl1uXyu7Gw-1; Fri,
 01 Nov 2024 20:06:02 -0400
X-MC-Unique: JEQr7_kkMe6sYl1uXyu7Gw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E59221956095;
	Sat,  2 Nov 2024 00:06:00 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF74195605A;
	Sat,  2 Nov 2024 00:05:52 +0000 (UTC)
Date: Sat, 2 Nov 2024 08:05:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, hch@lst.de, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in put_page (3)
Message-ID: <ZyVs271blMTITWVZ@fedora>
References: <67251378.050a0220.3c8d68.08cb.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67251378.050a0220.3c8d68.08cb.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Nov 01, 2024 at 10:44:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=131f2630580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=71abe7ab2b70bca770fd
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110d2a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e5540580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
> 
> The issue was bisected to:
> 
> commit e4e535bff2bc82bb49a633775f9834beeaa527db
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Thu Oct 24 05:00:15 2024 +0000
> 
>     iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1539b2a7980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1339b2a7980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
> Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
> 
> Oops: general protection fault, probably for non-canonical address 0xed2e87ee8f0cadc6: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: maybe wild-memory-access in range [0x69745f7478656e30-0x69745f7478656e37]
> CPU: 1 UID: 0 PID: 5869 Comm: syz-executor171 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
> RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
> RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
> RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
> RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
> R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
> R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
> FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  skb_page_unref include/linux/skbuff_ref.h:43 [inline]
>  __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
>  skb_release_data+0x483/0x8a0 net/core/skbuff.c:1119
>  skb_release_all net/core/skbuff.c:1190 [inline]
>  __kfree_skb net/core/skbuff.c:1204 [inline]
>  sk_skb_reason_drop+0x1c9/0x380 net/core/skbuff.c:1242
>  kfree_skb_reason include/linux/skbuff.h:1262 [inline]
>  kfree_skb include/linux/skbuff.h:1271 [inline]
>  __ip_flush_pending_frames net/ipv4/ip_output.c:1538 [inline]
>  ip_flush_pending_frames+0x12d/0x260 net/ipv4/ip_output.c:1545
>  udp_flush_pending_frames net/ipv4/udp.c:829 [inline]
>  udp_sendmsg+0x5d2/0x2a50 net/ipv4/udp.c:1302
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x1a6/0x270 net/socket.c:744
>  sock_sendmsg+0x134/0x200 net/socket.c:767
>  splice_to_socket+0xa10/0x10b0 fs/splice.c:889
>  do_splice_from fs/splice.c:941 [inline]
>  direct_splice_actor+0x11b/0x220 fs/splice.c:1164
>  splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
>  do_splice_direct_actor fs/splice.c:1207 [inline]
>  do_splice_direct+0x289/0x3e0 fs/splice.c:1233
>  do_sendfile+0x561/0xe10 fs/read_write.c:1388
>  __do_sys_sendfile64 fs/read_write.c:1455 [inline]
>  __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1441
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f17eb533ab9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdeb190c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f17eb533ab9
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
> RBP: 00007f17eb5a65f0 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000020000023893 R11: 0000000000000246 R12: 0000000000000001
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
> RIP: 0010:put_page+0x23/0x260 include/linux/mm.h:1552
> Code: 90 90 90 90 90 90 90 55 41 57 41 56 53 49 89 fe 48 bd 00 00 00 00 00 fc ff df e8 d8 ae 0d f8 49 8d 5e 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 5f e5 77 f8 48 8b 1b 48 89 de 48 83
> RSP: 0018:ffffc90003f970a8 EFLAGS: 00010207
> RAX: 0d2e8bee8f0cadc6 RBX: 69745f7478656e36 RCX: ffff8880306d3c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 69745f7478656e2e
> RBP: dffffc0000000000 R08: ffffffff898706fd R09: 1ffffffff203a076
> R10: dffffc0000000000 R11: fffffbfff203a077 R12: 0000000000000000
> R13: ffff88807fd7a842 R14: 69745f7478656e2e R15: 69745f7478656e2e
> FS:  0000555590726380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045ad50 CR3: 0000000025350000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	55                   	push   %rbp
>    8:	41 57                	push   %r15
>    a:	41 56                	push   %r14
>    c:	53                   	push   %rbx
>    d:	49 89 fe             	mov    %rdi,%r14
>   10:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
>   17:	fc ff df
>   1a:	e8 d8 ae 0d f8       	call   0xf80daef7
>   1f:	49 8d 5e 08          	lea    0x8(%r14),%rbx
>   23:	48 89 d8             	mov    %rbx,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
>   2e:	74 08                	je     0x38
>   30:	48 89 df             	mov    %rbx,%rdi
>   33:	e8 5f e5 77 f8       	call   0xf877e597
>   38:	48 8b 1b             	mov    (%rbx),%rbx
>   3b:	48 89 de             	mov    %rbx,%rsi
>   3e:	48                   	rex.W
>   3f:	83                   	.byte 0x83
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

#syz test: https://github.com/ming1/linux.git for-next

Thanks,
Ming



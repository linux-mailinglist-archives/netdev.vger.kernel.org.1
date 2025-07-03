Return-Path: <netdev+bounces-203884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E86AF7E1E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C16545CFF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424524EF76;
	Thu,  3 Jul 2025 16:43:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BA2580DD
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561013; cv=none; b=rj8i1vxOsWPk+b64gZfd0Y8GpAboUcO0zdyoHw2FcZcwus/4+SWQ1ctZaO0qdI2vJtOekpYW9vXP/meOgqYLJtIwBTfxihreXuaUKQ5H7XzlSz2SpQAgj2nwIRBrUA2e0SyrzgmuTTlFs0OxG0FEOJeMJ7GlqIVOO7761f/Ib3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561013; c=relaxed/simple;
	bh=qqLwuG36XKIZ+ISEBk5qt/u9PfQhtsR58/63CbLYsx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D/5E8Ay+cNKISu/LBVttM1HpvBgDp2lWZBweqdUp+HSlKGXpqXoOMXL1qJ67uXet99zMB/Xza76meHLAb+T9TYgu6YyTnwwZUvmYBXANKS6E9+kBbnvJWKaAMfeiV38ES5Si4Vsh6M9e2SnPjZa60rO5eeO9TywZTFUNPl4DH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86f4f032308so10915739f.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 09:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561011; x=1752165811;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRivCoXpqz5APGeo+CUhogEc126A/jC/qpsb4nTA31Q=;
        b=gN77NMGpu/OCwxzGHtXl2UEpYQUxk7RvRJ/dovaiURlNR2JHymAuRc+9K7s8G4865R
         gnKMcYkbTFhJnpezB3V4GzMhuYCHZwR5XfQWWYn+7/ZPf/L9a9G3NnQnGjjLM+lfNuET
         8qBnTgcVyNzPEgFYs5o84qJQR/T+hHlmJrJqGyDNy1uxTRw3YQ/pAg0MnILxHKQ9gpxU
         MhDpxOjts9Tu9YYiVPnhvafNfIFFCGgpkRq/HnrJMrMowFp2/YmjkXLjTSwnZ4hzDE6X
         Q22j9h3Dj2VScqwg2m52iojNHpsYJc1IvM4gzkgcZxrupSeNlAvVGbBXX0oR1NTVAIpG
         jk5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaZsmsinyVYkOjsSxvZ2HGpGHVeEdeWB/hXtCcXa+xyg+h1rL+O++Lbx1SWap6UDXfuNpIa3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRrlEMZfz0L17nqPu/EsMd61XE5kOwFZzzlUMvS1t/5JdMc4A
	v1DFe9NQ5Pmyic0XscU9jl9anR4jsylt9bozrhp+i++3oy+xGT80fPngBIVS5Eyd6t7k0wOXgFA
	2DGtvnsrYxoiAuZ7/juiq63Lie5PcSJJ5mK8uRMr60bj9tNLpISzp29nI29w=
X-Google-Smtp-Source: AGHT+IFtpt2JvQchlYUejpzQ03zikgdol/KIQsIwuuYC9HL9CdGp6KKa9JCa8Io7/zBMNQEL8GoxnHLIBnBHGXgB6uBhJsnI93iD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a002:b0:875:bc13:3c26 with SMTP id
 ca18e2360f4ac-876c6a03d0cmr954061139f.4.1751561010737; Thu, 03 Jul 2025
 09:43:30 -0700 (PDT)
Date: Thu, 03 Jul 2025 09:43:30 -0700
In-Reply-To: <684ffc59.a00a0220.279073.0037.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6866b332.a00a0220.c7b3.0005.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in filemap_fault (2)
From: syzbot <syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b4911fb0b060 Merge tag 'mmc-v6.16-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16568c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6ddf055b5c86f8
dashboard link: https://syzkaller.appspot.com/bug?extid=263f159eb37a1c4c67a4
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157cf48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146a948c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5828d857f454/disk-b4911fb0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecf6b7e29d2b/vmlinux-b4911fb0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cc43b227e03d/bzImage-b4911fb0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+263f159eb37a1c4c67a4@syzkaller.appspotmail.com

 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
 alloc_skb include/linux/skbuff.h:1336 [inline]
 __ip6_append_data+0x2b8c/0x3de0 net/ipv6/ip6_output.c:1668
 ip6_append_data+0x1c4/0x380 net/ipv6/ip6_output.c:1858
 rawv6_sendmsg+0x124b/0x17f0 net/ipv6/raw.c:911
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:727
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmmsg+0x227/0x430 net/socket.c:2709
------------[ cut here ]------------
kernel BUG at mm/filemap.c:3442!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 9236 Comm: syz.3.1035 Not tainted 6.16.0-rc4-syzkaller-00049-gb4911fb0b060 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:filemap_fault+0x117d/0x1200 mm/filemap.c:3442
Code: 38 c1 0f 8c 8e fc ff ff 4c 89 e7 e8 8d 6b 29 00 e9 81 fc ff ff e8 a3 13 c8 ff 48 89 df 48 c7 c6 a0 30 94 8b e8 d4 ae 0d 00 90 <0f> 0b e8 8c 13 c8 ff 48 8b 3c 24 48 c7 c6 20 37 94 8b e8 bc ae 0d
RSP: 0018:ffffc900030976e0 EFLAGS: 00010246
RAX: 864bab26a5780700 RBX: ffffea0001e53880 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8d96e815 RDI: 00000000ffffffff
RBP: ffffc90003097818 R08: ffffffff8f9fdbf7 R09: 1ffffffff1f3fb7e
R10: dffffc0000000000 R11: fffffbfff1f3fb7f R12: dffffc0000000000
R13: 1ffffd40003ca711 R14: ffffea0001e53898 R15: ffffea0001e53888
FS:  00007f9550ed76c0(0000) GS:ffff888125d84000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002000 CR3: 0000000059b4a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __do_fault+0x135/0x390 mm/memory.c:5169
 do_shared_fault mm/memory.c:5654 [inline]
 do_fault mm/memory.c:5728 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x198b/0x5620 mm/memory.c:6212
 handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_4+0xd/0x20 arch/x86/lib/putuser.S:94
Code: 66 89 01 31 c9 0f 01 ca e9 00 3b 03 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca e9 d7 3a 03 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003097c98 EFLAGS: 00050206
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00002000000015b8
RDX: 0000000000000000 RSI: ffffffff8db5a681 RDI: ffffffff8be1b940
RBP: ffffc90003097eb0 R08: 0000000000000000 R09: ffffffff820a3bc0
R10: dffffc0000000000 R11: ffffed100b371081 R12: 0000200000001580
R13: 0000000000040000 R14: 0000200000000480 R15: 0000000000000044
 __sys_sendmmsg+0x25f/0x430 net/socket.c:2714
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f954ff8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9550ed7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f95501b5fa0 RCX: 00007f954ff8e929
RDX: 00000000000002e9 RSI: 0000200000000480 RDI: 0000000000000004
RBP: 00007f9550010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f95501b5fa0 R15: 00007ffcd704c578
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filemap_fault+0x117d/0x1200 mm/filemap.c:3442
Code: 38 c1 0f 8c 8e fc ff ff 4c 89 e7 e8 8d 6b 29 00 e9 81 fc ff ff e8 a3 13 c8 ff 48 89 df 48 c7 c6 a0 30 94 8b e8 d4 ae 0d 00 90 <0f> 0b e8 8c 13 c8 ff 48 8b 3c 24 48 c7 c6 20 37 94 8b e8 bc ae 0d
RSP: 0018:ffffc900030976e0 EFLAGS: 00010246
RAX: 864bab26a5780700 RBX: ffffea0001e53880 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8d96e815 RDI: 00000000ffffffff
RBP: ffffc90003097818 R08: ffffffff8f9fdbf7 R09: 1ffffffff1f3fb7e
R10: dffffc0000000000 R11: fffffbfff1f3fb7f R12: dffffc0000000000
R13: 1ffffd40003ca711 R14: ffffea0001e53898 R15: ffffea0001e53888
FS:  00007f9550ed76c0(0000) GS:ffff888125d84000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002000 CR3: 0000000059b4a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	66 89 01             	mov    %ax,(%rcx)
   3:	31 c9                	xor    %ecx,%ecx
   5:	0f 01 ca             	clac
   8:	e9 00 3b 03 00       	jmp    0x33b0d
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	48 89 cb             	mov    %rcx,%rbx
  20:	48 c1 fb 3f          	sar    $0x3f,%rbx
  24:	48 09 d9             	or     %rbx,%rcx
  27:	0f 01 cb             	stac
* 2a:	89 01                	mov    %eax,(%rcx) <-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	0f 01 ca             	clac
  31:	e9 d7 3a 03 00       	jmp    0x33b0d
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


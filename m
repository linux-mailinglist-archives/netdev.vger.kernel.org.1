Return-Path: <netdev+bounces-146817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A59D60E6
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E6C28112C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF04135A4B;
	Fri, 22 Nov 2024 14:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1413AA4E
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287206; cv=none; b=Lw1+Xxm3FU7/SiCyvcSfh1RIYheWqsaJ97BtiMHmPB4Nc2wzi5QP1s2bfXRmHuiHCJQQ5I4JwwVTdajwQRtD7ruUXOX0/tdOFUktNHGtVqBABmAaSADzev6619iVmnkzKuSf+EGLBQaD/zM+YEb6FALLOebvSPLspUZh5JNud6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287206; c=relaxed/simple;
	bh=lZQekX2emKcuj2NJAxg/sQkuKYZ6re4Fnr/AHGyvKRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X5+S0Pde9N32q1O89OMB/VUqhUXh8zTwP1Qncfzv75VtCa63YDeA7Ct2r3ydflp4NEqerebdQXlDhoG9BoVmPSoRAOIEab+c1AFeOmdpe1RlTiyOcMN1KHymNGqs/5gARbn+h3kCJD6p5viHQ/z97XV4krmTcfJ4zBHsrSVibRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so20015145ab.1
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 06:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287204; x=1732892004;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7o7pgGKQ4wM8xkrHo10PDRpAbGA2NNo58w/WumnI7BA=;
        b=s4up7KnosXkhyp2tIVyNxzLkuLgIfg/1Tf8t9ZdlCKR+m1craUDRb4qZbcBWliXbvg
         x7YXkNABqAfojrQoLf9/FeU7oap/dUjde5J7pgn+FuXNxCVPSrxHLxSiOItLdac3Mbrp
         u+DnTQjy0QRYJx/R9MtDJlvRaURS6uuqDYiqD90/v3BN5uPT1OFrUdIdbjUxpuIdLm01
         kEclwoRHQw/Iwr6uSoQY7Jd38WKDnLiNtvf+dPPzb0hSzv32yyD9RS3PDAT2UjktWg9U
         hNFfjcC2soAuXdbCroPgwb/Ved5S2fAqD1PAAFmkeUvWfK8btR6bEDPd10jx6Jow1A4S
         +DOg==
X-Forwarded-Encrypted: i=1; AJvYcCVtHarNPyOhENLufYiEJ9w7Xygj8HaDKdKGVByOPjMftqWk/TeHKfLtIgvkopWDImVzDNsEqUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEEbY2GpCxWCvRqTr6g/a7hAh1t0lTInDrRQvy8QeqZBE4oCK
	+WggrMGGg73Y8JrshjAR2HNYNwiczifOQ2prUkKaxcKZFfu1mTU7gEhATO5DAHEW3xYLKLh17oA
	HtLo7/8URdF0/pOOHA+sKU7EtWFerukUUuB34Pmn4EqsS5HXh2bES9x0=
X-Google-Smtp-Source: AGHT+IFpChMF+zsGAxQ24GSFAkvrHfKB02in/7a9q3UjGkNd70I0TQZdAIdsr6uiZF3c1/+TokDsUp7KuIwntlqS2GdzaWD3gfL2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a7:9fff:1353 with SMTP id
 e9e14a558f8ab-3a79fff1550mr20296925ab.0.1732287204249; Fri, 22 Nov 2024
 06:53:24 -0800 (PST)
Date: Fri, 22 Nov 2024 06:53:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67409ae4.050a0220.363a1b.0140.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in __skb_frag_unref
From: syzbot <syzbot+3bd2949d1470dea6df73@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86cada34bc3a arm64: preserve pt_regs::stackframe during ex..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12b50287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c154e2d4db830898
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd2949d1470dea6df73
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160050a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cba29975cae/disk-86cada34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1e63bf4e894/vmlinux-86cada34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6770ff6b33c6/Image-86cada34.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3bd2949d1470dea6df73@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc3-syzkaller-g86cada34bc3a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:242 [inline]
pc : put_page include/linux/mm.h:1554 [inline]
pc : skb_page_unref include/linux/skbuff_ref.h:43 [inline]
pc : __skb_frag_unref+0x80/0x214 include/linux/skbuff_ref.h:56
lr : netmem_to_page include/net/netmem.h:83 [inline]
lr : skb_page_unref include/linux/skbuff_ref.h:43 [inline]
lr : __skb_frag_unref+0x78/0x214 include/linux/skbuff_ref.h:56
sp : ffff8000978f6aa0
x29: ffff8000978f6aa0 x28: dfff800000000000 x27: 0000000000000007
x26: ffff0000d3573d40 x25: ffff0000d3573d70 x24: 0000000000000000
x23: ffff0000d3573d42 x22: 1fffe0001a6ae7a8 x21: dfff800000000000
x20: 0000000000000008 x19: 0000000000000000 x18: ffff0000d1eba80c
x17: 0000000000013a0a x16: ffff800080588a40 x15: 0000000000000001
x14: 1fffe0001a6ae7ac x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001a6ae7ad x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff8000895974dc
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 _compound_head include/linux/page-flags.h:242 [inline] (P)
 put_page include/linux/mm.h:1554 [inline] (P)
 skb_page_unref include/linux/skbuff_ref.h:43 [inline] (P)
 __skb_frag_unref+0x80/0x214 include/linux/skbuff_ref.h:56 (P)
 netmem_to_page include/net/netmem.h:83 [inline] (L)
 skb_page_unref include/linux/skbuff_ref.h:43 [inline] (L)
 __skb_frag_unref+0x78/0x214 include/linux/skbuff_ref.h:56 (L)
 skb_release_data+0x3c4/0x618 net/core/skbuff.c:1119
 skb_release_all net/core/skbuff.c:1190 [inline]
 __kfree_skb+0x58/0x78 net/core/skbuff.c:1204
 tcp_wmem_free_skb include/net/tcp.h:306 [inline]
 tcp_rtx_queue_unlink_and_free+0x2e8/0x4a8 include/net/tcp.h:2091
 tcp_clean_rtx_queue net/ipv4/tcp_input.c:3436 [inline]
 tcp_ack+0x1c84/0x55ac net/ipv4/tcp_input.c:4032
 tcp_rcv_state_process+0x528/0x3e30 net/ipv4/tcp_input.c:6805
 tcp_v4_do_rcv+0x71c/0xc44 net/ipv4/tcp_ipv4.c:1938
 tcp_v4_rcv+0x2498/0x2dbc net/ipv4/tcp_ipv4.c:2350
 ip_protocol_deliver_rcu+0x1f8/0x484 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x284/0x4f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x328/0x3d4 include/linux/netfilter.h:314
 ip_local_deliver+0x120/0x194 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x220/0x24c net/ipv4/ip_input.c:449
 NF_HOOK+0x328/0x3d4 include/linux/netfilter.h:314
 ip_rcv+0x7c/0x9c net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x18c/0x3c8 net/core/dev.c:5779
 process_backlog+0x640/0x123c net/core/dev.c:6111
 __napi_poll+0xb4/0x3fc net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x6a8/0xf4c net/core/dev.c:6966
 handle_softirqs+0x2e0/0xbf8 kernel/softirq.c:554
 run_ksoftirqd+0x70/0x158 kernel/softirq.c:927
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 37000653 97a5f838 91002274 d343fe88 (38756908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	37000653 	tbnz	w19, #0, 0xc8
   4:	97a5f838 	bl	0xfffffffffe97e0e4
   8:	91002274 	add	x20, x19, #0x8
   c:	d343fe88 	lsr	x8, x20, #3
* 10:	38756908 	ldrb	w8, [x8, x21] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


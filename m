Return-Path: <netdev+bounces-132349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19D991529
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC651C21C66
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268151369BB;
	Sat,  5 Oct 2024 07:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BD12F5B1
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114982; cv=none; b=p3xEvYqYfxx5HnkECMxNDeu1FPP/kjA3iDgVRJt1QngXYuZj+ex7WssoQraKj1PMVA+6e0dKl3rKkWwqRAzDtGB/a2j7vFhFXveRzh+/Z8jRM0TL4hc64VqdtrhUgppBuJLusdpJ8ON+LNnXv9iqb5LCaOUE8EfOgMtE4uWrR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114982; c=relaxed/simple;
	bh=z2bFvLo+GFZM89ZYC+AtdG8B1aJLyj8pt68bcJKPH5o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DzKXiSFRJfttkwa5G06fwbIiaz35eWWqb1/C3iAT53ybCcnAk4jtjT+UOY84NTc/UMne3oiZeZv/OvokBqJfLj9lopvxKG/WkVFTBBKCp0E0Kmdrn3MgxgAAmgFOK8BaXybe6LBVF69putW8i5IteZHk6nNv/H2SvKiKvbJexVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so31158005ab.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 00:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728114979; x=1728719779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/w9tB55nUaOYadIWJ08slDlEGe2WJjvuC6OCwtHkxI=;
        b=acF7om10SdiUJUYJf+FJkEIkHfYBoxNdrB23AbSXFyDYwl6zUWA1nFV7kDFQRzanPg
         P04368r7GKLx/rrEKih28CWOiKtD9mnPAxdqIDQUjFWSTTolrddVOfxlVlaPchgKCpDq
         Ro7xfQWMP49TXHsGoUmB3aYbXX5LsnwQnTfy5z2b5bDpZB2JS+/cOnFcIJ1nnvdol67l
         t95Oi+1WemxlL3lRmNNKzO6h/EAn+RA4LjCdd90/Dd3k5GiB/X/i+FcuDYd0q7v+67b4
         p/wyRcjgLE+n/DWsv3vahjKdHn0Ox+kvAQJY4Q9F1MwdffFDL69QnSxB11yPlMkzxtOQ
         eYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyJTkOcOZLryDrZnC0bejAytNmGBET0+uJI+/CFeJn5aN5WNKQSyMhfVU9hGV741yQHDizVHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8It0V4ITSX46n9CJXIOCDeblaeZEwX5T6eoyqGz86WuTmKV3N
	ymD2TYG2dTmxyVXkC7uN00OD3BAJoWJbjQS7AUG6gLd9nc1Bpydr23XzpFb2Yes+NltCjmfVysV
	rDJCLTc/phghRmpoMPY1riStBR3CddZET5IALl2Tu9tlLM5Gg+Ei3am4=
X-Google-Smtp-Source: AGHT+IGyIMB5w+1FHfclmeKJk0ZAq4C6cLWrUWDucl/v1tfND5hVxxBqjLbkVcPuuqLy5rSLmFz3XrsKTgTrSPRmGozvZJVIasth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:39d:25f4:bed3 with SMTP id
 e9e14a558f8ab-3a37597d61bmr50375185ab.5.1728114979411; Sat, 05 Oct 2024
 00:56:19 -0700 (PDT)
Date: Sat, 05 Oct 2024 00:56:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6700f123.050a0220.49194.04b5.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] KFENCE: memory corruption in pskb_expand_head
From: syzbot <syzbot+80b36e60457a005e0530@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, cl@linux.com, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	feng.tang@intel.com, haoluo@google.com, iamjoonsoo.kim@lge.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1404ab9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=80b36e60457a005e0530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f633d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1204ab9f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz

The issue was bisected to:

commit d0a38fad51cc70ab3dd3c59b54d8079ac19220b9
Author: Feng Tang <feng.tang@intel.com>
Date:   Wed Sep 11 06:45:34 2024 +0000

    mm/slub: Improve redzone check and zeroing for krealloc()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16da4d27980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15da4d27980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11da4d27980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80b36e60457a005e0530@syzkaller.appspotmail.com
Fixes: d0a38fad51cc ("mm/slub: Improve redzone check and zeroing for krealloc()")

==================================================================
BUG: KFENCE: memory corruption in skb_kfree_head net/core/skbuff.c:1086 [inline]
BUG: KFENCE: memory corruption in skb_free_head net/core/skbuff.c:1098 [inline]
BUG: KFENCE: memory corruption in pskb_expand_head+0x4fc/0x1380 net/core/skbuff.c:2307

Corrupted memory at 0xffff88823be221c0 [ 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#16):
 skb_kfree_head net/core/skbuff.c:1086 [inline]
 skb_free_head net/core/skbuff.c:1098 [inline]
 pskb_expand_head+0x4fc/0x1380 net/core/skbuff.c:2307
 __skb_cow include/linux/skbuff.h:3702 [inline]
 skb_cow_head include/linux/skbuff.h:3736 [inline]
 __vlan_insert_inner_tag include/linux/if_vlan.h:354 [inline]
 __vlan_insert_tag include/linux/if_vlan.h:400 [inline]
 skb_vlan_push+0x319/0x8d0 net/core/skbuff.c:6324
 ____bpf_skb_vlan_push net/core/filter.c:3193 [inline]
 bpf_skb_vlan_push+0x215/0x8e0 net/core/filter.c:3183
 bpf_prog_73b0c961a278ad0e+0x5b/0x60
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x4f0/0xa90 net/bpf/test_run.c:433
 bpf_prog_test_run_skb+0xc97/0x1820 net/bpf/test_run.c:1094
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

kfence-#16: 0xffff88823be22000-0xffff88823be221bf, size=448, cache=kmalloc-512

allocated by task 5407 on cpu 0 at 90.755534s (0.100574s ago):
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 bpf_test_init+0xe1/0x180 net/bpf/test_run.c:669
 bpf_prog_test_run_skb+0x2bb/0x1820 net/bpf/test_run.c:1000
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

freed by task 5407 on cpu 0 at 90.755621s (0.144394s ago):
 skb_kfree_head net/core/skbuff.c:1086 [inline]
 skb_free_head net/core/skbuff.c:1098 [inline]
 pskb_expand_head+0x4fc/0x1380 net/core/skbuff.c:2307
 __skb_cow include/linux/skbuff.h:3702 [inline]
 skb_cow_head include/linux/skbuff.h:3736 [inline]
 __vlan_insert_inner_tag include/linux/if_vlan.h:354 [inline]
 __vlan_insert_tag include/linux/if_vlan.h:400 [inline]
 skb_vlan_push+0x319/0x8d0 net/core/skbuff.c:6324
 ____bpf_skb_vlan_push net/core/filter.c:3193 [inline]
 bpf_skb_vlan_push+0x215/0x8e0 net/core/filter.c:3183
 bpf_prog_73b0c961a278ad0e+0x5b/0x60
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 bpf_test_run+0x4f0/0xa90 net/bpf/test_run.c:433
 bpf_prog_test_run_skb+0xc97/0x1820 net/bpf/test_run.c:1094
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4247
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5652
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5739
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5407 Comm: syz-executor182 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


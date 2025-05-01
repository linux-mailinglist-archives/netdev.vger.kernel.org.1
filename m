Return-Path: <netdev+bounces-187225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE92AA5DAF
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3278E9C3957
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD222172C;
	Thu,  1 May 2025 11:16:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42178132103
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098199; cv=none; b=CvAYZ8iOGOwH5jK9k/zGPgUIdkIRlAR1k+1KaU+ClYCcn1XgoXr30Wgy7LsioYhgtWDsfZ8ykpolmvVtx+OEGwDJZ1fNlNHnTk+vb764QviKL54baeaRGVyBM+tsh6bLeSNGlDUFUT/eP5hjGqyc1xjMh9d9ddo8Pfz4GPb0h7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098199; c=relaxed/simple;
	bh=I++a0t3+Rl8fUzdoS3SV+0OrrhVGilPTQlRtbES/Mrs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o9Hgw/ZGPjcrlELnhdUgoJ+7FONt8cPNkdr2EoSiD9XGYE0tOuA3vnTYNhPNAKz4Xx1155UZ6U+nzHgS2POv1uaYLwjEdtgMi30u/2oIBkox1FsBgSNwc5qP4RJ2ZbeL9DG5D7+qei2rzyg+032XPTJFaNKl2TpJajESXel8C20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d90ba11afcso10383465ab.0
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 04:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098197; x=1746702997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJLGUG4iLInQ/D3odsfbaIKpUryuvWoS3MpipcaoHQE=;
        b=u2/P2UutShyLs90eak/m6QLL04O7cRN+JZAkhrE8f+z9DjCMSX95ZNC87D+sZSS5t8
         h3wPJTJuDUl/E4QXD+CapkoD9YtQIVCZbDSD9Wq4lDatTDTkrWRDb/r/GyfWCBaC3Z9b
         Dm+Gsfqic/jih/p1ritxsJ8xf5/bVWJgoLjw1N64pa8sr+3qh13Q14OGQ4T4bT8Rrls3
         qUSFB21N0/1pgX6uZEPdQqC2KLZ9pFBILqpi/bngacr+DuMRPiGnRK+37bO4trxn7Zbl
         C90uOkACRua22R1Asa2+Cdz+EO/i6tRYsjuUP6f/Zm+UfnQK0FOi/9iFnvR+rj8rE+rx
         XVnw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMICWF0lfOhqhK2SZHFARmn+V3PiJMiktZhWhv+E1+sG5E+jzgxqQj4pjOaiaOZqT5NBMzW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLF8mijdcwZy4oQR8VplMJgvxujAqxTs1XIEawlAYkWIgK4XC4
	17rEj2eZHMWYu5y/prOscCmBIyOdlkWO0veICGTvgnPSKULDTK+yOqJr7DAYuqQ+IksSzMl4WVQ
	mAv77saSJ0AsgGp5sneHmFZurPepIMzGNB2MMkXHvrfRoQBXqDDk6tTU=
X-Google-Smtp-Source: AGHT+IG9K8WOrkufEOH9DrP8lMVAsJtn15VEV17W8fw+GqqGRMkAx/TAFYzoI9XWkt66axHeeciyGXYjbrh8oKDpRa1GaMLE4IpO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2206:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d9701e4da5mr24991275ab.12.1746098197408; Thu, 01 May 2025
 04:16:37 -0700 (PDT)
Date: Thu, 01 May 2025 04:16:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68135815.050a0220.3a872c.000e.GAE@google.com>
Subject: [syzbot] [net?] upstream test error: KMSAN: uninit-value in mctp_dump_addrinfo
From: syzbot <syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jk@codeconstruct.com.au, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	matt@codeconstruct.com.au, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4432656b36e Linux 6.15-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173ea374580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f944a52db88df992
dashboard link: https://syzkaller.appspot.com/bug?extid=e76d52dadc089b9d197f
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26fcd648d1b5/disk-b4432656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25ce9039317e/vmlinux-b4432656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/387f0baa5e6e/bzImage-b4432656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 rtnl_dump_all+0x3ec/0x5b0 net/core/rtnetlink.c:4380
 rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6824
 netlink_dump+0x97b/0x1690 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x716/0xd60 net/netlink/af_netlink.c:2424
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6853 [inline]
 rtnetlink_rcv_msg+0x1262/0x14b0 net/core/rtnetlink.c:6920
 netlink_rcv_skb+0x54a/0x680 net/netlink/af_netlink.c:2534
 rtnetlink_rcv+0x35/0x40 net/core/rtnetlink.c:6982
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0xed5/0x1290 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 __sys_sendto+0x590/0x710 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4167 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4262
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:577
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1340 [inline]
 netlink_alloc_large_skb+0xa5/0x280 net/netlink/af_netlink.c:1187
 netlink_sendmsg+0xaea/0x1250 net/netlink/af_netlink.c:1858
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 __sys_sendto+0x590/0x710 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5447 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


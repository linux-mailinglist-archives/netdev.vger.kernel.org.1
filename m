Return-Path: <netdev+bounces-85015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480EA898FBB
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 22:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA71C226E2
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91913849C;
	Thu,  4 Apr 2024 20:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A66FE26
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263051; cv=none; b=Jfxp2pDPSruM+XCWHxNcKpyN4Fenm/XrBwILtUjJx37qM/BLfYeZrvPaZR7phphhf/1Wg5mHbc24ivrDqWv120QeS17p0KW27lXWQnjn495AfjxUcxDGHtfcShRi61A/YOoIs2yNqZtoth8JiEdUUHJO1OzF9bKNKMxmBakd5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263051; c=relaxed/simple;
	bh=A6HoS4GzLxsx7dqdRJSNn1EbWW7af9nHv+tk7XM/mQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yya+JI4qJHGbCN6lAU50hp8Dn67afO+RNIbfp0BgBLBHuWoecWZ3h+8dmX1vYt/JkzJ8OZEyXDZTt6LeyodmISnvUasjcyHBrPquU4a2+bU+kjixvDBXPBH0Muw/jQlWf3Gt6XjpBEkhZnMzZkRVIlff0f9iRqYybPNU+iHPlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3689a0abf52so12124065ab.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 13:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263049; x=1712867849;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZzdwtDeS7G4wOc9so8v1UyHpIk8pMZqZRG7ETlZnlY=;
        b=mD2+jc1N/F/eDS6JoG7CWDOT8kxiJ2rLOseVQQp8fG45GnFWBvzuC3MhFiqOsZGndw
         pQZNeG389NPb05vrTRnb0z/YPO05nVDPM+P8wO1wMJMtFa3GYx3g9oJG/UQ1zTPT4AJ2
         PTYubARvbJ0/FlaChel2fWqp1SUUUiqkSbSHoBfb4agFhINYrFBPVfSm9AbiA+ZcW4RK
         nA5PSV1pwGpvpIx4N7Pyqc1RX8D4K5uuHujISQwm49Pio2A4cbNU59Pb8w7S+yu3mvRk
         rt42QrctyeOW0XtPj1xnH3CfGU81kw+wDE2NgylbKWKHaWtvv7znjI67Ieolu4jiGrcb
         3yGA==
X-Forwarded-Encrypted: i=1; AJvYcCXl4WVPGQJFzqdMytCCewBKpWPbDAkbEGlCAjGGcQcJsr4o0sQ6dWYGDNabb3qnHAwgBbZ84HB2VynlECuHAg28KjO1WbDZ
X-Gm-Message-State: AOJu0YyvKYd1f+3Kq9/QTnr7V6ZtX5ViY8k3yJFZgr5hxAD63zSpqS/p
	k6+Dlg1xy2F4x5/yAAwAb5zWH/86/dHoRuBGxE3yYQCDVvVXGQnFNLjjAhEX3+e2dnF1aA/nPwE
	3xLFATWXuNZdn61EdlWdeliNsPztrYQOxG9tmZL3b/3/ql3TpqOiqkZM=
X-Google-Smtp-Source: AGHT+IHH0wpbFePpiE6nTTuUuVkf34Ui7sRdZXJxbGX8wsukrvd1m3qn/Cs15Ur/7yo7smMr53WGlvlbRkjCZysIoBKE1MXFjoqv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:368:9839:d21a with SMTP id
 z13-20020a056e0217cd00b003689839d21amr24501ilu.5.1712263049093; Thu, 04 Apr
 2024 13:37:29 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:37:29 -0700
In-Reply-To: <00000000000040a883061544c59f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdb28b06154b4e94@google.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in nf_flow_offload_ip_hook
From: syzbot <syzbot+b6f07e1c07ef40199081@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c85af715cac0 Merge tag 'vboxsf-v6.9-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1123c615180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f07e1c07ef40199081
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16960955180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cfc58d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6741d41720b3/disk-c85af715.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1783406dda64/vmlinux-c85af715.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53eeb4798ae1/bzImage-c85af715.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f07e1c07ef40199081@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nf_flow_skb_encap_protocol net/netfilter/nf_flow_table_ip.c:290 [inline]
BUG: KMSAN: uninit-value in nf_flow_offload_lookup net/netfilter/nf_flow_table_ip.c:352 [inline]
BUG: KMSAN: uninit-value in nf_flow_offload_ip_hook+0x79a/0x3e40 net/netfilter/nf_flow_table_ip.c:424
 nf_flow_skb_encap_protocol net/netfilter/nf_flow_table_ip.c:290 [inline]
 nf_flow_offload_lookup net/netfilter/nf_flow_table_ip.c:352 [inline]
 nf_flow_offload_ip_hook+0x79a/0x3e40 net/netfilter/nf_flow_table_ip.c:424
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf2/0x3f0 net/netfilter/core.c:626
 nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
 nf_ingress net/core/dev.c:5318 [inline]
 __netif_receive_skb_core+0x430b/0x6190 net/core/dev.c:5406
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 netif_receive_skb_internal net/core/dev.c:5738 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5798
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb63/0x1520 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

CPU: 0 PID: 5020 Comm: syz-executor108 Not tainted 6.9.0-rc2-syzkaller-00080-gc85af715cac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


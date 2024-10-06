Return-Path: <netdev+bounces-132571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16599223C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 01:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FAF2818ED
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580B18C01F;
	Sun,  6 Oct 2024 23:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8618C009
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728256829; cv=none; b=GDCh/O1k0qyakEKUrf2hWKJs85eB8Gst7iGtiUlpTRrSAL1O8C2sWkrioqC48l08+HyZgVJawICep5azC3RnhnFoYy5V+yxh9HkkrDUINgsdRQsnoeLcRt4Gx4F+k4/pXDB7yfcqfRBEMy3hMWihQcz2B+0Hdx/U4De4xXGXbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728256829; c=relaxed/simple;
	bh=ZgFsAM3U6S72QrsrAd96UkAcvUDA35edP/Tcg92CQlA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SbJJ40OmtR6zcrHTtkrWNFmt9VEafDuYlLOwhIFDI9es9CtH0Gp7Q+/KTKnjxC2+dtR9tuTrQVYXCVuBirfAkboIzsMbs+pCdiEOLZx2Bdo4HGMtAnigCqnLvks4PXvnsnL0GNr9akzuSdC89AI/5Vt+FP9E9CKSxycSFvvRPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so37828555ab.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 16:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728256827; x=1728861627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtnlwZ9lDDGPqJ5qwzA/iRKZ8utoFDH0jUzGYWicb3g=;
        b=e4K8mZUATmvBy+uoDImpPKqCFRb57fdgUEj6olJQS8riw4TEcWJ6OMoZi8JRyxn0xT
         SgPc6s/wrmpQ4CNzFUsv7G6LXpa6V0vsEo0QNDIg2QMA0vE+sz+SxL56qPUYDlpbapmA
         /i67Ly6jn1hZvD3QkCTcwnzqLhH1YY82HU4d+hL7DdDPesUICNiKmNX6arZRcM1OAX5Y
         2voDqwX9eKrvY+0ZsztMr7yF0/pzGV9IXVEq/TWEXxEo8JALssw7AshsWwfSGF0nsW+A
         JtKBi5xXS1rDSEwMhWlnVLkQbBw1OUcgyxGNfiW8t61Cx2EkhCgDrWhtxzo/JuiGf7lV
         KhCg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Mxi+0p8Hu8rp3DlEQl97zglU8CHlkC33lBqkj1tMpZIYI+Jfp+hKcdysybOq/zm4DsWgQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6JSgvfar9i6NjC/3sF+w0/6JdocGWxOYTEAnCrpUYlFStfHs
	VxdjBSTpFKirijmFisqBU77nuls6ZXx7t8k8fu66oePkax3GUJ7PR0LxyGLpmSpORhD+mVAb6S3
	DzE32RRnDmK0eR0xszcaxEItHz7UzZ0IjnYVImuLjal07niYD6GkZUu8=
X-Google-Smtp-Source: AGHT+IEiDKBfFWE1MqSel+pRkRJk2QXs0IOi7u6ba5rSr/O09dIhHCbhqBg1AwFcDstzuaSaD/Ftueu4cw9ePU1UNchptEdD84BJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:3a0:4c4e:2e53 with SMTP id
 e9e14a558f8ab-3a37597a1e5mr82022995ab.5.1728256826711; Sun, 06 Oct 2024
 16:20:26 -0700 (PDT)
Date: Sun, 06 Oct 2024 16:20:26 -0700
In-Reply-To: <000000000000dbc80e061b01a34f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67031b3a.050a0220.49194.04e9.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet (3)
From: syzbot <syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=148c27d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
dashboard link: https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1367f307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c98327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/241996bfa3de/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/417de1b4ca32/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c793c19b953/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com

nci: nci_rf_discover_ntf_packet: unsupported rf_tech_and_mode 0xe6
=====================================================
BUG: KMSAN: uninit-value in nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
BUG: KMSAN: uninit-value in nci_ntf_packet+0x2ac6/0x39c0 net/nfc/nci/ntf.c:798
 nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
 nci_ntf_packet+0x2ac6/0x39c0 net/nfc/nci/ntf.c:798
 nci_rx_work+0x408/0x6f0 net/nfc/nci/core.c:1544
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 virtual_ncidev_write+0x67/0x380 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x487/0x1540 fs/read_write.c:681
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 2937 Comm: kworker/u8:9 Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: nfc2_nci_rx_wq nci_rx_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


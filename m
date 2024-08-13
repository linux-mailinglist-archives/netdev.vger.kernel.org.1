Return-Path: <netdev+bounces-118124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8909509D6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FF72829D7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD71A2C27;
	Tue, 13 Aug 2024 16:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B91A08B1
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565187; cv=none; b=iQUVut8rmlRfhCTRV6MH0v/YMYUoPL6Huvh8rsLp+QyDgy6MRBeHoyF7tLt72eUVae6w6+gWsnqtHv/xSa9IZMO6EwYV3GVF53y4V0LY6cT3UWp9TmnnXK8o7edmVcPNAs6VqM4j4sJeveAM6NbHYHit0yY4IeFfQru5D1SDqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565187; c=relaxed/simple;
	bh=osxsjzgNitiECq/SBdwyE2s2oovBDFFvAhX1mFzqUGk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UTiKXC9qf39mMhy3qKpkMP6lKVfqt2DJD1yPLt32lqWc3Ee38VfMvKsuucm2lxKhhWUstH8wwb5Y5H+1KfGpNe3dIhMQEwYuiDcWYe1bfnXeYoZbD1VlV//KcTVkeqYYxQ091ejbrYCuKlL1YD/gu5zSWVLrJqULA7Ncvtb5Z/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a29e7099dso68638025ab.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565184; x=1724169984;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykbbkcpytacko8+s9bFUVLNOdhAI0H/W5VsGmdB5wuI=;
        b=N+i3Z0ON7Ybfancu8WopKbByWyKlQUWgayn/s5vXq/rn5x9qA0HW/T2L9IXRx2UeCR
         Gsu0jU/VJ+4OG73hIztpaV01kJtpogcUGVI/rkwW6oTNwABAboOGQHjLqBwiYUfjqt3s
         4ybyNLvk5IlPi9gTcQU7VBruH0wXOBmOeIDSeNFcurNuOI0g+XS0KRe+8UaBcXSeWeiC
         ATwp3iXWfQbGHif4ilJO4iaakE3kKf0i7ayPg+rWtSLrvWAL0owQUDh+CDYPqwFwWcoW
         z4OIr1BXj/BxNqS22dTR+xJ9B1EIhmVT+yyWFGgJLGJ3fklwCYM8BGQfH1D3O7bi5kZN
         yElA==
X-Forwarded-Encrypted: i=1; AJvYcCUpEHWqXVsUTGgmLER84aAjuL++FNdh7Bye/MYHAFVoqGsxbSGTuEc3jj0CAFxRSUw3MwtVOPz79NTJHyQi1GidT7IQZGuH
X-Gm-Message-State: AOJu0Yx8ltxZP6hWz0p3kFpmQVJ2p8gcbftFC+WXk0gXmlV+BOimr/5v
	F87JicM6v1xp3u+SzUmVUgcTu7fN2I97Dzma0Jpr3tTqT1elHea8qihxvAtYRf2EpcPFprlsyXM
	+2Fa9BcBKovySo3zFnfwe3cQYaCWqiW+8jBkm0GRq1v09CqT1hqyM6+M=
X-Google-Smtp-Source: AGHT+IGg92pPKG7Cs8FAKggYz9CQSajARBben8jTRDK/wRFRP8TD6SMz06hccdWMpya3NFvLM+YJTqsJfjc3qVn5cpF6vjFnnjSK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2148:b0:39d:1236:a9cb with SMTP id
 e9e14a558f8ab-39d1245d10bmr71045ab.2.1723565183926; Tue, 13 Aug 2024 09:06:23
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000891434061f92ca00@google.com>
Subject: [syzbot] [net?] Internal error in desc_read_finalized_seq (3)
From: syzbot <syzbot+8cf38d61f5bd7fa6620c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a25d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=692f298d4e1a1b64
dashboard link: https://syzkaller.appspot.com/bug?extid=8cf38d61f5bd7fa6620c
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-ee9a43b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef06d3e0bb3f/vmlinux-ee9a43b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c99456df6ae9/zImage-ee9a43b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8cf38d61f5bd7fa6620c@syzkaller.appspotmail.com

Insufficient stack space to handle exception!
Task stack:     [0xdfc9c000..0xdfc9e000]
IRQ stack:      [0xdf800000..0xdf802000]
Overflow stack: [0x82cb7000..0x82cb8000]
Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 9647 Comm: syz.0.2606 Not tainted 6.11.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at desc_read_finalized_seq+0x4/0xcc kernel/printk/printk_ringbuffer.c:1869
LR is at prb_read kernel/printk/printk_ringbuffer.c:1922 [inline]
LR is at _prb_read_valid+0x94/0x2ec kernel/printk/printk_ringbuffer.c:2113
pc : [<802bf87c>]    lr : [<802bfef4>]    psr: 00000093
sp : dfc9c020  ip : dfc9c020  fp : dfc9c08c
r10: 00000000  r9 : 3fffe4e2  r8 : dfc9c098
r7 : 00000000  r6 : 000004e2  r5 : 000004e2  r4 : 82629be4
r3 : 00000000  r2 : 000004e2  r1 : 3fffe4e2  r0 : 82629be4
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 852a3180  DAC: fffffffd
Register r0 information: non-slab/vmalloc memory
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: NULL pointer
Register r4 information: non-slab/vmalloc memory
Register r5 information: non-paged memory
Register r6 information: non-paged memory
Register r7 information: NULL pointer
Register r8 information: 2-page vmalloc region starting at 0xdfc9c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r9 information: non-paged memory
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdfc9c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r12 information: 2-page vmalloc region starting at 0xdfc9c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Process syz.0.2606 (pid: 9647, stack limit = 0xdfc9c000)
Stack: (0xdfc9c020 to 0xdfc9e000)
c020: dfc9c050 ffffff04 ffff0a00 00000000 ffffff04 ffff0a00 00000001 00000000
c040: 00000000 82629c18 fffdf6bc 821c596c 00000000 00000000 00000000 45886b9b
c060: dfc9c0bc 82629bf8 000004e1 00000000 00000000 000004e1 82629be4 82629b38
c080: dfc9c0dc dfc9c090 802c0218 802bfe6c 00000000 00000039 000004e2 00000000
c0a0: 00000000 00000000 ffffdfff 00000001 00000001 45886b9b dfc9c134 00000035
c0c0: dddc5595 00000000 00000000 00000000 dfc9c0f4 dfc9c0e0 802c02f4 802c0158
c0e0: 00000000 00000035 dfc9c17c dfc9c0f8 802bcd7c 802c02e0 821c594c dfc9c214
c100: 00000000 00000070 fcb43464 00000000 000025af 821c594c 60000013 00000002
c120: 00000002 dfc9c214 826449c8 8288e6ec 00000039 82629be4 80000093 3fffe4e2
c140: 00000040 65443201 00206461 45886b9b 85191f84 00000000 ffffffff 82622918
c160: 00000000 00000000 8522be40 821c594c dfc9c1bc dfc9c180 802bdf9c 802bcae0
c180: dfc9c214 82604d40 00000002 846e0000 dfc9c1d4 836d0000 824b9fcc 00000000
c1a0: 84498000 00000000 8522be40 00000000 dfc9c1d4 dfc9c1c0 802be138 802bdea4
c1c0: dfc9c214 dfc9c1d0 dfc9c1f4 dfc9c1d8 802bf0e0 802be11c 81943764 8197e878
c1e0: 841ed840 84697000 dfc9c20c dfc9c1f8 81956874 802bf078 dfc9c214 45886b9b
c200: dfc9c2dc dfc9c220 81479cac 81956850 821c594c 844980e0 00001400 836d0000
c220: 81779b40 8024bb0c 81779b40 8024bb0c 8024bb50 8027b53c dfc9c270 006e0000
c240: fffffff4 dfc9c250 817297b0 802e3240 00000000 00000000 8508ade0 00000001
c260: dfc9c284 dfc9c270 8024bb50 8027b53c 848d6010 00000001 00000000 dfc9c288
c280: 00000001 824b8944 8514e300 824b8944 848d6040 848d6000 dfc9c384 85217200
c2a0: 00000004 8260c720 821dd058 45886b9b dfc9c354 00000000 841ed840 8520c700
c2c0: 0000000e 00000010 00000009 00000013 dfc9c33c dfc9c2e0 8170adb4 81478fc0
c2e0: 841ed840 00000000 00000000 846e0000 00000000 00000000 00000000 00000000
c300: 00000000 00000000 00000000 45886b9b 00000000 841ed840 00000009 00000000
c320: 846e0000 00000000 000005dc 00000000 dfc9c37c dfc9c340 8170f6d8 8170aa50
c340: 85216350 00000000 dfc9c37c dfc9c358 8158854c 841ed840 846e0000 00000000
c360: 00000001 84498000 849fc800 00000000 dfc9c3c4 dfc9c380 8170f88c 8170f4d0
c380: 8179368c 00000a04 849fc800 84498000 00000000 846e0000 8170f4c4 45886b9b
c3a0: 841ed840 846e0000 00000000 836d0000 00000000 84697000 dfc9c3e4 dfc9c3c8
c3c0: 81793728 8170f818 841ed840 00000000 849fc800 836d0000 dfc9c41c dfc9c3e8
c3e0: 80c20ca4 817936f4 dfc9c47b 45886b9b 00000002 841ed840 00000000 45886b9b
c400: 84498000 0000011a 84498000 836d0000 dfc9c43c dfc9c420 80c213f0 80c20918
c420: 841ed840 81b705d8 84498000 836d0000 dfc9c484 dfc9c440 81478ca0 80c213e4
c440: dfc9c484 dfc9c450 dfc9c4a8 824b9fce 82606000 0000011a 841ed840 841ed840
c460: 824b9fcc 84697000 84498000 dfc9c488 8522be40 00000000 dfc9c544 dfc9c488
c480: 81479188 81478bc8 81779b40 8024bb0c 81779b40 8024bb0c 8024bb50 8027b53c
c4a0: dfc9c4d8 006e0000 fffffff4 dfc9c4b8 817297b0 802e3240 00000000 00000000
c4c0: 8508ade0 00000001 dfc9c4ec dfc9c4d8 8024bb50 8027b53c 848d6010 00000001
c4e0: 00000000 dfc9c4f0 00000001 824b8944 8514e300 824b8944 848d6040 848d6000
c500: dfc9c5ec 85217200 00000004 8260c720 821dd058 45886b9b dfc9c5bc 00000000
c520: 841ed840 8520c700 0000000e 00000010 00000009 00000013 dfc9c5a4 dfc9c548
c540: 8170adb4 81478fc0 841ed840 00000000 00000000 846e0000 00000000 00000000
c560: 00000000 00000000 00000000 00000000 00000000 45886b9b 00000000 841ed840
c580: 00000008 00000000 846e0000 00000000 000005dc 00000000 dfc9c5e4 dfc9c5a8
c5a0: 8170f6d8 8170aa50 85216350 00000000 dfc9c5e4 dfc9c5c0 8158854c 841ed840
c5c0: 846e0000 00000000 00000001 84498000 849fc800 00000000 dfc9c62c dfc9c5e8
c5e0: 8170f88c 8170f4d0 8179368c 00000a04 849fc800 84498000 00000000 846e0000
c600: 8170f4c4 45886b9b 841ed840 846e0000 00000000 836d0000 00000000 84697000
c620: dfc9c64c dfc9c630 81793728 8170f818 841ed840 00000000 849fc800 836d0000
c640: dfc9c684 dfc9c650 80c20ca4 817936f4 dfc9c6e3 45886b9b 00000002 841ed840
c660: 00000000 45886b9b 84498000 0000011a 84498000 836d0000 dfc9c6a4 dfc9c688
c680: 80c213f0 80c20918 841ed840 81b705d8 84498000 836d0000 dfc9c6ec dfc9c6a8
c6a0: 81478ca0 80c213e4 dfc9c6ec dfc9c6b8 dfc9c710 824b9fce 82606000 0000011a
c6c0: 841ed840 841ed840 824b9fcc 84697000 84498000 dfc9c6f0 8522be40 00000000
c6e0: dfc9c7ac dfc9c6f0 81479188 81478bc8 81779b40 8024bb0c 81779b40 8024bb0c
c700: 8024bb50 8027b53c dfc9c740 006e0000 fffffff4 dfc9c720 817297b0 802e3240
c720: 00000000 00000000 8508ade0 00000001 dfc9c754 dfc9c740 8024bb50 8027b53c
c740: 848d6010 00000001 00000000 dfc9c758 00000001 824b8944 8514e300 824b8944
c760: 848d6040 848d6000 dfc9c854 85217200 00000004 8260c720 821dd058 45886b9b
c780: dfc9c824 00000000 841ed840 8520c700 0000000e 00000010 00000009 00000013
c7a0: dfc9c80c dfc9c7b0 8170adb4 81478fc0 841ed840 00000000 00000000 846e0000
c7c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 45886b9b
c7e0: 00000000 841ed840 00000007 00000000 846e0000 00000000 000005dc 00000000
c800: dfc9c84c dfc9c810 8170f6d8 8170aa50 85216350 00000000 dfc9c84c dfc9c828
c820: 8158854c 841ed840 846e0000 00000000 00000001 84498000 849fc800 00000000
c840: dfc9c894 dfc9c850 8170f88c 8170f4d0 8179368c 00000a04 849fc800 84498000
c860: 00000000 846e0000 8170f4c4 45886b9b 841ed840 846e0000 00000000 836d0000
c880: 00000000 84697000 dfc9c8b4 dfc9c898 81793728 8170f818 841ed840 00000000
c8a0: 849fc800 836d0000 dfc9c8ec dfc9c8b8 80c20ca4 817936f4 dfc9c94b 45886b9b
c8c0: 00000002 841ed840 00000000 45886b9b 84498000 0000011a 84498000 836d0000
c8e0: dfc9c90c dfc9c8f0 80c213f0 80c20918 841ed840 81b705d8 84498000 836d0000
c900: dfc9c954 dfc9c910 81478ca0 80c213e4 dfc9c954 dfc9c920 dfc9c978 824b9fce
c920: 82606000 0000011a 841ed840 841ed840 824b9fcc 84697000 84498000 dfc9c958
c940: 8522be40 00000000 dfc9ca14 dfc9c958 81479188 81478bc8 81779b40 8024bb0c
c960: 81779b40 8024bb0c 8024bb50 8027b53c dfc9c9a8 006e0000 fffffff4 dfc9c988
c980: 817297b0 802e3240 00000000 00000000 8508ade0 00000001 dfc9c9bc dfc9c9a8
c9a0: 8024bb50 8027b53c 848d6010 00000001 00000000 dfc9c9c0 00000001 824b8944
c9c0: 8514e300 824b8944 848d6040 848d6000 dfc9cabc 85217200 00000004 8260c720
c9e0: 821dd058 45886b9b dfc9ca8c 00000000 841ed840 8520c700 0000000e 00000010
ca00: 00000009 00000013 dfc9ca74 dfc9ca18 8170adb4 81478fc0 841ed840 00000000
ca20: 00000000 846e0000 00000000 00000000 00000000 00000000 00000000 00000000
ca40: 00000000 45886b9b 00000000 841ed840 00000006 00000000 846e0000 00000000
ca60: 000005dc 00000000 dfc9cab4 dfc9ca78 8170f6d8 8170aa50 85216350 00000000
ca80: dfc9cab4 dfc9ca90 8158854c 841ed840 846e0000 00000000 00000001 84498000
caa0: 849fc800 00000000 dfc9cafc dfc9cab8 8170f88c 8170f4d0 8179368c 00000a04
cac0: 849fc800 84498000 00000000 846e0000 8170f4c4 45886b9b 841ed840 846e0000
cae0: 00000000 836d0000 00000000 84697000 dfc9cb1c dfc9cb00 81793728 8170f818
cb00: 841ed840 00000000 849fc800 836d0000 dfc9cb54 dfc9cb20 80c20ca4 817936f4
cb20: dfc9cbb3 45886b9b 00000002 841ed840 00000000 45886b9b 84498000 0000011a
cb40: 84498000 836d0000 dfc9cb74 dfc9cb58 80c213f0 80c20918 841ed840 81b705d8
cb60: 84498000 836d0000 dfc9cbbc dfc9cb78 81478ca0 80c213e4 dfc9cbbc dfc9cb88
cb80: dfc9cbe0 824b9fce 82606000 0000011a 841ed840 841ed840 824b9fcc 84697000
cba0: 84498000 dfc9cbc0 8522be40 00000000 dfc9cc7c dfc9cbc0 81479188 81478bc8
cbc0: 81779b40 8024bb0c 81779b40 8024bb0c 8024bb50 8027b53c dfc9cc10 006e0000
cbe0: fffffff4 dfc9cbf0 817297b0 802e3240 00000000 00000000 8508ade0 00000001
cc00: dfc9cc24 dfc9cc10 8024bb50 8027b53c 848d6010 00000001 00000000 dfc9cc28
cc20: 00000001 824b8944 8514e300 824b8944 848d6040 848d6000 dfc9cd24 85217200
cc40: 00000004 8260c720 821dd058 45886b9b dfc9ccf4 00000000 841ed840 8520c700
cc60: 0000000e 00000010 00000009 00000013 dfc9ccdc dfc9cc80 8170adb4 81478fc0
cc80: 841ed840 00000000 00000000 846e0000 00000000 00000000 00000000 00000000
cca0: 00000000 00000000 00000000 45886b9b 00000000 841ed840 00000005 00000000
ccc0: 846e0000 00000000 000005dc 00000000 dfc9cd1c dfc9cce0 8170f6d8 8170aa50
cce0: 85216350 00000000 dfc9cd1c dfc9ccf8 8158854c 841ed840 846e0000 00000000
cd00: 00000001 84498000 849fc800 00000000 dfc9cd64 dfc9cd20 8170f88c 8170f4d0
cd20: 8179368c 00000a04 849fc800 84498000 00000000 846e0000 8170f4c4 45886b9b
cd40: 841ed840 846e0000 00000000 836d0000 00000000 84697000 dfc9cd84 dfc9cd68
cd60: 81793728 8170f818 841ed840 00000000 849fc800 836d0000 dfc9cdbc dfc9cd88
cd80: 80c20ca4 817936f4 dfc9ce1b 45886b9b 00000002 841ed840 00000000 45886b9b
cda0: 84498000 0000011a 84498000 836d0000 dfc9cddc dfc9cdc0 80c213f0 80c20918
cdc0: 841ed840 81b705d8 84498000 836d0000 dfc9ce24 dfc9cde0 81478ca0 80c213e4
cde0: dfc9ce24 dfc9cdf0 dfc9ce48 824b9fce 82606000 0000011a 841ed840 841ed840
ce00: 824b9fcc 84697000 84498000 dfc9ce28 8522be40 00000000 dfc9cee4 dfc9ce28
ce20: 81479188 81478bc8 81779b40 8024bb0c 81779b40 8024bb0c 8024bb50 8027b53c
ce40: dfc9ce78 006e0000 fffffff4 dfc9ce58 817297b0 802e3240 00000000 00000000
ce60: 8508ade0 00000001 dfc9ce8c dfc9ce78 8024bb50 8027b53c 848d6010 00000001
ce80: 00000000 dfc9ce90 00000001 824b8944 8514e300 824b8944 848d6040 848d6000
cea0: dfc9cf8c 85217200 00000004 8260c720 821dd058 45886b9b dfc9cf5c 00000000
cec0: 841ed840 8520c700 0000000e 00000010 00000009 00000013 dfc9cf44 dfc9cee8
cee0: 8170adb4 81478fc0 841ed840 00000000 00000000 846e0000 00000000 00000000
cf00: 00000000 00000000 00000000 00000000 00000000 45886b9b 00000000 841ed840
cf20: 00000004 00000000 846e0000 00000000 000005dc 00000000 dfc9cf84 dfc9cf48
cf40: 8170f6d8 8170aa50 85216350 00000000 dfc9cf84 dfc9cf60 8158854c 841ed840
cf60: 846e0000 00000000 00000001 84498000 849fc800 00000000 dfc9cfcc dfc9cf88
cf80: 8170f88c 8170f4d0 8179368c 00000a04 849fc800 84498000 00000000 846e0000
cfa0: 8170f4c4 45886b9b 841ed840 846e0000 00000000 836d0000 00000000 84697000
cfc0: dfc9cfec dfc9cfd0 81793728 8170f818 841ed840 00000000 849fc800 836d0000
cfe0: dfc9d024 dfc9cff0 80c20ca4 817936f4 dfc9d083 45886b9b 00000002 841ed840
d000: 00000000 45886b9b 84498000 0000011a 84498000 836d0000 dfc9d044 dfc9d028
d020: 80c213f0 80c20918 841ed840 81b705d8 84498000 836d0000 dfc9d08c dfc9d048
d040: 81478ca0 80c213e4 dfc9d08c dfc9d058 dfc9d0b0 824b9fce 82606000 0000011a
d060: 841ed840 841ed840 824b9fcc 84697000 84498000 dfc9d090 8522be40 00000000
d080: dfc9d14c dfc9d090 81479188 81478bc8 81779b40 8024bb0c 81779b40 8024bb0c
d0a0: 8024bb50 8027b53c dfc9d0e0 006e0000 fffffff4 dfc9d0c0 817297b0 802e3240
d0c0: 00000000 00000000 8508ade0 00000001 dfc9d0f4 dfc9d0e0 8024bb50 8027b53c
d0e0: 848d6010 00000001 00000000 dfc9d0f8 00000001 824b8944 8514e300 824b8944
d100: 848d6040 848d6000 dfc9d1f4 85217200 00000004 8260c720 821dd058 45886b9b
d120: dfc9d1c4 00000000 841ed840 8520c700 0000000e 00000010 00000009 00000013
d140: dfc9d1ac dfc9d150 8170adb4 81478fc0 841ed840 00000000 00000000 846e0000
d160: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 45886b9b
d180: 00000000 841ed840 00000003 00000000 846e0000 00000000 000005dc 00000000
d1a0: dfc9d1ec dfc9d1b0 8170f6d8 8170aa50 85216350 00000000 dfc9d1ec dfc9d1c8
d1c0: 8158854c 841ed840 846e0000 00000000 00000001 84498000 849fc800 00000000
d1e0: dfc9d234 dfc9d1f0 8170f88c 8170f4d0 8179368c 00000a04 849fc800 84498000
d200: 00000000 846e0000 8170f4c4 45886b9b 841ed840 846e0000 00000000 836d0000
d220: 00000000 84697000 dfc9d254 dfc9d238 81793728 8170f818 841ed840 00000000
d240: 849fc800 836d0000 dfc9d28c dfc9d258 80c20ca4 817936f4 dfc9d2eb 45886b9b
d260: 00000002 841ed840 00000000 45886b9b 84498000 0000011a 84498000 836d0000
d280: dfc9d2ac dfc9d290 80c213f0 80c20918 841ed840 81b705d8 84498000 836d0000
d2a0: dfc9d2f4 dfc9d2b0 81478ca0 80c213e4 dfc9d2f4 dfc9d2c0 dfc9d318 824b9fce
d2c0: 82606000 0000011a 841ed840 841ed840 824b9fcc 84697000 84498000 dfc9d2f8
d2e0: 8522be40 00000000 dfc9d3b4 dfc9d2f8 81479188 81478bc8 81779b40 8024bb0c
d300: 81779b40 8024bb0c 8024bb50 8027b53c dfc9d348 006e0000 fffffff4 dfc9d328
d320: 817297b0 802e3240 00000000 00000000 8508ade0 00000001 dfc9d35c dfc9d348
d340: 8024bb50 8027b53c 848d6010 00000001 00000000 dfc9d360 00000001 824b8944
d360: 8514e300 824b8944 848d6040 848d6000 dfc9d45c 85217200 00000004 8260c720
d380: 821dd058 45886b9b dfc9d42c 00000000 841ed840 8520c700 0000000e 00000010
d3a0: 00000009 00000013 dfc9d414 dfc9d3b8 8170adb4 81478fc0 841ed840 00000000
d3c0: 00000000 846e0000 00000000 00000000 00000000 00000000 00000000 00000000
d3e0: 00000000 45886b9b 00000000 841ed840 00000002 00000000 846e0000 00000000
d400: 000005dc 00000000 dfc9d454 dfc9d418 8170f6d8 8170aa50 85216350 00000000
d420: dfc9d454 dfc9d430 8158854c 841ed840 846e0000 00000000 00000001 84498000
d440: 849fc800 00000000 dfc9d49c dfc9d458 8170f88c 8170f4d0 8179368c 00000a04
d460: 849fc800 84498000 00000000 846e0000 8170f4c4 45886b9b 841ed840 846e0000
d480: 00000000 836d0000 00000000 84697000 dfc9d4bc dfc9d4a0 81793728 8170f818
d4a0: 841ed840 00000000 849fc800 836d0000 dfc9d4f4 dfc9d4c0 80c20ca4 817936f4
d4c0: dfc9d553 45886b9b 00000002 841ed840 00000000 45886b9b 84498000 0000011a
d4e0: 84498000 836d0000 dfc9d514 dfc9d4f8 80c213f0 80c20918 841ed840 81b705d8
d500: 84498000 836d0000 dfc9d55c dfc9d518 81478ca0 80c213e4 dfc9d55c dfc9d528
d520: dfc9d580 824b9fce 82606000 0000011a 841ed840 841ed840 824b9fcc 84697000
d540: 84498000 dfc9d560 8522be40 00000000 dfc9d61c dfc9d560 81479188 81478bc8
d560: 81779b40 8024bb0c 81779b40 8024bb0c 8024bb50 8027b53c dfc9d5b0 006e0000
d580: fffffff4 dfc9d590 817297b0 802e3240 00000000 00000000 8508ade0 00000001
d5a0: dfc9d5c4 dfc9d5b0 8024bb50 8027b53c 848d6010 00000001 00000000 dfc9d5c8
d5c0: 00000001 824b8944 8514e300 824b8944 848d6040 848d6000 dfc9d6c4 85217200
d5e0: 00000004 8260c720 821dd058 45886b9b dfc9d694 00000000 841ed840 8520c700
d600: 0000000e 00000010 00000009 00000013 dfc9d67c dfc9d620 8170adb4 81478fc0
d620: 841ed840 00000000 00000000 846e0000 00000000 00000000 00000000 00000000
d640: 00000000 00000000 00000000 45886b9b 00000000 841ed840 00000001 00000000
d660: 846e0000 00000000 000005dc 00000000 dfc9d6bc dfc9d680 8170f6d8 8170aa50
d680: 85216350 00000000 dfc9d6bc dfc9d698 8158854c 841ed840 846e0000 00000000
d6a0: 00000001 84498000 849fc800 00000000 dfc9d704 dfc9d6c0 8170f88c 8170f4d0
d6c0: 8179368c 00000a04 849fc800 84498000 00000000 846e0000 8170f4c4 45886b9b
d6e0: 841ed840 846e0000 00000000 836d0000 00000000 84697000 dfc9d724 dfc9d708
d700: 81793728 8170f818 841ed840 00000000 849fc800 836d0000 dfc9d75c dfc9d728
d720: 80c20ca4 817936f4 8020d078 45886b9b dfc9d74c 841ed840 00000000 45886b9b
d740: 84498000 0000011a 84498000 836d0000 dfc9d77c dfc9d760 80c213f0 80c20918
d760: 841ed840 81b705d8 84498000 836d0000 dfc9d7c4 dfc9d780 81478ca0 80c213e4
d780: dfc9d7c4 dfc9d790 dfc9d7e8 824b9fce 82606000 0000011a 841ed840 841ed840
d7a0: 824b9fcc 84697000 84498000 dfc9d7c8 8522be40 00000000 dfc9d884 dfc9d7c8
d7c0: 81479188 81478bc8 836d0000 00000001 827e11dc 851a9ac0 dfc9d804 dfc9d7e8
d7e0: 8020c014 0020cff0 fffffff4 00000201 8197eac4 0000dd86 dfc9d844 dfc9d808
d800: 8020d078 8020bffc 8197e778 00000000 8148a10c dfc9d8b4 dfc9d888 8027cfb4
d820: 8148a10c 00000000 00000000 45886b9b 000086dd 8520c760 dfc9d864 dfc9d848
d840: 814ebd10 81453100 814ebcec 00000000 841ed840 45886b9b dfc9d884 8520c700
d860: 00000000 841ed840 80c21000 84498000 00000009 00000013 dfc9d8b4 dfc9d888
d880: 8148a0d0 81478fc0 00000000 0000010c dfc9d8b4 84498000 841ed840 8520c700
d8a0: 8509ec68 84bee800 dfc9d914 dfc9d8b8 8170acdc 81489fbc 841ed840 00000000
d8c0: 00000000 846e0000 00000000 00000000 00000000 00000000 00000000 00000000
d8e0: 00000000 45886b9b 00000000 841ed840 00000000 8418b440 846e0000 00000000
d900: 000005dc 8509ec00 dfc9d954 dfc9d918 8170f6d8 8170aa50 85216350 8509ec00
d920: dfc9d954 dfc9d930 8158854c 841ed840 846e0000 8418b440 00000001 84498000
d940: 00000000 8509ec00 dfc9d99c dfc9d958 8170f88c 8170f4d0 841ed840 00000a04
d960: 00000000 84498000 8418b440 846e0000 8170f4c4 45886b9b 841ed840 00000001
d980: 8418b440 8367da20 8509ec68 846e0000 dfc9da6c dfc9d9a0 8170b6f0 8170f818
d9a0: 00000000 00000000 00000000 00000050 84498000 8367da58 000000e4 00000000
d9c0: 8522be40 84bee800 84000000 8367da48 00000a03 00000000 84498000 8418b440
d9e0: 846e0000 81709ee0 00030000 00000000 00840000 00000000 00000000 00000000
da00: 00000000 00000000 dad00000 dad00000 00000000 00000000 00000000 00000000
da20: 0b1414ac 000000fc 00000000 00000000 00000000 00000000 00000000 45886b9b
da40: 00000000 841ed840 8367da00 8418b890 8418b440 8522be40 00000002 dfc9dba4
da60: dfc9db1c dfc9da70 81839334 8170b3c4 00000000 00000002 00000000 00000000
da80: 8181047c 45886b9b 836d0000 00000000 000000e4 8367da20 dfc9dab4 dfc9daa8
daa0: 8182be00 80827ce0 dfc9db1c dfc9dab8 81455438 8182bde8 84096840 45886b9b
dac0: dfc9daec 84096840 84096850 841ed840 00000000 000000d8 00000000 dfc9dba4
dae0: dfc9db04 dfc9daf0 8181047c 45886b9b 84096840 8367da00 dfc9db9c 8509ec78
db00: dfc9dba4 841ed840 00000000 dfc9dba4 dfc9db94 dfc9db20 8182cd78 8183908c
db20: 81c7d198 8020cff0 dfc9db5c dfc9db38 8182bf8c 808254d0 841ed840 00000000
db40: 821e60ec 00000001 845e0800 8367da00 00000000 8418b440 00000000 00000cc0
db60: 8367da00 841ed840 00840005 8367da00 84096840 00000cc0 00000000 0000d0da
db80: 00000000 845e0bb4 dfc9dbec dfc9db98 81816f50 8182c7cc 40000093 0000d0da
dba0: 00000000 dfc9dba4 dfc9dba4 00000034 0000010c 00010000 8367da00 00000000
dbc0: 00000000 45886b9b dfc9dc38 00000000 84096840 84096840 845e0bcc 845e0800
dbe0: dfc9dc7c dfc9dbf0 81818760 81816ecc 81a03ea0 45886b9b 845e0a5c 845e0a5c
dc00: 845e0a5c dddc6200 dfc9dc24 dfc9dc18 8197e89c 8027b53c dfc9dc7c dfc9dc28
dc20: 802fac68 00000000 845e0bb4 82604d40 845e0bb4 8367da00 8367dbc0 8367dbc0
dc40: 845e0800 8367db98 00000cc0 45886b9b 00000000 dfc9dd4c 845e0800 00000004
dc60: 84096840 00000000 845e0800 00000001 dfc9dc8c dfc9dc80 81819124 81817c18
dc80: dfc9ddac dfc9dc90 81808094 81819108 00000000 dfc9dcd4 8182d6c8 8292010c
dca0: 00000000 00000000 00000000 00000003 0000012c 00000000 8418b440 00000001
dcc0: 82ea8cc0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dce0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dd00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dd20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dd40: 00000000 00000000 00000000 84096840 0000000c 00000002 00000012 845e0800
dd60: 00000001 84096840 00000016 00000001 00000003 dfc9dd4c dfc9dd4c 45886b9b
dd80: 00000400 8418b440 8375eb40 0000001c dfc9de54 0000001c 8375eb40 845e0800
dda0: dfc9ddcc dfc9ddb0 8182bc14 81806ccc 82ea8cc0 845e0800 00000000 00000cc0
ddc0: dfc9de24 dfc9ddd0 81825bc8 8182bbe4 0000001c 82205adc 0000001c 8375eb40
dde0: 00000002 00000000 b5403587 8367da00 00000000 45886b9b 806e5418 0000001c
de00: 8418b440 8375eb40 dfc9de54 b5003500 b5403587 00000000 dfc9de4c dfc9de28
de20: 81825dc0 81825958 dfc9de54 80461d74 8375eb40 8418b440 20000000 20000180
de40: dfc9de8c dfc9de50 81825ef0 81825d5c 8418b440 00000000 00000000 0000001c
de60: 200002c0 45886b9b 8418b440 0000006f 20000000 00000010 20000180 836d0000
de80: dfc9dedc dfc9de90 8182a728 81825e10 00000000 00000000 00000000 00000010
dea0: 00000000 45886b9b ffffffff 45886b9b 0000006f 81829f48 00000084 00000000
dec0: 0000006f 833ca780 20000180 8144ab94 dfc9defc dfc9dee0 8144abbc 81829f54
dee0: 20000180 00000084 00000000 00000000 dfc9df4c dfc9df00 814479b4 8144aba0
df00: 20000180 0000006f 20000000 8020029c 836d0000 00000127 00000000 45886b9b
df20: 80527b84 00000000 00000084 0000006f 20000000 833ca780 836d0000 00000127
df40: dfc9dfa4 dfc9df50 81449934 8144789c 20000000 00000000 20000180 00000000
df60: 8261c9cc fffffff7 00000001 20000000 00000000 20000180 00000000 45886b9b
df80: 8020c920 20000180 00000000 002662f0 00000127 8020029c 00000000 dfc9dfa8
dfa0: 80200060 814498b0 20000180 00000000 00000003 00000084 0000006f 20000000
dfc0: 20000180 00000000 002662f0 00000127 00000000 00006364 003d0f00 76b2a0bc
dfe0: 76b29ec0 76b29eb0 000188c0 00132780 60000010 00000003 00000000 00000000
Call trace: 
[<802bfe60>] (_prb_read_valid) from [<802c0218>] (desc_update_last_finalized+0xcc/0x188 kernel/printk/printk_ringbuffer.c:1515)
 r10:82629b38 r9:82629be4 r8:000004e1 r7:00000000 r6:00000000 r5:000004e1
 r4:82629bf8
[<802c014c>] (desc_update_last_finalized) from [<802c02f4>] (prb_final_commit+0x20/0x24 kernel/printk/printk_ringbuffer.c:1782)
 r9:00000000 r8:00000000 r7:00000000 r6:dddc5595 r5:00000035 r4:dfc9c134
[<802c02d4>] (prb_final_commit) from [<802bcd7c>] (vprintk_store+0x2a8/0x450 kernel/printk/printk.c:2295)
 r5:00000035 r4:00000000
[<802bcad4>] (vprintk_store) from [<802bdf9c>] (vprintk_emit+0x104/0x278 kernel/printk/printk.c:2329)
 r10:821c594c r9:8522be40 r8:00000000 r7:00000000 r6:82622918 r5:ffffffff
 r4:00000000
[<802bde98>] (vprintk_emit) from [<802be138>] (vprintk_default+0x28/0x30 kernel/printk/printk.c:2363)
 r10:00000000 r9:8522be40 r8:00000000 r7:84498000 r6:00000000 r5:824b9fcc
 r4:836d0000
[<802be110>] (vprintk_default) from [<802bf0e0>] (vprintk+0x74/0x94 kernel/printk/printk_safe.c:45)
[<802bf06c>] (vprintk) from [<81956874>] (_printk+0x34/0x58 kernel/printk/printk.c:2373)
 r6:84697000 r4:841ed840
[<81956840>] (_printk) from [<81479cac>] (__dev_queue_xmit+0xcf8/0xf0c net/core/dev.c:4438)
 r3:836d0000 r2:00001400 r1:844980e0 r0:821c594c
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000009
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9c488 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000008
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9c6f0 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000007
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9c958 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000006
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9cbc0 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000005
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9ce28 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000004
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9d090 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000003
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9d2f8 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000002
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9d560 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8170adb4>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:8520c700 r5:841ed840
 r4:00000000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:846e0000 r6:00000000 r5:00000001
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:849fc800 r8:84498000 r7:00000001 r6:00000000 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<81793728>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<81793728>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:84697000 r8:00000000 r7:836d0000 r6:00000000 r5:846e0000 r4:841ed840
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<817936e8>] (ip6_local_out) from [<80c20ca4>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:836d0000 r6:849fc800 r5:00000000 r4:841ed840
[<80c2090c>] (ipvlan_queue_xmit) from [<80c213f0>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:836d0000 r6:84498000 r5:0000011a r4:84498000
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (xmit_one net/core/dev.c:3580 [inline])
[<80c213d8>] (ipvlan_start_xmit) from [<81478ca0>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:836d0000 r6:84498000 r5:81b705d8 r4:841ed840
[<81478bbc>] (dev_hard_start_xmit) from [<81479188>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:8522be40 r8:dfc9d7c8 r7:84498000 r6:84697000 r5:824b9fcc
 r4:841ed840
[<81478fb4>] (__dev_queue_xmit) from [<8148a0d0>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8148a0d0>] (neigh_resolve_output net/core/neighbour.c:1565 [inline])
[<81478fb4>] (__dev_queue_xmit) from [<8148a0d0>] (neigh_resolve_output+0x120/0x204 net/core/neighbour.c:1545)
 r10:00000013 r9:00000009 r8:84498000 r7:80c21000 r6:841ed840 r5:00000000
 r4:8520c700
[<81489fb0>] (neigh_resolve_output) from [<8170acdc>] (neigh_output include/net/neighbour.h:542 [inline])
[<81489fb0>] (neigh_resolve_output) from [<8170acdc>] (ip6_finish_output2+0x298/0x974 net/ipv6/ip6_output.c:137)
 r8:84bee800 r7:8509ec68 r6:8520c700 r5:841ed840 r4:84498000
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170aa44>] (ip6_finish_output2) from [<8170f6d8>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:8509ec00 r9:000005dc r8:00000000 r7:846e0000 r6:8418b440 r5:00000000
 r4:841ed840
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f4c4>] (ip6_finish_output) from [<8170f88c>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:8509ec00 r9:00000000 r8:84498000 r7:00000001 r6:8418b440 r5:846e0000
 r4:841ed840
[<8170f80c>] (ip6_output) from [<8170b6f0>] (dst_output include/net/dst.h:450 [inline])
[<8170f80c>] (ip6_output) from [<8170b6f0>] (NF_HOOK include/linux/netfilter.h:314 [inline])
[<8170f80c>] (ip6_output) from [<8170b6f0>] (NF_HOOK include/linux/netfilter.h:308 [inline])
[<8170f80c>] (ip6_output) from [<8170b6f0>] (ip6_xmit+0x338/0x74c net/ipv6/ip6_output.c:358)
 r9:846e0000 r8:8509ec68 r7:8367da20 r6:8418b440 r5:00000001 r4:841ed840
[<8170b3b8>] (ip6_xmit) from [<81839334>] (sctp_v6_xmit+0x2b4/0x344 net/sctp/ipv6.c:248)
 r10:dfc9dba4 r9:00000002 r8:8522be40 r7:8418b440 r6:8418b890 r5:8367da00
 r4:841ed840
[<81839080>] (sctp_v6_xmit) from [<8182cd78>] (sctp_packet_transmit+0x5b8/0xa04 net/sctp/output.c:653)
 r10:dfc9dba4 r9:00000000 r8:841ed840 r7:dfc9dba4 r6:8509ec78 r5:dfc9db9c
 r4:8367da00
[<8182c7c0>] (sctp_packet_transmit) from [<81816f50>] (sctp_packet_singleton+0x90/0xe4 net/sctp/outqueue.c:783)
 r10:845e0bb4 r9:00000000 r8:0000d0da r7:00000000 r6:00000cc0 r5:84096840
 r4:8367da00
[<81816ec0>] (sctp_packet_singleton) from [<81818760>] (sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline])
[<81816ec0>] (sctp_packet_singleton) from [<81818760>] (sctp_outq_flush+0xb54/0xba4 net/sctp/outqueue.c:1212)
 r9:845e0800 r8:845e0bcc r7:84096840 r6:84096840 r5:00000000 r4:dfc9dc38
[<81817c0c>] (sctp_outq_flush) from [<81819124>] (sctp_outq_uncork+0x28/0x2c net/sctp/outqueue.c:764)
 r10:00000001 r9:845e0800 r8:00000000 r7:84096840 r6:00000004 r5:845e0800
 r4:dfc9dd4c
[<818190fc>] (sctp_outq_uncork) from [<81808094>] (sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline])
[<818190fc>] (sctp_outq_uncork) from [<81808094>] (sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline])
[<818190fc>] (sctp_outq_uncork) from [<81808094>] (sctp_do_sm+0x13d4/0x1848 net/sctp/sm_sideeffect.c:1169)
[<81806cc0>] (sctp_do_sm) from [<8182bc14>] (sctp_primitive_ASSOCIATE+0x3c/0x44 net/sctp/primitive.c:73)
 r10:845e0800 r9:8375eb40 r8:0000001c r7:dfc9de54 r6:0000001c r5:8375eb40
 r4:8418b440
[<8182bbd8>] (sctp_primitive_ASSOCIATE) from [<81825bc8>] (__sctp_connect+0x27c/0x334 net/sctp/socket.c:1234)
[<8182594c>] (__sctp_connect) from [<81825dc0>] (__sctp_setsockopt_connectx+0x70/0xb4 net/sctp/socket.c:1336)
 r10:00000000 r9:b5403587 r8:b5003500 r7:dfc9de54 r6:8375eb40 r5:8418b440
 r4:0000001c
[<81825d50>] (__sctp_setsockopt_connectx) from [<81825ef0>] (sctp_getsockopt_connectx3+0xec/0x198 net/sctp/socket.c:1421)
 r7:20000180 r6:20000000 r5:8418b440 r4:8375eb40
[<81825e04>] (sctp_getsockopt_connectx3) from [<8182a728>] (sctp_getsockopt+0x7e0/0x1c90 net/sctp/socket.c:8133)
 r9:836d0000 r8:20000180 r7:00000010 r6:20000000 r5:0000006f r4:8418b440
[<81829f48>] (sctp_getsockopt) from [<8144abbc>] (sock_common_getsockopt+0x28/0x30 net/core/sock.c:3708)
 r10:8144ab94 r9:20000180 r8:833ca780 r7:0000006f r6:00000000 r5:00000084
 r4:81829f48
[<8144ab94>] (sock_common_getsockopt) from [<814479b4>] (do_sock_getsockopt+0x124/0x2a0 net/socket.c:2386)
 r4:00000000
[<81447890>] (do_sock_getsockopt) from [<81449934>] (__sys_getsockopt net/socket.c:2415 [inline])
[<81447890>] (do_sock_getsockopt) from [<81449934>] (__do_sys_getsockopt net/socket.c:2425 [inline])
[<81447890>] (do_sock_getsockopt) from [<81449934>] (sys_getsockopt+0x90/0xd4 net/socket.c:2422)
 r10:00000127 r9:836d0000 r8:833ca780 r7:20000000 r6:0000006f r5:00000084
 r4:00000000
[<814498a4>] (sys_getsockopt) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdfc9dfa8 to 0xdfc9dff0)
dfa0:                   20000180 00000000 00000003 00000084 0000006f 20000000
dfc0: 20000180 00000000 002662f0 00000127 00000000 00006364 003d0f00 76b2a0bc
dfe0: 76b29ec0 76b29eb0 000188c0 00132780
 r8:8020029c r7:00000127 r6:002662f0 r5:00000000 r4:20000180
Code: e89daff0 e3e00000 eafffffb e1a0c00d (e92ddb70) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e89daff0 	ldm	sp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, pc}
   4:	e3e00000 	mvn	r0, #0
   8:	eafffffb 	b	0xfffffffc
   c:	e1a0c00d 	mov	ip, sp
* 10:	e92ddb70 	push	{r4, r5, r6, r8, r9, fp, ip, lr, pc} <-- trapping instruction


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


Return-Path: <netdev+bounces-116401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B00394A53D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62151F21B3A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED61DD38F;
	Wed,  7 Aug 2024 10:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329811DD389
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025846; cv=none; b=I+gdCY+Im/X9Xi77GPxduNyeZ832+RuWc/azw3/lX4ojf7U0VNYEHdJGV0CJF4puIZV/PZ3Nxqw0+WWbullbb/8G2g8EV1na4PfHdN6RqbKuqbahVaWdxQXgZmNmcpY+OaqFOCvtaF+OoKSxPIZaTre1q3qI4rqKA6X76vKTcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025846; c=relaxed/simple;
	bh=KpGa2H+qNx+HN83Tgkzh4cL0PkRMmDKjlFe09hDDuSI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O9daRzLbrbGKvgI8mAGP+E8L/tC5HBAAyfvCKzdMxMIS7uf3bXhg+lCYq03iC0Hzxbb7VVBgl/RN61SqT/7kJhXO/x8bZojcLY7V4xyv6pMnfnXXU4w7Dnu9do0eakSHunKbjACuo0bR46m7EThjpjkXhC1mnl2DMv+fiT9GH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81faf98703eso190465539f.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 03:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025842; x=1723630642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LOIribQH56X98JMiZ9c4FBztUrlCcnc9yV/B4TL1h8=;
        b=CTyq8RF5UTIEWWi7qii3oTPd8tAn1ZwAe9E0Me+gCfqcxRbwZo1fFF2kWtzYJpQTJ1
         LTN3Sx+Or1CSOTzpSN+FQ9CnMaQf7gEojGnZDUuxn3rqA/DFGyJd7kgNZivm3Q8hg2eY
         9JCg+kDtmniyii8yPWPQBG5Xuogt3MNGtsyWjhuzyDRGgwUxjSK6SnJCZZO5eqZRQFlW
         N84Ws2P+/eiQtvumCdGudH5V2uVkAOkSl5nJ+2fBYMCEQdcO3ImZ7LpoS0qMy4MQ3OCg
         FM61tzN6zCaxqTvDUYOQYT5ypeK9F7ruX9AgFWgz/tP5FCRV/BUwCZDc40vSTNhBerWy
         hOsA==
X-Forwarded-Encrypted: i=1; AJvYcCVbGy9HKUM+JqWdI8b+HKBNv4HD4ygm1kvomO4+PwBZIY/Ej2KemAHvbXWM4HgzDLauLNwsEqmzx9dsJblwuLBxVmB8opyc
X-Gm-Message-State: AOJu0YxR6h99RrRKNh7zvGySf7GF9hg+sJ7j9/LpN0B3s6lSgBsEkLdp
	3PmQZtHut7lJMq/HC+iMEzvlhkLbTXoJX7niRPW6Lk3TNukeobFPEaXjjva/z+aYQUSaHAHV/Zq
	oGuRwz0xyxmLM0E588wKudeyHItIK+AmhmqKXCmqt0d0GbEJ+hJmW0/0=
X-Google-Smtp-Source: AGHT+IETFARmh2vksgypl9jyIjHXhlTyp/qgE07x2S6sxrBLNTQyyj1jkwA/rXbqiGEa8C1TdHFv9NnsG4+qdibZxLqAP/UG9G5o
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:b0:4bb:624c:5a7f with SMTP id
 8926c6da1cb9f-4c8d5584e20mr501089173.1.1723025842341; Wed, 07 Aug 2024
 03:17:22 -0700 (PDT)
Date: Wed, 07 Aug 2024 03:17:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004599d9061f15376a@google.com>
Subject: [syzbot] [net?] Internal error in fib6_table_lookup (2)
From: syzbot <syzbot+4205771ecfb50b61dfa1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17712b7ea075 Merge tag 'io_uring-6.11-20240802' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab594b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2238067711551561
dashboard link: https://syzkaller.appspot.com/bug?extid=4205771ecfb50b61dfa1
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-17712b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c9b251464cb7/vmlinux-17712b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca556e298b5e/zImage-17712b7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4205771ecfb50b61dfa1@syzkaller.appspotmail.com

Insufficient stack space to handle exception!
Task stack:     [0xec56c000..0xec56e000]
IRQ stack:      [0xdf800000..0xdf802000]
Overflow stack: [0x82cb7000..0x82cb8000]
Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 UID: 0 PID: 5724 Comm: syz.0.26897 Not tainted 6.11.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at fib6_table_lookup+0x4/0x354 net/ipv6/route.c:2188
LR is at ip6_pol_route+0x90/0x4fc net/ipv6/route.c:2231
pc : [<817282a0>]    lr : [<817295e4>]    psr: 60000013
sp : ec56c028  ip : ec56c028  fp : ec56c08c
r10: 00000080  r9 : 83eabc00  r8 : 00000031
r7 : ec56c138  r6 : 00000002  r5 : 8546c100  r4 : ec56c048
r3 : ec56c138  r2 : 00000031  r1 : 85029080  r0 : 8546c100
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 8515e480  DAC: fffffffd
Register r0 information: slab net_namespace start 8546c100 pointer offset 0 size 3328
Register r1 information: slab kmalloc-128 start 85029080 pointer offset 0 size 128
Register r2 information: non-paged memory
Register r3 information: 2-page vmalloc region starting at 0xec56c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r4 information: 2-page vmalloc region starting at 0xec56c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r5 information: slab net_namespace start 8546c100 pointer offset 0 size 3328
Register r6 information: non-paged memory
Register r7 information: 2-page vmalloc region starting at 0xec56c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r8 information: non-paged memory
Register r9 information: slab task_struct start 83eabc00 pointer offset 0 size 3072
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xec56c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Register r12 information: 2-page vmalloc region starting at 0xec56c000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2781
Process syz.0.26897 (pid: 5724, stack limit = 0xec56c000)
Stack: (0xec56c028 to 0xec56e000)
c020:                   ec56c048 00000002 00000000 00000000 00000000 85029080
c040: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
c060: 00000000 8546c100 00000084 ec56c138 00000000 81729a84 00000000 00000000
c080: ec56c0a4 ec56c090 81729ab0 81729560 00000000 00000084 ec56c104 ec56c0a8
c0a0: 817661f4 81729a90 00000084 00000000 00000000 00000000 00000000 00000000
c0c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
c0e0: 00000000 ec56c138 0b1414ac 8546c100 00000000 ec56c160 ec56c134 ec56c108
c100: 81721ca4 817661ac 81729a84 00000000 83dab000 84891000 00000050 ec56c160
c120: 8475e800 844eb000 ec56c1bc ec56c138 80c1f6a4 81721bf4 00000031 00000001
c140: 00000000 00000000 01840000 00000000 00000000 00000000 00000000 00000000
c160: 000000fc 00000000 00000000 00000000 00000000 00000000 00000000 0b1414ac
c180: bffa2800 00000000 00000000 00000000 83dab000 4378c5dd ec56c1bc 83dab000
c1a0: 84891000 84891000 83eabc00 00000000 ec56c1f4 ec56c1c0 80c20ad4 80c1f60c
c1c0: ec56c253 4378c5dd 00000002 83dab000 00000000 4378c5dd 8544b000 0000011a
c1e0: 8544b000 83eabc00 ec56c214 ec56c1f8 80c21250 80c20778 83dab000 81b705d8
c200: 8544b000 83eabc00 ec56c25c ec56c218 81478b58 80c21244 ec56c25c ec56c228
c220: ec56c280 824b9fce 82606000 0000011a 83dab000 83dab000 824b9fcc 844eb000
c240: 8544b000 ec56c260 851d76c0 00000000 ec56c31c ec56c260 81479040 81478a80
c260: 817799d8 8024bb0c 817799d8 8024bb0c 8024bb50 8027b53c ec56c2b0 0046c100
c280: fffffff4 ec56c290 81729648 802e31a8 00000000 00000000 845eade0 00000001
c2a0: ec56c2c4 ec56c2b0 8024bb50 8027b53c 8421b810 00000001 00000000 ec56c2c8
c2c0: 00000001 824b8944 8470f780 824b8944 8421b840 8421b800 ec56c3c4 8501c0c0
c2e0: 00000004 8260c720 821dcfe0 4378c5dd ec56c394 00000000 83dab000 851aa900
c300: 0000000e 00000010 00000009 00000013 ec56c37c ec56c320 8170ac4c 81478e78
c320: 83dab000 00000000 00000000 8546c100 00000000 00000000 00000000 00000000
c340: 00000000 00000000 00000000 4378c5dd 00000000 83dab000 00000008 00000000
c360: 8546c100 00000000 000005dc 00000000 ec56c3bc ec56c380 8170f570 8170a8e8
c380: 8443c290 00000000 ec56c3bc ec56c398 815883e4 83dab000 8546c100 00000000
c3a0: 00000001 8544b000 84891000 00000000 ec56c404 ec56c3c0 8170f724 8170f368
c3c0: 81793524 00000a04 84891000 8544b000 00000000 8546c100 8170f35c 4378c5dd
c3e0: 83dab000 8546c100 00000000 83eabc00 00000000 844eb000 ec56c424 ec56c408
c400: 817935c0 8170f6b0 83dab000 00000000 84891000 83eabc00 ec56c45c ec56c428
c420: 80c20b04 8179358c ec56c4bb 4378c5dd 00000002 83dab000 00000000 4378c5dd
c440: 8544b000 0000011a 8544b000 83eabc00 ec56c47c ec56c460 80c21250 80c20778
c460: 83dab000 81b705d8 8544b000 83eabc00 ec56c4c4 ec56c480 81478b58 80c21244
c480: ec56c4c4 ec56c490 ec56c4e8 824b9fce 82606000 0000011a 83dab000 83dab000
c4a0: 824b9fcc 844eb000 8544b000 ec56c4c8 851d76c0 00000000 ec56c584 ec56c4c8
c4c0: 81479040 81478a80 817799d8 8024bb0c 817799d8 8024bb0c 8024bb50 8027b53c
c4e0: ec56c518 0046c100 fffffff4 ec56c4f8 81729648 802e31a8 00000000 00000000
c500: 845eade0 00000001 ec56c52c ec56c518 8024bb50 8027b53c 8421b810 00000001
c520: 00000000 ec56c530 00000001 824b8944 8470f780 824b8944 8421b840 8421b800
c540: ec56c62c 8501c0c0 00000004 8260c720 821dcfe0 4378c5dd ec56c5fc 00000000
c560: 83dab000 851aa900 0000000e 00000010 00000009 00000013 ec56c5e4 ec56c588
c580: 8170ac4c 81478e78 83dab000 00000000 00000000 8546c100 00000000 00000000
c5a0: 00000000 00000000 00000000 00000000 00000000 4378c5dd 00000000 83dab000
c5c0: 00000007 00000000 8546c100 00000000 000005dc 00000000 ec56c624 ec56c5e8
c5e0: 8170f570 8170a8e8 8443c290 00000000 ec56c624 ec56c600 815883e4 83dab000
c600: 8546c100 00000000 00000001 8544b000 84891000 00000000 ec56c66c ec56c628
c620: 8170f724 8170f368 81793524 00000a04 84891000 8544b000 00000000 8546c100
c640: 8170f35c 4378c5dd 83dab000 8546c100 00000000 83eabc00 00000000 844eb000
c660: ec56c68c ec56c670 817935c0 8170f6b0 83dab000 00000000 84891000 83eabc00
c680: ec56c6c4 ec56c690 80c20b04 8179358c ec56c723 4378c5dd 00000002 83dab000
c6a0: 00000000 4378c5dd 8544b000 0000011a 8544b000 83eabc00 ec56c6e4 ec56c6c8
c6c0: 80c21250 80c20778 83dab000 81b705d8 8544b000 83eabc00 ec56c72c ec56c6e8
c6e0: 81478b58 80c21244 ec56c72c ec56c6f8 ec56c750 824b9fce 82606000 0000011a
c700: 83dab000 83dab000 824b9fcc 844eb000 8544b000 ec56c730 851d76c0 00000000
c720: ec56c7ec ec56c730 81479040 81478a80 817799d8 8024bb0c 817799d8 8024bb0c
c740: 8024bb50 8027b53c ec56c780 0046c100 fffffff4 ec56c760 81729648 802e31a8
c760: 00000000 00000000 845eade0 00000001 ec56c794 ec56c780 8024bb50 8027b53c
c780: 8421b810 00000001 00000000 ec56c798 00000001 824b8944 8470f780 824b8944
c7a0: 8421b840 8421b800 ec56c894 8501c0c0 00000004 8260c720 821dcfe0 4378c5dd
c7c0: ec56c864 00000000 83dab000 851aa900 0000000e 00000010 00000009 00000013
c7e0: ec56c84c ec56c7f0 8170ac4c 81478e78 83dab000 00000000 00000000 8546c100
c800: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
c820: 00000000 83dab000 00000006 00000000 8546c100 00000000 000005dc 00000000
c840: ec56c88c ec56c850 8170f570 8170a8e8 8443c290 00000000 ec56c88c ec56c868
c860: 815883e4 83dab000 8546c100 00000000 00000001 8544b000 84891000 00000000
c880: ec56c8d4 ec56c890 8170f724 8170f368 81793524 00000a04 84891000 8544b000
c8a0: 00000000 8546c100 8170f35c 4378c5dd 83dab000 8546c100 00000000 83eabc00
c8c0: 00000000 844eb000 ec56c8f4 ec56c8d8 817935c0 8170f6b0 83dab000 00000000
c8e0: 84891000 83eabc00 ec56c92c ec56c8f8 80c20b04 8179358c ec56c98b 4378c5dd
c900: 00000002 83dab000 00000000 4378c5dd 8544b000 0000011a 8544b000 83eabc00
c920: ec56c94c ec56c930 80c21250 80c20778 83dab000 81b705d8 8544b000 83eabc00
c940: ec56c994 ec56c950 81478b58 80c21244 ec56c994 ec56c960 ec56c9b8 824b9fce
c960: 82606000 0000011a 83dab000 83dab000 824b9fcc 844eb000 8544b000 ec56c998
c980: 851d76c0 00000000 ec56ca54 ec56c998 81479040 81478a80 817799d8 8024bb0c
c9a0: 817799d8 8024bb0c 8024bb50 8027b53c ec56c9e8 0046c100 fffffff4 ec56c9c8
c9c0: 81729648 802e31a8 00000000 00000000 845eade0 00000001 ec56c9fc ec56c9e8
c9e0: 8024bb50 8027b53c 8421b810 00000001 00000000 ec56ca00 00000001 824b8944
ca00: 8470f780 824b8944 8421b840 8421b800 ec56cafc 8501c0c0 00000004 8260c720
ca20: 821dcfe0 4378c5dd ec56cacc 00000000 83dab000 851aa900 0000000e 00000010
ca40: 00000009 00000013 ec56cab4 ec56ca58 8170ac4c 81478e78 83dab000 00000000
ca60: 00000000 8546c100 00000000 00000000 00000000 00000000 00000000 00000000
ca80: 00000000 4378c5dd 00000000 83dab000 00000005 00000000 8546c100 00000000
caa0: 000005dc 00000000 ec56caf4 ec56cab8 8170f570 8170a8e8 8443c290 00000000
cac0: ec56caf4 ec56cad0 815883e4 83dab000 8546c100 00000000 00000001 8544b000
cae0: 84891000 00000000 ec56cb3c ec56caf8 8170f724 8170f368 81793524 00000a04
cb00: 84891000 8544b000 00000000 8546c100 8170f35c 4378c5dd 83dab000 8546c100
cb20: 00000000 83eabc00 00000000 844eb000 ec56cb5c ec56cb40 817935c0 8170f6b0
cb40: 83dab000 00000000 84891000 83eabc00 ec56cb94 ec56cb60 80c20b04 8179358c
cb60: ec56cbf3 4378c5dd 00000002 83dab000 00000000 4378c5dd 8544b000 0000011a
cb80: 8544b000 83eabc00 ec56cbb4 ec56cb98 80c21250 80c20778 83dab000 81b705d8
cba0: 8544b000 83eabc00 ec56cbfc ec56cbb8 81478b58 80c21244 ec56cbfc ec56cbc8
cbc0: ec56cc20 824b9fce 82606000 0000011a 83dab000 83dab000 824b9fcc 844eb000
cbe0: 8544b000 ec56cc00 851d76c0 00000000 ec56ccbc ec56cc00 81479040 81478a80
cc00: 817799d8 8024bb0c 817799d8 8024bb0c 8024bb50 8027b53c ec56cc50 0046c100
cc20: fffffff4 ec56cc30 81729648 802e31a8 00000000 00000000 845eade0 00000001
cc40: ec56cc64 ec56cc50 8024bb50 8027b53c 8421b810 00000001 00000000 ec56cc68
cc60: 00000001 824b8944 8470f780 824b8944 8421b840 8421b800 ec56cd64 8501c0c0
cc80: 00000004 8260c720 821dcfe0 4378c5dd ec56cd34 00000000 83dab000 851aa900
cca0: 0000000e 00000010 00000009 00000013 ec56cd1c ec56ccc0 8170ac4c 81478e78
ccc0: 83dab000 00000000 00000000 8546c100 00000000 00000000 00000000 00000000
cce0: 00000000 00000000 00000000 4378c5dd 00000000 83dab000 00000004 00000000
cd00: 8546c100 00000000 000005dc 00000000 ec56cd5c ec56cd20 8170f570 8170a8e8
cd20: 8443c290 00000000 ec56cd5c ec56cd38 815883e4 83dab000 8546c100 00000000
cd40: 00000001 8544b000 84891000 00000000 ec56cda4 ec56cd60 8170f724 8170f368
cd60: 81793524 00000a04 84891000 8544b000 00000000 8546c100 8170f35c 4378c5dd
cd80: 83dab000 8546c100 00000000 83eabc00 00000000 844eb000 ec56cdc4 ec56cda8
cda0: 817935c0 8170f6b0 83dab000 00000000 84891000 83eabc00 ec56cdfc ec56cdc8
cdc0: 80c20b04 8179358c ec56ce5b 4378c5dd 00000002 83dab000 00000000 4378c5dd
cde0: 8544b000 0000011a 8544b000 83eabc00 ec56ce1c ec56ce00 80c21250 80c20778
ce00: 83dab000 81b705d8 8544b000 83eabc00 ec56ce64 ec56ce20 81478b58 80c21244
ce20: ec56ce64 ec56ce30 ec56ce88 824b9fce 82606000 0000011a 83dab000 83dab000
ce40: 824b9fcc 844eb000 8544b000 ec56ce68 851d76c0 00000000 ec56cf24 ec56ce68
ce60: 81479040 81478a80 817799d8 8024bb0c 817799d8 8024bb0c 8024bb50 8027b53c
ce80: ec56ceb8 0046c100 fffffff4 ec56ce98 81729648 802e31a8 00000000 00000000
cea0: 845eade0 00000001 ec56cecc ec56ceb8 8024bb50 8027b53c 8421b810 00000001
cec0: 00000000 ec56ced0 00000001 824b8944 8470f780 824b8944 8421b840 8421b800
cee0: ec56cfcc 8501c0c0 00000004 8260c720 821dcfe0 4378c5dd ec56cf9c 00000000
cf00: 83dab000 851aa900 0000000e 00000010 00000009 00000013 ec56cf84 ec56cf28
cf20: 8170ac4c 81478e78 83dab000 00000000 00000000 8546c100 00000000 00000000
cf40: 00000000 00000000 00000000 00000000 00000000 4378c5dd 00000000 83dab000
cf60: 00000003 00000000 8546c100 00000000 000005dc 00000000 ec56cfc4 ec56cf88
cf80: 8170f570 8170a8e8 8443c290 00000000 ec56cfc4 ec56cfa0 815883e4 83dab000
cfa0: 8546c100 00000000 00000001 8544b000 84891000 00000000 ec56d00c ec56cfc8
cfc0: 8170f724 8170f368 81793524 00000a04 84891000 8544b000 00000000 8546c100
cfe0: 8170f35c 4378c5dd 83dab000 8546c100 00000000 83eabc00 00000000 844eb000
d000: ec56d02c ec56d010 817935c0 8170f6b0 83dab000 00000000 84891000 83eabc00
d020: ec56d064 ec56d030 80c20b04 8179358c ec56d0c3 4378c5dd 00000002 83dab000
d040: 00000000 4378c5dd 8544b000 0000011a 8544b000 83eabc00 ec56d084 ec56d068
d060: 80c21250 80c20778 83dab000 81b705d8 8544b000 83eabc00 ec56d0cc ec56d088
d080: 81478b58 80c21244 ec56d0cc ec56d098 ec56d0f0 824b9fce 82606000 0000011a
d0a0: 83dab000 83dab000 824b9fcc 844eb000 8544b000 ec56d0d0 851d76c0 00000000
d0c0: ec56d18c ec56d0d0 81479040 81478a80 817799d8 8024bb0c 817799d8 8024bb0c
d0e0: 8024bb50 8027b53c ec56d120 0046c100 fffffff4 ec56d100 81729648 802e31a8
d100: 00000000 00000000 845eade0 00000001 ec56d134 ec56d120 8024bb50 8027b53c
d120: 8421b810 00000001 00000000 ec56d138 00000001 824b8944 8470f780 824b8944
d140: 8421b840 8421b800 ec56d234 8501c0c0 00000004 8260c720 821dcfe0 4378c5dd
d160: ec56d204 00000000 83dab000 851aa900 0000000e 00000010 00000009 00000013
d180: ec56d1ec ec56d190 8170ac4c 81478e78 83dab000 00000000 00000000 8546c100
d1a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
d1c0: 00000000 83dab000 00000002 00000000 8546c100 00000000 000005dc 00000000
d1e0: ec56d22c ec56d1f0 8170f570 8170a8e8 8443c290 00000000 ec56d22c ec56d208
d200: 815883e4 83dab000 8546c100 00000000 00000001 8544b000 84891000 00000000
d220: ec56d274 ec56d230 8170f724 8170f368 81793524 00000a04 84891000 8544b000
d240: 00000000 8546c100 8170f35c 4378c5dd 83dab000 8546c100 00000000 83eabc00
d260: 00000000 844eb000 ec56d294 ec56d278 817935c0 8170f6b0 83dab000 00000000
d280: 84891000 83eabc00 ec56d2cc ec56d298 80c20b04 8179358c ec56d32b 4378c5dd
d2a0: 00000002 83dab000 00000000 4378c5dd 8544b000 0000011a 8544b000 83eabc00
d2c0: ec56d2ec ec56d2d0 80c21250 80c20778 83dab000 81b705d8 8544b000 83eabc00
d2e0: ec56d334 ec56d2f0 81478b58 80c21244 ec56d334 ec56d300 ec56d358 824b9fce
d300: 82606000 0000011a 83dab000 83dab000 824b9fcc 844eb000 8544b000 ec56d338
d320: 851d76c0 00000000 ec56d3f4 ec56d338 81479040 81478a80 817799d8 8024bb0c
d340: 817799d8 8024bb0c 8024bb50 8027b53c ec56d388 0046c100 fffffff4 ec56d368
d360: 81729648 802e31a8 00000000 00000000 845eade0 00000001 ec56d39c ec56d388
d380: 8024bb50 8027b53c 8421b810 00000001 00000000 ec56d3a0 00000001 824b8944
d3a0: 8470f780 824b8944 8421b840 8421b800 ec56d49c 8501c0c0 00000004 8260c720
d3c0: 821dcfe0 4378c5dd ec56d46c 00000000 83dab000 851aa900 0000000e 00000010
d3e0: 00000009 00000013 ec56d454 ec56d3f8 8170ac4c 81478e78 83dab000 00000000
d400: 00000000 8546c100 00000000 00000000 00000000 00000000 00000000 00000000
d420: 00000000 4378c5dd 00000000 83dab000 00000001 00000000 8546c100 00000000
d440: 000005dc 00000000 ec56d494 ec56d458 8170f570 8170a8e8 8443c290 00000000
d460: ec56d494 ec56d470 815883e4 83dab000 8546c100 00000000 00000001 8544b000
d480: 84891000 00000000 ec56d4dc ec56d498 8170f724 8170f368 81793524 00000a04
d4a0: 84891000 8544b000 00000000 8546c100 8170f35c 4378c5dd 83dab000 8546c100
d4c0: 00000000 83eabc00 00000000 844eb000 ec56d4fc ec56d4e0 817935c0 8170f6b0
d4e0: 83dab000 00000000 84891000 83eabc00 ec56d534 ec56d500 80c20b04 8179358c
d500: 8020d078 4378c5dd ec56d524 83dab000 00000000 4378c5dd 8544b000 0000011a
d520: 8544b000 83eabc00 ec56d554 ec56d538 80c21250 80c20778 83dab000 81b705d8
d540: 8544b000 83eabc00 ec56d59c ec56d558 81478b58 80c21244 ec56d59c ec56d568
d560: ec56d5c0 824b9fce 82606000 0000011a 83dab000 83dab000 824b9fcc 844eb000
d580: 8544b000 ec56d5a0 851d76c0 00000000 ec56d65c ec56d5a0 81479040 81478a80
d5a0: 83eabc00 00000001 827e11dc 8517bfc0 ec56d5dc ec56d5c0 8020c014 0020cff0
d5c0: fffffff4 00000201 8197e844 0000dd86 ec56d61c ec56d5e0 8020d078 8020bffc
d5e0: 8197e4f8 00000000 81489fc4 ec56d68c ec56d660 8027cfb4 81489fc4 00000000
d600: 00000000 4378c5dd 000086dd 851aa960 ec56d63c ec56d620 814ebbc8 81452fb8
d620: 814ebba4 00000000 83dab000 4378c5dd ec56d65c 851aa900 00000000 83dab000
d640: 80c20e60 8544b000 00000009 00000013 ec56d68c ec56d660 81489f88 81478e78
d660: 00000000 0000010c ec56d68c 8544b000 83dab000 851aa900 8475e868 84b96c00
d680: ec56d6ec ec56d690 8170ab74 81489e74 83dab000 00000000 00000000 8546c100
d6a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
d6c0: 00000000 83dab000 00000000 84129300 8546c100 00000000 000005dc 8475e800
d6e0: ec56d72c ec56d6f0 8170f570 8170a8e8 8443c290 8475e800 ec56d72c ec56d708
d700: 815883e4 83dab000 8546c100 84129300 00000001 8544b000 00000000 8475e800
d720: ec56d774 ec56d730 8170f724 8170f368 83dab000 00000a04 00000000 8544b000
d740: 84129300 8546c100 8170f35c 4378c5dd 83dab000 00000001 84129300 84b9c820
d760: 8475e868 8546c100 ec56d844 ec56d778 8170b588 8170f6b0 00000000 00000000
d780: 00000000 00000050 8544b000 84b9c858 000000e4 00000000 851d76c0 84b96c00
d7a0: 84000000 84b9c848 00000a03 00000000 8544b000 84129300 8546c100 81709d78
d7c0: 00030000 00000000 00840000 00000000 00000000 00000000 00000000 00000000
d7e0: 2f920000 2f920000 00000000 00000000 00000000 00000000 0b1414ac 000000fc
d800: 00000000 00000000 00000000 00000000 00000000 4378c5dd 00000000 83dab000
d820: 84b9c800 84129750 84129300 851d76c0 00000002 ec56d97c ec56d8f4 ec56d848
d840: 818391b4 8170b25c 00000000 00000002 00000000 00000000 81810314 4378c5dd
d860: 83eabc00 00000000 000000e4 84b9c820 ec56d88c ec56d880 8182bc98 80827ba8
d880: ec56d8f4 ec56d890 814552f0 8182bc80 83d67b40 4378c5dd ec56d8c4 83d67b40
d8a0: 83d67b50 83dab000 00000000 000000d8 00000000 ec56d97c ec56d8dc ec56d8c8
d8c0: 81810314 4378c5dd 83d67b40 84b9c800 ec56d974 8475e878 ec56d97c 83dab000
d8e0: 00000000 ec56d97c ec56d96c ec56d8f8 8182cc10 81838f0c 81c7d198 8020cff0
d900: ec56d934 ec56d910 8182be24 80825398 83dab000 00000000 821e6074 00000001
d920: 83d3b800 84b9c800 00000000 84129300 00000000 00000cc0 84b9c800 83dab000
d940: 00840001 84b9c800 83d67b40 00000cc0 00000000 0000922f 00000000 83d3bbb4
d960: ec56d9c4 ec56d970 81816de8 8182c664 40000093 0000922f 00000000 ec56d97c
d980: ec56d97c 00000034 0000010c 00010000 84b9c800 00000000 00000000 4378c5dd
d9a0: ec56da10 00000000 83d67b40 83d67b40 83d3bbcc 83d3b800 ec56da54 ec56d9c8
d9c0: 818185f8 81816d64 81a03ea8 4378c5dd 83d3ba5c 83d3ba5c 83d3ba5c dddc6200
d9e0: ec56d9fc ec56d9f0 8197e61c 8027b53c ec56da54 ec56da00 802fabd8 00000000
da00: 83d3bbb4 82604d40 83d3bbb4 84b9c800 84b9c9c0 84b9c9c0 83d3b800 84b9c998
da20: 00000cc0 4378c5dd 00000000 ec56db24 83d3b800 00000004 83d67b40 00000000
da40: 83d3b800 00000001 ec56da64 ec56da58 81818fbc 81817ab0 ec56db84 ec56da68
da60: 81807f2c 81818fa0 00000000 ec56daac ec56db5c ec56da80 81839ab4 802e31a8
da80: ec56db3c 84b9c820 0000012c 00000000 84129300 00000001 8528f300 00000000
daa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dac0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dae0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
db00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
db20: 00000000 83d67b40 0000000c 00000002 00000012 83d3b800 00000001 83d67b40
db40: 00000016 00000001 00000003 ec56db24 ec56db24 4378c5dd 00000000 83d3b800
db60: 84129300 84b9c800 00000001 83eabc00 8528f300 ec56dc50 ec56dba4 ec56db88
db80: 8182baac 81806b64 8528f300 83d3b800 00000000 00000cc0 ec56dc14 ec56dba8
dba0: 8181fadc 8182ba7c 00000000 00000000 84b9c800 8546c100 ec56de90 00000001
dbc0: 83d3bb9c 84129300 818256b0 00000000 0000000a 00000000 00000000 00000000
dbe0: 00000000 4378c5dd 00000000 84129300 ec56de90 84b9c800 00000001 00000001
dc00: 8528f300 00000000 ec56dcbc ec56dc18 81828ab8 8181f8b4 ec56dc50 8515ec80
dc20: 83eabc00 ec56dd1c 83d3b800 83eabc00 806f29a0 84b9c800 00000000 00000000
dc40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dc60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dc80: 00000000 4378c5dd 00000000 4378c5dd 00000001 ec56de90 00000001 84129300
dca0: ec56ded8 ec56dd1c ec56dd1c 00000000 ec56dcdc ec56dcc0 81671a58 818284b8
dcc0: 00000000 ec56de90 84c2f400 ec56ded8 ec56dcfc ec56dce0 81446d24 81671a24
dce0: ec56de90 84c2f400 00000000 ec56ded8 ec56dd6c ec56dd00 81447aa4 81446cec
dd00: ec56dd78 ec56dea0 00000000 00000000 ec56dd6c 00000000 81449b30 00000000
dd20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
dd40: 00000000 00000000 ec56de90 84c2f400 ec56ded8 00000000 20007300 ec56dd7c
dd60: ec56de6c ec56dd70 81449c00 814479f4 00000080 ec56dd80 00000000 20000480
dd80: 00000001 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dda0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000000a
ddc0: 00000000 000000fc 00000000 00000000 00000000 00000000 00000000 00000000
dde0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
de00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
de20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 4378c5dd
de40: 80527a1c 00000000 20007300 00000001 00000000 00000000 ec56ded8 00000000
de60: ec56df8c ec56de70 8144a234 81449b70 ec56ded8 00000080 00000001 b5003500
de80: b5403587 84c2f400 00000001 00000000 ec56ddbc 0000001c 00000000 00000000
dea0: 00010000 00000000 20000480 00000001 00000001 00000000 00000000 00000001
dec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df40: 00000000 00000000 00000000 00000000 00000000 00000000 ffffffff 4378c5dd
df60: 8261c9cc 00000000 00000000 002662ec 00000176 8020029c 83eabc00 00000176
df80: ec56dfa4 ec56df90 8144a33c 8144a168 00000001 83eabc00 00000000 ec56dfa8
dfa0: 80200060 8144a32c 00000000 00000000 00000003 20007300 00000001 00000000
dfc0: 00000000 00000000 002662ec 00000176 7ee6377e 7ee6377f 003d0f00 76b550bc
dfe0: 76b54ec8 76b54eb8 000188c0 00132750 60000010 00000003 00000000 00000000
Call trace: 
[<81729554>] (ip6_pol_route) from [<81729ab0>] (ip6_pol_route_output+0x2c/0x34 net/ipv6/route.c:2606)
 r10:00000000 r9:00000000 r8:81729a84 r7:00000000 r6:ec56c138 r5:00000084
 r4:8546c100
[<81729a84>] (ip6_pol_route_output) from [<817661f4>] (pol_lookup_func include/net/ip6_fib.h:616 [inline])
[<81729a84>] (ip6_pol_route_output) from [<817661f4>] (fib6_rule_lookup+0x54/0x1e8 net/ipv6/fib6_rules.c:116)
[<817661a0>] (fib6_rule_lookup) from [<81721ca4>] (ip6_route_output_flags_noref net/ipv6/route.c:2639 [inline])
[<817661a0>] (fib6_rule_lookup) from [<81721ca4>] (ip6_route_output_flags+0xbc/0x1cc net/ipv6/route.c:2651)
 r8:ec56c160 r7:00000000 r6:8546c100 r5:0b1414ac r4:ec56c138
[<81721be8>] (ip6_route_output_flags) from [<80c1f6a4>] (ip6_route_output include/net/ip6_route.h:93 [inline])
[<81721be8>] (ip6_route_output_flags) from [<80c1f6a4>] (ipvlan_route_v6_outbound+0xa4/0x100 drivers/net/ipvlan/ipvlan_core.c:473)
 r9:844eb000 r8:8475e800 r7:ec56c160 r6:00000050 r5:84891000 r4:83dab000
[<80c1f600>] (ipvlan_route_v6_outbound) from [<80c20ad4>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:488 [inline])
[<80c1f600>] (ipvlan_route_v6_outbound) from [<80c20ad4>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<80c1f600>] (ipvlan_route_v6_outbound) from [<80c20ad4>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<80c1f600>] (ipvlan_route_v6_outbound) from [<80c20ad4>] (ipvlan_queue_xmit+0x368/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r8:00000000 r7:83eabc00 r6:84891000 r5:84891000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56c260 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000008
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56c4c8 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000007
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56c730 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000006
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56c998 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000005
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56cc00 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000004
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56ce68 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000003
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56d0d0 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000002
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56d338 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_hh_output include/net/neighbour.h:526 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (neigh_output include/net/neighbour.h:540 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<8170ac4c>] (ip6_finish_output2+0x370/0x974 net/ipv6/ip6_output.c:137)
 r10:00000013 r9:00000009 r8:00000010 r7:0000000e r6:851aa900 r5:83dab000
 r4:00000000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:00000000 r9:000005dc r8:00000000 r7:8546c100 r6:00000000 r5:00000001
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:00000000 r9:84891000 r8:8544b000 r7:00000001 r6:00000000 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<817935c0>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<817935c0>] (ip6_local_out+0x40/0x44 net/ipv6/output_core.c:155)
 r9:844eb000 r8:00000000 r7:83eabc00 r6:00000000 r5:8546c100 r4:83dab000
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:497 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:538 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline])
[<81793580>] (ip6_local_out) from [<80c20b04>] (ipvlan_queue_xmit+0x398/0x474 drivers/net/ipvlan/ipvlan_core.c:668)
 r7:83eabc00 r6:84891000 r5:00000000 r4:83dab000
[<80c2076c>] (ipvlan_queue_xmit) from [<80c21250>] (ipvlan_start_xmit+0x18/0xc4 drivers/net/ipvlan/ipvlan_main.c:222)
 r7:83eabc00 r6:8544b000 r5:0000011a r4:8544b000
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (__netdev_start_xmit include/linux/netdevice.h:4913 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (netdev_start_xmit include/linux/netdevice.h:4922 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (xmit_one net/core/dev.c:3580 [inline])
[<80c21238>] (ipvlan_start_xmit) from [<81478b58>] (dev_hard_start_xmit+0xe4/0x2b4 net/core/dev.c:3596)
 r7:83eabc00 r6:8544b000 r5:81b705d8 r4:83dab000
[<81478a74>] (dev_hard_start_xmit) from [<81479040>] (__dev_queue_xmit+0x1d4/0xf0c net/core/dev.c:4423)
 r10:00000000 r9:851d76c0 r8:ec56d5a0 r7:8544b000 r6:844eb000 r5:824b9fcc
 r4:83dab000
[<81478e6c>] (__dev_queue_xmit) from [<81489f88>] (dev_queue_xmit include/linux/netdevice.h:3105 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<81489f88>] (neigh_resolve_output net/core/neighbour.c:1565 [inline])
[<81478e6c>] (__dev_queue_xmit) from [<81489f88>] (neigh_resolve_output+0x120/0x204 net/core/neighbour.c:1545)
 r10:00000013 r9:00000009 r8:8544b000 r7:80c20e60 r6:83dab000 r5:00000000
 r4:851aa900
[<81489e68>] (neigh_resolve_output) from [<8170ab74>] (neigh_output include/net/neighbour.h:542 [inline])
[<81489e68>] (neigh_resolve_output) from [<8170ab74>] (ip6_finish_output2+0x298/0x974 net/ipv6/ip6_output.c:137)
 r8:84b96c00 r7:8475e868 r6:851aa900 r5:83dab000 r4:8544b000
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (__ip6_finish_output net/ipv6/ip6_output.c:211 [inline])
[<8170a8dc>] (ip6_finish_output2) from [<8170f570>] (ip6_finish_output+0x214/0x348 net/ipv6/ip6_output.c:222)
 r10:8475e800 r9:000005dc r8:00000000 r7:8546c100 r6:84129300 r5:00000000
 r4:83dab000
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (NF_HOOK_COND include/linux/netfilter.h:303 [inline])
[<8170f35c>] (ip6_finish_output) from [<8170f724>] (ip6_output+0x80/0x1e8 net/ipv6/ip6_output.c:243)
 r10:8475e800 r9:00000000 r8:8544b000 r7:00000001 r6:84129300 r5:8546c100
 r4:83dab000
[<8170f6a4>] (ip6_output) from [<8170b588>] (dst_output include/net/dst.h:450 [inline])
[<8170f6a4>] (ip6_output) from [<8170b588>] (NF_HOOK include/linux/netfilter.h:314 [inline])
[<8170f6a4>] (ip6_output) from [<8170b588>] (NF_HOOK include/linux/netfilter.h:308 [inline])
[<8170f6a4>] (ip6_output) from [<8170b588>] (ip6_xmit+0x338/0x74c net/ipv6/ip6_output.c:358)
 r9:8546c100 r8:8475e868 r7:84b9c820 r6:84129300 r5:00000001 r4:83dab000
[<8170b250>] (ip6_xmit) from [<818391b4>] (sctp_v6_xmit+0x2b4/0x344 net/sctp/ipv6.c:248)
 r10:ec56d97c r9:00000002 r8:851d76c0 r7:84129300 r6:84129750 r5:84b9c800
 r4:83dab000
[<81838f00>] (sctp_v6_xmit) from [<8182cc10>] (sctp_packet_transmit+0x5b8/0xa04 net/sctp/output.c:653)
 r10:ec56d97c r9:00000000 r8:83dab000 r7:ec56d97c r6:8475e878 r5:ec56d974
 r4:84b9c800
[<8182c658>] (sctp_packet_transmit) from [<81816de8>] (sctp_packet_singleton+0x90/0xe4 net/sctp/outqueue.c:783)
 r10:83d3bbb4 r9:00000000 r8:0000922f r7:00000000 r6:00000cc0 r5:83d67b40
 r4:84b9c800
[<81816d58>] (sctp_packet_singleton) from [<818185f8>] (sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline])
[<81816d58>] (sctp_packet_singleton) from [<818185f8>] (sctp_outq_flush+0xb54/0xba4 net/sctp/outqueue.c:1212)
 r9:83d3b800 r8:83d3bbcc r7:83d67b40 r6:83d67b40 r5:00000000 r4:ec56da10
[<81817aa4>] (sctp_outq_flush) from [<81818fbc>] (sctp_outq_uncork+0x28/0x2c net/sctp/outqueue.c:764)
 r10:00000001 r9:83d3b800 r8:00000000 r7:83d67b40 r6:00000004 r5:83d3b800
 r4:ec56db24
[<81818f94>] (sctp_outq_uncork) from [<81807f2c>] (sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline])
[<81818f94>] (sctp_outq_uncork) from [<81807f2c>] (sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline])
[<81818f94>] (sctp_outq_uncork) from [<81807f2c>] (sctp_do_sm+0x13d4/0x1848 net/sctp/sm_sideeffect.c:1169)
[<81806b58>] (sctp_do_sm) from [<8182baac>] (sctp_primitive_ASSOCIATE+0x3c/0x44 net/sctp/primitive.c:73)
 r10:ec56dc50 r9:8528f300 r8:83eabc00 r7:00000001 r6:84b9c800 r5:84129300
 r4:83d3b800
[<8182ba70>] (sctp_primitive_ASSOCIATE) from [<8181fadc>] (sctp_sendmsg_to_asoc+0x234/0x684 net/sctp/socket.c:1841)
[<8181f8a8>] (sctp_sendmsg_to_asoc) from [<81828ab8>] (sctp_sendmsg+0x60c/0x910 net/sctp/socket.c:2031)
 r10:00000000 r9:8528f300 r8:00000001 r7:00000001 r6:84b9c800 r5:ec56de90
 r4:84129300
[<818284ac>] (sctp_sendmsg) from [<81671a58>] (inet_sendmsg+0x40/0x4c net/ipv4/af_inet.c:853)
 r10:00000000 r9:ec56dd1c r8:ec56dd1c r7:ec56ded8 r6:84129300 r5:00000001
 r4:ec56de90
[<81671a18>] (inet_sendmsg) from [<81446d24>] (sock_sendmsg_nosec net/socket.c:730 [inline])
[<81671a18>] (inet_sendmsg) from [<81446d24>] (__sock_sendmsg+0x44/0x78 net/socket.c:745)
 r7:ec56ded8 r6:84c2f400 r5:ec56de90 r4:00000000
[<81446ce0>] (__sock_sendmsg) from [<81447aa4>] (____sys_sendmsg+0xbc/0x2cc net/socket.c:2597)
 r7:ec56ded8 r6:00000000 r5:84c2f400 r4:ec56de90
[<814479e8>] (____sys_sendmsg) from [<81449c00>] (___sys_sendmsg+0x9c/0xd0 net/socket.c:2651)
 r10:ec56dd7c r9:20007300 r8:00000000 r7:ec56ded8 r6:84c2f400 r5:ec56de90
 r4:00000000
[<81449b64>] (___sys_sendmsg) from [<8144a234>] (__sys_sendmmsg+0xd8/0x1c4 net/socket.c:2737)
 r10:00000000 r9:ec56ded8 r8:00000000 r7:00000000 r6:00000001 r5:20007300
 r4:00000000
[<8144a15c>] (__sys_sendmmsg) from [<8144a33c>] (__do_sys_sendmmsg net/socket.c:2766 [inline])
[<8144a15c>] (__sys_sendmmsg) from [<8144a33c>] (sys_sendmmsg+0x1c/0x24 net/socket.c:2763)
 r10:00000176 r9:83eabc00 r8:8020029c r7:00000176 r6:002662ec r5:00000000
 r4:00000000
[<8144a320>] (sys_sendmmsg) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xec56dfa8 to 0xec56dff0)
dfa0:                   00000000 00000000 00000003 20007300 00000001 00000000
dfc0: 00000000 00000000 002662ec 00000176 7ee6377e 7ee6377f 003d0f00 76b550bc
dfe0: 76b54ec8 76b54eb8 000188c0 00132750
Code: ebfff720 eafffff1 eb0926c7 e1a0c00d (e92ddff0) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	ebfff720 	bl	0xffffdc88
   4:	eafffff1 	b	0xffffffd0
   8:	eb0926c7 	bl	0x249b2c
   c:	e1a0c00d 	mov	ip, sp
* 10:	e92ddff0 	push	{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc} <-- trapping instruction


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


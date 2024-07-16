Return-Path: <netdev+bounces-111720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3A9323BE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3D71C20F0A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2F1991BE;
	Tue, 16 Jul 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QffpEaVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912C1991AA
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125065; cv=none; b=CffxCegM5rVsRRp6hYdR9+HFC+7FZLceeL/VIefPZRwbY18DsOoO9/j58gnUB+/l/p7llcAbhJx8UU8b0Ux+V8OCj+8LRgQaegHdvdH/H1uMSDuuxE0u/8W0r56NQgO5c+9C/nbZOtEMIQB+qNAXBPdDO8Q7Wvua4PwT+ma34XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125065; c=relaxed/simple;
	bh=1SpVvLeQUy6M2nodyPepY4vIlLRLMn5jCT9Jkh3yqUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYj75Yb4YJ9RWkKgDhYD+LgSL9P/diYEC0EkTU5tARU/Cbn77dNZN3psm0QIiYi6FGNGSE2zBQTSSbL9fHf+JUW2NKCPfkjU7G12k9ByEhOUo8lfMms28ALV+SGLZb//DX1ja+LDURuFRWFpnqFI9al62dILfcg6vEMkQQwQdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QffpEaVA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c519eso7088665a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721125062; x=1721729862; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3LxmxCoW3E8bDNIaxIpOdypnPGQGV/6ObFe/9muMyw=;
        b=QffpEaVAxTdSjQBdK2/LpCl++EiuZPpBIwR1XPdDo0HaDmqPJop4oZPcHrXmV0VkP+
         4lEObgRrI9BjFd3pkcnbMSz+1Ym/cKaRNbGM7N1RqEbo7OKrKyQbmWLFJj8MsILczWAR
         5DbsZE+GTp7Jaf2nPMxnmxmefb0Um+EjpvLq66XQzGmmrsS2CZGy7cH+FN9wRLAUat99
         GMiJA2n6G6JqDxM+OvXpxVYWq2fYcw7fw3HxxGZohTYFwBKLwmVYlg44nAA57kfjfnuf
         136wZ6pPQcsVYGR8HsRB4ySqlcjafBJHheRq5rQjdzSWbS9+3UgtK4fsdqDRVR0OZXXU
         J5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721125062; x=1721729862;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3LxmxCoW3E8bDNIaxIpOdypnPGQGV/6ObFe/9muMyw=;
        b=CS8WOvBco5EN7ukNb69M3o57kpHR521BznMNP3e+GoWJIMQruVLjBXsPJK+T9tSxA4
         EpmRpz+fTBplV7hkYtCaKzR5ZOqeDzYjq0kvD3eu5RHNE3U97lQyiUXbx50yxKqkD9GC
         XSy2a2vjI7OVRMm3zmFmFU24Vio1fyYG+oCXuvpJ5IgEJTMkSoLjmt5artqHR28SoTLM
         62KZSulRXyA/r7O1sbSmCT/unm7yJ96ETJPEgqSQc/FhSMTagVpCSHN/ew0fIsRmZp7s
         tyCcy6WT+KAW0ecaFcJSAbXxhgsnYshiixD1+0qtqJCR7XF/lonLSbHHUfRmxm2rkUfx
         5qiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQydP8uC6JcfV4OzklVYXmSsas9xGtty5jQ9TPtLDcXZX0/Xt7pZIKVqk/H5+t256IHC8yTPxu541XbsB9XSBoFhjQLeNK
X-Gm-Message-State: AOJu0YxJrkwX5uzT0NsOQ6aHVvKmhhSJUHbL4lg6wCDMIt0vLBqhiRhE
	CgCemKGj/dltMO4VU1KCZAAhr+BJNi038IeLk6zdXifPGvDT/L/B1H6yB4D9y0E=
X-Google-Smtp-Source: AGHT+IH8nILJXMilbhvyoNcXg2t3GY0Ge5UpJ/i0bhjtXPS9zxhmWBR4mLOmhf6ZFPFHsBLZye6CXg==
X-Received: by 2002:a50:c317:0:b0:573:5c4f:27a8 with SMTP id 4fb4d7f45d1cf-59ef01bb430mr971210a12.35.1721125062250;
        Tue, 16 Jul 2024 03:17:42 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a276bsm4603777a12.62.2024.07.16.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 03:17:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>,
  davem@davemloft.net,  dsahern@kernel.org,  edumazet@google.com,
  kuba@kernel.org,  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  soheil@google.com,  syzkaller-bugs@googlegroups.com,  willemb@google.com
Subject: Re: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
In-Reply-To: <5e4905d7-32e1-4359-9720-a32330aec424@redhat.com> (Paolo Abeni's
	message of "Tue, 16 Jul 2024 12:04:02 +0200")
References: <000000000000e1609a061d5330ce@google.com>
	<5e4905d7-32e1-4359-9720-a32330aec424@redhat.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 12:17:40 +0200
Message-ID: <87wmll7i9n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 16, 2024 at 12:04 PM +02, Paolo Abeni wrote:
> On 7/16/24 03:23, syzbot wrote:
>> syzbot found the following issue on:
>> HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of git:/..
>> git tree:       net-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175fb821980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dbcdd8641c4638f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e15b7e15b8a751a91d9a
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bf566980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fff535980000
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/184da3869c30/disk-80ab5445.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/vmlinux-80ab5445.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/06064623a948/bzImage-80ab5445.xz
>> The issue was bisected to:
>> commit 10154dbded6d6a2fecaebdfda206609de0f121a9
>> Author: Jakub Sitnicki <jakub@cloudflare.com>
>> Date:   Wed Jun 26 17:51:26 2024 +0000
>>      udp: Allow GSO transmit from devices with no checksum offload
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142ccbed980000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=162ccbed980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=122ccbed980000
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
>> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
>> skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99 76
>> skb frag:     00000090: f2 53
>> ------------[ cut here ]------------
>> ip6tnl0: caps=(0x00000006401d7869, 0x00000006401d7869)
>> WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>> Modules linked in:
>> CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller-01603-g80ab5445da62 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
>> RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>> Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f 44 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 90 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
>> RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
>> RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
>> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
>> R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
>> FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>>   skb_gso_segment include/net/gso.h:83 [inline]
>>   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>>   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>>   neigh_output include/net/neighbour.h:542 [inline]
>>   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>>   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>>   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>>   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>>   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>   __sock_sendmsg+0xef/0x270 net/socket.c:745
>>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>>   ___sys_sendmsg net/socket.c:2639 [inline]
>>   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>>   __do_sys_sendmmsg net/socket.c:2754 [inline]
>>   __se_sys_sendmmsg net/socket.c:2751 [inline]
>>   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f04f688fe89
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
>> RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
>> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
>> R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
>>   </TASK>
>
> Looking at the console log, the the relevant GSO packet is an UFO one with
> CSUM_NONE. commit 10154dbded6d6a2fecaebdfda206609de0f121a9 only adjust the skb
> csum for USO packets. @Jakub S. could you please have a look?

Will do. Thanks for the hint.


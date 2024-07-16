Return-Path: <netdev+bounces-111715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC5932389
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CA3282FFE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA482D7B8;
	Tue, 16 Jul 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH8spW8h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2721535DC
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124253; cv=none; b=OedzCBnpIDaVoeFV7hdkSXnyRzGMmTuv5PQO2fbT8V58i+FRqSs3pobkxtHpPY6SG9W0Ur3d95wz1Y8ErHylCHfo5Bvv6vWszqv9xKKF/M8Z199BUGTxjZw9x3QOK+Gprl0OzRgEUStmSZxQWxOlzrIxSP65FlUFG5mg1WppFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124253; c=relaxed/simple;
	bh=MUFuR2pXNxUKKtiasIUfiYjF2PsXeIixjzGA7sGDhIc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=gPWX1+yBDbUw5Y8nGcXNjB1mfeZjKR8eL0kLV5vT2qaDVL4VmU41fOfHiNyNDbUs8Kd2u8LnkIiLc5OXf+vuF5+q8ZALl4EmumlM4+CvpcrFdCac3BcE9yWFuVc/i2wCJH619eheHETsTmVcFkDfnues7mWNABqwDW293xLdZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH8spW8h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721124249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nifFBz3CcmH0KE26JlPLMWxX8zry3tjdLhy6RuGs/+w=;
	b=ZH8spW8h1uLQ23KyieQR1ngY/0yxf56+q0HYfUobbPjB/KjHcjLqIlJgXXPL/M6gCc2O8F
	1WQp/zkagag/29nNslQoicvBjIinuNXox+42Ld/FFyuJrpmdwxx30FOYMotdmfVFlpMSdj
	j10PeStxrQ6K3P9EoT2GvAjUbSgCLZ8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-_Lq5oMLbOIeTY-N6BIv-iw-1; Tue, 16 Jul 2024 06:04:08 -0400
X-MC-Unique: _Lq5oMLbOIeTY-N6BIv-iw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e954dd0deso227703e87.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 03:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721124245; x=1721729045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nifFBz3CcmH0KE26JlPLMWxX8zry3tjdLhy6RuGs/+w=;
        b=MHq85aVNLGVQMSK01DStWPgOAgZR9TsEp6RjYA5NJTkj7ZaoK6g3iJYn/KhJDZzErY
         kZJvfMCUmK/CNY0QHml3PoDGen4+fsIB2gpphCETdM9YsmMlKV3I6MToJItutAwvUWui
         VuLfccSUV9yiC7/l8RD5APqfo5hd6Su42Cibz+TPkoeWa8dRhfnsH4ol5y+uZVfE1QMY
         KskMe5XDAgcWSxCVa9YTDFhMq+Gv4UkLVfokDUQitODIxlZV4qzYzff60mUzUI7CzKHm
         lJMfiCApUS16FEUM1Hzn6x5RhUjc0wBrO8rFegUpFVPbj3uatR0xJTaOcsQ/OwWEIcsY
         mtsg==
X-Forwarded-Encrypted: i=1; AJvYcCUVY+v6b3ZTERkcQO81q8R4rdFyd8a68pkPL213YIZxQcXUDejiy6BA2i0n2EtNemTGE2CTOZo3RCaaF6TfFIZI9apEADGh
X-Gm-Message-State: AOJu0Yx5gJAB6vd2zQAEd+OEkZASmz9cded4jf8R+4vSPRKUkDLjEO4E
	wa0tUogCfGS0kkEMBnccLMXJOYJYSYqEc4PgeWdqSQLb9mFrKnt9Plwn1xVGMFojcytNJZk7ehF
	27oHdxSy5Svi5xQ0h9wzUGlvy1rehSvtLZ5gdXUOIx5Nvej06OcqJmfbrcdE3kQ==
X-Received: by 2002:a2e:bc03:0:b0:2ec:16c4:ead5 with SMTP id 38308e7fff4ca-2eef2d784d8mr13074361fa.2.1721124245370;
        Tue, 16 Jul 2024 03:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtM5cREuYKllv0xLM4vxnYGWZSnPcGKe7O6hxVUR6E6z5n02k3K8VGFZ360MPT9Us8phm49A==
X-Received: by 2002:a2e:bc03:0:b0:2ec:16c4:ead5 with SMTP id 38308e7fff4ca-2eef2d784d8mr13074161fa.2.1721124244858;
        Tue, 16 Jul 2024 03:04:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccad8sm8558606f8f.60.2024.07.16.03.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 03:04:04 -0700 (PDT)
Message-ID: <5e4905d7-32e1-4359-9720-a32330aec424@redhat.com>
Date: Tue, 16 Jul 2024 12:04:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
To: syzbot <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 jakub@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, soheil@google.com, syzkaller-bugs@googlegroups.com,
 willemb@google.com
References: <000000000000e1609a061d5330ce@google.com>
Content-Language: en-US
In-Reply-To: <000000000000e1609a061d5330ce@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 03:23, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of git:/..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175fb821980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dbcdd8641c4638f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e15b7e15b8a751a91d9a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bf566980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fff535980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/184da3869c30/disk-80ab5445.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/vmlinux-80ab5445.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/06064623a948/bzImage-80ab5445.xz
> 
> The issue was bisected to:
> 
> commit 10154dbded6d6a2fecaebdfda206609de0f121a9
> Author: Jakub Sitnicki <jakub@cloudflare.com>
> Date:   Wed Jun 26 17:51:26 2024 +0000
> 
>      udp: Allow GSO transmit from devices with no checksum offload
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142ccbed980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=162ccbed980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=122ccbed980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")
> 
> skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99 76
> skb frag:     00000090: f2 53
> ------------[ cut here ]------------
> ip6tnl0: caps=(0x00000006401d7869, 0x00000006401d7869)
> WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
> Modules linked in:
> CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller-01603-g80ab5445da62 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
> Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f 44 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 90 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
> RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
> RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
> R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
> FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>   skb_gso_segment include/net/gso.h:83 [inline]
>   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>   neigh_output include/net/neighbour.h:542 [inline]
>   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0xef/0x270 net/socket.c:745
>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>   ___sys_sendmsg net/socket.c:2639 [inline]
>   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>   __do_sys_sendmmsg net/socket.c:2754 [inline]
>   __se_sys_sendmmsg net/socket.c:2751 [inline]
>   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f04f688fe89
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
> RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
> R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
>   </TASK>

Looking at the console log, the the relevant GSO packet is an UFO one 
with CSUM_NONE. commit 10154dbded6d6a2fecaebdfda206609de0f121a9 only 
adjust the skb csum for USO packets. @Jakub S. could you please have a look?

Thanks!

Paolo



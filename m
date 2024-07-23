Return-Path: <netdev+bounces-112663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368493A7F8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5E91C22115
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F961411F9;
	Tue, 23 Jul 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CxY+elzb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54E13C691
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765081; cv=none; b=f6sSzo05FiCUI30Nv87kYhV6xJGqHCQ2iUrMOoySoAymqKIqVLSZCgySwDyh7sSV3t9XZkLPudZOjtcMnRfSvPZMHigYtMVCYxmUQnxO3jO7itl8U0309VgR9NtAhP8BEmZFYGpZsgO3a7b6m0ATkde4hXaG8e/snRBqnkU1SMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765081; c=relaxed/simple;
	bh=6okmN9u6g0YzEvUOMVo2qECWxsyJwW83+0wG5FuRGho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qeOdojLhL/wEWzu9WqUqhty3KCB4EHYMHH5IbYXKhmL40ughNdV5bs+Pqu7vKy4M1NRroStZWQt86XuF2YO5TsH7kB7KA1SYJjPi+SpE1QwmhuxqzR1hzNFJgaJAIoo+IrjL1FSCxBffgh+pHRCa/4yCBTxCZ/rJ2qcGkFbg3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CxY+elzb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so5906753a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721765077; x=1722369877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiy3vXnbgGkz9PmoVK9WFoCSTDARahNVFjTn/3fjxMk=;
        b=CxY+elzbvV7MHhh7s86xRosX5jPTWNbiMHYb7ctiqslipFEIvtfVipQAjHRnNHadky
         W3uP3SppCFypRTtLW81OAsnZUScH6jsbnzAHKPddb1U+IdNJnRFgrfaordqeyBknnzr5
         Gto9ye+qRXoE6OD7+R59Fv5g01261u0yJ5Iuc1VOc4GonrWjfxSRO/HSL0o5RrJ11zmY
         ekebo9Zrbx60ag5JeppY4GZogz/BvgwFvxfdqfdS5R2IvGpWh8H0eomzkZn/blsZn30g
         nWmwQKqFCe5kVLxjNHcZDYzYVD6N6cKIQNRgI1yr0n4SihFq9zQ9bBCmHFp+KcAcbj07
         itkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721765077; x=1722369877;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aiy3vXnbgGkz9PmoVK9WFoCSTDARahNVFjTn/3fjxMk=;
        b=qR5d8erlrrBEDz59C/DH0/r7ABf0vKBjc7Qoy6Qdc67XR5oz81Os8PBvN+ytb1H4+V
         19ib63/EnlQZWhbn/YVnzaubzmZhQgkekCMbgNg3P0M+6qRuH0LmsBykbooLa7XiTq1m
         tkQFFKGIRG9yFMIlh4TCMV87Jxp6kxfU9wZrzEQg1zhVNFxdklZw0mHy8bJeafGsppp4
         p/W75afKmsr1aSp2z1biTGNOMJ3SnjN/4hR/xiNzAFAUzIoYUca5Ur9hrcDNjVU6q/90
         VC5o6bOdZ57+DwqIx6isv4jM32jxRxmJwQ51O/OfVqP//pk0gbQmd4RH7S7HbF2Wbm8w
         0jQA==
X-Forwarded-Encrypted: i=1; AJvYcCV924kjCZKYTpO9a5MZLpek7kaevITutsqn/8M7/tn/JnjpesWsK5NDGlWFdlExrRYETFS9R6e0WhyKmOV6JZSvb7igxmVm
X-Gm-Message-State: AOJu0YyJEceBMPJ8Gngh6PPRiYXnGxzR3q7GMnh6FlqGqnImzi4Nj3rR
	GVwgsHnacAX6bmZAUWGx/eM71hsojYpeoAUcVNaeqKDLE5zzoLva0f1+coBATlE=
X-Google-Smtp-Source: AGHT+IHnuN6mlUjEqavFEeco2LD67qtvChZarrNGARbx17Z56kANRU6SoHNPIyFGEa4JVjtmMYQglQ==
X-Received: by 2002:a17:907:9444:b0:a72:5967:b3a with SMTP id a640c23a62f3a-a7a4c0113a1mr780118966b.22.1721765077538;
        Tue, 23 Jul 2024 13:04:37 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aaee13d39sm7380166b.218.2024.07.23.13.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 13:04:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  soheil@google.com,  syzkaller-bugs@googlegroups.com,  willemb@google.com,
  kernel-team@cloudflare.com
Subject: Re: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
In-Reply-To: <87o76t6urw.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Fri, 19 Jul 2024 21:34:11 +0200")
References: <000000000000e1609a061d5330ce@google.com>
	<5e4905d7-32e1-4359-9720-a32330aec424@redhat.com>
	<87wmll7i9n.fsf@cloudflare.com>
	<CANn89iKa8fyD2s1VdHJ2SQAUUzm-iPEXoKOGF6wvuqxofC4Frw@mail.gmail.com>
	<87o76t6urw.fsf@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 23 Jul 2024 22:04:35 +0200
Message-ID: <877cdbdgdo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 09:34 PM +02, Jakub Sitnicki wrote:
> On Tue, Jul 16, 2024 at 07:54 AM -07, Eric Dumazet wrote:
>> On Tue, Jul 16, 2024 at 3:17=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>>>
>>> On Tue, Jul 16, 2024 at 12:04 PM +02, Paolo Abeni wrote:
>>> > On 7/16/24 03:23, syzbot wrote:
>>> >> syzbot found the following issue on:
>>> >> HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of=
 git:/..
>>> >> git tree:       net-next
>>> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D175fb821=
980000
>>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2dbcdd86=
41c4638f
>>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3De15b7e15b8=
a751a91d9a
>>> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils fo=
r Debian) 2.40
>>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172bf5=
66980000
>>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12fff535=
980000
>>> >> Downloadable assets:
>>> >> disk image: https://storage.googleapis.com/syzbot-assets/184da3869c3=
0/disk-80ab5445.raw.xz
>>> >> vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/v=
mlinux-80ab5445.xz
>>> >> kernel image: https://storage.googleapis.com/syzbot-assets/06064623a=
948/bzImage-80ab5445.xz
>>> >> The issue was bisected to:
>>> >> commit 10154dbded6d6a2fecaebdfda206609de0f121a9
>>> >> Author: Jakub Sitnicki <jakub@cloudflare.com>
>>> >> Date:   Wed Jun 26 17:51:26 2024 +0000
>>> >>      udp: Allow GSO transmit from devices with no checksum offload
>>> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D142cc=
bed980000
>>> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D162cc=
bed980000
>>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D122ccbed=
980000
>>> >> IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
>>> >> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
>>> >> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no c=
hecksum offload")
>>> >> skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99=
 76
>>> >> skb frag:     00000090: f2 53
>>> >> ------------[ cut here ]------------
>>> >> ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
>>> >> WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offloa=
d+0x166/0x1a0 net/core/dev.c:3291
>>> >> Modules linked in:
>>> >> CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkal=
ler-01603-g80ab5445da62 #0
>>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 06/07/2024
>>> >> RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>>> >> Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f=
 44 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 =
90 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
>>> >> RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
>>> >> RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
>>> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>> >> RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
>>> >> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
>>> >> R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
>>> >> FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:00000000=
00000000
>>> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> >> CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
>>> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> >> Call Trace:
>>> >>   <TASK>
>>> >>   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>>> >>   skb_gso_segment include/net/gso.h:83 [inline]
>>> >>   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>>> >>   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>>> >>   neigh_output include/net/neighbour.h:542 [inline]
>>> >>   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>>> >>   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>>> >>   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>>> >>   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>>> >>   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>>> >>   sock_sendmsg_nosec net/socket.c:730 [inline]
>>> >>   __sock_sendmsg+0xef/0x270 net/socket.c:745
>>> >>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>>> >>   ___sys_sendmsg net/socket.c:2639 [inline]
>>> >>   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>>> >>   __do_sys_sendmmsg net/socket.c:2754 [inline]
>>> >>   __se_sys_sendmmsg net/socket.c:2751 [inline]
>>> >>   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>>> >>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>> >>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>> >>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> >> RIP: 0033:0x7f04f688fe89
>>> >> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48=
 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>>> >> RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001=
33
>>> >> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
>>> >> RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
>>> >> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
>>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
>>> >> R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
>>> >>   </TASK>
>>> >
>>> > Looking at the console log, the the relevant GSO packet is an UFO one=
 with
>>> > CSUM_NONE. commit 10154dbded6d6a2fecaebdfda206609de0f121a9 only adjus=
t the skb
>>> > csum for USO packets. @Jakub S. could you please have a look?
>>>
>>> Will do. Thanks for the hint.
>>
>> The trigger for the bug is the following :
>>
>> setsockopt(3, SOL_IPV6, IPV6_HOPOPTS,
>> "\0\3\0\0\0\0\0\0\5\2\0\0\0\1\0\302\4\200\0\0\0\5\2\0\6\302\4\0\0\0\1\30=
2"...,
>> 40) =3D 0
>>
>> Some random IPV6_HOPTS, with multiple IPV6_TLV_JUMBO options
>>
>> Non GSO path sends a malformed packet just fine, but GSO complains loudl=
y.
>>
>> (flowlabel 0x754ca, hlim 64, next-header Options (0) payload length:
>> 186) localhost > localhost: HBH
>> (pad1)(pad1)(pad1)(pad1)(pad1)(pad1)(rtalert: 0x0000)
>> (pad1)(padn)(jumbo: 2147483648 - payload len !=3D 0) (rtalert: 0x0006)
>> (jumbo: 1 - already seen)  [|hbhopt]
>
> Thank you for the hint. Extracted a reproducer. Fix will follow.

Thanks for the patience.

I've got a fix to propose which pulls the gso_skb->ip_summed tweak added
to __udp_gso_segment() in commit 10154dbded6d ("udp: Allow GSO transmit
from devices with no checksum offload") from gso/udp code up to the udp
layer (udp[_v6]_send_skb()).

This warning can also be triggered for an ipv4 tunnel by turning off
csum offload (ethtool -K $tnl tx-checksum-ip-generic off). Will extend
udpgso.sh test to cover both v4 and v6.

[...]


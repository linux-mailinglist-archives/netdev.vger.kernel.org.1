Return-Path: <netdev+bounces-112267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FB937CF8
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511C228294A
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528954BE7;
	Fri, 19 Jul 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BOKOv0o1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B114D8A1
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721417657; cv=none; b=peQDbUTtBmW+RkT1T9zQYDVwquwzifgrP/oDu1IgoyQHhJkNJ+pf/FkKzmLc38vziMplrKiMt0CWE73u/KITY28PicafWCpHbD/3BxGefLK4a0Sz7UrWL/YoHxNAuZ1ULEDLPf/Oook/zanKNR0mr7fZ9c2xboVZF1VYukm/tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721417657; c=relaxed/simple;
	bh=1LcEGMRKpHefe4HBGn2yAJ/81rJm8kFZ9X+xGiRPOUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6kVCqbPlksUs494Gw+qYXYMmqfSA3osJ1ds6WOWBtm0UgVB4CC964G5eyljjaLtUDirH5d1tGLCDr7wyxSkqOaZxxZ+hmtgfhYFQ6VPHi4TKtAv7hUb57ish0QE164q2Pat7tNBTqUbZ8GKwuDUx+tjQOWLV3jZQbjCZv+Wa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BOKOv0o1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c4309fc8so235958766b.3
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721417654; x=1722022454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45OOk2X+OgkpVAAZk8EzrlyU7PCqpeXI+TLpvkIwkAE=;
        b=BOKOv0o19/3HKx977laraN8CVAhZnYs9ZHxgo2MBFQwAnwy82VzI/ddeLceVmNgJki
         VS9yG/o1KLr4o6xZBijPxpho0M63p/MfURFvMiWLuQn0QSrr6lMCdypX7drk0p8Ufebe
         2KOqjTkxWCiPJUgQQ5DN3S6ZLICr2ounEeTaH8Ae6479KA08Tls/exMPRpe4Dge91O8u
         HazblLa+HMJmnadc+p/IBbq7khicz0SxRwbxDYefRL66d0TjCRWFjfTIw0g8TChFaJdv
         guu2qVJ9nAxZXVS1f5gtKifKuGQf7in51THuyf6KkXNdY7ewqh58EkeG9xaSMZICgyKB
         lI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721417654; x=1722022454;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45OOk2X+OgkpVAAZk8EzrlyU7PCqpeXI+TLpvkIwkAE=;
        b=dzffNMffW/UOAWz5kIb34vHPm6eSe+37h4O4WVei9RIpRnKD4Z3D71mJJkUc/kfUqf
         /Uy9/tO1QhsDllI1n3exWiVTRwkRUlV8Rmf+GYn4Us6tepUzrImDhSx29bDgNWY5LuNF
         +TGgS2DQNbtIppNEgHotALHgCT19pjo00/dVA7qwQpNvUJOAPYE26DJNMMJ1ztFIOCL7
         QEZGc72EkL8zkz/mgOIeEIyTNWFUSk2EQlsbulnhMm+ehEpLYVSs0iLjTlZTb0tLIyIx
         r2wG7uZlbrIpb9NRM3KJaU2JDvakhFF9bCAI77nwKw8UPOnsgwh/G75H48Rj4SxjUhyP
         XWNg==
X-Forwarded-Encrypted: i=1; AJvYcCVC+PpT2muXJgFvTzs7Gt8dJrXxL4RB3Ol22PZ3871DaPT2rr1F/06BhMLwXgJ3czEGpphD6bLhLudDALiS/hv5bb8isv5W
X-Gm-Message-State: AOJu0YzR4s77GmJss+L3vtb5Hqxc2ykNoAB6ZO4ZAiHZgE9wfwOOQqS3
	tonIV5WAfGw7L/VT3LJBb1z752cfyFSW2Gc/KdaDjRUGmpc+mpqCyi+98gRgAxw=
X-Google-Smtp-Source: AGHT+IHBzfJwcfSPvs7BtKkvjLTp7yOzcYbMGthLruITrVWifsoPc/dq/3a33ZNqdPFzyfHDtp1wSw==
X-Received: by 2002:a17:906:fb90:b0:a77:d52d:5c61 with SMTP id a640c23a62f3a-a7a01364897mr555544866b.69.1721417653603;
        Fri, 19 Jul 2024 12:34:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c91e09csm67418466b.155.2024.07.19.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 12:34:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>,  syzbot
 <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  soheil@google.com,  syzkaller-bugs@googlegroups.com,  willemb@google.com,
 kernel-team@cloudflare.com
Subject: Re: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
In-Reply-To: <CANn89iKa8fyD2s1VdHJ2SQAUUzm-iPEXoKOGF6wvuqxofC4Frw@mail.gmail.com>
	(Eric Dumazet's message of "Tue, 16 Jul 2024 07:54:00 -0700")
References: <000000000000e1609a061d5330ce@google.com>
	<5e4905d7-32e1-4359-9720-a32330aec424@redhat.com>
	<87wmll7i9n.fsf@cloudflare.com>
	<CANn89iKa8fyD2s1VdHJ2SQAUUzm-iPEXoKOGF6wvuqxofC4Frw@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 19 Jul 2024 21:34:11 +0200
Message-ID: <87o76t6urw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 07:54 AM -07, Eric Dumazet wrote:
> On Tue, Jul 16, 2024 at 3:17=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Tue, Jul 16, 2024 at 12:04 PM +02, Paolo Abeni wrote:
>> > On 7/16/24 03:23, syzbot wrote:
>> >> syzbot found the following issue on:
>> >> HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of =
git:/..
>> >> git tree:       net-next
>> >> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D175fb8219=
80000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2dbcdd864=
1c4638f
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3De15b7e15b8a=
751a91d9a
>> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
>> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172bf56=
6980000
>> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12fff5359=
80000
>> >> Downloadable assets:
>> >> disk image: https://storage.googleapis.com/syzbot-assets/184da3869c30=
/disk-80ab5445.raw.xz
>> >> vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/vm=
linux-80ab5445.xz
>> >> kernel image: https://storage.googleapis.com/syzbot-assets/06064623a9=
48/bzImage-80ab5445.xz
>> >> The issue was bisected to:
>> >> commit 10154dbded6d6a2fecaebdfda206609de0f121a9
>> >> Author: Jakub Sitnicki <jakub@cloudflare.com>
>> >> Date:   Wed Jun 26 17:51:26 2024 +0000
>> >>      udp: Allow GSO transmit from devices with no checksum offload
>> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D142ccb=
ed980000
>> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D162ccb=
ed980000
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D122ccbed9=
80000
>> >> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>> >> Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
>> >> Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no ch=
ecksum offload")
>> >> skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99 =
76
>> >> skb frag:     00000090: f2 53
>> >> ------------[ cut here ]------------
>> >> ip6tnl0: caps=3D(0x00000006401d7869, 0x00000006401d7869)
>> >> WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload=
+0x166/0x1a0 net/core/dev.c:3291
>> >> Modules linked in:
>> >> CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkall=
er-01603-g80ab5445da62 #0
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 06/07/2024
>> >> RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
>> >> Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f =
44 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 9=
0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
>> >> RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
>> >> RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
>> >> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> >> RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
>> >> R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
>> >> R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
>> >> FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:000000000=
0000000
>> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
>> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> >> Call Trace:
>> >>   <TASK>
>> >>   __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
>> >>   skb_gso_segment include/net/gso.h:83 [inline]
>> >>   validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
>> >>   __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
>> >>   neigh_output include/net/neighbour.h:542 [inline]
>> >>   ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
>> >>   ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>> >>   ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
>> >>   udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
>> >>   udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
>> >>   sock_sendmsg_nosec net/socket.c:730 [inline]
>> >>   __sock_sendmsg+0xef/0x270 net/socket.c:745
>> >>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>> >>   ___sys_sendmsg net/socket.c:2639 [inline]
>> >>   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
>> >>   __do_sys_sendmmsg net/socket.c:2754 [inline]
>> >>   __se_sys_sendmmsg net/socket.c:2751 [inline]
>> >>   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
>> >>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> >>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>> >>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> >> RIP: 0033:0x7f04f688fe89
>> >> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> >> RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
>> >> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
>> >> RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
>> >> RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
>> >> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
>> >> R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
>> >>   </TASK>
>> >
>> > Looking at the console log, the the relevant GSO packet is an UFO one =
with
>> > CSUM_NONE. commit 10154dbded6d6a2fecaebdfda206609de0f121a9 only adjust=
 the skb
>> > csum for USO packets. @Jakub S. could you please have a look?
>>
>> Will do. Thanks for the hint.
>
> The trigger for the bug is the following :
>
> setsockopt(3, SOL_IPV6, IPV6_HOPOPTS,
> "\0\3\0\0\0\0\0\0\5\2\0\0\0\1\0\302\4\200\0\0\0\5\2\0\6\302\4\0\0\0\1\302=
"...,
> 40) =3D 0
>
> Some random IPV6_HOPTS, with multiple IPV6_TLV_JUMBO options
>
> Non GSO path sends a malformed packet just fine, but GSO complains loudly.
>
> (flowlabel 0x754ca, hlim 64, next-header Options (0) payload length:
> 186) localhost > localhost: HBH
> (pad1)(pad1)(pad1)(pad1)(pad1)(pad1)(rtalert: 0x0000)
> (pad1)(padn)(jumbo: 2147483648 - payload len !=3D 0) (rtalert: 0x0006)
> (jumbo: 1 - already seen)  [|hbhopt]

Thank you for the hint. Extracted a reproducer. Fix will follow.

--8<--

 ~ # cat repro.sh
#!/usr/bin/env bash

unshare -Urn bash <<EOF

set -e

ip link add name sink mtu 1500 type dummy
ip addr add dev sink fd11::1/48 nodad
ip link set dev sink up
ethtool -K sink tx-checksum-ip-generic off >/dev/null
ethtool -K sink tx-udp-segmentation off >/dev/null

ip -6 tunnel add ip6tnl mode ip6ip6 local fd11::1 remote fd11::2
ip link set dev ip6tnl up
ip addr add fd00::1/48 dev ip6tnl

python -c '''

from socket import *

UDP_SEGMENT =3D 103

hopopts =3D b"\x00\x03\x00\x00\x00\x00\x00\x00\x05\x02\x00\x00\x00\x01\x00\=
xc2\x04\x80\x00\x00\x00\x05\x02\x00\x06\xc2\x04\x00\x00\x00\x01\xc2\x04\x00=
\x00\x00\x04\x00\x00\x00"
s =3D socket(AF_INET6, SOCK_DGRAM)
s.setsockopt(IPPROTO_IPV6, IPV6_HOPOPTS, hopopts)
s.setsockopt(SOL_UDP, UDP_SEGMENT, 145)
s.sendto(b"x" * 3000, ("fd00::2", 9))

'''

false

EOF
 ~ # ./repro.sh
[   59.122084] skb len=3D3080 headroom=3D120 headlen=3D80 tailroom=3D0
[   59.122084] mac=3D(120,0) mac_len=3D0 net=3D(120,72) trans=3D192
[   59.122084] shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D145 type=3D131072=
 segs=3D21))
[   59.122084] csum(0x600c0 start=3D192 offset=3D6 ip_summed=3D0 complete_s=
w=3D0 valid=3D0 level=3D0)
[   59.122084] hash(0xfd64b255 sw=3D1 l4=3D1) proto=3D0x86dd pkttype=3D0 ii=
f=3D0
[   59.122084] priority=3D0x0 mark=3D0x0 alloc_cpu=3D13 vlan_all=3D0x0
[   59.122084] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, tr=
ans=3D0)
[   59.122331] dev name=3Dip6tnl feat=3D0x00000006401d5869
[   59.122362] sk family=3D10 type=3D2 proto=3D17
[   59.122386] skb linear:   00000000: 60 0d 55 b2 0b e0 00 40 fd 00 00 00 =
00 00 00 00
[   59.122428] skb linear:   00000010: 00 00 00 00 00 00 00 01 fd 00 00 00 =
00 00 00 00
[   59.122473] skb linear:   00000020: 00 00 00 00 00 00 00 02 11 03 00 00 =
00 00 00 00
[   59.122515] skb linear:   00000030: 05 02 00 00 00 01 00 c2 04 80 00 00 =
00 05 02 00
[   59.122557] skb linear:   00000040: 06 c2 04 00 00 00 01 c2 ed fb 00 09 =
0b c0 05 d6
[   59.122601] skb frag:     00000000: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122653] skb frag:     00000010: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122696] skb frag:     00000020: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122739] skb frag:     00000030: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122781] skb frag:     00000040: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122824] skb frag:     00000050: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122866] skb frag:     00000060: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122914] skb frag:     00000070: 78 78 78 78 78 78 78 78 78 78 78 78 =
78 78 78 78
[   59.122957] ------------[ cut here ]------------
[   59.122987] ip6tnl: caps=3D(0x00000006401d5869, 0x0000000000000000)
[   59.123041] WARNING: CPU: 13 PID: 294 at net/core/dev.c:3291 skb_warn_ba=
d_offload+0x86/0xd0
[   59.123089] Modules linked in:
[   59.123113] CPU: 13 PID: 294 Comm: python Not tainted 6.10.0-rc7+ #44
[   59.123149] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
[   59.123197] RIP: 0010:skb_warn_bad_offload+0x86/0xd0
[   59.123228] Code: e6 48 c7 c7 79 1b f4 bc 48 85 d2 48 8d 8a a0 03 00 00 =
48 8d 95 b8 00 00 00 48 0f 44 c8 48 85 ed 48 0f 44 d0 e8 fb 33 4b ff 90 <0f=
> 0b 90 90 5b 5d 41 5c c3 cc cc cc cc 80 bd 30 01 00 00 00 49 c7
[   59.123322] RSP: 0018:ffffb25540993990 EFLAGS: 00010282
[   59.123352] RAX: 0000000000000000 RBX: ffff9262027e6f00 RCX: 00000000000=
00000
[   59.123395] RDX: 0000000000000000 RSI: ffffb25540993850 RDI: 00000000000=
00001
[   59.123438] RBP: ffff926205ece000 R08: 00000000ffffdfff R09: 00000000000=
00001
[   59.123486] R10: 00000000ffffdfff R11: ffffffffbd6a8420 R12: ffff926205e=
ce130
[   59.123529] R13: 000000000003078c R14: ffff9262027e6f00 R15: 00000000000=
00050
[   59.123573] FS:  00007f5188eb1040(0000) GS:ffff92623eb40000(0000) knlGS:=
0000000000000000
[   59.123620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.123655] CR2: 0000000000661700 CR3: 00000000027aa000 CR4: 00000000007=
50ef0
[   59.123699] PKRU: 55555554
[   59.123715] Call Trace:
[   59.123733]  <TASK>
[   59.123751]  ? __warn+0x8c/0x190
[   59.123777]  ? skb_warn_bad_offload+0x86/0xd0
[   59.123808]  ? report_bug+0x164/0x190
[   59.123834]  ? handle_bug+0x3b/0x70
[   59.123860]  ? exc_invalid_op+0x17/0x70
[   59.123884]  ? asm_exc_invalid_op+0x1a/0x20
[   59.123920]  ? skb_warn_bad_offload+0x86/0xd0
[   59.123954]  __skb_gso_segment+0xf0/0x170
[   59.123981]  validate_xmit_skb.isra.0+0x15e/0x2c0
[   59.124011]  __dev_queue_xmit+0x217/0x12e0
[   59.124037]  ? lock_acquire+0xc0/0x2d0
[   59.124063]  ? find_held_lock+0x2b/0x80
[   59.124087]  ? ip6_finish_output2+0x27a/0xb20
[   59.124120]  ? lock_release+0xbf/0x290
[   59.124144]  ? lockdep_hardirqs_on_prepare+0xda/0x1a0
[   59.124175]  ip6_finish_output2+0x27a/0xb20
[   59.124201]  ? ip6_mtu+0x9a/0x1c0
[   59.124225]  ? lock_release+0xbf/0x290
[   59.124251]  ip6_finish_output+0x27a/0x4d0
[   59.124278]  ip6_send_skb+0x36/0xb0
[   59.124304]  udp_v6_send_skb+0x1d6/0x480
[   59.124331]  udpv6_sendmsg+0xc04/0xf20
[   59.124356]  ? __lock_acquire+0xe9d/0x16d0
[   59.124381]  ? __pfx_ip_generic_getfrag+0x10/0x10
[   59.124415]  ? release_sock+0x1d/0xb0
[   59.124441]  ? find_held_lock+0x2b/0x80
[   59.124464]  ? find_held_lock+0x2b/0x80
[   59.124491]  ? __sys_sendto+0x123/0x1f0
[   59.124516]  __sys_sendto+0x123/0x1f0
[   59.124544]  ? __rseq_handle_notify_resume+0x42a/0x5c0
[   59.124579]  __x64_sys_sendto+0x24/0x30
[   59.124603]  do_syscall_64+0xbb/0x1d0
[   59.124628]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   59.124660] RIP: 0033:0x7f5188fdca37
[   59.124684] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f =
00 f3 0f 1e fa 80 3d 15 bb 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
[   59.124775] RSP: 002b:00007ffe9b877698 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002c
[   59.124817] RAX: ffffffffffffffda RBX: 00007ffe9b877738 RCX: 00007f5188f=
dca37
[   59.124860] RDX: 0000000000000bb8 RSI: 000000003998f950 RDI: 00000000000=
00003
[   59.124903] RBP: 0000000000000000 R08: 00007ffe9b8777b0 R09: 00000000000=
0001c
[   59.124947] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00000
[   59.124990] R13: 0000000000000000 R14: 00000000004a86e2 R15: 0000000000a=
71a18
[   59.125037]  </TASK>
[   59.125055] irq event stamp: 54030
[   59.125078] hardirqs last  enabled at (54040): [<ffffffffbb9e10fd>] cons=
ole_unlock+0x10d/0x130
[   59.125127] hardirqs last disabled at (54049): [<ffffffffbb9e10e2>] cons=
ole_unlock+0xf2/0x130
[   59.125176] softirqs last  enabled at (53220): [<ffffffffbc4a9de9>] ___n=
eigh_create+0x959/0xe30
[   59.125224] softirqs last disabled at (53224): [<ffffffffbc494736>] __de=
v_queue_xmit+0x76/0x12e0
[   59.125273] ---[ end trace 0000000000000000 ]---
 ~ #


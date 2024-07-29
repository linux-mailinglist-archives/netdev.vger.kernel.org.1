Return-Path: <netdev+bounces-113610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCA93F473
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1CE1C21D91
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D3145FED;
	Mon, 29 Jul 2024 11:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E31448DD
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253791; cv=none; b=moc1I9zcIDzztHSIOHVPfes8aW1+dI4tghCVdLV+n58rDRzbFb+pqICVCYNB+awC72LtjIYsEydbvtcUcNDgkZ3hHQ6RfFjg/dDuEOccnJFMQy2sTPhAXC6guFCMfkIuzKhNoqFHDlJP6vnQgMpDMftIR/dxXkV1qKOetn7IADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253791; c=relaxed/simple;
	bh=JLCY5qPvbYBcS+lsUKiVGZQ/CoHUs/uAtUUwHf/j4rA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BhI7g0nqk59uTKoFen35wX9gpdPWTzVGbKMhBSYwmb6Q0HcKI+eX4Bo07cpUMYGlF8RULi45RZioaM2nRC3KdT7Ze8Tm4F+RxnG2vm/XVPd1lvJOlZZkf3XK+M+BQDvaLZbPsHHrIyq50APsFimxEQi31Ur1rH9JYXQR8O0dsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a17513a7eso65263905ab.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 04:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253789; x=1722858589;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Mu7mu3T+YW/XcQY0fzrTrBn7OZb3PrUgRiRmHWzIY=;
        b=ZUFsbvSJqzYx53zmoFQENAas0bkLQ7hbHPN2uxUX/u2RC4+2wdkXEof1CB12d1iexF
         sk8HUrQlhYSDaxnWNSv5z8fzcltVUACkAAKedJDw1p57nvH85lsCMotl8b8VUjVTJscN
         3jrCxoODHgSE0HLkKSKzXALUh6b0/sm1m4OdC6POp0c4bxM7AYM7VhpnnwyKRg7jde96
         yZ4IXWsOsoBKh4ApaTscSqt5pjuBTXqwOkPCUNlrlY7D6I+gRDsYR55ysP4Sytm+80ti
         4ETCSsyX4W/WoIDKAAR8fw0+/P+iMgca3CI2kcJWhjaNDW1npI72jp3K7dAdORobCW3U
         bppg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuOQDzfFh1xYJQgHM0UmiXi2xhTTXGyX0u7WAb9fcBqU32rfnOJr8/X6AcfM6Kw8xTJYhvQwcLObyf4y2LwoJFQR5XkVV
X-Gm-Message-State: AOJu0YzTa/qar7xs4oYdh8dTtOX79MmfZ8dE8OqYQmP0hPvURpaDYtNw
	N1vp/ChZ1gBslFab2e5C8Oar1qzBfmk6gkkcdJAI1QhTeL4Zuy1fVz0SHjzqXBlPHZY68ITf3Pc
	llmht+1UeGBNHC8EawdUtaUONZy9SHw9cHOzTdtPAhYiCsjJLwMQKmhw=
X-Google-Smtp-Source: AGHT+IFGxT0upbKN5XWc4zf/MbDcatg0y0fagMYFUlu74SiZJHCJfGvuVLxr5RlXVc+Q0ttjdH6Irm3V4AKrIAuyIvHsAps4yROS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:39a:14c9:3f80 with SMTP id
 e9e14a558f8ab-39aec44de30mr5315645ab.5.1722253789121; Mon, 29 Jul 2024
 04:49:49 -0700 (PDT)
Date: Mon, 29 Jul 2024 04:49:49 -0700
In-Reply-To: <6b40e022-369c-8083-07d4-3036de1d3e65@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005060f2061e6175b6@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in net_generic
From: syzbot <syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com>
To: jchapman@katalix.com
Cc: davem@davemloft.net, edumazet@google.com, jchapman@katalix.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 26/07/2024 16:02, Jakub Kicinski wrote:
>> CC: James [L2TP]
>> 
>> On Thu, 25 Jul 2024 03:37:24 -0700 syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1625a15e980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=6acef9e0a4d1f46c83d4
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> userspace arch: arm64
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/fea69a9d153c/disk-c912bf70.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/be06762a72ef/vmlinux-c912bf70.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/6c8e58b4215d/Image-c912bf70.gz.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com
>>>
>>> Unable to handle kernel paging request at virtual address dfff800000000257
>>> KASAN: probably user-memory-access in range [0x00000000000012b8-0x00000000000012bf]
>  >> ...
>>> Call trace:
>>>  net_generic+0xd0/0x250 include/net/netns/generic.h:46
>>>  l2tp_pernet net/l2tp/l2tp_core.c:125 [inline]
>>>  l2tp_tunnel_get+0x90/0x464 net/l2tp/l2tp_core.c:207
>>>  l2tp_udp_recv_core net/l2tp/l2tp_core.c:852 [inline]
>>>  l2tp_udp_encap_recv+0x314/0xb3c net/l2tp/l2tp_core.c:933
>>>  udpv6_queue_rcv_one_skb+0x1870/0x1ad4 net/ipv6/udp.c:727
>>>  udpv6_queue_rcv_skb+0x3bc/0x574 net/ipv6/udp.c:789
>>>  udp6_unicast_rcv_skb+0x1cc/0x320 net/ipv6/udp.c:929
>>>  __udp6_lib_rcv+0xbcc/0x1330 net/ipv6/udp.c:1018
>>>  udpv6_rcv+0x88/0x9c net/ipv6/udp.c:1133
>>>  ip6_protocol_deliver_rcu+0x988/0x12a4 net/ipv6/ip6_input.c:438
>>>  ip6_input_finish+0x164/0x298 net/ipv6/ip6_input.c:483
>>> ...
>
> This crash is the result of a call to net_generic() being unable to 
> dereference net when handling a received l2tpv2 packet.
>
> The stack frame indicates that l2tp_udp_recv_core finds that the 
> packet's tunnel_id does not match the tunnel pointer derived from 
> sk_user_data of the receiving socket. This can happen when more than one 
> socket shares the same 5-tuple address. When a tunnel ID mismatch is 
> detected, l2tp looks up the tunnel using the ID from the packet. It is 
> this lookup which segfaults in net_generic() when l2tp tries to access 
> its per-net tunnel list.
>
> The code implicated by the crash, which added support for aliased 
> sockets, is no longer in linux-net or net-next. l2tp no longer looks up 
> tunnels in the datapath; instead it looks up sessions without finding 
> the parent tunnel first. The commits are:
>
>   * support for aliased sockets was added in 628bc3e5a1be ("l2tp: 
> Support several sockets with same IP/port quadruple") May 2024.
>
>   * l2tp's receive path was refactored in ff6a2ac23cb0 ("l2tp: refactor 
> udp recv to lookup to not use sk_user_data") June 2024.
>
> Is 628bc3e5a1be in any LTS or stable kernel? I didn't find it in 
> linux-stable.git
>
> A possible fix is attached.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 

This crash does not have a reproducer. I cannot test it.

> for-kernelci


Return-Path: <netdev+bounces-96631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46988C6BED
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDD28238D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA1158DB2;
	Wed, 15 May 2024 18:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865B1F60A;
	Wed, 15 May 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796771; cv=none; b=mTcZfykYlnUtoARurnaryRXeUz1aZhARvMZSSAK3tYrV+rbQX689zyxPPjnKoyBv220BC1XRhMV/Yr/GvFELSWzPipXe2Pd/DLnM3Gj9Pj29HwRB3FODP/NaRdh5l8B0lKDgLJKwb9Mdi/HyeE49mY7hEyerHiGrnFwS/hhHNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796771; c=relaxed/simple;
	bh=FX5qsQ+pm60AI+ZzsUnsZYsiP1JbmtAjEvy6JnirhdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC/83AlnmmTKqE2dh24lPpqS2aa2sea/Dm3hNl/C4Sfgw6v1xyt+6smZa/AFvUnLbZ2Q3jQxIQRBgGxaJo2SYIErm0Litcs7fWpsApoysMe48Uh5XNXIqMfjs5mVdL08wwZr890g6ZmyapxNTKosWRdX06DDWOjIhC3VmYFGu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 15 May
 2024 21:12:44 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 15 May
 2024 21:12:43 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: syzbot <syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<syzkaller-bugs@googlegroups.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find (2)
Date: Wed, 15 May 2024 11:12:39 -0700
Message-ID: <20240515181239.4127-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <00000000000082378906092f51aa@google.com>
References:
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3669558bdf35 Merge tag 'for-6.6-rc1-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16656930680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=754d6383bae8bc99
> dashboard link: https://syzkaller.appspot.com/bug?extid=23bbb17a7878e2b3d1d4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f2e55d5455c8/disk-3669558b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5a0b7323ae76/vmlinux-3669558b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3430d935a839/bzImage-3669558b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+23bbb17a7878e2b3d1d4@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
>  xfrm_state_find+0x17bc/0x8ce0 net/xfrm/xfrm_state.c:1160
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2469 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
>  xfrm_resolve_and_create_bundle+0x80c/0x4e30 net/xfrm/xfrm_policy.c:2807
>  xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141
>  xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
>  xfrm_lookup_route+0x63/0x2b0 net/xfrm/xfrm_policy.c:3281
>  ip6_dst_lookup_flow net/ipv6/ip6_output.c:1246 [inline]
>  ip6_sk_dst_lookup_flow+0x1044/0x1260 net/ipv6/ip6_output.c:1278
>  udpv6_sendmsg+0x3448/0x4000 net/ipv6/udp.c:1552
>  inet6_sendmsg+0x105/0x190 net/ipv6/af_inet6.c:655
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>  __sys_sendmmsg+0x3c4/0x950 net/socket.c:2681
>  __do_sys_sendmmsg net/socket.c:2710 [inline]
>  __se_sys_sendmmsg net/socket.c:2707 [inline]
>  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2707
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Local variable tmp.i.i created at:
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2447 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2514 [inline]
>  xfrm_resolve_and_create_bundle+0x370/0x4e30 net/xfrm/xfrm_policy.c:2807
>  xfrm_lookup_with_ifid+0x3f7/0x3590 net/xfrm/xfrm_policy.c:3141
> 
> CPU: 0 PID: 26289 Comm: syz-executor.3 Not tainted 6.6.0-rc1-syzkaller-00033-g3669558bdf35 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
> =====================================================

Hi,

I've got a theory about the way this issue is triggered and I could
use some guidance  on whether I am correct (and how to fix it).

Basically, in this case the way saddr is initialized and the way
saddr's hash is calculated are not synced (different fields of
struct xfrm_address_t are used).

xfrm_tmpl_resolve_one
	...
	// initialize saddr
	xfrm_get_saddr
		xfrm6_get_saddr
			ipv6_dev_get_saddr(..., &saddr->in6); // !!!
	...
	xfrm_state_find
		// get hash
		xfrm_dst_hash
			...
			__xfrm6_daddr_saddr_hash
				__xfrm6_addr_hash
					jhash2((__force u32 *)addr->a6, 4, 0); // !!!

I am still working out the best way to come up with a quick fix for
this problem. If, in fact, I am not wrong about it.

Regards,
Nikita


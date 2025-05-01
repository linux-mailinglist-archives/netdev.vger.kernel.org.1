Return-Path: <netdev+bounces-187342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A38AA6785
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC86A3B1BEF
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B1266B7E;
	Thu,  1 May 2025 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JQfzeLGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5D21B90B;
	Thu,  1 May 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143021; cv=none; b=WWcj4X0AwpX5QMeHL8bPAYch1fP1KuDoDoh9njN6p/v9n5oHPSA15sJI6IY4EqqBbdvq0zWUSQeXEVhUe3v4/5b47mFF5WSTCnchd4sIVDFixjrYyTmMS4syHG6I42vCOCJrKsgQRTkU2F6J2jQ455o4dwgWHgQyNlfkTlINRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143021; c=relaxed/simple;
	bh=nLAsd5GSdVN9zKoXT91AxBNtMuRg3WxVOfOoRjJiQck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKgDXHW/JR6YkFdB0Y1PZPfJRdZw8N3jhP43YhdvjaJen8AZQyuEszplEw6GVQA5FU79Js45fF12gJuCH3qVLrU6XReAEK5WoVmgF4I6Xff2ZtUBA4OwFZr//6uaRB5Ktb/pr0oWZ4zYhzge/6Q9W4Dm/8DTKtpm6fkNfNXx4dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JQfzeLGL; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746143020; x=1777679020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVVIXsRBiNGC5/+e/CeOhQZlrKYSsltgQ/G0Xe1FZXM=;
  b=JQfzeLGLd41mzembaG/et4fSmSo0uZagLxJqC0KKC5UcTIEu0VxNb2Vy
   PM+oUFLET7J2ADkFodJaJ3x5j7cqmIkMRQqnEPhcQZQp0RXtiNTFljEsv
   Ac4iGn+1CmZcUI4FNvVE+Wqnn3wShRydGMVCtvPLsMhUcXmkIjU2I36d+
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,254,1739836800"; 
   d="scan'208";a="488237012"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 23:43:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:6136]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.105:2525] with esmtp (Farcaster)
 id e8b08c5e-f1bd-46be-a9b2-4ca9a932d8b8; Thu, 1 May 2025 23:43:33 +0000 (UTC)
X-Farcaster-Flow-ID: e8b08c5e-f1bd-46be-a9b2-4ca9a932d8b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 23:43:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 23:43:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+9596c1b9df18e0ae7261@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] WARNING in ipv6_addr_prefix
Date: Thu, 1 May 2025 16:43:13 -0700
Message-ID: <20250501234322.55091-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <681357d6.050a0220.14dd7d.000b.GAE@google.com>
References: <681357d6.050a0220.14dd7d.000b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+9596c1b9df18e0ae7261@syzkaller.appspotmail.com>
Date: Thu, 01 May 2025 04:15:34 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5565acd1e6c4 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1178cecc580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2e3745cb659ef5d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=9596c1b9df18e0ae7261
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122efd9b980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e99574580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/80798769614c/disk-5565acd1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/435ecb0f1371/vmlinux-5565acd1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7790d5f923b6/bzImage-5565acd1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9596c1b9df18e0ae7261@syzkaller.appspotmail.com
> 
> UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
> ------------[ cut here ]------------
> memcpy: detected field-spanning write (size 898) of single field "pfx->in6_u.u6_addr8" at ./include/net/ipv6.h:614 (size 16)
> WARNING: CPU: 0 PID: 5838 at ./include/net/ipv6.h:614 ipv6_addr_prefix+0x124/0x1d0 include/net/ipv6.h:614
> Modules linked in:
> CPU: 0 UID: 0 PID: 5838 Comm: syz-executor414 Not tainted 6.15.0-rc3-syzkaller-00557-g5565acd1e6c4 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:ipv6_addr_prefix+0x124/0x1d0 include/net/ipv6.h:614
> Code: cc e8 70 eb af f7 c6 05 b8 a8 59 05 01 90 b9 10 00 00 00 48 c7 c7 a0 86 7d 8c 4c 89 fe 48 c7 c2 c0 8d 7d 8c e8 4d 4a 74 f7 90 <0f> 0b 90 90 e9 33 ff ff ff e8 3e eb af f7 44 89 e6 48 c7 c7 c0 53
> RSP: 0018:ffffc90003eb7920 EFLAGS: 00010246
> RAX: 8f8f704687b6a900 RBX: ffff8880337f5c50 RCX: ffff88803326da00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 0000000000000000 R08: ffffc90003eb7607 R09: 1ffff920007d6ec0
> R10: dffffc0000000000 R11: fffff520007d6ec1 R12: 0000000000000382
> R13: 1ffff920007d6f4e R14: ffffc90003eb7a84 R15: 0000000000000382
> FS:  0000555594768380(0000) GS:ffff8881260b2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d1681c9000 CR3: 0000000078e3e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip6_route_info_create+0x5cc/0xa70 net/ipv6/route.c:3810
>  ip6_route_add+0x29/0x2f0 net/ipv6/route.c:3902
>  ipv6_route_ioctl+0x35c/0x480 net/ipv6/route.c:4539
>  inet6_ioctl+0x219/0x280 net/ipv6/af_inet6.c:577

This will fix it.
https://lore.kernel.org/netdev/20250501005335.53683-1-kuniyu@amazon.com/

so speculatively:

#syz fix: ipv6: Restore fib6_config validation for SIOCADDRT.


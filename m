Return-Path: <netdev+bounces-149189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD69E4B84
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18492281154
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BE217543;
	Thu,  5 Dec 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bnPhdGy0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9114286
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 00:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359816; cv=none; b=seMPyIMxuDI9POzz9BfD+ecfCtOc5cAQ8XwqGhw6JqPzHA7ETOhHfZi/MT1BFhH2+pzG2E0A9uFoSlTQYWwcHr1fQPCRWnfBBOThDfGWPw/ZqgMGX8oyG3KXrRUE/eaqE3I3vmBqp+WSH47FTmVj0slDjpRlHOAZwHm1BaTEBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359816; c=relaxed/simple;
	bh=t2QyKR+pVHF8+MU8XL2sP9UGIxEza+UXGhPOIPtz/Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1ODPokiksBm7U7HdBzY8ZXmjEKQjJm87B7JyJDiCzvsuFm1Ap0UI2JnJSzyOYJpvnoBPAe0TNZ91dctMJNg84swH4FBnpjPlIisFECBzELxUagV+MfYWmBHobXPgYjJzmUmD31y0arj2goAIxDKFMEqPgfz4IJCx9yR3uJY/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bnPhdGy0; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733359814; x=1764895814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Ob04Bz/iSUGb2V0Fk+6eZUOR+CMnQcHYptW8yuck+I=;
  b=bnPhdGy0kBPM2zBm8P2Wp5yz9+T5vcjcy7XZ9LRfb10FopcEwxq5qTs/
   3pyB/ZlfDuUT4+S9/xg3HBUN3fqDOaRepOK1pAkLy0X9yKaUiDhQGKXaS
   EuPTtYI1vuKot+P5OnVrLnilpqOrGMKA63LiYpyfp7oyVlAUHcZMofpxs
   I=;
X-IronPort-AV: E=Sophos;i="6.12,209,1728950400"; 
   d="scan'208";a="700506145"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:49:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:3297]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525] with esmtp (Farcaster)
 id 7a331328-60c0-4b97-b9cc-61eb12ff3e41; Thu, 5 Dec 2024 00:49:50 +0000 (UTC)
X-Farcaster-Flow-ID: 7a331328-60c0-4b97-b9cc-61eb12ff3e41
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Dec 2024 00:49:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.3.161) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Dec 2024 00:49:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] tipc: fix NULL deref in cleanup_bearer()
Date: Thu, 5 Dec 2024 09:49:41 +0900
Message-ID: <20241205004941.92382-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204170548.4152658-1-edumazet@google.com>
References: <20241204170548.4152658-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  4 Dec 2024 17:05:48 +0000
> syzbot found [1] that after blamed commit, ub->ubsock->sk
> was NULL when attempting the atomic_dec() :
> 
> atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> 
> Fix this by caching the tipc_net pointer.
> 
> [1]
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 UID: 0 PID: 5896 Comm: kworker/0:3 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events cleanup_bearer
>  RIP: 0010:read_pnet include/net/net_namespace.h:387 [inline]
>  RIP: 0010:sock_net include/net/sock.h:655 [inline]
>  RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
> Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 3c f7 99 f6 48 8b 1b 48 83 c3 30 e8 f0 e4 60 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 1a f7 99 f6 49 83 c7 e8 48 8b 1b
> RSP: 0018:ffffc9000410fb70 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88802fe45a00
> RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000410f900
> RBP: ffff88807e1f0908 R08: ffffc9000410f907 R09: 1ffff92000821f20
> R10: dffffc0000000000 R11: fffff52000821f21 R12: ffff888031d19980
> R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88807e1f0918
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556ca050b000 CR3: 0000000031c0c000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fixes: 6a2fa13312e5 ("tipc: Fix use-after-free of kernel socket in cleanup_bearer().")
> Reported-by: syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67508b5f.050a0220.17bd51.0070.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


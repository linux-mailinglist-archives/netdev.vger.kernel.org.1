Return-Path: <netdev+bounces-112689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984D93A96C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D26283C44
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079EA143C77;
	Tue, 23 Jul 2024 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k7keo26u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32D1422AB
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774575; cv=none; b=pSz7c9VtbQj/Bht62fcdIaPLWalpzXl06YsZ0uq+A/1Td89s/RkYsCP1nGxm7hVW7wWptYdcBVHhfxZqCL5djJVRy4Mypx0ujfoDhsOkNW+LgA9zfFGT09SPDU80ljx/Of1a2xQcL+MQKL3OmRTqRRgxL7kNP9J9rsAGamkj1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774575; c=relaxed/simple;
	bh=rPDMSV4TaHfvcLHnkZDzDcceXeH/zm+J+EMQcNT/0o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLpTbW1zov8Lts6gaoajLK8dNwaQbI3D24KGifl/KvPmu19BW3FrIHdBZLXmsERYUiaWhT4/beY6Tqs6azu8loE988BofcQ0HqPammuxyUxXbpMUnED8UuZBixbj/6gBKB4jZxBJxWh3Etl4vFc2pBqdOaV2TQ+HdKWbZELyaTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k7keo26u; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1721774574; x=1753310574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NiLUZ4w5yHAUnV50wNGvQrLoz6YN+uQCd7L+69WP3Ao=;
  b=k7keo26u0mR34QJeIfdzsGBIP2f5ycPHkIwzAbFFxK4K1yPTXLmGB+I5
   WUVL5ED+kTsIs1ufxPMDq0nYOsOWTzQOcWWkqEHVTUnwn3N+eTWzaP8Be
   pmqyfAD9Dn4tq6AEuhnLV8sjX2lUja2wZxYAHGMMQXPHxMV66taOjGRES
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,231,1716249600"; 
   d="scan'208";a="108928269"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 22:42:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:37068]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.254:2525] with esmtp (Farcaster)
 id 0df52a1b-c83d-495b-a38f-cbf6d95e0a05; Tue, 23 Jul 2024 22:42:44 +0000 (UTC)
X-Farcaster-Flow-ID: 0df52a1b-c83d-495b-a38f-cbf6d95e0a05
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 22:42:38 +0000
Received: from 88665a182662.ant.amazon.com (10.88.135.114) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 23 Jul 2024 22:42:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>,
	<dust.li@linux.alibaba.com>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <schnelle@linux.ibm.com>,
	<syzkaller@googlegroups.com>, <wenjia@linux.ibm.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
Date: Tue, 23 Jul 2024 15:42:27 -0700
Message-ID: <20240723224227.68575-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240723175809.537291-1-edumazet@google.com>
References: <20240723175809.537291-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 17:58:09 +0000
> Following syzbot repro crashes the kernel:
> 
> socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
> 
> Fix this by not calling sk_common_release() from smc_create_clcsk().
> 
> Stack trace:
> socket: no more sockets
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
>  WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted 6.10.0-syzkaller-04483-g0be9ae5486cd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
>  RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
> RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
> RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
> R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
> R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
> FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  inet_create+0xbaf/0xe70
>   __sock_create+0x490/0x920 net/socket.c:1571
>   sock_create net/socket.c:1622 [inline]
>   __sys_socketpair+0x2ca/0x720 net/socket.c:1769
>   __do_sys_socketpair net/socket.c:1822 [inline]
>   __se_sys_socketpair net/socket.c:1819 [inline]
>   __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbcb9259669
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
> RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
> RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
> R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: D. Wythe <alibuda@linux.alibaba.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Dust Li <dust.li@linux.alibaba.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  net/smc/af_smc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 73a875573e7ad5b7a95f7941e33f0d784a91d16d..31b5d8c8c34085b73b011c913cfe032f025cd2e0 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3319,10 +3319,8 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>  
>  	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>  			      &smc->clcsock);
> -	if (rc) {
> -		sk_common_release(sk);

Do we need to move this to __smc_create() ?


> +	if (rc)
>  		return rc;
> -	}
>  
>  	/* smc_clcsock_release() does not wait smc->clcsock->sk's
>  	 * destruction;  its sk_state might not be TCP_CLOSE after
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 


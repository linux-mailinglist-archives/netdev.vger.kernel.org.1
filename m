Return-Path: <netdev+bounces-142566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06949BFA1D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C7C1F228E2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72511DE4D3;
	Wed,  6 Nov 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tr2WeeCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9D1CDA36
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935900; cv=none; b=U9ud3lu74BBl6iD42rvtiRgxhofu/HZVKGxr5VlB3WR++pIShP+lLCZEPiuse/pBbgJUj91qBq/atdTy1LO8TBsOxcx3SvgzTHrKsiaptbYjc2f+TetNIfIbhM6ewhwuHPBVWlj2h65Nb43C7za9lopZ+IMy7mpe+62f/GAStyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935900; c=relaxed/simple;
	bh=mWpGlC8TT6iWzmjsw47bBeNFYVFDhrJZPLzBX1vQ7AI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5qozToz8olpOTclIqSqvz3p2JMJSjto5ohLfFu/njejPhFz7cHZjoeOr3e0S5BpLogncKu+LXioC+XRRls6kxHfvjQD0GxR86icQS1MZdfNPcAkayT0782k/vWq9QvTW8SpdVhFDXMZaAJXDEsdb16U2odRB5veV5hl40pRF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tr2WeeCm; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730935900; x=1762471900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kKZNDXo2qZJhLwGxCaLoNmADWHhHDnpG9mYI9Q1qvmo=;
  b=Tr2WeeCmoLc/PQ9+IqzoMckmvp5xsElr7AyAAs92y6hUhLcCfzNixujj
   ArHJAJDtYMJrFsPHHhUNpfCL0rvWu3ktPGpEVm/N0D6V2MtlXT2/iLXrW
   cN9XZGUx+yiTmSEucRJk2v0mhBgCnKKgWxFqZXBUr9E2wYfHIQAnAxK6r
   o=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="383029804"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:31:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:36464]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.168:2525] with esmtp (Farcaster)
 id 86745bf4-ced1-4688-a110-4a0a2aead905; Wed, 6 Nov 2024 23:31:31 +0000 (UTC)
X-Farcaster-Flow-ID: 86745bf4-ced1-4688-a110-4a0a2aead905
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 23:31:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 23:31:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>,
	<dust.li@linux.alibaba.com>, <eric.dumazet@gmail.com>,
	<ignat@cloudflare.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <wenjia@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: do not leave a dangling sk pointer in __smc_create()
Date: Wed, 6 Nov 2024 15:31:24 -0800
Message-ID: <20241106233124.51142-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106221922.1544045-1-edumazet@google.com>
References: <20241106221922.1544045-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  6 Nov 2024 22:19:22 +0000
> Thanks to commit 4bbd360a5084 ("socket: Print pf->create() when
> it does not clear sock->sk on failure."), syzbot found an issue with AF_SMC:
> 
> smc_create must clear sock->sk on failure, family: 43, type: 1, protocol: 0
>  WARNING: CPU: 0 PID: 5827 at net/socket.c:1565 __sock_create+0x96f/0xa30 net/socket.c:1563
> Modules linked in:
> CPU: 0 UID: 0 PID: 5827 Comm: syz-executor259 Not tainted 6.12.0-rc6-next-20241106-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:__sock_create+0x96f/0xa30 net/socket.c:1563
> Code: 03 00 74 08 4c 89 e7 e8 4f 3b 85 f8 49 8b 34 24 48 c7 c7 40 89 0c 8d 8b 54 24 04 8b 4c 24 0c 44 8b 44 24 08 e8 32 78 db f7 90 <0f> 0b 90 90 e9 d3 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c ee f7
> RSP: 0018:ffffc90003e4fda0 EFLAGS: 00010246
> RAX: 099c6f938c7f4700 RBX: 1ffffffff1a595fd RCX: ffff888034823c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000ffffffe9 R08: ffffffff81567052 R09: 1ffff920007c9f50
> R10: dffffc0000000000 R11: fffff520007c9f51 R12: ffffffff8d2cafe8
> R13: 1ffffffff1a595fe R14: ffffffff9a789c40 R15: ffff8880764298c0
> FS:  000055557b518380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa62ff43225 CR3: 0000000031628000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   sock_create net/socket.c:1616 [inline]
>   __sys_socket_create net/socket.c:1653 [inline]
>   __sys_socket+0x150/0x3c0 net/socket.c:1700
>   __do_sys_socket net/socket.c:1714 [inline]
>   __se_sys_socket net/socket.c:1712 [inline]
> 
> For reference, see commit 2d859aff775d ("Merge branch
> 'do-not-leave-dangling-sk-pointers-in-pf-create-functions'")
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


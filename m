Return-Path: <netdev+bounces-138003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C69AB70C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCAAB2180D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D239C1CB503;
	Tue, 22 Oct 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jALndKjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302131C9EC7
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625999; cv=none; b=VgmC46bjWD4wqPIdyAJhCu3c3QPbiwl2SUbfHW8SzkfAxq1MU7QqzcdHjkiBrcljusy57UUTf93fMbe/ob5Ovpkgmar50AlrzBXAMdvt5OxY8SfrRcrJ2+BcJfHBNpJzo6gOWFkeCLZdN79ObeavtE0n+oKv+JGIaD4cSs6hKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625999; c=relaxed/simple;
	bh=VLpqxjcSFPsEWeWcI21yYkpbIRnOlXEPXgKXrs5URKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlFkf8yw9ySp4Jeo0PUhVZrYAokzejaQGIaBiPymCI61osBN4r6yOBI3EBTjpZOwNS8/hzJ6NP40YL/jHn+mK6OG9d7uKoNR+Epj8EiI7lAWLtu1xPz/f5H6iyQwELIlZawlDPSWFaOpw1++ShnDvVescwDIGzfqbMsjdoddc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jALndKjl; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729625999; x=1761161999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPnQaLMpRF9XStvqfpWCWCMSzkr69lWndF4fwhE9hds=;
  b=jALndKjlKiGw6HM8x6vXTlSr+KpXXqkgwE34HD3z39mRxIqbKYM4+Ppw
   gN+0SWKrMDScq3APKXPtbrciRkjbimsRokv7XBDGjVbu9kh+IkxH+zC9O
   6fWWljWKBVszT6/fxsmEaonXsrtNXxKCem+yOb4btpdnxFOVrcw9nYO0X
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="463663228"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:46551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.58:2525] with esmtp (Farcaster)
 id 99c5dfce-5dbb-43a6-92a8-0cfb8d2101e5; Tue, 22 Oct 2024 19:39:52 +0000 (UTC)
X-Farcaster-Flow-ID: 99c5dfce-5dbb-43a6-92a8-0cfb8d2101e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 19:39:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 22 Oct 2024 19:39:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <ignat@cloudflare.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH net-next] vsock: do not leave dangling sk pointer in vsock_create()
Date: Tue, 22 Oct 2024 12:39:44 -0700
Message-ID: <20241022193944.69966-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241022134819.1085254-1-edumazet@google.com>
References: <20241022134819.1085254-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 13:48:19 +0000
> syzbot was able to trigger the following warning after recent
> core network cleanup.
> 
> On error vsock_create() frees the allocated sk object, but sock_init_data()
> has already attached it to the provided sock object.
> 
> We must clear sock->sk to avoid possible use-after-free later.
> 
> WARNING: CPU: 0 PID: 5282 at net/socket.c:1581 __sock_create+0x897/0x950 net/socket.c:1581
> Modules linked in:
> CPU: 0 UID: 0 PID: 5282 Comm: syz.2.43 Not tainted 6.12.0-rc2-syzkaller-00667-g53bac8330865 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:__sock_create+0x897/0x950 net/socket.c:1581
> Code: 7f 06 01 65 48 8b 34 25 00 d8 03 00 48 81 c6 b0 08 00 00 48 c7 c7 60 0b 0d 8d e8 d4 9a 3c 02 e9 11 f8 ff ff e8 0a ab 0d f8 90 <0f> 0b 90 e9 82 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c c7 f8 ff
> RSP: 0018:ffffc9000394fda8 EFLAGS: 00010293
> RAX: ffffffff89873c46 RBX: ffff888079f3c818 RCX: ffff8880314b9e00
> RDX: 0000000000000000 RSI: 00000000ffffffed RDI: 0000000000000000
> RBP: ffffffff8d3337f0 R08: ffffffff8987384e R09: ffffffff8989473a
> R10: dffffc0000000000 R11: fffffbfff203a276 R12: 00000000ffffffed
> R13: ffff888079f3c8c0 R14: ffffffff898736e7 R15: dffffc0000000000
> FS:  00005555680ab500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f22b11196d0 CR3: 00000000308c0000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   sock_create net/socket.c:1632 [inline]
>   __sys_socket_create net/socket.c:1669 [inline]
>   __sys_socket+0x150/0x3c0 net/socket.c:1716
>   __do_sys_socket net/socket.c:1730 [inline]
>   __se_sys_socket net/socket.c:1728 [inline]
>   __x64_sys_socket+0x7a/0x90 net/socket.c:1728
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f22b117dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff56aec0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
> RAX: ffffffffffffffda RBX: 00007f22b1335f80 RCX: 00007f22b117dff9
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000028
> RBP: 00007f22b11f0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f22b1335f80 R14: 00007f22b1335f80 R15: 00000000000012dd
> 
> Fixes: 48156296a08c ("net: warn, if pf->create does not clear sock->sk on error")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Ignat Korchagin <ignat@cloudflare.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/vmw_vsock/af_vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 35681adedd9aaec3565495158f5342b8aa76c9bc..109b7a0bd0714c9a2d5c9dd58421e7e9344a8474 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2417,6 +2417,7 @@ static int vsock_create(struct net *net, struct socket *sock,
>  	if (sock->type == SOCK_DGRAM) {
>  		ret = vsock_assign_transport(vsk, NULL);
>  		if (ret < 0) {
> +			sock->sk = NULL;
>  			sock_put(sk);
>  			return ret;
>  		}
> -- 
> 2.47.0.105.g07ac214952-goog


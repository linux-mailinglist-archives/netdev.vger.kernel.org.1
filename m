Return-Path: <netdev+bounces-95306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7298C1D7F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4D11F23207
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F614A08E;
	Fri, 10 May 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WXcxe161"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287E12DD88;
	Fri, 10 May 2024 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715316609; cv=none; b=N4A/yqqv2uMN6CSMLMOYDJqZvrvwjB3BEalCNHQ8nDpvnYQiqAsOdG8xXTYUXl3UGtfI/pnAYwStEXTvMHOUaIoDZ6c566t4wjU5mNJHUEdZiztqt8/1GN4otGNeFe3BonQm2WGg+kuGbYtW1/ThrrNPvel7QxsilY2L5ownPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715316609; c=relaxed/simple;
	bh=Ojbxz06eYniGbmSWyknhMjXnkbDq+DPs55HNM0uCzNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBtTwrNuQ3BUulzk3lz7HdGs/hqCmvwve731ch91oFKgVDOYhZWDwSIvCcEmCk85uwGPcm1IXIM/tyCMtKz9wiHf+4svpFGGcMi/dfjRtFyOh8xy0NN6enqnuP2LiK5Et66Z6rTvnC9S2H0L1hlBaj27F90P0lZHvHm40h1j7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WXcxe161; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715316608; x=1746852608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bl0Zifhqq7E3SoEKYbnz8ntYa90jVZRoq1CV9kYkGQ=;
  b=WXcxe1613DL0S0dOLHM0bGjFyXt73PzCBvTso9U9+QSEJT8F+LJ21UmL
   MEHiYv4FsugpiBnpasaQ+XVYSEjNKmYeaZFHGKBT74tDSzNDvBnujRkml
   dr2Lw4gS1s5DglYH86aVSna5bSOJL7juzkhGSWdZ+hYT3UiHGW3H20Vd5
   g=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="657824590"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 04:50:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:1742]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.40:2525] with esmtp (Farcaster)
 id 2c3c20f3-af69-4b47-b2fb-8052ca477e74; Fri, 10 May 2024 04:50:04 +0000 (UTC)
X-Farcaster-Flow-ID: 2c3c20f3-af69-4b47-b2fb-8052ca477e74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 04:50:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.0.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 04:49:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <alexander@mihalicyn.com>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <dhowells@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <paulmck@kernel.org>
Subject: Re: [PATCH net v2] af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg
Date: Fri, 10 May 2024 13:49:48 +0900
Message-ID: <20240510044948.26074-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240509081459.2807828-1-leitao@debian.org>
References: <20240509081459.2807828-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu,  9 May 2024 01:14:46 -0700
> A data-race condition has been identified in af_unix. In one data path,
> the write function unix_release_sock() atomically writes to
> sk->sk_shutdown using WRITE_ONCE. However, on the reader side,
> unix_stream_sendmsg() does not read it atomically. Consequently, this
> issue is causing the following KCSAN splat to occur:
> 
> 	BUG: KCSAN: data-race in unix_release_sock / unix_stream_sendmsg
> 
> 	write (marked) to 0xffff88867256ddbb of 1 bytes by task 7270 on cpu 28:
> 	unix_release_sock (net/unix/af_unix.c:640)
> 	unix_release (net/unix/af_unix.c:1050)
> 	sock_close (net/socket.c:659 net/socket.c:1421)
> 	__fput (fs/file_table.c:422)
> 	__fput_sync (fs/file_table.c:508)
> 	__se_sys_close (fs/open.c:1559 fs/open.c:1541)
> 	__x64_sys_close (fs/open.c:1541)
> 	x64_sys_call (arch/x86/entry/syscall_64.c:33)
> 	do_syscall_64 (arch/x86/entry/common.c:?)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> 	read to 0xffff88867256ddbb of 1 bytes by task 989 on cpu 14:
> 	unix_stream_sendmsg (net/unix/af_unix.c:2273)
> 	__sock_sendmsg (net/socket.c:730 net/socket.c:745)
> 	____sys_sendmsg (net/socket.c:2584)
> 	__sys_sendmmsg (net/socket.c:2638 net/socket.c:2724)
> 	__x64_sys_sendmmsg (net/socket.c:2753 net/socket.c:2750 net/socket.c:2750)
> 	x64_sys_call (arch/x86/entry/syscall_64.c:33)
> 	do_syscall_64 (arch/x86/entry/common.c:?)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> 	value changed: 0x01 -> 0x03
> 
> The line numbers are related to commit dd5a440a31fa ("Linux 6.9-rc7").
> 
> Commit e1d09c2c2f57 ("af_unix: Fix data races around sk->sk_shutdown.")
> addressed a comparable issue in the past regarding sk->sk_shutdown.
> However, it overlooked resolving this particular data path.
> This patch only offending unix_stream_sendmsg() function, since the
> other reads seem to be protected by unix_state_lock() as discussed in
> Link: https://lore.kernel.org/all/20240508173324.53565-1-kuniyu@amazon.com/
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

> ---
> Changelog:
> 
> v2:
> 	* Only fix the usecase reported by KCSAN
> 	* Targeting net instead of net-next
> ---
>  net/unix/af_unix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index dc1651541723..fa906ec5e657 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2224,7 +2224,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  			goto out_err;
>  	}
>  
> -	if (sk->sk_shutdown & SEND_SHUTDOWN)
> +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
>  		goto pipe_err;
>  
>  	while (sent < len) {
> -- 
> 2.43.0
> 


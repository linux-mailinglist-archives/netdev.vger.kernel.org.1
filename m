Return-Path: <netdev+bounces-94682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251698C032E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4F2281539
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B018828;
	Wed,  8 May 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DHYz8t0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DF128806;
	Wed,  8 May 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189632; cv=none; b=uWRWcd9w7RtevP2YKl6xM82YlblRYlcqIIP+MKsdGmoWsQlBNJWFgjuAiF4unREqXGF8gnwRcBurE1FNOERUv4rTuUtOD4qLsWVPw+A5YMUu/2Vw3JkzF2HM0tgLJZ7wNKjnVdIvg8SfTQvaICVhl5Xurfi9SaH2RGmnyc300fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189632; c=relaxed/simple;
	bh=2GilhqZtlLPttb85A1d2PddeB4aUhLzNUbRfDd0NgAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIwigWBcjFLPFBUgdGjbUbTUXOoEQNmQ1WuvfgmQ2Vl4azVNY5LBixWBBj4whuSOQMsDH/WXW+JVvaDZPTWhdiDAKKoWVC2lFyvEA20nndiAvF6zTWphY3GjL2G/hD/h1+q2dKXgznVqUKs2BfrLydh7eOcVLIFizYUdOZVR1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DHYz8t0F; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715189630; x=1746725630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUo3ItEPwAK/Mo/YaF/CWRNiPFBINW7V9XBUrDV/B38=;
  b=DHYz8t0Fbcs9EcK3zvQyJFvxPYUEKMdU2ymyNSl31gLvPzuRwy+rc2MG
   QP9sVp37HVHQ2JaqtmpDfzc/MnJELeWGYPxa0yDIbpACzUO56DY0fFnw8
   RYxzuY9ejBazQ6r8iuvMWlPQvUBoaOs8V3gtvyvniFow75E9GFvcq9m5k
   A=;
X-IronPort-AV: E=Sophos;i="6.08,145,1712620800"; 
   d="scan'208";a="417790249"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:33:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:43343]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.157:2525] with esmtp (Farcaster)
 id 674f1dbd-fb22-4915-83d4-0b59d1ce8133; Wed, 8 May 2024 17:33:44 +0000 (UTC)
X-Farcaster-Flow-ID: 674f1dbd-fb22-4915-83d4-0b59d1ce8133
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:33:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.140.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:33:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <alexander@mihalicyn.com>, <daan.j.demeyer@gmail.com>,
	<davem@davemloft.net>, <dhowells@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <paulmck@kernel.org>
Subject: Re: [PATCH net-next] af_unix: Fix data races in unix_release_sock/unix_stream_sendmsg
Date: Wed, 8 May 2024 10:33:24 -0700
Message-ID: <20240508173324.53565-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240508111749.2386649-1-leitao@debian.org>
References: <20240508111749.2386649-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Wed,  8 May 2024 04:17:45 -0700
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
> 
> To prevent potential race conditions in the future, all read accesses to
> sk->sk_shutdown in af_unix need be marked with READ_ONCE().

Let's not add READ_ONCE() if not needed.  Othwewise, someone reading
the code would assess wrongly that the value could be updated locklessly
elsewhere.

You can find all writers of sk->sk_shutdown do that update under
unix_state_lock().


> Although
> there are additional reads in other->sk_shutdown without atomic reads,
> I'm excluding them as I'm uncertain about their potential parallel
> execution.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/unix/af_unix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 9a6ad5974dff..74795e6d13c6 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2270,7 +2270,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  			goto out_err;
>  	}
>  
> -	if (sk->sk_shutdown & SEND_SHUTDOWN)
> +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
>  		goto pipe_err;
>  
>  	while (sent < len) {
> @@ -2446,7 +2446,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>  		unix_state_lock(sk);
>  		/* Signal EOF on disconnected non-blocking SEQPACKET socket. */
>  		if (sk->sk_type == SOCK_SEQPACKET && err == -EAGAIN &&
> -		    (sk->sk_shutdown & RCV_SHUTDOWN))
> +		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN))

Here we locked unix_state_lock() just before accessing sk_shutdown,
so no need for READ_ONCE().


>  			err = 0;
>  		unix_state_unlock(sk);
>  		goto out;
> @@ -2566,7 +2566,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
>  		if (tail != last ||
>  		    (tail && tail->len != last_len) ||
>  		    sk->sk_err ||
> -		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> +		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
>  		    signal_pending(current) ||
>  		    !timeo)
>  			break;

Same here,


> @@ -2764,7 +2764,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  			err = sock_error(sk);
>  			if (err)
>  				goto unlock;
> -			if (sk->sk_shutdown & RCV_SHUTDOWN)
> +			if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN)
>  				goto unlock;
>  
>  			unix_state_unlock(sk);

and here.

Could you update the changelog and repost v2 for unix_stream_sendmsg()
targetting net tree with this Fixes tag ?

  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Thanks!

> -- 
> 2.43.0


Return-Path: <netdev+bounces-64890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C09F8375E6
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5FB1F26EC6
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B4482FB;
	Mon, 22 Jan 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i0vDi4Co"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54F482D6
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961738; cv=none; b=oRErYZKCqKeoKCLLJY2RYr9exIZJVPiEXEXR44qpRxBSn/7PwR6Kxp+ScImVltJ+Ju3G/TS07/+XSEmf9g58t4IPUQQ/WZZSu3oS7YwWDtVpk+Vn2eBsaWaz0YMRfLxivqZERY31IXOW2kLbuJNYQNLyo+mUGGzE23/O/Kjhh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961738; c=relaxed/simple;
	bh=Ec7Y1u2xmhlxw/89pIWwcJaiWAXN15QHRwr6zj9CDFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uP+jTt4LoBy8bph/gWW/RdQfE59D5IBdfvl0Il11EkPawTYzQ7idnrwc0PeHc7dx/prZl0cA1iRNZafjhFU8G+iXb0A6vSkMLmE+2s1irlRHiGKon+WrspvbRNKAdxCNdZTbxK9+iKQjfc9bsFwKMFS0UT14OVL9+/otQ6u9u8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=i0vDi4Co; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705961737; x=1737497737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SCWmzXZHDFtrO7jaXjEt8+o2QpAS4JIe44X0+wrna0=;
  b=i0vDi4CoSDTeBZ/BAQo88WKlsCEwShADvZ153glXn6EjJi42LhVBpMdj
   lB7IQDmrfHM/NXyzTCFYFYOMJQPxp26UhEQ9cjogq7elb97d003EjxEhv
   xhMqV8EJS7syZ2nfswcUnclyDoNfxRy0Pwfm/yuBl8N77cZI8SNfe1LuV
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="60341808"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:15:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id 8F5BC4A630;
	Mon, 22 Jan 2024 22:15:34 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:28658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.5:2525] with esmtp (Farcaster)
 id 967a9fda-a4be-4591-9686-41a3c16c506a; Mon, 22 Jan 2024 22:15:33 +0000 (UTC)
X-Farcaster-Flow-ID: 967a9fda-a4be-4591-9686-41a3c16c506a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:15:33 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:15:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lilinke99@qq.com>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: use READ_ONCE() to read in concurrent environment
Date: Mon, 22 Jan 2024 14:15:21 -0800
Message-ID: <20240122221521.17445-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <tencent_F35C58B90E47D014455212BC7110EDBB2106@qq.com>
References: <tencent_F35C58B90E47D014455212BC7110EDBB2106@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: linke li <lilinke99@qq.com>
Date: Tue, 23 Jan 2024 04:24:46 +0800
> In function sk_stream_wait_memory(), reads of sk->sk_err and sk->sk_shutdown
> is protected using READ_ONCE() in line 145, 146.
> 145: 		ret = sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
> 146: 				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
> 
> But reads in line 133 are not protected. This may cause unexpected error
> when other threads change sk->sk_err and sk->sk_shutdown. Function
> sk_stream_wait_connect() has same problem.
> 
> There is patch similar to this. https://github.com/torvalds/linux/commit/c1c0ce31b2420d5c173228a2132a492ede03d81f
> This patch find two read of same variable while one is protected, another
> is not. And READ_ONCE() is added to protect.

This is not sufficient.
You need to add WRITE_ONCE() on the writer side as well.

Also, you can disambiguate Subject by mentioning sk_state or
sk_stream_wait_connect().

Thanks!


> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>  net/core/stream.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/stream.c b/net/core/stream.c
> index b16dfa568a2d..7e67a2bf4480 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -63,7 +63,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
>  		int err = sock_error(sk);
>  		if (err)
>  			return err;
> -		if ((1 << sk->sk_state) & ~(TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		if ((1 << READ_ONCE(sk->sk_state)) & ~(TCPF_SYN_SENT | TCPF_SYN_RECV))
>  			return -EPIPE;
>  		if (!*timeo_p)
>  			return -EAGAIN;
> @@ -130,7 +130,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
>  	while (1) {
>  		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>  
> -		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
> +		if (READ_ONCE(sk->sk_err) || (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN))
>  			goto do_error;
>  		if (!*timeo_p)
>  			goto do_eagain;
> -- 
> 2.39.3 (Apple Git-145)


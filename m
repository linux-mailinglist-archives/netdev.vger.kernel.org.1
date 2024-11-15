Return-Path: <netdev+bounces-145385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067699CF552
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F29E282626
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF61D9346;
	Fri, 15 Nov 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BLu+NBVx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA81D5173
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731700533; cv=none; b=k/ZDNPWlikAdZV74KgKfMZLagLTbuSPe8piKkQSiy+gBN75o8xeFyd07aSpftUwXQBIo/bcakVUoJV2MDOMYDeoyDyKIill1PV0iQkiLbnjJrxKK4uAALBIAFkvi22TtmZADdkjBACb1GJec/ZcQxAmwqT20fT9aUPLCled06Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731700533; c=relaxed/simple;
	bh=7rTIjQAw46wQVEOMiPfzq3Cu51UbGJFkj702vwPEhDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE9wl2wHmq3dYVAvAioMOmM7BoPzEpNEixc4qdhRX+p0RDgSff1K1iwgZ2b+x+LA9LkZA7iT8ZGpFtgX7nUaggPMrKkHVcSxhu64Mt5XDN11qT3r8l0nZ680MaIjlFu0qynOg/TkYkYWRY2K4/m3Vn0Scx/+oYBcWssiaB3piiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BLu+NBVx; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731700531; x=1763236531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2wWO3HH4+xUmg6o6HK5G8Ozxu1uK5NKTUYqyqiCsN8=;
  b=BLu+NBVxBxXdyZq8J4+DBIMYKztiXs2DWv7Uy+39K6fr51yXDQtkk4DT
   OJ1dLKV8KAIns+soLJKj/9Zz+3opsa8K1bY+3Vz4bQFBRDolwf/wph2uC
   IEckn58DWmMfZG7EATgOpt8f8APVv3RNaenDlGbs4/55FCccmMkv3MzU7
   M=;
X-IronPort-AV: E=Sophos;i="6.12,157,1728950400"; 
   d="scan'208";a="440390537"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 19:55:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:17828]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 2f1a8eec-1d4f-4ac6-80c8-19754b3aa153; Fri, 15 Nov 2024 19:55:27 +0000 (UTC)
X-Farcaster-Flow-ID: 2f1a8eec-1d4f-4ac6-80c8-19754b3aa153
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 15 Nov 2024 19:55:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 15 Nov 2024 19:55:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sbrivio@redhat.com>
CC: <david@gibson.dropbear.id.au>, <edumazet@google.com>,
	<mmanning@vyatta.att-mail.com>, <netdev@vger.kernel.org>,
	<pholzing@redhat.com>, <santiago@redhat.com>,
	<willemdebruijn.kernel@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH RFC net 2/2] datagram, udp: Set local address and rehash socket atomically against lookup
Date: Fri, 15 Nov 2024 11:55:21 -0800
Message-ID: <20241115195521.63675-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114215414.3357873-3-sbrivio@redhat.com>
References: <20241114215414.3357873-3-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stefano Brivio <sbrivio@redhat.com>
Date: Thu, 14 Nov 2024 22:54:14 +0100
> diff --git a/net/core/sock.c b/net/core/sock.c
> index da50df485090..fcd2e2b89876 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -643,8 +643,17 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
>  	/* Paired with all READ_ONCE() done locklessly. */
>  	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
>  
> -	if (sk->sk_prot->rehash)
> -		sk->sk_prot->rehash(sk);
> +	/* Force rehash if protocol needs it */
> +	if (sk->sk_prot->set_rcv_saddr) {
> +		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_family == AF_INET6) {
> +			sk->sk_prot->set_rcv_saddr(sk, &sk->sk_v6_rcv_saddr);

sk_v6_rcv_saddr is not defined without CONFIG_IPV6 so I think the
compiler will complain ?  see net/ipv4/inet_connection_sock.c


> +		} else if (sk->sk_family == AF_INET) {
> +			struct inet_sock *inet = inet_sk(sk);
> +
> +			sk->sk_prot->set_rcv_saddr(sk, &inet->inet_rcv_saddr);

simply use &sk->sk_rcv_saddr.


> +		}
> +	}
> +
>  	sk_dst_reset(sk);
>  
>  	ret = 0;
[...]
> @@ -2034,20 +2052,32 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
>  				nhslot2->count++;
>  				spin_unlock(&nhslot2->lock);
>  			}
> -
> -			spin_unlock_bh(&hslot->lock);
>  		}
>  	}
> +
> +	if (sk->sk_family == AF_INET)
> +		sk->sk_rcv_saddr = *(__be32 *)addr;
> +	else if (sk->sk_family == AF_INET6)
> +		sk->sk_v6_rcv_saddr = *(struct in6_addr *)addr;

inet_update_saddr() can be reused ?  at least we should
use sk_rcv_saddr_set().

Same for other places.


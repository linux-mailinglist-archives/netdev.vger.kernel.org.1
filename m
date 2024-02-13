Return-Path: <netdev+bounces-71480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101498538CD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CF61C26427
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CD57885;
	Tue, 13 Feb 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kaxfCwbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C2A93C
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846061; cv=none; b=ogSxIi5uK2TzZUIqGri7S71NHD9enMB3QdLx0m95jAWP4IOmH1FzYw24xcG98UrLEPv4bc9XWPKbj0zpaQiHnNxzTLTWw1122xQFUQIOkQYd7FKZabPlJWlEt0UZmDSwNKreyyUIYpU8bCLDW7Pz7G/khiPaKKis/XE/rY4lEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846061; c=relaxed/simple;
	bh=bE4DHn9CrhF0GvXHvOQyZdC6nRLXW+bZCyUQ2qy7VJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRBkJlnBEDfQd4TxGvzJMKedEtx0QmbM5kgQA4fb5fLZ/D0lWcOgHxIY7IHwovk5Npp9OcAbVfq4InTcLJ53ZG8EIxKdTx7q4c5Nu2zqMo7mhHP/nNWeOVd4+wAK/vhtOYH1HZavM542TTONL4A6VRLZ4zK1OKMIh3N1xgWpdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kaxfCwbI; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707846057; x=1739382057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPET38PIuqSsM4gploQuTD7Wq3pbC3F0wy7EppYWoMk=;
  b=kaxfCwbI/Wj9yI47Q2KQ1AONqoAxPdBWXURTdv0H2Rdbpr5jMI1BU6Dc
   VkH9fsRmcIgBfndZyH7OBXSRF/iwEhj4J7OY0nuRXO7mB68Od3Zx2GAOT
   XJ0RvifEsFvakVIbiR11i9HR0dEML23umDSKP+QNQPhBfmLZxdRPs2TYb
   k=;
X-IronPort-AV: E=Sophos;i="6.06,157,1705363200"; 
   d="scan'208";a="704035957"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 17:40:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:44012]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id cd39f957-d7f7-4775-86aa-99109c99d973; Tue, 13 Feb 2024 17:40:48 +0000 (UTC)
X-Farcaster-Flow-ID: cd39f957-d7f7-4775-86aa-99109c99d973
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 17:40:43 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 17:40:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: no need to use acceptable for conn_request
Date: Tue, 13 Feb 2024 09:40:29 -0800
Message-ID: <20240213174029.60042-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240213131205.4309-1-kerneljasonxing@gmail.com>
References: <20240213131205.4309-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 21:12:05 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since tcp_conn_request() always returns zero, there is no need to
> keep the dead code. Remove it then.
> 
> Link: https://lore.kernel.org/netdev/CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_input.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2d20edf652e6..b1c4462a0798 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6623,7 +6623,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  	const struct tcphdr *th = tcp_hdr(skb);
>  	struct request_sock *req;
>  	int queued = 0;
> -	bool acceptable;
>  	SKB_DR(reason);
>  
>  	switch (sk->sk_state) {
> @@ -6649,12 +6648,10 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  			 */
>  			rcu_read_lock();
>  			local_bh_disable();
> -			acceptable = icsk->icsk_af_ops->conn_request(sk, skb) >= 0;
> +			icsk->icsk_af_ops->conn_request(sk, skb);
>  			local_bh_enable();
>  			rcu_read_unlock();
>  
> -			if (!acceptable)
> -				return 1;
>  			consume_skb(skb);
>  			return 0;
>  		}
> -- 
> 2.37.3


Return-Path: <netdev+bounces-72812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49D859B56
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FEB20AC2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EA79ED;
	Mon, 19 Feb 2024 04:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="itP15khX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C453C26
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316456; cv=none; b=WIdEUcJCwt83m4+6rmRwllOpvMQBxwC8TDi5DBqtKYtcnZTEnd2b3Wc6Jd0TDA0E/3knqzjOe10z+SeawMgjhlQ5UsTAcqjl4CZwKRb2mhuEvbZCnI/P5qVJLYUcl8jb1G6uKAx/XF8dON7hxffHm/H+3GP2qYiMr7k5Sa4rMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316456; c=relaxed/simple;
	bh=1XpASI/iRXkzNRFgBD7TOM1sXVg7VIN5VyZZygab/FU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmOfKLKoY99LY03FfaaSbXiStxWDwVMxya7nU9fTtX8CUz/OCyck23adlgOp7L/cvxziKWEkBCj4vNPQBWSa6SgkvctK1wdcxAJklzfG7qj7EQ6zH+LtfdnfqvAcxJlQNHIX3MM+e3OZeDaT4Iq4OGPwKJgN6tNNZ9LZbdAQadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=itP15khX; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708316454; x=1739852454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ztj6tfOTFqslpCK7yLRq/k1EACWETaQzH9fVOTu59Y=;
  b=itP15khXw/4eUKeofKmRl9UKaMhQqN9guaYoBDXrSsIKP4GzjgoMAJyv
   65JoKxZfEU3uCnzVCsgJvfosABazimjiRyCfLzV1T0j3pUzw11rzDPYb5
   QrvaBAm5c3+SFRRfNFG34z7RL2T/usxkTFOamYiIaGdrI5YQAt4gseNQC
   c=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="66890611"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:20:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:59800]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.134:2525] with esmtp (Farcaster)
 id 3d4e9979-5791-4d0b-9954-50a66ea8cbac; Mon, 19 Feb 2024 04:20:52 +0000 (UTC)
X-Farcaster-Flow-ID: 3d4e9979-5791-4d0b-9954-50a66ea8cbac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:20:52 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:20:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 02/11] tcp: directly drop skb in cookie check for ipv4
Date: Sun, 18 Feb 2024 20:13:49 -0800
Message-ID: <20240219041350.95304-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219032838.91723-3-kerneljasonxing@gmail.com>
References: <20240219032838.91723-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 11:28:29 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
> no other changes made. It can help us refine the specific drop reasons
> later.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/syncookies.c | 4 ++++
>  net/ipv4/tcp_ipv4.c   | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index be88bf586ff9..38f331da6677 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	struct rtable *rt;
>  	__u8 rcv_wscale;
>  	int full_space;
> +	SKB_DR(reason);
>  
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
>  	    !th->ack || th->rst)
> @@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	 */
>  	if (ret)
>  		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> +	else
> +		goto out_drop;
>  out:
>  	return ret;
>  out_free:
>  	reqsk_free(req);
>  out_drop:
> +	kfree_skb_reason(skb, reason);
>  	return NULL;
>  }
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0c50c5a32b84..0a944e109088 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
>  
>  		if (!nsk)
> -			goto discard;
> +			return 0;
>  		if (nsk != sk) {
>  			if (tcp_child_process(sk, nsk, skb)) {
>  				rsk = nsk;
> -- 
> 2.37.3
> 


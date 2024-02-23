Return-Path: <netdev+bounces-74532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EB6861C69
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99FC2850CF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058713F010;
	Fri, 23 Feb 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y/cejajR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A71F176
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716322; cv=none; b=ogHU+J601WwioS1w6iIlDbfg+N0sh9rgAIbXx7r9KQIYjtuRu7EbdRtyeoQ5rk69EZaONvrVolb+1lM8rhkUbZ3NCM7zVOQkcB5stgk9e/q04uLWrwjDtkwjaBNpRFQAEcWQLDWYv9cD4jwP55VaWW+g1ZO4cCPsiOGjV4HnYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716322; c=relaxed/simple;
	bh=gBuuwg0oY1K68oYmxW+Iz8M/TKADZKTcsPiKQtd5GcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DztJFmo0yE2yJ8F03gdY08sH5YvYk2XtsQEX9KYBPDtsiDlpzhDN0twgw5pm6YmNpgZmhLuEEt6Ckg9f7r16dxXQNzgY2toqi7xM4eDujZl/dsLhHiHjeBBvhH6jTIxp+mZNE0H/L9QTI5M7qmSrtaH/q2u8kNjlk9qsxaUynMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y/cejajR; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716321; x=1740252321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qv9L7HdrnSHnXys7Ej7f4u4edqMhpBk/lmUNGZI36h4=;
  b=Y/cejajRPcpKcEYSSQ1GidPAfjN8lydhEZbSz9Oh+RUb52dqsFVJ1gWR
   hzkUl2YBs+69W44zOhT6qWot/nyU+n3wloZ7aQEAbR4TCyT3jNRVRaiUH
   XPMFoDIrSoUpq49iCOE2KhIsz/crdOSFqMAKTmgDLs61hPjOEbMu+W3lr
   U=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="615203458"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:25:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:38401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.171:2525] with esmtp (Farcaster)
 id 190948d0-c346-46f7-9b09-41bae569f5f1; Fri, 23 Feb 2024 19:25:16 +0000 (UTC)
X-Farcaster-Flow-ID: 190948d0-c346-46f7-9b09-41bae569f5f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:25:16 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:25:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 04/10] tcp: directly drop skb in cookie check for ipv6
Date: Fri, 23 Feb 2024 11:25:04 -0800
Message-ID: <20240223192504.5097-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-5-kerneljasonxing@gmail.com>
References: <20240223102851.83749-5-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:45 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Like previous patch does, only moving skb drop logical code to
> cookie_v6_check() for later refinement.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> 1. add reviewed-by tag (David)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89iL8M=1vFdZ1hBb4POuz+MKQ50fmBAewfbowEH3jpEtpZQ@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> 
> v7:
> Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
> 1. refine the code (by removing redundant check), no functional changes. (Kuniyuki)
> 
> v6
> Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
> Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
> 1. take one case into consideration, behave like old days, or else it will trigger errors.
> 
> v5
> Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
> 1. avoid duplication of these opt_skb tests/actions (Eric)
> ---
>  net/ipv6/syncookies.c | 4 ++++
>  net/ipv6/tcp_ipv6.c   | 5 +----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 6b9c69278819..ea0d9954a29f 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	struct sock *ret = sk;
>  	__u8 rcv_wscale;
>  	int full_space;
> +	SKB_DR(reason);
>  
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
>  	    !th->ack || th->rst)
> @@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
>  
>  	ret = tcp_get_cookie_sock(sk, skb, req, dst);
> +	if (!ret)
> +		goto out_drop;
>  out:
>  	return ret;
>  out_free:
>  	reqsk_free(req);
>  out_drop:
> +	kfree_skb_reason(skb, reason);
>  	return NULL;
>  }
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 57b25b1fc9d9..0c180bb8187f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	if (sk->sk_state == TCP_LISTEN) {
>  		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
>  
> -		if (!nsk)
> -			goto discard;
> -
>  		if (nsk != sk) {
> -			if (tcp_child_process(sk, nsk, skb))
> +			if (nsk && tcp_child_process(sk, nsk, skb))
>  				goto reset;
>  			if (opt_skb)
>  				__kfree_skb(opt_skb);
> -- 
> 2.37.3


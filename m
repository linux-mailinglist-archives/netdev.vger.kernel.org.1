Return-Path: <netdev+bounces-74531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA1861C68
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3247B2358F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E01143C6A;
	Fri, 23 Feb 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sVjKemdT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C3EAD2
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716178; cv=none; b=IycLj6Hj6/EebSJXr6vehsNPshutTvH0aeoBrS1ILfqcl4JGgxYrxqupe32fCUl1YQBn2onV2xDZvgdQEL/TsnUUbkgUw7pIhGV4UPcJOVN/T5EZ+zFYjIgI4n8Il0Xl9Las73Bs8k4JWClsCvX0830uQOxQR9k7RG0KSUoleIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716178; c=relaxed/simple;
	bh=jgqsYZl1U76Rku8b3qraxjtEbNMdrAPUy+NbpCjT6M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hS6xyad0xD+pm78xZVZVOtUrfEHChVD7oGW0hP1Hpl7IuW9UXpbP2q9/JFPbVGkHLX5qKEX7cCUXXCJRlEm7wWtGjyQKAZDw83+xY8P0Ycn4dJR075tKritw2H/1AjF4PQ3MXlbCNdJK6KVtAcrtyx0+JghsZp/pFP92Iynb1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sVjKemdT; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716177; x=1740252177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71jZn0wyR8tKZlEmrPs3O1iO9w/HlTPkZPIcgNRN7KM=;
  b=sVjKemdTmGzLoyMcxChAbz1nIDwW/4NvhICd8hDwF7KrHJ/qzPoVfghS
   l0MTyqX+SnNwFpi/AQMi+ntDsr/61r2MVhTxvRoe6PcLebTNDwjwzVeT6
   3koBfIg9l9G844eaZFOa6YkBimoMDI7BtltnaohLzRpmGTaFjcEMJdtrc
   k=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="68341907"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:22:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:8952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.229:2525] with esmtp (Farcaster)
 id 26c09ca9-921e-4e7b-9baf-9f190ba7ae8f; Fri, 23 Feb 2024 19:22:50 +0000 (UTC)
X-Farcaster-Flow-ID: 26c09ca9-921e-4e7b-9baf-9f190ba7ae8f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:22:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 19:22:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 03/10] tcp: use drop reasons in cookie check for ipv4
Date: Fri, 23 Feb 2024 11:22:37 -0800
Message-ID: <20240223192237.4781-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-4-kerneljasonxing@gmail.com>
References: <20240223102851.83749-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:44 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Now it's time to use the prepared definitions to refine this part.
> Four reasons used might enough for now, I think.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> Link: https://lore.kernel.org/netdev/CANn89iLOxJxmOCH1LxXf-YwRBzKXcjPRmgQeQ6A3bKRmW8=ksg@mail.gmail.com/
> 1. add reviewed-by tag (David)
> 2. add reviewed-by tag (Eric)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89iL-FH6jzoxhyKSMioj-zdBsHqNpR7YTGz8ytM=FZSGrug@mail.gmail.com/
> 1. refine the codes (Eric)
> 
> v6:
> Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
> 1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
> an indicator which can be used as three kinds of cases to tell people that we're
> unable to get a valid one. It's a relatively general reason like what we did
> to TCP_FLAGS.
> Any better ideas/suggestions are welcome :)
> 
> v5:
> Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
> 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
> 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> ---
>  net/ipv4/syncookies.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 38f331da6677..7972ad3d7c73 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  		if (IS_ERR(req))
>  			goto out;
>  	}
> -	if (!req)
> +	if (!req) {
> +		SKB_DR_SET(reason, NO_SOCKET);
>  		goto out_drop;
> +	}
>  
>  	ireq = inet_rsk(req);
>  
> @@ -434,8 +436,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	 */
>  	RCU_INIT_POINTER(ireq->ireq_opt, tcp_v4_save_options(net, skb));
>  
> -	if (security_inet_conn_request(sk, skb, req))
> +	if (security_inet_conn_request(sk, skb, req)) {
> +		SKB_DR_SET(reason, SECURITY_HOOK);
>  		goto out_free;
> +	}
>  
>  	tcp_ao_syncookie(sk, skb, req, AF_INET);
>  
> @@ -452,8 +456,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  			   ireq->ir_loc_addr, th->source, th->dest, sk->sk_uid);
>  	security_req_classify_flow(req, flowi4_to_flowi_common(&fl4));
>  	rt = ip_route_output_key(net, &fl4);
> -	if (IS_ERR(rt))
> +	if (IS_ERR(rt)) {
> +		SKB_DR_SET(reason, IP_OUTNOROUTES);
>  		goto out_free;
> +	}
>  
>  	/* Try to redo what tcp_v4_send_synack did. */
>  	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
> @@ -476,10 +482,11 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	/* ip_queue_xmit() depends on our flow being setup
>  	 * Normal sockets get it right from inet_csk_route_child_sock()
>  	 */
> -	if (ret)
> -		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> -	else
> +	if (!ret) {
> +		SKB_DR_SET(reason, NO_SOCKET);
>  		goto out_drop;
> +	}
> +	inet_sk(ret)->cork.fl.u.ip4 = fl4;
>  out:
>  	return ret;
>  out_free:
> -- 
> 2.37.3



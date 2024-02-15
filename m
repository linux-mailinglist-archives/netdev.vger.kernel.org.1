Return-Path: <netdev+bounces-72199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D927C856F19
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 22:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791CB1F23B18
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0D13B2BF;
	Thu, 15 Feb 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GzFBilVp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9200913B287
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031378; cv=none; b=ARVfeIR4SJl1IbysmIfjG3W4uqeABNAZZ4ceH91+pObLVk+4FMBKZ3JQzEnQIv2U4msoIsSknIWbi8dt4ZIO83elbNZ72lMaRokD0HL/i5xHuBtX/oHwjfHZSnylqAZOx16qEJzULB3QvMZfMZFXN8+e/zSfk0UU/Qp9D7mdUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031378; c=relaxed/simple;
	bh=M48WQBn6YgvQbDcEahjl9zOb9wTEi7nGcfpHNGAFA/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sz4IsgMo2BtveKzGxJ9+KCUsReaV9p+bvEnxfngyHN+K/2p9qf1qRAYa+s84F0HhMD5IRhTdnWZvhzYR8IR/EBqO8fiioXrWxa+XaZTU/aoB/wvpiQ7DcaZQV0ISinv25vYPKkn86Exrraf6cIx9GRsQzBeqJ1wFt8isJUH98vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GzFBilVp; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708031376; x=1739567376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rYsTvWEiitBRJ22e/2HUzb3GtXQOiIlx4QgyQJdc6g=;
  b=GzFBilVpH/v1RrJshf6KVk5wf+9biItbK2wCCAbtWa6atcf7JsYAZ+Gn
   e39U8zEwy7EH+J9f4EnnjADfVy2lxBjBUmh5E2UwnNN8aYqkbuz+l0Cxg
   ASoRc48d9tiT3JImgYhki/24ICdYmlhObea21ihVWkDVDIflynHMpZGSM
   c=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="66360459"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 21:09:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:22009]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id f7956208-2ad0-49c1-aeed-75675e94f279; Thu, 15 Feb 2024 21:09:33 +0000 (UTC)
X-Farcaster-Flow-ID: f7956208-2ad0-49c1-aeed-75675e94f279
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 21:09:32 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 21:09:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: [PATCH net-next v5 03/11] tcp: use drop reasons in cookie check for ipv4
Date: Thu, 15 Feb 2024 13:09:22 -0800
Message-ID: <20240215210922.19969-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240215012027.11467-4-kerneljasonxing@gmail.com>
References: <20240215012027.11467-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Feb 2024 09:20:19 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Now it's time to use the prepared definitions to refine this part.
> Four reasons used might enough for now, I think.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v5:
> Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
> 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
> 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> ---
>  net/ipv4/syncookies.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 38f331da6677..aeb61c880fbd 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -421,8 +421,10 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  		if (IS_ERR(req))
>  			goto out;
>  	}
> -	if (!req)
> +	if (!req) {
> +		SKB_DR_SET(reason, NOMEM);

NOMEM is not appropriate when mptcp_subflow_init_cookie_req() fails.


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
> @@ -476,10 +482,12 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	/* ip_queue_xmit() depends on our flow being setup
>  	 * Normal sockets get it right from inet_csk_route_child_sock()
>  	 */
> -	if (ret)
> +	if (ret) {
>  		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> -	else
> +	} else {
> +		SKB_DR_SET(reason, NO_SOCKET);

This also seems wrong to me.

e.g. syn_recv_sock() could fail with sk_acceptq_is_full(sk),
then the listener is actually found.


>  		goto out_drop;
> +	}
>  out:
>  	return ret;
>  out_free:
> -- 
> 2.37.3
> 


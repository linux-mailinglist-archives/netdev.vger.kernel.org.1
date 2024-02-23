Return-Path: <netdev+bounces-74544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DF861CCA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DB8B219B1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8871145B1B;
	Fri, 23 Feb 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jssVpSG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE804142624
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717505; cv=none; b=cCWqSoWlpIhhDvyfpnKtm6ahh7inJDgjqoe8/z9+l4eeV1pl/iznfswBdVaJglwetBjw/hYk0m9kbsLD/KBwAc9VTzqw7Vq9zpOHLlWd0Qbyh9ldr9A/WAH4vf3TiJZhU6oeHWATpF7HxqNidRMXce9TV0UCWQmZtXQFhiQnauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717505; c=relaxed/simple;
	bh=oZFojommkmlfW4sfpH2pV3lTChda1Zko4jPtE5Y3Gek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/RUc1E53VzMkt/GTgbxbZ4xyxZcfuvyEmnSbPzzqwK++WR9cTa2knPtS6SWhOwsDMXOfnJeg+epBlSUnnovU5m3QySeU6XPmAAnW9h0haZ3zeWh/adosqueRxiO+lK+vrEQOpif6BfU3GdmP9E0jo4SS/iLVth0dYA0KKoEej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jssVpSG7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708717501; x=1740253501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5MAxUdfEcIs0wimr0t702udnrOLkQyv0tzwh5kSaXQ=;
  b=jssVpSG7AkgPkER+uBTuE/c+TGlQjdHsDA/XYqygI7q31agMYDyVNyk0
   9d/Dxg5RrGq1s2CS2pD7hkHiFoK6jqHjbO5n0vYom6jCjEymJbJvDQaCh
   E5FdSxdgFqsmznmn0p+N21rG/TLFYFbZyPN4WaeDnvmiPqFxaGZe0QbDX
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="187007743"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:44:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.43:2525] with esmtp (Farcaster)
 id fd2024cd-09a8-4798-a574-cfb81e9130c9; Fri, 23 Feb 2024 19:44:57 +0000 (UTC)
X-Farcaster-Flow-ID: fd2024cd-09a8-4798-a574-cfb81e9130c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:44:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:44:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 09/10] tcp: make the dropreason really work when calling tcp_rcv_state_process()
Date: Fri, 23 Feb 2024 11:44:45 -0800
Message-ID: <20240223194445.7537-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-10-kerneljasonxing@gmail.com>
References: <20240223102851.83749-10-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:50 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Update three callers including both ipv4 and ipv6 and let the dropreason
> mechanism work in reality.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

two nits below.


> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> 1. add reviewed-by tag (David)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89i+Uikp=NvB7SVQpYnX-2FqJrH3hWw3sV0XpVcC55MiNUg@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> ---
>  include/net/tcp.h        | 2 +-
>  net/ipv4/tcp_ipv4.c      | 3 ++-
>  net/ipv4/tcp_minisocks.c | 9 +++++----
>  net/ipv6/tcp_ipv6.c      | 3 ++-
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e5af9a5b411b..1d9b2a766b5e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -396,7 +396,7 @@ enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
>  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  			   struct request_sock *req, bool fastopen,
>  			   bool *lost_race);
> -int tcp_child_process(struct sock *parent, struct sock *child,
> +enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
>  		      struct sk_buff *skb);

Please fix indentation here,


>  void tcp_enter_loss(struct sock *sk);
>  void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost, int flag);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0a944e109088..c79e25549972 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1926,7 +1926,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	} else
>  		sock_rps_save_rxhash(sk, skb);
>  
> -	if (tcp_rcv_state_process(sk, skb)) {
> +	reason = tcp_rcv_state_process(sk, skb);
> +	if (reason) {
>  		rsk = sk;
>  		goto reset;
>  	}
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 9e85f2a0bddd..08d5b48540ea 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -911,11 +911,12 @@ EXPORT_SYMBOL(tcp_check_req);
>   * be created.
>   */
>  
> -int tcp_child_process(struct sock *parent, struct sock *child,
> +enum skb_drop_reason
> +tcp_child_process(struct sock *parent, struct sock *child,
>  		      struct sk_buff *skb)

and here.


>  	__releases(&((child)->sk_lock.slock))
>  {
> -	int ret = 0;
> +	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
>  	int state = child->sk_state;
>  
>  	/* record sk_napi_id and sk_rx_queue_mapping of child. */
> @@ -923,7 +924,7 @@ int tcp_child_process(struct sock *parent, struct sock *child,
>  
>  	tcp_segs_in(tcp_sk(child), skb);
>  	if (!sock_owned_by_user(child)) {
> -		ret = tcp_rcv_state_process(child, skb);
> +		reason = tcp_rcv_state_process(child, skb);
>  		/* Wakeup parent, send SIGIO */
>  		if (state == TCP_SYN_RECV && child->sk_state != state)
>  			parent->sk_data_ready(parent);
> @@ -937,6 +938,6 @@ int tcp_child_process(struct sock *parent, struct sock *child,
>  
>  	bh_unlock_sock(child);
>  	sock_put(child);
> -	return ret;
> +	return reason;
>  }
>  EXPORT_SYMBOL(tcp_child_process);
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 0c180bb8187f..4f8464e04b7f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1663,7 +1663,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	} else
>  		sock_rps_save_rxhash(sk, skb);
>  
> -	if (tcp_rcv_state_process(sk, skb))
> +	reason = tcp_rcv_state_process(sk, skb);
> +	if (reason)
>  		goto reset;
>  	if (opt_skb)
>  		goto ipv6_pktoptions;
> -- 
> 2.37.3
> 


Return-Path: <netdev+bounces-74543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECD861CB8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E577F1C23A58
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D19143C70;
	Fri, 23 Feb 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lh93fJeu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB91420B7
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717316; cv=none; b=DeJR90RL+t4LIRFFZoeb9oW9lJmayrzwDz5t8Nmnj0FPGyAXhXg2jlzs4HznU04quF+7zIHIrTXUn148f59rK2uIZnRM3wLn2/g7JHAKp6MqQBn51hcBApMMIm+ttO6u5HqqxhRxquwicJgpanx7Zgylrmqa07I+pRguM6sVmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717316; c=relaxed/simple;
	bh=g9agpSPQKbtSFMBeJ1HAkgHZnHWGtaWs68h87FgX04o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHfY3p0gDtJNjvfzfY8bRtEnrbgUZJRHRE+jnsaiQQL05WfICe8g7/4zGi+9KOc3F01udx0J8KsA1afoSwYH+dqTbvQZ1+BXOs4C3lr4t3fAdwruTo0CquXXwTE3gHniA5Ix2J4mm3d4bqjbDJCdv0F/ce6t3KgCpTgFo/L0dCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lh93fJeu; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708717315; x=1740253315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+eBKWI1NbsZeNVf0V5Joh41Hyf3rI/7v9ZZasuknbg=;
  b=lh93fJeuIUqL3zk04IGu/D84EGvcGAOk4nTtkFWkCRpLCw4GkHRDwUfD
   BIB7blTflAWYU+x8xevcmksGZJ8fUIyiAnNpjALgScdGfcavAj0Gb9tod
   /1AUZEb3PWSR4r3icJObQ5Fa3UAw02oq1zxYsX5312+jc5iAW7cPDWMHu
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="706469582"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:41:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:30390]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.154:2525] with esmtp (Farcaster)
 id 476ec20f-0700-45c2-84f9-f3fa6cb72a1d; Fri, 23 Feb 2024 19:41:48 +0000 (UTC)
X-Farcaster-Flow-ID: 476ec20f-0700-45c2-84f9-f3fa6cb72a1d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:41:39 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:41:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 08/10] tcp: add dropreasons in tcp_rcv_state_process()
Date: Fri, 23 Feb 2024 11:41:26 -0800
Message-ID: <20240223194126.7246-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-9-kerneljasonxing@gmail.com>
References: <20240223102851.83749-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:49 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> In this patch, I equipped this function with more dropreasons, but
> it still doesn't work yet, which I will do later.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> --
> v9
> Link: https://lore.kernel.org/netdev/CAL+tcoCbsbM=HyXRqs2+QVrY8FSKmqYC47m87Axiyk1wk4omwQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> 1. nit: remove unnecessary else (David)
> 2. add reviewed-by tag (David)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89iJJ9XTVeC=qbSNUnOhQMAsfBfouc9qUJY7MxgQtYGmB3Q@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> 
> v5:
> Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
> 1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> ---
>  include/net/tcp.h    |  2 +-
>  net/ipv4/tcp_input.c | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 58e65af74ad1..e5af9a5b411b 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -348,7 +348,7 @@ void tcp_wfree(struct sk_buff *skb);
>  void tcp_write_timer_handler(struct sock *sk);
>  void tcp_delack_timer_handler(struct sock *sk);
>  int tcp_ioctl(struct sock *sk, int cmd, int *karg);
> -int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
> +enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 83308cca1610..5d874817a78d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6619,7 +6619,8 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
>   *	address independent.
>   */
>  
> -int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
> +enum skb_drop_reason
> +tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct inet_connection_sock *icsk = inet_csk(sk);
> @@ -6635,7 +6636,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  
>  	case TCP_LISTEN:
>  		if (th->ack)
> -			return 1;
> +			return SKB_DROP_REASON_TCP_FLAGS;
>  
>  		if (th->rst) {
>  			SKB_DR_SET(reason, TCP_RESET);
> @@ -6704,8 +6705,12 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  				  FLAG_NO_CHALLENGE_ACK);
>  
>  	if ((int)reason <= 0) {
> -		if (sk->sk_state == TCP_SYN_RECV)
> -			return 1;	/* send one RST */
> +		if (sk->sk_state == TCP_SYN_RECV) {
> +			/* send one RST */
> +			if (!reason)
> +				return SKB_DROP_REASON_TCP_OLD_ACK;
> +			return -reason;
> +		}
>  		/* accept old ack during closing */
>  		if ((int)reason < 0) {
>  			tcp_send_challenge_ack(sk);
> @@ -6781,7 +6786,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  		if (READ_ONCE(tp->linger2) < 0) {
>  			tcp_done(sk);
>  			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
> -			return 1;
> +			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
>  		}
>  		if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
>  		    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
> @@ -6790,7 +6795,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  				tcp_fastopen_active_disable(sk);
>  			tcp_done(sk);
>  			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
> -			return 1;
> +			return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
>  		}
>  
>  		tmo = tcp_fin_time(sk);
> @@ -6855,7 +6860,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
>  				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
>  				tcp_reset(sk, skb);
> -				return 1;
> +				return SKB_DROP_REASON_TCP_ABORT_ON_DATA;
>  			}
>  		}
>  		fallthrough;
> -- 
> 2.37.3


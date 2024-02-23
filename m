Return-Path: <netdev+bounces-74542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F5861C9E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5F1C21942
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5255B143C59;
	Fri, 23 Feb 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hvXMvbcr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517F12AAE0
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716976; cv=none; b=YzLikjtCtbDiS9mxJvWTLtEP8nPLIyMhPlHR1L4Zp+So5t8C5JfkM9XFj13MOhQKPn7e77aZ818fIRnLrAF70H5dViOmYVKJeTwZUMYv1WyMx1SdMW0NQVU+j9gglMBgRrVO044Kw9Vig55YfKqNQ+PoHuzU1xRGPnxh+CyB3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716976; c=relaxed/simple;
	bh=ZJdF6fcQB/D3aoRjfCMbD/BqXfb6AMtd/RTSAogPfEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tj3LHilVAxIovF7T3NjheIf2U/re8UJHuWdCx25CXpB6Iw/eDNdXLW7Q/abcJzTkgmMoY9J5cERzXMdE4Gi4UK+hzDe/ZETMhG4NNUf+NnqPOh95P2BsypFZdeRx+45LJ/k76NsiHAvbDyk0DiLDbw5pXHMnIkSAbAwxGZFNq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hvXMvbcr; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716974; x=1740252974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6T4drezmuoL9SVXRMxMcYqu0oOraEwUDkwszdNQlyQ=;
  b=hvXMvbcrP+F/58pl8Yc1RF/RijFv5VpxZA6ZMbCxXAfsSjsnPdI1U8PE
   VMO5nWn5n3ljS3jY/+UJpbnqrn405xr2Iq+SJxSdbS11Lm/aL7oVEM7Ov
   RgMXREfLQaGZgc0QeodlTY+pdH3WOyK0spsAn0roiIsSzuJ4bU0AUHvdg
   4=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="399286967"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:36:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:39423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.177:2525] with esmtp (Farcaster)
 id 511f3b7c-cde8-4199-b8f7-5f37c9e27105; Fri, 23 Feb 2024 19:36:07 +0000 (UTC)
X-Farcaster-Flow-ID: 511f3b7c-cde8-4199-b8f7-5f37c9e27105
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:36:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:36:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 07/10] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
Date: Fri, 23 Feb 2024 11:35:54 -0800
Message-ID: <20240223193554.6960-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-8-kerneljasonxing@gmail.com>
References: <20240223102851.83749-8-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:48 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> This patch does two things:
> 1) add two more new reasons
> 2) only change the return value(1) to various drop reason values
> for the future use
> 
> For now, we still cannot trace those two reasons. We'll implement the full
> function in the subsequent patch in this series.
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
> Link: https://lore.kernel.org/netdev/CANn89i+EF77F5ZJbbkiDQgwgAqSKWtD3djUF807zQ=AswGvosQ@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> ---
>  net/ipv4/tcp_input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 74c03f0a6c0c..83308cca1610 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6361,6 +6361,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>  				inet_csk_reset_xmit_timer(sk,
>  						ICSK_TIME_RETRANS,
>  						TCP_TIMEOUT_MIN, TCP_RTO_MAX);
> +			SKB_DR_SET(reason, TCP_INVALID_ACK_SEQUENCE);
>  			goto reset_and_undo;
>  		}
>  
> @@ -6369,6 +6370,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>  			     tcp_time_stamp_ts(tp))) {
>  			NET_INC_STATS(sock_net(sk),
>  					LINUX_MIB_PAWSACTIVEREJECTED);
> +			SKB_DR_SET(reason, TCP_RFC7323_PAWS);
>  			goto reset_and_undo;
>  		}
>  
> @@ -6572,7 +6574,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>  reset_and_undo:
>  	tcp_clear_options(&tp->rx_opt);
>  	tp->rx_opt.mss_clamp = saved_clamp;
> -	return 1;
> +	/* we can reuse/return @reason to its caller to handle the exception */
> +	return reason;
>  }
>  
>  static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
> -- 
> 2.37.3


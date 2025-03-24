Return-Path: <netdev+bounces-177252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C2A6E69C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE81890B6E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBE61A23A1;
	Mon, 24 Mar 2025 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NiKCCa/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135DF1A01C6
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855582; cv=none; b=XiAZP+oyz9u1DwhabmZtiJJikb6VnH/kfc+LJT8/MqawJqGb/7mdMYVbbeDOzN2+pd4cNR2zRX1zgQeuQaENVdSp92/qwxSIvSg7yLF2/rAVywPo4syrstWrOTo3RFR647Pg6j9SRTEk6ArLNzFpUrMCxuBFuURf7HE1I1YTlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855582; c=relaxed/simple;
	bh=2+fr3WVb38GlBHVy+wuFIIpZBa6EdZZkmFipXee6Bas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQhFslwBrysZ9Nja5erWgprT388UHf5mSuelV9vE78NP1KUCrMWdnYjsz1hfuOQaQ6uPUb0OTz0kfWrfGINbttQTUlNtC8NatJ4chjYdCfHos8ZEpuCeUXOjjVqlg/qD5/BESFGILBWBNEyrHAgztsg0efrxR4OoD4xO1Gd4pHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NiKCCa/q; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742855581; x=1774391581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bgEdfZiIcBa5XBRmjV3AmFxOHnS/m69hf+qceDrGl2E=;
  b=NiKCCa/qKegnRUZsrLriEXDicPKQ5Mv/xgAJDaPiL7PF9d4U1OjdA9vz
   la8elWiCMURDW6uqGPEzWIZBa9FtUvh8ERjVFTRDyOB/bh7ZyPBY0OMr3
   lWv75LRg92+UuyuzKtfiBO1RGxT0z1BI6QW4E3xrYC3ASCisLohIGyiz+
   o=;
X-IronPort-AV: E=Sophos;i="6.14,273,1736812800"; 
   d="scan'208";a="707802622"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 22:32:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:13574]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id 8507564c-cc8a-4732-b911-273b0827440d; Mon, 24 Mar 2025 22:32:57 +0000 (UTC)
X-Farcaster-Flow-ID: 8507564c-cc8a-4732-b911-273b0827440d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 22:32:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Mar 2025 22:32:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: avoid atomic operations on sk->sk_rmem_alloc
Date: Mon, 24 Mar 2025 15:32:15 -0700
Message-ID: <20250324223243.76632-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320121604.3342831-1-edumazet@google.com>
References: <20250320121604.3342831-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 12:16:04 +0000
> TCP uses generic skb_set_owner_r() and sock_rfree()
> for received packets, with socket lock being owned.
> 
> Switch to private versions, avoiding two atomic operations
> per packet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/tcp.h       | 15 +++++++++++++++
>  net/ipv4/tcp.c          | 18 ++++++++++++++++--
>  net/ipv4/tcp_fastopen.c |  2 +-
>  net/ipv4/tcp_input.c    |  6 +++---
>  4 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d08fbf90495de69b157d3c87c50e82d781a365df..dd6d63a6f42b99774e9461b69d3e7932cf629082 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -779,6 +779,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
>  
>  /* tcp.c */
>  void tcp_get_info(struct sock *, struct tcp_info *);
> +void tcp_sock_rfree(struct sk_buff *skb);
>  
>  /* Read 'sendfile()'-style from a TCP socket */
>  int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> @@ -2898,4 +2899,18 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
>  		const void *saddr, const void *daddr,
>  		int family, int dif, int sdif);
>  
> +/* version of skb_set_owner_r() avoiding one atomic_add() */
> +static inline void tcp_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
> +{
> +	skb_orphan(skb);
> +	skb->sk = sk;
> +	skb->destructor = tcp_sock_rfree;
> +
> +	sock_owned_by_me(sk);
> +	atomic_set(&sk->sk_rmem_alloc,
> +		   atomic_read(&sk->sk_rmem_alloc) + skb->truesize);

It's nice to learn that atomic_set() and _read() are just __WRITE_ONCE()
and __READ_ONCE() and have no LOCK_PREFIX :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


Return-Path: <netdev+bounces-138849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AAB9AF282
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA51C2627E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1221830D;
	Thu, 24 Oct 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tus2hTjp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606F2141CB
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797252; cv=none; b=MPc+kNFb9k4h2SUnOeE2nmdRS8c25W6nUFaEVoed0/kQ07jyarO5H6XfejaxgItV30QUh0KSz/3aF6eTX0QIWmOCuCjmdgZLR3L/jd9Lt40oNMQZEXkblFNdV8CQBo3xLRqQuVl037SfKen2/1/4QmK+kdImeD752bTnyEC188I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797252; c=relaxed/simple;
	bh=ahtJyRWf6fW06ZJGWcr6jW+c998DDZHzizYyGN8Wc/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=affgs4pSrzSBLX2ZMCwtb/9CaflEQL2e3NNJv7GxFHxyxQAPsu59E2RmLxNcrogZ2fDKgUlooVCBwMTWgQU3KhbjAxkSYPh15fyw+RQ2PPEOXsA4IQeLygFEZPMGAoADp26iNfG5Pz74SvM8uHYNgHEKOIC7ZAqErv0plqVRsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tus2hTjp; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729797250; x=1761333250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yItsfa8MEM1NOB0K/f/mJhLmzWhj8ALD6cGU4Zwu3wk=;
  b=Tus2hTjpqm1s7YMGlKWJsLLccsVj4L4DPyGF7sEulmnNBMlbSfC6mg7t
   FhHp/MglV400qkrmA5CuYdiVf8BHtnykFvFAHQST9sPoyDezxBtEs1hEN
   6niic4Hlw/s7W88eAe2EfH4R1izv+p1MO7VYZBdDB2aAKR1Davrj9+KSb
   M=;
X-IronPort-AV: E=Sophos;i="6.11,230,1725321600"; 
   d="scan'208";a="464360279"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 19:14:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8860]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.158:2525] with esmtp (Farcaster)
 id aba2e2b1-da97-4506-a05b-350717a2bb14; Thu, 24 Oct 2024 19:14:04 +0000 (UTC)
X-Farcaster-Flow-ID: aba2e2b1-da97-4506-a05b-350717a2bb14
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 19:14:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 24 Oct 2024 19:13:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <laoar.shao@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <menglong8.dong@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>, <dxu@dxuuu.xyz>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
Date: Thu, 24 Oct 2024 12:13:56 -0700
Message-ID: <20241024191356.38734-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241024093742.87681-3-laoar.shao@gmail.com>
References: <20241024093742.87681-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 24 Oct 2024 17:37:42 +0800
> We previously hooked the tcp_drop_reason() function using BPF to monitor
> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> To address this, it would be beneficial to make noinline explicitly for
> tracing.
> 
> Link: https://lore.kernel.org/netdev/CANn89iJuShCmidCi_ZkYABtmscwbVjhuDta1MS5LxV_4H9tKOA@mail.gmail.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Menglong Dong <menglong8.dong@gmail.com>

I saw a somewhat related post yesterday.
https://x.com/__dxu/status/1849271647989068107

Daniel, could we apply your approach to this issue in the near future ?

Thread link: https://lore.kernel.org/netdev/20241024093742.87681-1-laoar.shao@gmail.com/


> ---
>  net/ipv4/tcp_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cc05ec1faac8..cf1e2e3a7407 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4894,8 +4894,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
>  	return res;
>  }
>  
> -static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
> -			    enum skb_drop_reason reason)
> +noinline_for_tracing static void
> +tcp_drop_reason(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
>  {
>  	sk_drops_add(sk, skb);
>  	sk_skb_reason_drop(sk, skb, reason);
> -- 
> 2.43.5
> 


Return-Path: <netdev+bounces-82654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1188EF2A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 20:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E4E1C2A52F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF414EC50;
	Wed, 27 Mar 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YgmnOcNR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93C5227
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567795; cv=none; b=WNwYERQFxnIHnAQ9rLcGEXeXpZbBL6W3bBFLac04s7A8vtXAboGSi7kZtZUIVPqXBOD6CCsr/9zs2iG7ugcPcDEX67fjhzp8pPf2y+dutkD+qHisHH0az4NyGzhMr74Jaz4m/v31S/p6sw3UFHzo/kG6kfTVNAPkD5f5LG2F4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567795; c=relaxed/simple;
	bh=LyKLXZ+SSNj05Nv929z79tkjBmruPTcG042sCpoq6kI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEkSRppW6q2lFaqa4QLtKhGMtgpXsn/1OGuW1oXoMtQOp9Xw23MMtM2sA8dxHVRvid75uvohwDLyskdmqsrpYyovcow8AgHeNhnzge4qDekSMSE/enj2fSKQvGZPSM4Xi1MdQ1eBrAK9bU3IjE7NSkanoOY3jpaJjfgdvgOhUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YgmnOcNR; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711567795; x=1743103795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ddqjGt/KRaeUYp4ogP035JliPK8BCq1LEONHp5A/Fs=;
  b=YgmnOcNR3KDEAcnMqdBZD+ZPr4JihtXzkoDkREvEl70GWAEZRPlPsCPA
   u9nCsTM/fV35rH59/TlUsQxy/L/eOg8uoH1X1O3Pso9YZSIZWHa7l5AL3
   9cmL/aqTJYs3VRAvCyXATxjUhgZDErxq2K0IoLDfdq54vpKyM05IKPEgN
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,159,1708387200"; 
   d="scan'208";a="194852616"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:29:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:55046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.228:2525] with esmtp (Farcaster)
 id d9f30dc5-6893-40bf-9f0f-01af57ae9920; Wed, 27 Mar 2024 19:29:50 +0000 (UTC)
X-Farcaster-Flow-ID: d9f30dc5-6893-40bf-9f0f-01af57ae9920
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 27 Mar 2024 19:29:50 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 27 Mar 2024 19:29:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp/dccp: bypass empty buckets in inet_twsk_purge()
Date: Wed, 27 Mar 2024 12:29:34 -0700
Message-ID: <20240327192934.6843-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327191206.508114-1-edumazet@google.com>
References: <20240327191206.508114-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Mar 2024 19:12:06 +0000
> TCP ehash table is often sparsely populated.
> 
> inet_twsk_purge() spends too much time calling cond_resched().
> 
> This patch can reduce time spent in inet_twsk_purge() by 20x.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Sounds good!

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

1 nit below.


> ---
>  net/ipv4/inet_timewait_sock.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> index e8de45d34d56a507a4bdcceaccbd5707692b6c0a..b0cc07d9a568c5dc52bd29729862bcb03e5d595d 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -266,12 +266,17 @@ EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
>  /* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
>  void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
>  {
> +	struct inet_ehash_bucket *head = &hashinfo->ehash[0];
> +	unsigned int ehash_mask = hashinfo->ehash_mask;
>  	struct hlist_nulls_node *node;
>  	unsigned int slot;
>  	struct sock *sk;
>  
> -	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
> -		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
> +	for (slot = 0; slot <= ehash_mask; slot++, head++) {
> +

unnecessary blank link here.

Thanks!

> +		if (hlist_nulls_empty(&head->chain))
> +			continue;
> +
>  restart_rcu:
>  		cond_resched();
>  		rcu_read_lock();
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 


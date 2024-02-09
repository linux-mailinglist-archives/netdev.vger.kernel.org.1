Return-Path: <netdev+bounces-70464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3233D84F217
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED108288EF7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E78664C5;
	Fri,  9 Feb 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fMNYIIv1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315E664C9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470113; cv=none; b=bgDmHDPZuqT+Z0wkuCXH5Q5tmezrBeGC96dVgnRu0lnehsUeZsc1yFFBbvl4tp7Sm+b3bsznrGWC0OsmuhT4iDpphWe3r7kkahTMf5F9wkXV5c2yVn94qDq/RRv3yciaUjJFVb9IHCNpkHEi1EKmZCK6BvSE64XTKEAdbIf3ulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470113; c=relaxed/simple;
	bh=QmJdIY6CrasyOGjGr1qXOw2HghGmUgcTKzC3xVgq4s4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmYZ2G+5l02K96QnOoWRPjciL6gbW39prLaEjnaPm1lvavKIrMOaAGJkIWxv9snSpF9LVS4wzrI+w6lQMT8DRXJr0C5L7djPaJpfHfI3jZLDp/IOuzjgnRdF3qeVqwg9cbtpmD1CBTWg7ENNH5802curol+4gLdpf8gKmr5N0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fMNYIIv1; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707470111; x=1739006111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMPuv/CqcO67JbqI2KVvdTSBCPVXrSHPH+lfqBmF/bQ=;
  b=fMNYIIv10drJiA5g9PWbtK9sg9Lsc15p4j/mMcIRPYYwawJcrmRLend9
   0ALFXeGDcPAftxRALo6JYdgxy1RQFDvPwA59kA0NNPky9Fysn9CGXtTQG
   ziiC2umdVJ9ddT/h2c9tQtQ6hmVTIODoeqUmpH+Ad79YH4EPAJyb70H82
   g=;
X-IronPort-AV: E=Sophos;i="6.05,256,1701129600"; 
   d="scan'208";a="633192675"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:15:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:37062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.35:2525] with esmtp (Farcaster)
 id 6af78892-2f50-4bf6-b776-538463434db2; Fri, 9 Feb 2024 09:15:07 +0000 (UTC)
X-Farcaster-Flow-ID: 6af78892-2f50-4bf6-b776-538463434db2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 09:15:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 9 Feb 2024 09:15:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp: add more DROP REASONs in receive process
Date: Fri, 9 Feb 2024 01:14:54 -0800
Message-ID: <20240209091454.32323-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240209061213.72152-3-kerneljasonxing@gmail.com>
References: <20240209061213.72152-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri,  9 Feb 2024 14:12:13 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> As the title said, add more reasons to narrow down the range about
> why the skb should be dropped.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/dropreason-core.h | 11 ++++++++++-
>  include/net/tcp.h             |  4 ++--
>  net/ipv4/tcp_input.c          | 26 +++++++++++++++++---------
>  net/ipv4/tcp_ipv4.c           | 19 ++++++++++++-------
>  net/ipv4/tcp_minisocks.c      | 10 +++++-----
>  net/ipv6/tcp_ipv6.c           | 19 ++++++++++++-------
>  6 files changed, 58 insertions(+), 31 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index efbc5dfd9e84..9a7643be9d07 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -31,6 +31,8 @@
>  	FN(TCP_AOFAILURE)		\
>  	FN(SOCKET_BACKLOG)		\
>  	FN(TCP_FLAGS)			\
> +	FN(TCP_CONNREQNOTACCEPTABLE)	\
> +	FN(TCP_ABORTONDATA)		\
>  	FN(TCP_ZEROWINDOW)		\
>  	FN(TCP_OLD_DATA)		\
>  	FN(TCP_OVERWINDOW)		\
[...]
> @@ -6654,7 +6657,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>  			rcu_read_unlock();
>  
>  			if (!acceptable)
> -				return 1;
> +				return SKB_DROP_REASON_TCP_CONNREQNOTACCEPTABLE;

This sounds a bit ambiguous, and I think it can be more specific
if tcp_conn_request() returns the drop reason and we change the
acceptable evaluation.

  acceptable = icsk->icsk_af_ops->conn_request(sk, skb) >= 0;


>  			consume_skb(skb);
>  			return 0;
>  		}


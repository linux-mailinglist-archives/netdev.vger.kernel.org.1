Return-Path: <netdev+bounces-74528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E1861C4F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992111F23D12
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203F179A8;
	Fri, 23 Feb 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k+xQpv/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7946B8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715589; cv=none; b=ufCwc50BbmZhHrUV9ppsjDxSEMp+wj/5kaQGkG16oQCdb7on8mHzl6AxrgrtpxBq+Ji+GRYPU4EpEzDQgi0+DwLDdb/5qQEiE1z1izrz8kpqYbQTyHIwSvI70e0IB07A94BHIvwb16KjMNsMkjybdHMWcjYtPpMBbhV26fAlABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715589; c=relaxed/simple;
	bh=BDYj5S0z74Pk1pDo6k9jPLoalkiuNjF5wU/cqluxoZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=de4kcx/J7BvIHgbZWVdgqgujdUgMEMYIMjxjaM5AHCsibLPVmHy5+a2ddc4PTpcPnhsljtCWnXv0PvNgSDwGbiB2Y22DQE8H9f2+zf140KH+DHzc66gp1ijvSCAAF3jHxhm0Bb8ZuFmzLi05j53t/OGHRcnYx2aYAolUYU31bYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k+xQpv/a; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708715587; x=1740251587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xYgQjmleSE90g73hI2m4h0MOyaY5t2PJKlT59oKjjEU=;
  b=k+xQpv/aJQyLhQYGapCjbWF7xGm0BkePKpqqGFBFS9Z1DhjygFegzZz2
   hI3iAGpi58d+au1vffHi5CC2Fk1cnw8wXhi14C2JJwlm0t3pC6eoTRL1o
   DVzENHto5xejoLnhtRWqm5uEa7T+mSEnfgLmC1vk62RlCg5CvEHH9R70Q
   g=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="275470190"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:13:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29299]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.213:2525] with esmtp (Farcaster)
 id 4df77269-2fb7-43d8-9168-77b4a8756ceb; Fri, 23 Feb 2024 19:13:05 +0000 (UTC)
X-Farcaster-Flow-ID: 4df77269-2fb7-43d8-9168-77b4a8756ceb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:13:05 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:13:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 01/10] tcp: add a dropreason definitions and prepare for cookie check
Date: Fri, 23 Feb 2024 11:12:52 -0800
Message-ID: <20240223191252.3856-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-2-kerneljasonxing@gmail.com>
References: <20240223102851.83749-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:42 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Adding one drop reason to detect the condition of skb dropped
> because of hook points in cookie check and extending NO_SOCKET
> to consider another two cases can be used later.
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
> Link: https://lore.kernel.org/netdev/CANn89iJ3gLMn5psbzfVCOo2=v4nMn4m41wpr6svxyAmO4R1m6g@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> 
> v7
> Link: https://lore.kernel.org/all/20240219040630.94637-1-kuniyu@amazon.com/
> 1. nit: change "invalid" to "valid" (Kuniyuki)
> 2. add more description.
> 
> v6
> Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
> 1. Modify the description NO_SOCKET to extend other two kinds of invalid
> socket cases.
> What I think about it is we can use it as a general indicator for three kinds of
> sockets which are invalid/NULL, like what we did to TCP_FLAGS.
> Any better ideas/suggestions are welcome :)
> 
> v5
> Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
> 1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
> 2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> 3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> 4. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
> 5. adjust the title and description.
> 
> v4
> Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
> 1. fix misspelled name in kdoc as Jakub said
> ---
>  include/net/dropreason-core.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 6d3a20163260..a871f061558d 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -54,6 +54,7 @@
>  	FN(NEIGH_QUEUEFULL)		\
>  	FN(NEIGH_DEAD)			\
>  	FN(TC_EGRESS)			\
> +	FN(SECURITY_HOOK)		\
>  	FN(QDISC_DROP)			\
>  	FN(CPU_BACKLOG)			\
>  	FN(XDP)				\
> @@ -105,7 +106,13 @@ enum skb_drop_reason {
>  	SKB_CONSUMED,
>  	/** @SKB_DROP_REASON_NOT_SPECIFIED: drop reason is not specified */
>  	SKB_DROP_REASON_NOT_SPECIFIED,
> -	/** @SKB_DROP_REASON_NO_SOCKET: socket not found */
> +	/**
> +	 * @SKB_DROP_REASON_NO_SOCKET: no valid socket that can be used.
> +	 * Reason could be one of three cases:
> +	 * 1) no established/listening socket found during lookup process
> +	 * 2) no valid request socket during 3WHS process
> +	 * 3) no valid child socket during 3WHS process
> +	 */
>  	SKB_DROP_REASON_NO_SOCKET,
>  	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
>  	SKB_DROP_REASON_PKT_TOO_SMALL,
> @@ -271,6 +278,8 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_NEIGH_DEAD,
>  	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
>  	SKB_DROP_REASON_TC_EGRESS,
> +	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
> +	SKB_DROP_REASON_SECURITY_HOOK,
>  	/**
>  	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
>  	 * failed to enqueue to current qdisc)
> -- 
> 2.37.3


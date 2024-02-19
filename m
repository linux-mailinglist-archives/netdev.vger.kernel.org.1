Return-Path: <netdev+bounces-72811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBA859B3D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB93B280D33
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1E63BF;
	Mon, 19 Feb 2024 04:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pzvyuZDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2BEAD3
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315609; cv=none; b=IRrcfvVJkq+XVU/7+/T/guwlKCkRUhCaP6UPa+8TSSr5Vh2MFTdDde5kUfmcrVHP/t3JwyR7keTWFMusOc3QifZOpjm3zApODzi3FRgPJR+fM9oHAMKHCsXyy9uICHLjRvMV4kYDYaW5v6LkKAWgrmzBaSa5/Bi/dXpJyAlYM0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315609; c=relaxed/simple;
	bh=Dk9KruBz/IH92tMpi7DJEbGATxlk+O6IcEW/sLIzzSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STMHYffO//LqpkkNUFmJC6aRJ7jqfzLbGATlgHXpw+HX1OIsjJ8azoYnhxWbJtnvPZCgjpTv6M9cJ2N1W3NJVqg3A1jgAiEyJ/A3LeENJ2FLVt7jZ6JEtcnhIYGk/8i1I/Cswf1tVRx2J+YWKq6LigL2rXoctDX4GBtVww8WBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pzvyuZDd; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708315608; x=1739851608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOT5tV3+iYmbdcVEsIyrgC+BwqxA4OmSRsb6a9BNcHI=;
  b=pzvyuZDdknHvwc1oTqHY/YfWqc8DXAFJVhE2UFkND5//K6KeFc9eU1E2
   14rJkry2Yjdu/52m/eyTM2gOqmxe1kX64vxhwgmJBXEXevxUzHpaKnlIV
   2bDzSOCB18nusgXVZvkgFGKj6nCpE0SFeY0syVK31Y3sci7WNQ6Cg45dK
   w=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="387381614"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:7815]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.141:2525] with esmtp (Farcaster)
 id fcf16b39-ee3b-4f43-97f7-95056d1d44d7; Mon, 19 Feb 2024 04:06:42 +0000 (UTC)
X-Farcaster-Flow-ID: fcf16b39-ee3b-4f43-97f7-95056d1d44d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:06:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 19 Feb 2024 04:06:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 01/11] tcp: add a dropreason definitions and prepare for cookie check
Date: Sun, 18 Feb 2024 20:06:30 -0800
Message-ID: <20240219040630.94637-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219032838.91723-2-kerneljasonxing@gmail.com>
References: <20240219032838.91723-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 11:28:28 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only add one drop reason to detect the condition of skb dropped
> because of hook points in cookie check for later use.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
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
> index 6d3a20163260..3c867384dead 100644
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
> +	 * @SKB_DROP_REASON_NO_SOCKET: no invalid socket that can be used.

s/invalid/valid/

Same for 2) and 3) below.


> +	 * Reason could be one of three cases:
> +	 * 1) no established/listening socket found during lookup process
> +	 * 2) no invalid request socket during 3WHS process
> +	 * 3) no invalid child socket during 3WHS process
> +	 */
>  	SKB_DROP_REASON_NO_SOCKET,
>  	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
>  	SKB_DROP_REASON_PKT_TOO_SMALL,


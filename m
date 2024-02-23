Return-Path: <netdev+bounces-74541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E018861C92
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8091C23870
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B608143C74;
	Fri, 23 Feb 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A+B27v9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BC1448FF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716833; cv=none; b=qg1uoAVeCA2P2BrL8rl3iFxVM4oERbP2f83mRBmWSoYxyPASL+2Q4UORRlzhRaou50j2e3GC/hEIXHfhwRJ346NgjiGYvXOR8/16c0+2BOm3iYwcVv/5+7DA0h+5BDiBt6iIk2UDkNcNujbxOTWWCbGyo2yYJFZisA8IlAWZ65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716833; c=relaxed/simple;
	bh=ieiOOssPRnTNyOj5qVOyQ1tQq6c9ccB5zNXAiIYbbiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7ydyjZNIthgk5yEQCCeMDBx3reUqnV7CJMLBN52Q0Y8FC4irW6jQDV/hIHMhTkadIgunu5Lq4shFB58cb3P/DS281ksrnLH/uSWVn0RHwlDgLVhl/9tgclNDoj8xaXkvUQlwxO9/ebeZzmk04VwSOANWh/MaDYKLQ8F60C0hFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A+B27v9v; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716831; x=1740252831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sHFPE3W6cT7LIWsh5zUoToSe53KJMr19jJJVFR9f4/s=;
  b=A+B27v9vGno8rx+SwNxplS6e3uLR/adc7HyQpdBMjB9TVjSiKxw7x2+p
   H8S9pCWcylBb+lD7Sp8DS6yxpMVG1yanmdoTk71VsTF5srDqdOR1sZ8Jx
   SZL6uf11qdKGXnCyzgXynyKVa3VkrR1YgGHzewZfR78iHlSdx2G6B28DQ
   A=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="68344361"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:33:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:42288]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.171:2525] with esmtp (Farcaster)
 id 843c66d7-5fc5-4b15-a26d-42375dd2b35b; Fri, 23 Feb 2024 19:33:50 +0000 (UTC)
X-Farcaster-Flow-ID: 843c66d7-5fc5-4b15-a26d-42375dd2b35b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:33:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:33:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 06/10] tcp: introduce dropreasons in receive path
Date: Fri, 23 Feb 2024 11:33:22 -0800
Message-ID: <20240223193321.6549-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-7-kerneljasonxing@gmail.com>
References: <20240223102851.83749-7-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:47 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Soon later patches can use these relatively more accurate
> reasons to recognise and find out the cause.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

one nit below.

> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> Link: https://lore.kernel.org/netdev/CANn89i+j55o_1B2SV56n=u=NHukmN_CoRib4VBzpUBVcKRjAMw@mail.gmail.com/
> 1. add reviewed-by tag (David)
> 2. add reviewed-by tag (Eric)
> 
> v7
> Link: https://lore.kernel.org/all/20240219044744.99367-1-kuniyu@amazon.com/
> 1. nit: nit: s/. because of/ because/ (Kuniyuki)
> 
> v5:
> Link: https://lore.kernel.org/netdev/3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org/
> 1. Use new name (TCP_ABORT_ON_DATA) for readability (David)
> 2. change the title of this patch
> ---
>  include/net/dropreason-core.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index a871f061558d..af7c7146219d 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -30,6 +30,7 @@
>  	FN(TCP_AOFAILURE)		\
>  	FN(SOCKET_BACKLOG)		\
>  	FN(TCP_FLAGS)			\
> +	FN(TCP_ABORT_ON_DATA)	\

One more trailing tab ?


>  	FN(TCP_ZEROWINDOW)		\
>  	FN(TCP_OLD_DATA)		\
>  	FN(TCP_OVERWINDOW)		\
> @@ -37,6 +38,7 @@
>  	FN(TCP_RFC7323_PAWS)		\
>  	FN(TCP_OLD_SEQUENCE)		\
>  	FN(TCP_INVALID_SEQUENCE)	\
> +	FN(TCP_INVALID_ACK_SEQUENCE)	\
>  	FN(TCP_RESET)			\
>  	FN(TCP_INVALID_SYN)		\
>  	FN(TCP_CLOSE)			\
> @@ -204,6 +206,11 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_SOCKET_BACKLOG,
>  	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
>  	SKB_DROP_REASON_TCP_FLAGS,
> +	/**
> +	 * @SKB_DROP_REASON_TCP_ABORT_ON_DATA: abort on data, corresponding to
> +	 * LINUX_MIB_TCPABORTONDATA
> +	 */
> +	SKB_DROP_REASON_TCP_ABORT_ON_DATA,
>  	/**
>  	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
>  	 * see LINUX_MIB_TCPZEROWINDOWDROP
> @@ -228,13 +235,19 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_TCP_OFOMERGE,
>  	/**
>  	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
> -	 * LINUX_MIB_PAWSESTABREJECTED
> +	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
>  	 */
>  	SKB_DROP_REASON_TCP_RFC7323_PAWS,
>  	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
>  	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
>  	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
>  	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
> +	/**
> +	 * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
> +	 * field because ack sequence is not in the window between snd_una
> +	 * and snd_nxt
> +	 */
> +	SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE,
>  	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
>  	SKB_DROP_REASON_TCP_RESET,
>  	/**
> -- 
> 2.37.3


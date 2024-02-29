Return-Path: <netdev+bounces-76077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5287C86C35E
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AFA1F217FD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F44DA0C;
	Thu, 29 Feb 2024 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mlm+Gzuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72699481AC
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194918; cv=none; b=MooODU3abbJQDcQ6nrVZHI10ysTuZzI7Atl5HWsc0fpV8j8fS3FTLNi8mLJk4W3KdDvZ0DeTNmoQz9GmaNIIZrYrpmiyYk4kTRVu822ZG8kzZTa5H0WhL/yB7XIn6HQf1JWCS0MiYT1CjpghTF9sN928EVZZS+uHPGrdYR0xK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194918; c=relaxed/simple;
	bh=ywzIhkmfztXXp75uTeorwbVzMD9NZPsL/unvyPsv24o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk4fOK1gxHZKP7z3vUEY9pcZtMUERIb6roDuVmKa5chD9ZSLFgU/2ejtoDFf/WhvArdE7CVwIomNv9veFDJ2G320ZBWI5yFzHAWeV6kusByITgS+0UCHie7HHfExqqUdQioU9QbMMkttDoQhXbJqPEHweiCaOT8b1GaMKTacZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mlm+Gzuw; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709194917; x=1740730917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8j8cxhENPtswZLOD+sXROv7peiZ8zOWCWh2d1Qyfok=;
  b=mlm+Gzuw4llKRNGn+UDChkHgAr7VeXuOsh/nmQn9tMKfz/PBqHbTDYf7
   NC3fTJEDcMsYCsiXcwKpLB7O/Lz6a0iutTUEx9rXuU1VqnUc1d5klECv/
   rZDbSoCJgmmNSOXgmqAUN08IO+KVydmka0F5i3FoM4VSpS/IwmuJl62Ov
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,192,1705363200"; 
   d="scan'208";a="400511047"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:21:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:4749]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.31:2525] with esmtp (Farcaster)
 id 05250a8c-0306-49a5-8940-8640dff5f501; Thu, 29 Feb 2024 08:21:50 +0000 (UTC)
X-Farcaster-Flow-ID: 05250a8c-0306-49a5-8940-8640dff5f501
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 08:21:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 29 Feb 2024 08:21:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bazsi77@gmail.com>
CC: <balazs.scheidler@axoflow.com>, <netdev@vger.kernel.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Thu, 29 Feb 2024 00:21:38 -0800
Message-ID: <20240229082138.81685-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b9b8f2ee80038707f2f237c4910c46e1cbed82cd.1709191570.git.balazs.scheidler@axoflow.com>
References: <b9b8f2ee80038707f2f237c4910c46e1cbed82cd.1709191570.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Balazs Scheidler <bazsi77@gmail.com>
Date: Thu, 29 Feb 2024 08:37:59 +0100
> This patch moves TP_STORE_ADDR_PORTS_SKB() to a common header and removes
> the TCP specific implementation details.
> 
> Previously the macro assumed the skb passed as an argument is a
> TCP packet, the implementation now uses an argument to the L3 header and

nit: s/L3/L4/


> uses that to extract the source/destination ports, which happen
> to be named the same in "struct tcphdr" and "struct udphdr"
> 
> Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
> ---
>  include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
>  include/trace/events/tcp.h              | 45 ++-----------------------
>  2 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
> index 3930119cab08..50c083b5687d 100644
> --- a/include/trace/events/net_probe_common.h
> +++ b/include/trace/events/net_probe_common.h
> @@ -41,4 +41,45 @@
>  
>  #endif
>  
> +#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)		\
> +	do {								\
> +		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
> +									\
> +		v4->sin_family = AF_INET;				\
> +		v4->sin_port = protoh->source;				\
> +		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
> +		v4 = (void *)__entry->daddr;				\
> +		v4->sin_family = AF_INET;				\
> +		v4->sin_port = protoh->dest;				\
> +		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
> +	} while (0)
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +
> +#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)			\
> +	do {								\
> +		const struct iphdr *iph = ip_hdr(skb);			\
> +									\
> +		if (iph->version == 6) {				\
> +			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
> +									\
> +			v6->sin6_family = AF_INET6;			\
> +			v6->sin6_port = protoh->source;			\
> +			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
> +			v6 = (void *)__entry->daddr;			\
> +			v6->sin6_family = AF_INET6;			\
> +			v6->sin6_port = protoh->dest;			\
> +			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
> +		} else							\
> +			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh); \
> +	} while (0)
> +
> +#else
> +
> +#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)		\
> +	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)
> +
> +#endif
> +
> +
>  #endif
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 7b1ddffa3dfc..717f74454c17 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -295,48 +295,6 @@ TRACE_EVENT(tcp_probe,
>  		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
>  );
>  
> -#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
> -	do {								\
> -		const struct tcphdr *th = (const struct tcphdr *)skb->data; \
> -		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
> -									\
> -		v4->sin_family = AF_INET;				\
> -		v4->sin_port = th->source;				\
> -		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
> -		v4 = (void *)__entry->daddr;				\
> -		v4->sin_family = AF_INET;				\
> -		v4->sin_port = th->dest;				\
> -		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
> -	} while (0)
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -
> -#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)				\
> -	do {								\
> -		const struct iphdr *iph = ip_hdr(skb);			\
> -									\
> -		if (iph->version == 6) {				\
> -			const struct tcphdr *th = (const struct tcphdr *)skb->data; \
> -			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
> -									\
> -			v6->sin6_family = AF_INET6;			\
> -			v6->sin6_port = th->source;			\
> -			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
> -			v6 = (void *)__entry->daddr;			\
> -			v6->sin6_family = AF_INET6;			\
> -			v6->sin6_port = th->dest;			\
> -			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
> -		} else							\
> -			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb);	\
> -	} while (0)
> -
> -#else
> -
> -#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)		\
> -	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)
> -
> -#endif
> -
>  /*
>   * tcp event with only skb
>   */
> @@ -353,12 +311,13 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
>  	),
>  
>  	TP_fast_assign(
> +		const struct tcphdr *th = (const struct tcphdr *)skb->data;
>  		__entry->skbaddr = skb;
>  
>  		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
>  		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
>  
> -		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
> +		TP_STORE_ADDR_PORTS_SKB(__entry, skb, th);
>  	),
>  
>  	TP_printk("src=%pISpc dest=%pISpc", __entry->saddr, __entry->daddr)
> -- 
> 2.40.1



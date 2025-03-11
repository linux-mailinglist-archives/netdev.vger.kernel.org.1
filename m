Return-Path: <netdev+bounces-173741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB258A5B8AA
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07F3AF12D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D751EF087;
	Tue, 11 Mar 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ArRODxbJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B81E7C2F
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672219; cv=none; b=qdrdMCi6nPM8Ds14Q2IB6QoY/t5cKdKu4loTx0VXG12LsrrtrK2VkV+ywkgyEA/FvuBiWTAgKFOG0M3XG7Ns/Wdqvwh8LBGQ9+Xzgs+GPW8HYgvmSEIEVSQO7HO1jk7A8WDs0SyUSai64RAGP3ODjRfsWTdmm8vChHtgdDa/6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672219; c=relaxed/simple;
	bh=P+4C5FSaKRDpQHmjAg5rSVWOc0yjYnW7e4MbeYT5rb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoO+AIYM81FRrejuws1GiYpxDqAMpnEAi/ztOO39TfgZXEyOFWcrHUs4rupixvuSkaalOpAIXHCgmlWqWbBS/haulCiaYIV+DZEz123MK3C6HUBCYCLJud+4FoRvKCog2Ws870IXrRqPTtpr9xQsu4huFHTA/cMW/ag+m7ERaX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ArRODxbJ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741672217; x=1773208217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbmomUF0fspPQk4vDbBJj//YBKQZdGu3rL16GwUh1Ik=;
  b=ArRODxbJZkXOBjgYgRWe3DF0hBAiUpVWQ64xs/3UUUhiwSPBcxluskBO
   N8x2F6s7TwyYIEm1Cvuyv/QPFETyLhXkLDfTSihCsD9jDWZZDJ+1OiY8W
   Ng7yX5eLFSWY+kCKPQKIHUk6iQCJ3NMvElL0KKB5vTp7A7LGJYTIDTdCR
   4=;
X-IronPort-AV: E=Sophos;i="6.14,238,1736812800"; 
   d="scan'208";a="703966445"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 05:50:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:50259]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id 87b05a20-2865-43a8-bd6e-e8a21ee3b8e5; Tue, 11 Mar 2025 05:50:12 +0000 (UTC)
X-Farcaster-Flow-ID: 87b05a20-2865-43a8-bd6e-e8a21ee3b8e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 05:50:07 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.128.133) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Mar 2025 05:50:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 net-next 2/2] udp_tunnel: use static call for GRO hooks when possible
Date: Mon, 10 Mar 2025 22:49:41 -0700
Message-ID: <20250311054957.81048-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b65c13770225f4a655657373f5ad90bcef3f57c9.1741632298.git.pabeni@redhat.com>
References: <b65c13770225f4a655657373f5ad90bcef3f57c9.1741632298.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 10 Mar 2025 20:09:49 +0100
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 054d4d4a8927f..500b2a20053cd 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -15,6 +15,39 @@
>  #include <net/udp_tunnel.h>
>  
>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +
> +/*
> + * Dummy GRO tunnel callback; should never be invoked, exists
> + * mainly to avoid dangling/NULL values for the udp tunnel
> + * static call.
> + */
> +static struct sk_buff *dummy_gro_rcv(struct sock *sk,
> +				     struct list_head *head,
> +				     struct sk_buff *skb)
> +{
> +	WARN_ON_ONCE(1);
> +	NAPI_GRO_CB(skb)->flush = 1;
> +	return NULL;
> +}
> +
> +typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
> +						struct list_head *head,
> +						struct sk_buff *skb);
> +
> +struct udp_tunnel_type_entry {
> +	udp_tunnel_gro_rcv_t gro_receive;
> +	refcount_t count;
> +};
> +
> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
> +			      IS_ENABLED(CONFIG_FOE) * 2)

I guess this is CONFIG_NET_FOU ?


Return-Path: <netdev+bounces-118633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9E9524D0
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769C61C21003
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61261C4607;
	Wed, 14 Aug 2024 21:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BB1BF309
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671116; cv=none; b=oSbTFTMQ9Mg5+9iKMg74a6wh8vnhjaDauRWQpzzk0GTe2B4sT4kDBeKHaEO5pINyFkQ0MhBN0orAfrBUQUkX64BF1D67XovKAB+yDj4LSkXMCk5fx1FU402sxX4ryMcIKbJOX9+UoC6bmsn9anWva42MiTHbv03fOU8eAQd/FP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671116; c=relaxed/simple;
	bh=xfEBLG4z8nZQGFB1Jw+jIczsBqp+PVT9lc1UGJEzzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZsY6CqpMV00nBzzlIKV5lgNhXP7rh4Fm/+WTH9t/K3tlI35ZVx1bfU0Ib9SkYzEYZu0fIXWeQp6Fm2eoksTlrlzBBtZvKPRiEj+7hpIIgJeVGTziPUdbw6Y84cQLMxtlQgS5qPUkkUeZ6D3BIiXRAuKIQH4/QHU3Bt+eAh0ljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-pmh1yFBwNIyWfEv750N8oA-1; Wed,
 14 Aug 2024 17:30:31 -0400
X-MC-Unique: pmh1yFBwNIyWfEv750N8oA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3997718EB234;
	Wed, 14 Aug 2024 21:30:28 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C94F196BE80;
	Wed, 14 Aug 2024 21:30:19 +0000 (UTC)
Date: Wed, 14 Aug 2024 23:30:17 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when
 TCP over IPv4 via INET6 API
Message-ID: <Zr0h6a_ExRhw8Mxh@hog>
References: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

2024-08-14, 16:45:04 +0800, Feng zhou wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78a6f746ea0b..9798537044be 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5399,7 +5399,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>  			  char *optval, int *optlen,
>  			  bool getopt)
>  {
> -	if (sk->sk_family != AF_INET)
> +	if (sk->sk_family != AF_INET && !is_tcp_sock_ipv6_mapped(sk))
>  		return -EINVAL;

I don't think this works when CONFIG_IPV6=m, because then
is_tcp_sock_ipv6_mapped will be part of the module and not usable in
net/core/filter.c. Stuff like this is usually done through ipv6_stub.

-- 
Sabrina



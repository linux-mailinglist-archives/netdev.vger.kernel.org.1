Return-Path: <netdev+bounces-135371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F054999DA0D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7651828284C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7C158D87;
	Mon, 14 Oct 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZNAQWTjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57617BD3
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947971; cv=none; b=lMVtI47H3zsr5HVG3VH0NORwihEcHdaf6ZgwVRd2HqlYIznk1jfQh2XkLL0v2dgMMeJUyrWPLq4UhpGrb1aDRst6lDfPCGQcjUoN9Li/hU0K6m/qcPRLi8DYPeFmVlX1hELE5yHFgz/HYOXtL/Bi9YmRq3/jdzcagZ90jC45UFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947971; c=relaxed/simple;
	bh=pzhiY2KHf3yZTqrf8a8iaaGMCnzyLarAQH9I9MXfSdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZpR3iYEW8pPFHoQsGNoyDBXlXhi4WYZocFeMJ+hbVsr2kX8623FKo0Vb6ruMKZ9eCG+HY7JyXWS02r4xj1hnl4JTo/fPjiSSe+ynSA853kt/P2QHsfOyFDpQRFz4IRmcluNTV4dsJTPI0KH+5TcKKv+miCjejC2SzTmhMd9Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZNAQWTjY; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728947970; x=1760483970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WcKJtmBuQ4AVLTAanVxc3iSs169+KQCSpyXgRfJHfl8=;
  b=ZNAQWTjYxj8hhJCPXA312Gsx2boovMdpIPOu5czbMVKfLoHCfgl10vXW
   S6xmE12MxgNBxaXi+pHtSVE4B8rnABCWDBe+wjigFnlIDuIk+EKop/z1+
   m+sW2sXTKSFzi8uuolZ4zyeKe879Uzn1ymI1TI5VR/SsIkcyQa8OAccXN
   U=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766535771"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:19:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:4639]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 1379f84f-402a-4616-8ebe-f32420831282; Mon, 14 Oct 2024 23:19:24 +0000 (UTC)
X-Farcaster-Flow-ID: 1379f84f-402a-4616-8ebe-f32420831282
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 23:19:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 23:19:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gilad@naaman.io>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] Create netdev->neighbour association
Date: Mon, 14 Oct 2024 16:19:17 -0700
Message-ID: <20241014231917.7858-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010120139.2856603-3-gnaaman@drivenets.com>
References: <20241010120139.2856603-3-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Thu, 10 Oct 2024 12:01:25 +0000
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 1b018ac35e9a..889501a16da2 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -186,4 +186,5 @@ struct dpll_pin*                    dpll_pin
>  struct hlist_head                   page_pools
>  struct dim_irq_moder*               irq_moder
>  u64                                 max_pacing_offload_horizon
> +struct hlist_head                   neighbours[3]

I think 2 should be enough as DECnet was removed two years ago.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1202cdd66531

MPLS also does not support DECnet via RTA_VIA, see nla_get_via().


[...]
> +static int family_to_neightbl_index(int family)
> +{
> +	switch (family) {
> +	case AF_INET:
> +		return NEIGH_ARP_TABLE;
> +	case AF_INET6:
> +		return NEIGH_ND_TABLE;
> +	case AF_DECnet:
> +		return NEIGH_DN_TABLE;
> +	default:
> +		return -1;

AF_DECnet should be unnecessary here and let default warn about it.

	case default:
		DEBUG_NET_WARN_ON_ONCE(1);
		return 0; /* to avoid panic by null-ptr-deref */


[...]
> +static void neigh_flush_dev_fast(struct neigh_table *tbl,
> +				 struct hlist_head *head,
> +				 bool skip_perm)
> +{
> +	struct neighbour *n, *next;
> +
> +	neigh_dev_for_each_safe_rcu_protected(n, next, head,
> +					      lockdep_is_held(&tbl->lock)) {
> +		if (skip_perm && n->nud_state & NUD_PERMANENT)
> +			continue;
> +
> +		_neigh_flush_free_neigh(n);
> +	}
> +}
> +
>  static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  			    bool skip_perm)
>  {
>  	int i;
>  	struct neigh_hash_table *nht;
>  
> +	i = family_to_neightbl_index(tbl->family);
> +	if (i != -1) {

No need to handle error, and replace the following for-loop with
the dev-base iteration.


> +		neigh_flush_dev_fast(tbl, &dev->neighbours[i], skip_perm);
> +		return;
> +	}
> +
>  	nht = rcu_dereference_protected(tbl->nht,
>  					lockdep_is_held(&tbl->lock));
>  
[...]
> @@ -701,6 +756,11 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  	if (want_ref)
>  		neigh_hold(n);
>  	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
> +
> +	error = family_to_neightbl_index(tbl->family);
> +	if (error != -1)

Same here.


Return-Path: <netdev+bounces-92818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD588B8F80
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E1028225E
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FF1474BB;
	Wed,  1 May 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F+Uql34A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EF13C90C
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588127; cv=none; b=dUT5cwZhJpRNnL0Eq/ykbXoX92Qjtvp4QugsX4hpOiWElq7h+IjDqBi3c4uc1w4C5ROwdGH2tyfL/0WhQ6a0DqGmLsiYuyz+NG4q1A0S1hC3QD2sHINdMu7A4H/hKZQRmUS/GXVEqcMgpL/Cg4CW4QznZHC8VcmDpn0T8yJcd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588127; c=relaxed/simple;
	bh=TADbG4V9WRHn39XFC7d7nMgta+CYH8L4WeGxa819swM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnlrbVOum75e1bTLyXYJwFF5zCUs1W6kdTWxgvD5MFh1TlsRuyW1DJKHT2ZAsMJ4aDD19sU8uXLGGgHvfIwgmjdaFwxMzQEXrkspIHf0tgBApLLX7NRhem3P9sTlBPhODZ+vbYAycOgPBGI2ytgH2ck6H9Vn8vZQZBIrinpM58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F+Uql34A; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714588126; x=1746124126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7M1EmEqfkyQv+pEzOYF4KbWS5ILHv+dxCHCQvKx8GnI=;
  b=F+Uql34ApZpJ3ejO/kZhmmiT2UmqcK3q+hg3yIzK78MO3tZv4EH/zGkJ
   st8BB2ztgTzpzOAUSZXr6b9JgwFuH0DOJZsxouL76XBoNdcvMUZd5MNwo
   FH1gey3igfJPO2g5E/WagjuHV6b/6xf3AEd4IAUneIef4ndWZpIKIq0D5
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,246,1708387200"; 
   d="scan'208";a="293113956"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 18:28:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:63488]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.73:2525] with esmtp (Farcaster)
 id c7f3b85d-2cbc-40fc-bb0e-7e6da5846c75; Wed, 1 May 2024 18:28:42 +0000 (UTC)
X-Farcaster-Flow-ID: c7f3b85d-2cbc-40fc-bb0e-7e6da5846c75
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 18:28:35 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 18:28:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <cascardo@igalia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kernel-dev@igalia.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH v2] net: fix out-of-bounds access in ops_init
Date: Wed, 1 May 2024 11:28:19 -0700
Message-ID: <20240501182819.34167-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240501151639.3369988-1-cascardo@igalia.com>
References: <20240501151639.3369988-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed,  1 May 2024 12:16:39 -0300
> net_alloc_generic is called by net_alloc, which is called without any
> locking. It reads max_gen_ptrs, which is changed under pernet_ops_rwsem. It
> is read twice, first to allocate an array, then to set s.len, which is
> later used to limit the bounds of the array access.
> 
> It is possible that the array is allocated and another thread is
> registering a new pernet ops, increments max_gen_ptrs, which is then used
> to set s.len with a larger than allocated length for the variable array.
> 
> Fix it by reading max_gen_ptrs only once in net_alloc_generic. If
> max_gen_ptrs is later incremented, it will be caught in net_assign_generic.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Fixes: 073862ba5d24 ("netns: fix net_alloc_generic()")
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

The functional change looks good.

I added small comments.


> ---
>  net/core/net_namespace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index f0540c557515..4a4f0f87ee36 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -70,11 +70,13 @@ DEFINE_COOKIE(net_cookie);
>  static struct net_generic *net_alloc_generic(void)
>  {
>  	struct net_generic *ng;
> -	unsigned int generic_size = offsetof(struct net_generic, ptr[max_gen_ptrs]);
> +	unsigned int generic_size;
> +	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);

Please keep reverse xmas order,
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

	unsigned int gen_ptrs = READ_ONCE(max_gen_ptrs);
	unsigned int generic_size;
  	struct net_generic *ng;

and add newline here.


> +	generic_size = offsetof(struct net_generic, ptr[gen_ptrs]);
>  
>  	ng = kzalloc(generic_size, GFP_KERNEL);
>  	if (ng)
> -		ng->s.len = max_gen_ptrs;
> +		ng->s.len = gen_ptrs;
>  
>  	return ng;
>  }
> @@ -1307,7 +1309,12 @@ static int register_pernet_operations(struct list_head *list,
>  		if (error < 0)
>  			return error;
>  		*ops->id = error;
> -		max_gen_ptrs = max(max_gen_ptrs, *ops->id + 1);
> +		/*
> +		 * This does not require READ_ONCE as writers will take
> +		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
> +		 * net_alloc_generic.
> +		 */

Please use netdev multi-line comment style.
https://docs.kernel.org/process/maintainer-netdev.html#multi-line-comments

		/* This does not require READ_ONCE as writers already hold
		 * pernet_ops_rwsem. But WRITE_ONCE is needed to protect
		 * net_alloc_generic.
		 */

Perhaps s/will take/already hold/ as pernet_ops_rwsem is already held here.

Also, could you repost with the target tree in Subject like [PATCH net v3]
so that patchwork can apply it on net.git and test it properly.
https://patchwork.kernel.org/project/netdevbpf/patch/20240501151639.3369988-1-cascardo@igalia.com/

Thanks!

> +		WRITE_ONCE(max_gen_ptrs, max(max_gen_ptrs, *ops->id + 1));
>  	}
>  	error = __register_pernet_operations(list, ops);
>  	if (error) {
> -- 
> 2.34.1


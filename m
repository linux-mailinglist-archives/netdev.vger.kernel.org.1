Return-Path: <netdev+bounces-137629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449E9A731D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFCE1F21187
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78031D0E2F;
	Mon, 21 Oct 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OE3ayEAj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C531EEE0
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538491; cv=none; b=ufD+VpEH90r6isek+n76/oz8CBfy7xuih1EFiT5t5EP2UGLmrJaWxZ7QoFEtkX2ONuH093CRiDF9PFrtJQf4aem9tzJspgtsraJV/M9gZVbyQV8xnF+jIK8M4K5BqM1eZMttJdAY3X4PAp6PEqhMMWyN+u5Tk/3sV8KDMDQtXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538491; c=relaxed/simple;
	bh=Hd9Lpeqr+zL9J5jdthp8Pyn8PhH4nnpByg83aXJyzy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3+JL2ezRbQYFQ5QUxT7uaJEoA1xoMUw0ZSr3hp0DeXcXjJHradXPSoxBCWiQv9dwjcgENRkiTU6fPaKWpWNG/5IjWXKaI9F/v+wxTtj01QcYaMlfLDPvNOHlgr75Ob3R32Z6q4I3T9JsL7K/3KNucJ8Skdgq5zyhvD4LqrGsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OE3ayEAj; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729538490; x=1761074490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kPxuZLZL6NDpDzDoVG30rr5bkdMNWqJ7zgjYWcKv//M=;
  b=OE3ayEAj8XYMCD7xt9PoMe9caWo+s6CknAbwlMapXgZnUQhfQgJfvo3U
   phxOSHCmNqV2/hFYRJlrC+Ro3K+UfGIb89SmnChDKfyx59lDF1uWkTwyn
   t72gKC6SG91YHw8CDPrgttw/9KfLN0GCrvvz4Pg965vzSDODPJZsvtbDN
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="769014544"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:21:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:25442]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 130f31de-4674-4d3d-a1ae-4629a40f9bbe; Mon, 21 Oct 2024 19:21:20 +0000 (UTC)
X-Farcaster-Flow-ID: 130f31de-4674-4d3d-a1ae-4629a40f9bbe
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 19:21:19 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 19:21:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 4/6] neighbour: Convert iteration to use hlist+macro
Date: Mon, 21 Oct 2024 12:21:14 -0700
Message-ID: <20241021192114.85237-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021102102.2560279-5-gnaaman@drivenets.com>
References: <20241021102102.2560279-5-gnaaman@drivenets.com>
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

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon, 21 Oct 2024 10:20:56 +0000
> @@ -3146,18 +3135,18 @@ EXPORT_SYMBOL(neigh_for_each);
>  void __neigh_for_each_release(struct neigh_table *tbl,
>  			      int (*cb)(struct neighbour *))
>  {
> -	int chain;
>  	struct neigh_hash_table *nht;
> +	int chain;
>  
>  	nht = rcu_dereference_protected(tbl->nht,
>  					lockdep_is_held(&tbl->lock));
>  	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
>  		struct neighbour *n;
> +		struct hlist_node *tmp;
>  		struct neighbour __rcu **np;

nit: Reverse xmas order

>  
>  		np = &nht->hash_buckets[chain];
> -		while ((n = rcu_dereference_protected(*np,
> -					lockdep_is_held(&tbl->lock))) != NULL) {
> +		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
>  			int release;
>  
>  			write_lock(&n->lock);


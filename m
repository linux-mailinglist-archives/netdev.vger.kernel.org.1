Return-Path: <netdev+bounces-135905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E499FBBA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C692C283A99
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C481B0F1D;
	Tue, 15 Oct 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WExCpSnd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A82146A9B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 22:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032611; cv=none; b=BdSPT3Q8VAtPPFVhYnl6iUqsyyIPxmPnrQXUOVpg8XJzqa4QhpfesOjmvCmSedfTca+xPuAN0a4gv3E+YFv8UK/tIZJAjoGCKUjBqy/Oz7ALJQV60t5Gti78EDN7mSEK978EVqyg8nwNBL3zd5O1/bRo52SGnZILP9ayOpKE0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032611; c=relaxed/simple;
	bh=VNCuWU0HqA5n/81+4GrsgERgsjUDkBUQVw4NYjtaZOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN3shxDEv4hXvjWZK6xGsCNXqG4CPwiFmzKf6BEmGRAs34rzOaTyfWMvrpAMgxmn43HkzQH5VGiq4xIAunL7YkVuiIecWEBzqUsn2mR3SzkAKyxtfwrIKIta86nEaAka+IgUfxrcEnlVZVoCzPk8qD9aL03v1PJrqvSumCAiwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WExCpSnd; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729032609; x=1760568609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9wy9Z76PFDQQRGVzsoxvB9UOmWjIcRqmyQPNolJ9M8=;
  b=WExCpSndJDMVky4Q0NR3/s/G+KgLjYEk+wEUdQlXeAbvDHwhMsmvzGTc
   X8HdNaoCVULj0ZvC+7tgpQPGcWQK9YyuFVmpcTHbZhBnPlbaZBSihfsml
   ACkEN99oJ59/G1OnzGfrxp4RuqT8K+7v3iodgsFiRO4Zrjj364AkDwmp3
   o=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="431749836"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 22:50:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:8396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id f80a93eb-0f49-4855-bf2d-bb4f73007ac4; Tue, 15 Oct 2024 22:50:05 +0000 (UTC)
X-Farcaster-Flow-ID: f80a93eb-0f49-4855-bf2d-bb4f73007ac4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 22:50:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 22:50:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/6] Add hlist_node to struct neighbour
Date: Tue, 15 Oct 2024 15:49:58 -0700
Message-ID: <20241015224958.64713-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015165929.3203216-2-gnaaman@drivenets.com>
References: <20241015165929.3203216-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue, 15 Oct 2024 16:59:21 +0000
> @@ -531,7 +533,9 @@ static void neigh_get_hash_rnd(u32 *x)
>  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  {
>  	size_t size = (1 << shift) * sizeof(struct neighbour *);
> +	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
>  	struct neigh_hash_table *ret;
> +	struct hlist_head *hash_heads;
>  	struct neighbour __rcu **buckets;
>  	int i;

nit:

While at it, please sort variables in reverse xmas tree order.
Same for other places.

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>  
> @@ -540,17 +544,28 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  		return NULL;
>  	if (size <= PAGE_SIZE) {
>  		buckets = kzalloc(size, GFP_ATOMIC);
> +		hash_heads = kzalloc(hash_heads_size, GFP_ATOMIC);
> +		if (!hash_heads)
> +			kfree(buckets);
>  	} else {
>  		buckets = (struct neighbour __rcu **)
>  			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>  					   get_order(size));
>  		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
> +
> +		hash_heads = (struct hlist_head *)
> +			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
> +					   get_order(hash_heads_size));
> +		kmemleak_alloc(hash_heads, hash_heads_size, 1, GFP_ATOMIC);
> +		if (!hash_heads)
> +			free_pages((unsigned long)buckets, get_order(size));
>  	}
> -	if (!buckets) {
> +	if (!buckets || !hash_heads) {
>  		kfree(ret);
>  		return NULL;

If buckets is NULL and hash_heads isn't, hash_heads is leaked.


>  	}
>  	ret->hash_buckets = buckets;
> +	ret->hash_heads = hash_heads;
>  	ret->hash_shift = shift;
>  	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
>  		neigh_get_hash_rnd(&ret->hash_rnd[i]);


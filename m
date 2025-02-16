Return-Path: <netdev+bounces-166823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00724A37712
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CBB3A27C5
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA719D881;
	Sun, 16 Feb 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v1SRTl9Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A419ABC2;
	Sun, 16 Feb 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732835; cv=none; b=dL0FKMnELNPBepIV9mRKVHwQBi3s1l3DxzhXFMGNWwZOHY2LOZWV8oMAHoYQIxnzAzgEhy0rZw1Xffzu8lhnHXinyjXhTNa2bQPyWyll359eK6ECZBFZvIfdEhm7AqKE+OeFBTizMBFwjdgjhMwHl1spyj8sSZWH+wZsHVLjlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732835; c=relaxed/simple;
	bh=WdUtfn83UKbZ9F3tMqRb3yyPvHLmUxE1jmeVFo4QYvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU0xlJOzZHXZ7NNFFOtWpxJP6Ade1M0D0UdA4ffuCBlg5tvpqf9S8pRcA5GZDgJFJ6lu30f5gWYvLpHVoBhA33Ja2tQtKAylQzHdHO2lIAGJrf7T/1n/UI5xnL/zuBddApcBLItf8gEnCVQZzlja594P7QDYrg+OURknDEfGzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v1SRTl9Q; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739732834; x=1771268834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ot3sZW9m1KrcwT8em5+cF0/58aAY/1r9ugZxy8yla4I=;
  b=v1SRTl9QMiJx/2xYox3TG1048MIPxt3ZUiqL2yB89H3o8MxaU7lDQIqj
   QY04l5OrIwDTlKa4YBPOxNp/b2N/hWj80RES2FcamR4WeExIGG1LvxFKj
   cbhzJvaXuwaknGktGMcLE23r8c1/Ln0JiDZ3A+a6hYAP1nLKSac7XbTrn
   w=;
X-IronPort-AV: E=Sophos;i="6.13,291,1732579200"; 
   d="scan'208";a="463041476"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 19:07:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:60624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525] with esmtp (Farcaster)
 id 57c8e7c4-aa7c-48b3-b74c-a9a298df9c11; Sun, 16 Feb 2025 19:07:09 +0000 (UTC)
X-Farcaster-Flow-ID: 57c8e7c4-aa7c-48b3-b74c-a9a298df9c11
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 16 Feb 2025 19:07:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.131) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Feb 2025 19:06:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <enjuk@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gnaaman@drivenets.com>,
	<horms@kernel.org>, <joel.granados@kernel.org>, <kohei.enju@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<lizetao1@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
Date: Sun, 16 Feb 2025 11:06:42 -0800
Message-ID: <20250216190642.31169-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250216163016.57444-1-enjuk@amazon.com>
References: <20250216163016.57444-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kohei Enju <enjuk@amazon.com>
Date: Mon, 17 Feb 2025 01:30:16 +0900
> Replace kvzalloc()/kvfree() with kzalloc()/kfree() when GFP_ATOMIC is
> specified, since kvzalloc() doesn't support non-sleeping allocations such
> as GFP_ATOMIC.
> 
> With incompatible gfp flags, kvzalloc() never falls back to the vmalloc
> path and returns immediately after the kmalloc path fails.
> Therefore, using kzalloc() is sufficient in this case.
> 
> Fixes: 41b3caa7c076 ("neighbour: Add hlist_node to struct neighbour")

This commit followed the old hash_buckets allocation, so I'd add

  Fixes: ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()")

too.

Both commits were introduced in v6.13, so there's no difference in terms
of backporting though.

Also, it would be nice to CC mm maintainers in case they have some
comments.


> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>  net/core/neighbour.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d8dd686b5287..344c9cd168ec 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -518,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  	if (!ret)
>  		return NULL;
>  
> -	hash_heads = kvzalloc(size, GFP_ATOMIC);
> +	hash_heads = kzalloc(size, GFP_ATOMIC);
>  	if (!hash_heads) {
>  		kfree(ret);
>  		return NULL;
> @@ -536,7 +536,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>  						    struct neigh_hash_table,
>  						    rcu);
>  
> -	kvfree(nht->hash_heads);
> +	kfree(nht->hash_heads);
>  	kfree(nht);
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)


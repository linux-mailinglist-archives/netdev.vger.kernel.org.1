Return-Path: <netdev+bounces-135912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F299FC87
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2248E282EC6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5C1D63E7;
	Tue, 15 Oct 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UIHPTiBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53321E3D8
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035543; cv=none; b=Zt2Fv5WJ6aj/58rUpkkIje5+mIpsVvKfqJJdzGNj/x6qlDCN4CM02iEoVnsaYJylI7CmW445dGD4XMerCpmQerI5vi7GLEkglRX1w4BSK7pxO/KYUQhzuu05iaqQhjkBR3xpi8Xh0PdmR+UTes97RmtuzYThplRajokfXOUxJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035543; c=relaxed/simple;
	bh=cZ5lDKAdRo8zkryOq3f33RCjNa7zFkn6RfUk80viQkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hfh74PhVdOmY2neWb1a0s2OYuEseX/HMPabztzLAzPI4XJRpx4nWF+kJHcpBHqU0LnKarKpNvV6RMktWooSes7cCkC1mZrTw1VXWpiS1IriB+XQ8qbWthKsRB1O1E1wHEsIbLJVj2ZEqE9zZKc1SWacxpJL7LPL6od0OEI6anX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UIHPTiBf; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729035543; x=1760571543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydixF+4y0pxuCRQ5eqM2xdHC35AOsrmJ5zu6A2zjyLk=;
  b=UIHPTiBfCt4D1dwekpC2dcQMpCJ+4i46aFeuI1aDSA01qfbQ/5X0QyQI
   wqrJvrnC4ZO08tZXAsyU9u6EZ2TmkYOshW6EIEegzhd227NFeA+i3rEdy
   LCc4IGQWYBYsj0hAhxX5WZPbNMxbYnX96XeeCb6xOFAlJkaaiNzV0PTHn
   w=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="666459263"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:38:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:38410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 1e7d3980-ebac-4593-9251-e0a9acf17c99; Tue, 15 Oct 2024 23:38:58 +0000 (UTC)
X-Farcaster-Flow-ID: 1e7d3980-ebac-4593-9251-e0a9acf17c99
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 23:38:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 23:38:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 4/6] Convert neighbour iteration to use hlist+macro
Date: Tue, 15 Oct 2024 16:38:51 -0700
Message-ID: <20241015233851.68607-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015165929.3203216-5-gnaaman@drivenets.com>
References: <20241015165929.3203216-5-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue, 15 Oct 2024 16:59:24 +0000
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 4bdf7649ca57..cca524a55c97 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -391,8 +391,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  		struct neighbour *n;
>  		struct neighbour __rcu **np = &nht->hash_buckets[i];
>  
> -		while ((n = rcu_dereference_protected(*np,
> -					lockdep_is_held(&tbl->lock))) != NULL) {
> +		neigh_for_each(n, &nht->hash_heads[i]) {
>  			if (dev && n->dev != dev) {
>  				np = &n->next;
>  				continue;
> @@ -427,6 +426,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
>  					n->nud_state = NUD_NONE;
>  				neigh_dbg(2, "neigh %p is stray\n", n);
>  			}
> +			np = &n->next;
>  			write_unlock(&n->lock);
>  			neigh_cleanup_and_release(n);
>  		}

Is this chunk necessary ?


> @@ -976,6 +970,7 @@ static void neigh_periodic_work(struct work_struct *work)
>  {
>  	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
>  	struct neighbour *n;
> +	struct hlist_node *tmp;
>  	struct neighbour __rcu **np;
>  	unsigned int i;
>  	struct neigh_hash_table *nht;

nit: let's sort variables in reverse xmas tree order.



> @@ -3124,11 +3117,11 @@ void __neigh_for_each_release(struct neigh_table *tbl,
>  					lockdep_is_held(&tbl->lock));
>  	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
>  		struct neighbour *n;
> +		struct hlist_node *tmp;
>  		struct neighbour __rcu **np;

nit: reverse xmas tree order.


>  
>  		np = &nht->hash_buckets[chain];
> -		while ((n = rcu_dereference_protected(*np,
> -					lockdep_is_held(&tbl->lock))) != NULL) {
> +		neigh_for_each_safe(n, tmp, &nht->hash_heads[chain]) {
>  			int release;
>  
>  			write_lock(&n->lock);
> -- 
> 2.46.0


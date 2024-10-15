Return-Path: <netdev+bounces-135906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388099FBD0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BC41F24588
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302381C75F9;
	Tue, 15 Oct 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ezkXn0/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F1B0F0D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033046; cv=none; b=IGeEGthu4R6/oxciYVc1ABg8sUrkRzVo0f6RpFLD8TAp++PtdbfbwBO/5IHjgw7vhR/6l0SgRKxNGxKI8JRA4KIh9Lik/OOU660m13M+ZLy13F8NrKzkkFGsTxS7lmv0tV22PIRls7RVEgE83zaEFv5n2+hHM1EAfnDab953uEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033046; c=relaxed/simple;
	bh=oaFMD0zyu6v2sI+9/C9CY/4hE+2C0FbwvdT/PZbM3KM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt6CZhuXTHtpZceTnGo3rpBYgcVoiN06QCcH6Sbu3gPjnQLGNxJXZszdLHpurLxitLH+I7MZpFU3sx0xk7SBMhestjoejSiULHx/WLuNhiqUp95u9sYtEaRliXaD507NUHlPrB81iMjjsK0MgnY+p77+5TO33Uwxhtt7oCd82vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ezkXn0/7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729033045; x=1760569045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7GDakXneB9TswFUeTbGDt34x1LEZAjuRjZbpesFPj0=;
  b=ezkXn0/7/TKsylWDWHntHao0f8bWKGVceSwyMgM7NUoLYAX5eHBND5wj
   nKKxL82xhF4WUB5myivl8jY8oa0xT87YVg5biICVPg5aVvpO7yh4OESr9
   5GZaGveoF/CIot6g1CjSQsNCZHoXaDllgGHXjU27DymuzBLZwdfhFz7sv
   g=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="239588031"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 22:57:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:50478]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 82cabe9a-5cd7-404a-9562-0ebe506999f3; Tue, 15 Oct 2024 22:57:20 +0000 (UTC)
X-Farcaster-Flow-ID: 82cabe9a-5cd7-404a-9562-0ebe506999f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 15 Oct 2024 22:57:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 15 Oct 2024 22:57:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/6] Define neigh_for_each
Date: Tue, 15 Oct 2024 15:57:12 -0700
Message-ID: <20241015225712.65071-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241015165929.3203216-3-gnaaman@drivenets.com>
References: <20241015165929.3203216-3-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Tue, 15 Oct 2024 16:59:22 +0000
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index 800dfb64ec83..0bb46aba2502 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -3006,6 +3006,27 @@ static void mlxsw_sp_neigh_rif_made_sync_each(struct neighbour *n, void *data)
>  		rms->err = -ENOMEM;
>  }
>  
> +static void mlxsw_sp_neigh_for_each(struct neigh_table *tbl,
> +				    void (*cb)(struct neighbour *, void *),

The function pointer is no longer needed as cb() is always
mlxsw_sp_neigh_rif_made_sync_each().

Also, please CC this driver's maintainers next time.

  git show --format=email | ./scripts/get_maintainer.pl


> +				    void *cookie)
> +{
> +	int chain;
> +	struct neigh_hash_table *nht;

nit: reverse xmas tree order.


> +
> +	rcu_read_lock();
> +	nht = rcu_dereference(tbl->nht);
> +
> +	read_lock_bh(&tbl->lock); /* avoid resizes */
> +	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
> +		struct neighbour *n;
> +
> +		neigh_for_each(n, &nht->hash_heads[chain])
> +			cb(n, cookie);

This can be a direct call.


> +	}
> +	read_unlock_bh(&tbl->lock);
> +	rcu_read_unlock();
> +}
> +
>  static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
>  					struct mlxsw_sp_rif *rif)
>  {
> @@ -3014,12 +3035,12 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
>  		.rif = rif,
>  	};
>  
> -	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
> +	mlxsw_sp_neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
>  	if (rms.err)
>  		goto err_arp;
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -	neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
> +	mlxsw_sp_neigh_for_each(&nd_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
>  #endif
>  	if (rms.err)
>  		goto err_nd;


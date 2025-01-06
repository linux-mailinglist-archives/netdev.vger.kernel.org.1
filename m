Return-Path: <netdev+bounces-155519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD11A02E25
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733AC1881C11
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF001DF265;
	Mon,  6 Jan 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGLn5p19"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE371DF255
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181904; cv=none; b=AAu5ZNPSSz/3MSqfz15aXSOZT34Hie//pJNhB/Rz7NXQyN3BUJnw1OEGU3EwGkl4HgC6wGh3yNv5/+v8C1sFpyHOSKZudahHUo4mFbUot/Duy/4Z0HweRxwlckZW+IymLkjyBo2jZzHFKI0Xx3lWWYIGRSzSlldqfBwqQ0lgyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181904; c=relaxed/simple;
	bh=res9AtqeHUv6BWQ00KeyDhCcz/+OWS8UdiSCcVJdVfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4XE5BTZRcR/D5zSPcsfzuIyOYR6JrpgXLKGm1+lkxHqo1lpghxhlv+p1mJdM+XggwMl9vbZs9kxoy62lcpbViwn5uokHWFIuQ+6FHJTlzT5uasC/rdZ4eh6DSiLu8zY9pmSkgoSFBTGTwvZ9QJASuchNiII5KUcYaJhQhpEvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGLn5p19; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216395e151bso153011955ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736181902; x=1736786702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zubiZlnMiNFiSRKQJphn36UvQ6LNwhYb3cisfKEEzUM=;
        b=DGLn5p198hl8TiNjUht5JZeXzmTnSXlJccnW15YQoft1uSocTo9inJf32yPRR3316e
         56uDoW76krRB5LBgVEx7Z96sDAOhc3AHf9RHN+iliDx6Zm/MI0/XV+ZyUYyzn0BAIzF+
         t4xFqTXDhnBPGV/Umvp6kzFdLPoAxsfOkFtoX53DARnMG1AYooZRhKWzZ7o3YHejoBxi
         fKfJ3NbyJWy7KHAp6rucjyQZoT1BXP0K5izKQZvhOYYwZT2fcfkyLmWUxv//Mrms8hGY
         m0pmQaR/eKj6/OsEMAObtqdhP2m256bJ8WbPtQ1YiRjFE1coGjV0E1MOf3xdX6QCOdiq
         20lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736181902; x=1736786702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zubiZlnMiNFiSRKQJphn36UvQ6LNwhYb3cisfKEEzUM=;
        b=Ovju6VZ3Eg7PRgitKBrGJJdhUWQZ44FqAqyjXoVqN5ua4Q4FGDoqlQnouw3I6I4nLh
         UyecMxDlk+YrjuOqDozY8xUh4sE4XamIg/NoX6Hx2eSChNqKT+2ez9BWb9gV/x3n29hs
         FJvdlFg9ICCJZihM+Y9r3Sqs/DbRryt4j0rcEqAbmmlqC462MrK5Y3MHNzmoeYmMQiSZ
         jDfwq3W1tGuM7z+8wpJMlnrrohTNZQ30fX7Gcp0KCArZieXONaeplsvIS8zVdelXFi0o
         PVcyt3pK4u5NpB6Wpklu8mfrXdDdRpE42TGV1dVO+riIsCWtZl/bVtWKQK/XwAtiiWb4
         qfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWuQ/NLoYYmBFB8X2m230ia6vXqEpL6S4s1BFP5J9qluKEa3FdjfC8CTis3H8jhITyzucsuoKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjChfDVzubNBCIfTLz46DPiqvby+mPcZH6b/Ops7yVQSWKNzE
	QIpllo4oOTjxjpJ0vVhW1MzmoJS0fw/hg6BQ+tNoKvsuGSel09M=
X-Gm-Gg: ASbGncs0hABe5hdvMZfULmAjDhAiRPwEDHneHahUMBLD2zDg/MBauVPm+9n2TxhvvLx
	52AHSiujSCfT3i6YORJHKaLtGexsp3HKt76MOJGaJoBR/iMDX77eyc3suGIfUNbxRiwswhXM9SQ
	DzzGQ48rkAros1n87L/8i9vhfKP3d0JfZ3mvcjG1IeH0j8nUP8CnJj2ldbPlLI7knWoj4ctZAmA
	nL2HKO8M/fR+cjpgJCBnTRHFw8i02PUXmTs01viZckIFYhwUQBIA/cO
X-Google-Smtp-Source: AGHT+IFBVjtRbQv/O4vFqCINHjkhFqUpcSr0X08Yu3doVReRAjJ1yNffuin/NiQkGmZ2j66VCsE/xg==
X-Received: by 2002:a17:903:2ac3:b0:215:9eac:1857 with SMTP id d9443c01a7336-219da5b9caemr836257655ad.5.1736181901797;
        Mon, 06 Jan 2025 08:45:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962933sm296360125ad.56.2025.01.06.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:45:01 -0800 (PST)
Date: Mon, 6 Jan 2025 08:45:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dw@davidwei.uk, almasrymina@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net-next 6/8] netdevsim: add queue management API support
Message-ID: <Z3wIjGoiyhxi-TtE@mini-arch>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103185954.1236510-7-kuba@kernel.org>

On 01/03, Jakub Kicinski wrote:
> Add queue management API support. We need a way to reset queues
> to test NAPI reordering, the queue management API provides a
> handy scaffolding for that.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 135 +++++++++++++++++++++++++++---
>  drivers/net/netdevsim/netdevsim.h |   2 +
>  2 files changed, 125 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index e1bd3c1563b7..86614292314a 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -359,25 +359,24 @@ static int nsim_poll(struct napi_struct *napi, int budget)
>  	return done;
>  }
>  
> -static int nsim_create_page_pool(struct nsim_rq *rq)
> +static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
>  {
> -	struct page_pool_params p = {
> +	struct page_pool_params params = {
>  		.order = 0,
>  		.pool_size = NSIM_RING_SIZE,
>  		.nid = NUMA_NO_NODE,
> -		.dev = &rq->napi.dev->dev,
> -		.napi = &rq->napi,
> +		.dev = &napi->dev->dev,
> +		.napi = napi,
>  		.dma_dir = DMA_BIDIRECTIONAL,
> -		.netdev = rq->napi.dev,
> +		.netdev = napi->dev,
>  	};
> +	struct page_pool *pool;
>  
> -	rq->page_pool = page_pool_create(&p);
> -	if (IS_ERR(rq->page_pool)) {
> -		int err = PTR_ERR(rq->page_pool);
> +	pool = page_pool_create(&params);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
>  
> -		rq->page_pool = NULL;
> -		return err;
> -	}
> +	*p = pool;
>  	return 0;
>  }
>  
> @@ -396,7 +395,7 @@ static int nsim_init_napi(struct netdevsim *ns)
>  	for (i = 0; i < dev->num_rx_queues; i++) {
>  		rq = ns->rq[i];
>  
> -		err = nsim_create_page_pool(rq);
> +		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
>  		if (err)
>  			goto err_pp_destroy;
>  	}
> @@ -613,6 +612,117 @@ static void nsim_queue_free(struct nsim_rq *rq)
>  	kfree(rq);
>  }
>  
> +/* Queue reset mode is controled by ns->rq_reset_mode.
> + * - normal - new NAPI new pool (old NAPI enabled when new added)
> + * - mode 1 - allocate new pool (NAPI is only disabled / enabled)
> + * - mode 2 - new NAPI new pool (old NAPI removed before new added)
> + * - mode 3 - new NAPI new pool (old NAPI disabled when new added)
> + */
> +struct nsim_queue_mem {
> +	struct nsim_rq *rq;
> +	struct page_pool *pp;
> +};
> +
> +static int
> +nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
> +{
> +	struct nsim_queue_mem *qmem = per_queue_mem;
> +	struct netdevsim *ns = netdev_priv(dev);
> +	int err;
> +
> +	if (ns->rq_reset_mode > 3)
> +		return -EINVAL;
> +
> +	if (ns->rq_reset_mode == 1)
> +		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
> +
> +	qmem->rq = nsim_queue_alloc();
> +	if (!qmem->rq)
> +		return -ENOMEM;
> +
> +	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
> +	if (err)
> +		goto err_free;
> +
> +	if (!ns->rq_reset_mode)
> +		netif_napi_add_config(dev, &qmem->rq->napi, nsim_poll, idx);
> +
> +	return 0;
> +
> +err_free:
> +	nsim_queue_free(qmem->rq);
> +	return err;
> +}
> +
> +static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
> +{
> +	struct nsim_queue_mem *qmem = per_queue_mem;
> +	struct netdevsim *ns = netdev_priv(dev);
> +

[..]

> +	if (qmem->pp)
> +		page_pool_destroy(qmem->pp);

nit: page_pool_destroy handles NULL arg, so no need for 'if (qmem->pp)',
but probably not worth it to respin?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


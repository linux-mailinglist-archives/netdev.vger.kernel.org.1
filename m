Return-Path: <netdev+bounces-12767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A4738DAB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6DA1C20F2C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550819E66;
	Wed, 21 Jun 2023 17:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F319E4E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF744C433CC;
	Wed, 21 Jun 2023 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687369831;
	bh=cIQE0tqYqde1wQS9/IcLrDtGE0ZwQxHO+6tde8cVt4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYva0/5W7t0NxIgVeP53vFnVTqwMOS59neZkd9E2R3q/WoNeHdWpSaEZrCBAgnNvZ
	 OZblVRAyPgDiw5WctBsoo9L3Arvz5mqxj7q/DcmLR0zYNJXbXUEhK4nW6hnlL0Kn0K
	 EG2tHOVn/uhj4Fgy8ml/PRX+0nixFAdEnAy9IIL8Ej9UeYnn8/cXVNjinfbHefzGrh
	 FwmwzO5ItB8xnxbnZgy+N/5CBOVLiqLQUXvXdwWvd/RUOaHknzUqB+5I1T8bCU4cnX
	 4smek8cmnOm6kSHHkKKJui4WQ3aLMV26JdX/MTrOTAtfahzYcKu+6h09EanF26OCHN
	 cIjisblPWM5vQ==
Date: Wed, 21 Jun 2023 13:50:28 -0400
From: Chuck Lever <cel@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 09/13] net: Convert sunrpc from pagevec to folio_batch
Message-ID: <ZJM4ZK8cKI4AmOgy@manet.1015granger.net>
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-10-willy@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621164557.3510324-10-willy@infradead.org>

On Wed, Jun 21, 2023 at 05:45:53PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove the last usage of pagevecs.  There is a slight change here; we
> now free the folio_batch as soon as it fills up instead of freeing the
> folio_batch when we try to add a page to a full batch.  This should have
> no effect in practice.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I don't yet have visibility into the folio_batch_* helpers, but this
looks like a wholly mechanical replacement of pagevec. LGTM.

I assume this is going to be merged via another tree, not nfsd-next,
so:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  include/linux/sunrpc/svc.h |  2 +-
>  net/sunrpc/svc.c           | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index c2807e301790..f8751118c122 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -222,7 +222,7 @@ struct svc_rqst {
>  	struct page *		*rq_next_page; /* next reply page to use */
>  	struct page *		*rq_page_end;  /* one past the last page */
>  
> -	struct pagevec		rq_pvec;
> +	struct folio_batch	rq_fbatch;
>  	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
>  	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
>  
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e7c101290425..587811a002c9 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -640,7 +640,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
>  	if (!rqstp)
>  		return rqstp;
>  
> -	pagevec_init(&rqstp->rq_pvec);
> +	folio_batch_init(&rqstp->rq_fbatch);
>  
>  	__set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	rqstp->rq_server = serv;
> @@ -851,9 +851,9 @@ bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
>  	}
>  
>  	if (*rqstp->rq_next_page) {
> -		if (!pagevec_space(&rqstp->rq_pvec))
> -			__pagevec_release(&rqstp->rq_pvec);
> -		pagevec_add(&rqstp->rq_pvec, *rqstp->rq_next_page);
> +		if (!folio_batch_add(&rqstp->rq_fbatch,
> +				page_folio(*rqstp->rq_next_page)))
> +			__folio_batch_release(&rqstp->rq_fbatch);
>  	}
>  
>  	get_page(page);
> @@ -887,7 +887,7 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
>  void
>  svc_rqst_free(struct svc_rqst *rqstp)
>  {
> -	pagevec_release(&rqstp->rq_pvec);
> +	folio_batch_release(&rqstp->rq_fbatch);
>  	svc_release_buffer(rqstp);
>  	if (rqstp->rq_scratch_page)
>  		put_page(rqstp->rq_scratch_page);
> -- 
> 2.39.2
> 


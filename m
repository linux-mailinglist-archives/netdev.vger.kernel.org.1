Return-Path: <netdev+bounces-82586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E688E9D8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA92A47B9
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FEA12BF39;
	Wed, 27 Mar 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK0FRftH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01187535D3
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554673; cv=none; b=PtgU1ImPj8XVRI7yYB5R+F5DZE0FCjy2We07d2bLOiRf8VNGyyvFU7IGwQtmc3lqvFyD86e3nQN+P1efwa+M4T7J6GSufBdj22ug0pwH3vkXThs4JAOTy2nVDE2zoLp8xYUSyJOpbdrDAx/6uzgIEoB5wwHD9tHgBTaaPgFcOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554673; c=relaxed/simple;
	bh=6rt6FNWzkg5Dd54VOU7nh0YVERHY6S1AQ0GYwpyWhEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSkAe0PLn3t64qZwhu/umscFhzMUyOxkuzJ+LEcNypDw13Lt7FsKrljUufkioFuv/YNuvmf20l/TVCMU4wtvD/s6nghmBXKrQM+liiqMI9PAnuXvRxU3pLcxB6NXoaHFpbXvP8AhdHGjXHGcIJegn5lZTqWP2yDIktV7gst/j0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK0FRftH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D38C433F1;
	Wed, 27 Mar 2024 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554672;
	bh=6rt6FNWzkg5Dd54VOU7nh0YVERHY6S1AQ0GYwpyWhEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uK0FRftHa1brhQEqtDpabVSp6sp3pGp+tYHvC025RIv3QHC+FzkZc5QlMPsu5MPSL
	 voTtoAevkKJ/OoTAAPTr6grVXGUIUdNOlnfV7i6m6Oq8F0j2vdi3Gi/XxcGka7OWZ0
	 07wm21jTsnCvfspNhj1O3OqZyAUudT0LUyNDi+4FR23DfgZlM+KgEl61C61zMho7Mh
	 FwFdBjNYODzcAPG1SLEPB3Y2BeR91zNnJqfvrEaGrqdFSQdwJabFs3mFipW0RfyahF
	 jwuY4wIbj4hDP9Z3BbCWsRKK2aXIXTEFPJgSouhhIY36pObYWS7bm2aMspK59VqqEm
	 MJYE4SAcQYlyw==
Date: Wed, 27 Mar 2024 15:51:09 +0000
From: Simon Horman <horms@kernel.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eadavis@qq.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net/rds: fix possible cp null dereference
Message-ID: <20240327155109.GO403975@kernel.org>
References: <20240326153132.55580-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326153132.55580-1-mngyadam@amazon.com>

On Tue, Mar 26, 2024 at 04:31:33PM +0100, Mahmoud Adam wrote:
> cp might be null, calling cp->cp_conn would produce null dereference
> 
> Fixes: c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>

Thanks Mahmoud,

As per some details below, this seems to be a valid concern to me.
And the cited commit does seem to introduce this problem.

Reviewed-by: Simon Horman <horms@kernel.org>

It is probably not necessary to repost because of this,
but in future, please target bug fixes for Networking against the
net tree, which should be designated in the subject.

	[PATCH net] ...

See: https://docs.kernel.org/process/maintainer-netdev.html

> ---
> This was found by our coverity bot, and only tested by building the kernel.
> also was reported here: https://lore.kernel.org/all/202403071132.37BBF46E@keescook/
> 
>  net/rds/rdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/rds/rdma.c b/net/rds/rdma.c
> index a4e3c5de998b..00dbcd4d28e6 100644
> --- a/net/rds/rdma.c
> +++ b/net/rds/rdma.c
> @@ -302,7 +302,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
>  		}
>  		ret = PTR_ERR(trans_private);
>  		/* Trigger connection so that its ready for the next retry */
> -		if (ret == -ENODEV)
> +		if (ret == -ENODEV && cp)
>  			rds_conn_connect_if_down(cp->cp_conn);
>  		goto out;
>  	}

Analysis:

* cp is a parameter of __rds_rdma_map and is not reassigned.

* The following call-sites pass a NULL cp argument to __rds_rdma_map()

  - rds_get_mr()
  - rds_get_mr_for_dest

* Prior to the code above, the following assumes that cp may be NULL
  (which is indicative, but could itself be unnecessary)

	trans_private = rs->rs_transport->get_mr(
		sg, nents, rs, &mr->r_key, cp ? cp->cp_conn : NULL,
		args->vec.addr, args->vec.bytes,
		need_odp ? ODP_ZEROBASED : ODP_NOT_NEEDED);

* The code modified by this patch is guarded by IS_ERR(trans_private),
  where trans_private is assigned as per the previous point in this analysis.

  The only implementation of get_mr that I could locate is rds_ib_get_mr()
  which can return an ERR_PTR if the conn (4th) argument is NULL.

* ret is set to PTR_ERR(trans_private).
  rds_ib_get_mr can return ERR_PTR(-ENODEV) if the conn (4th) argument is NULL.
  Thus ret may be -ENODEV in which case the code in question will execute.

Conclusion:
* cp may be NULL at the point where this patch adds a check;
  this patch does seem to address a possible bug


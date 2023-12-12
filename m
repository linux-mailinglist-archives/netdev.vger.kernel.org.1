Return-Path: <netdev+bounces-56368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32EA80EA1D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D838E1C20835
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674425CD1F;
	Tue, 12 Dec 2023 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClmUQ5Sy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB441805F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 11:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855FC433C8;
	Tue, 12 Dec 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702379766;
	bh=uYwwLlsIzQYDAj0R5783tUUQONQgc91PncKROKCTvL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClmUQ5Sy0FxUMQx8S4IKnViITsSypmc+mECTKMc5IgH3dGZNb0fp1CiuIK/GlpFXc
	 Vq+lycJe/grle9iUp9xrNWRJBAbM9ZSZUoxhIDWmcvZ5OCx5qQBADbMioF/yTgoHvj
	 u6EPVXKqqQWKYG+sDOlOB65sAl3p9fx+8Juawu6i+ISIjsC1Kt8HyBEGVLkrLrnef5
	 T/hjZw78hPygBbXIGovEdcFUpQuzsHMVwsDXW5qnVQ4vVMsH/rrCQt31SYt5K/5qYx
	 VUtY24tOiA0U/cdr65Y1M/fp8lbtQgqXRY9Mf+YNPsoIV6/IRQCbW944WE+2uM5+hq
	 m/S4XQMSDOA6w==
Date: Tue, 12 Dec 2023 11:16:01 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
	jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Fix multicast/mirror group
 lock/unlock issue
Message-ID: <20231212111601.GY5817@kernel.org>
References: <20231212091558.49579-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212091558.49579-1-sumang@marvell.com>

On Tue, Dec 12, 2023 at 02:45:58PM +0530, Suman Ghosh wrote:
> As per the existing implementation, there exists a race between finding
> a multicast/mirror group entry and deleting that entry. The group lock
> was taken and released independently by rvu_nix_mcast_find_grp_elem()
> function. Which is incorrect and group lock should be taken during the
> entire operation of group updation/deletion. This patch fixes the same.
> 
> Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> @@ -6306,6 +6310,13 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>  		return err;
>  
>  	mcast_grp = &nix_hw->mcast_grp;
> +
> +	/* If AF is requesting for the deletion,
> +	 * then AF is already taking the lock
> +	 */
> +	if (!req->is_af)
> +		mutex_lock(&mcast_grp->mcast_grp_lock);
> +
>  	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
>  	if (!elem)

Hi Suman,

Does mcast_grp_lock need to be released here?
If so, I would suggest a goto label, say unlock_grp.

>  		return NIX_AF_ERR_INVALID_MCAST_GRP;
> @@ -6333,12 +6344,6 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
>  	mutex_unlock(&mcast->mce_lock);
>  
>  delete_grp:
> -	/* If AF is requesting for the deletion,
> -	 * then AF is already taking the lock
> -	 */
> -	if (!req->is_af)
> -		mutex_lock(&mcast_grp->mcast_grp_lock);
> -
>  	list_del(&elem->list);
>  	kfree(elem);
>  	mcast_grp->count--;
> @@ -6370,9 +6375,20 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  		return err;
>  
>  	mcast_grp = &nix_hw->mcast_grp;
> +
> +	/* If AF is requesting for the updation,
> +	 * then AF is already taking the lock
> +	 */
> +	if (!req->is_af)
> +		mutex_lock(&mcast_grp->mcast_grp_lock);
> +
>  	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
> -	if (!elem)
> +	if (!elem) {
> +		if (!req->is_af)
> +			mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  		return NIX_AF_ERR_INVALID_MCAST_GRP;
> +	}
>  
>  	/* If any pcifunc matches the group's pcifunc, then we can
>  	 * delete the entire group.
> @@ -6383,8 +6399,11 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  				/* Delete group */
>  				dreq.hdr.pcifunc = elem->pcifunc;
>  				dreq.mcast_grp_idx = elem->mcast_grp_idx;
> -				dreq.is_af = req->is_af;
> +				dreq.is_af = 1;
>  				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
> +				if (!req->is_af)
> +					mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  				return 0;
>  			}
>  		}
> @@ -6467,5 +6486,8 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
>  
>  done:

I think it would be good to rename this label, say unlock_mce;

>  	mutex_unlock(&mcast->mce_lock);

Add a new label here, say unlock_grp;
And jump to this label whenever there is a need for the mutex_unlock() below.

> +	if (!req->is_af)
> +		mutex_unlock(&mcast_grp->mcast_grp_lock);
> +
>  	return ret;
>  }
> -- 
> 2.25.1
> 


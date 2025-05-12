Return-Path: <netdev+bounces-189710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F4AB3492
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F24A188CF1A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975325D554;
	Mon, 12 May 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUCTKJzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AD19F11B
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044599; cv=none; b=I9/bvQPvv+XGs7pRlzxfhgwp1KDGzqaEZtiwCSXUgR3u3g2BdFkHZjsE1glTkv8rG8geHYEB2rcRtaPmzJkxvT21in/VnpS1M+XefjQyY8H5I/a/YjN1EAedJ2rXHQILSZ86at1PNxd8ZlDs5gKUJyQhvvtbt6wbJNLnMq3SmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044599; c=relaxed/simple;
	bh=nKCrPhMvtWOZ3oEfC6DeBWCH/1y1UwxgKpuc9xz4cZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiwgjHfjP4A1kpu+ZVxpZCKL8QYoOG+ZXQwuucGt7Hvk7Zvq/HCrIPzoz8o/QmOtqIRY37o2y3RPVAV2aGhQaDDpCzM3fwQ+ElHbTo7aKHtmGMepVSNfFpp1m+eQDZBA/NMzf575TUbJGO9/HFs+xKD6QJIBig0rnqzmf/Fgz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUCTKJzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B5C4CEE9;
	Mon, 12 May 2025 10:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747044598;
	bh=nKCrPhMvtWOZ3oEfC6DeBWCH/1y1UwxgKpuc9xz4cZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUCTKJzgOfn9HG48qsn5twlDnMU2twl+c/a8xiGtXuxLt/YUsn/Qz3iv5CjSFGFOz
	 OAp6cyKmQDIUYY06gvdQkyTs1lgW+dxRlURUx9d52yiDe2jyKtzj47jUjs1chi1eFa
	 kmfnd33/xC17yQNzefr2plffltNptBpeOk2xtdax9LciiZjOUJsKNK3eykoeoywZP0
	 Ov5MG62bWw/qlmhsNDg7pwUwFhzpW9hNSuh35eBnwQ8sABtvz8T84SrHjCLdTGpCK2
	 OOLqHsCpR3JirmF33bIoBH5E4gD4zRqP/fe5uCjwVXZdBrTkbyaORC9VZnkpFELjMR
	 lBCQrmzBG+JZA==
Date: Mon, 12 May 2025 11:09:54 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Send Link events one by one
Message-ID: <20250512100954.GU3339421@horms.kernel.org>
References: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746638183-10509-1-git-send-email-sbhatta@marvell.com>

On Wed, May 07, 2025 at 10:46:23PM +0530, Subbaraya Sundeep wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.
> 
> Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 992fa0b..ebb56eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -272,6 +272,8 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
>  
>  		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);

Hi Subbaraya,

Are there other callers of otx2_mbox_msg_send_up()
which also need this logic? If so, perhaps a helper is useful.
If not, could you clarify why?

>  
> +		otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);

This can return an error. Which is checked in otx2_sync_mbox_up_msg().
Does it make sense to do so here too?

> +
>  		mutex_unlock(&rvu->mbox_lock);
>  	} while (pfmap);
>  }
> -- 
> 2.7.4
> 


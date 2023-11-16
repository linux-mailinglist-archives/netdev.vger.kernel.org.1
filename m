Return-Path: <netdev+bounces-48481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CAC7EE87F
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF52280F9E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F16495E9;
	Thu, 16 Nov 2023 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZcxY6Qb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BA3FE20
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BFC433C7;
	Thu, 16 Nov 2023 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700167838;
	bh=aBAhIG5ZZv+6q7MeBajGvorrQFRVmO/bABxuFh3GO44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZcxY6QbAH78bN+7VcTqkHc1XCQNNWeC0D4zmCFxss1cVqWIfbAYTTenUSqtdONTO
	 w0gTd93a3t1knEVwmdTmSszjpDrWYCYAmvnFKtqf7AX5R0fdYDE82bUAPoGIBFBMy9
	 173ZNkAwAAB67WysA+JQrNUNKIpJXpdLQB9yJxynHKXYHNUM5kmTU56bvTEB8Sg1oq
	 pzK64BiyyheRcg1xFlfjtauLx4+qv0zTjsSP/8O+YYuRYDLWy9nN/KR1c7gZn6M3sl
	 vwHkZmldvJjtbT2kcG74T+FT8uDnPTEW3AzdNw+D4ggyxgpBHgT4i/pjyElVWJxn1l
	 rj59ZMXjLwUMA==
Date: Thu, 16 Nov 2023 20:50:33 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] octeontx2-pf: Fix memory leak during interface down
Message-ID: <20231116205033.GI109951@vergenet.net>
References: <20231116155334.3277905-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116155334.3277905-1-sumang@marvell.com>

On Thu, Nov 16, 2023 at 09:23:34PM +0530, Suman Ghosh wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: f12098ce9b43 ("octeontx2-pf: Clear RSS enable flag on interace down")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

I'm wondering if the fixes tag should refer to the commit
that introduced the allocation that your patch is freeing.

Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")

> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 91b99fd70361..ba95ac913274 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1934,6 +1934,8 @@ int otx2_stop(struct net_device *netdev)
>  	/* Clear RSS enable flag */
>  	rss = &pf->hw.rss_info;
>  	rss->enable = false;
> +	if (!netif_is_rxfh_configured(netdev))
> +		kfree(rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
>  
>  	/* Cleanup Queue IRQ */
>  	vec = pci_irq_vector(pf->pdev,
> -- 
> 2.25.1
> 


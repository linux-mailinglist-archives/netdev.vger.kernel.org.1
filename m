Return-Path: <netdev+bounces-179293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6FBA7BB5B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CE1789C7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636151DE2D6;
	Fri,  4 Apr 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F149/3JM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3933F1DE2BB;
	Fri,  4 Apr 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743765103; cv=none; b=IDy9FA59FBhJdWEsU2JWqWcvwLKgiQ6isFTUgvRyE5QUIGTU2z5fmc2etWIBPKKMPsYgGyUj8xjIUaANg2eususRWVP4fgiziKDKHPHltG22Xm4cn5YtuqPgL+9GhkrVJRlEi+108nhkJH2wwpVBb7Woa5ewSICJxXw9AEfDZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743765103; c=relaxed/simple;
	bh=8dxgvzN4w8fgacqIjgT7H770dnwqMt2wCKE+xrQ64kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6QTq4PTDPrnvQy22XAdT+wmZAp6X/w7RPHKGqV0B/9WsWp2yGp33kThDrlrvX+5k+zWTwFHWvg/MRtiX2J7/wZai3Y+9gtxnMHPBtjFoaWTC2xpnNxrli1KNnpzuBxhtzu0iG10/E+GHUqkbj3iem8t/Iv1zl8CF1SjYVE+yfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F149/3JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540F3C4CEDD;
	Fri,  4 Apr 2025 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743765102;
	bh=8dxgvzN4w8fgacqIjgT7H770dnwqMt2wCKE+xrQ64kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F149/3JM9qnc3eDY3cdzrzjsazwUmLLgNjg1kcg9O3oPYxqtYVZH10oqPErp5Rs4J
	 i2NUrPvx+8EMgpj1yVH817W3GLYzb7x//nN5xvkmowlQswYeCW2Qj7poRJSQnOsQvz
	 VeJg1MBSVY4wa6LZC4aj3El/lxblkQkNGKtJ3j4HjJu+yi8d7zzogeLETDDS9VWia+
	 BtOnxlGq/6TOzng6+PkRvMkmMS33S5QDCA1bNrWFB0sLetTI3fJ95DzEsqU74eM23C
	 Z/Ng9DLB86tfTXHIJ7t5vu5wXsxWI2R59FTe+2ouXYl7IovZoVN2LJUrJb3W9yO8DM
	 vxAFaik9/3ReA==
Date: Fri, 4 Apr 2025 12:11:38 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] octeontx2-pf:  Add error handling for
 cn10k_map_unmap_rq_policer().
Message-ID: <20250404111138.GA336350@horms.kernel.org>
References: <20250403151303.2280-1-vulab@iscas.ac.cn>
 <CO1PR18MB4666D076ED0162018D4256B2A1A92@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB4666D076ED0162018D4256B2A1A92@CO1PR18MB4666.namprd18.prod.outlook.com>

On Fri, Apr 04, 2025 at 05:22:16AM +0000, Subbaraya Sundeep Bhatta wrote:
> Hi,
> 
> From: Wentao Liang <vulab@iscas.ac.cn> 
> Sent: Thursday, April 3, 2025 8:43 PM
> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Wentao Liang <vulab@iscas.ac.cn>
> Subject: [PATCH] octeontx2-pf: Add error handling for cn10k_map_unmap_rq_policer().
> 
> The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> for each queue in a for loop without checking for any errors. A proper
> implementation can be found in cn10k_set_matchall_ipolicer_rate().
> 
> Check the return value of the cn10k_map_unmap_rq_policer() function during
> each loop. Jump to unlock function and return the error code if the
> funciton fails to unmap policer.
> 
> Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> Signed-off-by: Wentao Liang <mailto:vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> index a15cc86635d6..ce58ad61198e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> @@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
>  
>  	/* Remove RQ's policer mapping */
>  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> -					   hw->matchall_ipolicer, false);
> +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> +		if (rc)
> +			goto out;
>  
> Intentionally we do not bail out when unmapping one of the queues is failed. The reason is during teardown if one of the queues is failed then
> we end up not tearing down rest of the queues and those queues cannot be used later which is bad. So leave whatever queues have failed and proceed
> with tearing down the rest. Hence all we can do is print an error for the failed queue and continue.

Hi Sundeep,

Sorry that I didn't notice your response before sending my own to Wentao.

I do agree that bailing out here is not a good idea.  But I wonder if there
is any value in the function should propagate some error reporting if any
call to cn10k_map_unmap_rq_policer fails - e.g. the first failure - while
still iterating aver all elements.

Just an idea.

> 
> Thanks,
> Sundeep
> 
>  	rc = cn10k_free_leaf_profile(pfvf, hw->matchall_ipolicer);
>  
> +out:
>  	mutex_unlock(&pfvf->mbox.lock);
>  	return rc;
>  }
> -- 
> 2.42.0.windows.2
> 


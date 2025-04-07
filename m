Return-Path: <netdev+bounces-179705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B472A7E36D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DC87A6418
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D061F237C;
	Mon,  7 Apr 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+gc7iiL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE71E8351;
	Mon,  7 Apr 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038243; cv=none; b=YRD4/8NDOfIRBH0LHSGF1W1uuv6ov8dzluNgmLEiRY210Zt8sHueVQWMW0ea3HtsmPILBUodN5imvxuTXLZcI7n39rF+quMZ17SxQbr0GmXoBaGHQfj6191SUE37yJpSyFg8qCVzrU8GxqriFYq9F3H354KAB7hGcUHyxBvJwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038243; c=relaxed/simple;
	bh=P6eEvhvy9dRFc9wEm2ygO58JnggEGiLrExQqC+R7A/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iESx2rDKWsvfpvVHrPgKmd1a6dJjUed9OI9OzbmJd1KoiAE09rldCeDRsGpadflCZqJV8/MGOp/AtvOsrGi3kwqhbemYkJJLsEjsz5/HnNoG7WnwI/fhxRwGukqYUKRfzStgEuTrk8xpv59mh9bcIl9zWV9AImxWK4d0dDVLshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+gc7iiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A3DC4CEDD;
	Mon,  7 Apr 2025 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038242;
	bh=P6eEvhvy9dRFc9wEm2ygO58JnggEGiLrExQqC+R7A/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+gc7iiLsQWTh6fSo0TpPt8rkNDIASwBYh29oHO2zk3h7SBCj84XZEmc6WDJ8besK
	 daLON/NpALVseZGfY48S1i81qGJ3SEtHso1+JteIZSSFUUTgsuXByNvpSfupUSXKLZ
	 PvF22rZi43g3OeOddVKffyF91pCn90QEIgnHPPtmFKqIkESQm2KKu+J8mdRfVM+HlM
	 ztDEi0gd/BCOaJS6sXWsg81BnATtiRDZdb1eavWoiksYqsCz5wfZAJHDsxdZLHa+Xz
	 7cx/YINqTqCGgJoeADRjCvbltluV0OkAsmpB6lW3qDGbz82+On6LJUqZLb4S8W880S
	 LPbN9aG0jsvIQ==
Date: Mon, 7 Apr 2025 16:03:58 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
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
Message-ID: <20250407150358.GN395307@horms.kernel.org>
References: <Z_NpOu08haGEgqi6@452e0070d9ab>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_NpOu08haGEgqi6@452e0070d9ab>

On Mon, Apr 07, 2025 at 05:57:14AM +0000, Subbaraya Sundeep wrote:
> On 2025-04-04 at 11:11:38, Simon Horman (horms@kernel.org) wrote:
> > On Fri, Apr 04, 2025 at 05:22:16AM +0000, Subbaraya Sundeep Bhatta wrote:
> > > Hi,
> > > 
> > > From: Wentao Liang <vulab@iscas.ac.cn> 
> > > Sent: Thursday, April 3, 2025 8:43 PM
> > > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Wentao Liang <vulab@iscas.ac.cn>
> > > Subject: [PATCH] octeontx2-pf: Add error handling for cn10k_map_unmap_rq_policer().
> > > 
> > > The cn10k_free_matchall_ipolicer() calls the cn10k_map_unmap_rq_policer()
> > > for each queue in a for loop without checking for any errors. A proper
> > > implementation can be found in cn10k_set_matchall_ipolicer_rate().
> > > 
> > > Check the return value of the cn10k_map_unmap_rq_policer() function during
> > > each loop. Jump to unlock function and return the error code if the
> > > funciton fails to unmap policer.
> > > 
> > > Fixes: 2ca89a2c3752 ("octeontx2-pf: TC_MATCHALL ingress ratelimiting offload")
> > > Signed-off-by: Wentao Liang <mailto:vulab@iscas.ac.cn>
> > > ---
> > >  drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > > index a15cc86635d6..ce58ad61198e 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
> > > @@ -353,11 +353,13 @@ int cn10k_free_matchall_ipolicer(struct otx2_nic *pfvf)
> > >  
> > >  	/* Remove RQ's policer mapping */
> > >  	for (qidx = 0; qidx < hw->rx_queues; qidx++)
> > > -		cn10k_map_unmap_rq_policer(pfvf, qidx,
> > > -					   hw->matchall_ipolicer, false);
> > > +		rc = cn10k_map_unmap_rq_policer(pfvf, qidx, hw->matchall_ipolicer, false);
> > > +		if (rc)
> > > +			goto out;
> > >  
> > > Intentionally we do not bail out when unmapping one of the queues is failed. The reason is during teardown if one of the queues is failed then
> > > we end up not tearing down rest of the queues and those queues cannot be used later which is bad. So leave whatever queues have failed and proceed
> > > with tearing down the rest. Hence all we can do is print an error for the failed queue and continue.
> > 
> > Hi Sundeep,
> > 
> > Sorry that I didn't notice your response before sending my own to Wentao.
> > 
> > I do agree that bailing out here is not a good idea.  But I wonder if there
> > is any value in the function should propagate some error reporting if any
> > call to cn10k_map_unmap_rq_policer fails - e.g. the first failure - while
> > still iterating aver all elements.
> > 
> > Just an idea.
> > 
> Hi Simon,
> 
> We can do but it gets compilcated if more than one queue failed and
> reasons are different. Hence just print error and continue.

Yes, understood. I did think about this some more and I think that
reporting an error is the best we can do, else as you say it gets complex.
So if there is already a log made, then I think that is sufficient.


Return-Path: <netdev+bounces-182966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCBA8A73D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EC5443ECA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2C233711;
	Tue, 15 Apr 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd3RBjbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71737221266;
	Tue, 15 Apr 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743080; cv=none; b=oVeSCn6oTalMLh9famzbi1wqt9SDUz/OJ7BfE+D/IUSJsDuZVTZoqJeOlZQ1eu3bYbDA8RaNsrxb+s9U/Nsxe+fyndnN/yWYYf8Adg0DDq11FeqqXRt6oylxPbFStAilu2bbJJQ6CCtAdsyBuawJrdKb8YwdhrNjrz0F6ckum4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743080; c=relaxed/simple;
	bh=+YZJMLcbhKnrpLnI5QmdG4v6jk8BIKjrknPDXiTcnHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLmng+/dUYb7ATp2X4Po0c+2lNRXHjnyAFSPZk1P8tI/J9EgxH43rYUTVw4zKQIB4h5rUlmFn833TdH+RcM/fRwsHxVOvxAvfDH6Ciw1u1SDFz/dlrgGmAipJwkqUphTZIDr2QJ4Vu0b6US0JlSX1di788N7I7jdoSUA7q77RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd3RBjbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6CDC4CEE7;
	Tue, 15 Apr 2025 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743077;
	bh=+YZJMLcbhKnrpLnI5QmdG4v6jk8BIKjrknPDXiTcnHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hd3RBjbcZCeyn0q945T4MSZJlSgucwNo4XKVE3jIsHuRRD2XhNH9Ia+mckqA4cWbp
	 kP+h1Rii3558ukalEnAnoE8bwDDwHLj4aDAiCft6hF+UIcFW0Z0i0y60FvdgSG97CD
	 XzZw6TTpcAxXSeVCTq9ffF+2eDok5bH913L8PNA5BaeFOrCQZ0Aq7XIedv8w0FmZki
	 0cnlCGQftm8vXf5tZFpFjPbATPHK1ENlbyyILFeZZUmDI6C8iKQPpv5lcQl8gQXuae
	 kpKUBCa+nmFiCC0r+927ppOMxfcJw2GILv98AXrfy0zlBPurwv7Yr050rE0ySVwRgE
	 JeNtZtwBAbRGg==
Date: Tue, 15 Apr 2025 19:51:13 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: handle otx2_mbox_get_rsp errors
Message-ID: <20250415185113.GG395307@horms.kernel.org>
References: <20250412183327.3550970-1-chenyuan0y@gmail.com>
 <Z/zrwJJhR1pDwfj/@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/zrwJJhR1pDwfj/@mev-dev.igk.intel.com>

On Mon, Apr 14, 2025 at 01:04:32PM +0200, Michal Swiatkowski wrote:
> On Sat, Apr 12, 2025 at 01:33:27PM -0500, Chenyuan Yang wrote:
> > Adding error pointer check after calling otx2_mbox_get_rsp().
> > 
> > This is similar to the commit bd3110bc102a
> > ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c").
> > 
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > index 04e08e06f30f..7153a71dfc86 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > @@ -67,6 +67,8 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
> >  
> >  		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
> >  			(&priv->mbox.mbox, 0, &req->hdr);
> > +		if (IS_ERR(rsp))
> > +			goto exit;
> 
> Changes looks fine:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> BTW, looks like now you can use break instead of goto exit, as exit
> label is just after the while loop.

True. My suggestion would be to keep this patch as-is. And, once it has
hit net-next, send a follow-up to remove the exit label.

> 
> >  
> >  		for (ent = 0; ent < rsp->count; ent++)
> >  			rep->flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
> > -- 
> > 2.34.1
> 


Return-Path: <netdev+bounces-182278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CDA88669
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D7316FF39
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA525D550;
	Mon, 14 Apr 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvyip8VH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC82522BC;
	Mon, 14 Apr 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642777; cv=none; b=UCIAuxCQI4LgV4t/xT0ZJKMwEuUt/7N0yqq2n+SuzEY5OwjVi1dJ8WU3jCN7zEE7IXXleADiy8S74nMZmMLWcj5p9XaBlaQ134O0PssLmBTxULp4okE0GUED2NUZiNbIBlziN3gqNTtn2ci8WDuUd3CpT/2GQs2atEP8rZw73Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642777; c=relaxed/simple;
	bh=TXFo3YH0SnxAza+gtpMwQLt8XQCR/UmGU74NQR4Cdy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHEp7dXHesApy+CPOLUH9fcfyffFaJXEc3x/cCVobuyrH1QyR33DUfAv7c2Yngm+sclclmtaEPo4K5OkrejeOlhffjeoGrKWR2n58je0bOYHfSYFDKpNwe6p/VZpnWLJt0FdG/pC2cgrkHgYVAh/qZdzsar7Ud7X5+56+rPdpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvyip8VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02829C4CEE2;
	Mon, 14 Apr 2025 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744642777;
	bh=TXFo3YH0SnxAza+gtpMwQLt8XQCR/UmGU74NQR4Cdy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uvyip8VH1mVHDRmAzVsLu+a/nS+Oz9/it7MYuLKR5OZ/6LlfUQ6iphsK5o22269lz
	 a9lqjbfexAfoqfKtaMpAJ3yn9JIVrg7+cdpmxjVkFV0Uo0VxZck0/3hO9jsAtHNTLd
	 U19XuNYivnph0hLnjatmZaJpvLKRueBpmF60CTSXJg0EcpGIp1NHIoZ/CiiUpe5NaD
	 NwWfNVCieYFLCMLSL7r1VANeo6tIecpE2dMDkqjfss2FDVAaMGs0C/HZouJMnQ4hdR
	 iUpDoN3zUa3cfvNJVgNwpLPwu8RcR/zWZgCKydDYrdaIkG2KOgoAz8ewmeBHcuNzeh
	 nUjO4Q6Y+LtRQ==
Date: Mon, 14 Apr 2025 15:59:32 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Message-ID: <20250414145932.GA1508032@horms.kernel.org>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
 <20250411145734.GH395307@horms.kernel.org>
 <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
 <20250414145618.GT395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414145618.GT395307@horms.kernel.org>

On Mon, Apr 14, 2025 at 03:56:22PM +0100, Simon Horman wrote:
> On Fri, Apr 11, 2025 at 09:52:29PM +0530, Abdun Nihaal wrote:
> > On Fri, Apr 11, 2025 at 03:57:34PM +0100, Simon Horman wrote:
> > > On Wed, Apr 09, 2025 at 05:47:46PM +0200, Markus Elfring wrote:
> > > > …
> > > > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > > > @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> > > > >  		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> > > > >  		if (!eth_filter->port[i].bmap) {
> > > > >  			ret = -ENOMEM;
> > > > > +			kvfree(eth_filter->port[i].loc_array);
> > > > >  			goto free_eth_finfo;
> > > > >  		}
> > > > >  	}
> > > > 
> > > > How do you think about to move the shown error code assignment behind the mentioned label
> > > > (so that another bit of duplicate source code could be avoided)?
> > > 
> > > Hi Markus,
> > > 
> > > If you mean something like the following. Then I agree that it
> > > is both in keeping with the existing error handling in this function
> > > and addresses the problem at hand.
> > > 
> > > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > index 7f3f5afa864f..df26d3388c00 100644
> > > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > @@ -2270,13 +2270,15 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> > >                 eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> > >                 if (!eth_filter->port[i].bmap) {
> > >                         ret = -ENOMEM;
> > > -                       goto free_eth_finfo;
> > > +                       goto free_eth_finfo_loc_array;
> > >                 }
> > >         }
> > > 
> > >         adap->ethtool_filters = eth_filter;
> > >         return 0;
> > > 
> > > +free_eth_finfo_loc_array:
> > > +       kvfree(eth_filter->port[i].loc_array);
> > >  free_eth_finfo:
> > >         while (i-- > 0) {
> > >                 bitmap_free(eth_filter->port[i].bmap);
> > > 
> > 
> > I think what Markus meant, was to move the ret = -ENOMEM from both the
> > allocations in the loop, to after the free_eth_finfo label because it is
> > -ENOMEM on both goto jumps.
> > 
> > But personally I would prefer having the ret code right after the call 
> > that is failing. Also I would avoid creating new goto labels unless
> > necessary, because it is easier to see the kvfree in context inside the
> > loop, than to put it in a separate label.
> > 
> > I just tried to make the most minimal code change to fix the memory leak.
> 
> Thanks Nihaal,
> 
> I agree that your patch is fine as-is for the reasons you describe above.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

As the patch was marked as changes requested, presumably due to earlier
discussion in this thread, could you please post a v2. You can include my
tag above. And note under the scissors ("---") that adding the tag was the
only change between v1 and v2.


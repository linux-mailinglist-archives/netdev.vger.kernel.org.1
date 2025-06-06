Return-Path: <netdev+bounces-195486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC83AD072C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E26163BBF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B6289356;
	Fri,  6 Jun 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEObtBJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984B1DCB09
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229518; cv=none; b=i/T/I9iVNZVqiy2rk12kMDOweGNC7gnT+ySJbl2KGTqSzd5Kakn0fGN8QUjjMhYW0bk4suHVf3lhW0ettGUnwOu56aUKtbhve8KG3jZVxRqsejTA3KjTZdvL/qNtv7tyrvEmAP0Ln3Kit5xoDcimj+DhSzWh80ULa+0PYEMuKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229518; c=relaxed/simple;
	bh=uPCcvBvQlkufo3tLTX69dfcWF1c4LwbQll4os1qnL9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jza0NBA77+avI3URta4t/LTAqr/ul251LRfPfMcPcvhPVszwy+h9S1k5myRt7L8fygSUhX++T8MzeJw71E5jdUpfcOmIsLLR68C+YQs3EPnwIuKL/WXbYR8rIMPeon1HWrob3UiSUgP01Jly0Lb1KR+SIBPXGWToDkYoCNW/TnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEObtBJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C86C4CEEB;
	Fri,  6 Jun 2025 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749229516;
	bh=uPCcvBvQlkufo3tLTX69dfcWF1c4LwbQll4os1qnL9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEObtBJBKYiXW7Aq3d0sruZkyu0xe458brl0N9fiBvq5eIr18uhz4np+quUbUUizs
	 wrPPZGSDbSy8lnsN4GjYXIck5pFAFeVfsXwUCeWBvm0JvIGDmAZnMzMGqc1bSBG6Cx
	 PxM7xF2izjw+JfjXklWt+w2vJCBC3bui3oY/OUy7bqS2QDXRyZbjvMW2VML0ro9W7N
	 3RAv5CB3WRXJgS3B95e0MEigXfjJz2fRDdeTENx/WVHyq8z4OwMz0Wl9lQu+eZ2R3B
	 MLSo/ZEh0an5aoJOTtMBPp7GEaIGJI5bY7hFSvl0E4BkD3ZFXh40P75asSITmSKd3q
	 DTtwGGc6oPgSQ==
Date: Fri, 6 Jun 2025 20:05:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next v1 1/5] xfrm: delay initialization of offload
 path till its actually requested
Message-ID: <20250606170512.GH7435@unreal>
References: <cover.1739972570.git.leon@kernel.org>
 <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>
 <aEGW_5HfPqU1rFjl@krikkit>
 <20250605141624.GG7435@unreal>
 <aEMFdAPopn9Td-Dn@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMFdAPopn9Td-Dn@krikkit>

On Fri, Jun 06, 2025 at 05:12:52PM +0200, Sabrina Dubroca wrote:
> 2025-06-05, 17:16:24 +0300, Leon Romanovsky wrote:
> > On Thu, Jun 05, 2025 at 03:09:19PM +0200, Sabrina Dubroca wrote:
> > > Hello,
> > > 
> > > I think we need to revert this patch. It causes a severe performance
> > > regression for SW IPsec (around 40-50%).
> > > 
> > > 2025-02-19, 15:50:57 +0200, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > XFRM offload path is probed even if offload isn't needed at all. Let's
> > > > make sure that x->type_offload pointer stays NULL for such path to
> > > > reduce ambiguity.
> > > 
> > > x->type_offload is used for GRO with SW IPsec, not just for HW offload.
> > 
> > Thanks for the report, can you please try the following fix?
> 
> Seems to work in my setup. That's basically a revert of every
> functional change in 585b64f5a620 ("xfrm: delay initialization of
> offload path till its actually requested"), except that now we set
> ->type_offload during xfrm_state_construct instead of
> __xfrm_init_state, so other callers of __xfrm_init_state
> (xfrm_state_migrate and pfkey - we can ignore ipcomp since it doesn't
> have ->type_offload) won't get ->type_offload set correctly. I'm not
> sure we want that.
> 
> Do you need to also revert 49431af6c4ef ("xfrm: rely on XFRM offload")
> from this series? The assumption that x->type_offload is set only for
> HW offload isn't correct.

I don't think so, we are not setting x->type_offload in crypto and packet
offload modes and it is enough for us to rely on offload type.

  230 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
  231                        struct xfrm_user_offload *xuo,
  232                        struct netlink_ext_ack *extack)
  233 {
  ...
  308         if (!x->type_offload) {
  309                 NL_SET_ERR_MSG(extack, "Type doesn't support offload");
  310                 dev_put(dev);
  311                 return -EINVAL;
  312         }

Thanks

> 
> -- 
> Sabrina


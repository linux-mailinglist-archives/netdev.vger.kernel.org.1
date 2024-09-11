Return-Path: <netdev+bounces-127324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17A974FDF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF91C22A70
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C40715DBB3;
	Wed, 11 Sep 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+01lOju"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0039AEB
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051246; cv=none; b=o/3GT2VLs+p7n15oSl8WfNYswnAOB5E6qTTVdYIwpuvZzk93fsIysKZUVOUwOINgW5ct2lTV5dpghmWvWAk5Hl+xlmZEApCWMhkmGdVKGAzn3dy3WHXTCdbU7D8aa4ZRLrrwgXEL5nXloKHHGMKIEaxTAqjEBVpjzjfa2EkA0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051246; c=relaxed/simple;
	bh=fmtW2qHDJCExAMPhfQra5Vcs4sdEJaS6wDsLMjOCI18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upQQOGzrEo0DBd+1g7G5VjAuXEVfuSFXFMw2mQqRpw4IRZPguv46QUL3M6DK0VSQrNQ1dyEmtZFS6Ri1hFcEk66Jmij3kODEmK39OFqPhPrDAC+NedQaqHTqf5xQ7l4iSB0J5tvWqb9Sl7Yg8d9OdctjfMyT9ao9UZuPp7S+dzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+01lOju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD99C4CEC5;
	Wed, 11 Sep 2024 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726051245;
	bh=fmtW2qHDJCExAMPhfQra5Vcs4sdEJaS6wDsLMjOCI18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+01lOjuJ/jXsLkaUQT2Px2rAuiiPbPD42p9tPo+eCXsw9wSVhABeO51ymwq4evWb
	 oM4pvZxGs4wL9qseLKaRt3QXG8DgrOqB5Nh1JtXcSZgcqHTYvNIwwx/baJEPlbAOfs
	 cu5Sp246J/PAHDiOyxhj0ovJ/vzLiznb5o/OMLI4nR57a/+aQRScd/s2TQwyRz1cE2
	 aXQw1gTsJUqrYUc79kx7DvCugd76gLNqO7DnE5IpeOcezS8Bf7lFsZv3gdg6ueY+RM
	 6150uc3kMRnQX0NysS8w+BleHr3UlWDKR16aEjFIZTTfThBfYEdYinftXsmeE5DcKy
	 HQKTzRXJa89yQ==
Date: Wed, 11 Sep 2024 13:40:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240911104040.GG4026@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt67MfyiRQrYTLHC@gauss3.secunet.de>

On Mon, Sep 09, 2024 at 11:09:05AM +0200, Steffen Klassert wrote:
> On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > > 
> > > > Steffen,
> > > > 
> > > > What is your position on this patch?
> > > > It is the same patch (logically) as the one that was rejected before?
> > > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > > 
> > > This is an infrastructure patch to support routing based IPsec
> > > with xfrm interfaces. I just did not notice it because it was not
> > > mentioned in the commit message of the first patchset. This should have
> > > been included into the packet offload API patchset, but I overlooked
> > > that xfrm interfaces can't work with packet offload mode. The stack
> > > infrastructure should be complete, so that drivers can implement
> > > that without the need to fix the stack before.
> > 
> > Core implementation that is not used by any upstream code is rarely
> > right thing to do. It is not tested, complicates the code and mostly
> > overlooked when patches are reviewed. The better way will be to extend
> > the stack when this feature will be actually used and needed.
> 
> This is our tradeoff, an API should be fully designed from the
> beginning, everything else is bad design and will likely result
> in band aids (as it happens here). The API can be connected to
> netdevsim to test it.
> 
> Currently the combination of xfrm interfaces and packet offload
> is just broken. 

I don't think that it is broken. It is just not implemented. XFRM
interfaces are optional field, which is not really popular in the
field.

> Unfortunalely this patch does not fix it.
> 
> I think we need to do three things:
> 
> - Fix xfrm interfaces + packet offload combination
> 
> - Extend netdevsim to support packet offload
> 
> - Extend the API for xfrm interfaces (and everything
>   else we forgot).

This is the most challenging part. It is not clear what should
we extend if customers are not asking for it and they are extremely
happy with the current IPsec packet offload state.

BTW, I'm aware of one gap, which is not clear how to handle, and
it is combination of policy sockets and offload.

> 
> > IMHO, attempt to enrich core code without showing users of this new flow
> > is comparable to premature optimization.
> > 
> > And Feng more than once said that this code is for some out-of-tree
> > driver.
> 
> It is an API, so everyone can use it.

Of course, as long as in-kernel user exists.

Thanks


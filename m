Return-Path: <netdev+bounces-129671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C4198557E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25559282AAB
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB011598F4;
	Wed, 25 Sep 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRGjZU7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3841598E9
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252980; cv=none; b=kLMkGNaxg7gSYbV2uF2NgAdrVD3Mnc9ggS2s3yTkC3wRjBcWxPH+KqRr72/mjPTBXhlGJDCw3u2o52qsPtVi2EHDBJFjsWkcZsvXuENH86IhbAqVvZi6OMBeburANwEZzCSsmI7LY+WSU1yobv14VSBFrvqJwpbd+vpp4Zd9j1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252980; c=relaxed/simple;
	bh=YBpfptIeybOZ1fFLnfnzMvFJaT8t1rJ7YQ4EcaxwGWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdmxQDaGiG3DT/buW7qsUMVOL3oGorxP6u4QF9rpcbgxda3UlEVebwQxChZ4q1wxR3ht+b4/7W2SXVtg014nJTE+0ix6gC8nIgy+sLP+DyDOimLn2mO+GTLizUyfCuyLIchx0y7+xsmtpSIYzMmLK6xvWK/WfRjCAE0NHFAUqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRGjZU7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332DC4CEC3;
	Wed, 25 Sep 2024 08:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727252980;
	bh=YBpfptIeybOZ1fFLnfnzMvFJaT8t1rJ7YQ4EcaxwGWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRGjZU7P0WI3I/WjYZAtafqFJPh61tFRAzqGageigU1gZ/OK+KRUQ3yGTUM0zn5kZ
	 kpRFP0/tYQU/lLF1g3e5220g1XyUE5zacbi5u2NstU1QHUdpnTVU7Mb9cQA+0Dq+lg
	 zvhH1Gw3Jb3f4E0VQBQo26NZ9l1cUvFg/f1naF9/7vWUzotGtDd4fPtM2i07WRPJdp
	 5RksKhmqhjAHP3ASdWByPRsPOkOFHqTjiFpUBFJQigOKjoatfK3GYqQxVR+5W05wI3
	 kDIERdfVI71EsaHQg7Cb0Jk51wRAHtmIrvOkFZ3CJXE09YvF0JXqwsOpz3uWLDVj21
	 iX4McKFKhizlQ==
Date: Wed, 25 Sep 2024 11:29:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240925082935.GC967758@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
 <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>

On Tue, Sep 24, 2024 at 12:34:32PM +0200, Steffen Klassert wrote:
> On Wed, Sep 11, 2024 at 01:40:40PM +0300, Leon Romanovsky wrote:
> > On Mon, Sep 09, 2024 at 11:09:05AM +0200, Steffen Klassert wrote:
> > > On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > > > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > > > > 
> > > > > > Steffen,
> > > > > > 
> > > > > > What is your position on this patch?
> > > > > > It is the same patch (logically) as the one that was rejected before?
> > > > > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > > > > 
> > > > > This is an infrastructure patch to support routing based IPsec
> > > > > with xfrm interfaces. I just did not notice it because it was not
> > > > > mentioned in the commit message of the first patchset. This should have
> > > > > been included into the packet offload API patchset, but I overlooked
> > > > > that xfrm interfaces can't work with packet offload mode. The stack
> > > > > infrastructure should be complete, so that drivers can implement
> > > > > that without the need to fix the stack before.
> > > > 
> > > > Core implementation that is not used by any upstream code is rarely
> > > > right thing to do. It is not tested, complicates the code and mostly
> > > > overlooked when patches are reviewed. The better way will be to extend
> > > > the stack when this feature will be actually used and needed.
> > > 
> > > This is our tradeoff, an API should be fully designed from the
> > > beginning, everything else is bad design and will likely result
> > > in band aids (as it happens here). The API can be connected to
> > > netdevsim to test it.
> > > 
> > > Currently the combination of xfrm interfaces and packet offload
> > > is just broken. 
> > 
> > I don't think that it is broken.
> 
> I don't see anything that prevents you from offloading a SA
> with an xfrm interface ID. The binding to the interface is
> just ignored in that case.
> 
> > It is just not implemented. XFRM
> > interfaces are optional field, which is not really popular in the
> > field.
> 
> It is very popular, I know of more than a billion devices that
> are using xfrm interfaces.

We see different parts of "the field". In my case it it enterprise/cloud
world, and I can say same sentence as you with "are NOT using ..."
words instead. This is why so important to see google's driver (which is Android)
to understand the real need from this feature.

> 
> > 
> > > Unfortunalely this patch does not fix it.
> > > 
> > > I think we need to do three things:
> > > 
> > > - Fix xfrm interfaces + packet offload combination
> > > 
> > > - Extend netdevsim to support packet offload
> > > 
> > > - Extend the API for xfrm interfaces (and everything
> > >   else we forgot).
> > 
> > This is the most challenging part. It is not clear what should
> > we extend if customers are not asking for it and they are extremely
> > happy with the current IPsec packet offload state.
> 
> We just need to push the information down to the driver,
> and reject the offload if not supported.

Yes and in addition to that it will be beneficial do not add this information
to SKB if it won't be used.

> 
> > 
> > BTW, I'm aware of one gap, which is not clear how to handle, and
> > it is combination of policy sockets and offload.
> 
> Socket policies are a bit special as they are configured by
> the application that uses the socket. I don't think that
> we can even configure offload for a socket policy.

One of the idea is to iterate over all devices and check if they
support offload, if yes, then offload, if not, then fallback
to software for that device. This is just rough idea with many
caveats.

Thanks


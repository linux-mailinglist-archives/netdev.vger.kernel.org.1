Return-Path: <netdev+bounces-124134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC4968380
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CD81F22DE2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3411D1F65;
	Mon,  2 Sep 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft6az4D9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0F18661C
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270298; cv=none; b=I+ONbJIZQCZeMyqdM4JLrsaiLN3nibXtqiEI2WBBYdexofGIoBtMabRkS6BQOluDdT++UbaFuIm/XaF/jHUMXCr021dlJADn1nuqfFNkbaQRGrsKGjNGWxb9tjB9KFcPb+ES4FSVdu+UA7M9Tcs/Uvy4jY3txwh+rYxWpSJhaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270298; c=relaxed/simple;
	bh=nfx9KdHtB7mfqNMCqfYYEmR1tL/q4jvZ6kOi2em5qw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB3z1C0xWF+lUof1v9k/8kIx9A0PAYJuGGFiwIU2m001y06Cor0oq9uc84IgByNf1kyVPcyjIy2Nbmg16X0Rt6hGv4ZfNOs4f4F1pFVe3Pxsc69CuZqlHPZSMbeoVYhqIEj8M5siQzvWYwaKQY6xNkdONoe504rAU4dsMfpDI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft6az4D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4ADC4CEC2;
	Mon,  2 Sep 2024 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725270297;
	bh=nfx9KdHtB7mfqNMCqfYYEmR1tL/q4jvZ6kOi2em5qw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ft6az4D9vqCiDKCRe2dMAZ4KTqlpiiS8n0yEftvkxX3PaTtYBHq4ivYcOt/fkgNZ1
	 oS7DcvyMzeflAZgjZatybOeWbsrJEmMhxh0fQlEzgTY7z+zWwkGNhIFLOyI/4vaDaJ
	 sx1sJ6rzVCVueAre1ppwk0GrtuN+rGnKwlC28/1C/vrFRiKsLNAAwXZytjqbOa3Qnb
	 0KuXnsakfldwBYc50KhH1UOGXMdxbomMJ9l3LwVpe6TTYnh1b+XKacC4vA5I5cZ9pD
	 BE+ImnsOFCUPS7keTy+LGfYFMFYFdC104IkGzvxom4LwfYBZ0vclGfUdyNAlCJMpH6
	 tULjfxp/dpZ4Q==
Date: Mon, 2 Sep 2024 12:44:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240902094452.GE4026@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>

On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> Sorry for the delay. I'm on vacation, so responses will take a bit
> longer during the next two weeks.
> 
> On Sat, Aug 31, 2024 at 08:39:34PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> > > On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > > > From: wangfe <wangfe@google.com>
> > > > 
> > > > In packet offload mode, append Security Association (SA) information
> > > > to each packet, replicating the crypto offload implementation.
> > > > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > > > from the validate_xmit_xfrm function, thus aligning with the existing
> > > > code path for packet offload mode.
> > > > 
> > > > This SA info helps HW offload match packets to their correct security
> > > > policies. The XFRM interface ID is included, which is crucial in setups
> > > > with multiple XFRM interfaces where source/destination addresses alone
> > > > can't pinpoint the right policy.
> > > > 
> > > > Signed-off-by: wangfe <wangfe@google.com>
> > > 
> > > Applied to ipsec-next, thanks Feng!
> > 
> > Steffen,
> > 
> > What is your position on this patch?
> > It is the same patch (logically) as the one that was rejected before?
> > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> 
> This is an infrastructure patch to support routing based IPsec
> with xfrm interfaces. I just did not notice it because it was not
> mentioned in the commit message of the first patchset. This should have
> been included into the packet offload API patchset, but I overlooked
> that xfrm interfaces can't work with packet offload mode. The stack
> infrastructure should be complete, so that drivers can implement
> that without the need to fix the stack before.

Core implementation that is not used by any upstream code is rarely
right thing to do. It is not tested, complicates the code and mostly
overlooked when patches are reviewed. The better way will be to extend
the stack when this feature will be actually used and needed.

IMHO, attempt to enrich core code without showing users of this new flow
is comparable to premature optimization.

And Feng more than once said that this code is for some out-of-tree
driver.

> 
> In case the patch has issues, we should fix it.

Yes, this patch doesn't have in-kernel users.

Thanks


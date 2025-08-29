Return-Path: <netdev+bounces-218292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B7B3BCCD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608C15605F3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEF21FF3B;
	Fri, 29 Aug 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBwgaCPo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5177347B4
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475374; cv=none; b=OIhAKGotGcYN3t7rvr5cB6NNQOkz64lnpSVayOq8dHnNKMq6NeIMn82jhGLlApWcFjRGK4QZeD3bYtd/B2trV5b1f6Fi+MPJzXQnYSaholo5eDqInlqXTTSRcwsvB9xDSi+I5D2PgoykD5/2YGIUu5MulJZoq1aOB5IdQn8JKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475374; c=relaxed/simple;
	bh=um782bfu+OSrbzaNHhQL8QcXexj+R+MNW4UBzQsB7I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2LO4VEUQ1Bs6ZWjlk3/y6ygFrfjiHGNZWIKNc4p8FTeUpKdxi+JOLdOIgfkzivxR6d857wTpTaFm144XyuYV5DxTwxbSdb4bAGeLzFZqB5++652dsp9M5J4xl/4Vvv/GdNS8qHP/73IAN4CQ54dcCInJg3ZxiuyHBIVLKdK4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBwgaCPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B7CC4CEF0;
	Fri, 29 Aug 2025 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756475374;
	bh=um782bfu+OSrbzaNHhQL8QcXexj+R+MNW4UBzQsB7I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBwgaCPoqjcngxIrFrZYTJYD7M916WnxdNQDbjQju4ByNRh26y3hIitwvE4N8Us4e
	 ePuYuF046d+vAPl+Esxl3UunZQOAsThm5Fy/mm71wE79XCuBfKPuv8S8cDSOxlCjS4
	 xAfqwZHVwv5s/8LHID4gkWaxQ9UJyr/jY1C3VXYgf8My9R7jdA67NcLn9e7zPOsHtT
	 4Sv9MRzbdDL4qySezRShWMwUF6R1uoUgH8SIVxSec87YO62EDUteOfxcj30RfbT2z/
	 EIe26sjb45nqw+8xq9igHBxfcx6pGLepqQa0c/bg6vPQFSetxyHHksn7deom+8tmPV
	 CJmJm0/lWyXug==
Date: Fri, 29 Aug 2025 14:49:31 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Aakash Kumar S <saakashkumar@marvell.com>,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Subject: Re: [PATCH ipsec] xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
Message-ID: <20250829134931.GL31759@horms.kernel.org>
References: <b7a2832406b97f48fbfdffc93f00b7a3fd83fee1.1756457310.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a2832406b97f48fbfdffc93f00b7a3fd83fee1.1756457310.git.sd@queasysnail.net>

On Fri, Aug 29, 2025 at 10:54:15AM +0200, Sabrina Dubroca wrote:
> x->id.spi == 0 means "no SPI assigned", but since commit
> 94f39804d891 ("xfrm: Duplicate SPI Handling"), we now create states
> and add them to the byspi list with this value.
> 
> __xfrm_state_delete doesn't remove those states from the byspi list,
> since they shouldn't be there, and this shows up as a UAF the next
> time we go through the byspi list.
> 
> Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> Fixes: 94f39804d891 ("xfrm: Duplicate SPI Handling")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks, I see that prior to the cited commit an error would
be returned if newspi was 0. Where newspi was
assigned the value of get_random_u32_inclusive(low, high).

Reviewed-by: Simon Horman <horms@kernel.org>

...


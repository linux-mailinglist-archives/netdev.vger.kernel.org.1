Return-Path: <netdev+bounces-115527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42190946E46
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4D628164E
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3D282E5;
	Sun,  4 Aug 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg+qi+9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884F22086;
	Sun,  4 Aug 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722766742; cv=none; b=B83pGVqblES8QzJJ5k1iKx0kBH/KYgUYtMllLGdKP29S2Xu/OYyk9Ig8CXtaY8nRa8FZ2n3J6oN5uNLsgnIpdLN0rewpBQgnf97faL+47rvwvoXiSedhn7tzn2ASWc1R71fyMRIcHuK3jJlpIcKscjGPA8ltw0VFBjBYaGLRtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722766742; c=relaxed/simple;
	bh=VqVDiHRGe7S5dUvDDN4PtPEzYktCtPFF85MFvcHUAds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncXFzwDbzbpPaBJCctqwgHdHTKfmhsHyIORG0j2412qmoKPCaeseZLpZbnhCenA9feS4ZI+DsSQFHK15nxdHDDOIthSWV6cr1kEpiNOKE2Rj3BtqtRUe+7xuXey6bwNdPfYxSQjuVnNV8zBff+lshlFlu2tKh6qDxXFrxQk4izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg+qi+9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB1C32786;
	Sun,  4 Aug 2024 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722766742;
	bh=VqVDiHRGe7S5dUvDDN4PtPEzYktCtPFF85MFvcHUAds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lg+qi+9zrI/OEuRbbIEvrTbHXCMGbKim0Dz/yaLYD0Cwt4TJRS4JZjlB499FYmdsz
	 B8FZBzOz4x5KES35ndcv1oGEyIU0OKG1h6KWEzNTALvhNKPB6/ztm59cmVJ/LzoCzJ
	 Bf7eflWsUChlpaSDDL/yd0D8lBCOSLbrwrZGoOG7lPP1XW47/HOZNsPZJqm33CXzLO
	 u/Og06ZQwqhPkDouuzsMVWjZ909eq1gdCDVG1zV2EuRe/TrW9kJV9d6M/NIfv5O2X8
	 nV8m+rHr1GPs22tAskd6kxWpUbi55KZlVejpmqW8bjVi4KzTKnT0yFhgpCGHQ97aa4
	 tZez5QLD7F0Bw==
Date: Sun, 4 Aug 2024 11:18:58 +0100
From: Simon Horman <horms@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: cooldavid@cooldavid.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
Message-ID: <20240804101858.GI2504122@kernel.org>
References: <20240802054421.5428-1-yyyynoom@gmail.com>
 <20240802141534.GA2504122@kernel.org>
 <CAAjsZQwKbp-3QgBj9KEUoqLvaE5pLX8wsLq01TDC8HdVp=8pLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjsZQwKbp-3QgBj9KEUoqLvaE5pLX8wsLq01TDC8HdVp=8pLg@mail.gmail.com>

On Sat, Aug 03, 2024 at 10:47:35AM +0900, Moon Yeounsu wrote:
> On Fri, Aug 2, 2024 at 11:15 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Aug 02, 2024 at 02:44:21PM +0900, Moon Yeounsu wrote:
> > > `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> > > Therefore, we should use a well-defined function not a bit shift
> > > to find the header length.
> > >
> > > It also compress two lines at a single line.
> > >
> > > Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
> >
> > Firstly, I think this clean-up is both correct and safe.  Safe because
> > ip_hdrlen() only relies on ip_hdr(), which is already used in the same code
> > path. And correct because ip_hdrlen multiplies ihl by 4, which is clearly
> > equivalent to a left shift of 2 bits.
> Firstly, Thank you for reviewing my patch!
> >
> > However, I do wonder about the value of clean-ups for what appears to be a
> > very old driver, which hasn't received a new feature for quite sometime
> Oh, I don't know that...
> >
> > And further, I wonder if we should update this driver from "Maintained" to
> > "Odd Fixes" as the maintainer, "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
> > doesn't seem to have been seen by lore since early 2020.
> >
> > https://lore.kernel.org/netdev/20200219034801.M31679@cooldavid.org/
> Then, how about deleting the file from the kernel if the driver isn't
> maintained?

That is a bit more severe than marking it as being unmaintained
in MAINTAINERS. But I do agree that it should be considered.

> Many people think like that (At least I think so)
> There are files, and if there are issues, then have to fix them.
> Who can think unmanaged files remain in the kernel?

And yet, they do exist. ☯


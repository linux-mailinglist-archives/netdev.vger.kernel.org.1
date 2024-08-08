Return-Path: <netdev+bounces-116900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111A994C040
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B4B1C2213F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF818EFF5;
	Thu,  8 Aug 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb4FCWQs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029B25570
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128721; cv=none; b=V/5VsT4a2hhXKMRbukKDTBEiGCaVLI56U7Ue+ij1lldoGZheyrhWvy0YY17j2XfBBD5Q0jEnqv4P2Om/xW7WM0UYjoD44aB7k2jea05RQe+kmnR+RISlAsN+Lv6E3LepLtB3m+FGpIa6dmuZZPFsRuSOxUcNqVi5bzyJyYqX8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128721; c=relaxed/simple;
	bh=W02wD5JtqEp4WdOIBWnzvcXTADkJwkpzD/NUg+0zisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA/yq5FPTH22cMuiNf2JIzfhCwS4Pm6I1J+gHG5G+R8VHcONj0ehzd34Y630TPKD0bRtNm4H0UFRaFvx3dhZLDAo7ne0ddnc1ApxQQnLFTcvd/lt4W0jxvwL1Y6wu36bg4TbWq0QbJOHrfVHSnPFbjEaY5b7RfC/Gk+CBG5Is9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb4FCWQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D3C32786;
	Thu,  8 Aug 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128720;
	bh=W02wD5JtqEp4WdOIBWnzvcXTADkJwkpzD/NUg+0zisQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mb4FCWQs7h46CwxH61HoyVonazHmEgG7oMMPYldmovohfZJ4tIFjfqvE2pQyMEzSh
	 uQGNX7ihG42vVNTZHZ0uDv9rmbgnPzguo9807MeNYisoLDhUaZJOnnjbdTIw2vXKug
	 lhDBQvyb46ZFJ2dexPsQhwTwMJBSvKlPo25tcDmEfbrXviK1c7OLJCwa8px+vEJ2O0
	 0jRJPiY0YEQ9N7fmk1Gud2Y1tAJ06MIicPUQp0lReXNbkc67pX2ZXQBZ9v5jCO6S/4
	 Y9Rf3OYOB9gJg2oso4vAexqjZs2ligGuGsDJX54w1TW0Mc9YSDMVa/SOFwKNfFazrd
	 PXy597XTvr+0w==
Date: Thu, 8 Aug 2024 07:51:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Jesper Dangaard Brouer <hawk@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240808075159.4a58cc7d@kernel.org>
In-Reply-To: <CAC_iWj+z_6QZCOWv9DKZ1-ScOREtjSTzOBPw5VQCaWacJy3toQ@mail.gmail.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<CAC_iWj+G_Rrqw8R5PR3vZsL5Oid+_tzNOLOg6Hoo1jt3vhGx5A@mail.gmail.com>
	<20240808065228.4188e5d3@kernel.org>
	<CAC_iWj+z_6QZCOWv9DKZ1-ScOREtjSTzOBPw5VQCaWacJy3toQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 17:30:31 +0300 Ilias Apalodimas wrote:
> > we get_device() hoping that it will keep the IOMMU machinery active
> > (even if the device won't use the page we need to unmap it when it's
> > freed), but it sounds like IOMMU dies when driver is unbound. Even if
> > there are outstanding references to the device.
> >
> > I occasionally hit this problem reloading drivers during development,
> > TBH, too. And we have been told we "use the API wrong" so let's fix
> > it on our end?..  
> 
> It's been a while since I looked at the use cases, but I don't love
> the idea of stalling the netdev removal until sockets process all
> packets. There's a chance that the device will stay there forever.

True, my thinking is that there are 3 cases:
 - good case, nothing gets stalled
 - pages held, no IOMMU, we may make it worse, user doesn't care
 - pages held, IOMMU enabled, it would have crashed

given that we get so few reports about the third one, I tend towards
thinking that the risk of stall is somewhat limited.

> I'll have to take a closer look but the first thing that comes to mind
> is to unmap the pages early, before page_pool_destroy() is called and
> perhaps add a flag that says "the pool is there only to process
> existing packets, but you can't DMA into it anymore".

Yeah, but we need to find them... Maybe Alex knows how many rotten veg
will be thrown our way if we try to scan all struct pages, IDK if that's
considered acceptable.


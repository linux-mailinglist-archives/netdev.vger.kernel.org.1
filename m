Return-Path: <netdev+bounces-141529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C09BB415
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E56A1F21F4C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE551B21BA;
	Mon,  4 Nov 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUR0JKf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF571B21BE
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721693; cv=none; b=Uq5LmYmDDV7YbLeSWTrGsokOZy51QmmuseOuMD/5Cck7jrXuEMq/I1WA6PUGnGLZT768bG2vgqHwk2vg334vSy4QH023GtvwrKpxl/NiDYJgw2+zcnTRmsznb1w2M12sMyTjCg/HoPmzcBFVxwzmbOZ8PUdEhBzj/T7pKZi5/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721693; c=relaxed/simple;
	bh=VMet+ZKZMbB9kRXIqGRAeZC8WyYNEBBksEcEjpKHNt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVWXyVPUHwPNCCBHr2EhTC5mh600pWAPFyIwEslXRzZcvcO/CBx0qpiscS7LiRf813WXrMm37Fo0BbGxadYYQMNSlOCL6LyKb1wSB6qgzksTueud9B6Sj2FCOs3JIUZhZm02TBs5wxZ5rK6Wu2gTFV4lPlaGnvxXXkKkaEfRNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUR0JKf1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca03687fdso205255ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 04:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730721691; x=1731326491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBZ849UhGXAQ20Maj+3fLLaqA5Ylq1njMJ91T1YRFLU=;
        b=iUR0JKf1qjiBPD55BNhhuisXrsH422q2YgLRbJyQ2QTL/mH4n4FBm1apUZTcgL+1qn
         pJVgx34koXmUndJIFrhaLxN5zS5Xk/fTnd63s5SZlSPFgzH32T7M52SEZ68bp3LdgrrU
         KiXfEq8powI5PPMtvWUkPpnYWyIGw5guwpBb5WiGP4cJbYEaMjqzGMbQZkNsNQOunBFX
         fG79d5syeIEqsrupLhOW6vAUbpvl4FFsXtZQ6KD4o2pUMIR2yIgb4lhgtDpuAQog0S41
         Da/gIy4fVz46OP7uazlGSreAG5W4USFgH34DLZSSNyBQOYSahhR9tKtkr00DI1wuZCRZ
         w+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721691; x=1731326491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBZ849UhGXAQ20Maj+3fLLaqA5Ylq1njMJ91T1YRFLU=;
        b=YgiDQpunBtGnER0Y9JeOX6Jlz5/JUsYXGCCaPBHvFIq4cYdutdPTrsV2moag+0+bT0
         CTnY5ylUmYi5N5iZii6gMPjmUaWgyq3Q7VXwPP77VgXEjbjapIYbOdUjzoEQrrnhUoKB
         sBheu80xbphWG8cZrJs6AbLlGnjttS+GTR2GAOCOml00l6kPJPGyWOBksfcYcQIfJP28
         YqpTQJJIypnbRzNPOOSl/zSjKAVcedGeKzchzEExlm4RQoOcrPjJKK/B6n5mvllc8Bg2
         9XF0edFcIxrYCpoJuzkB7OEGCictriQ4bPyLyjltguNfvSBlntfML81GrSfBvAGJfgJl
         nscQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqrcbmXrFLxHbw0hULJJQcdg+Xpq50SOlPHKRCuXdrVd5PKNjJzvxCKUKy4VZPYJfm9HSE0L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Io3T0Cy6rSQZJaDPy2S2YtqgUBsb65LzDO1vBNaVt/pVYZFd
	2o6ssk+fHMUL936Gjs4Ghp7UgvALK9ZSIawBaDmLpyIIk690V7x5Y2+fm8M3qQ==
X-Gm-Gg: ASbGncspto8BFntqH/3N+k08PIIi8v7XEELncPmMhMMJWB6DgM9T/qtRDFSMT5xIwr6
	aec1hkRThLyNXFB+OmOYXIcyduGVcAvnvUdhfXyiAPKBYD+rel7sFFsbURyLbYu2AUj6lEgu1vX
	wzJrIYlqsiA7oN44DTlMfCVFzCE8Ol7iUyqzn6S1Okq+tKSdhqon4azw9KSFHyzGDitlXLuY2Mu
	J7yAqFhJOCpvt8aMui4iFUEKStiQNVPYGkSzMiDXA/PfyPDa5UjIqiPGPQufc0tpzoZVzI7tLw7
	0HHCEEwMuUg=
X-Google-Smtp-Source: AGHT+IH9N8cVhjwUeF7SpDXa4M8T9hV2JUOxyfIm3VNZdh9jllFT9vRCS00lpSDKOeoHLwlT1m6GKg==
X-Received: by 2002:a17:903:1ca:b0:20c:a5fb:7a0a with SMTP id d9443c01a7336-21134d2054fmr2537175ad.19.1730721690924;
        Mon, 04 Nov 2024 04:01:30 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110572008dsm58319505ad.114.2024.11.04.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:01:30 -0800 (PST)
Date: Mon, 4 Nov 2024 12:01:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Message-ID: <Zyi3kb_Q-0Fs9Ycw@google.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
 <069c9838-b781-4012-934a-d2626fa78212@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <069c9838-b781-4012-934a-d2626fa78212@arm.com>

On Mon, Nov 04, 2024 at 10:29:28AM +0000, Robin Murphy wrote:
> On 2024-11-04 8:21 am, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The hns3 driver started filling iommu_iotlb_gather structures itself,
> > which requires CONFIG_IOMMU_SUPPORT is enabled:
> > 
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function 'hns3_dma_map_sync':
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:14: error: 'struct iommu_iotlb_gather' has no member named 'start'
> >    395 |  iotlb_gather.start = iova;
> >        |              ^
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:14: error: 'struct iommu_iotlb_gather' has no member named 'end'
> >    396 |  iotlb_gather.end = iova + granule - 1;
> >        |              ^
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:14: error: 'struct iommu_iotlb_gather' has no member named 'pgsize'
> >    397 |  iotlb_gather.pgsize = granule;
> >        |              ^
> > 
> > Add a Kconfig dependency to make it build in random configurations.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux.dev
> > Fixes: f2c14899caba ("net: hns3: add sync command to sync io-pgtable")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I noticed that no other driver does this, so it would be good to
> > have a confirmation from the iommu maintainers that this is how
> > the interface and the dependency is intended to be used.
> 
> WTF is that patch doing!? No, random device drivers should absolutely not be
> poking into IOMMU driver internals, this is egregiously wrong and the
> correct action is to drop it entirely.

+1. Device drivers shouldn't poke into IOMMU internals.

> 
> Thanks,
> Robin.

I see that the requirement in [1] is to somehow flush / sync the iotlb
right after dma mapping an address as a work around for a HW bug, right?

I'd like to point out that the dma_map* API take care of this if the
underlying iommu implements the `iotlb_sync_map` op (check iommu_map).

Thus, in case you require it and your iommu driver does NOT support
`iotlb_sync_map`, the right way would be to add this functionality to
*that* iommu driver instead of letting the device driver poke into IOMMU

Another thing worth noting is, we do have some quirks to address broken
hardware in the iommu drivers. For example, a broken pre-fetch command
for hisilicon HI161x in arm-smmu-v3 driver[2]. Such options can be added
to iommu drivers after discussion with the relevant stakeholders.

Thanks,
Praan

[1]
 https://lore.kernel.org/netdev/20241025092938.2912958-2-shaojijie@huawei.com/

[2]
 https://elixir.bootlin.com/linux/v6.11.6/source/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#L81

> 
> > ---
> >   drivers/net/ethernet/hisilicon/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> > index 65302c41bfb1..790efc8d2de6 100644
> > --- a/drivers/net/ethernet/hisilicon/Kconfig
> > +++ b/drivers/net/ethernet/hisilicon/Kconfig
> > @@ -91,6 +91,7 @@ config HNS_ENET
> >   config HNS3
> >   	tristate "Hisilicon Network Subsystem Support HNS3 (Framework)"
> >   	depends on PCI
> > +	depends on IOMMU_SUPPORT
> >   	select NET_DEVLINK
> >   	select PAGE_POOL
> >   	help
> 
> 


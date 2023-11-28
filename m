Return-Path: <netdev+bounces-51889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485C7FCA8C
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22900B21655
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43C57331;
	Tue, 28 Nov 2023 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="L2M2Qprf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524421A5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:08:49 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-423dcd5e86bso5791391cf.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212928; x=1701817728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwfH1boRaqUSm7vYG/zdQBuuZhpN21nmfcJNTWlLUDE=;
        b=L2M2Qprf4E13EmuQfMCiF96aDL6KRUKn30A8AJ9b64X816aPXJAY9oxw7B1ln8iZHi
         48FDR+YptH8ftAV2+eOX/vl7Oe5bDpdaafnB96VWxqu5tkeNY7SunuexF2cs/fzyj/PF
         52SOZGEcxMRPEPkYoIZQOTGi2wnFe8v/w1oF10w6RQwekK+EzxkxlYt0qcfzwiJQts+H
         2tMU1YUY+TjpQSYKZH1l+OlSp3m7dzueKnbvTL7NXjfpV4JEEkxClWrtUUf4jcXVj6jt
         e7sejvPKLZx1EPf+lDFFwqdwpKQonrOaiVG5Lue0KJdEEO6Oz2qRGuU1t6eH92/gwk6X
         Cj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212928; x=1701817728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwfH1boRaqUSm7vYG/zdQBuuZhpN21nmfcJNTWlLUDE=;
        b=JCCg6R4Xxj68Wi3oJHAOTo+pt8i7gFyiMl0NsYnLjGqgYT3WAp5z7OtUqrf/ltxSyf
         Rw77NDy6AmQYv1uEQY1/YUoi6oyHes9ycuvKOcEbeXvqDp1+HvVJ2ryFhdD3tWaDm/6s
         Mcl2R12+qqbTGa4AuHfu5wh5LmupUBFVWE3vhztRrIB8XcDQQbfDpIEihuMm9oO3xwzV
         bkW9QWpPrEG0mXHGw0Hst4qLWOTKPiaDfvXw0TBTWaB9fBlBTvAH6CQ4YvWysIpltnlu
         JF73C3Ftf0A3JkGQjp6VwcDYpZIguhsPcZOxZurW6QHRbjib9MpZbhKcXPpEEdHpYU2a
         IQnw==
X-Gm-Message-State: AOJu0Yx2+VwQTeG8XAXmNHfIMHlQLP2OAa58JBEyK8+wNCTA2aeHqBFi
	+y+ziRpULOCwccDO5EiAsDzhnkzSf6QvlhaaHRjlkQ==
X-Google-Smtp-Source: AGHT+IH+DSzeg4H32kbSmeDdX42LwmFTBbiExz1cQ9Spo9pVMTh9OFSxf1oX9/Sr0tuUo1qYELK4l02okd8aqJLSMys=
X-Received: by 2002:a05:622a:d2:b0:423:7f91:3a17 with SMTP id
 p18-20020a05622a00d200b004237f913a17mr22124861qtw.21.1701212928489; Tue, 28
 Nov 2023 15:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com> <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
 <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com> <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
In-Reply-To: <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 18:08:11 -0500
Message-ID: <CA+CK2bDZUHSLWB=ec6Jdjbi+y6fD8=j96bK-kPHYKc1uiVLZWw@mail.gmail.com>
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> > This is true, however, we want to account and observe the pages
> > allocated by IOMMU subsystem for DMA buffers, as they are essentially
> > unmovable locked pages. Should we separate IOMMU memory from KVM
> > memory all together and add another field to /proc/meminfo, something
> > like "iommu -> iommu pagetable and dma memory", or do we want to
> > export DMA memory separately from IOMMU page tables?
>
> These are not allocated by "the IOMMU subsystem", they are allocated by
> the DMA API. Even if you want to claim that a driver pinning memory via
> iommu_dma_ops is somehow different from the same driver pinning the same
> amount of memory via dma-direct when iommu.passthrough=1, it's still
> nonsense because you're failing to account the pages which iommu_dma_ops
> gets from CMA, dma_common_alloc_pages(), dynamic SWIOTLB, the various
> pools, and so on.

I see, IOMMU variants are used only for discontiguous allocations, and
the common ones are defined outside of driver/iommu. Alright, I can
remove all the changes for all no-page table related IOMMU
allocations.

Pasha


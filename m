Return-Path: <netdev+bounces-51921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8917FCB02
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645DE283152
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C65C3F9;
	Tue, 28 Nov 2023 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fX+fCASa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF1E19AE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:50:40 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58cdc801f69so3642421eaf.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215438; x=1701820238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYTfkI+bm13XmNm4VDm7JNv4il6+T5S3nBbruRBN+40=;
        b=fX+fCASayAnz9s/y6EySKMP9JlABM2IIm4M5EtIiRXHeKCvQXb/5G/ut27GFa3Oxq2
         1Sld3F4EfNF9LnNovl2mKaB2MwW8gT/ggwIdpQe8icye6hAABlt/PmsTc+bZwCK2C9Vf
         J+DKW+a3oeh2L72QAgOSm1x8BgaHS+Acr+UrYKKPaca4NNBo/cMemL71HS6DaH9UPqfy
         t42Kq8g+UvQngThwZ8zIn8dduNQEczgszqPAnrhaMg6XyDbi73zometA9+u5pgLITdfA
         ew5dpaEm/NVrgvafpkIsfYrEyD8MK+xkJWQyZlunB503FSY9CBLvySosaqVx9BJqLEma
         qRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215438; x=1701820238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYTfkI+bm13XmNm4VDm7JNv4il6+T5S3nBbruRBN+40=;
        b=Ud+F3MDxxUnNeBPq4Hb4YNU3j9jzmIqCVmpFCmeqFJsPXoLN2ltyqwO7k3M+A3u8Yk
         L/101QWkWBXaIq/XX1MedFWTrBHWNEGi8T3xxXn1zgeyIjXmLKTtv08utkZO4JLmNMUz
         SjWYSVbh8brfI2IevZyZHJ8nyqOkgbIAPeJ1TKqhO1HQXdR75/kcr7ZSWYVotKLPrVBD
         lEMgR1AVCvY9xC2CVjy49zpSlo6132xCVpeK3IFgJ50Jh13nwcBNx8E6AaNdnkRyIUi9
         fYHRf+ldLp/2lgUyMKo8xSDC63zssOdAMqwOb8zsmKfFy1UwllUYNxoksqZ/s8nuqNkW
         Nhjw==
X-Gm-Message-State: AOJu0Yy7BeWQgEU/mbf2d2IHQDhi/U+Ok2xLsjKaz8NfynQnDhItTS+x
	38FVoLE+3ec73zSjR8EHhQhD1Q==
X-Google-Smtp-Source: AGHT+IGwgOr6qdtdfdMX4Rg2CnVVZBQ0aH/828IT9FkkN9y3SJG6wbzLt3OY2goWTqPUl1CtrUxcHA==
X-Received: by 2002:a05:6820:809:b0:58d:a6ed:5601 with SMTP id bg9-20020a056820080900b0058da6ed5601mr6252111oob.1.1701215438416;
        Tue, 28 Nov 2023 15:50:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id b35-20020a4a98e6000000b0058d2ea19475sm1934017ooj.11.2023.11.28.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:50:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87qf-005jHH-5R;
	Tue, 28 Nov 2023 19:50:37 -0400
Date: Tue, 28 Nov 2023 19:50:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
	m.szyprowski@samsung.com, netdev@vger.kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided
 by iommu-pages.h
Message-ID: <20231128235037.GC1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com>
 <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
 <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>

On Tue, Nov 28, 2023 at 06:00:13PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 5:53 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> > > Convert iommu/fsl_pamu.c to use the new page allocation functions
> > > provided in iommu-pages.h.
> >
> > Again, this is not a pagetable. This thing doesn't even *have* pagetables.
> >
> > Similar to patches #1 and #2 where you're lumping in configuration
> > tables which belong to the IOMMU driver itself, as opposed to pagetables
> > which effectively belong to an IOMMU domain's user. But then there are
> > still drivers where you're *not* accounting similar configuration
> > structures, so I really struggle to see how this metric is useful when
> > it's so completely inconsistent in what it's counting :/
> 
> The whole IOMMU subsystem allocates a significant amount of kernel
> locked memory that we want to at least observe. The new field in
> vmstat does just that: it reports ALL buddy allocator memory that
> IOMMU allocates. However, for accounting purposes, I agree, we need to
> do better, and separate at least iommu pagetables from the rest.
> 
> We can separate the metric into two:
> iommu pagetable only
> iommu everything
> 
> or into three:
> iommu pagetable only
> iommu dma
> iommu everything
> 
> What do you think?

I think I said this at LPC - if you want to have fine grained
accounting of memory by owner you need to go talk to the cgroup people
and come up with something generic. Adding ever open coded finer
category breakdowns just for iommu doesn't make alot of sense.

You can make some argument that the pagetable memory should be counted
because kvm counts it's shadow memory, but I wouldn't go into further
detail than that with hand coded counters..

Jason


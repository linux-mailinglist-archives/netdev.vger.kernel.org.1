Return-Path: <netdev+bounces-52317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6AE7FE475
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F61C20EB6
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12E7FB;
	Thu, 30 Nov 2023 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iOzGNPoh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2210D0
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:03:01 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1fa4e47f6c0so697746fac.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701302581; x=1701907381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=iOzGNPohtJhV5ZKZto6OPi9ScC3+3i49b+LcVuxDq9mtzkWFxOvciaUfeoR4sw7MAj
         QkroWu54eoGEksnarJc5KLNbJjo2b9/mRbC+ARswRHSJSyHf6r8cA77yjWE15tnQlLyz
         LBW/x9VdJrPUIKxS84g8k0Qs9ndFvOUUMlXB7Nqmt7sEcoM/fPyFN2BUh3cbS5mvHdg0
         VdkVOj4Kg/Qxda/ukbmSUzOpmMJI+XXCavYOg10/lBhhL0UvytuwbmpE/8guWJYyiZ+X
         V6X2LIvossUNdgs1k1Z5XJ0azlmaKkohR5dD+1WWKcXd1aFqIkEqAhpHzDOqblxLktkC
         OKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302581; x=1701907381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqaBGyfV5ntKwlfmxQAMawFx8i861c6WUBXKE0OU9B4=;
        b=a6XVnZmTcRjx/z0Yx9lqSf823LLwblhkdOFM2gM83zqUANxII0mubiINE3zE5CyeCC
         eeCSJmUKF9k/562scpFPuBJ3qSy8Xqw9IiDgM2H0j8FQv04GXjD5O+6Pc0uukhTribwN
         Dyt7OWS19QxvtrYG7orE8pKGAqps04G/VcLzp8kFAAPvddVy0y1CoSZYEVt+pTNoVsHA
         hCZmsdiqbkVLLXq3bq+Let8bIa454idCrb+PjMHIBi2OS+mu4q6GsVptzm2isE2s9yxR
         //0SsdGycZOOfik98NweYIy9KjrSaDjhRZyImtQesyhFKI2TIZqUJSIhEMu8TEqvn8jO
         Ti8g==
X-Gm-Message-State: AOJu0YxjGwlxxIMx2+b9ZsyVMXd7feSuaOpZFyo9jc13R/5nefQRv+h7
	wBgx/F70sbcseFhgX9nDvpb5Rw==
X-Google-Smtp-Source: AGHT+IH9mJrgeBca3QDmdqlZSO64E6UWuuZZMjhMVoz9rZsKA5pWXiF1aXxzzo/4HFbYhkfRvbso7A==
X-Received: by 2002:a05:6870:1603:b0:1f9:eb7e:6621 with SMTP id b3-20020a056870160300b001f9eb7e6621mr10166623oae.18.1701302580971;
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ry4-20020a056871208400b001efa3446d4esm3609159oab.43.2023.11.29.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:03:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8UWB-005qQQ-Hz;
	Wed, 29 Nov 2023 20:02:59 -0400
Date: Wed, 29 Nov 2023 20:02:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, baolu.lu@linux.intel.com,
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
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
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
	virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
	yu-cheng.yu@intel.com
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
Message-ID: <20231130000259.GS1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com>
 <20231128235254.GE1312390@ziepe.ca>
 <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC=vMU54wXz1GSzpOcLFCuX5vuE6tD49JF8cMbz4tis-g@mail.gmail.com>

On Wed, Nov 29, 2023 at 04:59:43PM -0500, Pasha Tatashin wrote:
> On Tue, Nov 28, 2023 at 6:52 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> > > Convert iommu/iommufd/* files to use the new page allocation functions
> > > provided in iommu-pages.h.
> > >
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > This is a short term allocation, it should not be counted, that is why
> > it is already not using GFP_KERNEL_ACCOUNT.
> 
> I made this change for completeness. I changed all calls to
> get_free_page/alloc_page etc under driver/iommu to use the
> iommu_alloc_* variants, this also helps future developers in this area
> to use the right allocation functions.
> The accounting is implemented using cheap per-cpu counters, so should
> not affect the performance, I think it is OK to keep them here.

Except it is a mis use of an API that should only be used for page
table memory :(

Jason


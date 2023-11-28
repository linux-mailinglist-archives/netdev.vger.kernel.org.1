Return-Path: <netdev+bounces-51924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FD7FCB18
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BC2832F7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA85C3F2;
	Tue, 28 Nov 2023 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RCU1zb38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FED198D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:53:59 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58d5979c676so2047360eaf.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215638; x=1701820438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEFdBGBIPfDPsFioHp1AVnDQQb24hQej9vfPWpRMMTA=;
        b=RCU1zb38W1lDnFGuc/2CUsbLnoo9xXAJSrXg0v2WFXuB5lsnFzUs2hH4BE6DXrHKLy
         1rMNTQ3c8Yx7INXmJNwkJaZhLhKO/fOzPqfqSYhqUZ1wnFHGOMZez+wLEERKha1Cmxzj
         UyQzurKjXdTTf8oAqDGdOV+fZleg3V/L9XhgQc9thk17Hi0vLgbgqHa9neDAf13jZW0p
         PQiRw15NyExgFvO0p88kYGEhcfN6mrm/Pu3xzZcbvMUIVdbr8ppGEf+mWabuaq+Hjj3h
         bTTDZkWzutTErpZHE26ZdRxikFAEXVLtZN+ODOHULs5bGeJvDCpk/HwhWDLl7vwzcKc3
         x1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215638; x=1701820438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEFdBGBIPfDPsFioHp1AVnDQQb24hQej9vfPWpRMMTA=;
        b=fnB4qQIGrpNqtwlIfCEIgUY4W1qD3vdjx3bNGCHqunyHm91qdAbp2SxKL83XcdMsqD
         ifO8RbahLNbiCQ33loNsZEcjW6CZhTk4OAiqZTalLO2TTj8tdH0ZoADoWkyPIxWY2PMc
         B7KcH4GoHxTJ4dRr3So0F6sQdH3oq4lLqpfdvxB9tBj+nrYiyLJDXR+LNTYgs1DgZQ2S
         ntEcvcu/iKvYHyXjX9JfwmdgNglwZ60zrTRiSzir9Fje2uYFNygpl49fPrq4gFwzlvuj
         adnFFR61LYcMvM4RgvgMf3azvJccOCeWckstTWdu1KXVXuwMWzxvKCJW3lmVneW6mh6N
         BQWg==
X-Gm-Message-State: AOJu0YwV0s3TplyYK6f3rkiuZZkXvj/aearTaSU1LK4DJSpd0iHRYRed
	ZVZqQk0iLeP03gAHAQlL/5D0aA==
X-Google-Smtp-Source: AGHT+IG+JvDO46eVb/i8IDuwEuHhA2SVxYkTSZoGtbM2c6nncwzUAA0+bA0p676nl1Is/JNEkvg0HA==
X-Received: by 2002:a05:6820:160a:b0:58d:9bb6:c38c with SMTP id bb10-20020a056820160a00b0058d9bb6c38cmr7347167oob.3.1701215638582;
        Tue, 28 Nov 2023 15:53:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id 63-20020a4a0342000000b0058ad7b0b1a8sm2117307ooi.13.2023.11.28.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:53:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87tt-005jIw-Fu;
	Tue, 28 Nov 2023 19:53:57 -0400
Date: Tue, 28 Nov 2023 19:53:57 -0400
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
Subject: Re: [PATCH 16/16] vfio: account iommu allocations
Message-ID: <20231128235357.GF1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-17-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128204938.1453583-17-pasha.tatashin@soleen.com>

On Tue, Nov 28, 2023 at 08:49:38PM +0000, Pasha Tatashin wrote:
> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

You should send the seperately and directly to Alex.

Jason


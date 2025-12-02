Return-Path: <netdev+bounces-243285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D79C9C84A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08184E3AD3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506142D592E;
	Tue,  2 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5xvNIWf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759542D1F5E
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698197; cv=none; b=cyxFjL18DwcWEmV1v4a8/wl20dR0PR09PzM97/FMCS2GfltNFVPosegdx3z8M5GrxX2OpXYlBv+s9gfpuBz8X5HmORxfDR/jV5hbkeNVd5GfsaUN2gbCM9vZ1oTCbPfAMBMC51BiWzKAflz5L4yq9PsNJZPqKB5nWNC/hihgWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698197; c=relaxed/simple;
	bh=gZ+Brvw6pzH0M1d3K6QDW4DtiuRy/OTyA5sJrBWC8Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzTqQqi/jGC01MnU7eAIi+YYVqbvHZH0JdZqWnQcfkMMICNZYXGrEuP4URPcaLYp+9jfvfkqQDSPaVt2P662zND0gDkg7q61Qm139J0vaPSe6V+qmtOcUqSbiAUQUkwnDid4MR9wh8+qJbG0YjAkwQYRfwc5MU+r9/Vir9oKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5xvNIWf; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63fc72db706so4783660d50.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698194; x=1765302994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ithlbIiEq/FI2LL3XrBJ6TyWmZcusp7vhJwcVLoEBM4=;
        b=X5xvNIWfNBOCVFJCKsuYEJN4nNf/MlBDcJVdBqv6Up8TVZDv9XL0iYnjeA1kFLK+xR
         R/Mmnmf8P00bjaqpGT3KAhH8b0DPW3HOHhlXfhcIuhHXpdOyXM8faMrD017YntwrZOws
         Lilbxx7j6JIKph5H4KZB0cOcS6e+uRRf97YimaRFXt1EELH9AJSGTS9fXGGOXGH8cUbm
         Wkg5y8C06xp/FikszPTntzzvw+jbRW/KtxkbI1Ru41Rfau79B0987B/dUYVHITg/wt5i
         3VbX4qQqgjb7BTH0LhguXF/X/kaJlxU/TzlNdWHudzZLdwznuAXBUpXO3K9gSurUkuXt
         FiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698194; x=1765302994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ithlbIiEq/FI2LL3XrBJ6TyWmZcusp7vhJwcVLoEBM4=;
        b=EjyMGoMDxadwrc/jl0FjSzJmGBTB9rD5lZN2SKuIeY+G3pTOIrQt3vnjGFuWwJ6lHm
         bixPGjyHcFtdLI6M4ONcf7CvnLmlsUFu8WfGXvhUWySrsFZlSKP7QiNZbN2ohjA5f2ll
         nJNvtsRBJSwLyfMdHQMP/geLlW4fsiDOnsb4Trt7eCuRCAQPl7pk7ZSAGki28X1Qi7Y/
         gpPSK7JlvbUdJRuz6FCkbeIPLXYbvOy3SAQFDp9BSz5LDsFZPDP6GxEzDPV56s8q3L9l
         Bf4wmc6k3b4U7rbf/WEDGr5sOWdUV/i1q11TUhqCRCNOi6FfEwCak6C1ZGPxdOoBpyIO
         22iw==
X-Forwarded-Encrypted: i=1; AJvYcCUjTeIpgf5DZ9JVovphvhXgHByrNtIrr+wFjt03A8Z+k5yH/vQBQ20C/VJTFsvg3QsnJSqVVeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5C97OXqkduTe1Tv+BGbRV0+QoV1yU8ywQa+JTrdza1xiQbdl
	VchssjCk/ilGgrvRIYWBf8oYB0tIu640BttlaoPrTl7wC5R3bxRsOiW8
X-Gm-Gg: ASbGncthVfKjsNE9bMTiK8Z2RNnvxUCxwIqPDQKX8/vxwgjodlKUsuhpY1A1hdVKvtP
	ODDqAoUbS2d5LOsSQtUJOyy9dhlgVllmoidKfRB8f6AOOASg1r09DxgkZsu7STYGhGUvZh62C6i
	Zq90X6WhatibDirQig96GPnMNh1elpod5hm3E/aih20AWhk+s9tYnJcnbzajt41SsnOPrtMKo9S
	MSMIY1bXHrOGiKQAThs8Uuk2PnMpp1jo/KnBxmJbwrc7cyKCPnx8DFVlKgXseW87EllZCNk83Cw
	FFBMrefee7DGD8X8EjS0w9FPFU+QfBAtTDzaFiN/9NiBvxKlUq+Pn/g4q21DioGk/7tVNswozI7
	CQ4qayY4psA+DLeVJJ6V18VUIQjMKG+ywG0CPBSUMFCtxEssq+zh4hPcCfoWG9jQrxGozKQnLhW
	AOrOGuh2JCUMnO67yUQm3dv9Xn5yLxbpC+9+0ueiPrUxkRE+w=
X-Google-Smtp-Source: AGHT+IHvQT1QI9TdiXKfZ68wlKamcPDrfQTrBswbbjSU6kRBe9Kysk7H9AxfecqUja0yhfUS62M5lQ==
X-Received: by 2002:a05:690e:191d:b0:640:d119:d339 with SMTP id 956f58d0204a3-6432926b302mr21611358d50.33.1764698194211;
        Tue, 02 Dec 2025 09:56:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad100e94fsm65771557b3.32.2025.12.02.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:56:33 -0800 (PST)
Date: Tue, 2 Dec 2025 09:56:32 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next] net: devmem: convert binding refcount to
 percpu_ref
Message-ID: <aS8oUIPqOsLun0mU@devvm11784.nha0.facebook.com>
References: <20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com>
 <aS3Md9EuAGIl8Bd0@mini-arch>
 <871f34ca-e417-4e46-8593-b3e10b64b8b9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871f34ca-e417-4e46-8593-b3e10b64b8b9@redhat.com>

On Tue, Dec 02, 2025 at 11:52:06AM +0100, Paolo Abeni wrote:
> On 12/1/25 6:12 PM, Stanislav Fomichev wrote:
> > On 11/26, Bobby Eshleman wrote:
> >> From: Bobby Eshleman <bobbyeshleman@meta.com>
> >>
> >> Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
> >> to optimize common-case reference counting on the hot path.
> >>
> >> The typical devmem workflow involves binding a dmabuf to a queue
> >> (acquiring the initial reference on binding->ref), followed by
> >> high-volume traffic where every skb fragment acquires a reference.
> >> Eventually traffic stops and the unbind operation releases the initial
> >> reference. Additionally, the high traffic hot path is often multi-core.
> >> This access pattern is ideal for percpu_ref as the first and last
> >> reference during bind/unbind and normally book-ends activity in the hot
> >> path.
> >>
> >> __net_devmem_dmabuf_binding_free becomes the percpu_ref callback invoked
> >> when the last reference is dropped.
> >>
> >> kperf test:
> >> - 4MB message sizes
> >> - 60s of workload each run
> >> - 5 runs
> >> - 4 flows
> >>
> >> Throughput:
> >> 	Before: 45.31 GB/s (+/- 3.17 GB/s)
> >> 	After: 48.67 GB/s (+/- 0.01 GB/s)
> >>
> >> Picking throughput-matched kperf runs (both before and after matched at
> >> ~48 GB/s) for apples-to-apples comparison:
> >>
> >> Summary (averaged across 4 workers):
> >>
> >>   TX worker CPU idle %:
> >>     Before: 34.44%
> >>     After: 87.13%
> >>
> >>   RX worker CPU idle %:
> >>     Before: 5.38%
> >>     After: 9.73%
> >>
> >> kperf before:
> >>
> >> client: == Source
> >> client:   Tx 98.100 Gbps (735764807680 bytes in 60001149 usec)
> >> client:   Tx102.798 Gbps (770996961280 bytes in 60001149 usec)
> >> client:   Tx101.534 Gbps (761517834240 bytes in 60001149 usec)
> >> client:   Tx 82.794 Gbps (620966707200 bytes in 60001149 usec)
> >> client:   net CPU 56: usr: 0.01% sys: 0.12% idle:17.06% iow: 0.00% irq: 9.89% sirq:72.91%
> >> client:   app CPU 60: usr: 0.08% sys:63.30% idle:36.24% iow: 0.00% irq: 0.30% sirq: 0.06%
> >> client:   net CPU 57: usr: 0.03% sys: 0.08% idle:75.68% iow: 0.00% irq: 2.96% sirq:21.23%
> >> client:   app CPU 61: usr: 0.06% sys:67.67% idle:31.94% iow: 0.00% irq: 0.28% sirq: 0.03%
> >> client:   net CPU 58: usr: 0.01% sys: 0.06% idle:76.87% iow: 0.00% irq: 2.84% sirq:20.19%
> >> client:   app CPU 62: usr: 0.06% sys:69.78% idle:29.79% iow: 0.00% irq: 0.30% sirq: 0.05%
> >> client:   net CPU 59: usr: 0.06% sys: 0.16% idle:74.97% iow: 0.00% irq: 3.76% sirq:21.03%
> >> client:   app CPU 63: usr: 0.06% sys:59.82% idle:39.80% iow: 0.00% irq: 0.25% sirq: 0.05%
> >> client: == Target
> >> client:   Rx 98.092 Gbps (735764807680 bytes in 60006084 usec)
> >> client:   Rx102.785 Gbps (770962161664 bytes in 60006084 usec)
> >> client:   Rx101.523 Gbps (761499566080 bytes in 60006084 usec)
> >> client:   Rx 82.783 Gbps (620933136384 bytes in 60006084 usec)
> >> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:24.51% iow: 0.00% irq: 1.67% sirq:73.79%
> >> client:   app CPU  6: usr: 1.51% sys:96.43% idle: 1.13% iow: 0.00% irq: 0.36% sirq: 0.55%
> >> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:25.18% iow: 0.00% irq: 1.99% sirq:72.80%
> >> client:   app CPU  5: usr: 2.21% sys:94.54% idle: 2.54% iow: 0.00% irq: 0.38% sirq: 0.30%
> >> client:   net CPU  3: usr: 0.00% sys: 0.01% idle:26.34% iow: 0.00% irq: 2.12% sirq:71.51%
> >> client:   app CPU  7: usr: 2.22% sys:94.28% idle: 2.52% iow: 0.00% irq: 0.59% sirq: 0.37%
> >> client:   net CPU  0: usr: 0.00% sys: 0.03% idle: 0.00% iow: 0.00% irq:10.44% sirq:89.51%
> >> client:   app CPU  4: usr: 2.39% sys:81.46% idle:15.33% iow: 0.00% irq: 0.50% sirq: 0.30%
> >>
> >> kperf after:
> >>
> >> client: == Source
> >> client:   Tx 99.257 Gbps (744447016960 bytes in 60001303 usec)
> >> client:   Tx101.013 Gbps (757617131520 bytes in 60001303 usec)
> >> client:   Tx 88.179 Gbps (661357854720 bytes in 60001303 usec)
> >> client:   Tx101.002 Gbps (757533245440 bytes in 60001303 usec)
> >> client:   net CPU 56: usr: 0.00% sys: 0.01% idle: 6.22% iow: 0.00% irq: 8.68% sirq:85.06%
> >> client:   app CPU 60: usr: 0.08% sys:12.56% idle:87.21% iow: 0.00% irq: 0.08% sirq: 0.05%
> >> client:   net CPU 57: usr: 0.00% sys: 0.05% idle:69.53% iow: 0.00% irq: 2.02% sirq:28.38%
> >> client:   app CPU 61: usr: 0.11% sys:13.40% idle:86.36% iow: 0.00% irq: 0.08% sirq: 0.03%
> >> client:   net CPU 58: usr: 0.00% sys: 0.03% idle:70.04% iow: 0.00% irq: 3.38% sirq:26.53%
> >> client:   app CPU 62: usr: 0.10% sys:11.46% idle:88.31% iow: 0.00% irq: 0.08% sirq: 0.03%
> >> client:   net CPU 59: usr: 0.01% sys: 0.06% idle:71.18% iow: 0.00% irq: 1.97% sirq:26.75%
> >> client:   app CPU 63: usr: 0.10% sys:13.10% idle:86.64% iow: 0.00% irq: 0.10% sirq: 0.05%
> >> client: == Target
> >> client:   Rx 99.250 Gbps (744415182848 bytes in 60003297 usec)
> >> client:   Rx101.006 Gbps (757589737472 bytes in 60003297 usec)
> >> client:   Rx 88.171 Gbps (661319475200 bytes in 60003297 usec)
> >> client:   Rx100.996 Gbps (757514792960 bytes in 60003297 usec)
> >> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:28.02% iow: 0.00% irq: 1.95% sirq:70.00%
> >> client:   app CPU  6: usr: 2.03% sys:87.20% idle:10.04% iow: 0.00% irq: 0.37% sirq: 0.33%
> >> client:   net CPU  3: usr: 0.00% sys: 0.00% idle:27.63% iow: 0.00% irq: 1.90% sirq:70.45%
> >> client:   app CPU  7: usr: 1.78% sys:89.70% idle: 7.79% iow: 0.00% irq: 0.37% sirq: 0.34%
> >> client:   net CPU  0: usr: 0.00% sys: 0.01% idle: 0.00% iow: 0.00% irq: 9.96% sirq:90.01%
> >> client:   app CPU  4: usr: 2.33% sys:83.51% idle:13.24% iow: 0.00% irq: 0.64% sirq: 0.26%
> >> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:27.60% iow: 0.00% irq: 1.94% sirq:70.43%
> >> client:   app CPU  5: usr: 1.88% sys:89.61% idle: 7.86% iow: 0.00% irq: 0.35% sirq: 0.27%
> >>
> >> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >> ---
> >>  net/core/devmem.c | 38 +++++++++++++++++++++++++++++++++-----
> >>  net/core/devmem.h | 18 ++++++++++--------
> >>  2 files changed, 43 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/net/core/devmem.c b/net/core/devmem.c
> >> index 1d04754bc756..83989cf4a987 100644
> >> --- a/net/core/devmem.c
> >> +++ b/net/core/devmem.c
> >> @@ -54,10 +54,26 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
> >>  	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
> >>  }
> >>  
> >> -void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> >> +/*
> >> + * percpu_ref release callback invoked when the last reference to the binding
> >> + * is dropped. Schedules the actual cleanup in a workqueue because
> >> + * ref->release() cb is not allowed to sleep as it may be called in RCU
> >> + * callback context.
> >> + */
> > 
> > Can we drop this and the rest of the comments? I feel like they mostly
> > explain how percpu_ref works, nothing devmem specific.
> 
> I agree with Stan, the code looks good, but the comments are a bit
> distracting. It should be assumed that people touching this code has
> read/studied percpu_ref documentation.
> 
> Please strip them, thanks!
> 
> Paolo
> 

Sounds good!

Best,
Bobby


Return-Path: <netdev+bounces-248257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F66D0605B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3003013EA4
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70532ED28;
	Thu,  8 Jan 2026 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRihcpir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76111328614
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903520; cv=none; b=Esy+C3vb6mm4/nl3sPAM1VAI8RB5lMhfJCrak9xgxbiFM4iIycoDJr2X7Ob5+/oFEtQIXQZB5ljEVD6jTHiZ10X8Mx7YVVr/4v70FH10DP2/C8kSuz9xcZm/5qh6mqXZ1KgA53Shmfu2kbFdTeRURPRy9NiiDTJuagmTXKj38kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903520; c=relaxed/simple;
	bh=eMZuMbnvTpupe3z4sL/3yulIjCVyOBiMl0XNVcweEro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smkyNNdF2N9pI1cvPFEueF2+wj/uGFJBdQYDY8Cs4OJzISmRfmLzoO0CeDflTxOYJ7D6NX8BJsR70V9VXECN3YGJfeY2rntFpwyKJFsuxc8Q2op85vtoVGv1CHOMn2E7SvD5eCQLkSYOou8y54d6M6oja0aOZldsB60DgvkXFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRihcpir; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12056277571so3835751c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767903517; x=1768508317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEV94PZ/KmCPCiILrgkVyejWUU/HBZTW+bNvgP5cVxM=;
        b=SRihcpirg88znFnf7ymmXQH95DVPkToNTrpohc+42U0u9c1wXwxKuurfBA3jhLcr9R
         /DdXSCIWulqZceHZTUHNx8gECtW3nH6DJRGQquLLtOzWO2vVAocyz7Nv1pIEoMGT+qzZ
         nB7O1ilPZ0OCiF5mXcOQ537tMy5+wtZWsG9oAnuMGXjSTpHH3IaHuW8sUxc2u6WCy7mr
         r9rHhb0qtnArJ0jIqCrUXfbutSg0YNIs0qHsRI9qcprNxApjZx0b0tfPq96+gkizmw8B
         FsGyeY50Ty4NdFvRGy1XI5xEvcs7zXL8guSo6ZPZIsk22nlc3FURHfLvmr78ToM0VuJR
         GAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767903517; x=1768508317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEV94PZ/KmCPCiILrgkVyejWUU/HBZTW+bNvgP5cVxM=;
        b=A0JzWQiGswJkAA7jyh/kYAMnWEbn1GduU03bZ6wwQu2C+pRpfJ/TxjqgtGz2XWxgJ+
         qNHhMWrKNKFxgC0xhTdHUriEaCkqsoguUdkk8JiEvrn4jDVyYUF0vMcg19PzrtVZCTcd
         Iakuef3Fjw7Rms8V9RcmL2yXm9UwDITcNT3YG7W95KgstwvOofF0bi0VV55Tj6avB1iu
         70IFjA6euRYk4k30jSBdi751puUZPqqRlXDBTkSRIw2Vm1UfYpC9g1gl3tCyf3y09UXy
         gzV2yZUmdX5OZYNfVFxzdXtF127Tkvx/Rte2S87ADLkqz7utwv61eG7hBioOWMq5zMZR
         Bcyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQBj1LUHHT05RnjA6FA1L3Uvt/JAxG/KF0GaMP1RPiwHg6lWgmzq6UEK3i5+j95hoRCsNw6+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkhX09mO1O5IZW24gAskRGG5Y/OCASdzR8cugLsJwfAbZqUjB
	IYDKuuWd1h2N2dbEgINnDpKcviAONLCMGF+rvVvOrdMUbx3JGk3JlRM=
X-Gm-Gg: AY/fxX7X7x3SqtEeqaW9T8QhUiPj429Kzh/l4k7IJH+H22Z+A2eX3kf6krUiGAuP9i1
	VO/cOvZgpmbWd1jKp7dMOEp6+lvTHrWEI1KlY5pyPvOvBWzRnNJrEQ8lIRhPMl+GDcXuJsvMkHA
	X9huBQSJQoVOPsidERT14/BCnO8FFqnJCWpD4eIyuM+fD8AFKh9M+BZ0456xNb6dCmL8wSWZQ7t
	AvlXlQRzjyDj51lcuDSYJPwFdnjM+QfwufN0hbmr9EaYcEOWHqKlIk4qZpN4/48MlDOul8upLha
	yoewqSJx1pkrHnbfUt9fhQHRsWendB6uWHLuytucvjv8mE31oPtItQOC2uP/W8Uh8XrHx9na7gL
	jCxiIlE1X7XYhID4ivevAAC0qK5zJGAQTZsD3yhu33B14SaN6wsNhthrF3MQhroMvjFiHjZPm/B
	5sklO2BiNRhSITrFjwDXnfQSgZD6BC2cSSH0XZ0//HTNwqdnPkC0wVQ+9hhlgkpkn4AfFyHtSa/
	b1ynA==
X-Google-Smtp-Source: AGHT+IFUQi0BrfT68h0C2uHqNHZmyyN+toZqSmeX8bW0JvZ5hvF4JdUCKUKVcLcElvTT5rqIfY6TvQ==
X-Received: by 2002:a05:7022:43a1:b0:11e:3e9:3e9f with SMTP id a92af1059eb24-121f8b9aedamr5501314c88.50.1767903516937;
        Thu, 08 Jan 2026 12:18:36 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm15476361c88.5.2026.01.08.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:18:36 -0800 (PST)
Date: Thu, 8 Jan 2026 12:18:35 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RESEND net-next v2] net: devmem: convert binding refcount
 to percpu_ref
Message-ID: <aWARGwnF3z-ix35V@mini-arch>
References: <20260107-upstream-precpu-ref-v2-v2-1-a709f098b3dc@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107-upstream-precpu-ref-v2-v2-1-a709f098b3dc@meta.com>

On 01/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
> to optimize common-case reference counting on the hot path.
> 
> The typical devmem workflow involves binding a dmabuf to a queue
> (acquiring the initial reference on binding->ref), followed by
> high-volume traffic where every skb fragment acquires a reference.
> Eventually traffic stops and the unbind operation releases the initial
> reference. Additionally, the high traffic hot path is often multi-core.
> This access pattern is ideal for percpu_ref as the first and last
> reference during bind/unbind normally book-ends activity in the hot
> path.
> 
> __net_devmem_dmabuf_binding_free becomes the percpu_ref callback invoked
> when the last reference is dropped.
> 
> kperf test:
> - 4MB message sizes
> - 60s of workload each run
> - 5 runs
> - 4 flows
> 
> Throughput:
> 	Before: 45.31 GB/s (+/- 3.17 GB/s)
> 	After: 48.67 GB/s (+/- 0.01 GB/s)
> 
> Picking throughput-matched kperf runs (both before and after matched at
> ~48 GB/s) for apples-to-apples comparison:
> 
> Summary (averaged across 4 workers):
> 
>   TX worker CPU idle %:
>     Before: 34.44%
>     After: 87.13%
> 
>   RX worker CPU idle %:
>     Before: 5.38%
>     After: 9.73%
> 
> kperf before:
> 
> client: == Source
> client:   Tx 98.100 Gbps (735764807680 bytes in 60001149 usec)
> client:   Tx102.798 Gbps (770996961280 bytes in 60001149 usec)
> client:   Tx101.534 Gbps (761517834240 bytes in 60001149 usec)
> client:   Tx 82.794 Gbps (620966707200 bytes in 60001149 usec)
> client:   net CPU 56: usr: 0.01% sys: 0.12% idle:17.06% iow: 0.00% irq: 9.89% sirq:72.91%
> client:   app CPU 60: usr: 0.08% sys:63.30% idle:36.24% iow: 0.00% irq: 0.30% sirq: 0.06%
> client:   net CPU 57: usr: 0.03% sys: 0.08% idle:75.68% iow: 0.00% irq: 2.96% sirq:21.23%
> client:   app CPU 61: usr: 0.06% sys:67.67% idle:31.94% iow: 0.00% irq: 0.28% sirq: 0.03%
> client:   net CPU 58: usr: 0.01% sys: 0.06% idle:76.87% iow: 0.00% irq: 2.84% sirq:20.19%
> client:   app CPU 62: usr: 0.06% sys:69.78% idle:29.79% iow: 0.00% irq: 0.30% sirq: 0.05%
> client:   net CPU 59: usr: 0.06% sys: 0.16% idle:74.97% iow: 0.00% irq: 3.76% sirq:21.03%
> client:   app CPU 63: usr: 0.06% sys:59.82% idle:39.80% iow: 0.00% irq: 0.25% sirq: 0.05%
> client: == Target
> client:   Rx 98.092 Gbps (735764807680 bytes in 60006084 usec)
> client:   Rx102.785 Gbps (770962161664 bytes in 60006084 usec)
> client:   Rx101.523 Gbps (761499566080 bytes in 60006084 usec)
> client:   Rx 82.783 Gbps (620933136384 bytes in 60006084 usec)
> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:24.51% iow: 0.00% irq: 1.67% sirq:73.79%
> client:   app CPU  6: usr: 1.51% sys:96.43% idle: 1.13% iow: 0.00% irq: 0.36% sirq: 0.55%
> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:25.18% iow: 0.00% irq: 1.99% sirq:72.80%
> client:   app CPU  5: usr: 2.21% sys:94.54% idle: 2.54% iow: 0.00% irq: 0.38% sirq: 0.30%
> client:   net CPU  3: usr: 0.00% sys: 0.01% idle:26.34% iow: 0.00% irq: 2.12% sirq:71.51%
> client:   app CPU  7: usr: 2.22% sys:94.28% idle: 2.52% iow: 0.00% irq: 0.59% sirq: 0.37%
> client:   net CPU  0: usr: 0.00% sys: 0.03% idle: 0.00% iow: 0.00% irq:10.44% sirq:89.51%
> client:   app CPU  4: usr: 2.39% sys:81.46% idle:15.33% iow: 0.00% irq: 0.50% sirq: 0.30%
> 
> kperf after:
> 
> client: == Source
> client:   Tx 99.257 Gbps (744447016960 bytes in 60001303 usec)
> client:   Tx101.013 Gbps (757617131520 bytes in 60001303 usec)
> client:   Tx 88.179 Gbps (661357854720 bytes in 60001303 usec)
> client:   Tx101.002 Gbps (757533245440 bytes in 60001303 usec)
> client:   net CPU 56: usr: 0.00% sys: 0.01% idle: 6.22% iow: 0.00% irq: 8.68% sirq:85.06%
> client:   app CPU 60: usr: 0.08% sys:12.56% idle:87.21% iow: 0.00% irq: 0.08% sirq: 0.05%
> client:   net CPU 57: usr: 0.00% sys: 0.05% idle:69.53% iow: 0.00% irq: 2.02% sirq:28.38%
> client:   app CPU 61: usr: 0.11% sys:13.40% idle:86.36% iow: 0.00% irq: 0.08% sirq: 0.03%
> client:   net CPU 58: usr: 0.00% sys: 0.03% idle:70.04% iow: 0.00% irq: 3.38% sirq:26.53%
> client:   app CPU 62: usr: 0.10% sys:11.46% idle:88.31% iow: 0.00% irq: 0.08% sirq: 0.03%
> client:   net CPU 59: usr: 0.01% sys: 0.06% idle:71.18% iow: 0.00% irq: 1.97% sirq:26.75%
> client:   app CPU 63: usr: 0.10% sys:13.10% idle:86.64% iow: 0.00% irq: 0.10% sirq: 0.05%
> client: == Target
> client:   Rx 99.250 Gbps (744415182848 bytes in 60003297 usec)
> client:   Rx101.006 Gbps (757589737472 bytes in 60003297 usec)
> client:   Rx 88.171 Gbps (661319475200 bytes in 60003297 usec)
> client:   Rx100.996 Gbps (757514792960 bytes in 60003297 usec)
> client:   net CPU  2: usr: 0.00% sys: 0.01% idle:28.02% iow: 0.00% irq: 1.95% sirq:70.00%
> client:   app CPU  6: usr: 2.03% sys:87.20% idle:10.04% iow: 0.00% irq: 0.37% sirq: 0.33%
> client:   net CPU  3: usr: 0.00% sys: 0.00% idle:27.63% iow: 0.00% irq: 1.90% sirq:70.45%
> client:   app CPU  7: usr: 1.78% sys:89.70% idle: 7.79% iow: 0.00% irq: 0.37% sirq: 0.34%
> client:   net CPU  0: usr: 0.00% sys: 0.01% idle: 0.00% iow: 0.00% irq: 9.96% sirq:90.01%
> client:   app CPU  4: usr: 2.33% sys:83.51% idle:13.24% iow: 0.00% irq: 0.64% sirq: 0.26%
> client:   net CPU  1: usr: 0.00% sys: 0.01% idle:27.60% iow: 0.00% irq: 1.94% sirq:70.43%
> client:   app CPU  5: usr: 1.88% sys:89.61% idle: 7.86% iow: 0.00% irq: 0.35% sirq: 0.27%
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> I previously sent this out after the merge window closed. This is
> unchanged from that rev, so I left it the same version and added
> RESEND, though I'm not entirely sure if that was correct...
> ---
> Changes in v2:
> - remove comments (Stan and Paolo)
> - fix grammar error in commit msg
> - avoid unnecessary name change of work_struct wq
> - Link to v1:
>   https://lore.kernel.org/r/20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


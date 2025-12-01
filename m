Return-Path: <netdev+bounces-243032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D4C98737
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 18:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D743A55C4
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916F336EFD;
	Mon,  1 Dec 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+r7ORPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F72336ED8
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609148; cv=none; b=KioKK2LpyLN1a/pPnGK/CJiNFFK2qeosUSytq3smw6kp9hSg3l/eEuoyTTiuCuTvG8lwJ4A6Sko01p8iQUOUDuW2vovNEgz5ofd5vrV9EGvQAe/ZuipoXn4JVis5AWNKO+ag0pgNE66QCLptxLcINPa9CU6VHy+GBUJ2DCgWNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609148; c=relaxed/simple;
	bh=x4D5NP6Zfja3G7Plx+Ch0EnKti5y4jSVxb1S2Q1yCiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFsHsR7yy11V1YaS4FNNoQ8EhIHElKO3FXsNEmPttBOSZF2QU+3Y15+QEn+Q+dZZ/8bMON0zG3Gr5XtXeU15MGcBUJhLQKSPItwNASFPhBPF9mlPQ8tTiru5GOl1+6vJfE5gKMMjCiJvEft4sm+EZvOn/fTyg223xxv16QoIJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+r7ORPN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aad4823079so3892150b3a.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764609145; x=1765213945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHc3eGxg1AfMkOsYgenDDiadYC8vBUdnmiqv6Jul2Wc=;
        b=d+r7ORPNm+t2o4pydxo8YzdX5wVPHw3FfSCHztFix+6qdKcFiATJhWf75DLbSrV9xx
         gOQFz4sYDzZTcpxwYuLWX4+fl09yJed5YUXvXCZeWiZxbZynqfjzvowW2D4YxbwgZ4he
         KA2SLykXYP6mMc12KvSju0YE/SAhkGQEB4648zfZ8QzoaxFylcWKg8sV0dq5kb4Z6IGU
         IBokmUiYQ7TFqV5roIlCRMcllq88WClc+0NKzH6wa4I3Mc2bghhx2synkXgtzKYjudKs
         uxPz4/zOad4uqEC0zVUxglfs2JUvgnG8axGNVCTWaXxCASRkmb3ZcQcD3BEhYGbrtSxZ
         NYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764609145; x=1765213945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHc3eGxg1AfMkOsYgenDDiadYC8vBUdnmiqv6Jul2Wc=;
        b=KULBNjOqujzX0Mnv3JwOiU9qFZI5KiOI/JiLUz1YrCdde7QWLsfoGyDHOVgHtDL/CB
         Gs67GcHSXjhp69IvO2q81IjYWm5e5YPOamvPJsegFZHwhMTKu52Ztl45kMRRWNowInxw
         H8PxEYn174+KPmHAVIOxUirkSdLKix/DiprYXzi163AfPIoitB4hRitaKA5na6DXT6r1
         5EtY+u4wj0a5bmIrgcnSwAipIpsBZHXveAZtz1McJXDyMaCqT1d7XxCOEkj2qt03WpEi
         KIpG7mQFfxJ8agsVnGesEsQp+tlVF0SE4ACFIt1rjcdC3gK4+udUDvo8UQho4hYiJ7H5
         C1SA==
X-Forwarded-Encrypted: i=1; AJvYcCVStGzPdzm+4Z6jQ/ZSj6NARm1TScrRA+YibSvjsXYtCZi2/IwCPQX19ozndULkWl4X48iDwUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/FgFqafc/Yi2CdaZ+UjxY1Q82+MdKMy+tQscUKAHl+Q6Zbjg
	JjmdMDTl9dKJXHFfsGm/cae5MhRYcoT00RvXD6kAJg6C94nfUli4Yfg=
X-Gm-Gg: ASbGncsTStxiLPreaGtasJDOt20gArtkSz5mLR/xaGWHv7m843F3+OElf65ogv5U3G6
	zrP0JIS8BpHCV96KE8bgjSUw2okrqS+9qjflOkiMS2Qiv9tV2uVaLYiE06XXqOWWLAaOZAq0q/y
	is+ehtT8683nqYzr4UhwZaC1qA4YpEQRsoCSgoJ9c56R5++y5d6zokWJdkVDwWJQODaHlJQXS7/
	cincVBbg+b+oQa26VePnR5rqF4t9YZh/myvAseLS5M+4b363bSgebkGOS7Y/J/rfm/47V/Tv5vU
	0e+BoHgXEsFQ0tPkL7SUYVH4FrKeg/88Z4vTCk10R1/EqYVPerTIqsPcQyd7qaWd14n/901zAcW
	04uYaBjdLQaVJzqSuvhHLzyAN2kihK0Ku+9WIrEc1mTRcyc89/U48q7be4wenyKkNVyIXkSog8w
	afKzWl2nXysbVqlv1qra0ccfNxHZbyQI8+xS+PW/5V04F7q0zjOP3y0pynpcQAB81hoeT60WhIQ
	JsS18ikhoJMJZ4LOKdRQVN82bagozTC1hLMb5BeXeAc/mH4wsbeXlbkHl/5FELhhd4=
X-Google-Smtp-Source: AGHT+IFwjSGG3Dt/eYj9hHvToQyaoBJtTmfyRd5eGjpq3DqcECFM1du4NT1sGE/IGpfMkgQ3fX0hxw==
X-Received: by 2002:a05:6a20:914d:b0:35d:3b70:7629 with SMTP id adf61e73a8af0-36150e5fe3bmr41001862637.18.1764609144637;
        Mon, 01 Dec 2025 09:12:24 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f17877dsm13986405b3a.52.2025.12.01.09.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:12:24 -0800 (PST)
Date: Mon, 1 Dec 2025 09:12:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next] net: devmem: convert binding refcount to
 percpu_ref
Message-ID: <aS3Md9EuAGIl8Bd0@mini-arch>
References: <20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126-upstream-percpu-ref-v1-1-cea20a92b1dd@meta.com>

On 11/26, Bobby Eshleman wrote:
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
> reference during bind/unbind and normally book-ends activity in the hot
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
>  net/core/devmem.c | 38 +++++++++++++++++++++++++++++++++-----
>  net/core/devmem.h | 18 ++++++++++--------
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 1d04754bc756..83989cf4a987 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -54,10 +54,26 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>  	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
>  }
>  
> -void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> +/*
> + * percpu_ref release callback invoked when the last reference to the binding
> + * is dropped. Schedules the actual cleanup in a workqueue because
> + * ref->release() cb is not allowed to sleep as it may be called in RCU
> + * callback context.
> + */

Can we drop this and the rest of the comments? I feel like they mostly
explain how percpu_ref works, nothing devmem specific.

refcnt-wise, feels like the only place that deserves a comment is
net_devmem_get_net_iov (why it's safe to ignore
net_devmem_dmabuf_binding_get return value, but you are not touching that..)

Otherwise LGTM!


Return-Path: <netdev+bounces-117839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347F94F829
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E930281252
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9119307E;
	Mon, 12 Aug 2024 20:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F5186E30;
	Mon, 12 Aug 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494210; cv=none; b=Y3n5ek6T0d/3V83vABgHJ7RbK2lrQLOmuCu10z6R5l4lxZCpUxN9SW96wX3LoTiEEZQtH6OtPZXtwiW0pSFeBGmXrTPvK1XOnk6oY9bSWZP7zaeybS/2P7EbOQEuqbeX6yMJkVb2MxQR3Nsjo6kY40kmwafYGJFtzSssEqhu3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494210; c=relaxed/simple;
	bh=xcyXqGp/vIPm25gwoTB8fN3iLEkpf3lzBI9z6lRi3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtXIitnOTMo5ZZNBgaJA23XHwLUESWyzDqy+FuvcdABSWKTy9gQCpLQVOQe2Z7xjnMSihAAJ35iJP3/ZCdhfeG+hHCC0pX+3wf5bKKB/YAlbbtScOOFWVeLhIBV4n89qDjxeMcfWaRFIYMBBOr3INihL18+my77vlmpiLcyOgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd6ed7688cso41238905ad.3;
        Mon, 12 Aug 2024 13:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723494208; x=1724099008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pREe9g6ybdZ+2HTF9XCEyGKYgxlP5j2neTstGZLyss=;
        b=nnRZnYXnGmNbIinNIlkVi9E0XVPnrLpQGqvFxu4FFonbs3PVcw5xWWPkSWLDCtjf+d
         OW5MkUni1Jm5aFM2viCKcAHGtFvkWOUmaWVQS4wukqGBYTHbbju9mswYKoqrFT/2K7iM
         VCft+h1FvacWmII3CYI5KMeTT2d7hVHiOckritS+M6sgPamwcNX2vGdpZgHxPXq4MZi0
         oMBu7xuiDWni8mmUOk3Wt1Ev5yEpcZLEzz0l4Ble5ye6OpEc8yjgA+QeWNPwRpgP7t2Z
         yjFSgU9YrCl/VvSuTpPcivUFGXUIK5yst6cOIPFnqrfheCI98BA7bpqGbzbSZArnLabh
         o93g==
X-Forwarded-Encrypted: i=1; AJvYcCV3NsGG9ZuGpENjQDZIoT6l5oF/yURrpu5cwg4jePeDsv3MxMPp6kLLjpT6qdAQlTKVcX2HesMoCHykVc4oU54/5ao4SOjgV1sPSHeQ
X-Gm-Message-State: AOJu0Yy1XjdkqUavkEa25zp6Z2JYNo6Yl7UGW0ourHDzwhmgGGj2ihMV
	V1+lW/ToOAWy8a7NDtk9hqVsKTRMkLa5nRcQNqJn7wzQ9nim9CM=
X-Google-Smtp-Source: AGHT+IFnjyk/sUKXIY4GZBM6SjohiGVLx0AHHXAV1CjTPxshYNK0r8Tqxafx2HBUJziuPQ3y/YBdDg==
X-Received: by 2002:a17:902:f64a:b0:1fd:6529:7447 with SMTP id d9443c01a7336-201ca143f34mr13460875ad.29.1723494208115;
        Mon, 12 Aug 2024 13:23:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c9b92sm802795ad.277.2024.08.12.13.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:23:27 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:23:27 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] netdevice: Add napi_affinity_no_change
Message-ID: <ZrpvP_QSYkJM9Mqw@mini-arch>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812145633.52911-2-jdamato@fastly.com>

On 08/12, Joe Damato wrote:
> Several drivers have their own, very similar, implementations of
> determining if IRQ affinity has changed. Create napi_affinity_no_change
> to centralize this logic in the core.
> 
> This will be used in following commits for various drivers to eliminate
> duplicated code.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  include/linux/netdevice.h |  8 ++++++++
>  net/core/dev.c            | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0ef3eaa23f4b..dc714a04b90a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -464,6 +464,14 @@ enum rx_handler_result {
>  typedef enum rx_handler_result rx_handler_result_t;
>  typedef rx_handler_result_t rx_handler_func_t(struct sk_buff **pskb);
>  
> +/**
> + * napi_affinity_no_change - determine if CPU affinity changed
> + * @irq: the IRQ whose affinity may have changed
> + *
> + * Return true if the CPU affinity has NOT changed, false otherwise.
> + */
> +bool napi_affinity_no_change(unsigned int irq);
> +
>  void __napi_schedule(struct napi_struct *n);
>  void __napi_schedule_irqoff(struct napi_struct *n);
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 751d9b70e6ad..9c56ad49490c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -89,6 +89,7 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/if_ether.h>
> +#include <linux/irq.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> @@ -6210,6 +6211,19 @@ void __napi_schedule_irqoff(struct napi_struct *n)
>  }
>  EXPORT_SYMBOL(__napi_schedule_irqoff);
>  
> +bool napi_affinity_no_change(unsigned int irq)
> +{
> +	int cpu_curr = smp_processor_id();
> +	const struct cpumask *aff_mask;
> +

[..]

> +	aff_mask = irq_get_effective_affinity_mask(irq);

Most drivers don't seem to call this on every napi_poll (and
cache the aff_mask somewhere instead). Should we try to keep this
out of the past path as well?


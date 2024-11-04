Return-Path: <netdev+bounces-141631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9D9BBD3E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3531C21460
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27311CB318;
	Mon,  4 Nov 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FWt+i2d6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7A1CACDE
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744698; cv=none; b=KDTqSV9G7R1C+jf/qL8Upc9Mzytf+UCmfA4ZBfhMk99dkdaJb1y895zjZzmy9tUm73EWW7t/ycie1361W89fT4+t4bdFJ2qUt3AA7wgPKlxC4pDKegqaRM96sCE/ekYDUYiYRmymeNBN+kmBBFHB+E/2ZVsF2i3dw0HKJc62TG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744698; c=relaxed/simple;
	bh=hjmtCr4RvpNtlz3b/lLgBNa8CcjPWCV2aUlUR2nChXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REM7VpoOSnBsbzhNEgNe2dhKHvHstDNt6b3ojdTgYHffAA1UF5bo+5SUrEHXqAp0mXvx5de05gjpxisXyvGZQGnbWcodENc+ANzNHmufTvUIw1Ttn03XArD3JCKXZRoZQrkXqI7zP9tpbsLvnz2vdq3nW/n5XERci7DL31X6t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FWt+i2d6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so2615648a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730744696; x=1731349496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEXIZqC5VcLDorkVVv0u5LjNvfAzKSFSY+HZszN2aqU=;
        b=FWt+i2d6Qq4r30sCRa9UXIYQnT/ioFsy6muWqvINzn59bEPPy8OViTJH/WFHcOMLIR
         4v0zswpv5FrE+UP0Rr1Cje+5lr0SL4polON3d6lAK+rJjKTC5k0HuDeUaB0TB7Q4dUOG
         8WcwzrM7usUS9w+cKHUcMqnaJug8s6il+K2Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744696; x=1731349496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEXIZqC5VcLDorkVVv0u5LjNvfAzKSFSY+HZszN2aqU=;
        b=iZZd0iwACLW5XpgOpOPzhUlkuhk0SwDbYnXxRu73yDNXh/bCJ6CljjCcPlHmU/6+2a
         iGQmwDkbjZiyGFS8zQ5I79GI4a+5bDBYkGF3JT38u5brHnW2Gv9TR0aTHaY7cwBMXcFR
         /WsFHdsS90+QWE9ugEUl9gY2xfwVClN0+tSBJedXtEV7Q2678bn9gwkgSpnoxlgfGLVC
         LkdA/AZGikErpdpVnqY9CLvX4nsKB1bqy6Sh/nWnTpAFYEM1ZYjxQq8/Cy6cPtu4qyM/
         T/de72zSYPVxHlH/+G2C68H2Qwhb35hAUBUWuINAycRZajkZmGC7/HDAVjVgJr43q8ZR
         f6Rg==
X-Gm-Message-State: AOJu0YyQB2rKC833o/Ut01WkIvnY3bx/Q7ZFzEXUNhvSQVDA9gS3swvs
	DZEpB46iuV8hWO24x+Yh3LnxOfoD5ob3EdVr/95+eH1cx5rTdNSdDoEJolateP4=
X-Google-Smtp-Source: AGHT+IFpdfhbfkjgEQWpS6fEh5XcbhUvqgvXbQ8YCcQUXqN2GLQVkvXuNax1ALfDwZxYSpCLmjOVCg==
X-Received: by 2002:a17:90b:2703:b0:2d3:c9bb:9cd7 with SMTP id 98e67ed59e1d1-2e94c52aa1amr19422073a91.36.1730744696125;
        Mon, 04 Nov 2024 10:24:56 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa123e0sm10392385a91.7.2024.11.04.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:24:55 -0800 (PST)
Date: Mon, 4 Nov 2024 10:24:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org, hdanton@sina.com, pabeni@redhat.com,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
Message-ID: <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
	hdanton@sina.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com>
 <ZyinhIlMIrK58ABF@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyinhIlMIrK58ABF@archie.me>

On Mon, Nov 04, 2024 at 05:52:52PM +0700, Bagas Sanjaya wrote:
> On Sun, Nov 03, 2024 at 05:24:09AM +0000, Joe Damato wrote:
> > +It is important to note that choosing a large value for ``gro_flush_timeout``
> > +will defer IRQs to allow for better batch processing, but will induce latency
> > +when the system is not fully loaded. Choosing a small value for
> > +``gro_flush_timeout`` can cause interference of the user application which is
> > +attempting to busy poll by device IRQs and softirq processing. This value
> > +should be chosen carefully with these tradeoffs in mind. epoll-based busy
> > +polling applications may be able to mitigate how much user processing happens
> > +by choosing an appropriate value for ``maxevents``.
> > +
> > +Users may want to consider an alternate approach, IRQ suspension, to help deal
>                                                                      to help dealing
> > +with these tradeoffs.
> > +

Thanks for the careful review. I read this sentence a few times and
perhaps my English grammar isn't great, but I think it should be
one of:

Users may want to consider an alternate approach, IRQ suspension, to
help deal with these tradeoffs.  (the original)

or

Users may want to consider an alternate approach, IRQ suspension,
which can help to deal with these tradeoffs.

or

Users may want to consider an alternate approach, IRQ suspension,
which can help when dealing with these tradeoffs.

I am thinking of leaving the original unless you have a strong
preference? My apologies if I've gotten the grammar wrong here :)

Please let me know.

> > <snipped>...
> > +There are essentially three possible loops for network processing and
> > +packet delivery:
> > +
> > +1) hardirq -> softirq   -> napi poll; basic interrupt delivery
> > +
> > +2)   timer -> softirq   -> napi poll; deferred irq processing
> > +
> > +3)   epoll -> busy-poll -> napi poll; busy looping
> 
> The loops list are parsed inconsistently due to tabs between the
> enumerators and list items. I have to expand them into single space
> (along with number reference fix to follow the output):

Thank you for doing that. I'll take the suggested patch below and
apply it for our v6.

> ---- >8 ----
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
> index bbd58bcc430fab..848cb19f0becc1 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -375,23 +375,21 @@ epoll finds no events, the setting of ``gro_flush_timeout`` and
>  There are essentially three possible loops for network processing and
>  packet delivery:
>  
> -1) hardirq -> softirq   -> napi poll; basic interrupt delivery
> +1) hardirq -> softirq -> napi poll; basic interrupt delivery
> +2) timer -> softirq -> napi poll; deferred irq processing
> +3) epoll -> busy-poll -> napi poll; busy looping
>  
> -2)   timer -> softirq   -> napi poll; deferred irq processing
> -
> -3)   epoll -> busy-poll -> napi poll; busy looping
> -
> -Loop 2) can take control from Loop 1), if ``gro_flush_timeout`` and
> +Loop 2 can take control from Loop 1, if ``gro_flush_timeout`` and
>  ``napi_defer_hard_irqs`` are set.
>  
> -If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are set, Loops 2)
> -and 3) "wrestle" with each other for control.
> +If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are set, Loops 2
> +and 3 "wrestle" with each other for control.
>  
> -During busy periods, ``irq-suspend-timeout`` is used as timer in Loop 2),
> -which essentially tilts network processing in favour of Loop 3).
> +During busy periods, ``irq-suspend-timeout`` is used as timer in Loop 2,
> +which essentially tilts network processing in favour of Loop 3.
>  
> -If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are not set, Loop 3)
> -cannot take control from Loop 1).
> +If ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` are not set, Loop 3
> +cannot take control from Loop 1.
>  
>  Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
>  the recommended usage, because otherwise setting ``irq-suspend-timeout``
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara




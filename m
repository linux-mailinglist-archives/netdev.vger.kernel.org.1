Return-Path: <netdev+bounces-226927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF6BA633F
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A70189AD16
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5513237A4F;
	Sat, 27 Sep 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wrhp2NKy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005A1E5B64
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005426; cv=none; b=C/ZCgAp3C1CgX70ZEz9JQy4hlnoT+7O0F3P1T2g5L39GSq3Estd0S/tAM2zsGDLYWBEYYA0/rb+PaZRHOgkbN6+tHxOoTBx3lAEcNxEclQYB98WCaVMj4V+17pLH6JF9ykl6SNm/mEmJBHGWKozusZFQ1cKojum0gq8jjTzysPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005426; c=relaxed/simple;
	bh=sfYVx76JGrxHqHCOgMqEADM4JLCw9ZLaEQjj51LNMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+WJBByJyHkYfYE0iCz/diIERlXXV1cRbmAYh6IxeCMs8jJxYDt4X0BeErB3/RwM12WcgFcWIb1mYDLbwY35cF5/8mf2XyNgwOeDoBsd2Y7N9Rlv8KncZ6cEvDTE91SEoFm3wtBFaXANP900W5EFtH7p/Rnj8k3PYRSumAtjAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wrhp2NKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759005423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSL50vU3vn5zRDcV8odSyRV3zrATLUSrY+rAICw6mik=;
	b=Wrhp2NKyOLUs0qrzYjw9/JK1kyH1EpsJuuUqOCePjqL1aMJ+4z9DekGrsss6MDjiM/67jL
	t6i0eo/W7qPtzdus++75K2UC63XgBXMd2UzNR6bJczlQp8zCFuFvFdqSk4hZG6Bj7SIou/
	uLsim3RD5TsH61nRd9D07T9B69eLeMs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qSUuhulQPrK9sZAohocmMQ-1; Sat, 27 Sep 2025 16:37:01 -0400
X-MC-Unique: qSUuhulQPrK9sZAohocmMQ-1
X-Mimecast-MFC-AGG-ID: qSUuhulQPrK9sZAohocmMQ_1759005420
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so1667332f8f.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 13:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005420; x=1759610220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSL50vU3vn5zRDcV8odSyRV3zrATLUSrY+rAICw6mik=;
        b=SqjNTgeDqg+g97SrJAxPt3pt9fitXIeiL+j0+M7j6yI8nM/PAZJpY9sz1iPKaNUwhG
         OjIypLNv6Dg+2HB1bgl6beD0u3gWNZ8wyNf/nxNWpUW3KVEX7bZAihRdizGCuBYQCJ+C
         zJF7XLnaark4XHcKw+BNEuBYfsOMpgBepA0luu8T09voEZF62SchiGMc5AVg5dpnCoPf
         GH4z8r3BbLPrp39n5Kj0LL77CUz513h3cnCzq+dNLNWkg4ICo5kkquoZm01nxGlCdY8R
         9Ayu8KMedG7N1Q8fKyMEf35RdMSJ7YnciiWmiWzMnAIjY6oLd0nkDg8s5GWAIVWMrygz
         kwww==
X-Forwarded-Encrypted: i=1; AJvYcCUCyRtoyYGBerddHK1Jzr+hMRmngRA1DaDfB2yyIcfHxLjpABmB6oQUCGH6A3YikeDuzDrxxcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKTNZA2GUkKdcZluVmMDKI14VYnPLndyaWfSW3DJUpK8qa6eW
	ghhoF3Nv/t6+QHoOsLqi/S6vgJ9Sq69oAs3/2FegITQPls2kyPlQlWmrfvxQeTjUxDcjVYX2mk8
	1PNmCgWny0gLCDpIybTmvzoBsTbv9rtPan8PdiiNJZP89JILBVXKULFJ2iw==
X-Gm-Gg: ASbGncutJXD3Le/gz4lUuAmOrcuebXB8h/w8gXr80VgYfYXKaQ5tsgO/tN2WMJRQ/R1
	twc3v9V+TQU1dQ4twGLtYBRH7JHHD8UQ0ZmyGyaLkzRjOxmSykpIt8TZejzXef7V9TKreb5ibys
	q22+MmUYlz+OuLY0RsuRAZyBduBw73DAM0p0MYDno4hDcgoXPMWdyjfr5tiQ7sYumW1ZAHZIxRq
	jO4FYZNNsdw4R6dheXtfxDmDxeHbWUnIg4/XvWL8upnlHOoyRt+AyuqtyfsZU91f8p6ABA4AfPA
	F4Lr3jF4//nXPlcwb/FQjOeJBoFJyA4rdw==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr11399273f8f.42.1759005420278;
        Sat, 27 Sep 2025 13:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf/X8n0rnPQnTiFh6PR8PNOgfG0IN2tIXN0qUNFfjcbHhagOSXpXgOJkcWSW/etGX5pqojgA==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr11399254f8f.42.1759005419753;
        Sat, 27 Sep 2025 13:36:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e3bdsm131200905e9.2.2025.09.27.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 13:36:59 -0700 (PDT)
Date: Sat, 27 Sep 2025 16:36:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250927163552-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The return value of copy_from_iter and copy_to_iter can't be negative,
> check whether the copied lengths are equal.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Given copy_to_iter was fixed on net, how about applying
this one on net, too?


> ---
>  drivers/vhost/vringh.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9f27c3f6091b..0c8a17cbb22e 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  		struct iov_iter iter;
>  		u64 translated;
>  		int ret;
> +		size_t size;
>  
>  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
>  				      len - total_translated, &translated,
> @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>  				      translated);
>  		}
>  
> -		ret = copy_from_iter(dst, translated, &iter);
> -		if (ret < 0)
> -			return ret;
> +		size = copy_from_iter(dst, translated, &iter);
> +		if (size != translated)
> +			return -EFAULT;
>  
>  		src += translated;
>  		dst += translated;
> -- 
> 2.33.0
> 
> 



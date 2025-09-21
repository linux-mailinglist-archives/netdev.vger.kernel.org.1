Return-Path: <netdev+bounces-225100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C665B8E5C2
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 22:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1536B16D28F
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7E28D82A;
	Sun, 21 Sep 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc23reFv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F145524D1
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488382; cv=none; b=p/aY+xEKkTZZqJ/hJTOBuBinNXLSJEM8DZ+CVkDIwh4+GSfboU2GjIRLESTMe2EdC3PiLIecbQiA1M35qOwsdOT/uAA0ClXMqg9l8MOZtGyV6w4gewxFpQcleJXpiUcs2QLcTBw4kjcxAHy3gsQ8D47S1eOQt0eRzkwEoe4qSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488382; c=relaxed/simple;
	bh=i7pW9HwRwP2c7GQu7cmSv4/uxHxGCvk/Ta/jaDGnmYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6nj4L1cetL5+K6NhQIsBFRPHgjqc3fysiaqIasIohc0Xo9yGjNzf84BEKN7om2yhcF6Yke9hDUr+rOKi/s+XM2W8mhbcAVJjQs5r/2oucjRFWX8UQ5IgIQD7UP7h7avN3XXeVYe5KqY28STgMqiFaSmgWQIhoiQRfjlUahsI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uc23reFv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
	b=Uc23reFvm6uJZmX2rTDVjweww81LYP6Zkt+vjDui3VqlXdbFBfT8BA6xI/Jt13Br6KviuC
	CTaYfnIFN/egykOPu5MKzCAX6Xtx9HDa6UR/XgJv25OPqcdZWvhxnjhW3obDRoQL0kBDkM
	NZsa2pLB3PnghSXzM/4yUd36trcZBqw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-HVtzesTtNV2K8n6zCIOVFg-1; Sun, 21 Sep 2025 16:59:37 -0400
X-MC-Unique: HVtzesTtNV2K8n6zCIOVFg-1
X-Mimecast-MFC-AGG-ID: HVtzesTtNV2K8n6zCIOVFg_1758488376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso20993295e9.1
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 13:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488376; x=1759093176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cccTVUHrijNSX4z+x7tgOWrfdy/5n+8UzzmA9bxQJ4s=;
        b=bqQu/845uiKZ/WxTEcUv/RpUPcJbs03BI1RtGkQgdUacTPeyuwVHvPy4co4kuHqsen
         o8fAJVVRBpT8SNDuUGnvQGAwZieSKVFWptV5pEhbLfT+6V1NaG1CqgnblbqJZ/nAxap+
         ZjVREdxrrm4MC7NkmVooDseqQaQTfhgUuJV4kz/r55JoOZI5KqOCuQPshjq02xtWOXMt
         NX5XxufvBfhgTOEEtYogSSGjHyW0oC45xpjqJJbAmXyTJeIze28BAC8G/KJx0NWHXkG3
         VaU6YjwO7Be6Bv1goIeYW8PG6IgQYEkUN7xkf5V3QP7Ss8g4WNo6b78rXkzadmr5Yns+
         ksMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYr3Tf5xXkK/NkRjPdOJw12aUT/d4cFKeq6S2H9qD3tTV3WuomvYpEpnX1qQ9GgXI0STcs5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWY3O0ETbybX0PetwAgrm//aGXn3PSqAj90GvIiL/H3qoNnjk
	wjaIgkNmmfw4U1O/2a36e34eahBliEwKH1CKEc6KXrh0YAoB+hdIf64gXxMidUckithKc3Fv1YM
	nY/cNXUbEjI54qkHwRxjPU66ylDd1mWufwHjIjmD1PFr8ffB4O1IxvXEIdg==
X-Gm-Gg: ASbGncsBi/KTBej1wK+baLwe8HaTGxQI4iJEgxtID6HuPsXeAPapKY2/Ex6NUPzN2Vz
	UHFAdAAyGmA7zJV/C7ZjXIiIvmTS9bDkrT+sSlNAEYqvkMBdHrmXmblDtmvTf1WglAIWg9G71t3
	BtHcregdBmHohMN6j+Ue9c18nsFuC1MNBplHJSYxZ2V2Jgukng+tZFngsV0CKIVPWQ4Oc/eChvc
	e1tk3C7lkcvAxzOilboAjBKVxhUnp6zNF7fmgeOQ0xJtI08/tkyEQaWj0nilisVwI/SNmPvDI/2
	1C99xodwSDdVOKrxNUsdrWEkZ5qZQ3zlrLo=
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179835e9.20.1758488376291;
        Sun, 21 Sep 2025 13:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+9gyh4b7Pe6vwSysrkjuIQgt/cb1zE0T12QzGBFLzTc0cFE1MvWmSWaHwMUzYdnnxQL7Ozw==
X-Received: by 2002:a05:600c:3b20:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-467efb044f0mr75179775e9.20.1758488375860;
        Sun, 21 Sep 2025 13:59:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fa9e584309sm3897012f8f.49.2025.09.21.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:59:34 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921165746-mutt-send-email-mst@kernel.org>
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

Well I don't see a fix for copy_to_iter here.


                ret = copy_to_iter(src, translated, &iter);
                if (ret < 0)
                        return ret;





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



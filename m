Return-Path: <netdev+bounces-225104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B98B8E6A0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302A47AB122
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0B2C234B;
	Sun, 21 Sep 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqz96YZX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E81798F
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490874; cv=none; b=tSYpc1v2TYhekIxe04rHi4D8g/Dkv3Vp+DtA3c6tfWh2z8+WU4fAIE170ih0i2tUR2YMDzdMev4GPZHyed3XjbeVEquQX3uDt5QLHEyAFk7D7oE7j87cKvjxD7lsi1XY/ryTvW5pZ78EYoVeV/+VfeLQM8TEXIprbbBB/91brvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490874; c=relaxed/simple;
	bh=2eRQFz6lTYzuVrxi3sraTdoTI5Gov5pFUQwZMiCSUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU/aiaMIwJ2k5eViFFucG7p6dad9TQjU/+SKkx/t+943qlJZ+BCJ3TRzYhtGscIe7Nzd/MTRy55De82HumVzfh3U20G5pH9YAvT3gd6jsF+Px+/CyTUONFdT12UuFKUgWUJNJ4zeGoxpvxMerf0AzyrWuxvci471X/EfJuLtDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rqz96YZX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
	b=Rqz96YZXUPJ1csNq31jUX5dHbnPEf+aXuJnDqjZnBfnzp46pbUoOD+npyNjN6pkH3IaZA+
	ybjfXok1WLEb7s/nM6gLjdMngYtkyQhCOmsWFnotsf2Ds11Oxrb3DK+R6l5tNnu9G221mU
	TnV2i60UzwtE+zNxyD1ucHru48Vy0k0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-OhDEtP2wPCWF-rMkYakQ9w-1; Sun, 21 Sep 2025 17:41:10 -0400
X-MC-Unique: OhDEtP2wPCWF-rMkYakQ9w-1
X-Mimecast-MFC-AGG-ID: OhDEtP2wPCWF-rMkYakQ9w_1758490869
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso21884305e9.0
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490869; x=1759095669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KqMplkScTYjn/2difwf3vbnDC8sEidYGpK87XWS4RY=;
        b=k6euHxML6agrlMR5ufY186d5G3Rxk07r+gT7/bSZTnIX6ipg1IGfHUMhAb8ePTd0oF
         QUIeUU2inuh80YrhSLbW71wP2g82VzSRnZ+EHuSHkogiIM11hdJCDu+TxrPmwch5yyhb
         65hrhNxrHy1r8qSjT7dujZ5rXQAZIbEwpwSvjaAzbyDHzFJ24l0Q16FbTE0B3CLl39rW
         EwwtR2y0RdtNrcAVumZ6PbBQ8qiby0GBA13c2oKL6YBk1fSeUbE4flOG1l9ckrxgb/Fx
         K7CUMUoK7Dpc6Cr84YPmMzSUuAPEMbbLdKuwkdnPX81vwenQxWiJW4LTeGXvZX5gJj22
         TttA==
X-Forwarded-Encrypted: i=1; AJvYcCUd580lyEB+S4voaLZQbSyRX3PcD4oEHOVG9TUvpSboysOm9hYsTcPD5Zg3nBwBlCCJs7ltME0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEiSnnTklN6uq81i6qI2UvDFbj+OGz9sq+ZC2nGx1eZ8oSDMm3
	2/Oy/TfN/LaKUuzhqQXTldPRPAbVbs2v9N3QgUPqRYCUxUZBJg5Ne1cMXahDjk9fpcRjsWOXTRZ
	nnhJx6RpEbT3cvoP3Fonk5M2bhuf0Cmz3Qw22X/q1i6Ef469LJmeasZW21A==
X-Gm-Gg: ASbGnctHoCWKCXvwiFj+n8sQtsUyolAaAztn+JhtweP7oPhBhvu9QL0Ls95xZl5LJ5n
	blaswLPXNJ1zY+OE40xqN/WhyRcQLe5rToMkNFHnNEohWu9OcGI4AhUPzlOfj+SovM1fJ+7/K6L
	1mrMHCcx0lidC8LKqoxRthC79abj995wQ0Ltf9vdUeD7eCM1KN43km9WLcnlNWcezHgPJ+blkj5
	1YiboeRb1uSQKhE8tvEsTK+c0u93xwFfPIyC1uckeQeHeyegDtYr1ccXYxk3hfujBg0WCo8kX0Q
	b7dgZPeDoBe1g9Bri2NGNUZofOxM725o2IU=
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93974055e9.12.1758490869185;
        Sun, 21 Sep 2025 14:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3ONLO0TqDIpbwZ8tdp1Uhm0ZVS1N782aV32rBmMI81RJxSBnbtQKfoquKrW3T2JV+taGEw==
X-Received: by 2002:a05:600c:4fc3:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-467eed8f915mr93973945e9.12.1758490868782;
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d42bee6sm221283755e9.15.2025.09.21.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:41:08 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:41:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: vringh: Modify the return value check
Message-ID: <20250921174041-mutt-send-email-mst@kernel.org>
References: <20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com>
 <20250921165746-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165746-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:59:36PM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 10, 2025 at 05:17:38PM +0800, zhangjiao2 wrote:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > 
> > The return value of copy_from_iter and copy_to_iter can't be negative,
> > check whether the copied lengths are equal.
> > 
> > Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Well I don't see a fix for copy_to_iter here.
> 
> 
>                 ret = copy_to_iter(src, translated, &iter);
>                 if (ret < 0)
>                         return ret;
> 

to clarify, pls send an additional patch to copy that one.

> 
> 
> 
> > ---
> >  drivers/vhost/vringh.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9f27c3f6091b..0c8a17cbb22e 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1115,6 +1115,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  		struct iov_iter iter;
> >  		u64 translated;
> >  		int ret;
> > +		size_t size;
> >  
> >  		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
> >  				      len - total_translated, &translated,
> > @@ -1132,9 +1133,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
> >  				      translated);
> >  		}
> >  
> > -		ret = copy_from_iter(dst, translated, &iter);
> > -		if (ret < 0)
> > -			return ret;
> > +		size = copy_from_iter(dst, translated, &iter);
> > +		if (size != translated)
> > +			return -EFAULT;
> >  
> >  		src += translated;
> >  		dst += translated;
> > -- 
> > 2.33.0
> > 
> > 



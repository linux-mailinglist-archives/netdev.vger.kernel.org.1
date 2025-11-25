Return-Path: <netdev+bounces-241549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F798C85A3A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A403A6240
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95BF32549B;
	Tue, 25 Nov 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqIroag1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwvD3UUV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F0B21ABDC
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082931; cv=none; b=rhOdZVCkgwzu61nwobwPocW8RYEj7vtj+LFzUvou8hhljNzaqXE02F8cnlr0iC4M0+993ZOzYgXpFL74+3EDXcWiemJuxqsDja+GyqZRWy8D+3Tmy3E6xftI5u1MSDaKu1WLPfmhufL9bRUMGYZdDsHDsmRUmGu4CXaeKV/sNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082931; c=relaxed/simple;
	bh=MA9QsTVtWgsvfIublM08n8V07qfNyZI6ksmu7VUM+Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3LfqcFvER1IdWnFcBoy1l5mi5CKXb85M0kfK+SwTQDXe6i94vCsHV7M+g8/rk2JckYIE0GnlQQW4AvdTDDsRZUDCvVoD9NKZLEP/IeduHJlyBTk14S/KLtMbITle2LKydoclDFh23vnPs8fHaBuRVFFbADVXa3yKu1lnuTjb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EqIroag1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwvD3UUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764082929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09KqEaOP5fl8HujAjQhdvyXU7ffK0wmWeHz1wD48GE4=;
	b=EqIroag19rralZILbIkUISF84q4xBnzJVdAbjiSRNV6g0JY3eNKSe44cCokVZD62gsmckW
	JqhJ0gqXclSzr2pkdOg1msmFmhAGuRxJF/+/1w6UCP7DSxhyetruwE7DeNKJpQFG942t/X
	/VZPqux2wVPhz714iXYg/WFha3xwvoY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-rXK6ViUiOU6mIieIOL4XWg-1; Tue, 25 Nov 2025 10:02:07 -0500
X-MC-Unique: rXK6ViUiOU6mIieIOL4XWg-1
X-Mimecast-MFC-AGG-ID: rXK6ViUiOU6mIieIOL4XWg_1764082926
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so26789265e9.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764082926; x=1764687726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09KqEaOP5fl8HujAjQhdvyXU7ffK0wmWeHz1wD48GE4=;
        b=AwvD3UUVrp0326DAYp37svKYhisi8ke6EQSbIuhd2apj3tbpGaEee9tjmfULRlELS7
         9mTD52lzt+9Jpcw97+dTqOE/QRGSG9ofFNYM4IY1pltLfboW7mIHPDOZCF4UIjOdTvd3
         VO0AGgZG96+0Brnaq+gQ4gMU5Z6Xjks1B1agfWwU463EuAzgCAGjHuXDxij70tCBTVLd
         2F0Urs+AUu0arJWCbZJhv01zE+14cxo62Dm8ba6sZfEEez4FF9mYOsL1RY3WOA3mDQFb
         YkMsjyyxEjF8VKd69vkbHSYdoeHtAxlXV+6eULkjlKchngpai1WypZbHNSGV31hBaOJP
         ch2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764082926; x=1764687726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09KqEaOP5fl8HujAjQhdvyXU7ffK0wmWeHz1wD48GE4=;
        b=M5RUZ28+a8O3gyZV7FOctD+iZxhgHni+oE4hn3Cn3B/IC/n+MiPS8+5IdCkp9j6IeD
         tCWgcuRXxxqKS4Zu4ClH11BqXOjENi4hwPogx2CYZBwUkywVDAPkXb4UtbS+0JA9lU3d
         HW8BhA0i3KGMLJF6DriE4DqyfaRnsjiYud3RKvIOI/edwlQVqbQezTuVg5lo1Z636Fmg
         ucYaXhe6fFAKDO/ApbBbwDmhz4/AXDAdeCI9xtc4mpx7II14D9gBeR0yXBTFVOa4t+Q0
         D4gLGPzSt0ZW8+0r2C4sieNnKli2/evIXymgVwMu/CiX41EZmv95hK4K1y1fGySXVrsb
         vV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxLXfy9QCRBy6/ZB4xrdfARKOY/fkpfPBfKX+9CHzQEkVUVobZclyWrlUa8EOqs20d/iI9+Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjsmqM5/h2dmucqEXqDfPnHbcv4ISfFUjeVRpuRmOJ8sxHyv1
	lHetj9AmU4ORMi5oO1wL6h+3esTb2QwyHy9WHcU+/aJ775y1IsYnyVpwfBHS/PhhxCFW4NVhTGn
	rBaRUzToXvcWaxEPyCM+RRSRQZxgFduJaBNIN61h1+z07/aKh35njvCDV9g==
X-Gm-Gg: ASbGncvd/sew161khPU/76iE/bjkJL/XOEhRrnK0gs0dGFtyI8zeb1yZyEeiy5CExgX
	xtDMenC16CW255xujnUB5PWhWhPB6Z5GIye+gEn0uaJ/d4gaQB7c/XyFmGNyStE3jLD9agkl9Ly
	wocXsehi8nNLXgpumg3Cp4fNCwGPQeXBVqJNkzEW6xOHxoM5Re6f4B1soqVldyyRSCHr45IIEKI
	GlU6OmW6XAFRRICt/obH1R88X+t/Y2/DP0SJ2ipACDOUEuPJkkv5kZoZH7CIMtXKM09ptPag4Hu
	ekRSBlkdTs6JGQYBowGK+OxemIB1I6X1OtSIuO9sG7q5IXcqavDHrBDLOva5jkzGpH3/X7CDfNA
	fR7hJqWVTJ3FSYVIrDmlndAdx1OGimQ==
X-Received: by 2002:a05:600c:4fce:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47904ad9438mr24886225e9.9.1764082926355;
        Tue, 25 Nov 2025 07:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnxhF4yC89mPigrHkbVw1gVjo8TuRM3hL5MAajbA1OA7AnNYZFSuV4PRGzcMPXZxxaMN4l+A==
X-Received: by 2002:a05:600c:4fce:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47904ad9438mr24884925e9.9.1764082924414;
        Tue, 25 Nov 2025 07:02:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm273353425e9.11.2025.11.25.07.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:02:03 -0800 (PST)
Date: Tue, 25 Nov 2025 10:01:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Message-ID: <20251125095650-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>

On Thu, Nov 20, 2025 at 04:29:07PM +0100, Simon Schippers wrote:
> Add __ptr_ring_consume_created_space() to check whether the previous
> __ptr_ring_consume() call successfully consumed an element and created
> space in the ring buffer. This enables callers to conditionally notify
> producers when space becomes available.
> 
> The function is only valid immediately after a single consume operation
> and should not be used after calling __ptr_ring_consume_batched().
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index da141cc8b075..76d6840b45a3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/*
> + * Check if the previous consume operation created space

space?

what does this mean?

> + *
> + * Returns true if the last call to __ptr_ring_consume() has created
> + * space in the ring buffer (i.e., an element was consumed).
> + *
> + * Note: This function is only valid immediately after a single call to
> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> + * been made, this check must be performed after each call individually.
> + * Likewise, do not use this function after calling
> + * __ptr_ring_consume_batched().

API-wise, it is a really weird function.  So is 

{
	p = __ptr_ring_consume

	return !!p
}

guaranteed to be equivalent to 

{
	p = __ptr_ring_consume

	return !!__ptr_ring_consume_created_space
}



> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> +{
> +	return r->consumer_tail >= r->consumer_head;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0



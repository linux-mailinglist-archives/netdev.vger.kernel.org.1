Return-Path: <netdev+bounces-225778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66576B982A0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C8919C7A06
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887211EF091;
	Wed, 24 Sep 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdq8S5PI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A971F92E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686630; cv=none; b=t+Bnwb2ssb/8PD8zxjbIM/QBSsDn2QUePopielHiRIFnGLtJp2wTwon2lIFD+5dmzRJOxgG1fVELMUvN9Q0/Dm+oq/hfTjAvQEMgojbzXNJOqE6NR4y6pj27BsSKDSIACvOfRSsfH6W+ttI2kyyjGMn42NrOXFr+Q5Wm/Sszvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686630; c=relaxed/simple;
	bh=JRds4ewEiat2kGaKuomIYc9LrNpzksooaNNA/nWY2hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKEe1vdJMr7fg/+SqYh8IJdVDzuX0gY/odXx3nzR5o1aYAsW7K1roCGoKybCaWi97zSsUFSd0QFnlQNn2lKmnsNpj0GL450t9TAUcY77tZAn+5Jy94RTBtxhiwFCbBS5YutpFoZkgsSwvN2T7x7tWwZKiUpphYUdLLnGMt8p+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gdq8S5PI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758686627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jn0uShW4d78eXk+mVybzY9CVxRSQzxZ0SWvxR+EjkxM=;
	b=Gdq8S5PI42XWQtNdgTWui5SeF18rmsdWEvyP4X0OIWiVCwYyGzJ6mEZt9/1pYayuSyuay7
	zW9gA5aTlehlZF0nq/FMHCw9xL5YAnStCQbf7ZQmgN7k1xuYeJG6YsW9FIiQhMw1hqneWA
	3CuVsISBANmYWqb7RHX6kMi+HGeTfIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-aPFL1K2xOJuPWHH1ShLvHg-1; Wed, 24 Sep 2025 00:03:44 -0400
X-MC-Unique: aPFL1K2xOJuPWHH1ShLvHg-1
X-Mimecast-MFC-AGG-ID: aPFL1K2xOJuPWHH1ShLvHg_1758686623
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso16829105e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 21:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758686623; x=1759291423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn0uShW4d78eXk+mVybzY9CVxRSQzxZ0SWvxR+EjkxM=;
        b=LG7cZmxh2Pj61UyCY+fY51DRB9LmZTyLRWpKieqC4UFOhQWBzKekH3GoDS7Z2qiZ/I
         75+PdFPGH+DbUerZykrZUT4Y7FSCPYm9lhE1shKU0QJpOoFJlzFBe6nnB5hYy4vCk1TT
         QNMeMbkq5k8VcLq09l4ykDDiLpqCwwZkQZbxbiq7G5wrysb4m+R58oiUp+IVQywpJxcf
         wTvd2VX3nhJ79k/0+4+frRhkOPcnWAPe3HeFwr8YSPpEzYe99XgkPhXh/Iwvb0RkIyXa
         AFpPqdKJfxQXfGkXNGkuOSgZ0v1QXD+s1Wvmf99xGaDeGOCVqQl1637dANDvD3RhNPCe
         UEZA==
X-Gm-Message-State: AOJu0YwH3ePmR32a1n3PPYXccRUgufrF53U8Y2LY8g1klowDRKrys6Lk
	AnFRjU3FzxrQhuyO5r5gIu/DC2PX9x4enI/FlBQZws3Piowa1y/BP3IHulyBTJ4HRr3vX4ffrJm
	DD7OwAUvEhCK1v0Li5Dnad1BGOhqibyi8u3XlBFvQo3h2p0jv4MXxzmzTJQ==
X-Gm-Gg: ASbGncsP6Wz5KUeWMsbkxkcuz1U4FANv6f7y/SWKpEnEhZcZ1/G0D1H4Prv+qvfhLdU
	XDiRufn60sFpL6K4ngfIyW5yFQwLEOS9Avi3sZ9VtjySozlq7sNTkWo/BC+gynlmwzpRiUt5IKa
	m7HvSNiCEQ2BYUxj/Tra9XulB7lxF1YTpmxCGFFCvHWFFOo1gtXpshQSIMZ2229yaaQr7YC0k1P
	K5E9IxaRqMkVvHAQ3fjdh8CYaKDe/i43aTpgxZ2iqlqfzfqwbPmno7s5JIopl6ISvAEDC3kWpn2
	0U44KmDW/HNLXYLdbCCiTuikgzs8LN1V+Ds=
X-Received: by 2002:a05:600c:3b11:b0:45d:e4ff:b642 with SMTP id 5b1f17b1804b1-46e1dac5378mr46784715e9.25.1758686622784;
        Tue, 23 Sep 2025 21:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy/gg9Hqtp0uwQSZ57KvovAnNkmzxgNrJ+400kezxW+Bxo+7/7gLREd35l3o7lHlDM8//+OA==
X-Received: by 2002:a05:600c:3b11:b0:45d:e4ff:b642 with SMTP id 5b1f17b1804b1-46e1dac5378mr46784545e9.25.1758686622303;
        Tue, 23 Sep 2025 21:03:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e21c8b7eesm20566605e9.4.2025.09.23.21.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 21:03:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: ptr_ring_unconsume: memory corruption potential?
Message-ID: <20250924000311-mutt-send-email-mst@kernel.org>
References: <20250923235611-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923235611-mutt-send-email-mst@kernel.org>

On Tue, Sep 23, 2025 at 11:58:40PM -0400, Michael S. Tsirkin wrote:
> Jason, guys,
> reading ptr ring code, I noticed:
> 


Pls ignore. ENOTENOUGHCOFFEE. It's a nop.



> static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
>                                       void (*destroy)(void *))
> {
>         unsigned long flags;
>         int head;
>                 
>         spin_lock_irqsave(&r->consumer_lock, flags);
>         spin_lock(&r->producer_lock);
> 
>         if (!r->size)
>                 goto done;
>                 
>         /*
>          * Clean out buffered entries (for simplicity). This way following code
>          * can test entries for NULL and if not assume they are valid.
>          */     
>         head = r->consumer_head - 1;
>         while (likely(head >= r->consumer_tail))
>                 r->queue[head--] = NULL;
>                 __ptr_ring_update(r, head);
>         r->consumer_tail = r->consumer_head;
> 
> 
> ...
> 
> 
> 
> Does not look like this will DTRT if r->consumer_head == 0 .
> In fact it looks like it will go off corrupting memory.
> 
> Why isn't this a concern?
> 
> -- 
> MST



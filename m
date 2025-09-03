Return-Path: <netdev+bounces-219577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F590B4208A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1917BD2F8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A8302CB4;
	Wed,  3 Sep 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhqrJBpm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F83009F0
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904724; cv=none; b=sBGQLilyBU0e8nnL+p426ZB1SknTDy8eq++dQsVV9u1AC9BpN0pwr2+6YjqaVxhovxPyOtI9OICaOzuAYMrA3Y9EOrLg1leq1S+p3JySYY1ifTz4tvW04rvWuMTs+Z/5diFBLX2cGqlIkCMzEFKPc4SNhoLb4egPAWkG3ThD8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904724; c=relaxed/simple;
	bh=wx8Tfq9Xifa0zuCHejFIDyBweEYkpVa68tCxnuiy/sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkKctcazKA1vauZxy+NJtY1yPBuZif/2yUKgERz34icg4qVFA6j9OuLoNThNDYaQ95cQf6yHpcFt3mLNU+HzCBEXvBZyjfP0gBBqUQRj4QCWLU7aJln0qCjaTNY/J6ozQsrOj35tugkTg2rU1u+zdFv3kUR0VSKa1ssYoHmkTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhqrJBpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756904720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrgPdVi1Tq/sUmSfRfVNUoce7RWoUa2jBaIiUDjya2s=;
	b=BhqrJBpmSzvZnCVW5+oIsvKSVmOFrDzcrG2XM+JwkIaYIRNnz/Ch9LlyDLupZlo0H9ynht
	AqG1V37J6xJ9L8esVfsmk0VTTLqmzwqNZt8r/HZRwSpo8ki9edpV5PgOV9mFjNMlsiY4qP
	uopOdNtVjkjAfQ3jnWwEmk5lS2gq5kQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-sgmP1FNlMKa5WE-qBSxsoA-1; Wed, 03 Sep 2025 09:05:19 -0400
X-MC-Unique: sgmP1FNlMKa5WE-qBSxsoA-1
X-Mimecast-MFC-AGG-ID: sgmP1FNlMKa5WE-qBSxsoA_1756904718
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b87609663so22611915e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 06:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904718; x=1757509518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrgPdVi1Tq/sUmSfRfVNUoce7RWoUa2jBaIiUDjya2s=;
        b=jPKTHm5ok9Fm90clmX9wr0bHHkjFcXimZvUntapmKBj2W7Asv0B8bpzfMRz1EGxfGg
         PXPE568shOXkmqX2ONFI25qugzbZDcRzz5y/jVWYxGb+NdH07C/DdJ2JtRDURarldte0
         yALDHUYEFt/or45C4etzhUUYhTxgYM2HRp7lqG/zIP+nFY9s4ddEhDOwKrDj9mNasqSr
         0mt+ec/zZhzyePaa258Mte3nO7MOi546ofEIKoGt9Ssu97swHz3XMKCzzFBAHQNf68AK
         Z+XhudfFqjesuWB/9RDLCuVjOaNImWZJdzNreb2IhpSgqtQVyVVEhftC6xv0w22U8Elu
         kCRg==
X-Forwarded-Encrypted: i=1; AJvYcCXIt8sPm7Zl+hmeIm6xdTxCvTS68sNmbRzvlFpj2QLqitT3NLBq9Ee5WP6lIMr5IRMiRxyGh7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74oOXkAW9hkogL61n6hoWGiciGnMbmaMwGgTnA66OVwxecLWf
	LUCKY8MAxmXRma04AHqRbOG2mKy9HR2+aGDxoVbzBOWTGdD+X/RAdJS90EyZ0jDQEM6snrY5+lK
	HuVmPif/0UgA0M3H7Ihp+5uVnh0YBqTW1APEKeHO3SQWPV+MjvTi5YLvUUg==
X-Gm-Gg: ASbGncsdp7Tl7Uqrvt55Q+3jycE0lPxXJJArdkgbbUqD3l/CWHrt9IEENB0veaNzkPp
	Kl88fqcRpc2SIoU8GKHAYHkIBqnYASn5PHQaG1BUh8mZb01M4oOCm1DXbqI3D28oPQ6+FuhyWk0
	Lkcj5po3M0Sq+8T4vsVbGyf3UIpbi4YwgmFdymVZnZvVPvCdQ/qq1WdSQQEztZApZEQAk9cd6IU
	Uo1TkTnuXR6dnTv/u2RShz8GH3Lgh5Ia+fz22IPAhbpWaOY9T9J3CEoXwMR1HwlRzfZqC1d+H/P
	zcmjTFqY9jlK0zGtDavLFEAKKSny7A==
X-Received: by 2002:a05:600c:3ba9:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45c6fa9a71amr30616565e9.22.1756904717712;
        Wed, 03 Sep 2025 06:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtX1RsxlJvS5LBnQ6eZx2sJEwHto6VMfJqc79cmA6A9vHdfuL33yrAr/RXggLaExbbjXQUzA==
X-Received: by 2002:a05:600c:3ba9:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45c6fa9a71amr30616165e9.22.1756904717260;
        Wed, 03 Sep 2025 06:05:17 -0700 (PDT)
Received: from redhat.com ([2a0e:41b:f000:0:c4d3:2073:6af0:f91d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b88007a60sm98473065e9.8.2025.09.03.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:05:16 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:05:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH 1/4] ptr_ring_spare: Helper to check if spare capacity of
 size cnt is available
Message-ID: <20250903085610-mutt-send-email-mst@kernel.org>
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
 <20250902080957.47265-2-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080957.47265-2-simon.schippers@tu-dortmund.de>

On Tue, Sep 02, 2025 at 10:09:54AM +0200, Simon Schippers wrote:
> The implementation is inspired by ptr_ring_empty.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 551329220e4f..6b8cfaecf478 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -243,6 +243,77 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/*
> + * Check if a spare capacity of cnt is available without taking any locks.

Not sure what "spare" means here. I think you mean

Check if the ring has enough space to produce a given
number of entries.

> + *
> + * If cnt==0 or cnt > r->size it acts the same as __ptr_ring_empty.

Logically, cnt = 0 should always be true, cnt > size should always be
false then?

Why do you want it to act as __ptr_ring_empty?


> + *
> + * The same requirements apply as described for __ptr_ring_empty.


Which is:

 * However, if some other CPU consumes ring entries at the same time, the value
 * returned is not guaranteed to be correct.


but it's not right here yes? consuming entries will just add more
space ...

Also:
 * In this case - to avoid incorrectly detecting the ring
 * as empty - the CPU consuming the ring entries is responsible
 * for either consuming all ring entries until the ring is empty,
 * or synchronizing with some other CPU and causing it to
 * re-test __ptr_ring_empty and/or consume the ring enteries
 * after the synchronization point.

how would you apply this here?


> + */
> +static inline bool __ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	int size = r->size;
> +	int to_check;
> +
> +	if (unlikely(!size || cnt < 0))
> +		return true;
> +
> +	if (cnt > size)
> +		cnt = 0;
> +
> +	to_check = READ_ONCE(r->consumer_head) - cnt;
> +
> +	if (to_check < 0)
> +		to_check += size;
> +
> +	return !r->queue[to_check];
> +}
> +

I will have to look at how this is used to understand if it's
correct. But I think we need better documentation.


> +static inline bool ptr_ring_spare(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock(&r->consumer_lock);
> +
> +	return ret;


I don't understand why you take the consumer lock here.
If a producer is running it will make the value wrong,
if consumer is running it will just create more space.


> +}
> +
> +static inline bool ptr_ring_spare_irq(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_irq(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irq(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_any(struct ptr_ring *r, int cnt)
> +{
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&r->consumer_lock, flags);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_irqrestore(&r->consumer_lock, flags);
> +
> +	return ret;
> +}
> +
> +static inline bool ptr_ring_spare_bh(struct ptr_ring *r, int cnt)
> +{
> +	bool ret;
> +
> +	spin_lock_bh(&r->consumer_lock);
> +	ret = __ptr_ring_spare(r, cnt);
> +	spin_unlock_bh(&r->consumer_lock);
> +
> +	return ret;
> +}
> +
>  /* Must only be called after __ptr_ring_peek returned !NULL */
>  static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  {
> -- 
> 2.43.0



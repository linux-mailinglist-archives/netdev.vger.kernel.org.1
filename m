Return-Path: <netdev+bounces-225789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1279DB98491
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777962A76FC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AB22DF9E;
	Wed, 24 Sep 2025 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtCdeT/j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFACE1C84C7
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691684; cv=none; b=t+YDAkl5RfRGaaPQ8ga4TyLiPyl4bBef03/LBeqd1i7BEgl6LXIASs5AH72dcyx0tz0IBZzsHpfkLQgaEcFOFZWC+eC1yE7XL8EGMuFzdvZlZRB/5O9RSysCJIwaQd3df6KyeG5i3/EGouAbc5Lhh2MgwwIvz7hCO50yIoIBJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691684; c=relaxed/simple;
	bh=UFjExh43UXaUp/tZZHYT7ARaZowSev2WWH8n7m8z8D8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taQANdnobGkrNPgcVejgbIZzadlU+TcvfawsjVXrDJvgRHrLPe4UKwfbji50ObV4PFo0I8rxrCmOKCahvVKSBzznMc2AIbVuqX3xKUi7ytrnmE3ZMPcLuqZ+TBoX0AqsBjzGIQC8qJJqxnLvwOprjUJ4HjMYvGm5Cm+Y0xxOBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtCdeT/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758691680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Op26YAffBp8tOKfuV5Tcf4HuI3YKE+atQUTpt3Pe7A8=;
	b=RtCdeT/jc5y8UnjiNxOJ75Vff2QyTmaTRi/3GY0ARxHOr3ORp+7ph2UAd56bDl9k5GqoES
	nkM2VQtL4Gt5EGPNLuXTBOBcBvYh6s9ploAK4LYw0pOEwVvIwrkXCaXqA6RZ65FvrGBEUG
	lbHiTFtz9vB2vUh/GmXWmQQkxg3hVH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-RvNhP7IqNDOv2U9VHIYilA-1; Wed, 24 Sep 2025 01:27:52 -0400
X-MC-Unique: RvNhP7IqNDOv2U9VHIYilA-1
X-Mimecast-MFC-AGG-ID: RvNhP7IqNDOv2U9VHIYilA_1758691671
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so2605449f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 22:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758691671; x=1759296471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op26YAffBp8tOKfuV5Tcf4HuI3YKE+atQUTpt3Pe7A8=;
        b=LQfa0i6nMhVf6Ws62hUVxdVAtlA/S98JqRdX2cBZCSRlC/BGt7u6bNBBehy1+5D2HI
         UKi8Gmfgjruup3GDRhK8nColmM/oeHmXBiuLAh2hTpEnCnHiDZmx2Wz89wabqRrsqiI0
         FwieJZ0WEtNVEPFteUeWiPxg33KKjr5mYmInSwYrv9Tpi9nHXw/w94tZnPDuxLMRf9g7
         9Q9ArggUTEwWt3l9m+WYhidMXBa/oGHpEvKR4q+fb9dYwWgG2n8Q/76S/6JD8POCyn0k
         R5BL4sQaKy3ODe4sOH6YBoGkQ3zXf8Yihm10Gbrcvytf4f7+s8IGrK7H0jOhHb55P8n5
         bapQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqnvkfoPB7+h5PDf94K3Emu+/epMj67VABOA9aATHE8+elNQnSv2ieef7XplgvNLZrebEHCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bz15vsPOV4+fUtN93qEUzqXoBUVik+/Hx8TF1mPlp5frh+Sx
	7odj66dM5yJMu/ItQqPjNkBceM4BRClQxd3J+C5I8YpFl5a70EUT8cR76L0DV5b1uXR1/NPCGlD
	+/TzB4tu8CI8tlwOtMqa1dgqLjhjCmIptKIXX2ysNIvUqJcAX4ymGYENk7g==
X-Gm-Gg: ASbGnctcnEn/Xu8VPWlUUlcT91bM91DP9rMH+vYj9KYR8FpHwRoX0XxL52BVIe+USM+
	rFHA+mIlZp8knQpxT2Uvu550bUrnw1evHrYLCyRlMOFvZLFDIq2dtri9viSiJEaOlhOoA4wGcOv
	yeg2gTc7Chyyk8jv3SNBKZyK4FwJqolpQhhYPqpExnSoSFenz5ZnPL8EMrmexHRvwDUpWIuktYg
	iIf5KBZUSRG2MIytUPD4OeaQKC5esHEuC/oP2se+Yvdp4Qg2gmFT64zsVepJRClgpGRznSM9dPB
	Yz2ASgZKCgBPwpELJd63jtKS7yfsLfpD2oE=
X-Received: by 2002:a05:6000:2304:b0:3ee:1357:e18f with SMTP id ffacd0b85a97d-405c49a252amr4041717f8f.12.1758691670939;
        Tue, 23 Sep 2025 22:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+yFqhaqoFopq7rZf8kR+Ni9QC+PbuNvIk77bkhBjbuNAj+k34PkCijOGnyeAujdQIjd3OOA==
X-Received: by 2002:a05:6000:2304:b0:3ee:1357:e18f with SMTP id ffacd0b85a97d-405c49a252amr4041699f8f.12.1758691670369;
        Tue, 23 Sep 2025 22:27:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1d35sm28457392f8f.55.2025.09.23.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:27:49 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:27:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
Message-ID: <20250924012728-mutt-send-email-mst@kernel.org>
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>

On Wed, Sep 24, 2025 at 01:27:09AM -0400, Michael S. Tsirkin wrote:
> We have some rather subtle code around zeroing tail entries, minimizing
> cache bouncing.  Let's put it all in one place.
> 
> Doing this also reduces the text size slightly, e.g. for
> drivers/vhost/net.o
>   Before: text: 15,114 bytes
>   After: text: 15,082 bytes
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Ugh net-next obviously. Sorry.


> ---
> 
> Lightly tested.
> 
>  include/linux/ptr_ring.h | 42 +++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 551329220e4f..a736b16859a6 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -243,6 +243,24 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
>  	return ret;
>  }
>  
> +/* Zero entries from tail to specified head.
> + * NB: if consumer_head can be >= r->size need to fixup tail later.
> + */
> +static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
> +{
> +	int head = consumer_head - 1;
> +
> +	/* Zero out entries in the reverse order: this way we touch the
> +	 * cache line that producer might currently be reading the last;
> +	 * producer won't make progress and touch other cache lines
> +	 * besides the first one until we write out all entries.
> +	 */
> +	while (likely(head >= r->consumer_tail))
> +		r->queue[head--] = NULL;
> +
> +	r->consumer_tail = consumer_head;
> +}
> +
>  /* Must only be called after __ptr_ring_peek returned !NULL */
>  static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  {
> @@ -261,8 +279,7 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
>  	 * to work correctly.
>  	 */
> -	int consumer_head = r->consumer_head;
> -	int head = consumer_head++;
> +	int consumer_head = r->consumer_head + 1;
>  
>  	/* Once we have processed enough entries invalidate them in
>  	 * the ring all at once so producer can reuse their space in the ring.
> @@ -270,16 +287,9 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	 * but helps keep the implementation simple.
>  	 */
>  	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
> -		     consumer_head >= r->size)) {
> -		/* Zero out entries in the reverse order: this way we touch the
> -		 * cache line that producer might currently be reading the last;
> -		 * producer won't make progress and touch other cache lines
> -		 * besides the first one until we write out all entries.
> -		 */
> -		while (likely(head >= r->consumer_tail))
> -			r->queue[head--] = NULL;
> -		r->consumer_tail = consumer_head;
> -	}
> +		     consumer_head >= r->size))
> +		__ptr_ring_zero_tail(r, consumer_head);
> +
>  	if (unlikely(consumer_head >= r->size)) {
>  		consumer_head = 0;
>  		r->consumer_tail = 0;
> @@ -513,7 +523,6 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
>  				      void (*destroy)(void *))
>  {
>  	unsigned long flags;
> -	int head;
>  
>  	spin_lock_irqsave(&r->consumer_lock, flags);
>  	spin_lock(&r->producer_lock);
> @@ -525,17 +534,14 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
>  	 * Clean out buffered entries (for simplicity). This way following code
>  	 * can test entries for NULL and if not assume they are valid.
>  	 */
> -	head = r->consumer_head - 1;
> -	while (likely(head >= r->consumer_tail))
> -		r->queue[head--] = NULL;
> -	r->consumer_tail = r->consumer_head;
> +	__ptr_ring_zero_tail(r, r->consumer_head);
>  
>  	/*
>  	 * Go over entries in batch, start moving head back and copy entries.
>  	 * Stop when we run into previously unconsumed entries.
>  	 */
>  	while (n) {
> -		head = r->consumer_head - 1;
> +		int head = r->consumer_head - 1;
>  		if (head < 0)
>  			head = r->size - 1;
>  		if (r->queue[head]) {
> -- 
> MST



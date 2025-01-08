Return-Path: <netdev+bounces-156247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECDDA05B48
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9C1889FC9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3820B1DE895;
	Wed,  8 Jan 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha0Wc5JH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2A1FBCB9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338548; cv=none; b=MOeZSgKQxLYdpLWATkLJmYO0VDRukoPYs5y5/a15gHyf3TDOFB/zXNrQsrptCcyM/E8jFhDmP8xnko/c82zGyevGMRdSdaAhQBYZrV3M6/9orOlmPwDpxTDsUSG16J1W50CcvSFfUWjegNlumSmP7IaAoIaNhCrM/BhwUFu/di8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338548; c=relaxed/simple;
	bh=OqojvAOQdZS0yj4ZVZFm47SzmmZRZEQKJGSfgoE2f+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBa+pw2Bp9r5gBiBb1eRv08+KXU/84TwtPB7Xr+pAfwRzHgC1q1Z9H6Sw3RhGx6le/0XVaQBJe6ZIRYvtxXGLHyODkAE3vcWxVtq+AP0R/o93xE1hBkCOh46GmafRJ62XVnaN11pwV3ICpUxJlsFI78Y2WwDw67CGUNRq9kY5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha0Wc5JH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFFT/vNzip1RPoosirB5rZ8ksM/hte4x/jhW8SUMpHI=;
	b=ha0Wc5JHzN83B6sCVc4QfoA/hlg0KZaMXsp8rxzFgUAkypJPI7DIqhkRQviGbuAvTY1zer
	KrCGfre/X9IyxxBx8ZsaV9zX1a7hX2Cv8vAXDKpGimRwkXOJz65XzodGn2NRpbgyUCMpHm
	jz6Lt9sy085or/da6xh+jkAHvA8CSck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-qD2mgp0tMDyrb8Jbr54nyA-1; Wed, 08 Jan 2025 07:15:43 -0500
X-MC-Unique: qD2mgp0tMDyrb8Jbr54nyA-1
X-Mimecast-MFC-AGG-ID: qD2mgp0tMDyrb8Jbr54nyA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-388d1f6f3b2so6682602f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338542; x=1736943342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFFT/vNzip1RPoosirB5rZ8ksM/hte4x/jhW8SUMpHI=;
        b=D5/vAtt82F+82pxu4wpMLxa0LmoQMHgrUCwVSIhQPwqH1BDW8VBh9miyum4DRj6T1N
         pvhA12uT8GnUnKs7jjNYnArOldV7NN8lASdorzujxirDEMCci8qeqHhBsVl2JI/V2DSr
         bk5+n66lVth73KalwF/43hpmOBZziL4nQYO1I0TC3h1cZnVzuk+3dyZLc+Wfgm0fnt/Z
         vRjHjjQh0jdJ003VQCDGx1e+TTVy26hf1Jsg3fv8iurQShclAWu2Ldz1nT22yWH9T3r6
         MBzq0W3vM1TkBDZ9o3ASvXcwoUPJUIw7glI40DCzCDnAz7Xh8T4LAYOtlxmK154Didq5
         mSKg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2UvUX42DRBAMgIbZuJb6Tr14cUFG4rovuSNM3lkuBI2K/5XFKzEsgV13tw5BdeOBvqpqjt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3k0BWF6d/OZ5wmriJbJpS65LcvI40QGSjMpEzgRJl5P0qw6t
	gI8cErIyFaRdIBZOzLmoXoR5Wj2E1xSep7wdRVAcXaqgLa5tSjtdhq8FhKM7ws2iyjbSPUx+CIV
	X4Qb+b3H078/xe1lBKfQFMTsYiwIZtFVM9ML8t/uDxpTuBCGQIPyKCg==
X-Gm-Gg: ASbGncveaQVwzz5m9yjqsu2BiLPOKeo31i8E4gvewqwVBMM4YdixWL9c9oH97ZogqPU
	5u/68ePJvu10Y5ZqqV6QPKOtErbGVNBAKaWTJCFRIUh42AIMNr8Y5nc6u+wBh4AEVq2MclMG0Ld
	dQIH1VJPCCVZhunQ37Hk4bOe9b+v0JLJTW9YthYIgz9VmRcNN/cvHn409nNQhvXRxbd+S8Vpt/C
	Q6X0tWJdVKWJd81hkxjJX7iK6WjNLDpT2DoKbEV1w7vaxMm9Y4=
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr2066558f8f.9.1736338542113;
        Wed, 08 Jan 2025 04:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+hsGgqCsiIWeOXVWHmgrZwnMiJD4OWipciIeE4FGEZqdLeDGimlpEKTMbbuIjZpmwpZibCg==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id ffacd0b85a97d-38a872f6915mr2066535f8f.9.1736338541761;
        Wed, 08 Jan 2025 04:15:41 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e03210sm19211155e9.34.2025.01.08.04.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:15:41 -0800 (PST)
Date: Wed, 8 Jan 2025 07:15:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250108071456-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230124445.1850997-6-lulu@redhat.com>

On Mon, Dec 30, 2024 at 08:43:52PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I'd like a Kconfig option to control enabling/blocking this
ioctl. Make it a patch on top pls.


> ---
>  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index ff17c42e2d1a..47c1329360ac 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
>  	struct eventfd_ctx *ctx;
>  	u64 p;
> -	long r;
> +	long r = 0;
>  	int i, fd;
> +	u8 inherit_owner;
>  
>  	/* If you are not the owner, you can become one */
>  	if (ioctl == VHOST_SET_OWNER) {
>  		r = vhost_dev_set_owner(d);
>  		goto done;
>  	}
> +	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
> +		/*inherit_owner can only be modified before owner is set*/
> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +			r = -EFAULT;
> +			goto done;
> +		}
> +		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
> +		if (inherit_owner > 1) {
> +			r = -EINVAL;
> +			goto done;
> +		}
> +
> +		d->inherit_owner = (bool)inherit_owner;
>  
> +		goto done;
> +	}
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index b95dd84eef2d..f5fcf0b25736 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,23 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1 (default behavior):
> + *   - The VHOST worker threads inherit their values/checks from
> + *     the thread that owns the VHOST device. The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> + *     implementation, which may be preferred by older userspace applications that
> + *     do not utilize the newer vhost_task concept.
> + */
> +
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0



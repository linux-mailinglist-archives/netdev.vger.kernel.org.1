Return-Path: <netdev+bounces-156238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB181A05B28
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0541881EFC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951C1FA15E;
	Wed,  8 Jan 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWEwi+Vx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E1F9400
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338417; cv=none; b=cc6kxxl590159v2B9FaZ97AHMUeSxzzC77c5wARDlXMmMvxfzTutZY/gDIb4MAiAgGxtq/B6RRpPhv4VKU8hf3OZxEryeN9e2oe48A1MHAB3I35fO+9o2syUZVP/6YJP5W46ZUHPrykU24GpwYwkYMuRl58iN3c2KASBK84n/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338417; c=relaxed/simple;
	bh=d7f8krLI3sio/JPw5wyDY2mgXVXa4Il9oYZULrgrmls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSWEn53rJkJWG+hjzFxqm4shfFr3+4cDWcfX+DCkYXQDihDScP6u3Bxt1uHuL1grhyxPcIkilwa9FXJ946g/sS046hiuNf58OWhaZr8L2ol0J6ewlXT02nvCZPHPsqSsk3qtJnyvd5ezipNxeABuGZPSzzUCRWwJ+pT/26wUqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWEwi+Vx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bcqwD+plhNgGAFGqLcZ3Vozdz+RdeOGXJJcR/HY5MSA=;
	b=PWEwi+VxxuOoYDKI8PZYijW07s4N4pIurywKHpc4UyZoFon+GSpspSHtsMePOztZHi4h6n
	/30tP5909OMncu350Jvcadh0t5F7oC5Mmb/hAwWktzWHvq791pJlMdHdMye+cOK4+3q3je
	FvGD8mjH4C7Czm1jUsafTkAnzDuuBPI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-dcifnp96Pk-hTG6m1vA0fw-1; Wed, 08 Jan 2025 07:13:33 -0500
X-MC-Unique: dcifnp96Pk-hTG6m1vA0fw-1
X-Mimecast-MFC-AGG-ID: dcifnp96Pk-hTG6m1vA0fw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68952272bso455668666b.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 04:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338412; x=1736943212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcqwD+plhNgGAFGqLcZ3Vozdz+RdeOGXJJcR/HY5MSA=;
        b=ahQ0A1jxbfCpJ1ag+E/UMg6V7bv2d21KtsxtrztL1jSQJet19hNfnITlmtkxT5DY4h
         IdZg83fCJJ+Q+pBoXtxSAw59fSOiOmjVrLp/erAQB3tj1fbyvq5m/bqcNwNAQlXPxNrY
         OYY7h19uO1hw1/8sotWcXZhEIMyXT3kMnlLBIB/TlQ0/EBtXUPgEABPTlRcsL4p07r3P
         ISTOsVbhL8svJ8py8VPHzesGGZzhdkVDNXjLIfg3qAuQB9cqw/XSlPIf7TFQ7xprIGba
         QMftAQw9idB5FGei2rMdUo0eRlKwbcaDiUaAE8clNKrH6TVDRE4r8rKHjRsKZJp0I7Er
         BnZA==
X-Forwarded-Encrypted: i=1; AJvYcCUcv5uWDz9fqsTHANDhOErUq4U+FveVNqeX9KVJx1KnHxhFqRR/NZFyKwyxKzafZzq8eV75Tl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRHAVMcRUuHopBk8kMsL7XTBLwYXb5ly5GNix/oLhvGqQF/Qb
	9NV4darGa/59sRQ3HVxo/AvitxT0+TYt4M1h7nq6OzATfHRCcmpk1OQ4+LCrqtLaw0Ms9CLfAsJ
	6LHYUG+yfKvEHqqVJ90ipXCwZR4c+B0A3cS7N+SyVEdG75nsAwy9PTg==
X-Gm-Gg: ASbGnctaXy7khjZ4KYsN0ckinCqFgwfvUisg9+bLAKawjC0Jehba+neB5cMlTWU5DNR
	g1EnNQpsvXbH2kfVxNefyp3vEo7pdvBg/oRCAoJ6zpPAZSOEmX1aarYpukXR2qenYMp+TA9zBPl
	UDUoj/Ent+alN7zbZgkCjaywiwKZVp1R+wXRcTBcICXQm/0BMzNEybkRjkJsYQ9CTmqVwNrTrzM
	mEsaFH/G516XtMa5vnBHhLqTs2pQ9AxytZjoP8PwVnUdPrhQLQ=
X-Received: by 2002:a17:906:ef0e:b0:aa6:9e0f:d985 with SMTP id a640c23a62f3a-ab2ab748e6fmr186651666b.35.1736338411968;
        Wed, 08 Jan 2025 04:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1tzHlmToonYU5VRNpZjPrkTmxuXnu7JCDwg2y8QM+1b+3gwVx6kdoXsaFrzdS6+50/P9Meg==
X-Received: by 2002:a17:906:ef0e:b0:aa6:9e0f:d985 with SMTP id a640c23a62f3a-ab2ab748e6fmr186649366b.35.1736338411574;
        Wed, 08 Jan 2025 04:13:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06c654sm2510917266b.185.2025.01.08.04.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:13:30 -0800 (PST)
Date: Wed, 8 Jan 2025 07:13:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Message-ID: <20250108071107-mutt-send-email-mst@kernel.org>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210164456.925060-8-lulu@redhat.com>

On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.
> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Good.  I would like to see an option to allow/block this ioctl,
to prevent exceeding nproc limits. A Kconfig option is probably
sufficient.  "allow legacy threading mode" and default to yes?


> ---
>  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3e9cb99da1b5..12c3bf3d1ed4 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
> index b95dd84eef2d..d7564d62b76d 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1:
> + *   - The VHOST worker threads inherit its values/checks from
> + *     the thread that owns the VHOST device, The vhost threads will
> + *     be counted in the nproc rlimits.
> + *
> + * When inherit_owner is set to 0:
> + *   - The VHOST worker threads will use the traditional kernel thread (kthread)
> + *     implementation, which may be preferred by older userspace applications that
> + *     do not utilize the newer vhost_task concept.
> + */
> +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0



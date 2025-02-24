Return-Path: <netdev+bounces-169206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7051A42F6E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852F5176236
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705981F3FF8;
	Mon, 24 Feb 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBJfrgcg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C61A9B23
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433579; cv=none; b=pb+oqrVrCxSo9qzMqJHJzdXdO7351IQPpqHeZw71+3NdQMqOFikSY/mq0NCU9vy1QIN9QgdgeD7ymaCWPuj0A0D0VPJzNgF1lmghUMRA/QNsZUU/6TWKFlsxvKtLa3mStPV30jmkTAAaFzr2I9/y8P7KSg/C2g2zC3VlC0mxBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433579; c=relaxed/simple;
	bh=e+kYByMXNeDUALN2Jm62hIYRxASWL87Qinb3VWV2j40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/J33H+7c2Wm+LJD9JEJMeeZYyfab0am5cIUmzgm0GZEQT8+9QD1EHVjBEepV47mPYtI6++fxQ6I0wZtk+P3B8OFnYLx3EXI01PaWwwRNwvyc/S4bIc5ELwl/ryF9ws5lR4JbLy+Zirtt3C4+lXc+5//DpuILyLEIcKx4b8hWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBJfrgcg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/djJ+PtX4FDl6jsu51ShmCbl9JrXbgv9LkcxGG2wMj8=;
	b=iBJfrgcghoMt4jVMUZumxVDUhUa1I0Ax8r99o09wcJ8HEBmm1WOrQdyz1NGw41ktqLjbU8
	6vPyOrL65yBmFPLJ7A1JwOc7PPKwCrO2djAs8CKevsCq3OwYZxpTx5FUyt67E2jYPOzhDy
	z1zd2Dtobb4Ij6ulDb18D8EBrK22NOQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-R2tfuA7mOgy84ONoDwNbHA-1; Mon, 24 Feb 2025 16:46:14 -0500
X-MC-Unique: R2tfuA7mOgy84ONoDwNbHA-1
X-Mimecast-MFC-AGG-ID: R2tfuA7mOgy84ONoDwNbHA_1740433573
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so352690166b.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433573; x=1741038373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/djJ+PtX4FDl6jsu51ShmCbl9JrXbgv9LkcxGG2wMj8=;
        b=kNnX2tEI3WUfYiCphtpiibBX8934z7YO9u1jmv0ZzWf/U2u7hYk8vpfP5+gmgcTMiP
         fWE0co7T8id+jGjrqYlbBzQHVQzxnkcpXm9j9BuVQORnbUP2NfdUpqxaIgkI/jAIc3eI
         yagP1EhfBoKxssdWsWtD1aWNNnISbb5VhoD2Uv+Ol41gksSPvgE6sDjQ8jQFs1sk12wU
         GVx/vqi8VFDNRSakgwWQZdhDqNbPYOODJBA7quC8taE79xgvovqYab/j0l+wiRiacH7i
         /Ib0+c+pqaUWQ/2h9WykNMpQoe/pdG/MAW0Ag5/hMi13Jpe75dVDIhn0EK1oCjVmEIWC
         DVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUotxkc4ddrEqg1WCuP+y/2R5cofE6Gu6Xwba3N7jU9+jTu7gYHGDFw8whj2kBDwZdmhq6JM5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9Ics2m1IsR38rbzUgGtrR8MlILJ3OKLRB+bU8LDSDpKYXBD4
	Z5MghNEkvuGoJq8L5uBlc3HM6jx2DWJpxtZwUhNruCH4Xubr18KIPcDO9fyzVHvrsrjfrhTrQ3b
	GpqRkFoReEx7bqjyW0QoRtFkDeng9QtYP9rk0tDQIHtGZEEgG0WnhYQ==
X-Gm-Gg: ASbGncuLlTYSHfuGP8mE8kCiSHpqh3brzWz8gaOZ2k4IY73nD7TbNuz2hKIw53sVvJL
	HImxC+YJ/dPfR80FGo9264V/VOZ2Wq/bh/Xha6qT/2FOULVSV3lFEOYEkl81iiBP1GPASq3ujqt
	JYoARP9iD3f9WH7WNCJ2wpobZa+cBBpiv0undrMY8Qgfp2v4eAIvFu11e7/oP5eeFkiafF7wJP4
	prtw5UmPmqy3VCyZU3T8llRpY/c/aD7OIA4x0r9YDngVX+rTxkPVyPhPuXJckKicKMlIVK4KJOX
	CuX+8yErvQ==
X-Received: by 2002:a17:906:399b:b0:abe:cb87:9599 with SMTP id a640c23a62f3a-abecb8796b2mr187043766b.44.1740433572896;
        Mon, 24 Feb 2025 13:46:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7OyvLnm+e7goejV5zHakF8+COjfdjxx8Ny74h+t1TgYk1yctpE21hRJ1pnICAkf/LM9wawg==
X-Received: by 2002:a17:906:399b:b0:abe:cb87:9599 with SMTP id a640c23a62f3a-abecb8796b2mr187042466b.44.1740433572546;
        Mon, 24 Feb 2025 13:46:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd4c23sm28274366b.11.2025.02.24.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:46:11 -0800 (PST)
Date: Mon, 24 Feb 2025 16:46:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <20250224164312-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>

better subject:

vhost: uapi to control task mode (owner vs kthread)


On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> Add a new UAPI to enable setting the vhost device to task mode.

better:

Add a new UAPI to configure the vhost device to use the kthread mode


> The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> to configure the mode

... to either owner or kthread.


> if necessary.
> This setting must be applied before VHOST_SET_OWNER, as the worker
> will be created in the VHOST_SET_OWNER function
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
>  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d8c0ea118bb1..45d8f5c5bca9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  	int i;
>  
>  	vhost_dev_cleanup(dev);
> -
> +	dev->inherit_owner = true;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
> +	if (ioctl == VHOST_FORK_FROM_OWNER) {
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
> index b95dd84eef2d..8f558b433536 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,22 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
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
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +
>  #endif
> -- 
> 2.45.0



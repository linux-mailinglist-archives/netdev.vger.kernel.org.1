Return-Path: <netdev+bounces-118347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87595157E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA701C266AF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24726143C7B;
	Wed, 14 Aug 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih4OhHVA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61455898
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620447; cv=none; b=XOOYF5Pm/GBDyEJT+f+BAv2ZmCig+zy34pT8dxW/MM3ZFC9hk7GuBxu6O2whzQbcEPy/J5NgJEX0pzdUbJbx6tBKhd2xFWomH53CPVSq2AM5Lf+1ixXaDkd4AUxhjPebVOjHgllm5Z++5ZPFvtUqOdJLbXtl3Ca7o/uDJMP7pG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620447; c=relaxed/simple;
	bh=1UP383j6hjG1P69n1FRHYze421i09BJSQebpheB6rVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AECP6WAJ/vTHeeG5b1r/NRlzHq7wViyc2xWzVGoZj2EcZ8omYpSd9LlNqCjP7OuShgiFzDl52LJz0vGIiGP7741ZWdtJjQqCOk2koTk2wmOI1bqWGqJKnMxDpe7oXLD9ytzrFQfylMHgsL1YkjXg2wZ7NYpv6hElNsrsP5njyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih4OhHVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723620443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
	b=Ih4OhHVAICbUeWWP6Tgwb5apy9vBT1ETH2CNM8owRiUdiSPhhG+bXggByXmOJfQlC34hNY
	9ml8wSSi9U4GRzOqzzgsRLW6sLC6kSMMBu28ZAwUmC+LbpeUxTU4d33J+tnZMy/ErTTtDD
	b5yqGCyidS9uLAvHrAi7dxcPVgUY4Kg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-tKIPdbRLO3ySZpUz5sCodw-1; Wed, 14 Aug 2024 03:27:21 -0400
X-MC-Unique: tKIPdbRLO3ySZpUz5sCodw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a822ee907so506536366b.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723620440; x=1724225240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWW6/JtLLOdbS2RriwQ1Xt/j+3UDgvX+fkiP4SLbmfs=;
        b=v0EI0wHV1f959Q1vKjjxDhd+uLdHCJwc6VQrSJbpvAwUdlONZUeHljye9hd4TrNWGy
         SCJ+XrkQpPotzXyrnzHiMQm8Jdof8u9PNLtUus0a+SSD+/xPDAQWvIMb9xrDvbGbxqxD
         Nsr1P0blbhD33mM9lxT7tdU8U2OoUa68y1EnAMsbIpgkHDhWKn16aieKABsUey+G37/1
         06z8aq06ezz5eRksBSafOQ4VeJ63ZYtb7eFcnDVeBjIPn3MvDDqBGtFUmVUTACyAhU9W
         6/zwVBHGAAZqxCaEN/fp3U7loFXHwEjc1WcV0gUHSzTnbtHm9V/Wal1yVOttj/vi7YoE
         Z+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV2V1I5FD7u1GuIDlqBz+bw0nti58v6YWTzDtGRKKk70dLCuWMGqzCmhJpCIKCSSza54IvaQ35cPRvm3HpNi9s+8mxUY1J2
X-Gm-Message-State: AOJu0Yy9K/VGqFRdHCeQ2RE9fXx+Rvq4AG7YP5ui/7RH5yaYkeWFygMB
	caSYVZZmNCx7Tp33K49w0C/Wd6J6AadIDZkyvNGTicOxImudEcCKbyuo/OQXw+38G7REC4NOmEY
	mKEVjOzp3NUtuGdJsLgSuVa0kY1NE7Lbm1UggHVefucFO6jMRcVbztw==
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116566366b.18.1723620440175;
        Wed, 14 Aug 2024 00:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWLP3dpgqeL2l8ABzufX/5DIla/d7Ejaojfhfx0OWK/1bdtH+0ljIF9zLiuDaMf7faqOl25Q==
X-Received: by 2002:a17:907:e6cb:b0:a7a:83f8:cfd5 with SMTP id a640c23a62f3a-a8366c31b00mr116563466b.18.1723620439327;
        Wed, 14 Aug 2024 00:27:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411d225sm137283666b.107.2024.08.14.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:27:18 -0700 (PDT)
Date: Wed, 14 Aug 2024 03:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, lingshan.zhu@intel.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] vhost_vdpa: assign irq bypass producer token
 correctly
Message-ID: <20240814032700-mutt-send-email-mst@kernel.org>
References: <20240808082044.11356-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808082044.11356-1-jasowang@redhat.com>

On Thu, Aug 08, 2024 at 04:20:44PM +0800, Jason Wang wrote:
> We used to call irq_bypass_unregister_producer() in
> vhost_vdpa_setup_vq_irq() which is problematic as we don't know if the
> token pointer is still valid or not.
> 
> Actually, we use the eventfd_ctx as the token so the life cycle of the
> token should be bound to the VHOST_SET_VRING_CALL instead of
> vhost_vdpa_setup_vq_irq() which could be called by set_status().
> 
> Fixing this by setting up  irq bypass producer's token when handling
> VHOST_SET_VRING_CALL and un-registering the producer before calling
> vhost_vring_ioctl() to prevent a possible use after free as eventfd
> could have been released in vhost_vring_ioctl().
> 
> Fixes: 2cf1ba9a4d15 ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Want to post a non-RFC version?

> ---
> Note for Dragos: Please check whether this fixes your issue. I
> slightly test it with vp_vdpa in L2.
> ---
>  drivers/vhost/vdpa.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index e31ec9ebc4ce..388226a48bcc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -209,11 +209,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	if (irq < 0)
>  		return;
>  
> -	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  	if (!vq->call_ctx.ctx)
>  		return;
>  
> -	vq->call_ctx.producer.token = vq->call_ctx.ctx;
>  	vq->call_ctx.producer.irq = irq;
>  	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
>  	if (unlikely(ret))
> @@ -709,6 +707,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			vq->last_avail_idx = vq_state.split.avail_index;
>  		}
>  		break;
> +	case VHOST_SET_VRING_CALL:
> +		if (vq->call_ctx.ctx) {
> +			vhost_vdpa_unsetup_vq_irq(v, idx);
> +			vq->call_ctx.producer.token = NULL;
> +		}
> +		break;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> @@ -747,13 +751,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			cb.callback = vhost_vdpa_virtqueue_cb;
>  			cb.private = vq;
>  			cb.trigger = vq->call_ctx.ctx;
> +			vq->call_ctx.producer.token = vq->call_ctx.ctx;
> +			vhost_vdpa_setup_vq_irq(v, idx);
>  		} else {
>  			cb.callback = NULL;
>  			cb.private = NULL;
>  			cb.trigger = NULL;
>  		}
>  		ops->set_vq_cb(vdpa, idx, &cb);
> -		vhost_vdpa_setup_vq_irq(v, idx);
>  		break;
>  
>  	case VHOST_SET_VRING_NUM:
> @@ -1419,6 +1424,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>  	for (i = 0; i < nvqs; i++) {
>  		vqs[i] = &v->vqs[i];
>  		vqs[i]->handle_kick = handle_vq_kick;
> +		vqs[i]->call_ctx.ctx = NULL;
>  	}
>  	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
>  		       vhost_vdpa_process_iotlb_msg);
> -- 
> 2.31.1



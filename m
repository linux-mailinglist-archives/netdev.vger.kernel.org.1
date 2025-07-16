Return-Path: <netdev+bounces-207466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A412B07720
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163101C23C73
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6B11D8E1A;
	Wed, 16 Jul 2025 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLCIKI6L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23431C5D44
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673104; cv=none; b=n/RtII4PoEYA2cK2rhoamzELanEbSjJAZEgj05cJ6u0jiOuXfdkBp8xFwTp6xSmCMgJBAUG29e7EaY8f8ETk+DAu2c8DE5EQQ0FtswK5OEsgqC0UfjyCmA3bvR2pCgXucUvlLoUbxAqeYS4Fg2K03PV+CW7E7s7knKMtD0QpYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673104; c=relaxed/simple;
	bh=+iHvtiP4dVRUwu8zgMFFhXFii73LKNAGPkqOJ4OL0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbWTbVghT8J8vYCGad/jhE19Z5vbDrG5z04isDbEaKn71N5KfwRoRyThCR1yl3n7VifgAF+mZp5mrnQ8n/QAM0tOrrH9Qx+j/eHq+LywrTzw5eTPcOx4DSU9jkoV0/IGFc7qccfl1/BSntjmYQ0fb0w77aabTV/cnRwAcSXnAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLCIKI6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
	b=gLCIKI6LRb/e/4KcXK2dBSwiWpYbISLVZIQYa6EgAAN051DiHi8FmOpx1KI8B3o/DAPUwB
	fuxLZy+XPi4YqPCIMPR13aOgcDV3yPzBmyAS4Sgb6E7zwWncaggiJ9xTTWNJVMuOQUUbmu
	aNNFyBNAQes2bNfNN1SweOJThxHv6FE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-EZ7gouxaN3O-TnMraI2bQQ-1; Wed, 16 Jul 2025 09:38:20 -0400
X-MC-Unique: EZ7gouxaN3O-TnMraI2bQQ-1
X-Mimecast-MFC-AGG-ID: EZ7gouxaN3O-TnMraI2bQQ_1752673099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so2655263f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673099; x=1753277899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbdAneayJf7wacuXl5G+NfMjm/fAiFdmts8eam55w7A=;
        b=Uc9LXJUnF2/LK2vtqtDKG0XK//3JYWRTBEiiR0zgccwXP6dQfGJFD0M3uXHYex3Ah4
         a0Lv8Mkro4iAZKZsRVJaaG00DW1j5NG2tTtj+loPeoQ14zvy6SJoZZmjGde5Cn3q7lty
         EFTfDIS2h2rf7agivOsdgDPrRJ1YDKQpK3+2A7rPxt1noi2DL9VcA12/J87lW724KlY2
         TcCK4/JFNjEPPeZfBp/NM3BKWCxAP1UJwR+0AA70x6TFZnKC/8SiyVqooxPOwsPBm620
         cvEBqYv7S8DYIOxidv4zlDXCJ7wnO7G4Ea9Ady7gH8pzuN8sL89xlAp5gyuUEBXsjhIf
         30jA==
X-Forwarded-Encrypted: i=1; AJvYcCV8fxKqvB+art65N4ux9NyPrsIi4WOHIaAHAjFoEDCY0YG+N4Isa/7+NlV9n/dE+6Zh7kA2SLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCmYBfZgdXXASFC4ZoJRx5lcuqGqw/da2V2/vfzydjX6LlJkp
	MFiUUr+Yg2RJIbWBUDw0OXryHm6JS+fG/4yFOLL/3M2Cy8aR8zisZC1f0KMGQDUciS2aHfJEE7I
	49tcJrdeBcbJtavgu/t7ICqvccC7M0JX8hPOGvIGVEBp8asF5B4ucDroPZVzDqW7xaA==
X-Gm-Gg: ASbGncvBUTiJ5xdRS57cJhtPnv10Lt5uGoT/Vz3s/l74Zt2bPk7N265WpsF3dmgTngP
	23uZzjUiumnrCfYIlERznnvHaoEAqIs9gRPIm6cMcHqu59Krek/qjy0Kz7/ev922a3Y7B1AeysU
	iCTBG1CTewOmx+gn+Drkf3UTZl7fnuMYk5VKy/GhISooW3C6uEtT2gqfxa9d1Fk/+ZvwHr6I59t
	xzbmZ9MmL4/0l+evyDlTRdfgwFe7q7EJJ6zj8GlUu6XZ25nSx2VZdTX0FaPjPafghX2M99wSVj+
	M6F13bCkTz1uL+WnKYA6RER/oD7dCWWu
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892560f8f.16.1752673098833;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHONniWygBXciPr26x3pHj0nvSDyjvuSRdQI8CkI7uj3vzxwTl+/0L6TJlAmz7DGZ27LNtzhw==
X-Received: by 2002:a5d:5e88:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b60dd51291mr2892536f8f.16.1752673098367;
        Wed, 16 Jul 2025 06:38:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm21517885e9.10.2025.07.16.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:38:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: Fix typos in comments and clarity on alignof usage
Message-ID: <20250716093552-mutt-send-email-mst@kernel.org>
References: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615173933.1610324-1-alok.a.tiwari@oracle.com>

On Sun, Jun 15, 2025 at 10:39:11AM -0700, Alok Tiwari wrote:
> This patch fixes multiple typos and improves comment clarity across
> vhost.c.
> - Correct spelling errors: "thead" -> "thread", "RUNNUNG" -> "RUNNING"
>   and "available".
> - Improve comment by replacing informal comment ("Supersize me!")
>   with a clear description.
> - Use __alignof__ correctly on dereferenced pointer types for better
>   readability and alignment with kernel documentation.
> 
> These changes enhance code readability and maintainability.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks, I applied parts of it.

> ---
>  drivers/vhost/vhost.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..0227c123c0e0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -594,10 +594,10 @@ static void vhost_attach_mm(struct vhost_dev *dev)
>  	if (dev->use_worker) {
>  		dev->mm = get_task_mm(current);
>  	} else {
> -		/* vDPA device does not use worker thead, so there's
> -		 * no need to hold the address space for mm. This help
> +		/* vDPA device does not use worker thread, so there's
> +		 * no need to hold the address space for mm. This helps
>  		 * to avoid deadlock in the case of mmap() which may
> -		 * held the refcnt of the file and depends on release
> +		 * hold the refcnt of the file and depends on release
>  		 * method to remove vma.
>  		 */
>  		dev->mm = current->mm;
> @@ -731,7 +731,7 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
>  	 * We don't want to call synchronize_rcu for every vq during setup
>  	 * because it will slow down VM startup. If we haven't done
>  	 * VHOST_SET_VRING_KICK and not done the driver specific
> -	 * SET_ENDPOINT/RUNNUNG then we can skip the sync since there will
> +	 * SET_ENDPOINT/RUNNING then we can skip the sync since there will
>  	 * not be any works queued for scsi and net.
>  	 */
>  	mutex_lock(&vq->mutex);
> @@ -1898,8 +1898,8 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  		return -EFAULT;
>  
>  	/* Make sure it's safe to cast pointers to vring types. */
> -	BUILD_BUG_ON(__alignof__ *vq->avail > VRING_AVAIL_ALIGN_SIZE);
> -	BUILD_BUG_ON(__alignof__ *vq->used > VRING_USED_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->avail) > VRING_AVAIL_ALIGN_SIZE);
> +	BUILD_BUG_ON(__alignof__(*vq->used) > VRING_USED_ALIGN_SIZE);
>  	if ((a.avail_user_addr & (VRING_AVAIL_ALIGN_SIZE - 1)) ||
>  	    (a.used_user_addr & (VRING_USED_ALIGN_SIZE - 1)) ||
>  	    (a.log_guest_addr & (VRING_USED_ALIGN_SIZE - 1)))
> @@ -2840,7 +2840,7 @@ void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(vhost_signal);
>  
> -/* And here's the combo meal deal.  Supersize me! */
> +/* Add to used ring and signal guest. */
>  void vhost_add_used_and_signal(struct vhost_dev *dev,
>  			       struct vhost_virtqueue *vq,
>  			       unsigned int head, int len)
> @@ -2860,7 +2860,7 @@ void vhost_add_used_and_signal_n(struct vhost_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  
> -/* return true if we're sure that avaiable ring is empty */
> +/* return true if we're sure that available ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
>  	int r;
> -- 
> 2.47.1



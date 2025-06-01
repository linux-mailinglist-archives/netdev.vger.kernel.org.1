Return-Path: <netdev+bounces-194523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73EAC9E60
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 12:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E7C7A37AB
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E601ACEDD;
	Sun,  1 Jun 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etDKjry9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2EDF58
	for <netdev@vger.kernel.org>; Sun,  1 Jun 2025 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748774961; cv=none; b=TOJbYXtTIcA9JveiQLc3C/SIgAPBJ4tdMH8gqOxE71UwCP4dR0lMt7VaV1eKv7bjN2E7smarUGuVS4rJ5GDLKZ6OwE4JrbFf6kzFaBSqY+VpgKIRtdqBV1wz+H4VFb/XM8hLFuOv5etESn8o3O17i5OHjIzi971seEVGXHnvo8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748774961; c=relaxed/simple;
	bh=kBLKF1AdFh/RK7a1OTYX+QEN6rDtO9n4uA58wanc4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqCU/U7iK3pABPi5hMHpFGrufC9UnLpJS3fFBQC0pWTZrkZ+rNf33iER+El7OvWBXh65SV/HbT0nVZF6Eo7TnqmFA1KpY8QhPFmqAKXumUJ5lHlhyf68YgUC2zFRBrKZe8qsKQpnhOMKSeDtyGvVnmfn1DURFWq2oBZBDOWDDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etDKjry9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748774957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfBKjlttcg3nh+GmuVdjWfmJaLtSoWbkOCvRrt0qU0s=;
	b=etDKjry9whOfA7CTKpm3zsG7UPff36gI3PZ+aWf2hTzvd8yTcwn3Qmx63Tq3tJAqU9LhBB
	bIdHKvwqTU3Fmmw73iAChhx52t77OKzEKn47HzhnupDKmUY3IgFazRBGL7TmydOF00qbRM
	Z6LxeOt3xBT6kMjKD/z5lZcNrCD2dcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-YZv81w-6OgCH23afjkZ5jQ-1; Sun, 01 Jun 2025 06:49:15 -0400
X-MC-Unique: YZv81w-6OgCH23afjkZ5jQ-1
X-Mimecast-MFC-AGG-ID: YZv81w-6OgCH23afjkZ5jQ_1748774955
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d30992bcso5877485e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Jun 2025 03:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748774954; x=1749379754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfBKjlttcg3nh+GmuVdjWfmJaLtSoWbkOCvRrt0qU0s=;
        b=VnCSOFv4jXQ2Nz+ZhFGmgL1WmkPDSteCypUt0f7C+tBOIqlcoXYXTmwWkxXHbqr981
         xxLxUW0QPQReB8171v01Ey8xxNjezVRDZ4w2sD3D7VHeFadjgRn6qjDGCtwt4ffVvz13
         /2tvCQ2Ov/PS3R0/PPCcFTqbDZXK1r+f9OoaK7AVd5HwZNcRqENABiTp1+D1gG08xwFl
         GAdCmRM7/a4G/A2z01jGpAV4ogynoptKv7bqHaO6WwQYuycySofBnY3CjYaF80a1B0WC
         2VD+66fDQ0Pl6tHg4UbyKOb/QNdvpqk6p95EjhDncGlmW9y47WBM29+hqfq2VRMqkKI1
         JhXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLFB7OmRXcUUOT8E1C8sKxTGilf/bDlJifoQJKmJFC+S8LQuCNlaVGfoKKK3OeMCs8j29xMgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnO+dXaCeBqL/8iJd//RedqiQhO9OfrUK6oQAy7zat8Jenr32l
	RuDWnnL/PwmUay46cS8qyYuvXGD1lE884X2h0h8qz1ljLVMQL3KI0upb7a9DGE0q69wcR5xjD4B
	P3XEjAJn+0z9RXowPlqwK3kArDUjmOfg0EP6Z8L0aokQQ6RTvSh9NR7OpuQ==
X-Gm-Gg: ASbGncuuKHH5LQwboXj7cvyR3bWduIpIZJRkRfgo2up2OwiSH9ENBsLT2MarTTYRMO+
	cfApxehCZ4X7ydfo9mVn2RUJ4zE0ZOqNj1z5YSgcTECz18pkdfkbAQeOgUkRJUtDxx3uA0r5qIC
	9w743135d/eF5BGjnYErDm55cfWsCUl6/nf6z/2ac2qbXhlstu9AmUb48xJ8Bv3Dd+f7c8+m+Hv
	cWkvk1x1fKk7PK24xes3AIUEJuh+tBmI3xhNmJnF4L5+nyo6L0QRrWbRE4pIvqP8KQqAKhz2fxz
	325eZw==
X-Received: by 2002:a05:600c:620a:b0:450:d37c:9fc8 with SMTP id 5b1f17b1804b1-4511ecc3cecmr34788945e9.13.1748774954538;
        Sun, 01 Jun 2025 03:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs/RMZHHq7bLSa1yD1M5+XQCeStRNeaN+YhhV20HUyM/fKkQFejJBYYJGV/3MZkgRfuJE0bA==
X-Received: by 2002:a05:600c:620a:b0:450:d37c:9fc8 with SMTP id 5b1f17b1804b1-4511ecc3cecmr34788845e9.13.1748774954061;
        Sun, 01 Jun 2025 03:49:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc24d7sm82044335e9.36.2025.06.01.03.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 03:49:13 -0700 (PDT)
Date: Sun, 1 Jun 2025 06:49:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 3/3] vhost: Add new UAPI to select kthread
 mode and KConfig to enable this IOCTL
Message-ID: <20250601064429-mutt-send-email-mst@kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531095800.160043-4-lulu@redhat.com>

On Sat, May 31, 2025 at 05:57:28PM +0800, Cindy Lu wrote:
> This patch introduces a new UAPI that allows the vhost device to select
> in kthread mode. Userspace applications can utilize IOCTL
> VHOST_FORK_FROM_OWNER to select between task and kthread modes, which
> must be invoked before IOCTL VHOST_SET_OWNER, as the worker will be
> created during that call.
> 
> The VHOST_NEW_WORKER requires the inherit_owner setting to be true, and
> a check has been added to ensure proper configuration.
> 
> Additionally, a new KConfig option, CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL,
> is introduced to control the availability of the IOCTL
> VHOST_FORK_FROM_OWNER. When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set
> to n, the IOCTL is disabled, and any attempt to use it will result in a
> failure.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I propose renaming
CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
to
CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
and it should also control the presence of the module parameter
and a get ioctl (more on which below).

Otherwise we can get a situation where task mode is disabled and
there is no way for userspace to override or check.



> ---
>  drivers/vhost/Kconfig      | 13 +++++++++++++
>  drivers/vhost/vhost.c      | 30 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vhost.h | 16 ++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..300e474b60fd 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -96,3 +96,16 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  If unsure, say "N".
>  
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +	default n
> +	help
> +	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, allowing
> +	  userspace applications to modify the thread mode for vhost devices.
> +
> +	  By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> +	  which disables the IOCTL. When enabled (y), the IOCTL allows
> +	  users to set the mode as needed.
> +
> +	  If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2d2909be1bb2..cfa60dc438f9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1022,6 +1022,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
>  	switch (ioctl) {
>  	/* dev worker ioctls */
>  	case VHOST_NEW_WORKER:
> +		/*
> +		 * vhost_tasks will account for worker threads under the parent's
> +		 * NPROC value but kthreads do not. To avoid userspace overflowing
> +		 * the system with worker threads inherit_owner must be true.
> +		 */
> +		if (!dev->inherit_owner)
> +			return -EFAULT;
>  		ret = vhost_new_worker(dev, &state);
>  		if (!ret && copy_to_user(argp, &state, sizeof(state)))
>  			ret = -EFAULT;
> @@ -1138,7 +1145,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>  	int i;
>  
>  	vhost_dev_cleanup(dev);
> -
> +	dev->inherit_owner = inherit_owner_default;
>  	dev->umem = umem;
>  	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
>  	 * VQs aren't running.
> @@ -2292,6 +2299,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		goto done;
>  	}
>  
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> +	if (ioctl == VHOST_FORK_FROM_OWNER) {
> +		u8 inherit_owner;
> +		/*inherit_owner can only be modified before owner is set*/
> +		if (vhost_dev_has_owner(d)) {
> +			r = -EBUSY;
> +			goto done;
> +		}
> +		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> +			r = -EFAULT;
> +			goto done;
> +		}
> +		if (inherit_owner > 1) {
> +			r = -EINVAL;
> +			goto done;
> +		}
> +		d->inherit_owner = (bool)inherit_owner;
> +		r = 0;
> +		goto done;
> +	}
> +#endif
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index d4b3e2ae1314..d2692c7ef450 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,20 @@
>   */
>  #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>  					      struct vhost_vring_state)
> +
> +/**
> + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
> + * This ioctl must called before VHOST_SET_OWNER.
> + *
> + * @param inherit_owner: An 8-bit value that determines the vhost thread mode
> + *
> + * When inherit_owner is set to 1(default value):
> + *   - Vhost will create tasks similar to processes forked from the owner,
> + *     inheriting all of the owner's attributes.
> + *
> + * When inherit_owner is set to 0:
> + *   - Vhost will create tasks as kernel thread.
> + */
> +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)



Given default now depends on the module parameter, we should
have both GET and SET ioctls. All controlled by the kconfig knob.

> +
>  #endif
> -- 
> 2.45.0



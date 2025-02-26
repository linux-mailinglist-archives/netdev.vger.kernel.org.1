Return-Path: <netdev+bounces-169756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31FDA45960
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F4E188DCF1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F6E19DF66;
	Wed, 26 Feb 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXYrtyjY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76A258CED
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560719; cv=none; b=Uiyl1qlDxSR0uDrx0Dup9CwGbyp7970iNjhX4JtJpueTxF7NGOWlwlqgKs2rDL8zErzxOtnzn+t4Cv7jSRYW2Y/r9EJUkeopoazXRuLKGjFp4NYWzALN5A9XghyTCkBeztFWny5suhwZPjz2kMkRSc91dhIs/3hF8EtFhykguGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560719; c=relaxed/simple;
	bh=70Bz6bXCIZd7CqL1a4wfBpVEIhFZTwDuQ4RJXOiwz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yomc9/smlThCJHlP5wYrl0Aoio1q0FI/DUrijgDA/MxXd0uKp6kVe7RBoWsPd/5br5vZLc9J9TRpd/yS9ir3sxiihqiQeSs2tjfG5s36dONpn89PtynAoD6OWMwMf7mK36/qz+rGuy5c/jFHHBk2nUFUruPCKuzFdnY8Q7oBGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXYrtyjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740560716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
	b=SXYrtyjYLDyOzq5h1OxEf+rUCZ1vgPQLa8m8SxRwjYej6ZnloWiAXavyPvC61CsD6owxh5
	rMjHigFAe8p7DpzDLLzM8aoMNJuPEytjFFzaju2+WY3k69OTG4Pk0xapzBcV/UzZy6s78L
	lpydDRtBMq9PKVy82nf9fXfKfm4RWoI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Dunrt-wAMrOT_C_G2qhhtg-1; Wed, 26 Feb 2025 04:05:14 -0500
X-MC-Unique: Dunrt-wAMrOT_C_G2qhhtg-1
X-Mimecast-MFC-AGG-ID: Dunrt-wAMrOT_C_G2qhhtg_1740560714
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e073b9cf96so5408619a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560713; x=1741165513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
        b=UQGcYJdaFY/dBgwh/KnJBVLgxNYcgf2B4zB8j5Ilm45LrTrZpT5u7QZAe8u9gF+n1G
         HioB619S7agnLwoOeq6awUbQcXMXhUrzAj/7h5YxlbNBofLQSOrk39Flw87lqvV+rfGv
         hZpcG1YXcMkKf+UHqIQwd1hUCwqPZne2JtTsJ9X3xRC8C5r4mw7EmIF1Y2meWuDbYzGD
         GjmvFfND/hQrdvFVcw6IyDdxpGa0Gv61f/RGwtXS17u6DofrAHs3BEE8KYuCMlDCnrdr
         WMYzPlCVwDUIXDpZ8qizaB4ODfz4xaXQE7shCDbO8yPANTgZHVdZE30a+NXf18KK/sQg
         bmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj8vVr2kkZfCEK1VumohTHS9gYG7VtDLMCorSrOEQFutbexDbqCOB+/k4MwQr365xDpr8r0qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiMf7AzutpnS9Pacz5DRRtW1IyGnqw2ghfc8X+FpRyjQnKwOyi
	1NZGe/Q4p9WPxUKxsbo8EL+i27iMSw3g0p/aY3Y512hHQMnck3vR7QJR010ESW1QS6jQS/nongw
	+5Xd/2gfwI1Vc1zvk5Ab8g7WoKldNug7xiIClCum1+FACdxb29DrXEQ==
X-Gm-Gg: ASbGncsJC1DPkcAv4tHJxrrtKcIkIpKlO6QK4NAK0z8/5935UF+KrOs9sV8g1GLDNOW
	cynlHHoqEUtSq5OflupT2mUlOMn5rH7uc3anekG5oXiFchGAkaJvoVtKs2zVqN7x1k9DrWsJ2xo
	j5T4/T+xbwxGvt2Fn8Kq1AHfqMaITp2E3TZ5zWuh1h+vF/5Q9p+e8k2ftzez2IyHE6tP12rAPwp
	Zg/3E1JAEGA9wOeykKvihRE287s4D/zqmrMvCR4ApeWbTQbiFRZ4Xsovy4rXVGg7m7gBr3HEiat
	SUtM1eIGUSAG6MXV/kU=
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974877a12.7.1740560713419;
        Wed, 26 Feb 2025 01:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE494TvftaZSM3XnKjm3rhP+LMRh6Vk2MpaWmBgbVXsiLnzb3YS6LBhcMLOzYGoliBdZ979FA==
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974810a12.7.1740560712818;
        Wed, 26 Feb 2025 01:05:12 -0800 (PST)
Received: from sgarzare-redhat ([5.179.186.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b80b94fsm2569435a12.42.2025.02.26.01.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:05:11 -0800 (PST)
Date: Wed, 26 Feb 2025 10:05:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <77uzlntuxfzcj4qxggac23g73hslbkstygunqus33hzwrmotzq@f2t22l52xqdo>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 40 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index d8c0ea118bb1..45d8f5c5bca9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	u8 inherit_owner;
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+
>+		d->inherit_owner = (bool)inherit_owner;
>
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..8f558b433536 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.

Should we document that this (inherit_owner = 1) is the default, so if 
the user doesn't call VHOST_FORK_FROM_OWNER, this mode will be 
automatically selected?

Thanks,
Stefano

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>



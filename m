Return-Path: <netdev+bounces-194524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C9AC9E66
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAD23AA828
	for <lists+netdev@lfdr.de>; Sun,  1 Jun 2025 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D31AF0BF;
	Sun,  1 Jun 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYQTEDiS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E19EEBD
	for <netdev@vger.kernel.org>; Sun,  1 Jun 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748775102; cv=none; b=bcDYLtEEvwym0pUiR6KJ/ZYxgiRgxag5VtzbM3pY7cdb/+52HZayMXQUDEgYpWkaRwYA5L0mK8yR3BnI/F6i9/ZKH8U9oq6PVrG2a9AiOhGFUmikIJQIbiCbTaOe+yynNU1dMJMZTER4e7pzQgY2tAw4njvfkRJ3IJpGvh05TQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748775102; c=relaxed/simple;
	bh=Kg3D1Hds9FAI9RcBxGC9kYXWJb0C19mfROuvp6I68T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWHDs7ientbg83OHOMDRnB/onmm3nvcLWwQ16+Ifr7Q34Mkuk+mjnROyMMICI1o8npXf3TuwhCR+akDjic4goRvQg6zQODRCR0CB6QgSYTmqQ0Ae+9IIw0ss1HB7LrFNaAWFac6l9kuxQ5ve0oeVQKyAl2nZbJyw2J7BCSD7N4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYQTEDiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748775098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+LDkkF3bl9XFii8SeXhYSZYWFK7xdUoFXE21Deot6Q=;
	b=DYQTEDiSdyQbMJiPkdjD9rj8JmJt/YRpQJmcc1yatWWq/oh9omV/vKjfD+1ZPEPj1VtD0M
	s2UcMULpqIUUAEmjbtUhvilfLGkQE8ysn9QHYx6ANFYa1z5NSFQx3k9Au8Ht9EwkWiGTVO
	i+Fu57fjDppfyHwonXHoPNY4ZSMWwNM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ygX12KLpOcicd_4_tYZyCw-1; Sun, 01 Jun 2025 06:51:37 -0400
X-MC-Unique: ygX12KLpOcicd_4_tYZyCw-1
X-Mimecast-MFC-AGG-ID: ygX12KLpOcicd_4_tYZyCw_1748775096
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so20658555e9.1
        for <netdev@vger.kernel.org>; Sun, 01 Jun 2025 03:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748775096; x=1749379896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+LDkkF3bl9XFii8SeXhYSZYWFK7xdUoFXE21Deot6Q=;
        b=k94oEKJW1OESE6gUx4wvAStu1LBqt4ff4ecG3B+ZkJjwmHwRRXAg1mirAH681Kq3QO
         yxhqk9hitLgf6Vujp4sqLvSFnW+o2w9SGjpD7VR5fWrAjZrmi889RczizSlU0c5ENBdq
         jMm03mJ2sTmoPui48XS3U52kWo4Y+ohdrJNQt4kNeE4zC3qHQfVSVzRShBF2lLGXRgkk
         uecXsCCSj9RnPNXY+nTKO+vJgWe4lE1Q48Ze1fl8mxpXmNMs9sttOLqKdwS2D9STRnaC
         q3DJJ15JBt0qds+hl+ZoZV9ZWKyIcYzvYdEnEQZf2Np02j0rs+cSOpxVQ3ERiDdffQKe
         QqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6aNGAvRPXD+Bi1g4l6/83fgy0PBw1Oe+6MiVwMXL/7AATu+9z0WHk0eWpFxL6dsdfXNfNPFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJJ6fR0Gupxc//4PD074jVf6+tELsOLlPGvKwH9H1LY5P0QaM
	XFirX9cefnoCfpxofPmKqYre8+2KpD7YwVdX4sEsIYznMJzgB9AspBOd8jTBz645DTE1yrVq6wP
	KeuWJ89BcOZ2022x/7xi4+s2QHTeQhheCrenYtEmwv/3IqFC/gZMAs3ZnOA==
X-Gm-Gg: ASbGncvchxeOT6UFzmJTEBS/vEjr+24CJ+1RFL5Q287oHqkfMiaApjtMrtsBJmNFB+P
	DdusExQiWnTOsLjzlf76Cl8vVI0p3wZbMQXtyCjfqKWl6o/1g/BggfuNLLwcqEpmEAHjnMphu8g
	+7byeRGQfPg2DXXjWxzNhzFTS3KdAOf26nXsuc6IZko+6aV3J7jkZaO2+yUHnBZxWmx5m0AZDuW
	O9PquW6vuB8mHiSJhzvg9zqxITrFd43NSitBoi8iuYSIDGy2f1ZV/OJRjI7x3da+gf8vnQs7FgI
	pmkTFg==
X-Received: by 2002:a05:600c:6747:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-450d8876bd5mr68720225e9.29.1748775095928;
        Sun, 01 Jun 2025 03:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyVvW8vOUJekNf9fJWEFV8OBsS9sxAfCFyfMFebeG/spr6/CyNivjswpG1bzmxkbm+qlN2ZA==
X-Received: by 2002:a05:600c:6747:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-450d8876bd5mr68720075e9.29.1748775095516;
        Sun, 01 Jun 2025 03:51:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8012af3sm80427155e9.35.2025.06.01.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 03:51:34 -0700 (PDT)
Date: Sun, 1 Jun 2025 06:51:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND v10 1/3] vhost: Add a new modparam to allow
 userspace select kthread
Message-ID: <20250601064917-mutt-send-email-mst@kernel.org>
References: <20250531095800.160043-1-lulu@redhat.com>
 <20250531095800.160043-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531095800.160043-2-lulu@redhat.com>

On Sat, May 31, 2025 at 05:57:26PM +0800, Cindy Lu wrote:
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
> 
> Add a new module parameter to allow userspace to select behavior
> between using kthread and task.
> 
> By default, this parameter is set to true (task mode). This means the
> default behavior remains unchanged by this patch.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

So modparam is here but does nothing.
This should be the last patch in the series, or squashed with 3/3.

why is this inherit_owner but ioctl is fork_owner? is there
a difference? If not
can't the name be consistent with the ioctl?  vhost_fork_owner?


> ---
>  drivers/vhost/vhost.c |  5 +++++
>  drivers/vhost/vhost.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..240ba78b1e3f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>  	"Maximum number of iotlb entries. (default: 2048)");
> +bool inherit_owner_default = true;
> +module_param(inherit_owner_default, bool, 0444);
> +MODULE_PARM_DESC(inherit_owner_default,
> +		 "Set task mode as the default(default: Y)");
>  
>  enum {
>  	VHOST_MEMORY_F_LOG = 0x1,
> @@ -552,6 +556,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->byte_weight = byte_weight;
>  	dev->use_worker = use_worker;
>  	dev->msg_handler = msg_handler;
> +	dev->inherit_owner = inherit_owner_default;
>  	init_waitqueue_head(&dev->wait);
>  	INIT_LIST_HEAD(&dev->read_list);
>  	INIT_LIST_HEAD(&dev->pending_list);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..c1ff4a92b925 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -176,6 +176,16 @@ struct vhost_dev {
>  	int byte_weight;
>  	struct xarray worker_xa;
>  	bool use_worker;
> +	/*
> +	 * If inherit_owner is true we use vhost_tasks to create
> +	 * the worker so all settings/limits like cgroups, NPROC,
> +	 * scheduler, etc are inherited from the owner. If false,
> +	 * we use kthreads and only attach to the same cgroups
> +	 * as the owner for compat with older kernels.
> +	 * here we use true as default value.
> +	 * The default value is set by modparam inherit_owner_default
> +	 */
> +	bool inherit_owner;
>  	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  			   struct vhost_iotlb_msg *msg);
>  };
> -- 
> 2.45.0



Return-Path: <netdev+bounces-239856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD198C6D302
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD226359204
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B42D24A9;
	Wed, 19 Nov 2025 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxhMlCTb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvPlL/PS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77629E0F6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537933; cv=none; b=UoksxV+MSQxI6rn9+1tehqDJ7fg50NpPrZjjrPWezlmjyPBiHZRb7OMpISqBc55DrBVenZ6T4B6ZY6nLzkCO3mOAxsihjmosPkFkEyMDZBSLuJY/80LEFN/IAvTVqswavSvxb1kzsnOSgz1B5yEonYC2uqwXI9CZOKMxQO2nN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537933; c=relaxed/simple;
	bh=zmNqkoSltZ5GgXLj7EvC+Y7auPwKrmrMj6qaKvvDaGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcZGvOj0TT+0vItjvO4+nKRldHiJMw/BUDI0OY3v8OJmfJ57i+0rdZVMgn5xvI+sK+FmOVwOMae0AbAumk/QzZsoC/ejOZn0s5SLKqy0cmr1STdMtdCt5yheZaSCMtyzKc+uE44p13+6Zg7EHNcvKttO1YbYvg4SJ8Je0/8Q1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxhMlCTb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvPlL/PS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eden/oMzm33N9T6c3JgYfx1SV0QunnDnTTMkdMfqk7c=;
	b=GxhMlCTbtrIUBhfQdNKOcSBa5hn20SJFCsI0ym8F4Sz4CV/pMCHW65uBqIuK4iMucsJOqT
	HpAxj2i3FJS2PIDWlL8/mxIQdfHXH8I2lldRcSpzYAE6d6bYZCu0/QdRkl2u8bIimBndMh
	gr5DppfoJkdFbsRm9YHSTeSWBlCPsos=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-dWrKpVT7NqeWXuVwQrvqIw-1; Wed, 19 Nov 2025 02:38:49 -0500
X-MC-Unique: dWrKpVT7NqeWXuVwQrvqIw-1
X-Mimecast-MFC-AGG-ID: dWrKpVT7NqeWXuVwQrvqIw_1763537929
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so4262215e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763537928; x=1764142728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eden/oMzm33N9T6c3JgYfx1SV0QunnDnTTMkdMfqk7c=;
        b=PvPlL/PSWN3nyTC+qBubR30d3yJGGlNDNcmpUSIps4EEZG8jJLTZTnHBBm4Cy/xMEo
         Edu3VT3PnR+KlT3sp1mXu+z/9m9J8nKZPoKdjOl9nUyohGhHPbH1yvyQeY35ntG2tQhF
         IzMDlm3+jC7hytjGzy+OTELvog8Ood6W0gzwHz/+8qHdvWfmma5RX3QkNC12HMyGM0gr
         kDgChd0PA9qUNbjI1vqslKa+N0KLXXHFPes7NXBRtQ8ZW259wAuYRnjExTGcFIzBjz/6
         H27EpOv69PfMrbC7bQw5ytom9Dal1URwFYmAfs+VfPxefPNhmy4VxntKxPfLODy+Pu79
         AoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537928; x=1764142728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eden/oMzm33N9T6c3JgYfx1SV0QunnDnTTMkdMfqk7c=;
        b=HTmWqOv4/JqMXZKXsLp33n318yWSpGrZnPs3fzgdWPQS/Rnpt2gYQd3pYuNqmnMG5/
         QGVndKvl6kKHgxvB5v/ArcIstXXNl3u/yrWmW5OSNZsDsRsuRaFtqEEseEk9euUh8wsi
         7DL5MZIBki9Zqxom303cbPENEcvjxKTWGv2Ixp1Tky0x4vFYf4+jCQGTOe0nqLasqLfs
         gBPVmXIyMrELyGSEtbYtIIrsH2EX3PHFQnLQn8NTdHkQivntx6ICig/14muF0uN4AWmi
         zXyE/sAwJClbhHkCks1FLRuGeuCQ+xEgPTqrFrLLujajZ0q0jaz5nyrry2gzDtccVRa0
         yepA==
X-Gm-Message-State: AOJu0Yxr13G+gcu+NxgePGrAJKlBs9RZAigkzyatJgxuDsQgub76Nl4e
	YfLCKjm6VW0oOxnhsaA1mRN3e4VGW5SUOc5dyE7uFoKW9ILsGH7ulkM5VwKEKBWy9GFRlDkO0Kj
	lVU82y7XnY9tIyed9i7PaVkfF5u8kS7XCJJrbT8tNl/wFyo3fZ4OPHobLEg==
X-Gm-Gg: ASbGncsw5AuvR1gRgIF+T6THVFaUX9leIMtK3QhYduz30LT/cA5apN5Hwd7r8ZZpaQm
	GxwxiylbO4Sfi1qnoqwOHkj7dse+Uu5Qjrfcg+Uaa+EIKhA3Bq7EdG3r3iWRCYPU9DgyP22MToF
	Pr3fdINaAJGcY0ryJ6lcJnIMOLBSf/2ai+m6/ZGc/EuNRm9Y/BYR0rQ7sjkoQ3Qi740j6pWyswL
	iJpkaOwsi3cp6yKAJg7FnbynklWW3VePYaXB677prp5YyDQ4agBg5+/BWwIYBIxl+ZxUHGKkrIa
	wh2D78+ccGK48hipXjlmWhyZZANjiihkdJtbVWpWtgW41lrOVHwQJKXuUWMTmZ4ptf0yEsgT7vk
	rkeIYAUFR8Fm3FMEbASjBzhwBj1VUgQ==
X-Received: by 2002:a05:600c:3b29:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-477b18bfcf8mr13614925e9.5.1763537928449;
        Tue, 18 Nov 2025 23:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBaprik/Sp1uYavYsVh1sL/U72VYWrQLNUZqdCZ0jFk34W6YL7U0vj3IwUMUFpjme+YxSRHg==
X-Received: by 2002:a05:600c:3b29:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-477b18bfcf8mr13614705e9.5.1763537928057;
        Tue, 18 Nov 2025 23:38:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9ddef38sm34907765e9.3.2025.11.18.23.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:38:47 -0800 (PST)
Date: Wed, 19 Nov 2025 02:38:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 01/12] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <20251119023725-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-2-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:51AM -0600, Daniel Jurgens wrote:
> The cap ID list can be more than 64 bits. Remove the build assert. Also
> remove caching of the supported caps, it wasn't used.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> ---
> v4: New patch for V4
> v5:
>    - support_caps -> supported_caps (Alok Tiwari)
>    - removed unused variable (test robot)
> ---
>  drivers/virtio/virtio_pci_common.h | 1 -
>  drivers/virtio/virtio_pci_modern.c | 8 +-------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 8cd01de27baf..fc26e035e7a6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
>  	/* Protects virtqueue access. */
>  	spinlock_t lock;
>  	u64 supported_cmds;
> -	u64 supported_caps;
>  	u8 max_dev_parts_objects;
>  	struct ida dev_parts_ida;
>  	/* Name of the admin queue: avq.$vq_index. */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index dd0e65f71d41..ff11de5b3d69 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
>  
>  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  {
> -	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
>  	struct virtio_admin_cmd_query_cap_id_result *data;
>  	struct virtio_admin_cmd cmd = {};
>  	struct scatterlist result_sg;
> @@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
>  	if (ret)
>  		goto end;
>  
> -	/* Max number of caps fits into a single u64 */
> -	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
> -
> -	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
> -
> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
> +	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
>  		goto end;

It's ok but a better way is

data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)

giving the compiler a chance to do the byte swap at compile time
on BE.



>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
> -- 
> 2.50.1



Return-Path: <netdev+bounces-225799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCBB985E2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721EF3BFFF4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5876158DAC;
	Wed, 24 Sep 2025 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG7tDhRP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B01114
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694594; cv=none; b=at0LGAjzM9jsN+iGyZJrofO8wYQqkEK3+5njSjMIueck8/RUuPhuVawCsDXoMS0IrfJ7G6hFfzq+pEGAE2F8ztnNWs27zOjGt0ZJZ2xQFP6s8IkZxbabLjEa4g9S4LkpgYNCED/rZfFn9Duhul6ks+6TR1/FlJ2s1/XUK4YRZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694594; c=relaxed/simple;
	bh=wYoHhlyTQLrXzZnfKqE5TTY7hdPbb+343tQnEnwumRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohCO8t+0AYh67ThgMY9497txhWSdRP0ci/h4EkQi+rM1Q25Z2qsaqQCKmDzlVj9E9spwzXodbiu4mM/mttGWeiE28N+33xgTgcTp7NYGceCL2pR1PUuPUCBbgT6HquCDnQxO+O4/5pUVvO/7TIuF+CPm2Aq8VzT9b2+54s3H4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG7tDhRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758694592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYqDEElUq6PE/aUwO89wI+I285Xe17iMxShOwBkPxgY=;
	b=WG7tDhRP7cEKTgXdGzOoB/VjEFwGQD58x33UD1dfywW+MkqkGxW5YA5iX7taZY77MKlFSm
	gedz6HVhQX/bLyElPY7STD6D8wbgSdiOTg2ylfRt+yOqOfuHybKH616vRaqF56QV4j4sD6
	a+WyFYaVvDWpwZlgNXxlIVC7peMI+Kg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440--aXcWpNVN5mc3ijRR_vDjQ-1; Wed, 24 Sep 2025 02:16:30 -0400
X-MC-Unique: -aXcWpNVN5mc3ijRR_vDjQ-1
X-Mimecast-MFC-AGG-ID: -aXcWpNVN5mc3ijRR_vDjQ_1758694589
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so2676892f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 23:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694589; x=1759299389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYqDEElUq6PE/aUwO89wI+I285Xe17iMxShOwBkPxgY=;
        b=I4/LbayHcWRwObAPOxpXIhtgkvoufieq0JJffEoU2nGVvWBMEakJLJ7k1Cl5pY4ehU
         kEBtfO8euTYdNfLGGnznSbOod/GSQWPKp+702oyHw72tLmlKrh/gWmHz4ld+syBeDFkm
         WfIDoc4EYL41/HM5aNiRt83PDTYgIS/RateHr7c021y3QXyrVnmQm5q0vZ8J5n3q1FMa
         xeaWJZd1eyYYl7kI+np16FKcdXbhz8+f7QsgpbakZOYyTwjMcfjuL49k+e0GV0d53nH6
         JN2x+Wxp2BAYxA0myODtG/mENwQuDtf8jvtg10fG7ttygZ1aTHpJ89xifxfiZ18eBJEs
         ZJug==
X-Gm-Message-State: AOJu0YzwaKVlrK4B7eNSDr8z0q0s5QM5oX/s0L2QgqREqxtkOW0qD/Hg
	KQ2Lq1zArQIlkbuSIF7iMz/WWMUPWDJjMo0H3daCQqjKLghK3LGWUAHbyZRNaKKOT4RF8xN9b3j
	orjZUcjK+Gyysvu0n+lT9aiDTIBYTeJ0m14VHPmNSKKnty/gqj3lNehewiw==
X-Gm-Gg: ASbGnctdmg48NnfPO8Cvdk3bZWwt46wQcNoZW7qWvTCRtHH30SGkNakAyJJzKKcna+c
	4JdWCWJmyKGUgl53UWoypN1rx1cXoMQkjoq28i+J+ZOhyLagHzMw5mJ2XDxUTyPcVoZUos3m3g6
	eVQRHh6sKe+QHF/xlFXZi6rDHJGxSoXDeg7SKa+IVOTHyWWxVdAbWMOGrduC+//qHzJ8ZrVltNX
	gHdeM/8Qhr0/JL+0k+TNiRGzn73p02EyG9/Ba4xp9WC66T3GA2TKx2N/jH4yoBy2A+7P0XLzZ7X
	FItMahfN7rwJVO+FYodaLZ4rIUNb71kuEj0=
X-Received: by 2002:a05:6000:4205:b0:3ec:1b42:1f90 with SMTP id ffacd0b85a97d-405cb9a58b5mr4240166f8f.60.1758694589118;
        Tue, 23 Sep 2025 23:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFawYpDl5FDdbDTaRogi0vy2KU6XJAI+3T8autcDErz2jQEJ88pc53RcQP8+2rm9oLn7/8iCQ==
X-Received: by 2002:a05:6000:4205:b0:3ec:1b42:1f90 with SMTP id ffacd0b85a97d-405cb9a58b5mr4240140f8f.60.1758694588591;
        Tue, 23 Sep 2025 23:16:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm26600355f8f.21.2025.09.23.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:16:27 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:16:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250924021444-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-2-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:10AM -0500, Daniel Jurgens wrote:
> Currently querying and setting capabilities is restricted to a single
> capability and contained within the virtio PCI driver. However, each
> device type has generic and device specific capabilities, that may be
> queried and set. In subsequent patches virtio_net will query and set
> flow filter capabilities.
> 
> Move the admin related definitions to a new header file. It needs to be
> abstracted away from the PCI specifics to be used by upper layer
> drivers.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>


...


> +/**
> + * struct virtio_admin_ops - Operations for virtio admin functionality
> + *
> + * This structure contains function pointers for performing administrative
> + * operations on virtio devices. All data and caps pointers must be allocated
> + * on the heap by the caller.
> + */
> +struct virtio_admin_ops {
> +	/**
> +	 * @cap_id_list_query: Query the list of supported capability IDs
> +	 * @vdev: The virtio device to query
> +	 * @data: Pointer to result structure (must be heap allocated)
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_id_list_query)(struct virtio_device *vdev,
> +				 struct virtio_admin_cmd_query_cap_id_result *data);
> +	/**
> +	 * @cap_get: Get capability data for a specific capability ID
> +	 * @vdev: The virtio device
> +	 * @id: Capability ID to retrieve
> +	 * @caps: Pointer to capability data structure (must be heap allocated)
> +	 * @cap_size: Size of the capability data structure
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_get)(struct virtio_device *vdev,
> +		       u16 id,
> +		       void *caps,
> +		       size_t cap_size);
> +	/**
> +	 * @cap_set: Set capability data for a specific capability ID
> +	 * @vdev: The virtio device
> +	 * @id: Capability ID to set
> +	 * @caps: Pointer to capability data structure (must be heap allocated)
> +	 * @cap_size: Size of the capability data structure
> +	 * Return: 0 on success, negative error code on failure
> +	 */
> +	int (*cap_set)(struct virtio_device *vdev,
> +		       u16 id,
> +		       const void *caps,
> +		       size_t cap_size);
> +};
> +


I do not get why do we need this indirection. There is a single
implementation in the spec for now, and your patchset does not introduce
a new one.


-- 
MST



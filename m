Return-Path: <netdev+bounces-226526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FBBA1783
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0045216BF3A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6C275AE2;
	Thu, 25 Sep 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiywI9EG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D89233707
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834808; cv=none; b=CS7rzzDiYuFzUu1eFycNOsOCRhhjHVhK0kn+4Xdd883Ya9FiRdjAANSH+N6UbuhkI9rjCKQqZrdiB00c98FWLu1of0fDNvZwukVD1omJE3EhodF0suGh8M3Y0WQkFRLrlFuzGoDSM1XZna5lLsDP6jAqz3VtmwCjPWZXrIO8fBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834808; c=relaxed/simple;
	bh=67sXkd/kZkyYEB3zDBgSHObSu79lmesE6k8OCRZWSZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Z8OTV73yLFoL88M/Nl2x4Bvq7eKMs3nb5Yza1ZSUFpmcagvwCrZu4QO6rit/ClVrWW7p1p0ZZ2nm9mnFj+SxgUHt6gh1VjvJ4FTU+YC8qvuyXN1SVQ3fD1Yj/0A7K33XGcNuFdOVT8ZxCmJD+Q9/us+SNSIOEYBWj4L9TNltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiywI9EG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758834806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig3nBeCUwloN4LvzwfZMbkgJCfvy/bic/b84bOETkhM=;
	b=PiywI9EGUm60HlNTtUQn2K/TKTrmw/pCi0R8q1IgsKgijyM5pAbc2HLAbCXqO+oVziWOrh
	breGaov+fH27GhzX9OJQUo/7GSnUyJa1XT5q0xQtEjIr73vHvgr8CAfVw5OVgn8JXqrg1y
	pirjYscMc6/7Xp2wA7xSoiuoocyxZfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-6Um_cmUsOyu6dYnR_0uWXA-1; Thu, 25 Sep 2025 17:13:24 -0400
X-MC-Unique: 6Um_cmUsOyu6dYnR_0uWXA-1
X-Mimecast-MFC-AGG-ID: 6Um_cmUsOyu6dYnR_0uWXA_1758834803
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso8849615e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834803; x=1759439603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig3nBeCUwloN4LvzwfZMbkgJCfvy/bic/b84bOETkhM=;
        b=LzV/C+PqiC3OKUEQpyeE8+qmU/+GmFOVFmt2rRxES0thN0TdvaWZ+/UIFdogZGetVI
         9yNenz63/zizn7nWiF2k2j0kBtImXDf+9uttrGYnsUKlByGbsBPsqWmO3mya3IfRt8lh
         W2lg38joHMQmxNi+Qx6iGYApP7z8xAKNoftc/Awitr3ehCLspdVUQN1WoE+afOsq7dNg
         KyFDy2zuBmhS1jm57X35hQOaVuNriFP4S4WVbr7t8XoSLrTadFrjN5vZuK9AITOFpmun
         dAI+cHbj02fm97X8ue2f1ydIm7RAlFtizmUe7ab/1qOXT+ADpX+BaRekZ9YMPpw0YwG+
         xhHg==
X-Gm-Message-State: AOJu0Yx621HNHaFdGOgTye9qBnJ9DSmdA0Mxh7ygvr0VMX1mqNmfdsM2
	FFmSXcy3SLSx8feOOIuQkJ2ZoxSoohUudmCcmQ9AzhxDNz179aAK/SpKoYqltOieeGXsq0XVX4G
	JeBH9xM+o4WTQegtL9CQCout0INRx3b9x5MJ4L5JSQMVpXkiSTXzBWUQrlw==
X-Gm-Gg: ASbGncvI/FLVKlmPnza3CWdOPbWbT2jybcINltoZXrL13a5PfrRJa8rnj/C4cbnQEnT
	H9vjsLO1ZZDbVECEMmFxi0LRklv98NZYuoQPaOiSX5ovYjsgSwTb+u6kcSQvauY5Y21kFLyExVn
	a3oSV1H0iea/kkm6Q3QjbVQIuqwjr1EpiMiyq0a5D53veI87aQfCLMtaza5MnRIi0cM1faH7Kjd
	MBz2ALZSAzJWPa8KWaBajZ7riro/8FgBHRr2TlD4K7/7oFivPyY+yP7X2bgwDI95EqwnOc6miNr
	EzUw5swJiafNwIiaQH7atxhSsMFQdBStDQ==
X-Received: by 2002:a05:600c:1d01:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e32a0bda9mr62544385e9.31.1758834803286;
        Thu, 25 Sep 2025 14:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFHV5Q07RhN0juNlqporSm4E3ydRkAdaK/psjGehjTm2V7fiQhfIUNkC+PlQ7T9FIaIwtYHg==
X-Received: by 2002:a05:600c:1d01:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e32a0bda9mr62544155e9.31.1758834802798;
        Thu, 25 Sep 2025 14:13:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm4468039f8f.37.2025.09.25.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:13:22 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:13:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 05/11] virtio_net: Create a FF group for
 ethtool steering
Message-ID: <20250925171105-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923141920.283862-6-danielj@nvidia.com>

On Tue, Sep 23, 2025 at 09:19:14AM -0500, Daniel Jurgens wrote:
> All ethtool steering rules will go in one group, create it during
> initialization.


document uapi changes pls.

> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  drivers/net/virtio_net/virtio_net_ff.c | 25 +++++++++++++++++++++++++
>  include/uapi/linux/virtio_net_ff.h     |  7 +++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
> index 61cb45331c97..0036c2db9f77 100644
> --- a/drivers/net/virtio_net/virtio_net_ff.c
> +++ b/drivers/net/virtio_net/virtio_net_ff.c
> @@ -6,6 +6,9 @@
>  #include <net/ip.h>
>  #include "virtio_net_ff.h"
>  
> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> +#define VIRTNET_FF_MAX_GROUPS 1
> +
>  static size_t get_mask_size(u16 type)
>  {
>  	switch (type) {
> @@ -30,6 +33,7 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>  			      sizeof(struct virtio_net_ff_selector) *
>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>  	struct virtio_net_ff_selector *sel;
>  	int err;
>  	int i;
> @@ -92,6 +96,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
> +		err = -ENOSPC;
> +		goto err_ff_action;
> +	}
> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
> +
>  	err = virtio_device_cap_set(vdev,
>  				    VIRTIO_NET_FF_RESOURCE_CAP,
>  				    ff->ff_caps,
> @@ -121,6 +131,17 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>  	if (err)
>  		goto err_ff_action;
>  
> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
> +	/* Use priority for the object ID. */
> +	err = virtio_device_object_create(vdev,
> +					  VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +					  VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
> +					  &ethtool_group,
> +					  sizeof(ethtool_group));
> +	if (err)
> +		goto err_ff_action;
> +
>  	ff->vdev = vdev;
>  	ff->ff_supported = true;
>  
> @@ -139,6 +160,10 @@ void virtnet_ff_cleanup(struct virtnet_ff *ff)
>  	if (!ff->ff_supported)
>  		return;
>  
> +	virtio_device_object_destroy(ff->vdev,
> +				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
> +				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
> +
>  	kfree(ff->ff_actions);
>  	kfree(ff->ff_mask);
>  	kfree(ff->ff_caps);
> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
> index a35533bf8377..662693e1fefd 100644
> --- a/include/uapi/linux/virtio_net_ff.h
> +++ b/include/uapi/linux/virtio_net_ff.h
> @@ -12,6 +12,8 @@
>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>  
> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
> +
>  struct virtio_net_ff_cap_data {
>  	__le32 groups_limit;
>  	__le32 classifiers_limit;
> @@ -52,4 +54,9 @@ struct virtio_net_ff_actions {
>  	__u8 reserved[7];
>  	__u8 actions[];
>  };
> +
> +struct virtio_net_resource_obj_ff_group {
> +	__le16 group_priority;
> +};
> +
>  #endif
> -- 
> 2.45.0



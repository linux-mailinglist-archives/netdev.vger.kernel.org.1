Return-Path: <netdev+bounces-192389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E3ABFAE2
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDAF1C040D6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19D17BB0D;
	Wed, 21 May 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpXzt0z7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314401F8EFF
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843335; cv=none; b=NYa3ADYWBNwyiSnIjmyuO5h/cNLc3flKpfPKQRkdBKcyPc12P2eidgwEwq8o1hNhKJ56TTttBty121RxjR1hBgfGZrYcPgeJ+EBtm1HihTYxIxlqdWuVc7OZF8ZQcWtqBlLau7ZVGEoEDohlPxxouESQH/cvHBc1qZ2i9y2VqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843335; c=relaxed/simple;
	bh=mxHJn+tYCQWy2TGdW1zAJsijYDpahlwM02VTSFwt9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcoKy2SuEKFe4rdzmeR5J66qNZI5KJooQ4/zN1zY00tbJzU0VOR2RXqCrggGGINj11zVxyhkVkkIbA4T4VFFczAK7nT/AQzIqyyE4DVSlriYkncqb/Rgr4X117RBG5yXUoq8CzNSMzedT7oVRQ5vTl5v39RQbbvM5KQ6JPkrBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpXzt0z7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747843332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAque6hPpCN15KF4nCvki/jOFCGmNPYDWAkGwA1mYKk=;
	b=GpXzt0z7/eeFp62PftMumZMDv9SNnJ6vfnOBRYmnOjuIsAOs38wsvyNRx3mWk79dr/G7Gd
	1IcutK8WKGg70Zpgs4B+zIVNC/vG3QIHzpbwfYjGWrLUy1YZhxD8OMVUu3RA+yJv8C5C1P
	VtkCEqUmfZ0+Jd0ZbUc1rhhDvw2MGPE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-u9yl12XcOJax6CbqurG2ew-1; Wed, 21 May 2025 12:02:10 -0400
X-MC-Unique: u9yl12XcOJax6CbqurG2ew-1
X-Mimecast-MFC-AGG-ID: u9yl12XcOJax6CbqurG2ew_1747843329
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442cdf07ad9so40169715e9.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843329; x=1748448129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAque6hPpCN15KF4nCvki/jOFCGmNPYDWAkGwA1mYKk=;
        b=sbAs7fEfSGjppXOa7+IFCW1Zin1xLfLH9H0U2n/9jfLJeRR9RcFpvCIq5Y/sx1eo/3
         FV8xumqyqSAQgg+e99jgAC9Ojjip/Hnxk4B0GXNynHpKZ/9+nvFNBEguuXHwBAATnq4O
         1tQSXnN0WrlpiPDzuMkOMX7ldfQpvtxbizOrTLXKloSoB6fTCmNefbEOQWvz3bj552cn
         EinwPWZS+zWIeqqz0zI/surO97ieMYlQ/cy32NbkJWPH21bnyqwBg9y5SRYhgPGjOyC9
         HvMkU2focxYxQJdMrlzatm08vVFma6mt9j3xf+TZPIY+29DLCadimjDWmvDZWwyjf235
         Ao9w==
X-Gm-Message-State: AOJu0YzwbPXh0xeiGvQpYreoJW70PZ+hEU636EBLMtGbY14akz/ZV1aJ
	lyBjL+gdsUYzcsovLVMdWZE9Ks07yw9T51GJHJ1w2fVJPfv+VMJbUK++FX4IU6XNMVYSv5UKlJW
	pRlO1/YiHwRsMzxLgt/PRdh8O2tBKt5WIPvOWOB0TWInMKhWjpRY+TNUDpw==
X-Gm-Gg: ASbGncsWMkwPrx61mJrfgg6z9QC+P1tZgDBGJKGzACFWKg099ZL40whznCUIP7T7FFQ
	FsSbkcgMm+adVK/RFdy87g3WIdK+cBAML9QTfYT8nD1LiH57U3rZSxjdMZY+rDWuZoU/nyCQsGB
	9WLq1ljOYBFwgLJFt0CY0/lRan7tB3wlYY3v8vGAP59Ax566A41+luSrq8mgJhqTC71PbFECgMx
	MiolsC3Th2X8WAyfUQuyZdK/R43aGP3zoP4jw4SDn81ipuiCvaZ2Hab7wAN3KUEv0nwkImVxJ6z
	XW2U7g==
X-Received: by 2002:a05:600c:c8c:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-442fefd5f8dmr218642385e9.4.1747843328291;
        Wed, 21 May 2025 09:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUnUGVKBz5fV+UUXjQyBzhy6ZZfJZaKwtaZuhkG5D+QyvEyDsEls2y8hrKJdP6QdVYq+eBQ==
X-Received: by 2002:a05:600c:c8c:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-442fefd5f8dmr218641305e9.4.1747843327279;
        Wed, 21 May 2025 09:02:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd7fsm20432983f8f.38.2025.05.21.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:02:06 -0700 (PDT)
Date: Wed, 21 May 2025 12:02:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
Message-ID: <20250521115217-mutt-send-email-mst@kernel.org>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>

On Wed, May 21, 2025 at 12:32:35PM +0200, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio_net driver.
> 
> Introduce an specific type to represent the virtio features bitmask.
> On platform where 128 bits integer are available use such wide int
> for the features bitmask, otherwise maintain the current u64.
> 
> Updates all the relevant virtio API to use the new type.
> 
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  drivers/virtio/virtio.c                | 12 ++++++------
>  drivers/virtio/virtio_mmio.c           |  4 ++--
>  drivers/virtio/virtio_pci_legacy.c     |  2 +-
>  drivers/virtio/virtio_pci_modern.c     |  7 ++++---
>  drivers/virtio/virtio_pci_modern_dev.c | 13 ++++++-------
>  drivers/virtio/virtio_vdpa.c           |  2 +-
>  include/linux/virtio.h                 |  5 +++--
>  include/linux/virtio_config.h          | 22 +++++++++++-----------
>  include/linux/virtio_features.h        | 23 +++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      | 11 ++++++++---
>  10 files changed, 65 insertions(+), 36 deletions(-)
>  create mode 100644 include/linux/virtio_features.h
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b1..542735d3a12ba 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -272,9 +272,9 @@ static int virtio_dev_probe(struct device *_d)
>  	int err, i;
>  	struct virtio_device *dev = dev_to_virtio(_d);
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> -	u64 device_features;
> -	u64 driver_features;
> -	u64 driver_features_legacy;
> +	virtio_features_t device_features;
> +	virtio_features_t driver_features;
> +	virtio_features_t driver_features_legacy;
>  
>  	/* We have a driver! */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);


> @@ -286,8 +286,8 @@ static int virtio_dev_probe(struct device *_d)
>  	driver_features = 0;
>  	for (i = 0; i < drv->feature_table_size; i++) {
>  		unsigned int f = drv->feature_table[i];
> -		BUG_ON(f >= 64);
> -		driver_features |= (1ULL << f);
> +		BUG_ON(f >= VIRTIO_FEATURES_MAX);
> +		driver_features |= VIRTIO_BIT(f);
>  	}
>  
>  	/* Some drivers have a separate feature table for virtio v1.0 */
> @@ -320,7 +320,7 @@ static int virtio_dev_probe(struct device *_d)
>  		goto err;
>  
>  	if (drv->validate) {
> -		u64 features = dev->features;
> +		virtio_features_t features = dev->features;
>  
>  		err = drv->validate(dev);
>  		if (err)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 5d78c2d572abf..158c47ac67de7 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -106,10 +106,10 @@ struct virtio_mmio_vq_info {
>  
>  /* Configuration interface */
>  
> -static u64 vm_get_features(struct virtio_device *vdev)
> +static virtio_features_t vm_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> -	u64 features;
> +	virtio_features_t features;
>  
>  	writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
>  	features = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d9cbb02b35a11..b2fbc74f74b5c 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -18,7 +18,7 @@
>  #include "virtio_pci_common.h"
>  
>  /* virtio config->get_features() implementation */
> -static u64 vp_get_features(struct virtio_device *vdev)
> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d50fe030d8253..c3e0ddc7ae9ab 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -22,7 +22,7 @@
>  
>  #define VIRTIO_AVQ_SGS_MAX	4
>  
> -static u64 vp_get_features(struct virtio_device *vdev)
> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  
> @@ -353,7 +353,8 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>  	}
>  }
>  
> -static void vp_transport_features(struct virtio_device *vdev, u64 features)
> +static void vp_transport_features(struct virtio_device *vdev,
> +				  virtio_features_t features)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct pci_dev *pci_dev = vp_dev->pci_dev;
> @@ -409,7 +410,7 @@ static int vp_check_common_size(struct virtio_device *vdev)
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	u64 features = vdev->features;
> +	virtio_features_t features = vdev->features;
>  
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 0d3dbfaf4b236..1d34655f6b658 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -393,11 +393,10 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>   *
>   * Returns the features read from the device
>   */
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
> +virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	u64 features;
> +	virtio_features_t features;
>  
>  	vp_iowrite32(0, &cfg->device_feature_select);
>  	features = vp_ioread32(&cfg->device_feature);
> @@ -414,11 +413,11 @@ EXPORT_SYMBOL_GPL(vp_modern_get_features);
>   *
>   * Returns the driver features read from the device
>   */
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
> +virtio_features_t
> +vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> -
> -	u64 features;
> +	virtio_features_t features;
>  
>  	vp_iowrite32(0, &cfg->guest_feature_select);
>  	features = vp_ioread32(&cfg->guest_feature);
> @@ -435,7 +434,7 @@ EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
>   * @features: the features set to device
>   */
>  void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -			    u64 features)
> +			    virtio_features_t features)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>  
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 1f60c9d5cb181..b92749174885e 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -409,7 +409,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	return err;
>  }
>  
> -static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
> +static virtio_features_t virtio_vdpa_get_features(struct virtio_device *vdev)
>  {
>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>  	const struct vdpa_config_ops *ops = vdpa->config;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 64cb4b04be7ad..6e51400d04635 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -11,6 +11,7 @@
>  #include <linux/gfp.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/completion.h>
> +#include <linux/virtio_features.h>
>  
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -159,11 +160,11 @@ struct virtio_device {
>  	const struct virtio_config_ops *config;
>  	const struct vringh_config_ops *vringh_config;
>  	struct list_head vqs;
> -	u64 features;
> +	virtio_features_t features;
>  	void *priv;
>  #ifdef CONFIG_VIRTIO_DEBUG
>  	struct dentry *debugfs_dir;
> -	u64 debugfs_filter_features;
> +	virtio_features_t debugfs_filter_features;
>  #endif
>  };
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367facb..bff57f675fca7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -77,7 +77,7 @@ struct virtqueue_info {
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> - *	Returns the first 64 feature bits (all we currently need).
> + *	Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently need).
>   * @finalize_features: confirm what device features we'll be using.
>   *	vdev: the virtio_device
>   *	This sends the driver feature bits to the device: it can change
> @@ -120,7 +120,7 @@ struct virtio_config_ops {
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
>  	void (*synchronize_cbs)(struct virtio_device *);
> -	u64 (*get_features)(struct virtio_device *vdev);
> +	virtio_features_t (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);
>  	int (*set_vq_affinity)(struct virtqueue *vq,
> @@ -149,11 +149,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
>  {
>  	/* Did you forget to fix assumptions on max features? */
>  	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  
> -	return vdev->features & BIT_ULL(fbit);
> +	return vdev->features & VIRTIO_BIT(fbit);
>  }
>  
>  /**
> @@ -166,11 +166,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
>  {
>  	/* Did you forget to fix assumptions on max features? */
>  	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  
> -	vdev->features |= BIT_ULL(fbit);
> +	vdev->features |= VIRTIO_BIT(fbit);
>  }
>  
>  /**
> @@ -183,11 +183,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>  {
>  	/* Did you forget to fix assumptions on max features? */
>  	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>  
> -	vdev->features &= ~BIT_ULL(fbit);
> +	vdev->features &= ~VIRTIO_BIT(fbit);
>  }
>  
>  /**
> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
> new file mode 100644
> index 0000000000000..2f742eeb45a29
> --- /dev/null
> +++ b/include/linux/virtio_features.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_FEATURES_H
> +#define _LINUX_VIRTIO_FEATURES_H
> +
> +#include <linux/bits.h>
> +
> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
> +#define VIRTIO_HAS_EXTENDED_FEATURES
> +#define VIRTIO_FEATURES_MAX	128
> +#define VIRTIO_FEATURES_WORDS	4
> +#define VIRTIO_BIT(b)		_BIT128(b)
> +
> +typedef __uint128_t		virtio_features_t;

Since we are doing it anyway, what about __bitwise ?

We used to have a lot of bugs where people would stick
a bit number where BIT_ULL would be appropriate. These are all
fixed by now, I presume, but sounds like a good thing to have?
I think the changes would be localized to this patch, since
everyone should going through these macros now.


> +
> +#else
> +#define VIRTIO_FEATURES_MAX	64
> +#define VIRTIO_FEATURES_WORDS	2
> +#define VIRTIO_BIT(b)		BIT_ULL(b)

Hmm. We have
#define BIT_ULL(nr)             (ULL(1) << (nr))
So this is undefined behaviour if given bit > 63.


How about 

(nr > 63 ? 0 : BIT_ULL(b))


I think this will automatically make most code correct
on these platforms.

Some ceremony with a temp variable or an inline function
might be good here to avoid evaluating b twice.


> +
> +typedef u64			virtio_features_t;
> +#endif
> +
> +#endif
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index c0b1b1ca11635..e55fbb272b4d3 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_PCI_MODERN_H
>  
>  #include <linux/pci.h>
> +#include <linux/virtio_features.h>
>  #include <linux/virtio_pci.h>
>  
>  /**
> @@ -95,10 +96,14 @@ static inline void vp_iowrite64_twopart(u64 val,
>  	vp_iowrite32(val >> 32, hi);
>  }
>  
> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
> +virtio_features_t
> +vp_modern_get_features(struct virtio_pci_modern_device *mdev);
> +
> +virtio_features_t
> +vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
> +
>  void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
> -		     u64 features);
> +		     virtio_features_t features);
>  u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
>  u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
>  void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> -- 
> 2.49.0



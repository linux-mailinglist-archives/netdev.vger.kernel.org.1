Return-Path: <netdev+bounces-192548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7FEAC05BD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF313A3C8E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A0215787;
	Thu, 22 May 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoEAcZOI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2158202988
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898977; cv=none; b=Y+UX1ikBLV/IVcsoSEblFCwWJQmzskLyZvZzqHo8WSqC1VHya+G6ZVBVHHrcu0lxiF2cKXVWwUN0ufvwOj8uwZ20K312ZZAYZWGm6HyB1oEtGIhnjfGcoQn4S6XA5+QaO9SyAwp3QylbaXopWTQHYdipfWAEGIS4iXh/21G1Aj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898977; c=relaxed/simple;
	bh=IoID69/IuF3U3GvOT/Svn+MMFTkmTzKgF8iRK2NqC8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXsv0Z9zxd1IVErlBJGqsxvhzazYP6+RhpCwFEITtOHd5ou004KSwG+uX+QrKGVv00qnjAmJ8yMtTmjaWLe9MZVhnRY/SgWALVHzY1x/Ov0YaCV4Vjd1pS+efx9i3pkjDLOgGkIZbXBtLoutAz6o3tPr7ggvoVcSqho5p8R+sXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoEAcZOI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747898973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D1/VnGF6KQYcqZggvtqwHcTxHvNY4tlRgrj/bQyDss=;
	b=JoEAcZOIzn2+xz5+JMM1A32FqUqHwP5EWadybpqNRX6o5xFi5plIzi+Gup3UI2UruERW9Z
	CKxhKbG7V+NRcKatxmj5HVnamqsOc8fpkvOLKL6viHK7fmmhMMEmsbjmqrqBZ6lkBCr5LT
	uCX7d4BjR6bGZQ00ibjXMkZZ36AV/cs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-pOw-eUflNp2VY_h8r1H4wg-1; Thu, 22 May 2025 03:29:32 -0400
X-MC-Unique: pOw-eUflNp2VY_h8r1H4wg-1
X-Mimecast-MFC-AGG-ID: pOw-eUflNp2VY_h8r1H4wg_1747898971
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43efa869b19so59351625e9.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 00:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747898971; x=1748503771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D1/VnGF6KQYcqZggvtqwHcTxHvNY4tlRgrj/bQyDss=;
        b=PFdNXsCVCkZeJaA3BkrvvwDEhJ5rwIqeZYdkN27TEBPWfE2KkMzf+kslDHHtEh0brl
         0kdwJqtKAAFN0cRfBZJDToAZGTEzqasiaNGuhNLKAqJLnmWkbjZ5kfME8bLM50eeVtf7
         pcTVD4t6NHj72F5M2JiNFWXVY0IJ4+7YrfQwFiqu8hcl1sSM8UQo0ivJz969OOzwSm5P
         PRHh9P+u1fJe1eVSpsP2xbb1YqlOIFQ31GzeCDoAbHAQaCauLrL2QoUPhYsjnApDReWm
         MP9lb1PiP3IjOzeHNVjhrJ7biKIg6IY+X1JyiqmJe3hsRES3Vl9v3fBPWvSS9Jr2y2PY
         Fv2A==
X-Gm-Message-State: AOJu0Yy/x6shTiCPcBcIetjM5/TT/hn6PhrQZ96CFOoul1HLiydXec0D
	L4J1plZG9gm9mhGd54GqWuBAOQya7gy9EytJczzxzzjqRN0mGl14Sq/rQb0xclQ2ed0IiMFbULS
	HVTbjIBZAzFDnyW5PtQNLI45IXSz87nyTAZ6N5bnCHTQU21zI8VLASga/iQ==
X-Gm-Gg: ASbGnctxh5lCKKGeFbDcHdWvNzHdswlls9XTrV++qX2z6vgQvU7GpfUknoj4DvbzK73
	ICWAu3A0Sevu6gk1anrzPIjP1jlvgywSuLwJEEIvkenyDyr+ZhaxtlJMVZMo5GMDD0aqDWDnaTR
	cks6qLssyIwqnW1PFJJn0t35OO6HOzzPYrC1Nh5XlQSjJj8pKzSMwUjaHuVpOii5BgxFU5n6MHQ
	/BPPURavRrO38+61npq5c9JsnEKQboR73UpqL8arU4cqVtZjGOBZ8DgtmyE/Kv2+tPxTg/nW+bv
	QXkUTjzXOA2HyJE3T2s=
X-Received: by 2002:a05:600c:4753:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-442fefef18amr210766255e9.14.1747898970666;
        Thu, 22 May 2025 00:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN+ATeY6ODXxe5XeIEia8e3UNXH4S+W8aqhsao3f2mW0koggZWaqMGDaiEoUCugFg0zn+hqg==
X-Received: by 2002:a05:600c:4753:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-442fefef18amr210765935e9.14.1747898970182;
        Thu, 22 May 2025 00:29:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a8f8sm169492085e9.0.2025.05.22.00.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 00:29:29 -0700 (PDT)
Message-ID: <fa55e26b-54f7-400f-88f7-530f3a95a0e9@redhat.com>
Date: Thu, 22 May 2025 09:29:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <20250521115217-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521115217-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 6:02 PM, Michael S. Tsirkin wrote:
> On Wed, May 21, 2025 at 12:32:35PM +0200, Paolo Abeni wrote:
>> The virtio specifications allows for up to 128 bits for the
>> device features. Soon we are going to use some of the 'extended'
>> bits features (above 64) for the virtio_net driver.
>>
>> Introduce an specific type to represent the virtio features bitmask.
>> On platform where 128 bits integer are available use such wide int
>> for the features bitmask, otherwise maintain the current u64.
>>
>> Updates all the relevant virtio API to use the new type.
>>
>> Note that legacy and transport features don't need any change, as
>> they are always in the low 64 bit range.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/virtio/virtio.c                | 12 ++++++------
>>  drivers/virtio/virtio_mmio.c           |  4 ++--
>>  drivers/virtio/virtio_pci_legacy.c     |  2 +-
>>  drivers/virtio/virtio_pci_modern.c     |  7 ++++---
>>  drivers/virtio/virtio_pci_modern_dev.c | 13 ++++++-------
>>  drivers/virtio/virtio_vdpa.c           |  2 +-
>>  include/linux/virtio.h                 |  5 +++--
>>  include/linux/virtio_config.h          | 22 +++++++++++-----------
>>  include/linux/virtio_features.h        | 23 +++++++++++++++++++++++
>>  include/linux/virtio_pci_modern.h      | 11 ++++++++---
>>  10 files changed, 65 insertions(+), 36 deletions(-)
>>  create mode 100644 include/linux/virtio_features.h
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 95d5d7993e5b1..542735d3a12ba 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -272,9 +272,9 @@ static int virtio_dev_probe(struct device *_d)
>>  	int err, i;
>>  	struct virtio_device *dev = dev_to_virtio(_d);
>>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>> -	u64 device_features;
>> -	u64 driver_features;
>> -	u64 driver_features_legacy;
>> +	virtio_features_t device_features;
>> +	virtio_features_t driver_features;
>> +	virtio_features_t driver_features_legacy;
>>  
>>  	/* We have a driver! */
>>  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> 
> 
>> @@ -286,8 +286,8 @@ static int virtio_dev_probe(struct device *_d)
>>  	driver_features = 0;
>>  	for (i = 0; i < drv->feature_table_size; i++) {
>>  		unsigned int f = drv->feature_table[i];
>> -		BUG_ON(f >= 64);
>> -		driver_features |= (1ULL << f);
>> +		BUG_ON(f >= VIRTIO_FEATURES_MAX);
>> +		driver_features |= VIRTIO_BIT(f);
>>  	}
>>  
>>  	/* Some drivers have a separate feature table for virtio v1.0 */
>> @@ -320,7 +320,7 @@ static int virtio_dev_probe(struct device *_d)
>>  		goto err;
>>  
>>  	if (drv->validate) {
>> -		u64 features = dev->features;
>> +		virtio_features_t features = dev->features;
>>  
>>  		err = drv->validate(dev);
>>  		if (err)
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 5d78c2d572abf..158c47ac67de7 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -106,10 +106,10 @@ struct virtio_mmio_vq_info {
>>  
>>  /* Configuration interface */
>>  
>> -static u64 vm_get_features(struct virtio_device *vdev)
>> +static virtio_features_t vm_get_features(struct virtio_device *vdev)
>>  {
>>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>> -	u64 features;
>> +	virtio_features_t features;
>>  
>>  	writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
>>  	features = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
>> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
>> index d9cbb02b35a11..b2fbc74f74b5c 100644
>> --- a/drivers/virtio/virtio_pci_legacy.c
>> +++ b/drivers/virtio/virtio_pci_legacy.c
>> @@ -18,7 +18,7 @@
>>  #include "virtio_pci_common.h"
>>  
>>  /* virtio config->get_features() implementation */
>> -static u64 vp_get_features(struct virtio_device *vdev)
>> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index d50fe030d8253..c3e0ddc7ae9ab 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -22,7 +22,7 @@
>>  
>>  #define VIRTIO_AVQ_SGS_MAX	4
>>  
>> -static u64 vp_get_features(struct virtio_device *vdev)
>> +static virtio_features_t vp_get_features(struct virtio_device *vdev)
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  
>> @@ -353,7 +353,8 @@ static void vp_modern_avq_cleanup(struct virtio_device *vdev)
>>  	}
>>  }
>>  
>> -static void vp_transport_features(struct virtio_device *vdev, u64 features)
>> +static void vp_transport_features(struct virtio_device *vdev,
>> +				  virtio_features_t features)
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>>  	struct pci_dev *pci_dev = vp_dev->pci_dev;
>> @@ -409,7 +410,7 @@ static int vp_check_common_size(struct virtio_device *vdev)
>>  static int vp_finalize_features(struct virtio_device *vdev)
>>  {
>>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> -	u64 features = vdev->features;
>> +	virtio_features_t features = vdev->features;
>>  
>>  	/* Give virtio_ring a chance to accept features. */
>>  	vring_transport_features(vdev);
>> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
>> index 0d3dbfaf4b236..1d34655f6b658 100644
>> --- a/drivers/virtio/virtio_pci_modern_dev.c
>> +++ b/drivers/virtio/virtio_pci_modern_dev.c
>> @@ -393,11 +393,10 @@ EXPORT_SYMBOL_GPL(vp_modern_remove);
>>   *
>>   * Returns the features read from the device
>>   */
>> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>> +virtio_features_t vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>>  {
>>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>> -
>> -	u64 features;
>> +	virtio_features_t features;
>>  
>>  	vp_iowrite32(0, &cfg->device_feature_select);
>>  	features = vp_ioread32(&cfg->device_feature);
>> @@ -414,11 +413,11 @@ EXPORT_SYMBOL_GPL(vp_modern_get_features);
>>   *
>>   * Returns the driver features read from the device
>>   */
>> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
>> +virtio_features_t
>> +vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev)
>>  {
>>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>> -
>> -	u64 features;
>> +	virtio_features_t features;
>>  
>>  	vp_iowrite32(0, &cfg->guest_feature_select);
>>  	features = vp_ioread32(&cfg->guest_feature);
>> @@ -435,7 +434,7 @@ EXPORT_SYMBOL_GPL(vp_modern_get_driver_features);
>>   * @features: the features set to device
>>   */
>>  void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
>> -			    u64 features)
>> +			    virtio_features_t features)
>>  {
>>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
>>  
>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>> index 1f60c9d5cb181..b92749174885e 100644
>> --- a/drivers/virtio/virtio_vdpa.c
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -409,7 +409,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>>  	return err;
>>  }
>>  
>> -static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
>> +static virtio_features_t virtio_vdpa_get_features(struct virtio_device *vdev)
>>  {
>>  	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>  	const struct vdpa_config_ops *ops = vdpa->config;
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 64cb4b04be7ad..6e51400d04635 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/gfp.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/completion.h>
>> +#include <linux/virtio_features.h>
>>  
>>  /**
>>   * struct virtqueue - a queue to register buffers for sending or receiving.
>> @@ -159,11 +160,11 @@ struct virtio_device {
>>  	const struct virtio_config_ops *config;
>>  	const struct vringh_config_ops *vringh_config;
>>  	struct list_head vqs;
>> -	u64 features;
>> +	virtio_features_t features;
>>  	void *priv;
>>  #ifdef CONFIG_VIRTIO_DEBUG
>>  	struct dentry *debugfs_dir;
>> -	u64 debugfs_filter_features;
>> +	virtio_features_t debugfs_filter_features;
>>  #endif
>>  };
>>  
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 169c7d367facb..bff57f675fca7 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -77,7 +77,7 @@ struct virtqueue_info {
>>   *      vdev: the virtio_device
>>   * @get_features: get the array of feature bits for this device.
>>   *	vdev: the virtio_device
>> - *	Returns the first 64 feature bits (all we currently need).
>> + *	Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently need).
>>   * @finalize_features: confirm what device features we'll be using.
>>   *	vdev: the virtio_device
>>   *	This sends the driver feature bits to the device: it can change
>> @@ -120,7 +120,7 @@ struct virtio_config_ops {
>>  			struct irq_affinity *desc);
>>  	void (*del_vqs)(struct virtio_device *);
>>  	void (*synchronize_cbs)(struct virtio_device *);
>> -	u64 (*get_features)(struct virtio_device *vdev);
>> +	virtio_features_t (*get_features)(struct virtio_device *vdev);
>>  	int (*finalize_features)(struct virtio_device *vdev);
>>  	const char *(*bus_name)(struct virtio_device *vdev);
>>  	int (*set_vq_affinity)(struct virtqueue *vq,
>> @@ -149,11 +149,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
>>  {
>>  	/* Did you forget to fix assumptions on max features? */
>>  	if (__builtin_constant_p(fbit))
>> -		BUILD_BUG_ON(fbit >= 64);
>> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  	else
>> -		BUG_ON(fbit >= 64);
>> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  
>> -	return vdev->features & BIT_ULL(fbit);
>> +	return vdev->features & VIRTIO_BIT(fbit);
>>  }
>>  
>>  /**
>> @@ -166,11 +166,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
>>  {
>>  	/* Did you forget to fix assumptions on max features? */
>>  	if (__builtin_constant_p(fbit))
>> -		BUILD_BUG_ON(fbit >= 64);
>> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  	else
>> -		BUG_ON(fbit >= 64);
>> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  
>> -	vdev->features |= BIT_ULL(fbit);
>> +	vdev->features |= VIRTIO_BIT(fbit);
>>  }
>>  
>>  /**
>> @@ -183,11 +183,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>>  {
>>  	/* Did you forget to fix assumptions on max features? */
>>  	if (__builtin_constant_p(fbit))
>> -		BUILD_BUG_ON(fbit >= 64);
>> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  	else
>> -		BUG_ON(fbit >= 64);
>> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>>  
>> -	vdev->features &= ~BIT_ULL(fbit);
>> +	vdev->features &= ~VIRTIO_BIT(fbit);
>>  }
>>  
>>  /**
>> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
>> new file mode 100644
>> index 0000000000000..2f742eeb45a29
>> --- /dev/null
>> +++ b/include/linux/virtio_features.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_VIRTIO_FEATURES_H
>> +#define _LINUX_VIRTIO_FEATURES_H
>> +
>> +#include <linux/bits.h>
>> +
>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
>> +#define VIRTIO_HAS_EXTENDED_FEATURES
>> +#define VIRTIO_FEATURES_MAX	128
>> +#define VIRTIO_FEATURES_WORDS	4
>> +#define VIRTIO_BIT(b)		_BIT128(b)
>> +
>> +typedef __uint128_t		virtio_features_t;
> 
> Since we are doing it anyway, what about __bitwise ?

Yep, I will add it in the next revision.

>> +
>> +#else
>> +#define VIRTIO_FEATURES_MAX	64
>> +#define VIRTIO_FEATURES_WORDS	2
>> +#define VIRTIO_BIT(b)		BIT_ULL(b)
> 
> Hmm. We have
> #define BIT_ULL(nr)             (ULL(1) << (nr))
> So this is undefined behaviour if given bit > 63.
> 
> 
> How about 
> 
> (nr > 63 ? 0 : BIT_ULL(b))
> 
> 
> I think this will automatically make most code correct
> on these platforms.

Sounds good. Will add it in the next revision.

BTW I'm wondering if sharing a pull request from a stable tree would be
better, so that you could pull this also in the virtio/vhost tree and
avoid conflicts in the later pull to Linus.

Thanks,

Paolo



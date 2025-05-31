Return-Path: <netdev+bounces-194467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A279AC996B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 07:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77888A233FF
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E861DDC07;
	Sat, 31 May 2025 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="2XwaEGge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F02907
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748669882; cv=none; b=uca3o72phqutDm5MblcA9w91Bz2MHXE+tnuiy1iSXnm4R8Cb+CdB2wfp5Ze+/4ujC6ms8S3b5PiokQ4K0Vj35BOT4nJh4X25L0oi+PwXgCHQ+he8NrYd8k9pm8NTTLgj5kljw+9aPPAY3gm/BtPEKqvTd4budu3ECglAvcFxCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748669882; c=relaxed/simple;
	bh=z2DL9paKpewL/tohFoGg4bsRZaQlsx9/i8iBASIiZtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSVYb4IjNekoEkkLlgjbMWeLVEzLkiCHFkEtatfqf7Q58i/qm8xRJYlkHLZXl1Nmx2DgCrYIGEANWW17vHT2ySnMMG5amd0YHHxco6mcErWn9ua2n3D1Yi/ieLxX4qx8saDlb5Kbk0v9x7bB86phZ9YC7KF1AQmyLJyhB5TG0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=2XwaEGge; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1655662a12.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748669879; x=1749274679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7pns3vNbL/afb0jgOCaVptWokAOC1F45T9AerlkrJM=;
        b=2XwaEGgeS+0OdFgaWEQhhxfVvpccREZX8GLxekjYpvvfseUQm/XhWPEyOItWHMbvi6
         fK1G3fARLfRCixPSiiM8h2ZgydWl1gOQPM9s+TkgZPa3FIwmKP8OOEnZAO4evnJKfmbF
         7GKrBcayYeC6V9KunWuCYCCY6pwIisBWFVwMOdDTR7BAo2fs0+1iJ46aUZEasdE+tmj1
         BdXgRzEJZi6u8s3ZyqgNsc7GXE65pKmyhn6JieZR97cWWetdyObWy3ipNOOjFm+S4BNh
         yPo5UcY8DMbFUcNVGTgZ6kOmA57piBNUiCj1sZzWQ7pQgPkzK01OBGA81+qHbM3jhH9r
         4ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748669879; x=1749274679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7pns3vNbL/afb0jgOCaVptWokAOC1F45T9AerlkrJM=;
        b=AyJE8q7zG4W/oqHKotLZBXyMxPjOL0W9ImAg0XniqwXvJzecVpNF7bYz25N0nwov4M
         GSvuB8l9BnXYkVQhPC5O5hENDloT3UwvKVAIefio6m/mRnB6qetHxVpUP+o/ng8B4i+9
         ZZKdjkZz8NvzgueNBiy11JkIiyn7FiU7SePbiZDgtylPDZl/cO1p7mrZST+mcwAgFMgU
         W3N5/lTNEwyM/BSLEyCVW28PEmxAejIO1nVY0E9Hsa4McI9Pg9eR0GkIkjHvR7y0I0Mx
         KHLwVDi7QMamrNPSnEvM3in9MMkJQFnpxnv4j1hXbYlLJzw9my9b1UCsMHhG9omaW1vt
         4CyA==
X-Forwarded-Encrypted: i=1; AJvYcCXTbS1leMY93o3JPspNW9bQnCK3LwWo5i6nwYXG21JTPPgEubI987HnGciphr6Hc9OSogW+pNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNaQ+P3oj6Qqlr/EWYZg9Kdp8v0Tk8dG612t1NbUJdtOl0lDO
	k7//UPH4Eo6UTxtO6hmM4atvOV9q3P5wSDxt4w7op46alT3+XmX1bVlV28k7HjDoouE=
X-Gm-Gg: ASbGnct9GP4NLv2k4H/f7kFMxN8JsS3faOe741pp41cnXWxBJJ/G5Bf5zQS/dqA5F6c
	C+kUYZd3ov4rktb30YcbdI0riK2sUH4YL+Bmwn60EF8TVKn8egQBim9yzFkni1aA2ppUm0wY4s1
	DewHz8YTEFcuZg+vl3l8HhmHS6LXr98n8KewJqByYjizD3xX2OCEdy5QlR5QAUZ6Sb5Vlpal5oJ
	FOYPvFVqkgKRr86BCxwhJvRmIVouZ+67hwkZhH/xSiK8t/LAMxgb+HDAhcA2/BtIlxUtF+jYASy
	DUyt7KsqXWNfoznVLg16e7spNWG5zVa4T7EX0bV+IX0CgB/U8J7wvgCkTeU1Iw==
X-Google-Smtp-Source: AGHT+IEBW2yN4mdkfyRqaqJYcOfq6U2ABG67WBxQnN4RV4Jfc1l3nJ8Ur00b/zAumm7VcY/wJ8zvaQ==
X-Received: by 2002:a17:90b:2e45:b0:311:fde5:c4be with SMTP id 98e67ed59e1d1-31250476afcmr7148200a91.35.1748669879058;
        Fri, 30 May 2025 22:37:59 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e399c0esm2266095a91.26.2025.05.30.22.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 22:37:58 -0700 (PDT)
Message-ID: <da18286e-c518-4f6b-99bb-13b52df3555f@daynix.com>
Date: Sat, 31 May 2025 14:37:56 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] virtio: introduce virtio_features_t
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1748614223.git.pabeni@redhat.com>
 <5be304a8d0e2fffa6bd13cfa9ff848b2e5842171.1748614223.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5be304a8d0e2fffa6bd13cfa9ff848b2e5842171.1748614223.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/05/30 23:49, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio_net driver.
> 
> Introduce an specific type to represent the virtio features bitmask.
> 
> On platform where 128 bits integer are available use such wide int
> for the features bitmask, otherwise maintain the current u64.
> 
> Introduce an extended get_features128() configuration callback that
> devices supporting the extended features range must implement in
> place of the traditional one.

The callback is called get_extended_features() in the code, which makes 
more sense as it is actually 64-bit if CONFIG_ARCH_SUPPORTS_INT128 is 
not defined.

That said, it doesn't seem that the code saved by the use of 128-bit 
integer type is significant enough.

I can think of three strategies to support more features:
1) Converting bitmasks to 128-bit, which is this patch does
2) Convert both "features" and "debugfs_filter_features" of the struct
    into bitmaps provided by include/linux/bitmap.h

2) requires more changes, but perhaps there may be a middle ground.

Looking at details, there are two fields that contain feature bitmasks 
in the common structure, struct virtio_device:
- features
- debugfs_filter_features

Fortunately, "debugfs_filter_features" is only referred by
drivers/virtio/virtio_debug.c. The problem is "features", which is 
referred everywhere. Perhaps converting all of them into bitmaps may 
make sense in a long term, but it may be something you want to avoid 
with this patch series.

So there is the following middle-ground option:

3) Adding e.g., "features_hi" for the upper 64-bit of features
    (which is similar to what I suggested for QEMU*),
    and convert only "debugfs_filter_features" into a bitmap.

This substantially reduces the code change required for "features" and 
make them contained in the following three functions:
- virtio_dev_probe() in drivers/virtio/virtio.c
- features_show() in drivers/virtio/virtio.c
- virtio_debug_device_filter_features() in drivers/virtio/virtio_debug.c

These functions can use bitmaps internally, and convert them from/into 
64-bit integers using bitmap_from_arr64() and bitmap_to_arr64().

Since you are adding the support for extended features to 
virtio_pci_modern and virtio_net, you'll later need to change their 
implementations too, but that won't add complexity much; some complexity 
is inevitable even when choosing 1) and "[RFC PATCH v2 2/8] 
virtio_pci_modern: allow configuring extended features" already include it.

And by choosing 3), you can remove the check of 
CONFIG_ARCH_SUPPORTS_INT128 and avoid the need to test platforms without 
the config. I suspect particularly eliminating the need of test 
outweighs the cost of the additional change required for 3).

Regards,
Akihiko Odaki

* 
https://lore.kernel.org/qemu-devel/473516b5-d52b-4671-aeca-d02ad1940364@daynix.com/

> 
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - let u64 VIRTIO_BIT() cope with higher bit values
>    - add .get_extended_features instead of changing .get_features signature
> ---
>   drivers/virtio/virtio.c         | 14 +++++++-------
>   drivers/virtio/virtio_debug.c   |  2 +-
>   include/linux/virtio.h          |  5 +++--
>   include/linux/virtio_config.h   | 32 ++++++++++++++++++++++----------
>   include/linux/virtio_features.h | 27 +++++++++++++++++++++++++++
>   5 files changed, 60 insertions(+), 20 deletions(-)
>   create mode 100644 include/linux/virtio_features.h
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b..206ae8fa0654 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
>   	int err, i;
>   	struct virtio_device *dev = dev_to_virtio(_d);
>   	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> -	u64 device_features;
> -	u64 driver_features;
> -	u64 driver_features_legacy;
> +	virtio_features_t device_features;
> +	virtio_features_t driver_features;
> +	virtio_features_t driver_features_legacy;
>   
>   	/* We have a driver! */
>   	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
>   
>   	/* Figure out what features the device supports. */
> -	device_features = dev->config->get_features(dev);
> +	device_features = virtio_get_features(dev);
>   
>   	/* Figure out what features the driver supports. */
>   	driver_features = 0;
>   	for (i = 0; i < drv->feature_table_size; i++) {
>   		unsigned int f = drv->feature_table[i];
> -		BUG_ON(f >= 64);
> -		driver_features |= (1ULL << f);
> +		BUG_ON(f >= VIRTIO_FEATURES_MAX);
> +		driver_features |= VIRTIO_BIT(f);
>   	}
>   
>   	/* Some drivers have a separate feature table for virtio v1.0 */
> @@ -320,7 +320,7 @@ static int virtio_dev_probe(struct device *_d)
>   		goto err;
>   
>   	if (drv->validate) {
> -		u64 features = dev->features;
> +		virtio_features_t features = dev->features;
>   
>   		err = drv->validate(dev);
>   		if (err)
> diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
> index 95c8fc7705bb..5ca95422d3ca 100644
> --- a/drivers/virtio/virtio_debug.c
> +++ b/drivers/virtio/virtio_debug.c
> @@ -12,7 +12,7 @@ static int virtio_debug_device_features_show(struct seq_file *s, void *data)
>   	u64 device_features;
>   	unsigned int i;
>   
> -	device_features = dev->config->get_features(dev);
> +	device_features = virtio_get_features(dev);
>   	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
>   		if (device_features & (1ULL << i))
>   			seq_printf(s, "%u\n", i);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 64cb4b04be7a..6e51400d0463 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -11,6 +11,7 @@
>   #include <linux/gfp.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/completion.h>
> +#include <linux/virtio_features.h>
>   
>   /**
>    * struct virtqueue - a queue to register buffers for sending or receiving.
> @@ -159,11 +160,11 @@ struct virtio_device {
>   	const struct virtio_config_ops *config;
>   	const struct vringh_config_ops *vringh_config;
>   	struct list_head vqs;
> -	u64 features;
> +	virtio_features_t features;
>   	void *priv;
>   #ifdef CONFIG_VIRTIO_DEBUG
>   	struct dentry *debugfs_dir;
> -	u64 debugfs_filter_features;
> +	virtio_features_t debugfs_filter_features;
>   #endif
>   };
>   
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367fac..1cc43d9cf6e8 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -77,7 +77,10 @@ struct virtqueue_info {
>    *      vdev: the virtio_device
>    * @get_features: get the array of feature bits for this device.
>    *	vdev: the virtio_device
> - *	Returns the first 64 feature bits (all we currently need).
> + *	Returns the first 64 feature bits.
> + * @get_extended_features:
> + *      vdev: the virtio_device
> + *      Returns the first VIRTIO_FEATURES_MAX feature bits (all we currently need).
>    * @finalize_features: confirm what device features we'll be using.
>    *	vdev: the virtio_device
>    *	This sends the driver feature bits to the device: it can change
> @@ -121,6 +124,7 @@ struct virtio_config_ops {
>   	void (*del_vqs)(struct virtio_device *);
>   	void (*synchronize_cbs)(struct virtio_device *);
>   	u64 (*get_features)(struct virtio_device *vdev);
> +	virtio_features_t (*get_extended_features)(struct virtio_device *vdev);
>   	int (*finalize_features)(struct virtio_device *vdev);
>   	const char *(*bus_name)(struct virtio_device *vdev);
>   	int (*set_vq_affinity)(struct virtqueue *vq,
> @@ -149,11 +153,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
>   {
>   	/* Did you forget to fix assumptions on max features? */
>   	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   
> -	return vdev->features & BIT_ULL(fbit);
> +	return vdev->features & VIRTIO_BIT(fbit);
>   }
>   
>   /**
> @@ -166,11 +170,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
>   {
>   	/* Did you forget to fix assumptions on max features? */
>   	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   
> -	vdev->features |= BIT_ULL(fbit);
> +	vdev->features |= VIRTIO_BIT(fbit);
>   }
>   
>   /**
> @@ -183,11 +187,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>   {
>   	/* Did you forget to fix assumptions on max features? */
>   	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   
> -	vdev->features &= ~BIT_ULL(fbit);
> +	vdev->features &= ~VIRTIO_BIT(fbit);
>   }
>   
>   /**
> @@ -204,6 +208,14 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>   	return __virtio_test_bit(vdev, fbit);
>   }
>   
> +static inline virtio_features_t virtio_get_features(struct virtio_device *vdev)
> +{
> +	if (vdev->config->get_extended_features)
> +		return vdev->config->get_extended_features(vdev);
> +
> +	return vdev->config->get_features(vdev);
> +}
> +
>   /**
>    * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
> new file mode 100644
> index 000000000000..0a7e2265f8b4
> --- /dev/null
> +++ b/include/linux/virtio_features.h
> @@ -0,0 +1,27 @@
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
> +typedef __uint128_t virtio_features_t;
> +
> +#else
> +#define VIRTIO_FEATURES_MAX	64
> +#define VIRTIO_FEATURES_WORDS	2
> +
> +static inline u64 VIRTIO_BIT(int bit)
> +{
> +	return bit >= 64 ? 0 : BIT_ULL(b);
> +}
> +
> +typedef u64 virtio_features_t;
> +#endif
> +
> +#endif



Return-Path: <netdev+bounces-195534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F59AD110F
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 07:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F483ABCCC
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF91EF09C;
	Sun,  8 Jun 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rRuCf6gl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09063FF1
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361797; cv=none; b=WmBBuqgEGQh1Rd85ewNBhsi68C6lo2USnDZTIPDdSbXQm6ck3LibT/NI/6BgSURRIBn8AFH+lgTvYLVC0dpNDUG4viETi9s9X6lBFouW1zNZwEU+gL4FZ/J8QeffIZdfOliIPhbYT0qyoI+OLtUf1MvZAG0BCm/3QchuDP3zD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361797; c=relaxed/simple;
	bh=eKaSjzaukVqgkSug6ffqReB42cf8kuLjsk3ekzNyrMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eitIDVhoBdzybAyc2mpN6aUO1X1SWXqofybU6+a5U1c8i/AwuBcaP0Trc9T1JE4JJ8KyhV6ySDRJeRZGkuaM7XzO0QUC5EAgvG3BT3ymXl5mvwBeWwt2THXz5lRwtgZBHmxE+wOQXquydCf/P19mrjSNsIUC5DNI0AkpYh5xvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rRuCf6gl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236192f8770so3649165ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749361795; x=1749966595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWZ38ZrEp1+Hx2HEtC4aFLqXFBpnTZ+Q6jDPJmp9rCA=;
        b=rRuCf6gl/gzRXSfsbnnO3hrzpjjUtHwl5jFMW/tXGfMMvo64LMHvrADl3KXJWGWWmn
         CGMdtFBz+oS5sjYlMeWoQSTrJw4wz3nx1aRHdTdYZpa8CyD9KQzaxQDSiGxer8ULajzL
         etpYLnNHjQHPg222eL5am/qReQqMMgjfETaipv91piz9OrXIKMaKHiuQQMhZ8nMYjBsA
         Z8mi8jxK9h+soWUOUUQsKh3/cxcbfnLBwmFye/QyTMoFCxsee2hj7yuN/wJoufdMQ2qu
         bXUkYPd4LvFkLlDSJlqB3y712sJwlqqQghD/iV/R+TVR1NavlssS+OSxRkYUErE0dKOj
         lAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749361795; x=1749966595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWZ38ZrEp1+Hx2HEtC4aFLqXFBpnTZ+Q6jDPJmp9rCA=;
        b=vo7rvfI5vR2BXZMWxw/p2ySdf1qbH60gWDco7AXSiXUZklm6XEuV+WYTl9pBhLHgl0
         L5J/gOOuTTLjoP46GlorG7kSgbF7X4hLdMdK9/6DSRI95naOXJxzFkmMAhIBwuE2wE3l
         Uq82tzw8eW4uNFxO4wkxQlpoYAXxvnKtBKiK/g0lp79+J7TLTUF4ihZZTRztaBpw5ISl
         X1C8nJsU0TbgAJKN1B07Rs3iBPxi8vhgh/hUrRVWWAovYnzsRPasaxPcWZQ7TaCej5nb
         2YBFn6rEMuc7iih/kvphhPuP7rI8mizhunHtOIlxcs0eJswhK7c+fAIPA5pXKkjSnCFm
         nClg==
X-Forwarded-Encrypted: i=1; AJvYcCVwr/BPcGTjhuYuoZOeE00F0yyfLepZVq8aBZVNoo8EnrhAX0CK6LXQfr+CsXnR0OgvMyseobg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEwBXJU6O+RHyPrXh8MjuVaLjbMGVVTQLpqomrpEmmB3AcX2U
	dQb+onOHYQ/1eXbMup51hQFxPu8ifsVObdA7Zk6XerSZGTFRU56DQcezkw9hFa235FQ=
X-Gm-Gg: ASbGncsSFO+QBbsY3PuXQvO+n4LJiSnkpnRee8xQDCB3T/FyUaUTqYvOmant/537/fd
	yZBaQMZsVIOzTH7lgOIiILetUmZY5P3USgDkV1q3M6bkh+Xmv+8W9JvaXNFwFPyqE+JSokPlxmQ
	QGnblAYi2U2t7o4hyQl0lUYX+Zs1tgTchxQlhRUyFIqZP2RZkPb89JNrsbSwnU2lH0tAKC8umwa
	hEg7Oac88dv4dVhKvp0egjZGAOOPIp1SIBTZtT2nPGiMb3qRjDEe8c1Xql7P6PoT4h762jdOLIM
	zvmDPciEereYnmiiLlxxhMClo1fCrMWzvVZkJIzLdmdJw4zH8I8o/yscYoDzzwPtBLcMgGyn41o
	=
X-Google-Smtp-Source: AGHT+IFAPZliG9aztEc4J2nw2g3G5H61StP1wNzwn4/k8HD0M9RXhjqDcmQeFnjaQapG7YSdmeK0aQ==
X-Received: by 2002:a17:902:eccb:b0:234:24a8:bee9 with SMTP id d9443c01a7336-236135d613amr59344315ad.4.1749361794908;
        Sat, 07 Jun 2025 22:49:54 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm34979885ad.122.2025.06.07.22.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 22:49:54 -0700 (PDT)
Message-ID: <165572ca-edc0-4b31-be53-065e257701df@daynix.com>
Date: Sun, 8 Jun 2025 14:49:51 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/8] virtio: introduce extended features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <47a89c6b568c3ab266ab351711f916d4a683ebdf.1749210083.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/06 20:45, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (above 64) for the virtio_net driver.
> 
> Introduce extended features as a fixed size array of u64. To minimize
> the diffstat allows legacy driver to access the low 64 bits via a
> transparent union.
> 
> Introduce an extended get_extended_features128 configuration callback
> that devices supporting the extended features range must implement in
> place of the traditional one.

It's named as get_extended_features(); now it can grow to have more than 
128 bits, which is nice.

> 
> Note that legacy and transport features don't need any change, as
> they are always in the low 64 bit range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>    - uint128_t -> u64[2];
> v1 -> v2:
>    - let u64 VIRTIO_BIT() cope with higher bit values
>    - add .get_features128 instead of changing .get_features signature
> ---
>   drivers/virtio/virtio.c         | 39 +++++++++++-------
>   drivers/virtio/virtio_debug.c   | 27 +++++++------
>   include/linux/virtio.h          |  5 ++-
>   include/linux/virtio_config.h   | 35 ++++++++++++-----
>   include/linux/virtio_features.h | 70 +++++++++++++++++++++++++++++++++
>   5 files changed, 137 insertions(+), 39 deletions(-)
>   create mode 100644 include/linux/virtio_features.h
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b..ed1ccedc47b3 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -53,7 +53,7 @@ static ssize_t features_show(struct device *_d,
>   
>   	/* We actually represent this as a bitstring, as it could be
>   	 * arbitrary length in future. */
> -	for (i = 0; i < sizeof(dev->features)*8; i++)
> +	for (i = 0; i < VIRTIO_FEATURES_MAX; i++)
>   		len += sysfs_emit_at(buf, len, "%c",
>   			       __virtio_test_bit(dev, i) ? '1' : '0');
>   	len += sysfs_emit_at(buf, len, "\n");
> @@ -272,22 +272,22 @@ static int virtio_dev_probe(struct device *_d)
>   	int err, i;
>   	struct virtio_device *dev = dev_to_virtio(_d);
>   	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> -	u64 device_features;
> -	u64 driver_features;
> +	u64 device_features[VIRTIO_FEATURES_DWORDS];
> +	u64 driver_features[VIRTIO_FEATURES_DWORDS];
>   	u64 driver_features_legacy;
>   
>   	/* We have a driver! */
>   	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
>   
>   	/* Figure out what features the device supports. */
> -	device_features = dev->config->get_features(dev);
> +	virtio_get_features(dev, device_features);
>   
>   	/* Figure out what features the driver supports. */
> -	driver_features = 0;
> +	virtio_features_zero(driver_features);
>   	for (i = 0; i < drv->feature_table_size; i++) {
>   		unsigned int f = drv->feature_table[i];
> -		BUG_ON(f >= 64);
> -		driver_features |= (1ULL << f);
> +		BUG_ON(f >= VIRTIO_FEATURES_MAX);
> +		virtio_features_set_bit(driver_features, f);
>   	}
>   
>   	/* Some drivers have a separate feature table for virtio v1.0 */
> @@ -299,20 +299,25 @@ static int virtio_dev_probe(struct device *_d)
>   			driver_features_legacy |= (1ULL << f);
>   		}
>   	} else {
> -		driver_features_legacy = driver_features;
> +		driver_features_legacy = driver_features[0];
>   	}
>   
> -	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> -		dev->features = driver_features & device_features;
> -	else
> -		dev->features = driver_features_legacy & device_features;
> +	if (virtio_features_test_bit(device_features, VIRTIO_F_VERSION_1)) {
> +		for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
> +			dev->features_array[i] = driver_features[i] &
> +						 device_features[i];
> +	} else {
> +		virtio_features_from_u64(dev->features_array,
> +					 driver_features_legacy &
> +					 device_features[0]);
> +	}
>   
>   	/* When debugging, user may filter some features by hand. */
>   	virtio_debug_device_filter_features(dev);
>   
>   	/* Transport features always preserved to pass to finalize_features. */
>   	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
> -		if (device_features & (1ULL << i))
> +		if (virtio_features_test_bit(device_features, i))
>   			__virtio_set_bit(dev, i);
>   
>   	err = dev->config->finalize_features(dev);
> @@ -320,14 +325,15 @@ static int virtio_dev_probe(struct device *_d)
>   		goto err;
>   
>   	if (drv->validate) {
> -		u64 features = dev->features;
> +		u64 features[VIRTIO_FEATURES_DWORDS];
>   
> +		virtio_features_copy(features, dev->features_array);
>   		err = drv->validate(dev);
>   		if (err)
>   			goto err;
>   
>   		/* Did validation change any features? Then write them again. */
> -		if (features != dev->features) {
> +		if (!virtio_features_equal(features, dev->features_array)) {
>   			err = dev->config->finalize_features(dev);
>   			if (err)
>   				goto err;
> @@ -701,6 +707,9 @@ EXPORT_SYMBOL_GPL(virtio_device_reset_done);
>   
>   static int virtio_init(void)
>   {
> +	BUILD_BUG_ON(offsetof(struct virtio_device, features) !=
> +		     offsetof(struct virtio_device, features_array[0]));
> +
>   	if (bus_register(&virtio_bus) != 0)
>   		panic("virtio bus registration failed");
>   	virtio_debug_init();
> diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
> index 95c8fc7705bb..6d066b5e8ec0 100644
> --- a/drivers/virtio/virtio_debug.c
> +++ b/drivers/virtio/virtio_debug.c
> @@ -8,13 +8,13 @@ static struct dentry *virtio_debugfs_dir;
>   
>   static int virtio_debug_device_features_show(struct seq_file *s, void *data)
>   {
> +	u64 device_features[VIRTIO_FEATURES_DWORDS];
>   	struct virtio_device *dev = s->private;
> -	u64 device_features;
>   	unsigned int i;
>   
> -	device_features = dev->config->get_features(dev);
> -	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
> -		if (device_features & (1ULL << i))
> +	virtio_get_features(dev, device_features);
> +	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
> +		if (virtio_features_test_bit(device_features, i))
>   			seq_printf(s, "%u\n", i);
>   	}
>   	return 0;
> @@ -26,8 +26,8 @@ static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
>   	struct virtio_device *dev = s->private;
>   	unsigned int i;
>   
> -	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
> -		if (dev->debugfs_filter_features & (1ULL << i))
> +	for (i = 0; i < VIRTIO_FEATURES_MAX; i++) {
> +		if (virtio_features_test_bit(dev->debugfs_filter_features, i))
>   			seq_printf(s, "%u\n", i);
>   	}
>   	return 0;
> @@ -39,7 +39,7 @@ static int virtio_debug_filter_features_clear(void *data, u64 val)
>   	struct virtio_device *dev = data;
>   
>   	if (val == 1)
> -		dev->debugfs_filter_features = 0;
> +		virtio_features_zero(dev->debugfs_filter_features);
>   	return 0;
>   }
>   
> @@ -50,9 +50,10 @@ static int virtio_debug_filter_feature_add(void *data, u64 val)
>   {
>   	struct virtio_device *dev = data;
>   
> -	if (val >= BITS_PER_LONG_LONG)
> +	if (val >= VIRTIO_FEATURES_MAX)
>   		return -EINVAL;
> -	dev->debugfs_filter_features |= BIT_ULL_MASK(val);
> +
> +	virtio_features_set_bit(dev->debugfs_filter_features, val);
>   	return 0;
>   }
>   
> @@ -63,9 +64,10 @@ static int virtio_debug_filter_feature_del(void *data, u64 val)
>   {
>   	struct virtio_device *dev = data;
>   
> -	if (val >= BITS_PER_LONG_LONG)
> +	if (val >= VIRTIO_FEATURES_MAX)
>   		return -EINVAL;
> -	dev->debugfs_filter_features &= ~BIT_ULL_MASK(val);
> +
> +	virtio_features_clear_bit(dev->debugfs_filter_features, val);
>   	return 0;
>   }
>   
> @@ -91,7 +93,8 @@ EXPORT_SYMBOL_GPL(virtio_debug_device_init);
>   
>   void virtio_debug_device_filter_features(struct virtio_device *dev)
>   {
> -	dev->features &= ~dev->debugfs_filter_features;
> +	virtio_features_and_not(dev->features_array, dev->features_array,
> +				dev->debugfs_filter_features);
>   }
>   EXPORT_SYMBOL_GPL(virtio_debug_device_filter_features);
>   
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 64cb4b04be7a..dcd3949572bd 100644
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
> +	VIRTIO_DECLARE_FEATURES(features);
>   	void *priv;
>   #ifdef CONFIG_VIRTIO_DEBUG
>   	struct dentry *debugfs_dir;
> -	u64 debugfs_filter_features;
> +	u64 debugfs_filter_features[VIRTIO_FEATURES_DWORDS];
>   #endif
>   };
>   
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367fac..83cf25b3028d 100644
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
> @@ -121,6 +124,8 @@ struct virtio_config_ops {
>   	void (*del_vqs)(struct virtio_device *);
>   	void (*synchronize_cbs)(struct virtio_device *);
>   	u64 (*get_features)(struct virtio_device *vdev);
> +	void (*get_extended_features)(struct virtio_device *vdev,
> +				      u64 *features);
>   	int (*finalize_features)(struct virtio_device *vdev);
>   	const char *(*bus_name)(struct virtio_device *vdev);
>   	int (*set_vq_affinity)(struct virtqueue *vq,
> @@ -149,11 +154,11 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
>   {
>   	/* Did you forget to fix assumptions on max features? */
>   	if (__builtin_constant_p(fbit))
> -		BUILD_BUG_ON(fbit >= 64);
> +		BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
>   	else
> -		BUG_ON(fbit >= 64);
> +		BUG_ON(fbit >= VIRTIO_FEATURES_MAX);

This check is better to be moved into virtio_features_test_bit().

>   
> -	return vdev->features & BIT_ULL(fbit);
> +	return virtio_features_test_bit(vdev->features_array, fbit);
>   }
>   
>   /**
> @@ -166,11 +171,11 @@ static inline void __virtio_set_bit(struct virtio_device *vdev,
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
> +	virtio_features_set_bit(vdev->features_array, fbit);
>   }
>   
>   /**
> @@ -183,11 +188,11 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
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
> +	virtio_features_clear_bit(vdev->features_array, fbit);
>   }
>   
>   /**
> @@ -204,6 +209,16 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>   	return __virtio_test_bit(vdev, fbit);
>   }
>   
> +static inline void virtio_get_features(struct virtio_device *vdev, u64 *features)
> +{
> +	if (vdev->config->get_extended_features) {
> +		vdev->config->get_extended_features(vdev, features);
> +		return;
> +	}
> +
> +	virtio_features_from_u64(features, vdev->config->get_features(vdev));
> +}
> +
>   /**
>    * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
> new file mode 100644
> index 000000000000..42c3c7cee500
> --- /dev/null
> +++ b/include/linux/virtio_features.h
> @@ -0,0 +1,70 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_FEATURES_H
> +#define _LINUX_VIRTIO_FEATURES_H
> +
> +#include <linux/bits.h>
> +
> +#define VIRTIO_FEATURES_DWORDS	2
> +#define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_DWORDS * 64)
> +#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_DWORDS * 2)
> +#define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
> +#define VIRTIO_DWORD(b)		((b) >> 6)

You can use BIT_ULL_MASK() and BIT_ULL_WORD().

> +#define VIRTIO_DECLARE_FEATURES(name)			\
> +	union {						\
> +		u64 name;				\
> +		u64 name##_array[VIRTIO_FEATURES_DWORDS];\
> +	}

This is clever. I like this.

> +
> +static inline bool virtio_features_test_bit(const u64 *features,
> +					    unsigned int bit)
> +{
> +	return !!(features[VIRTIO_DWORD(bit)] & VIRTIO_BIT(bit));
> +}
> +
> +static inline void virtio_features_set_bit(u64 *features,
> +					   unsigned int bit)
> +{
> +	features[VIRTIO_DWORD(bit)] |= VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_clear_bit(u64 *features,
> +					     unsigned int bit)
> +{
> +	features[VIRTIO_DWORD(bit)] &= ~VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_zero(u64 *features)
> +{
> +	memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_from_u64(u64 *features, u64 from)
> +{
> +	virtio_features_zero(features);
> +	features[0] = from;
> +}
> +
> +static inline bool virtio_features_equal(const u64 *f1, const u64 *f2)
> +{
> +	u64 diff = 0;
> +	int i;
> +
> +	for (i = 0; i < VIRTIO_FEATURES_DWORDS; ++i)
> +		diff |= f1[i] ^ f2[i];
> +	return !!diff;
> +}
> +
> +static inline void virtio_features_copy(u64 *to, const u64 *from)
> +{
> +	memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_and_not(u64 *to, const u64 *f1, const u64 *f2)

Other similar functions uses "andnot" instead "and_not" for their names.

Regards,
Akihiko Odaki

> +{
> +	int i;
> +
> +	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
> +		to[i] = f1[i] & ~f2[i];
> +}
> +
> +#endif



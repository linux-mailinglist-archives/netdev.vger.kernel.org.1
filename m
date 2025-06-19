Return-Path: <netdev+bounces-199525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E51AAE09C6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A53A8CD1
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E428B4EF;
	Thu, 19 Jun 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ViUg8oCz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D85227B83
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345243; cv=none; b=QEwaXtOJiWtneSDH55s5smWFk7CgznZ9Ar4PpJbXFQl8bAtHVf98BWUvpXw8+FTnsx3hhXk7UdDxb05+Ccur+7/04PXc2GQKbrpx3G1xdwH0Lj1YjV2tBX67z9kvNJW+kCbIAhML4S+P4H51bjQ2mwHSyccb2WoB68pY7sJ2kQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345243; c=relaxed/simple;
	bh=dQNla0/wh5v1DaAwQfiJxU51+21oEWtTHRGEvFpO3fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bo4xy+eFZxn+9PLqFMkQ6J647romm3qktme4RyBv0nDx4giATCMbBcTYKLyhdv3Byek+nsL1riUgptQUDnNQuWIjMFKxh8n1niknvgBGd+ggprcTusFRrh57fsanWajN3qBasuAS9fUqu3wC7XuD2kKipALw4HiD8plAIqiPFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ViUg8oCz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so599181b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750345241; x=1750950041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbqsTG+WR0DzpOILYTiC2FTuehgWfdHcmXuIvq1R3N0=;
        b=ViUg8oCztHaYq6UMdZMg91EjFL1+LNe4kFJXTGg9IRexL09pzuSnbhWdoz3HAtimSL
         CSBJRwDsi/bQ5JKNLbBhjQpaoPlJoSTYfLuqxVcXw6wfpA3rR4wXdh16Xkpqp9IgPn7d
         HhiLfCkWFCm7BHIPxCZq7pDO1dxFJsJj9YfZF5VwNPYqTqZ6lJTqgb1nhkhnxw3zRywx
         IGKLxiRzuNnz2zGNL7vtj9zlmYVsOIswKQOAI1EEd7q3cEKd/rspZLLbPnkaLb1l+8F/
         tcAP6sOHL1Z9ODDbuQP7i9vLIRgIQqYzJilrA7jwWXeToF348KR0HkFpkr+vVk6TtQS9
         +1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345241; x=1750950041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbqsTG+WR0DzpOILYTiC2FTuehgWfdHcmXuIvq1R3N0=;
        b=EGd6YYAhl4gnHjUtLNO7HCr7ox4XwP5GZ8Il3/9Sy72A75ijNKQVoWKAidUpdZgZ4s
         XVYE99sbUmNfC66cii4JIeUhuau2K7ux3UVmoBvty+Uxb6hzk5WpFOHARhuoGQdHGMif
         rSJzy+VAk9OHAvykaD2efBhzZORwfy7JT/eG7ZuB1KUW9Cm7pa9AEPrzRv4v2jqNrFYQ
         q7Zeb932OYNxaKdGW64LQ8REfG39HzPMrQ2FO7oxVQyN6vb02KNdNPuVJpnkJsO6xECN
         3oi6CeMIGbHET32yEfFY27PkOzOPb6yoTvKdRp2qs2iig9nZjCdN4L8u+4C8tW5wOwnK
         yAaw==
X-Forwarded-Encrypted: i=1; AJvYcCXZyTO5tPaQ/0oAt6KiM2y4ufIQqeoaNPMzi1m/Ixp/qkiyRbCoFRr0h+xMw8DMDWbOhMPA7I0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39xUDStJzq+YNvimrXZQ4YN4QRputAZfpdkwcRK5jzDZycked
	qZPQFpXHA0o1gS8sdpmKlAK6SkBaC9sFgxiifG8MQKPqWJfHdR6v5+H1tkMY5nDL6V0=
X-Gm-Gg: ASbGncs2btmRYmFMa8Q+i7EBYaFUz6NrpEyusMP+JPldnW3MoKqRobCtlSw5yPnhZwc
	i068iP6ubFU08A+eUPatP5BHZPdLaRvS6Jqu16ZH02/dOVhSmlJIQlbo/IaqtGbSQPQlhk5zpUH
	pOi3I/6TqZCmM40n8I6ou5PEYe3gQ4Viprhhrrrae0JvJxH2TPm/E1DNf5GuXC+Jsv4QDsvtBG1
	AUjfx9HUNdiAEhOtXLj0Xh/5Lw5qMw3fCfWU9oG2P/DBmtLmTg3rwPdIzjdmnyq9USPnDMZKlgN
	iOeja13m/fqlvzUB2Ue1y9zbDdT8ZL4ETUpzRvRteLsTkn2H/HopBNmnHCzW3AUku5EZyLW0CMI
	=
X-Google-Smtp-Source: AGHT+IFhSiX0teIV17ufUa6FIi5e7mNIOeSAS79lgqnCmX8uRJD0lusMq6ngH/Lv1ldogoDQmj6OjA==
X-Received: by 2002:a05:6a21:5010:b0:220:1215:fea7 with SMTP id adf61e73a8af0-2201216010emr3776354637.9.1750345239092;
        Thu, 19 Jun 2025 08:00:39 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46eb71sm101416b3a.22.2025.06.19.08.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 08:00:38 -0700 (PDT)
Message-ID: <e9ca64b4-3196-4b7b-822c-4bb0b40f8689@daynix.com>
Date: Fri, 20 Jun 2025 00:00:34 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/8] vhost-net: allow configuring extended
 features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <c510db61e36ce3b26e3a1fb7716c17f6888da095.1750176076.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <c510db61e36ce3b26e3a1fb7716c17f6888da095.1750176076.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/18 1:12, Paolo Abeni wrote:
> Use the extended feature type for 'acked_features' and implement
> two new ioctls operation allowing the user-space to set/query an
> unbounded amount of features.
> 
> The actual number of processed features is limited by VIRTIO_FEATURES_MAX
> and attempts to set features above such limit fail with
> EOPNOTSUPP.
> 
> Note that: the legacy ioctls implicitly truncate the negotiated
> features to the lower 64 bits range and the 'acked_backend_features'
> field don't need conversion, as the only negotiated feature there
> is in the low 64 bit range.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>    - use a single static (lower case) constant instead of enum and old def
>    - simpler VHOST_GET_FEATURES_ARRAY impl
>    - avoid using virtio_features_and_not
> 
> v2 -> v3:
>    - virtio_features_t -> u64[2]
>    - add __counted_by annotation to vhost_features_array
> 
> v1 -> v2:
>    - change the ioctl to use an extensible API
> ---
>   drivers/vhost/net.c              | 87 ++++++++++++++++++++++++--------
>   drivers/vhost/vhost.c            |  2 +-
>   drivers/vhost/vhost.h            |  4 +-
>   include/uapi/linux/vhost.h       |  7 +++
>   include/uapi/linux/vhost_types.h |  5 ++
>   5 files changed, 82 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..126aa4ee26a8 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -69,12 +69,12 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
>   
>   #define VHOST_DMA_IS_DONE(len) ((__force u32)(len) >= (__force u32)VHOST_DMA_DONE_LEN)
>   
> -enum {
> -	VHOST_NET_FEATURES = VHOST_FEATURES |
> -			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> -			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -			 (1ULL << VIRTIO_F_RING_RESET)
> +static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
> +	VHOST_FEATURES |
> +	(1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> +	(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> +	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> +	(1ULL << VIRTIO_F_RING_RESET),
>   };
>   
>   enum {
> @@ -1614,16 +1614,17 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>   	return err;
>   }
>   
> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
> +static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
>   {
>   	size_t vhost_hlen, sock_hlen, hdr_len;
>   	int i;
>   
> -	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -			       (1ULL << VIRTIO_F_VERSION_1))) ?
> -			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
> -			sizeof(struct virtio_net_hdr);
> -	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
> +	hdr_len = virtio_features_test_bit(features, VIRTIO_NET_F_MRG_RXBUF) ||
> +		  virtio_features_test_bit(features, VIRTIO_F_VERSION_1) ?
> +		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
> +		  sizeof(struct virtio_net_hdr);
> +
> +	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
>   		/* vhost provides vnet_hdr */
>   		vhost_hlen = hdr_len;
>   		sock_hlen = 0;
> @@ -1633,18 +1634,19 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
>   		sock_hlen = hdr_len;
>   	}
>   	mutex_lock(&n->dev.mutex);
> -	if ((features & (1 << VHOST_F_LOG_ALL)) &&
> +	if (virtio_features_test_bit(features, VHOST_F_LOG_ALL) &&
>   	    !vhost_log_access_ok(&n->dev))
>   		goto out_unlock;
>   
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
>   		if (vhost_init_device_iotlb(&n->dev))
>   			goto out_unlock;
>   	}
>   
>   	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
>   		mutex_lock(&n->vqs[i].vq.mutex);
> -		n->vqs[i].vq.acked_features = features;
> +		virtio_features_copy(n->vqs[i].vq.acked_features_array,
> +				     features);
>   		n->vqs[i].vhost_hlen = vhost_hlen;
>   		n->vqs[i].sock_hlen = sock_hlen;
>   		mutex_unlock(&n->vqs[i].vq.mutex);
> @@ -1681,12 +1683,13 @@ static long vhost_net_set_owner(struct vhost_net *n)
>   static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>   			    unsigned long arg)
>   {
> +	u64 all_features[VIRTIO_FEATURES_DWORDS];
>   	struct vhost_net *n = f->private_data;
>   	void __user *argp = (void __user *)arg;
>   	u64 __user *featurep = argp;
>   	struct vhost_vring_file backend;
> -	u64 features;
> -	int r;
> +	u64 features, count, copied;
> +	int r, i;
>   
>   	switch (ioctl) {
>   	case VHOST_NET_SET_BACKEND:
> @@ -1694,16 +1697,60 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>   			return -EFAULT;
>   		return vhost_net_set_backend(n, backend.index, backend.fd);
>   	case VHOST_GET_FEATURES:
> -		features = VHOST_NET_FEATURES;
> +		features = vhost_net_features[0];
>   		if (copy_to_user(featurep, &features, sizeof features))
>   			return -EFAULT;
>   		return 0;
>   	case VHOST_SET_FEATURES:
>   		if (copy_from_user(&features, featurep, sizeof features))
>   			return -EFAULT;
> -		if (features & ~VHOST_NET_FEATURES)
> +		if (features & ~vhost_net_features[0])
>   			return -EOPNOTSUPP;
> -		return vhost_net_set_features(n, features);
> +
> +		virtio_features_from_u64(all_features, features);
> +		return vhost_net_set_features(n, all_features);
> +	case VHOST_GET_FEATURES_ARRAY:
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		/* Copy the net features, up to the user-provided buffer size */
> +		argp += sizeof(u64);
> +		copied = min(count, VIRTIO_FEATURES_DWORDS);
> +		if (copy_to_user(argp, vhost_net_features,
> +				 copied * sizeof(u64)))
> +			return -EFAULT;
> +
> +		/* Zero the trailing space provided by user-space, if any */
> +		if (clear_user(argp, (count - copied) * sizeof(u64)))
> +			return -EFAULT;
> +		return 0;
> +	case VHOST_SET_FEATURES_ARRAY:
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		virtio_features_zero(all_features);
> +		for (i = 0; i < min(count, VIRTIO_FEATURES_DWORDS); ++i) {
> +			argp += sizeof(u64);
> +			if (copy_from_user(&all_features[i], argp,
> +					   sizeof(u64)))
> +				return -EFAULT;
> +		}

This for loop can be converted into a single copy_from_user() call as 
done for VHOST_GET_FEATURES_ARRAY/copy_to_user().

> +
> +		/* Any feature specified by user-space above VIRTIO_FEATURES_MAX is
> +		 * not supported by definition.
> +		 */
> +		for (; i < count; ++i) {
> +			if (copy_from_user(&features, argp, sizeof(u64)))

get_user() is a simpler alternative.

> +				return -EFAULT;
> +			if (features)
> +				return -EOPNOTSUPP;
> +		}
> +
> +		for (i = 1; i < VIRTIO_FEATURES_DWORDS; i++)

i should be initialized with 0 to check the first element as done for 
VHOST_SET_FEATURES.

> +			if (all_features[i] & ~vhost_net_features[i])
> +				return -EOPNOTSUPP;
> +
> +		return vhost_net_set_features(n, all_features);
>   	case VHOST_GET_BACKEND_FEATURES:
>   		features = VHOST_NET_BACKEND_FEATURES;
>   		if (copy_to_user(featurep, &features, sizeof(features)))
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5ebb973dba..1094256a943c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -372,7 +372,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>   	vq->log_used = false;
>   	vq->log_addr = -1ull;
>   	vq->private_data = NULL;
> -	vq->acked_features = 0;
> +	virtio_features_zero(vq->acked_features_array);
>   	vq->acked_backend_features = 0;
>   	vq->log_base = NULL;
>   	vq->error_ctx = NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..d1aed35c4b07 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -133,7 +133,7 @@ struct vhost_virtqueue {
>   	struct vhost_iotlb *umem;
>   	struct vhost_iotlb *iotlb;
>   	void *private_data;
> -	u64 acked_features;
> +	VIRTIO_DECLARE_FEATURES(acked_features);
>   	u64 acked_backend_features;
>   	/* Log write descriptors */
>   	void __user *log_base;
> @@ -291,7 +291,7 @@ static inline void *vhost_vq_get_backend(struct vhost_virtqueue *vq)
>   
>   static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
>   {
> -	return vq->acked_features & (1ULL << bit);
> +	return virtio_features_test_bit(vq->acked_features_array, bit);
>   }
>   
>   static inline bool vhost_backend_has_feature(struct vhost_virtqueue *vq, int bit)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index d4b3e2ae1314..d6ad01fbb8d2 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -235,4 +235,11 @@
>    */
>   #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>   					      struct vhost_vring_state)
> +
> +/* Extended features manipulation */
> +#define VHOST_GET_FEATURES_ARRAY _IOR(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +#define VHOST_SET_FEATURES_ARRAY _IOW(VHOST_VIRTIO, 0x83, \
> +				       struct vhost_features_array)
> +
>   #endif
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index d7656908f730..1c39cc5f5a31 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>   	};
>   };
>   
> +struct vhost_features_array {
> +	__u64 count; /* number of entries present in features array */
> +	__u64 features[] __counted_by(count);
> +};
> +
>   struct vhost_memory_region {
>   	__u64 guest_phys_addr;
>   	__u64 memory_size; /* bytes */



Return-Path: <netdev+bounces-194468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959EAC998C
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EFE4A2CEF
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3513BAE3;
	Sat, 31 May 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="n5eV7MDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E7380
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748672118; cv=none; b=AB7ZFGnfMAdYt88JXcn34IdIrrPri815QgV7eGVzsDJY6X2JdrnyqCX/KbLiHqK9BSgIQh+MkGvAlOXf8t3W3R9euYMD4vHAoRY8mVht2a4fHlZUiHp55FhuYALAlt3HuA3k/dafRKNc8KtxqJ6pKLOWzcQSlDhrHHUuVKZSyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748672118; c=relaxed/simple;
	bh=JAO+jntjKh3HLfLK6yVIbyUxXC8Og4r0vlAqlwAYOj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY6JiHJFXyh0IgUqTLObnK6qeeYM8yy2jnXjpQwc4yuKsRVL5jIrShSufNrbNa1BgB2QZj3hqKutGWHohqc9P+fjPpqSNZ20apkSEZTMB8zdKuuKEScBwld4aP9VLsnVvYEChIbloFrmpnjUm6ZBh6p6fCN+vkFWi3rht/khg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=n5eV7MDo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2351ffb669cso20235675ad.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748672116; x=1749276916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4CEbBo9kOHxtt4F5lcELpR40xlCxau+7wiaQ+eXkuw=;
        b=n5eV7MDo0to3wrG5rc/hpXUJVK4j5SGmDCJFi0DPeYTXak0wCJ3sTFDx32gGz8xofr
         6gdcAJAM5mJWNcgLbcifEsY8w+RZrfBQdJFc9CN1YjpKJ5IAHs4ETE5Ntwo6SVjD7ufs
         5NgHthKMSutqJpdiVC0c5vyGf5BMpDIqA1ZWspzI75RD7ddkmNxAWkS9kD9d+V2qaZdQ
         9vDcuLfcq6d5f4YvOiMJNlsJVvJfu23XAcuAppi/HAFR6HmRjVqAck+VXZe6aNpW4uOx
         /r9KWLoG/C0KKMlEti01P2AgZkyg6W5K5dac5Tgk2dfTBA6JCiH4IHHyhrJ+K5KCpgb0
         MEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748672116; x=1749276916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4CEbBo9kOHxtt4F5lcELpR40xlCxau+7wiaQ+eXkuw=;
        b=LrYhh5Uguxj0CRDuzDneLX/tmzHRiX0cmo5WcI413XGsCV68eAcQoVDx7m8hS6As29
         zBvH9Ago/+59JI/ivpMdg81uhL64gr+T58Iq8m/Mk3taSr4G5UlFJGqypaA2cJt0UeAd
         NGBfw49pB9rlvox0MeyzYbdL8oOu2uR7unLnSrG+vd7JW8kHwggCjI35ucMXfAoKFbHR
         2Ff+qPX9Ipcq2TzyIKSjlu5L6LIfqSc1EP34MG8ljS5GL8ZJFlK/Wn4YrC4x+YW8VMma
         SLB8eGp394QqbinvsTPplx9amxk8NRrWiComIb1F40UXPD5PNJX6NQXem/5IiqSpZQon
         oFKg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ogvFlK0S9iaEecyCUB6eXGnJukLiGt23U6WkPmZQdZTXbFrmjU24vV+WHJDRWu5AL6No0rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQz4gHL6CTOdbzERWOBVaQ0gVDg8QatFGQJHJuMVuSS2cZrhNo
	fP/Ddz818VCCmnuBTPaENu7YT91QeFRlggE/tD9k9hW8bTigxf4tghzMJeWkOPRf29s=
X-Gm-Gg: ASbGncsLJtSPE8a8xe8FFAnCQSaaJaHUt20k7nomnHYUSUyZj2IiNtSnyAWVmVCdKr/
	MB6ZUNhRnSXvXIt+iPGVTLr0dRHAwiWKWaVbVAHn5YPIigi3wsM08EwYODlHgl3lq5G0TbCqK14
	0eKSvtc/drHuZzzslCyZXcbthYjkZhXNL1EtI4zzxTb3aPztuW0myw4NdDs47irjGyXxyD/1xXf
	S2Cmd8zUq+XNY2s0tBABzz7V/zFhpUcE7RNsbEBJVXmJ+zpc70iJ47MG+meTfTpROrnp+/3Gp7M
	+IdLNajys0B+nDOJKkW3YVH8kTWhamlmrHmz9E+Nr76QHQp2NWP2G5pLv/8kkg==
X-Google-Smtp-Source: AGHT+IHuiolWEMTQ9v6HviGgh78/cIDhfQ4a0S0ZzCjg4n8WUdDIXvlrmK+aXIYgcbkkclcxMEbaxA==
X-Received: by 2002:a17:902:d4c1:b0:234:9cdd:ffd5 with SMTP id d9443c01a7336-2355f74fcd1mr12668865ad.25.1748672115621;
        Fri, 30 May 2025 23:15:15 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf4730sm37240075ad.168.2025.05.30.23.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 23:15:15 -0700 (PDT)
Message-ID: <9eae960a-0226-46e2-a6f4-95c91800268c@daynix.com>
Date: Sat, 31 May 2025 15:15:12 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1748614223.git.pabeni@redhat.com>
 <b9b60ed5865958b9d169adc3b0196c21a50f6bca.1748614223.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <b9b60ed5865958b9d169adc3b0196c21a50f6bca.1748614223.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/05/30 23:49, Paolo Abeni wrote:
> Use the extended feature type for 'acked_features' and implement
> two new ioctls operation allowing the user-space to set/query an
> unbounded amount of features.
> 
> The actual number of processed features is limited by virtio_features_t
> size, and attempts to set features above such limit fail with
> EOPNOTSUPP.
> 
> Note that the legacy ioctls implicitly truncate the negotiated
> features to the lower 64 bits range.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>    - change the ioctl to use an extensible API
> ---
>   drivers/vhost/net.c              | 61 ++++++++++++++++++++++++++++++--
>   drivers/vhost/vhost.h            |  2 +-
>   include/uapi/linux/vhost.h       |  7 ++++
>   include/uapi/linux/vhost_types.h |  5 +++
>   4 files changed, 71 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..f53294440695 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -77,6 +77,8 @@ enum {
>   			 (1ULL << VIRTIO_F_RING_RESET)
>   };
>   
> +#define VHOST_NET_ALL_FEATURES VHOST_NET_FEATURES
> +
>   enum {
>   	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>   };
> @@ -1614,7 +1616,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
>   	return err;
>   }
>   
> -static int vhost_net_set_features(struct vhost_net *n, u64 features)
> +static int vhost_net_set_features(struct vhost_net *n, virtio_features_t features)
>   {
>   	size_t vhost_hlen, sock_hlen, hdr_len;
>   	int i;
> @@ -1685,8 +1687,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>   	void __user *argp = (void __user *)arg;
>   	u64 __user *featurep = argp;
>   	struct vhost_vring_file backend;
> -	u64 features;
> -	int r;
> +	virtio_features_t all_features;
> +	u64 features, count;
> +	int r, i;
>   
>   	switch (ioctl) {
>   	case VHOST_NET_SET_BACKEND:
> @@ -1704,6 +1707,58 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>   		if (features & ~VHOST_NET_FEATURES)
>   			return -EOPNOTSUPP;
>   		return vhost_net_set_features(n, features);
> +	case VHOST_GET_FEATURES_ARRAY:
> +	{
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		/* Copy the net features, up to the user-provided buffer size */
> +		all_features = VHOST_NET_ALL_FEATURES;
> +		for (i = 0; i < min(VIRTIO_FEATURES_WORDS / 2, count); ++i) {

I think you need to use: array_index_nospec()

> +			argp += sizeof(u64);
> +			features = all_features >> (64 * i);
> +			if (copy_to_user(argp, &features, sizeof(u64)))
> +				return -EFAULT;
> +		}
> +
> +		/* Zero the trailing space provided by user-space, if any */
> +		features = 0;
> +		for (; i < count; ++i) {
> +			argp += sizeof(u64);
> +			if (copy_to_user(argp, &features, sizeof(u64)))
> +				return -EFAULT;

There is clear_user().

> +		}
> +		return 0;
> +	}
> +	case VHOST_SET_FEATURES_ARRAY:
> +	{
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		all_features = 0;
> +		for (i = 0; i < min(count, VIRTIO_FEATURES_WORDS / 2); ++i) {
> +			argp += sizeof(u64);
> +			if (copy_from_user(&features, argp, sizeof(u64)))
> +				return -EFAULT;
> +
> +			all_features |= ((virtio_features_t)features) << (64 * i);
> +		}
> +
> +		/* Any feature specified by user-space above VIRTIO_FEATURES_MAX is
> +		 * not supported by definition.
> +		 */
> +		for (; i < count; ++i) {
> +			if (copy_from_user(&features, argp, sizeof(u64)))
> +				return -EFAULT;
> +			if (features)
> +				return -EOPNOTSUPP;
> +		}
> +
> +		if (all_features & ~VHOST_NET_ALL_FEATURES)
> +			return -EOPNOTSUPP;
> +
> +		return vhost_net_set_features(n, all_features);
> +	}
>   	case VHOST_GET_BACKEND_FEATURES:
>   		features = VHOST_NET_BACKEND_FEATURES;
>   		if (copy_to_user(featurep, &features, sizeof(features)))
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..ef1c7fd6f4e1 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -133,7 +133,7 @@ struct vhost_virtqueue {
>   	struct vhost_iotlb *umem;
>   	struct vhost_iotlb *iotlb;
>   	void *private_data;
> -	u64 acked_features;
> +	virtio_features_t acked_features;
>   	u64 acked_backend_features;
>   	/* Log write descriptors */
>   	void __user *log_base;
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
> index d7656908f730..3f227114c557 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -110,6 +110,11 @@ struct vhost_msg_v2 {
>   	};
>   };
>   
> +struct vhost_features_array {
> +	__u64 count; /* number of entries present in features array */
> +	__u64 features[];


An alternative idea:

#define VHOST_GET_FEATURES_ARRAY(len) _IOC(_IOC_READ, VHOST_VIRTIO,
                                            0x00, (len))

By doing so, the kernel can have share the code for 
VHOST_GET_FEATURES_ARRAY() with VHOST_GET_FEATURES() since 
VHOST_GET_FEATURES() will be just a specialized definition.

It also makes the life of the userspace a bit easier by not making it 
construct struct vhost_features_array.

Looking at include/uapi, it seems there are examples of both your 
pattern and my alternative, so please pick what you prefer.

If you are going to keep struct vhost_features_array, you may want to 
use __counted_by().

> +};
> +
>   struct vhost_memory_region {
>   	__u64 guest_phys_addr;
>   	__u64 memory_size; /* bytes */



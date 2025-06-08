Return-Path: <netdev+bounces-195536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F9AD1141
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6889E188B1A4
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EDE7DA9C;
	Sun,  8 Jun 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="O75kLpZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093DA55
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749363421; cv=none; b=aPhpvnCWWfk6aWwRQq8eFNpmPiJ+fLdo0InCbuG7WLRsQf3mHuxHAqY8v5iD3YCTFFA6MkPsv81AcGs8JTKT5hGegKxvsv/WgTm66K/kb3ArPSeVjU8icWtD2VN/eirYC+lHJLNHK5Ed9S9JyCoMHvCf7SX+ss3Ozd+vzSp5QfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749363421; c=relaxed/simple;
	bh=U94yLL7M0cU14of2wAsYg4Nb39bgM57DAIkhEYA720c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzaP4u612Ft3wG8UT+Od0VlNIiR69E4JG4YgoNiay8OVQpek2elX7v7DSYEoT5IAGJk31pwxX2DPWVy3x/rO2+ibcsb370+UUGZ6Kmqo3sNxMVWLs8zC+nXyg06kwg6TZ6gm5Yzp9HSEvKhvB2lKl62ulv2Se5Xnrgs2rH1L+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=O75kLpZJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2fa3957661so286138a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749363419; x=1749968219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGFkKRIawdsdVOEEa2wmRl67AWusHwsa+G0vSF5uBLo=;
        b=O75kLpZJmyFM3xIcNNV/382+lRhKrTS8ooio5UKuqPNjvu/J0iACKb2Dh7Q/9NHYOy
         MGVzdl9SBq4Xpj4HyqQHforH0N3O1fBj+W7puePcaFFQAhWTkyksLf6z2+uIW56CQOPk
         DswrVtmKLICJrUP9b9JUlC18e0b3lHQXAJ0NVUDxdMBEShT5zEkhaIrP/srxcrqHIMYr
         X4xLi4eMgwGvJKYBxzvvLamUb51cMXDfRiHZrq+Qweq2DDJcfMNeHbtMASNMagNj9N0q
         tHiw9W7ISR8IbWX47SUp3Bg38wNZPtviBSfwrtvrumirG2SvzDpy+VmAiTT7/4Pt79h7
         MZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749363419; x=1749968219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGFkKRIawdsdVOEEa2wmRl67AWusHwsa+G0vSF5uBLo=;
        b=WiPz2YWFLQPIAfrwRbudE4yd7ZaeiodiVuNuCk2oW7nr7YITm3Z5+dSdHi5ETt2RS8
         fBV4oMfNraKYiwlXIi3SIqTdTeg71nprHkxvkY/VpwFIfTt5bnup3ltLaYNHcl7zmFM3
         5tbkEZOtIgSdzKevHNLkUsw0YRB0wOdNiwGPPjM7fe/lK2lL7dMauZGW9Pqg5iL00uHF
         Cnl5NFA6qhqUciwQtmp5EU+eCz5ZxGVXRp2jESgcXKoVTtc+aqy1lKN++TU05Zt/ULTy
         KSAEsoAaQNQKu50Z7i1unOT4lEH5S9EG0LSFEH0h5YIZe+MoevMfHoHQ+/dAdftaK8m8
         J0yw==
X-Forwarded-Encrypted: i=1; AJvYcCUoVGnjSpWU4+YU+7b5TLts1gBzsXdfHIO4CpED/tcpKtjANAdR+h4nyAxiNBkUEWAOXi6xRSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrBoYESZUTSWh/6epE3ruobZZ34ts3WmopwVAxiReP3xpxxEh
	kucN3Z480J7N/zQhJO5r8sWJt8oWzaX7KAInVudu0I0E+ex+M5iY5TDxg1aZxPJbSM0=
X-Gm-Gg: ASbGncs6xruXZB34fYLTb2+xRP1MY2EbBInM4q2BQ9fA/x36en9v5AaN4pCECKNaGW9
	/79K/JQLwivtf9lgtO86vdMbjmgUhrp4dR1FrQcBhjEkclwyNPUw/rXHxypyiA1vt0xOmVlWPuN
	sK1nDsmoiUYQ5uMYnI8HxQQRv8sZWO0BEeie41s8RdRtCmj+uDLhUP8zvVUniSHoFO8/W7p1NVl
	upVYW9hj2H7vkzqWZUaaTYZd/5AHnBjH9k6SqyhVFC2AXgzWI5ZrvQu5BdzTnqJJQPh6BrQYyI/
	MM7JAScKprb5NjjA8MP9dBQTaUgUwW7subqgwkNbTwtPhn/Arp4CXcuykCR44FioQlAXbN1jNzk
	=
X-Google-Smtp-Source: AGHT+IG1/DgpCEanBkJkcS4z/hHF8ldU5ZalK4/sWMdwn0XZyV/mMktx2OkFCKl3MkMj+/OawD5BCg==
X-Received: by 2002:a17:90b:3d89:b0:313:b78:dc14 with SMTP id 98e67ed59e1d1-31346b46060mr14831249a91.0.1749363418571;
        Sat, 07 Jun 2025 23:16:58 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077ed0sm34758135ad.18.2025.06.07.23.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 23:16:58 -0700 (PDT)
Message-ID: <0497f70f-3c6a-4ecc-97e9-4487b3531810@daynix.com>
Date: Sun, 8 Jun 2025 15:16:54 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 3/8] vhost-net: allow configuring extended features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <960cefa020e5cfa7afdf52447ee1785bedea75fd.1749210083.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/06 20:45, Paolo Abeni wrote:
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
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>    - virtio_features_t -> u64[2]
>    - add __counted_by annotation to vhost_features_array
> 
> v1 -> v2:
>    - change the ioctl to use an extensible API
> ---
>   drivers/vhost/net.c              | 85 +++++++++++++++++++++++++++-----
>   drivers/vhost/vhost.c            |  2 +-
>   drivers/vhost/vhost.h            |  4 +-
>   include/uapi/linux/vhost.h       |  7 +++
>   include/uapi/linux/vhost_types.h |  5 ++
>   5 files changed, 88 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 7cbfc7d718b3..0291fce24bbf 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -77,6 +77,8 @@ enum {
>   			 (1ULL << VIRTIO_F_RING_RESET)
>   };
>   
> +const u64 VHOST_NET_ALL_FEATURES[VIRTIO_FEATURES_DWORDS] = { VHOST_NET_FEATURES };

This should have static.

Probably it should be lower-case too. 
Documentation/process/coding-style.rst says: "Names of macros defining 
constants and labels in enums are capitalized". Note that variables are 
not named here.

I think it's also better to remove the definition of VHOST_NET_FEATURES 
since having two definitions with similar names and meaning is 
confusing. (Just in case you wonder: GCC is able to optimize accesses 
like "VHOST_NET_ALL_FEATURES[0]" to eliminate array accesses, by the way.)

> +
>   enum {
>   	VHOST_NET_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
>   };
> @@ -1614,16 +1616,17 @@ static long vhost_net_reset_owner(struct vhost_net *n)
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
> @@ -1633,18 +1636,19 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
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
> @@ -1681,12 +1685,13 @@ static long vhost_net_set_owner(struct vhost_net *n)
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
> +	u64 features, count;
> +	int r, i;
>   
>   	switch (ioctl) {
>   	case VHOST_NET_SET_BACKEND:
> @@ -1703,7 +1708,63 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>   			return -EFAULT;
>   		if (features & ~VHOST_NET_FEATURES)
>   			return -EOPNOTSUPP;
> -		return vhost_net_set_features(n, features);
> +
> +		virtio_features_from_u64(all_features, features);
> +		return vhost_net_set_features(n, all_features);
> +	case VHOST_GET_FEATURES_ARRAY:
> +	{
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		/* Copy the net features, up to the user-provided buffer size */
> +		virtio_features_copy(all_features, VHOST_NET_ALL_FEATURES);
> +		argp += sizeof(u64);
> +		for (i = 0; i < min(count, VIRTIO_FEATURES_DWORDS); ++i) {
> +			i = array_index_nospec(i, VIRTIO_FEATURES_DWORDS);
> +			if (copy_to_user(argp, &all_features[i], sizeof(u64)))
> +				return -EFAULT;
> +
> +			argp += sizeof(u64);
> +		}

Simpler:

copy_to_user(argp, all_features, min(count, VIRTIO_FEATURES_DWORDS) * 
sizeof(u64));

> +
> +		/* Zero the trailing space provided by user-space, if any */
> +		if (i < count && clear_user(argp, (count - i) * sizeof(u64)))

I think checking i < count is a premature optimization; it doesn't 
matter even if we spend a bit longer because of the lack of the check.

> +			return -EFAULT;
> +		return 0;
> +	}
> +	case VHOST_SET_FEATURES_ARRAY:
> +	{
> +		u64 tmp[VIRTIO_FEATURES_DWORDS];
> +
> +		if (copy_from_user(&count, argp, sizeof(u64)))
> +			return -EFAULT;
> +
> +		virtio_features_zero(all_features);
> +		for (i = 0; i < min(count, VIRTIO_FEATURES_DWORDS); ++i) {
> +			argp += sizeof(u64);
> +			if (copy_from_user(&features, argp, sizeof(u64)))
> +				return -EFAULT;
> +
> +			all_features[i] = features;
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
> +		virtio_features_and_not(tmp, all_features, VHOST_NET_ALL_FEATURES);
> +		for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++)
> +			if (tmp[i])

I think using virtio_features_and_not() helps much. Instead, we can 
check all_features[i] & ~VHOST_NET_ALL_FEATURES[i] here, allowing to 
remove the tmp array.

Regards,
Akihiko Odaki

> +				return -EOPNOTSUPP;> +
> +		return vhost_net_set_features(n, all_features);
> +	}
>   	case VHOST_GET_BACKEND_FEATURES:
>   		features = VHOST_NET_BACKEND_FEATURES;
>   		if (copy_to_user(featurep, &features, sizeof(features)))
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 63612faeab72..6d3b9f0a9163 100644
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



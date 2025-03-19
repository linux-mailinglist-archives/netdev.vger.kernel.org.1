Return-Path: <netdev+bounces-176000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2C3A68447
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 05:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B18176180
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 04:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5E20F075;
	Wed, 19 Mar 2025 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="lpsUTIdY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83EBA3D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742359589; cv=none; b=NN2StRxW8Us5B/ihwqmtLre6iYC+o0mT2sreouCLaI6bFxCkGQP43X6HKlaxweTl2wCP6GF3qiNfz0YZhmAK0z7rGbLJxPDaFvgY4ncFgrJONRGaJ5XMMD/mKj8zzRAqsAWWpnO42NOaGa5T9ooa2DuubRDAbveM5FjkObi5Nug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742359589; c=relaxed/simple;
	bh=+9zyP2QzLPd0UjehZBHRR4YrRE9ZDUDwMjGPUpDhqKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKYADAYAOL+MysBQ1nfy0jgjL9Jkz8EZov5TZWWH/QDyKyVHa4i6Ftf9E8rx4Redn/TMohS8k9bkGjBOkFeXezgbMGcj3MQVAqyhIGWrdGodlCd497vCPnrFM6Sx3PeG5mOLjRjWhcatd6A2RepQ4f4egtpfLt9Cw+kCOrNRUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=lpsUTIdY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3018f827c9bso4050274a91.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 21:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742359587; x=1742964387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2U60mcEZz+UGEev480GbmTKjamMySSmqcXL7L2fzQ8=;
        b=lpsUTIdYNY0oHgUatDbnKs6w+6WPgtgmIxCTjbv8tlsQKum8awzQQo+VxIpH3VM8/T
         4wyLU2V5QLfL/5T3zX23HptRT6g6kwOvRH7aQWcrocgmGmuaOml1436fcjSca6X4DIbJ
         rqIm2O2zXvqDMGy1fzpIQF1UNRFbjKktlR+N2mTuQ9L98Uq6OW2MVXW+dsxHzOTzUD90
         qex8h9cpxz4u0H15AognPEneNtxpF+RMp9dmKbavUymQnKCkKiVlzdCwkwGKwcuJqPDD
         YqQARCNdnXaKGykJC657glNbEGTbbdZ5Y0puS3VJGBCJm36RhwfltFpGN9gMNU0Eo24+
         BlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742359587; x=1742964387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2U60mcEZz+UGEev480GbmTKjamMySSmqcXL7L2fzQ8=;
        b=wXDIlmjv2i7/vBxIPrzCBpldT2nM2v9DRgfD1H4orPViPMMW5A41rYDKhRo0pDC21N
         1nqiq0zmQtTKgorbwVqE/HS9ntEIixeQRAy2ylseIlILxKNJ7IvMIMKbV/hZhR398Lhq
         3EIN46UUllVNkTXEfffa3iFWfnHyw4m4lj8Vj8//FPLmoqOJaKi4VeUF+8T7P438S0Se
         Dunsx4NLokGMiYgrxA3jtF5rzOLfa+MGrFtiU1HZf1ro0Nis5KeDkcXfqaCN2Ap9+juA
         SOnuBR85RqOkcpg0uXjlyR1D5pXk7cEgzbwEJ7DP9PqPpEjk8n+qGccAbgB8Y3Qj3sAj
         C5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wfAIxW5bk3KLS+h/TjTuScH23uv4cpJFfc0FV9e4S0pleKWmNFwbSe/oVbcLzCu/Uvlc3RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHp+Yr2EXScTm3xUU9nelCv7rCtK+3TIx91QiOC4ApyzhvJaK
	gFyb9XPA3al4aFnV73Zdg8H8w380H8aU8WKi8uARZC07rpGdnGkichTZDPsJFog=
X-Gm-Gg: ASbGnctstqItRfdX4MuwNnmtwBhCJWlEX1GAM/cXmLCvGkgyV/fHfV1bgg7lPQsbqk+
	rDf7ihokzuKT61UMeIGOEmizQSqoHIeJrwEcH6zUYDdfiVIUbUf7F7IbamkQEloVIrUiO1grxKa
	dRk4g53gWCELK/0t8vU0dh1la9P67SQKOsMRVzYPZXxPPVwJM0QySdCpDf9e7Y/X0Z6YbSl+9Ib
	ClXuD8IxMnE3JJRe3ulXkmp9IY2igW5Sb7C+B21tjaBAMuoqLHGyDvMvRfnELd1v6dZ3H/T4hPM
	pWofAu7dndns3/8y1RaOXmWL6iSF8IT8oUq44JwQXWnWL3kZwlynVb0TYm0FTBdKFbVw
X-Google-Smtp-Source: AGHT+IEchhWvO3NJ51u4MCgKEdBI72z+tg8ef39KdCl2RxMUnvWhmbmV0ftGEJwUxPE76L0uQQVHZw==
X-Received: by 2002:a05:6a21:50b:b0:1ee:e785:a082 with SMTP id adf61e73a8af0-1fbeae911ddmr2185123637.1.1742359587113;
        Tue, 18 Mar 2025 21:46:27 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7f6e2sm10014264a12.60.2025.03.18.21.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 21:46:26 -0700 (PDT)
Message-ID: <0d694aa8-513c-4288-8562-f1bdfb66c429@daynix.com>
Date: Wed, 19 Mar 2025 13:46:22 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devel@daynix.com, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
 <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <1742347325.317026-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1742347325.317026-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/19 10:22, Xuan Zhuo wrote:
> On Tue, 18 Mar 2025 18:56:53 +0900, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> The new RSS configuration structures allow easily constructing data for
>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
>> for the command.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
>>   1 file changed, 43 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index d1ed544ba03a..4153a0a5f278 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -360,24 +360,7 @@ struct receive_queue {
>>   	struct xdp_buff **xsk_buffs;
>>   };
>>
>> -/* This structure can contain rss message with maximum settings for indirection table and keysize
>> - * Note, that default structure that describes RSS configuration virtio_net_rss_config
>> - * contains same info but can't handle table values.
>> - * In any case, structure would be passed to virtio hw through sg_buf split by parts
>> - * because table sizes may be differ according to the device configuration.
>> - */
>>   #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>> -struct virtio_net_ctrl_rss {
>> -	__le32 hash_types;
>> -	__le16 indirection_table_mask;
>> -	__le16 unclassified_queue;
>> -	__le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
>> -	__le16 max_tx_vq;
>> -	u8 hash_key_length;
>> -	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>> -
>> -	__le16 *indirection_table;
>> -};
>>
>>   /* Control VQ buffers: protected by the rtnl lock */
>>   struct control_buf {
>> @@ -421,7 +404,9 @@ struct virtnet_info {
>>   	u16 rss_indir_table_size;
>>   	u32 rss_hash_types_supported;
>>   	u32 rss_hash_types_saved;
>> -	struct virtio_net_ctrl_rss rss;
>> +	struct virtio_net_rss_config_hdr *rss_hdr;
>> +	struct virtio_net_rss_config_trailer rss_trailer;
>> +	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> 
> Why put rss_hash_key_data outside of virtio_net_rss_config_trailer?

virtio_net_rss_config_trailer has a field named hash_key_data, but it is 
a flexible array without storage. The structure is defined in a UAPI 
header, and its other users may provide storages of different sizes. So 
we need to provide a storage with our own size limit.

Regards,
Akihiko Odaki

> 
> Thanks.
> 
> 
>>
>>   	/* Has control virtqueue */
>>   	bool has_cvq;
>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
>>   	VIRTNET_XMIT_TYPE_XSK,
>>   };
>>
>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
>>   {
>> -	if (!indir_table_size) {
>> -		rss->indirection_table = NULL;
>> -		return 0;
>> -	}
>> +	u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
>>
>> -	rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
>> -	if (!rss->indirection_table)
>> -		return -ENOMEM;
>> -
>> -	return 0;
>> +	return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
>>   }
>>
>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
>>   {
>> -	kfree(rss->indirection_table);
>> +	return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
>>   }
>>
>>   /* We use the last two bits of the pointer to distinguish the xmit type. */
>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
>>
>>   	for (; i < vi->rss_indir_table_size; ++i) {
>>   		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>> -		vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
>> +		vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
>>   	}
>> -	vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
>> +	vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>>   }
>>
>>   static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   {
>>   	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>> -	struct virtio_net_ctrl_rss old_rss;
>> +	struct virtio_net_rss_config_hdr *old_rss_hdr;
>> +	struct virtio_net_rss_config_trailer old_rss_trailer;
>>   	struct net_device *dev = vi->dev;
>>   	struct scatterlist sg;
>>
>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>   	 */
>>   	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
>> -		memcpy(&old_rss, &vi->rss, sizeof(old_rss));
>> -		if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
>> -			vi->rss.indirection_table = old_rss.indirection_table;
>> +		old_rss_hdr = vi->rss_hdr;
>> +		old_rss_trailer = vi->rss_trailer;
>> +		vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
>> +		if (!vi->rss_hdr) {
>> +			vi->rss_hdr = old_rss_hdr;
>>   			return -ENOMEM;
>>   		}
>>
>> +		*vi->rss_hdr = *old_rss_hdr;
>>   		virtnet_rss_update_by_qpairs(vi, queue_pairs);
>>
>>   		if (!virtnet_commit_rss_command(vi)) {
>>   			/* restore ctrl_rss if commit_rss_command failed */
>> -			rss_indirection_table_free(&vi->rss);
>> -			memcpy(&vi->rss, &old_rss, sizeof(old_rss));
>> +			kfree(vi->rss_hdr);
>> +			vi->rss_hdr = old_rss_hdr;
>> +			vi->rss_trailer = old_rss_trailer;
>>
>>   			dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
>>   				 queue_pairs);
>>   			return -EINVAL;
>>   		}
>> -		rss_indirection_table_free(&old_rss);
>> +		kfree(old_rss_hdr);
>>   		goto succ;
>>   	}
>>
>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
>>   static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>>   {
>>   	struct net_device *dev = vi->dev;
>> -	struct scatterlist sgs[4];
>> -	unsigned int sg_buf_size;
>> +	struct scatterlist sgs[2];
>>
>>   	/* prepare sgs */
>> -	sg_init_table(sgs, 4);
>> -
>> -	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
>> -	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
>> -
>> -	if (vi->has_rss) {
>> -		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
>> -		sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
>> -	} else {
>> -		sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
>> -	}
>> -
>> -	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
>> -			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>> -	sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
>> -
>> -	sg_buf_size = vi->rss_key_size;
>> -	sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
>> +	sg_init_table(sgs, 2);
>> +	sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
>> +	sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
>>
>>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>>   				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
>> @@ -4097,17 +4064,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>>
>>   static void virtnet_init_default_rss(struct virtnet_info *vi)
>>   {
>> -	vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_supported);
>> +	vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_supported);
>>   	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
>> -	vi->rss.indirection_table_mask = vi->rss_indir_table_size
>> +	vi->rss_hdr->indirection_table_mask = vi->rss_indir_table_size
>>   						? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
>> -	vi->rss.unclassified_queue = 0;
>> +	vi->rss_hdr->unclassified_queue = 0;
>>
>>   	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
>>
>> -	vi->rss.hash_key_length = vi->rss_key_size;
>> +	vi->rss_trailer.hash_key_length = vi->rss_key_size;
>>
>> -	netdev_rss_key_fill(vi->rss.key, vi->rss_key_size);
>> +	netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
>>   }
>>
>>   static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
>> @@ -4218,7 +4185,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
>>
>>   	if (new_hashtypes != vi->rss_hash_types_saved) {
>>   		vi->rss_hash_types_saved = new_hashtypes;
>> -		vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>> +		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>>   		if (vi->dev->features & NETIF_F_RXHASH)
>>   			return virtnet_commit_rss_command(vi);
>>   	}
>> @@ -5398,11 +5365,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
>>
>>   	if (rxfh->indir) {
>>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>> -			rxfh->indir[i] = le16_to_cpu(vi->rss.indirection_table[i]);
>> +			rxfh->indir[i] = le16_to_cpu(vi->rss_hdr->indirection_table[i]);
>>   	}
>>
>>   	if (rxfh->key)
>> -		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
>> +		memcpy(rxfh->key, vi->rss_hash_key_data, vi->rss_key_size);
>>
>>   	rxfh->hfunc = ETH_RSS_HASH_TOP;
>>
>> @@ -5426,7 +5393,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   			return -EOPNOTSUPP;
>>
>>   		for (i = 0; i < vi->rss_indir_table_size; ++i)
>> -			vi->rss.indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
>> +			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
>>   		update = true;
>>   	}
>>
>> @@ -5438,7 +5405,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>>   		if (!vi->has_rss && !vi->has_rss_hash_report)
>>   			return -EOPNOTSUPP;
>>
>> -		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
>> +		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
>>   		update = true;
>>   	}
>>
>> @@ -6044,9 +6011,9 @@ static int virtnet_set_features(struct net_device *dev,
>>
>>   	if ((dev->features ^ features) & NETIF_F_RXHASH) {
>>   		if (features & NETIF_F_RXHASH)
>> -			vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>> +			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
>>   		else
>> -			vi->rss.hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
>> +			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
>>
>>   		if (!virtnet_commit_rss_command(vi))
>>   			return -EINVAL;
>> @@ -6735,9 +6702,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>>   				rss_max_indirection_table_length));
>>   	}
>> -	err = rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size);
>> -	if (err)
>> +	vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
>> +	if (!vi->rss_hdr) {
>> +		err = -ENOMEM;
>>   		goto free;
>> +	}
>>
>>   	if (vi->has_rss || vi->has_rss_hash_report) {
>>   		vi->rss_key_size =
>> @@ -7016,7 +6985,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>>
>>   	remove_vq_common(vi);
>>
>> -	rss_indirection_table_free(&vi->rss);
>> +	kfree(vi->rss_hdr);
>>
>>   	free_netdev(vi->dev);
>>   }
>>
>> --
>> 2.48.1
>>



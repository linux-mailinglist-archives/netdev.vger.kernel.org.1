Return-Path: <netdev+bounces-260861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNNSKQ3Knmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F128195806
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1049300D161
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A638F929;
	Wed, 25 Feb 2026 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqSFo7u3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t9e1us5M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296738F258
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013839; cv=none; b=CeT8oJfr7JRius0d5Ad3vrac4TAuftag2lYUd+aw/KjS+EpPbCO2NFpI4pDO9hLU7qcOL4TWRLU+QYMA3TzTq25PjK15eg6/ztxqPsBDi1ScTsXzW5zODu7KIQ45rjgas5pG4T/ujEi3ghYgg7BPdYuk61M6MjD2C6lVZ8w4HcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013839; c=relaxed/simple;
	bh=MlGwjzWpXwzqj1theVwJR7UUQV7kxnwLCrbDJttd5R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWBs+AfitMZsZwNfZiD4TTNXvgVb45npC6puDuIOVe0Bene3oM6Tdx4aNUSc6zlFeahPJVK27oqk8BwD964G1qXItkMwsO0e8ZGy//hrn4IcW3JsLDHJoGfo7f06jCF8FbcoN4XBsmGGrJJJqqovZbOQLfV50cQ5LnvPNJjM8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqSFo7u3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t9e1us5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdDT+ULPxR7vs0Kn+FgSJEXLQt+Ky2Cw9evRXmYJ0ZA=;
	b=aqSFo7u3TPDOhVRiJEOHdInGecH73KkpYWLQhACNv6pTOshgNzf2sL/Ej0JkfGd1HzlvRM
	k/VsZdZ7o6GF650vXaC0WRVw9uQrAjjE5U7/Myn/NlbYE6u6vS6IfR490DsaUOtI2Anfos
	E2r/MRnxo1OINGwKxHPqK1rTDm2x6zU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-0EjsRxztNBaw8jt9L8dizg-1; Wed, 25 Feb 2026 05:03:56 -0500
X-MC-Unique: 0EjsRxztNBaw8jt9L8dizg-1
X-Mimecast-MFC-AGG-ID: 0EjsRxztNBaw8jt9L8dizg_1772013835
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48071615686so14840175e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772013835; x=1772618635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdDT+ULPxR7vs0Kn+FgSJEXLQt+Ky2Cw9evRXmYJ0ZA=;
        b=t9e1us5MxjbgUPdNIDsBGADQj0ZVFf9J/6G1QtD40/FONFIhYhLEq8XZeAI6EBpuuL
         HG4ZYW00Jjki5sxFDOH8HvSNraEhcSQjD6vGK7Qhj9i9PwmcGcdYY0nY1pIZZPoiB45L
         4zhg1z4CpAeN0Bz6XQylGboGXg9AWzBR2eoOT8XXAbJPJ8PuNrkdIqstqY67mTl+xVZP
         ot6FMAViBXxQFD1/hJrxSiqwnXnhytuP9sG7Y4w5fTLbnqtu+QKa0CuMmC52+3Zp7Jrh
         IoGgI5BCU2OWkIAQ1hzW26QfgqZKSJ8qCn1+J61aqjsI26M2v38jORrGdCKeUHqJuUas
         4ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013835; x=1772618635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdDT+ULPxR7vs0Kn+FgSJEXLQt+Ky2Cw9evRXmYJ0ZA=;
        b=n8LkIMqrcYrE8+JTur76TivumZnYRwa+h/DYyEFaui0aPelSJC5augoxzR7/xsPUTO
         qWtvb0kf5q8iQB4MujqIQM7PxFjZXn9U8iYPUR0EplOmxyVijSK/xk1kQuLQIRzuj9NF
         8bAVFnm4vmSisUWAtKAjBVLWnr0JrXHGt/8q3DqxY8TfhRl14mJHyY2j32i0S/fzpJUp
         ZQmlwbD5RjyfQXGnewJYqrdm93VzPA3lejk6VDzGxcLds9NV8/xSDYkO7AEnHov5znVa
         T9n8TG8X/K0caRQXjrCYz0fY6AIIqHB8itlg16E3mwfp5PtlqQfsU7VH/K90Rv4EmspV
         tn3g==
X-Gm-Message-State: AOJu0YwpgmcF1RHzI+K/kmuOF90inCYXx8LGO/pbI5Ajj9L5t5X8hpfW
	96YL2pZoyvSDZpL2+xe7t2jQt//RKszka4RWJf2D818zC3ygUC4N6cJsB9gXTklWENV4VOwsbBn
	orLDTgLvWkWVlVEQqpRmulPgzwwvwynUEThNmBlZrrQiarZOu1ES0X2iPq4s40amubw==
X-Gm-Gg: ATEYQzx4DyM864Gd8zDZl999OUUQxmBmxVQUarjr7IW+aNfN8/LvBXmqbNmFtR13cti
	8pWvw8d1YE1GnIO3mbNyW5aVn6bcef1cIXChKG5GcXT5+N5A1S287KuSh2NkDmV6CM2SD4Kcftd
	l4I/z6mAym+Hil0/nLcWaeauW+2+TEpagqh/YeofZGjSDPn2VdrtWwEB0Uqo4sJFdW7rKnGGG4I
	slRFefec2lJwDTH88LS04qtW6J7Bg9rSJcjxlr3p7ugIBQwy6pvmwHT6M+PVljhGg9WI9M6x8od
	Oa7zAyN3A1aqDFGZksEkQJgY9RyDhK8tFrxmFlHWmZgarzLPTtoBODaa/uKkfpPXwTp3MU9XQdR
	3js4QbiREXKuNGsh7Svm83yZUXOiFvBEVKjoAA7K2pYnWdA==
X-Received: by 2002:a05:600c:8b66:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-483a95ed6f3mr232787315e9.30.1772013834429;
        Wed, 25 Feb 2026 02:03:54 -0800 (PST)
X-Received: by 2002:a05:600c:8b66:b0:483:6f7c:19f4 with SMTP id 5b1f17b1804b1-483a95ed6f3mr232786485e9.30.1772013833899;
        Wed, 25 Feb 2026 02:03:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19f5sm143757215e9.1.2026.02.25.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:03:53 -0800 (PST)
Date: Wed, 25 Feb 2026 05:03:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225050154-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224065850.962826-1-schalla@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F128195806
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:28:49PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Signed-off-by: Srujana Challa <schalla@marvell.com>

--- should come here before changelog.

> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> ---
>  drivers/net/virtio_net.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..eeefe8abc122 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,8 +381,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -486,7 +484,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6627,6 +6625,29 @@ static int virtnet_validate(struct virtio_device *vdev)
>  		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS) ||
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
> +		u8 key_sz = virtio_cread8(vdev,
> +					  offsetof(struct virtio_net_config,
> +						   rss_max_key_size));
> +		/* Spec requires at least 40 bytes */
> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE 40
> +		if (key_sz < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 key_sz, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> +		}
> +		if (key_sz > NETDEV_RSS_KEY_LEN) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> +				 key_sz, NETDEV_RSS_KEY_LEN);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> +			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);

you flipped the logic here and it makes no sense now.

Did you test this path?


So if device is powerful and supports a very big key size then...
we disable the feature? how does this make sense?


> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6839,13 +6860,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> -
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
>  		vi->rss_hash_types_supported &=
> -- 
> 2.25.1



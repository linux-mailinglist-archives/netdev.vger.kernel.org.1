Return-Path: <netdev+bounces-273982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNW4EaTYzGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52800376E3A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B0073007234
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADE395244;
	Wed,  1 Apr 2026 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hubbP+T3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjq95id0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778E334C33
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031680; cv=none; b=pa0OJAzXFeO1ggnwxTvp9dYUbAS5gvX66W+pqbJezjj3Nms/PrnX8mEyxpehZGu7YnoH5ByV5KYoOaGi7qMgSr0BhWaFmP9UZaHx7WaSUddY+p2PLU1iGBVPKsEv0g1UdZNEyppowt0BzP4iY5ldTPdcFUsxylFhZ+c+PjBuKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031680; c=relaxed/simple;
	bh=B5Tle2fRi76KfDMCO8D4EC6UyhUw+743wpGBNKtB0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDLz33mPHWWiBsfiiEUfXALOqCWFYXZ1OAetFWj8K/F5ydd9voHtqHB2N4/FobUtP670SzddH6OdXL7v2i8Kr8uh6iR0zXwEiZXkFG8jBQNwFJQDZXiMPThHRorsIxzRqGAU9WHYRdX6cvgBhx/6y/YoV2CmrvNwg9kabQCbED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hubbP+T3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjq95id0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775031678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
	b=hubbP+T3DqH6VmwgNZNLMgRo/DMlAsz6jqpH6AtxboKZDyt3jJwKbkMoA+G/i4y0xn6oDw
	fVh7Rwcmwb50/3G7m7fyk+4QnR5uPlodfOF0PKoSRWtegAkmLtxtNirCNbzYeDG2QdWnNY
	wY+2ow1/EZdIzJd8xIbbvhrpuo+emF8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-RUINlQsjMXWc5uJyC-hTeQ-1; Wed, 01 Apr 2026 04:21:17 -0400
X-MC-Unique: RUINlQsjMXWc5uJyC-hTeQ-1
X-Mimecast-MFC-AGG-ID: RUINlQsjMXWc5uJyC-hTeQ_1775031676
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03db814eso2183588f8f.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775031676; x=1775636476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
        b=Fjq95id0xir6J/b+Gbz7A+6NBWMs8P0GMtCNlFhJvMa/+p85jkM/u660o3lR1pBAe5
         aLtzmHE/zvDCzsKcKu42DGH0DKNHlqETcUf3y90leNzUUS89R2l6kClpql2L3sl5JXfP
         RzzFOhierK9x75yBmCy+e6PLLLUeHwuy66dwzu1lNMTL6KaUsiVkuqGSaM2MwDHLSKst
         YyfALx9dOF+8M4ZWDTqlTjMeFwPmLf/EPjNkYSjpsLISu0dHY/9HkZZVoQsGu2ESVS2X
         iD0ZtJCynmed5GxGagplb8TZcVkyCqJZoJnUXNlP39LLlp8DSiBpqVJq5c9rV14O6oZX
         6tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775031676; x=1775636476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+9bEHS3jmAexwoYuhPYmzlkbcIU24Gjv5E3vES6Edw=;
        b=bLRsn0CDP58EGOhe1bO21Dt1kq+fV+Q+M/7rmDVUcRO0cBh9P+zGpAl1CAfXBUB9Jg
         rbWqj5ilY1JuMNKLrItcawz1xiiYz3iVAC+A/L8id2S5ExUsgYrPaMUOQVgBanP2K+A/
         FqHRb7E2tldYHQqwRVhYH7CMiyUNHbwzh3prHZT2UCFScN/2N2gh3C1oMYbCV5VgsNgu
         GBMIc4DMrtMuj3FXbDj0S2J/1i0V6ZkhGg8DPM1T2XQZ08aVImdKUoqj8iZ2EUPtcAC7
         EIZMVACk4MEYylaDxjDatkcEMzI5L0x5bLK2owCthAsMljGZzN+RyDrdCpz72T0spLL1
         ECwA==
X-Gm-Message-State: AOJu0YzYfYowGklfDhBu0X3+UwoG49AvHyAtekYoe4YQKQOpVOVo5gOh
	AgaQgc+lXbyZv+UOtQrNYWFeVrilMp6rivlsuWRWKtk3OAS3wrrcq56f6I5BM3tvRmAyDiu12i6
	wbuVceUR4zPLd/Lo4xeLMpcr+iDmegykFx0HDesJQeYToKkkqPMyEB+EFHw==
X-Gm-Gg: ATEYQzz6R+sos8t9GzkjyX46nh2dmpQ27MO+3PF0bkk1xDtqKW2dRSYOB+zrtmlCMUl
	ZgshoFxzS5CBmqmy1jmFcD/fR1iQFNzi2DdF5j/VbOZ5W19CzoOzYyAN2mIM6kCLotp0KmyMLaA
	LfpSjZy4gTiOu3oHiY01L+b/xK1agAFcSM58Gx1xbJS6LI4hBNM4zIbDJFe/4KMWCdF5V/l9J/6
	A+gvIXaMI++eIIHwXxuQOJPI3r1X8miNdeVQKADV7Rz0MZy6/uIhkWUVetj/NuUe+236NAmisX+
	eZqdcnwPv1iMLTa/I6U1DQC6dVqy1mO1I6qnmJUnMMl/RJVyVS5CCvjmiHd179jLeygqozuF7mm
	9eNiiyOHQtSQsOOIc
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40333125e9.12.1775031675924;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4888356275bmr40332415e9.12.1775031675320;
        Wed, 01 Apr 2026 01:21:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e7e9728sm101815975e9.1.2026.04.01.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:21:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 04:21:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
Message-ID: <20260401042105-mutt-send-email-mst@kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 52800376E3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:53:44PM +0530, Srujana Challa wrote:
> rss_max_key_size in the virtio spec is the maximum key size supported by
> the device, not a mandatory size the driver must use. Also the value 40
> is a spec minimum, not a spec maximum.
> 
> The current code rejects RSS and can fail probe when the device reports a
> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> and keep RSS enabled.
> 
> This keeps probe working on devices that advertise larger maximum key sizes
> while respecting the netdev RSS key buffer size limit.
> 
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srujana Challa <schalla@marvell.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> v5:
> - Interpret rss_max_key_size as a maximum and clamp it to NETDEV_RSS_KEY_LEN.
> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds NETDEV_RSS_KEY_LEN.
> - Drop the separate patch that replaced the runtime check with BUILD_BUG_ON.
> 
>  drivers/net/virtio_net.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 022f60728721..b241c8dbb4e1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -373,8 +373,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -478,7 +476,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6717,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	struct virtnet_info *vi;
>  	u16 max_queue_pairs;
>  	int mtu = 0;
> +	u16 key_sz;
>  
>  	/* Find if host supports multiqueue/rss virtio_net device */
>  	max_queue_pairs = 1;
> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	if (vi->has_rss || vi->has_rss_hash_report) {
> -		vi->rss_key_size =
> -			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +
> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> +		if (key_sz > vi->rss_key_size)
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
> +				 key_sz, vi->rss_key_size);
>  
>  		vi->rss_hash_types_supported =
>  		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -- 
> 2.25.1



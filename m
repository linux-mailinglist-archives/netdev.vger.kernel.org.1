Return-Path: <netdev+bounces-257571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGIKArgChmmyJAQAu9opvQ
	(envelope-from <netdev+bounces-257571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:03:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A9FF69D
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906EE3023360
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13823274658;
	Fri,  6 Feb 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvlHaqNp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBE47soH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F3273D76
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390174; cv=none; b=gP5m7C2LjcYfk//lICakoupngAMQZWKqaQkGbWVDMZqmlbnRg28fV1qXFaLunLdoa9uJqptkemAeTsKsD5r68509pIWQ9KHirqmuCsmnnqrv4K6K30A8aK/pOXZzyopHJZfzO/qs2zss0/XFGzLkOj6hhJmXmqzMkatXi65oy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390174; c=relaxed/simple;
	bh=r9JDNy3iLGRFG7x4Aha2CU+4aaIo1+oBQFDu2MLALE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ox49b+jmGDQmwYr9CwscQc18uxuDnd5UoilT+Eo7HjjCZEZL/sIygVRnVu/NxKsV5Y7sbMhSE1hKXeS3EjnALn/iHXgUWlHYQSSujeS7d8OqMV08Nz2v/kFNt2thTXCbWG3hiJ+6eCXsxG12eGfDC2fOhPhpLfZmF0hkFORI6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvlHaqNp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBE47soH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770390172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBtTGnoiFZd7hFZAgWuXiiQbJ1BM906Q9PTZBsz7Exk=;
	b=MvlHaqNp/NnuhcbDQ6z0ogyU3iyVJkGK0I2e3HgC5tX920xGxwrv5+ulk+aF51U8K9E1xS
	MiDSTEUPyABFOi5Ue/JQMalwS2fEACk402im9UB7BApmCX0jjBNXLu/xe8YDBFA5AlVYX2
	Mq3BnMhLtMCuLjSEFEZFioVTBptD79o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-OHC7-rWPPMa4s3zbUaqANg-1; Fri, 06 Feb 2026 10:02:51 -0500
X-MC-Unique: OHC7-rWPPMa4s3zbUaqANg-1
X-Mimecast-MFC-AGG-ID: OHC7-rWPPMa4s3zbUaqANg_1770390170
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so29623535e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770390170; x=1770994970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBtTGnoiFZd7hFZAgWuXiiQbJ1BM906Q9PTZBsz7Exk=;
        b=jBE47soHOvYQUjuDKZoCcMLnsQFwAo5Pc2S9hFginwpcgobbz75MExS2cymz1EzfCM
         +m1IRlQA3MiJOaI3N08RPMiEGrOFQAs9Y4bEUe09+RMnSKTlMwDnms+YmVpVISIQ3itM
         mCaZ8CT11fxB4vVYqbecm+oP5IQaHQ0dP+U5/Q6lWRUqLSJKO+0ETaB2mDWtgoC28aNv
         c8dKPBfrymAEPazrjogR5XIxyFD0xZQxmSEjfQ0uE9rbnM0ePb1nl3UtYW+JbZ1Hg4yS
         clDR747QY9fm2khxB+0Gks68ZjEEl72YS3tsdmEpBKT+ViG+pl/OoqHJ3wRnTsHjIUoG
         /pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390170; x=1770994970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBtTGnoiFZd7hFZAgWuXiiQbJ1BM906Q9PTZBsz7Exk=;
        b=e+3jAgM3V74oTcY6JgkWAGQLW6lZbkpU5hYOUHLZAHQPljpPnB1ciem4005WIUa8Ec
         25JXYcIuPJqHBlaR1PpXtDlGpOfRsUYXqJZKIC5lkfsVQp0NbUPYM/IuyVs4X3ABuomZ
         b7/byBoP1kDSXKSEJVScASFVpnaWarpTcAijMA8mwE0oTl+oy2YZSg4k0wOzvNCiWJAP
         uWXH1du/pAvUEFO97aNeafwxlgMp7XRZXE/0dfRN5uw6Gi4niqXS8RLsjzO3pEbCZ6bs
         3N19dHXhmpH0sIgF0BI3UJd1uunxPaq2v8nW1eQRnJDbN3dRF1yhYLE9c8dfff9pEhXP
         buSA==
X-Gm-Message-State: AOJu0YyTZqarf+Sm/hIVSsOS5qEVAvsGw8hUHHupChjldJXN9SZ9Prge
	fLvNnyeEs6zWqiv9W5jYrQDinM3Mg180V59EVkDkCq5q+H0B27N4LzHv6b6oH+aHllC38UIGz2B
	Ub4aYJLaK1jNkl3i2BHIsrGvTgjGpeUDPoWZO3+Um2XZXxU7eFbAbs/Q5sdbFwx2Xag==
X-Gm-Gg: AZuq6aJ1wi/3DS5Ih5yCzBU9wOkljJ8uYbADNs4LnfQ9DGC0lMg6+eP/xWzDIY7PNPC
	cH8Ka7JEjRDkqkVS3uz2UJ2tR/zAlVP23uaNiEe6awCqSG295+RPiKIRkvSEYWTahD4D55lI9nE
	XBAvsSeyM4lKxg3DlCbXs7nYZyuQWmqAPBnoWrmZhzCh9lh1eUmQfrpZVJGKO/SGlArI6sKe07a
	iAzR0RU9i8H5AOVaks1t/2iApn/wsI8fbn7wLpKpjXwM660wVZc7xxPI8OxjxhJTFWQpLCa3nyJ
	R2THPllTv5p0PLgvsNXWsfCH4XNVjIgfavN5DfsK1DWX/fMRWl4Edw1m47moi7apoHa6Q0QEaeG
	Bq+m9E+e+Z0E2jl1234WoDHrL7QKjRuIioQ==
X-Received: by 2002:a05:600c:474c:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-483201dc4efmr48039035e9.8.1770390170105;
        Fri, 06 Feb 2026 07:02:50 -0800 (PST)
X-Received: by 2002:a05:600c:474c:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-483201dc4efmr48038395e9.8.1770390169571;
        Fri, 06 Feb 2026 07:02:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm122985135e9.2.2026.02.06.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:02:48 -0800 (PST)
Date: Fri, 6 Feb 2026 10:02:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com
Subject: Re: [PATCH v2 net-next] virtio_net: Improve RSS key size validation
 and use NETDEV_RSS_KEY_LEN
Message-ID: <20260206095859-mutt-send-email-mst@kernel.org>
References: <20260206120154.2548079-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206120154.2548079-1-schalla@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 5D5A9FF69D
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:31:54PM +0530, Srujana Challa wrote:
> Replace hardcoded RSS max key size limit with NETDEV_RSS_KEY_LEN to
> align with kernel's standard RSS key length. Add validation for RSS
> key size against spec minimum (40 bytes) and driver maximum. When
> validation fails, gracefully disable RSS features and continue
> initialization rather than failing completely.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

I'd CC stable on this actually. failing when device is more capable
was a bad idea.
can you add a Fixes: tag, too? Thanks!

> ---
>  drivers/net/virtio_net.c | 62 +++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..1fa4197dffc3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -381,7 +381,8 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     NETDEV_RSS_KEY_LEN
> +#define VIRTIO_NET_RSS_MIN_KEY_SIZE     40
>  
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
> @@ -6823,38 +6824,47 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>  
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
>  		vi->has_rss = true;
>  
> -		vi->rss_indir_table_size =
> -			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> -				rss_max_indirection_table_length));
> -	}
> -	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
> -	if (!vi->rss_hdr) {
> -		err = -ENOMEM;
> -		goto free;
> -	}
> -
>  	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
>  
> -		vi->rss_hash_types_supported =
> -		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> -		vi->rss_hash_types_supported &=
> -				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> -				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> -				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> +		/* Spec requires at least 40 bytes */
> +		if (vi->rss_key_size < VIRTIO_NET_RSS_MIN_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u is less than spec minimum %u, disabling RSS\n",
> +				 vi->rss_key_size, VIRTIO_NET_RSS_MIN_KEY_SIZE);
> +			vi->has_rss = false;
> +			vi->has_rss_hash_report = false;
> +		} else if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> +				 vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> +			vi->has_rss = false;
> +			vi->has_rss_hash_report = false;
> +		} else {
> +			vi->rss_indir_table_size =
> +				virtio_cread16(vdev, offsetof(struct virtio_net_config,
> +							      rss_max_indirection_table_length));
> +			vi->rss_hash_types_supported =
> +			    virtio_cread32(vdev, offsetof(struct virtio_net_config,
> +							  supported_hash_types));
> +			vi->rss_hash_types_supported &=
> +					~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> +					  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> +					  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> +
> +			dev->hw_features |= NETIF_F_RXHASH;
> +			dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +		}
> +	}
>  
> -		dev->hw_features |= NETIF_F_RXHASH;
> -		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
> +	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
> +	if (!vi->rss_hdr) {
> +		err = -ENOMEM;
> +		goto free;
>  	}

I feel these checks belong in virtnet_validate. Then we can disable
features e.g. by clearing VIRTIO_NET_F_RSS and host will have some
visibility that RSS can't be used.



>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> -- 
> 2.25.1



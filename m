Return-Path: <netdev+bounces-156557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E59A06F1B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A0618894B1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA52144C8;
	Thu,  9 Jan 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRUXNw7r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD628F5E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407951; cv=none; b=LClVuDR7v4Nil/NHnV0sDz4QcjnwmLf6c3dKc7nFXm/pYhLESVuN/6CV9pt2FchPctioELvNUdxZBTkjzNOoYcJ+37FA1kC2nQ5f5tBp0AgRG9s6ILOB5mdwjSafKO16ql7dlW0ezQRgITgktJeN8ccn7Fk6g9MwOdo+N1LXM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407951; c=relaxed/simple;
	bh=5UbUHUDUA55r0nK5d8Jha5yrj/zO4cmMTkO+X7Cu5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0TUin5OcHJpYfomQhwe90hUB7o7mx4bOoqzKcHcXsXxK+Cn5OvZmlQcuvGPEUD4L5Ysl41XKgD1bLhFpxGk/dMABDcmC0lSe2nfkI4xAfty1ptclM3uzde+BB0vf3LIQDmFs4mzswjLOt2KMoLcKFRMRBW2fcjSUudtnI3u7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRUXNw7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736407948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXSR6q6tyKylmweELFbBP+9GVq64q77ZdCgNpskFR5E=;
	b=eRUXNw7rSVjxSZFPKHJu/XNPnO3TVWaRt/sIQMVXy9gHNYWlh4/Qu3s/Ctq0GxdSdY+aTe
	nZIMOu7hDkn3PObCF1zxMbXmsLgFTcnEYFzi/UOc8cQB8Xn/hXrJy6+7Dzg8umEhQb77bk
	0exx33Yq+g1DqvXwOaIVIzPuA2q6mX8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-6eS1uGxLP2Wlz977K35hxA-1; Thu, 09 Jan 2025 02:32:27 -0500
X-MC-Unique: 6eS1uGxLP2Wlz977K35hxA-1
X-Mimecast-MFC-AGG-ID: 6eS1uGxLP2Wlz977K35hxA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab2b300e5daso60525666b.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 23:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407946; x=1737012746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXSR6q6tyKylmweELFbBP+9GVq64q77ZdCgNpskFR5E=;
        b=OMhZYHnbWdIh6YC6vDezxQFjWMFX7C0fe3HlSmtsCGk6FHlF2GnjQhFIWabor0qxD1
         /mUIgk+kSLh8AoGBfzJZf/FPt8WzZSKtnhwwNqK8k2JBd+PTkQMibXP3UHvRXiCjjuKR
         six9TmhJHjR2l6877FiKTmMdxsa1PTWdBcLibhbasLTa+lSJ/s0uhKZg3zXd+qJ5SLHd
         p4DCwsgTVpoTDHyIQPDsp3FuWrkKGnI+xnOJytyKA4f14M0rrDyfY9yyZYjXSnRU5/OX
         GE4IbXtsryxgX6OioWqImDquBPF5eewwgswnnFY2ak1xMbj8uzVBglctQZD/Q77nxrqR
         RP4w==
X-Forwarded-Encrypted: i=1; AJvYcCU52DmG68xvYuI7i9yYun6vg4yMAd4fZXGvmjQ8DIpsnk8JHluTEeGF3JyNsuwOjFO7tXgM5ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAc8f1PRnDN7hW+PwbIjdbR937gAlTjqp7zW3BF8nDjyQpi4I
	q4yQTzbQ1zNZAACwzgN6y2OpX+KtxIK5hZIpzI92wILEYbkHFu6NYViI5pfd3zo1dtsIXhiMbk9
	XRRZjZDtZnYi+wxsa3ItLpAwl9UD/qk8y6vChY6a/quwUYSuUwEJwrw==
X-Gm-Gg: ASbGncs/uTwPdpZU/V7VKhYkalbq8j7iakaiTwTAeT/eZ8QjQLsZyYVysJ6OP3T5yIr
	IlE2qzofvhnujVma9OfGcsFP6MofO7U2daJfDJltuK1jEK80N7Q3u6QRYCq5rshxAGrPhI1dpm6
	HpgTZUngked2i9QOambEvs1VgSvLovqYk0SgsG+LppBTx0gscxI98ThqdBvpQtf2+qKDHCxSKtl
	t9OncuI7a09U19Lrf9WW0l9c8mMKPVqIPFbxXQY+mbOfA/Hq4Y=
X-Received: by 2002:a17:907:3687:b0:aa6:7ab4:4597 with SMTP id a640c23a62f3a-ab2abca77a5mr543843266b.39.1736407945904;
        Wed, 08 Jan 2025 23:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhA9sGH/7wRh3dK4PkGB9iJkH6oEUW3xYeKZu2VsLICT8lcRMG971KDIhNk+uyN4aFtn0oSQ==
X-Received: by 2002:a17:907:3687:b0:aa6:7ab4:4597 with SMTP id a640c23a62f3a-ab2abca77a5mr543838266b.39.1736407945404;
        Wed, 08 Jan 2025 23:32:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b0ab6sm41300766b.155.2025.01.08.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:32:24 -0800 (PST)
Date: Thu, 9 Jan 2025 02:32:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
Message-ID: <20250109023144-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-tun-v2-3-388d7d5a287a@daynix.com>

On Thu, Jan 09, 2025 at 03:58:45PM +0900, Akihiko Odaki wrote:
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


How do we know this is v1 and not v0? Confused.

> ---
>  drivers/net/tap.c      |  2 +-
>  drivers/net/tun.c      |  6 ++++--
>  drivers/net/tun_vnet.c | 14 +++++++++-----
>  drivers/net/tun_vnet.h |  4 ++--
>  4 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 60804855510b..fe9554ee5b8b 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -713,7 +713,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr vnet_hdr;
> +		struct virtio_net_hdr_v1 vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dbf0dee92e93..f211d0580887 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1991,7 +1991,9 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  	size_t total;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr gso = { 0 };
> +		struct virtio_net_hdr_v1 gso = {
> +			.num_buffers = __virtio16_to_cpu(true, 1)
> +		};
>  
>  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>  		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> @@ -2044,7 +2046,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1 gso;
>  
>  		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
>  		if (ret < 0)
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index ffb2186facd3..a7a7989fae56 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -130,15 +130,17 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>  EXPORT_SYMBOL_GPL(tun_vnet_hdr_get);
>  
>  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -		     const struct virtio_net_hdr *hdr)
> +		     const struct virtio_net_hdr_v1 *hdr)
>  {
> +	int content_sz = MIN(sizeof(*hdr), sz);
> +
>  	if (iov_iter_count(iter) < sz)
>  		return -EINVAL;
>  
> -	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
> +	if (copy_to_iter(hdr, content_sz, iter) != content_sz)
>  		return -EFAULT;
>  
> -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +	if (iov_iter_zero(sz - content_sz, iter) != sz - content_sz)
>  		return -EFAULT;
>  
>  	return 0;
> @@ -154,11 +156,11 @@ EXPORT_SYMBOL_GPL(tun_vnet_hdr_to_skb);
>  
>  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  			  const struct sk_buff *skb,
> -			  struct virtio_net_hdr *hdr)
> +			  struct virtio_net_hdr_v1 *hdr)
>  {
>  	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  
> -	if (virtio_net_hdr_from_skb(skb, hdr,
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>  				    tun_vnet_is_little_endian(flags), true,
>  				    vlan_hlen)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
> @@ -176,6 +178,8 @@ int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  		return -EINVAL;
>  	}
>  
> +	hdr->num_buffers = 1;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tun_vnet_hdr_from_skb);
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 2dfdbe92bb24..d8fd94094227 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -12,13 +12,13 @@ int tun_vnet_hdr_get(int sz, unsigned int flags, struct iov_iter *from,
>  		     struct virtio_net_hdr *hdr);
>  
>  int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -		     const struct virtio_net_hdr *hdr);
> +		     const struct virtio_net_hdr_v1 *hdr);
>  
>  int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  			const struct virtio_net_hdr *hdr);
>  
>  int tun_vnet_hdr_from_skb(unsigned int flags, const struct net_device *dev,
>  			  const struct sk_buff *skb,
> -			  struct virtio_net_hdr *hdr);
> +			  struct virtio_net_hdr_v1 *hdr);
>  
>  #endif /* TUN_VNET_H */
> 
> -- 
> 2.47.1



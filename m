Return-Path: <netdev+bounces-242103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEAC8C5D6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B538635113E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8B2FE050;
	Wed, 26 Nov 2025 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grg5eFv8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cU5hB8Sw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C4207A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199886; cv=none; b=kaPVtTbDLtOL2FRT2WAiIgGP3GLO0Zg1kU6b8qSvnDpQrwQXoxGescLSWucUnb8qN5EfhOIgtZyFDiXhGuK306VgV6cZXKBDiJiBbiBDfxKuabu3Jjfd9fkyFfY1QcteZr1seIynnzU/xQeyYXt2/EhOjg9jqULD/xpCkJISb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199886; c=relaxed/simple;
	bh=yFNIi8DTjY/UB56wGpgXzrHmqQnS+mB0/nAhgkygiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzMi7rgnwCdGF0t2lmJHJzwv6tjibS1yERNkT86aPJe0raUmPKjAgUXUftO4b4Af0poUO506f+dYoeqOKcv2nAM6FePxeUHWiEZ/Tw2v6rGzKZiHzgvE7ipCxae/E1ilZsbC0foxlJ+AScVEgh8X6+Bh4IA7AK2+F2mA3wqrimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grg5eFv8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cU5hB8Sw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764199884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBj4v5CDhCaSOnmP98D4k4FodyYHO+5JcI7F7kgJOdE=;
	b=Grg5eFv8C6L/i7IfzxByVuUHjWoFp0KJCWtbtVl2x4ZcOgBnI0lZ0IHTis0U0BXLj19UT7
	TsFmCKnK+hpeKNVNDAHjAWFYpZRMG6ZEFgZwfPz/QhggazVP7i7k2eTjLHfIWHF78HtcT2
	356kIe9/tUs/9LSOxRPl3LoVsYm3tGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-0HTH1VpNNMOInyjAWCihaQ-1; Wed, 26 Nov 2025 18:31:23 -0500
X-MC-Unique: 0HTH1VpNNMOInyjAWCihaQ-1
X-Mimecast-MFC-AGG-ID: 0HTH1VpNNMOInyjAWCihaQ_1764199882
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563a0c75so897865e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764199882; x=1764804682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBj4v5CDhCaSOnmP98D4k4FodyYHO+5JcI7F7kgJOdE=;
        b=cU5hB8SwoLMawYGmK2ZPn4pR3i1vJnTACF19BRwBMqRwiRhKgJbEE4cj+vReXlP5qB
         xULmeyu1ZNI/vSYMc08s6h2hYqPpgGeEoOEapljV5hHSe47F2e3cJaUbEDZjRcjQXll0
         sbSsOGouIpAX8gaglt9Y35ODOs6sTUKAojENidbMjYG7zZapjUYqHA13sN+xAO0GH1dI
         iw+lYSp153LfZAVyLHmimooiV9pUR4luoNvNLdYtMofTZw6tBTO3T3vrd6lOfu+y8C/M
         f/1YJCk/COTax43jVAB/u6L3z3gdrtby1mOY1X0FHAKvWLXqjCqPj1v4ze1d2gHOCrAV
         44BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199882; x=1764804682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBj4v5CDhCaSOnmP98D4k4FodyYHO+5JcI7F7kgJOdE=;
        b=nzorz9FKTp+rEh+iaMPYPm9nXhopWCggQVHMUgBSIPw2LM1yoLDPruG14lmDNtvjll
         WHOnNub0SYKcyeBq55xNrngZigt9+80SRPvRo3qv1bfws2lM+WrLmLwrTGYXNrY9a4Xg
         NJWMcc2viWR53V8aA0cr8A2agwTCmmYGF9lU8Qhf+4KG8GTZUGOe/NteAGjnR6ND70k8
         CjBa/0MeApHxicV9V439wjIMQzAPgMo6a+BrZEY6Bj3jUZkYLzA6VvrhuzYvd0PLELlt
         BMuG1UJH7+xamZQ4A276ajBGvdHJAJVzdo1hcZc7hOqoU4vM+WaR2lFlczDDRV4dDVqr
         1JNA==
X-Gm-Message-State: AOJu0Yy58i11R/d1J7f+BWTRV3ro88ufq8TEN7sA5tdpRK1DmIr/kyHR
	pjfpqlROBLXRHEsCT6Njf7AZb5/qInbXQumNdHB4IVMywEiC3L0eAIE22IW3meozidwX1wgs5a1
	iSavYZIrczjTTac7CwtO/BGrZK2T45rhHPKb3HeklVI2R2o+RoE44oUFipA==
X-Gm-Gg: ASbGncurffygHHzifSGCwBiA+c6Bzfrp1BALYLb4kuFwmugPxpJPM9e0qivueKYgg6R
	RYYTBwqkLP5QNA3nlGVrALD3ASh+9BlpSZ9nhvwPCNDROAWx2LSWfIRZ/2tYygNFZ6uRAaGyTpg
	6UJTXdr7JLT5SZzGK6pY+S7SqdMCcBIXAAp4r6UIypX/IzKOUmBZyukXDkkW5nGksuNcwSDaaht
	DSYpsKMicd0d+lpZgCfeamQuVNaVMNL6bg2IiwzjF6wZv2YkLUKEu+KZUA28ZLnC3ksJCSA+aM7
	evoFSxepNYbwrIYbc6JdxwBdURNjPeKOlOX/T9kLcaYsg+7wYVrq7GWca2ZhlVKKxfDxx+1h4qq
	Z3X4XS8vNZNK3sjfGETl8k+SFHZ4ohA==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr23815445e9.3.1764199881842;
        Wed, 26 Nov 2025 15:31:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvsPc8i4qlwSOov+ZFIUbJXh0qRN5MOs/+9Y7azH6GR/o2n03YQmnKCjFnc5uZOpB6h284EQ==
X-Received: by 2002:a05:600c:21cb:b0:477:acb7:7141 with SMTP id 5b1f17b1804b1-4790f03337dmr23815225e9.3.1764199881338;
        Wed, 26 Nov 2025 15:31:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm52884525e9.2.2025.11.26.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 15:31:20 -0800 (PST)
Date: Wed, 26 Nov 2025 18:31:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251126182919-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193539.7791-6-danielj@nvidia.com>

On Wed, Nov 26, 2025 at 01:35:32PM -0600, Daniel Jurgens wrote:
> @@ -5812,6 +6019,17 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  			return err;
>  	}
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	rtnl_lock();
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		return err;

does not look like this rolls back previous
initialization on error (probe does).


> +	}
> +	rtnl_unlock();
> +
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> @@ -7145,6 +7363,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	/* Initialize flow filters. Not supported is an acceptable and common
> +	 * return code
> +	 */
> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
> +	if (err && err != -EOPNOTSUPP) {
> +		rtnl_unlock();
> +		goto free_unregister_netdev;
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -7160,6 +7387,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	unregister_netdev(dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  free_failover:
>  	net_failover_destroy(vi->failover);
>  free_vqs:
> @@ -7209,6 +7437,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	virtnet_free_irq_moder(vi);
>  
>  	unregister_netdev(vi->dev);
> +	virtnet_ff_cleanup(&vi->ff);
>  
>  	net_failover_destroy(vi->failover);
>  



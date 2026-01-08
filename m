Return-Path: <netdev+bounces-248098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32844D04781
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7442433626EC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78DB3D3CF0;
	Thu,  8 Jan 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMv34wXl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9sH7pR8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F083587CA
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881321; cv=none; b=fH4aI0COIyWfkoIA8H5dFAOBTwXP4spNuM59NyMl+a9ZxhEdqcpSPutpsi5G9qQQCRce9pBSG3PxBoJpDzH2pO8k3e9PR4ZJwieI/620/bAXb9ZKrHLb1q/QfeEAfoMBpFmvfJJOV8YS9FW8MZMS0p45OKYDf5mUCSWavRi2Xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881321; c=relaxed/simple;
	bh=Tv7zh9Hk92kdNn+K2fPlpE9fTBNWYFWSvOonEurgOJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufWKuQVD4YjXO7TKARKK6axgEj3quvLjRjJ4YpQ61JYv4elAamkEw48OhCagg3HxJ5jGYZ4fqfd/TmVGLyd3suh/lfLMDPjxymqEqiyUH+hxEss1WgwVbmzbzcz39eEQW8yZ+/B+1wjDBlYInOqK7RsM6OV5EWxEorj1KwAjgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMv34wXl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9sH7pR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qb0opi0EkMyYcYBrprImauJ5+csaYa0bSdovEgtQBZs=;
	b=JMv34wXl46/FnDYIPBeZ51sXipwgk6pezAGY39bqTlzPzqGLwhRvYA/iMaoSBPaRx9mLmE
	WPsMmMtnHKxBdSGceUrsdOCiOOR846ppp2hyrm4iDkWlsJ7yXyPyGNQfRhlC14giF8oheA
	VeRS8FI//u7LGUMkUMyNIwT1lF2XALc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-X5YX-6LrOhOPE4U8WKmCyg-1; Thu, 08 Jan 2026 09:08:38 -0500
X-MC-Unique: X5YX-6LrOhOPE4U8WKmCyg-1
X-Mimecast-MFC-AGG-ID: X5YX-6LrOhOPE4U8WKmCyg_1767881317
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7cea4b3f15so486705166b.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767881317; x=1768486117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qb0opi0EkMyYcYBrprImauJ5+csaYa0bSdovEgtQBZs=;
        b=F9sH7pR867jA/rHKxKKU/wpVji4GMqf5bUfz/vL/UajgRxivMXVN1rpc+bMD//MFem
         1/W8C34QuRmQ49nrCPu280beltecWuHq1ZHRIhey8IRNXFSJwnwFmr3n1XCxadOSXRTW
         aRQNsTndJZfe/+athyPIXMVHIHuJKSXtdJcQODBjYfw2l1dt7fi3IziyM7jZfem9OIs5
         Ui5Cc5tJJak48o9XioaoIpsOvshER1DSGt9a+BAUtuf1sUYim4U62vGBvUppT8EKllKD
         hjquDst3yF/i2CRxsABHhuJZQc8Q7GPqdOXx4evG9W63gV86858VQhDj57XNG8g09u5U
         QDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881317; x=1768486117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb0opi0EkMyYcYBrprImauJ5+csaYa0bSdovEgtQBZs=;
        b=JtDbTf5k23AG1pNo9VPRI/zcQf8BIHtI7DVypuRVNHPcuuCWrZe7q/WcOEnd/AxUxE
         DmG5qB3JV1lhee8wA9QIYubsVyJg3iMgnSIoCZnp8/bl/sy4kZI0EcmKuPWMN5qsC09Y
         wL137tVjv0CNqTlFUPxXkPn5oqbw/6YGPqH+C7RYCnDydtVTQT/2q+jI/tarAsM4oasv
         XR1Y1+K0aHr9OdjSnOpx07eQQx0Ph1vcRaZ+xC9o12NuTQNUo9kVpKWrFAcRbZOA2VM/
         /vfSYMKxjuwpWlZoLm/YrT9vDLdB+CQHLiQ5zCcKXGXlhyerszXGkhRHPpWb3I3rlSxJ
         T8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlM7ba4KFKW77FLvSuwqlCjeGUVPH4YIdoIF2b3vTGVNhJRHuUOglj/jy3mo4NiG4llaXRbXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfZ/wz1mxTdh5K/gsbrCsrj4s65Gzgolvnsonex164l1uDyMY
	zrvwDix9IHCv64v8GDG94rQRLM9IaFopsGGCwlHv2oWihHkw7zjRlBs1FmQxQMZrjLzW4RKoo8A
	Pee+hdESNwcCpxTvgR3D2sntq8GcIgrC5Y4swAcbsibBK0sWSCbsSnvqFPA==
X-Gm-Gg: AY/fxX6Xhbnt9YwIs9jeNf0u+i9vA8KHHlZCefJ23yZneu9tSMz0M+Te5bgoKdgQdj6
	tXWjODjfhlfZA7bdsrJXiAxO4WimxgsMaINDm1iVTzcwJO/avhxqk7aDOydOgIwhlzkmNsDLUZZ
	HF7umSSG3ecKbG2foUnB7IbWli+H8uyoG8WwMo/Om1fkgHdTwXYPr7K9ydG3XsPf8pUzEWiUKtO
	pWzdhVIEGttxW20tm+4rlwO0t36asRCwkfr/hXKLWv57SlmbmBYySkTfGDnrqpNxEf1QylApfXF
	3DTLkkUJ4C68msjqbUFCPmzGYJzhzm9f3Ga/548iq7drUKi8IlIZ9zo79hc7EJoxMZ+SdwCYK+8
	l9y9IqhmqGpa8OROg
X-Received: by 2002:a17:907:7b89:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b8444fd453amr620663866b.49.1767881317022;
        Thu, 08 Jan 2026 06:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7HOHiWGYK4xorotJbNX0jMidX1ixXQJJ1VdDBrRK+mMgTkrWVhdGn0FKO7KNa9bc9HZtucg==
X-Received: by 2002:a17:907:7b89:b0:b6d:6c1a:31ae with SMTP id a640c23a62f3a-b8444fd453amr620660466b.49.1767881316491;
        Thu, 08 Jan 2026 06:08:36 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2cb447sm843387866b.29.2026.01.08.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:08:35 -0800 (PST)
Date: Thu, 8 Jan 2026 15:08:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 08/15] vsock/virtio: use
 virtqueue_add_inbuf_cache_clean for events
Message-ID: <aV-6UTKChBhiTynA@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>

On Mon, Jan 05, 2026 at 03:23:21AM -0500, Michael S. Tsirkin wrote:
>The event_list array contains 8 small (4-byte) events that share
>cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
>this can trigger warnings about overlapping DMA mappings within
>the same cacheline.
>
>The previous patch isolated event_list in its own cache lines
>so the warnings are spurious.
>
>Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
>write into these fields, suppressing the warnings.
>
>Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bb94baadfd8b..ef983c36cb66 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -392,7 +392,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
>
> 	sg_init_one(&sg, event, sizeof(*event));
>
>-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
>+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
> }
>
> /* event_lock must be held */
>-- 
>MST
>



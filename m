Return-Path: <netdev+bounces-246430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61D6CEC0E2
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F221D30517EA
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BF922126D;
	Wed, 31 Dec 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f+D1ouYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE01DE4E1
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189727; cv=none; b=moMF2pkGA16x3s60B7GFkw2EwqSKSY4/8DKjeDUMCLKskv9dh9Zs5SMKXwIDGWOs7IobQlswDVhrs2m/f7IL5ygnMRoR7C2wXeCACt11PjNcChvyn//DcpbljkGLmTCgwzxDIgKnEz80A6ed+H5CY4YBzOpx5O7WP1cBVPcEfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189727; c=relaxed/simple;
	bh=4Hf8qGAfIDnMbElA9BV7uSYKEWjXXxN6zt+BgVtPhAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyJfOzm2hk0c29ov0u/daBWqSrU6mUZgX19PrHCjbj00SDCVaM9/ORh+E9CiYzBe9HMmmCNjAkMUNa6VEkSAPUs/1BfxqJI487eTdmuTgxmebbBiTJvS7AmIVX1fdfcxg2ZBwvSrCgCkhYL5lxaP1zgZBsrwFfKQfq0yzOXXaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f+D1ouYW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d211aee52so7052635e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767189722; x=1767794522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=f+D1ouYWMJ1UqzYlbVRrds9ZuhaEIzCognWhf5Hu9rZQP8kr2ApNEsiqTRT3GYMeoV
         sTa9PyUVAVWltZHod9NBZo07NQd+5X9JlqWSrj09UZkyQRmOcSZz7FHyCxDN1cHTuFnp
         yIsTYnwTIVGyyvBw7kvXeM4S9Nyho1/0zeDYA+gEBae7mjBOy/Dh1XEYjZoCh83ekN0m
         1WgXXsYEkystG5HLfaWousHU2nAfPYVcQpyxiZPu8DYAEnVP802z6Uer+QJ1WyElaMky
         7vjHK6ou3VoLPXT8CfAA9VJ6V/eJcyxhmOgh9Tf6u1z60ZC3+EaHXb49xMq5eeOIPt6f
         iDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767189722; x=1767794522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=ZpejPlXDAdQlkKop0cHRemwo0SDbKm8Nb3O0jSIanp1tXQWOD/MJX3z4daafOYv4A4
         kBgU+9C5lZEe6kzf00wqq7QM4gPYHJ38S+MGPeiJyt454DCUirnvrf4e+rvHkq64cJBN
         UySlFe0GhJkBw6ScpDf+2NSVzWwpRfmvgCkTevsh3yGLJ+2yOYTT6g1OYJc9upkwMNy8
         mJqBdGr+TfCndYE9kTkODxmmiymptGPT1OmSmAmnUreTZUldMSy4ezEKAkJQU/PHEK2I
         f10NIHPfWLV+LCa1bQZRINTAofzAgc84usUFf3kKboKYiZh9igktSML6JPChZy0oIqWi
         OlQg==
X-Forwarded-Encrypted: i=1; AJvYcCV8aZhKWVrLZRh6o1Hf48h2PNTOzLxKGht9Ugxk3FsAwMum5NDLmAYBJMH61exbLn27FCTXzQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJzj3PyoFr5sWv5lrITWFS/ZCUzLCISBzda/RDc0XtuAKi1J+
	VgRVvV7lA+QZe+Eb6GQnYLR8Annt0I8st1CbTGWGWn3uHpC4C0y7nBssr7DoV6gYBxI=
X-Gm-Gg: AY/fxX4EzTMVUxq47pkCD9xhT1SRWE/fbZflTHNxVd5Wsg4vHVq9f7MDmTyEHq6qV/y
	bf1Dso6t7ZcrX4zpIEgqEN0QaRxhQ1+w+/iUaLdEFTz0/yo14t/QqLwHbPVpb5A/M28Mh1zlHaf
	ekQSKg96T1OM1XmMgS7ZRgm9l7K6OTNwFMt8WmJ2wLIbZvSnbeXU/X6HjKUXoVsrxbWW3HGVVMV
	FY3NlRW6tIWLD3PqOtQ4jIdAPDygUSRCphNEq1bFGsYMbtr0k/lHmfJ+rWNfTpRLz7PAaKYu3JG
	uAzwc0VUhMFrTmSwcakDFMqfhfjh0qjJQd8hso2reBXaZq03D9QCztJCPRpq2yJhCnRi9VVvtG/
	m9SJphp4e+N3jjEVbDbJT7gYetnR20Keq0BO7qjmONg0mtxImG+5KPC59UkncxG8QiTkKys2fT+
	pEF6g3lB0vm5jyTJlj+d3bHfwTfHhK/Za3eXj6h6EN/7i/geM8U0XBDRBfpaBf1zozdP72fR4Zy
	M15
X-Google-Smtp-Source: AGHT+IE0s0lyU5FbbMJZMjZzb/JdJphgG95YZRZrXFcSa/kp+KRPaXRAnUQjMNNmxS+JnzgO7HwnTw==
X-Received: by 2002:a05:600c:4fc6:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d19538e2cmr221697055e9.1.1767189721959;
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm73767887f8f.40.2025.12.31.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Date: Wed, 31 Dec 2025 15:01:59 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231150159.1779b585@mordecai>
In-Reply-To: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
	<ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:15:46 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When a structure contains a buffer that DMA writes to alongside fields
> that the CPU writes to, cache line sharing between the DMA buffer and
> CPU-written fields can cause data corruption on non-cache-coherent
> platforms.
> 
> Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> annotations to ensure proper alignment to prevent this:
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_aligned_end spinlock_t lock2;
> };
> 
> When the DMA buffer is the last field in the structure, just
> __dma_from_device_aligned_begin is enough - the compiler's struct
> padding protects the tail:
> 
> struct my_device {
> 	spinlock_t lock;
> 	struct mutex mlock;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> };

This works, but it's a bit hard to read. Can we reuse the
__cacheline_group_{begin, end}() macros from <linux/cache.h>?
Something like this:

#define __dma_from_device_group_begin(GROUP)			\
	__cacheline_group_begin(GROUP)				\
	____dma_from_device_aligned
#define __dma_from_device_group_end(GROUP)			\
	__cacheline_group_end(GROUP)				\
	____dma_from_device_aligned

And used like this (the "rxbuf" group id was chosen arbitrarily):

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin(rxbuf);
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end(rxbuf);
	spinlock_t lock2;
};

Petr T

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/dma-mapping.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df..47b7de3786a1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
>  }
>  #endif
>  
> +#ifdef ARCH_HAS_DMA_MINALIGN
> +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define ____dma_from_device_aligned
> +#endif
> +/* Apply to the 1st field of the DMA buffer */
> +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> +/* Apply to the 1st field beyond the DMA buffer */
> +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> +
>  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {



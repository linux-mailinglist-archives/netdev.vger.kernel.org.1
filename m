Return-Path: <netdev+bounces-137044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4789A415E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41551C2301A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08951F4286;
	Fri, 18 Oct 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8PwP3d3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F211EE03F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262394; cv=none; b=oXLCFgWisY6aL74FYh5h6lqmy4gbSaLOo3AzWw1gm0chHPdPRwY4HfvqW4JHrJK7druwoNHveZ7258asoFz6od9WseiNtbFUgrpaYkhsAITvsk5VNMdD5ZYq90dQXxVTvDAfd/ZP7CBoqenFLyOwUCgKuLQFfEcfMJuwYbNbzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262394; c=relaxed/simple;
	bh=tr8jRKAqh09ouuyihQan5X+g0ShJthMmUZ6d8PXsqVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuKXQ7BCfcfzl46lL+AO735EJWd5/fFUtOQO8oXbQrVOYolsvuqLUdie4CMsP0JlV1iRRsyRA6YS2OoSkCawTL2xA/RyTM1Kgl4taSM2IDAWKQyolN324mNr8HbkPrN7J9HwHOQtf7k89bDGiHqYL7K6NIW0mtR7jKdvp7BISHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8PwP3d3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1kdgqSpUkHaDdHlWc2ZMvh2f7J4lCZH1eEq8CMsWKE=;
	b=a8PwP3d3SkWwpl1EBMF2cozoCoAAZv3M3BrudlTg2Dk/bO4JGkSKgofTmtcAQlZePZSKzb
	AQQtWh3Pw0bBhzbBtHVVGdGUZVMRQtZMHSaxtihfOlcNdETUKANr4NY8YD0pvSbbxBxMHG
	l+y8KJJWMjUxJrg2WkW/edMMS1yY+lA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-k5M8jfOMPIqkDUVdf74Ulw-1; Fri, 18 Oct 2024 10:39:49 -0400
X-MC-Unique: k5M8jfOMPIqkDUVdf74Ulw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbec7fbf1cso28610466d6.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 07:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262389; x=1729867189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1kdgqSpUkHaDdHlWc2ZMvh2f7J4lCZH1eEq8CMsWKE=;
        b=jD6cszv5Qkc5Z95tB3D5d51ScrKaPvx38gOHyCekOF4gH34H4/5OEI4Ng3HfWHkmJp
         01hJ6FuhVSjCD/ZeCnw0qrzehaBpMFi5K2+VSUu8e9QwF3yAgs/spXiBwrImdn70JfIx
         D4tDt+IPP0oJnq1eZZQyTtEGQV04M+LnIxB67mu9ngxwTyt/uHPxvU+If/YmhoWjiVK4
         rBJ3+xeXurEWI6mOJIpOrkrqJR3F89ZmFB1ZH/YUO1dhW1q+VtcLqVOVulGGGD8M8yzQ
         pZcn8j3bcXB2sutBud9abifnjl5PMqVMrN5muQ45VBAZZrIdM61OjYrpmOVEHXNi2sx2
         LHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu14Xy+5SlcAd5SnSgbEtM3w38Du53H90C6COad1gNGKKh3QyWBYoC7y4GR7zUgtUnUXptvCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pufJ6UccY3AlSBuPHqzABJHVRaZ4ynYAla1qHKGwUrOO9OPv
	6mVv/wIzm8eqYFdXLjLln1DYp7XRzw63AoljmzQ+yWqCGBBd35vhiDZd3zWI88uH6uDJ0CQpYFw
	sbzu2Xb0uD8zJr8AaNirNha7JCJiW8GeSSbVGYvedmuCmc3B9MZMkDw==
X-Received: by 2002:a05:6214:5541:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6cde150dd18mr34710896d6.21.1729262389302;
        Fri, 18 Oct 2024 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsprW5VkpYV0rcxGwN4Pw/bcWrNG/R/XuTyrPHGf/vzAwEznM75iAODlOWI+en0Ua/metoMA==
X-Received: by 2002:a05:6214:5541:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6cde150dd18mr34710536d6.21.1729262388975;
        Fri, 18 Oct 2024 07:39:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde115577csm7560936d6.55.2024.10.18.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:39:48 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:39:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
Message-ID: <riu6774ovfsubpe3zzuehfmzr2lz4slv6wmcsenoewl47nukf6@ba2tode64wby>
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>

On Wed, Oct 16, 2024 at 01:27:07PM -0400, Michael S. Tsirkin wrote:
>Static analysis on linux-next has detected the following issue
>in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
>
>        if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                queue_type = VIRTNET_Q_TYPE_CQ;
>                ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
>                ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
>                ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
>        }
>
>ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
>VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>
>include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL << 32)
>
>..and hence the bit-wise or operation won't set any bits in ctx->bitmap
>because 1ULL < 32 is too wide for a u32.
>
>In fact, the field is read into a u64:
>
>       u64 offset, bitmap;
>....
>       bitmap = ctx->bitmap[queue_type];
>
>so to fix, it is enough to make bitmap an array of u64.
>
>Fixes: 941168f8b40e5 ("virtio_net: support device stats")

Release with v6.10, so should we cc stable?

>Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> drivers/net/virtio_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index c6af18948092..b950d24b1ffa 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -4112,7 +4112,7 @@ struct virtnet_stats_ctx {
> 	u32 desc_num[3];
>
> 	/* The actual supported stat types. */
>-	u32 bitmap[3];
>+	u64 bitmap[3];
>
> 	/* Used to calculate the reply buffer size. */
> 	u32 size[3];
>-- 
>MST
>
>



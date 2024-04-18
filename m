Return-Path: <netdev+bounces-88999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDC48A92D0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEDAB220E0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0206A329;
	Thu, 18 Apr 2024 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyGGMBRx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22236A340
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420687; cv=none; b=pwN5v1AWOYZ1Js4jfoZs9fkH03/Q7dQGGrhXwvjdMgngKShQi8Vjp+WnR1O5NKsBXdaVsE1dUiwgfCDA7rN2gJvt3/rxxlQT8eYw6RvvIuwt8VY7SQZdc5ejkJ1h3GW7CApWqTDK8s2GCuTLCjEwnTjmCbX//3GqICPtj/I75Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420687; c=relaxed/simple;
	bh=jSDOyoU+Ufb3EoZHi6b/eMQZ//b2/llKBiIbkVZpldQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irFsfKVLtcIw3y1zQe3fj6mx+WmXSG15rjCFN8geXrkyFBjOHGWHSoLExMbvqrTHqCkt9kj65CFyaqtmtMfCzIfc6fj7FwcZGINVURYrI4i5Dv8TwBOGNT/X7/9w46a5wcwSAq1erXdAa2bdj49O5cY6R8idQr+Vjwec3QyIpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyGGMBRx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bTyk8H9lbs4UgJmEreKEkQSEUAJlXl9tp1kT54Vykk=;
	b=eyGGMBRxGqFeb9qpjo/rJllO2BbAXOwkgSyOj425W49L/O8HSDrIF/fxwtUIAQW9rrbgpU
	oytJHy8xzOyr49qyr9lh4c7BbwrbKIbqJKGKCqWr0qkWX6pjki33ACtJcUhuWGXrulS9dk
	FD/sk5ptf5SV4S07kgE91Ttqrg9omaI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-8lyvbnKVO3yGcVbvB3d8cQ-1; Thu, 18 Apr 2024 02:11:22 -0400
X-MC-Unique: 8lyvbnKVO3yGcVbvB3d8cQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6eb86b1deb1so632065a34.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420681; x=1714025481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bTyk8H9lbs4UgJmEreKEkQSEUAJlXl9tp1kT54Vykk=;
        b=DoovktqmixyvPhuQU4JBHA2KtGj6c19bipgTJl0mXrdAQ2c7BVXF7PGOkPWRhsKVsl
         IXQHvre1yLSjnUwHbVuWwIWYAarjwJWJvcBUgbTZzL7k45UGnEBc49f4phSbIMlPV5mK
         xZ/qGEkeLnV8iOe26gIs3+Yp9xqmKQwbQYmvvWgG4XMKYSwEXQKNuU9NgVY/zZEWJn7l
         utSwZY29AOiSVb2nfNp9G5tV5iU6/9etI0Em2GrdI2U0QsUdlDwGaXSsFV6MIwggdcrh
         lewl9p1gZAWR1a9UjR5UY5A2+1AV2bcOhXume3yuLVdEkXZ9UGndHMsaPGIERaNH6sU0
         kGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFJH6oOTzcwXtkG44mYKbpKIsvevFtlADqAFGYFgvlAwjeSeD3kM55TQn6qMp3XVHGo/4unzcHcZm9AIHTpCbrhgDwMf77
X-Gm-Message-State: AOJu0YzZKImwcMTJ+ODg9SM6xCANHd5qG/SBgubXqyeq3a+dtPEAGdOC
	EXiqDWTHp3rLAItFKOpGmzHll6lzAUIllM2oMQ9J3MBlfMaaAHAxVkb0jXIBHJsgU8Z7i6R52Ur
	AULRTyQok2VWhaz5DI3wRTQHPghMIA8mCRPWQEENgKyJ67/TQ03hUpYHECbGtFVbgj90ZXU5h2e
	2faBP/cxJ4wKyQCBbJqjrqZ7/u5I2B
X-Received: by 2002:a05:6870:a10d:b0:229:87f6:ee8a with SMTP id m13-20020a056870a10d00b0022987f6ee8amr2082548oae.30.1713420681558;
        Wed, 17 Apr 2024 23:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/aKSHIiMQ4NX9lXWFREqZsIXbcFaERNQbi8Xmb3rVUhJIHh0oBv/suIMx3kplwqHZTIWICb6u4Bl3iFHFt7U=
X-Received: by 2002:a05:6870:a10d:b0:229:87f6:ee8a with SMTP id
 m13-20020a056870a10d00b0022987f6ee8amr2082533oae.30.1713420681310; Wed, 17
 Apr 2024 23:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:11:10 +0800
Message-ID: <CACGkMEuWTpMSQVMvWgp2+wDPtRDuKiqFQdsSEnd9ors+E3iDWw@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we chain the pages of big mode by the page's private variable.
> But a subsequent patch aims to make the big mode to support
> premapped mode. This requires additional space to store the dma addr.
>
> Within the sub-struct that contains the 'private', there is no suitable
> variable for storing the DMA addr.
>
>                 struct {        /* Page cache and anonymous pages */
>                         /**
>                          * @lru: Pageout list, eg. active_list protected =
by
>                          * lruvec->lru_lock.  Sometimes used as a generic=
 list
>                          * by the page owner.
>                          */
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>                                         /* Always even, to negate PageTai=
l */
>                                         void *__filler;
>                                         /* Count page's or folio's mlocks=
 */
>                                         unsigned int mlock_count;
>                                 };
>
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
>                         union {
>                                 pgoff_t index;          /* Our offset wit=
hin mapping. */
>                                 unsigned long share;    /* share count fo=
r fsdax */
>                         };
>                         /**
>                          * @private: Mapping-private opaque data.
>                          * Usually used for buffer_heads if PagePrivate.
>                          * Used for swp_entry_t if PageSwapCache.
>                          * Indicates order in the buddy system if PageBud=
dy.
>                          */
>                         unsigned long private;
>                 };
>
> But within the page pool struct, we have a variable called
> dma_addr that is appropriate for storing dma addr.
> And that struct is used by netstack. That works to our advantage.
>
>                 struct {        /* page_pool used by netstack */
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
>
> On the other side, we should use variables from the same sub-struct.
> So this patch replaces the "private" with "pp".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..4446fb54de6d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -48,6 +48,9 @@ module_param(napi_tx, bool, 0644);
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
>
> +#define page_chain_next(p)     ((struct page *)((p)->pp))
> +#define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> +
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -191,7 +194,7 @@ struct receive_queue {
>
>         struct virtnet_interrupt_coalesce intr_coal;
>
> -       /* Chain pages by the private ptr. */
> +       /* Chain pages by the page's pp struct. */
>         struct page *pages;
>
>         /* Average packet length for mergeable receive buffers. */
> @@ -432,16 +435,16 @@ skb_vnet_common_hdr(struct sk_buff *skb)
>  }
>
>  /*
> - * private is used to chain pages for big packets, put the whole
> - * most recent used list in the beginning for reuse
> + * put the whole most recent used list in the beginning for reuse
>   */

While at this, let's explain the pp is used to chain pages or we can
do it on the definition of page_chain_add().

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



Return-Path: <netdev+bounces-135134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D168599C652
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D44285EDC
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416661547EF;
	Mon, 14 Oct 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDd1L5KU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B8146A79
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899272; cv=none; b=CsOLiaQ2AO3hoGWjT9pGd7+2fubrQ0E70bcTqjUJf+E2Mb8Wr9dpfuv2QX8pfC8KkoFS25+13QGcx3iReObyDmA+fDPn0FH1rnq93P6Huj+A9ByRC/avBbLFs24IOp9zk20vnVsXmSSF9S7br40uKKXUxQV3UBibb90xXaJFXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899272; c=relaxed/simple;
	bh=b8NCLRJKGrm+n0lum0OQZapBDj5h/D1HEj2AK7tWcKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEcCjkPKr0Nm/czHx3I2SDJ3t6qDD/krRHOCIXubB3yTdyLmGuMQC3Rd6lROtMALwsBciTXvC5a8LOUQLW1TNcTad+JEletauNspTNHMe09PW+kbVIAvCym7jLCihLjRiTuvLvUrKmyolN+xA64YZURuMtygBuGEE4AsKsdh8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDd1L5KU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728899269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbyVEHx1wYT46hZ0YR53rr13HilYd79w5fQFSE3Vqco=;
	b=bDd1L5KU6NufRvg/tuuRymQ7geTiod+4yoil6cZT/KfghQxbDhVSzfO4nWAvJd6NfQ9gnt
	AVPrqW/DxJ4Z6+X/rL8alj77tGsFwj6FilW+DY9KfdNZq5aS16uXZh+/nNtccRLjnln1Do
	bIbvrqWTKLKy3ThLq41YZE0rDWMv2S8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-5QVgXFflNAy3E_JTOzqKGA-1; Mon, 14 Oct 2024 05:47:47 -0400
X-MC-Unique: 5QVgXFflNAy3E_JTOzqKGA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1e429a8fso2663166b.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 02:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899266; x=1729504066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbyVEHx1wYT46hZ0YR53rr13HilYd79w5fQFSE3Vqco=;
        b=USMMAr1xlrciB0YSDdBBpwg2zw9P3FdUVYDfAo/rXQx55BgsQNe4a1hhpM1eLTuxtr
         5T3sCUizNjhJ6cK/Q0VLK1FEg96fcuTQ34I5LvZYJz1R4Sjds0+gppueI2pkgITXXqMu
         af+rC9lkaU6DxVH6WtwzFq7dUzFRF0mTAcAlP+UD72hymzc8TTIeXX0Ow1SR1uJq4HU4
         G9hyD4cJfY6PeVGBw75FAyHsouocEu2WaiqPWxs3qDJ6Ta1564lFdR1ZTWr42laYPfwu
         d8Bf+V8qHPfwlxyhaMLWIO7bUFZtcH/15SJ6kXcLaVUxM7OXap3HYM7lMHm1H93HvmTC
         vkEw==
X-Forwarded-Encrypted: i=1; AJvYcCWyxEyYO6wFRlbM5I/ig90KE3N/ip3tBh3FgpooKivt/hZsrVmL5h8beLCLjLKPT1RAdcH0rNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzizkna3XBVGGNBTzax88rPERNtzHuSU87i9JDAp92YOjpq35+
	p+WumGmGoBehOPTBz2TJcCEnepHQiR2ZknX9HDcSgro9gyWjhwRuhWERPAIqV1DtWvaeRL02q61
	AG7mcJl8lxeOdoTdQsTXdZ2DzsgqIQpb5+lAsmlk3bfLuygcbqZdUBQ==
X-Received: by 2002:a17:907:31c8:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a99e3c97e69mr785564966b.32.1728899266553;
        Mon, 14 Oct 2024 02:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMHMu4YWij0zyJOKwCcWc+znbiga0jEn5SFeqDdbHrQBD3dXiMBV8NYSsDJh+q3dUEZeJFiA==
X-Received: by 2002:a17:907:31c8:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a99e3c97e69mr785562766b.32.1728899266063;
        Mon, 14 Oct 2024 02:47:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:d16c:2d5b:a55d:7fda:5330])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a07662ffbsm178004966b.130.2024.10.14.02.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:47:45 -0700 (PDT)
Date: Mon, 14 Oct 2024 05:47:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: virtio_net: support device stats
Message-ID: <20241014054305-mutt-send-email-mst@kernel.org>
References: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb09900a-8443-4260-9b66-5431a85ca102@gmail.com>

On Mon, Oct 14, 2024 at 10:39:26AM +0100, Colin King (gmail) wrote:
> Hi,
> 
> Static analysis on Linux-next has detected a potential issue with the
> following commit:
> 
> commit 941168f8b40e50518a3bc6ce770a7062a5d99230
> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Date:   Fri Apr 26 11:39:24 2024 +0800
> 
>     virtio_net: support device stats
> 
> 
> The issue is in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c
> as follows:
> 
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                 queue_type = VIRTNET_Q_TYPE_CQ;
> 
>                 ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
>                 ctx->desc_num[queue_type] +=
> ARRAY_SIZE(virtnet_stats_cvq_desc);
>                 ctx->size[queue_type]     += sizeof(struct
> virtio_net_stats_cvq);
>         }
> 
> 
> ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
> 
> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <<
> 32)
> 
> ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
> because 1ULL < 32 is too wide for a u32.

Indeed. Xuan Zhuo how did you test this patch?

> I suspect ctx->bitmap should be
> declared as u64.
> 
> Colin
> 
> 

In fact, it is read into a u64:

       u64 offset, bitmap;
....
        bitmap = ctx->bitmap[queue_type];

we'll have to reorder fields to avoid wasting memory.
Like this I guess:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Colin, can you confirm pls?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..ef221429f784 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4111,12 +4111,12 @@ struct virtnet_stats_ctx {
 	/* Used to calculate the offset inside the output buffer. */
 	u32 desc_num[3];
 
-	/* The actual supported stat types. */
-	u32 bitmap[3];
-
 	/* Used to calculate the reply buffer size. */
 	u32 size[3];
 
+	/* The actual supported stat types. */
+	u64 bitmap[3];
+
 	/* Record the output buffer. */
 	u64 *data;
 };
-- 
MST



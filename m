Return-Path: <netdev+bounces-201878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15347AEB531
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73A41891B42
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20729898D;
	Fri, 27 Jun 2025 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOWVwNV/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804E265621
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020927; cv=none; b=RSacgxECl6GeZcIiFhLxx7RiBcBdXExF2egnQ3TII1IFu9VM7JXzxJ58NaIj35gjImWpou6zEuE8pEAD/oAdqICGt3zb5xiugOJfHMwKYB4A3ZKXilEzvDT9ko0+i70TKg7FQFl4mQCewfe0/y2Qp4Td2K+IytyQa2FF62K99iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020927; c=relaxed/simple;
	bh=YDMMLOTxS78FCUcrDJt19rSCZOgABNO62CdcDVjYmWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVgt4AC3shU/5RECuMCYIdM3safe40IyqcXRhaoJ07ESvBuAzARu930nFpD6yZY04G3U2g1e0UWB2kv26f+QPIq2ptSjxxkprrsmauC8nsY6RSDNx+7tbRj8mf3gAPdSfv6Sw/GGKbJaluzP0EnDP6QKCg+zUNIx7uKzd/aMPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOWVwNV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751020924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eq+61IIf8U2MG+TUGf81YCWex3B4uWo1eFJJF8gAeVs=;
	b=hOWVwNV/K0s+x9EY4xg2F55T3Vxl/wfJW4/vFUf1cwj9JEd9bfVMTNhWjiNlszeRFO5QFF
	ztzApB94ZpXau4sGdpkwPafxe6W3sd4bpMFbvcU73V3XCC6idwLYrUMj8WhiQOQuEcWp2m
	N1XWYntpM01P0wDs3Lg83NKEXt3Yexs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-9Hcq-a4LNq6h31kRiy6WTQ-1; Fri, 27 Jun 2025 06:42:03 -0400
X-MC-Unique: 9Hcq-a4LNq6h31kRiy6WTQ-1
X-Mimecast-MFC-AGG-ID: 9Hcq-a4LNq6h31kRiy6WTQ_1751020922
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1713926a91.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020922; x=1751625722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eq+61IIf8U2MG+TUGf81YCWex3B4uWo1eFJJF8gAeVs=;
        b=gQ8tAFtWDh97klZWj0CzPXDYbn/sYll7WzJ0c3lM3ccMTtnp7hf6ACNuz9OtIgrgY6
         zVMqFiVagWtmL0EQP34C6EUPinZoVIXLwZdZfVBQMLi1CjpK3LKyYcoRPAkh6t2hrArH
         Z9J27oUJWyr0SyJqpzyF3Pu1s680mGRzUkFtfF8fAN9wsS/PZ6dyUm8VkAM5kXr2uTrg
         c0ugfdf/znwLkjy+qPO72TJ1wGN7zCCMEBxy0L4cnuKRbtuwD+ux/TxJsRxdgs3lsPoZ
         iz4cDIH7km0KH2IhVEsqlBMKu5J/ukt596DdP6bFDZkUPjX/2FtA7llHVnkakJ1bR/oa
         VCaA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Q5K+DmPakM5WBOD/G60SwDjXzxd9MKEEQrcVPZKNUUGBL7DFIC2IyKO4+ul8lqgvk1wnj5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSrORWqJBzvW+hZIaMpiKEpflAJ69DC2v1MkwIIKqwJjP0wHq
	rDKpB+Jng5Dm0hZnWgHfprSDzMs32SnjD1NIXzaDD05/3C84dAzsq+iJ+mh4xdsfaLVgDIN0G71
	sSGNirsJWu9LihJ0PTz3Li3JWz8uHStTu4MZmhjOWb9Uudd19nGuK+gSJBA==
X-Gm-Gg: ASbGncs/zMAdDwQ7rgLwXO1YMMEDPtdnqacwZy2e9I/JgECwrQELBx7fSRLcOSm+NHO
	Lf9zi5aDGnBwBJIcgzmh/cXwDW5k+uuNo6OvKGqeMmqJH+mLQjDgtpfYP8Mh4+cF+257an8PJH/
	YQZYwW5+z0NB4/YAC9oKwf5sg+iDmBIxYGFHtBQILBMitMz8Imbc4qCGWkROCf1UijtC/JvNAWx
	Rigip9XDT/iexTO+5bJ865QfUvn/uV2cmzt5kue7Hfa4C3VjucKjt1MNzvOdw6/VTOjtupOmQty
	jGEabyH5wM+B73zTx3upGf4x9xk=
X-Received: by 2002:a17:90a:d88c:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-318c9225ecbmr4389579a91.14.1751020921921;
        Fri, 27 Jun 2025 03:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+VYLk3yg6ZtWzngleQFQrjV6eQzaFY2eMafnD1MIJ2M0SYc8xq7tio6475lHd9a4WuJerDQ==
X-Received: by 2002:a17:90a:d88c:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-318c9225ecbmr4389548a91.14.1751020921576;
        Fri, 27 Jun 2025 03:42:01 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e6b5sm6241273a91.13.2025.06.27.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:42:01 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:41:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 2/5] vsock/virtio: Resize receive buffers so that each
 SKB fits in a page
Message-ID: <rl5x3fw5rgyrptof2h7qc2wgimxd4ldh4tp4yhm52n4utksjdm@zei2wzme65jj>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250625131543.5155-3-will@kernel.org>

On Wed, Jun 25, 2025 at 02:15:40PM +0100, Will Deacon wrote:
>When allocating receive buffers for the vsock virtio RX virtqueue, an
>SKB is allocated with a 4140 data payload (the 44-byte packet header +
>VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE). Even when factoring in the SKB
>overhead, the resulting 8KiB allocation thanks to the rounding in
>kmalloc_reserve() is wasteful (~3700 unusable bytes) and results in a
>higher-order page allocation for the sake of a few hundred bytes of
>packet data.
>
>Limit the vsock virtio RX buffers to a page per SKB, resulting in much
>better memory utilisation and removing the need to allocate higher-order
>pages entirely.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> include/linux/virtio_vsock.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..67ffb64325ef 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -111,7 +111,8 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>-#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>+#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(SKB_WITH_OVERHEAD(PAGE_SIZE) \
>+						 - VIRTIO_VSOCK_SKB_HEADROOM)

This is only used in net/vmw_vsock/virtio_transport.c :

static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
{
	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;


What about just remove VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE and use
`SKB_WITH_OVERHEAD(PAGE_SIZE)` there? (maybe with a comment summarizing
the issue we found).

Thanks,
Stefano

> #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
> #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
>
>-- 
>2.50.0.714.g196bf9f422-goog
>
>



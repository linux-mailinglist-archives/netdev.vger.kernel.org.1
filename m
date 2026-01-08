Return-Path: <netdev+bounces-248095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A1D03883
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7822317D142
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354184ED46F;
	Thu,  8 Jan 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UF3RLuvY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="shfpwgPb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA294ECFCD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881073; cv=none; b=OT/pbPEvRsK2KZ0o6o+TgSoewMOqxM/E2xZ/N1j3qMmCHHup3Dtkfg7br54uzxXp6N69sXnU5gZWlndFNxj6+uDdB8FTTHsDacgh1xFAYLGqNKxLRKA5M8JLyRWEWvx4G7w3oEtezP1f5gjfxCyXP8DnX56fG8vEFld/xFHlRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881073; c=relaxed/simple;
	bh=yXMok8JlOEM2sgAIipul0a74lzFqWXRhO2Aov20FAgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwJvSFbk3RkSNuLA7WMB4lIZlKoblziYy/fYYW+SNp4aEu/h1cXvLzqhorGf7hjr9DZNDIdNiBQFdvJ4uaxWJI/IqwszeCE6LKAM+4vTnVJ1jNUbrDqxLnnDkgex6sAhTGAoQkQmuqnotVpWtA0Hxfe92Y3tQ5pBdRSfiKb+kw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UF3RLuvY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=shfpwgPb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767881070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmGHhC+vkdZJgHO0r54G5/mI53k1eZnkbsYL2uSG2DQ=;
	b=UF3RLuvYJBY5RjSmvxQ6zCy4LCIq1tzeAReT9cIp+jzDXHSIA4JXqYkWxlZ4O1zgbTl154
	1nNN9KiuDZU4d9Z1rTKvbwpYKi0chZFPJmensz/7eSzaVYN9ixJ8pZ9NFtaLQOJMHF6Xz0
	TDmx7kkamKn+HUBwaJZQ9YpG1X4XqMw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ymHRsDaRONCPBBD8Hc_GKg-1; Thu, 08 Jan 2026 09:04:29 -0500
X-MC-Unique: ymHRsDaRONCPBBD8Hc_GKg-1
X-Mimecast-MFC-AGG-ID: ymHRsDaRONCPBBD8Hc_GKg_1767881068
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b771bfe9802so384501266b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767881068; x=1768485868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmGHhC+vkdZJgHO0r54G5/mI53k1eZnkbsYL2uSG2DQ=;
        b=shfpwgPb9LiNC4RMyXNeaAydM+O4PgXrgayaVFh93s4USaWOAaWjZpVwiy1sXwxVba
         +joVYqHfHeZAptMJrIAHxN+Il8KeIwX8vLznxxcMIJ1fFQz9JXdXx2vk2a4I/AHdyxva
         cTYY9/tSUdMp1ijSF6MFKiXUxA6rpdXMRu7eAD38oCh7tocT1ncw0/5GVNMy5MP5ZtPS
         5k7qSgFQaTfMXylcEdtmyZ4XyiK+iNaTqnFVtbMaa/dVgCM+4h99Mdg0JkPDzpZltGlK
         gsh2k9LQwfzbiZtioTg9D9HsFjFqKW67YV/ABUXh53UzuP7Rh+1eYW9ysm1SKRlaoP+9
         3Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881068; x=1768485868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmGHhC+vkdZJgHO0r54G5/mI53k1eZnkbsYL2uSG2DQ=;
        b=XZwj/q/QE+4RGWe6z8qG+eaZUNuBYNlSlhm5CUfUKy/Sw3AV3pKCd2qrvYKv8H9irH
         eZPDOLTqnIXb/RsGXERLy3ICzloWp/Oqrwupt2z9r5rxnBGJiD58yVpyfohffPyv+JHj
         m6eOlVVyi5PcCLGmms0H29rrxOmFWnU5nPy/7aHYoMZs7Ws7X1gowz0FbmWbAREOddoM
         fEi9bKvIddVT+gnwWfrwudYKsdv4bKTdIIPHD8TydQ2JQvxLlq3AOsEpmbny8QtrWlwy
         QVh4//aSUKkZ9msHPYtENnvJu2D/c7I3Y16fZ7ZK9PxgxYjCUKpz7RPR541/T15CFlpO
         d+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2h8zgtpJt7aYSgPmCyK/LHZCEf1Y66MbVt6AjeqYhdU9OHNvM/pXjHNA/pkBoyrH7LomAlVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Y5xQX4eEvj3SAdmuPdRrcAh4Jxc1ioKQf7WfAKLPM8RRPQ0B
	ldyeiSuSDwRZMUgaDR4mjmR0nbUJNv9zJnfZqjwDUQgRHOP03AmdUnjnbSsS6KdJZoaKsnTI50V
	HtfsMrAt1U+1miZizRj+7sI9VhIGpSxauofl10oGRssrKdR59ZRB0ClJGnQ==
X-Gm-Gg: AY/fxX6X6bbM/XerS7Q2mJyyDd0TptkysJuKCsku0m0c1v0PgE5tlppc7jdRT/w7sxU
	OsHaGwc4SKlvx9haRWW4eriqYvJMb7iHeFjkjvBmjtObvGANoKJXUnrvKy9zu1ste1Vx8V0zgRY
	DfURIsA201Q6Zt9wTzH4PieH81LF4Ks66o2LRWgK2s87HFKXnEZbJod5h1rhZ9I22IJdW1TCZFB
	4ras17cqgSIdC7CX9V/a/O6ookmCFx+zyc0LOZz4H9DzCQtLbcirP3zV1SdZk+FZTCiLQMOah2I
	1ZfmR+w+U4PgNFLA469qUORli4O/UcJvu2LfrtZ6Qv9r9+a4qIIuy4kwArkyNytHJWNOrvCVZnq
	6rF43It8ZlpBu8eZO
X-Received: by 2002:a17:907:3da6:b0:b7d:11ae:4006 with SMTP id a640c23a62f3a-b8444fd6743mr637892866b.52.1767881067706;
        Thu, 08 Jan 2026 06:04:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgw/BdfC1kapmuRYU6+l1S1c4vqL+ygT6gHm7yV/BgYYGWFixI2eOd8lpv0XHKoQQX3Zl7xQ==
X-Received: by 2002:a17:907:3da6:b0:b7d:11ae:4006 with SMTP id a640c23a62f3a-b8444fd6743mr637888166b.52.1767881067171;
        Thu, 08 Jan 2026 06:04:27 -0800 (PST)
Received: from sgarzare-redhat ([193.207.223.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a564284sm830039366b.62.2026.01.08.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:04:26 -0800 (PST)
Date: Thu, 8 Jan 2026 15:04:07 +0100
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
Subject: Re: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <aV-4mPQYn3MUW10A@sgarzare-redhat>
References: <cover.1767601130.git.mst@redhat.com>
 <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>

On Mon, Jan 05, 2026 at 03:23:17AM -0500, Michael S. Tsirkin wrote:
>On non-cache-coherent platforms, when a structure contains a buffer
>used for DMA alongside fields that the CPU writes to, cacheline sharing
>can cause data corruption.
>
>The event_list array is used for DMA_FROM_DEVICE operations via
>virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
>written by the CPU while the buffer is available, so mapped for the
>device. If these share cachelines with event_list, CPU writes can
>corrupt DMA data.
>
>Add __dma_from_device_group_begin()/end() annotations to ensure event_list
>is isolated in its own cachelines.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 8c867023a2e5..bb94baadfd8b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -17,6 +17,7 @@
> #include <linux/virtio_ids.h>
> #include <linux/virtio_config.h>
> #include <linux/virtio_vsock.h>
>+#include <linux/dma-mapping.h>
> #include <net/sock.h>
> #include <linux/mutex.h>
> #include <net/af_vsock.h>
>@@ -59,8 +60,9 @@ struct virtio_vsock {
> 	 */
> 	struct mutex event_lock;
> 	bool event_run;
>+	__dma_from_device_group_begin();
> 	struct virtio_vsock_event event_list[8];
>-
>+	__dma_from_device_group_end();

Can we keep the blank line before `guest_cid` so that the comment before 
this section makes sense? (regarding the lock required to access these 
fields)

Thanks,
Stefano

> 	u32 guest_cid;
> 	bool seqpacket_allow;
>
>-- 
>MST
>



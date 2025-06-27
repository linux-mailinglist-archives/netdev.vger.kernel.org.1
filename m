Return-Path: <netdev+bounces-201880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B96AEB546
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011F1178AAA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417EC2980A5;
	Fri, 27 Jun 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb49pQZS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E11DDC1E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021192; cv=none; b=Vv+cULWu1wNGw1E7q6BS047aI9maY7YidH3ii9fy08FB57RQHp6Ygc6klsVgBFp7kz9IYwM51TFu72Ue4GN1TFuND4wqYXO1hKExAjre+weHVh9alG2z8IF+bi3YbRW6llZdEE6ZKVVpsG5S/Sc0HCyl1WwQp6wyEwwdbseKp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021192; c=relaxed/simple;
	bh=H9cfOW7/9BOVcWtdnIje6hKT1HQvPyY4W0Mbubki7jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy4BNyQXcJrJppFxvECX3QzCPwym4Lf6UE/UgsLDcsikt/rjqtbNNFDN29/Ca3dHqkI/LqnABVrDk6P1qF+XwyFbqnf0JYA46eD9srnUGuKtBWih7kB+9goC0Q9deLWqyicjjHvyiXgyykBqS+9JvEraI5gHU1soAmZivikq1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cb49pQZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2U6yQaN5C0bZ1f1NN3/TqG5WpiCkSwG+8B6FK7qmmgQ=;
	b=Cb49pQZSy0tNkqKQyYifUqyxSyP8sVFi6cm8Alt9a2+p90aIMlFiU60kjAqyvu0wgQd0qt
	FB646obpbcREM4egv2FFrAZHCP7knygRiVBGCRX0B27SktTeq3wVt9tAS/CgyxSkpAC9bA
	Xeo6hXTqBrYdFO6ofikb1TthUiKkRwU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-JGVj5TIjM8Gzei4ZGIQyvQ-1; Fri, 27 Jun 2025 06:46:27 -0400
X-MC-Unique: JGVj5TIjM8Gzei4ZGIQyvQ-1
X-Mimecast-MFC-AGG-ID: JGVj5TIjM8Gzei4ZGIQyvQ_1751021186
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748d96b974cso1787918b3a.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021186; x=1751625986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U6yQaN5C0bZ1f1NN3/TqG5WpiCkSwG+8B6FK7qmmgQ=;
        b=ORTxDK3VKdU6beNcVpl7hM/E0A07g04bgnjOxuiKY/XFQVITlTJnWH9UVjtL4LViO0
         eI7AyQt8a2vEtBSfCsY/5GCIJJhgMeQYlMVOLTEAZjko8/nLf3MjL6s++JsD9DtRbbkx
         zjQ9of5jcIHKxGv6v6NpL8/hJbl9BCxqEG0lEKQBK5zmuYSWWITsaHLI3IlPXdrP1ZLR
         1ypwEbbOoL70pxehfwzqD2PkbJT1f9R0scgvG6Y7ZYoLKHmErOGfpQ7LkZ/5qO8eSga+
         18JqQ8bZQLpIuU1i/vscgcV8qTEbBbouqMQVTbWqvSLwqKzbaKHSpM+ZClAr8cZctwTH
         bXWA==
X-Forwarded-Encrypted: i=1; AJvYcCUgZzr7EdLE3VauSWu9poZGg0VfFIgzpVpauRt9S5QHywcOFP4/rkrHaHAb5lg4wNORiBkC83M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKDKzhU0E1DFegbp9/UQwmzynP1AVRM5ljAuXgfTV6PZ97oWY
	9yMgMggcV0eTS07bUX5lW1qTnlthnxtDct+9iC2vh/M0UjXVo2Y7mslpCj4a0Bvp3wRJLOvJ53r
	d9HZ1HhS49MxFKIC3B1fnJnMLN8aJnTLL/hd4zV3fSrqjvSLl+4JSmM3XuQ==
X-Gm-Gg: ASbGncvtj+Yx6q/1jyYch43XyL29GYdUAFDwJqU5UvauMQtmYTcDH+uxFiqsN+eqHYS
	TyZoCJ4ZQdimzasp+zyLLrR/AyBjabRLDHi3axxeggJDIolDQYhpf9LaB4nIC3xvFoa9aRr/PIx
	7k3wIo2va0jf5t78Hnrq4bj08MqcqmoVAkASqncUkmlGQXWZnsIC3d8rU8Ha5NSBxXP/olLrNHB
	MkINYd3Z1OKBXzXtv7J3xb0yuPy0bbJeFctAribj/hmi8lcSEe56q7PXBfdzS/QYCUkWWFvzPh7
	tIIJIcuBRG11QfXXTa0n8oeJ6aE=
X-Received: by 2002:a05:6a00:1a8f:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74af6fcd495mr4401850b3a.23.1751021185870;
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1QscKRumL1vYeE62JJDCxmp5mPz+2z7tzSDNki5kV7FVhY5xV2DPg4aIB+BhjiSrwycgrew==
X-Received: by 2002:a05:6a00:1a8f:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74af6fcd495mr4401798b3a.23.1751021185441;
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c5837sm2009378b3a.116.2025.06.27.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:46:25 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:46:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 4/5] vsock/virtio: Rename virtio_vsock_skb_rx_put() to
 virtio_vsock_skb_put()
Message-ID: <oxnd4uescl5fhdvkyrhndygud5io7qwwajjg5h2bkmhz5kdhbx@zontoh2qdsuw>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-5-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250625131543.5155-5-will@kernel.org>

On Wed, Jun 25, 2025 at 02:15:42PM +0100, Will Deacon wrote:
>In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
>on the vsock TX path, rename virtio_vsock_skb_rx_put() to
>virtio_vsock_skb_put().
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c            | 2 +-
> include/linux/virtio_vsock.h     | 2 +-
> net/vmw_vsock/virtio_transport.c | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)

LGMT!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index cfa4e1bcf367..3799c0aeeec5 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -380,7 +380,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	virtio_vsock_skb_rx_put(skb);
>+	virtio_vsock_skb_put(skb);
>
> 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 8f9fa1cab32a..d237ca0fc320 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -47,7 +47,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>+static inline void virtio_vsock_skb_put(struct sk_buff *skb)
> {
> 	u32 len;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..3319be2ee3aa 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -648,7 +648,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			virtio_vsock_skb_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.714.g196bf9f422-goog
>
>



Return-Path: <netdev+bounces-207045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74DB05738
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9250C1889B63
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692842D5430;
	Tue, 15 Jul 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs2qrHe6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393F26D4D4
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573327; cv=none; b=e9zdFquf4Jx792WQVcQKIwG0RoKBUqr53kN5nIu19UGtw8xyi9yj8xJhbM0Zg8kwRyFrKT1x5Y2ijk1QFk0LeXqbhmWngi7GlocupYXdzfM1oxtmw1ufa+SMVtcFnkYSyiu875pfVHggO9u6Dl9z2jkFOhcEWjRXhFsYaXpJrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573327; c=relaxed/simple;
	bh=+amJMGPMe6DvicjWF80SXyO9oVTDL+ida1EY6ELCfas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsbDM3sXQcvI7lAIZzj+IyucZcOFCdOBuVEu33gPahP5aYoqiP3nVcO15itOiKeTDViJwWIPoKViaR+gR3+zgOQcBnqIy98BIOmczYPrNkucD59snPrrT8paH/vKSPvDUqTbXtcZTWxSlOyFFVXEDujIYMSUSsGlfgJu/s4etAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs2qrHe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
	b=gs2qrHe64Y6+qqaB3bH/PEBKwU1gStv65XH66OaR8/t5n4G5kDmlhLVVFKU066g4ln2zTo
	3iFwnKuSND22gdiEWi8Iy4VXNxEh95I682z5sBkI9LW2fM+vhXDC0kZ6Qgp74LZ2McgFH1
	vxSnk1qdGiF++GMhkbcR54Za/2MYgcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-HntG1Rx0Owm97oSS8uu06A-1; Tue, 15 Jul 2025 05:55:22 -0400
X-MC-Unique: HntG1Rx0Owm97oSS8uu06A-1
X-Mimecast-MFC-AGG-ID: HntG1Rx0Owm97oSS8uu06A_1752573322
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab5d8797ecso44775941cf.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573322; x=1753178122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
        b=hOXDinqDliPCvXewcDCFGptlqQ2heGZ7ul6JWhQnfOLi5wTREOkvnY+I73njaXduMn
         PLYybhGg6sNHyrg5Kpke7m1mnJE24mLnGF5SDnQpsDK/WudnV37eE6gfIVDmQ9Z/NCB6
         Cwnc0qNDziC31wZd7uADlf1dV8MV6mJmLx6YImOh4MMAAmvRbPqjXnBz4G/dnnH9LsBv
         zRqzHSgjtoT90y2JSR8Dief5mVtMDiO2e96aAzn5kVTcX0dPKIpm4rtVXE0efzBTfZGT
         ncUwjHPl+jA8vLc74+SHQrpkLR63zzNNlRSi87QsVS7Ozzl+zuqDQi/w1rT9GTmksAmm
         MIkg==
X-Forwarded-Encrypted: i=1; AJvYcCXrfZ59tJwbkTV2fi4udgOjGTJ9WDBMAS+6Lnh7fL1Si3VR3JJR/5CP6QFq4UPxE8lzXqsCo6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzntm3BRZ1d2VIVD6xpihO4Gtc8GU8iLNQaCTxa6pZ7YuQm+vKH
	d2uWvTOlXVSxts78DoUJnOmbMMyyFXk++CENBO4nAL3cmX0xcs1/CrSLG/ICr1Z8tlfgUXhSyC5
	ZCaCq2glDyHhZsLac9jjGYFF3C9TsBhKsRS5rGLKXS7Jt8YbeFJ9tLKNdTA==
X-Gm-Gg: ASbGncsQqWD6iWDY4Hw/Had902Y0BsYa3TOKYz1Ee4YlqA2LuhC+i3yShfoKmPfU+ej
	sk9pXFSayLjyXsc+T1dxxB3kJwZH26t+rhBYRtNU5VwvfhbHNCqQaQTD+FkGYmPmfnX2goy+ZOE
	AA6zhipKBp+IuOGR8jfrMBdUbBxMOF1Fnx2cOI+oii7U0MMt6KdayepZj7i3xOoLhTrulFm2wX4
	FNrW91bJNbAWnhgWQYjqJw7cJk9b7C9u+tqaDYlzYrtK4KZD+GfbzoY7iUe+Wht+Oi7wAHqETC9
	VybBBgbRrIYJ9KWVNxwCTdEyY4Fi5TiXqYC/KbU3Zw==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393471cf.18.1752573322301;
        Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeWoRAlpmTeV16PHDRVin9Qf8zLbTd5Snp7dshvSQ6NI7guHEP1XHwoIcK6laQEHjMzcohNg==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393191cf.18.1752573321802;
        Tue, 15 Jul 2025 02:55:21 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab75211016sm14135681cf.45.2025.07.15.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:55:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:55:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 3/9] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <ho6edx2uqqazyeoe3vm4oruas44ozngsoyhcuilremkzqg7u44@b6xeevkxtlmc>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-4-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:57PM +0100, Will Deacon wrote:
>virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
>packet header is not zero even though skb_put() handles this case
>gracefully.
>
>Remove the functionally redundant check from virtio_vsock_skb_rx_put()
>and, on the assumption that this is a worthwhile optimisation for
>handling credit messages, augment the existing length checks in
>virtio_transport_rx_work() to elide the call for zero-length payloads.
>Since the callers all have the length, extend virtio_vsock_skb_rx_put()
>to take it as an additional parameter rather than fish it back out of
>the packet header.
>
>Note that the vhost code already has similar logic in
>vhost_vsock_alloc_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c            | 2 +-
> include/linux/virtio_vsock.h     | 9 ++-------
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..4c4a642945eb 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -375,7 +375,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	virtio_vsock_skb_rx_put(skb);
>+	virtio_vsock_skb_rx_put(skb, payload_len);
>
> 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
> 	if (nbytes != payload_len) {
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..97465f378ade 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -47,14 +47,9 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> {
>-	u32 len;
>-
>-	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-
>-	if (len > 0)
>-		skb_put(skb, len);
>+	skb_put(skb, len);
> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bd2c6aaa1a93..1af7723669cb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			if (payload_len)
>+				virtio_vsock_skb_rx_put(skb, payload_len);
>+
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>



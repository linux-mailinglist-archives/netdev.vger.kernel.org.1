Return-Path: <netdev+bounces-213264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236ABB24486
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253D6721E7E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC79B2EE61B;
	Wed, 13 Aug 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoM70vIo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DED2D94B0
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074478; cv=none; b=YEQ1dqowUHidJvKiKczI3m/ffDyr72z3cnNto+Sw+QeQccsiQadCYw5L971T/WpxN6qviJni8FA8ltAyBMualblYYeYVR7NtvJMew63tZ5dq0G5R8GkJDSPQtKnHWo09s4lqIgWcLWEWklhZ6aywS3PLGZzzCsPkyxUbe7Us8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074478; c=relaxed/simple;
	bh=tPuksD77buzY7YWi9EBculS4rVEQBAdYHafEc74xhBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1EHP49OvYB7b9Z8kMJh4vFxdmKlf2UcRzqxhVO1aMq7gZKSBwbLtof3ZMNy/CpoTYb9NpQqFMQI4RxklLdGOVOth3bsALfnFkvywWWacGTtaLA92TefZt0C26ku8/gnvaTByE71khv9OsBlnY09amJDmfzX+720WIiRQQDHBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoM70vIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755074476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
	b=IoM70vIoIA0WG1EdZbTiMQ0U4V+1909tSy1OpO1jwGx5t8R+/d1jylMILVtcNr4nj+8pb4
	ONHj5BYRF3f04J+iX7zO1nwhhcECeSnDEJjAPhgEGZOGLXf3GZ1zN0HHmCDwoumydMcnZy
	EZdoCzFRppyAe5bGCWone25YoKdQgLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Sipyb4tkPN211No2s3zyvg-1; Wed, 13 Aug 2025 04:41:14 -0400
X-MC-Unique: Sipyb4tkPN211No2s3zyvg-1
X-Mimecast-MFC-AGG-ID: Sipyb4tkPN211No2s3zyvg_1755074473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458f710f364so41836965e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074473; x=1755679273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
        b=pYZNoHSfFUm3sznVzxMmtwrrSVNIMWBSEA45Dh/em61B6cn79LGT5I15yOoKvNW/sG
         MO01wQKYzlqOdsD5Nz1fdvzVpXteC4A75fpxAFUL7q2gnjosui0pjzqOwXsJueQsZGV6
         MkL0vbGrBDybxjWKNWUgXeGVJNOo2K8Sk8FIDrm7SzMixq8BFh7PrlazPD3WXQjSDLZb
         zAQjGCxLkrjb4Z1fCoaAGEapJ9lb2679kaD5peYZfsbywjwJtVC/xKjUxeOkWLYgysEc
         YfFGGz7fMS1QT4SrTjIme+tz4o3N02dUYVLRM5Y6vinK+mdmNXNh41/md8ZDbneLN6fD
         HBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1yW4eq/ofAZRp6M/7vWRc4j55DB8uKMpIuEVAb18pWXodSpuLe8yz2sDrZVD7zZgmqTBUc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKLGmkNGG289WJMwFwGWzElvXokFuxzQ1+I8m/MBoClGjMOUG
	tcWX+miq1PpPCVnGlCi3TJbzV6cprEuvrbbz8nY6FI9ZB02n62+51zLvTO9NWxmS5U5Zcdy7mFp
	D4Ct4xCaD4LotOJ5QJQ5uhYdTALDrlXgR0xmdXs1ec4kES883SHhTCSsFgw==
X-Gm-Gg: ASbGncuE0GoSo+CnkG4uc7EVLpP65tFzlo2Zmm0UYEiwRhVfNwwY+2eKG6QlBQfCOKU
	IoLhiV6UHDHMo5dGNGknWklUFRUyjk7FnmAm+6H2zU60oMmRnpzSYyBetTdHsihJSSpz+JI45nj
	OZZRxdy+E3+HXuZBYydgXyEjMjNyS1KRgLVzPX6DQQoLgEoRECZ43lU6aRgk5e50CHEY7gbGiwG
	dBDExKylLhcI/2EMM5gdawW22si71wEvIo0ek2TmtECOtUB3xGPkelmfXC8c/mLdC30pZdFuoJG
	luiQGMrW3Vgzve42Cc0KbqPI9MYbH2ha
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15732945e9.28.1755074473344;
        Wed, 13 Aug 2025 01:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAoH7imNQ2C+/iwNJvGO5T7E2kVVUhVdyltcXD3iFW1FubZdXr/O++cAjLCc7t/dYIu5pcLQ==
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15732735e9.28.1755074472965;
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16ddb9fbsm19841985e9.9.2025.08.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 04:41:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717090116.11987-10-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> transmit data. Unfortunately, these are always linear allocations and
> can therefore result in significant pressure on kmalloc() considering
> that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> allocation for each packet.
> 
> Rework the vsock SKB allocation so that, for sizes with page order
> greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> instead with the packet header in the SKB and the transmit data in the
> fragments. Note that this affects both the vhost and virtio transports.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>



So this caused a regression, see syzbot report:

https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com


I'm inclined to revert unless we have a fix quickly.


> ---
>  net/vmw_vsock/virtio_transport_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index c9eb7f7ac00d..fe92e5fa95b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
>  		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
>  					       &info->msg->msg_iter, len, NULL);
>  
> -	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
> +	virtio_vsock_skb_put(skb, len);
> +	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
>  }
>  
>  static void virtio_transport_init_hdr(struct sk_buff *skb,
> @@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (!zcopy)
>  		skb_len += payload_len;
>  
> -	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>  	if (!skb)
>  		return NULL;
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog



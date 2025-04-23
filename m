Return-Path: <netdev+bounces-185208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74FBA994B0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91CC189A6AE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C3290BC0;
	Wed, 23 Apr 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw8fzwa4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E319DFA7
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423607; cv=none; b=OheUOzJ81CDdA2tgw7iZbQzSD0SlO72WOH0wuhqONGgF1eYkB/Vpce+KXt9RDCqxw98x68mYD3gmKhu46TNPGnZR01bpr9LZuqHOqWt4Fj6ei28rCYJvFXjuy7o0K/0oKUQy9cHx4i7T8CU2rz1r4nsQTdW0lwN5Whrl2uesNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423607; c=relaxed/simple;
	bh=9F5t42L4T7DlrKAbIEzJacTshtoofiMJhhUWO+3Np/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRjdoffT/a9zAOg/1tJsM5vNeonB8U4M9yYXSaBEpo5fsj256ycfjWfB5zyARQgR7OcrmJ/xWmGQnXUUXhH/7DpEPMD3ncWJhIP+hZ62I3DmcrKV71iqltDn6Fdl1gYuMp6CLl+IzdNGnIM6qHo7WsMYtB43s+sfMkUucVSCPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zw8fzwa4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745423604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vXjdITA2otLqOLfSkM93EoHhrqfeYMofeR1JyUMjL4=;
	b=Zw8fzwa4fvBzY5pRGWegWzDtHY02t35JUjzxH1wXRLWhFhLn+Nsot461MfhVkMLOvrwzMV
	q6XZ0fipMOPZy4cY1l+OMeRKpJuzvLw/tTH9T4rbyMuMdKRQ8cn2QAvfDCrQ+3DRPL+D0M
	A65wkpXmcxbw7AL/g5F38kW7lbLsxaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ZhIczwSKNxmqRE7Ioe4uEQ-1; Wed, 23 Apr 2025 11:53:17 -0400
X-MC-Unique: ZhIczwSKNxmqRE7Ioe4uEQ-1
X-Mimecast-MFC-AGG-ID: ZhIczwSKNxmqRE7Ioe4uEQ_1745423596
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d01024089so42808545e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 08:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423595; x=1746028395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vXjdITA2otLqOLfSkM93EoHhrqfeYMofeR1JyUMjL4=;
        b=E+SWik1CRNPT3EK9Mf/y+/0PiDn8Vfk8HKTqM2MpMzxO53jjTuFU69WfBH4hc5qzBT
         L6Bi+JjU4jw7b8VH3mzeAw46GJ9aawOH0B8AQhlCwLaQ8LuoR94fpbFSNAfJ0CK734bf
         BonSjdv/4YnJrGoy7fe9+PNudZebaHC4kAwPphy9fgiUsLz31+lBkPxCwNz+7ydBZ1FL
         nE2Tr122vxe3IOkneDalqQsIdUmzTnG7khkGvuYev0ZTdg7EhSWtnm/pzznDUfiNxDgd
         1x4ZDtjxOU9SP+6Uuvl7LM0yBG7USvLwyfP/fCAx2NSJRDRM9CYfOVVGVZ/eo+Z/caob
         rvQw==
X-Forwarded-Encrypted: i=1; AJvYcCWzrIYGvX/BV3ifOCx6vB8stBGcwqiXLTTxHd3I9uI/fcq6dlescu/xJ4kMZ5+AVpR0e30MBug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoZn718jLpKqi3X32rkIsJO61Jy6xbopcFb5cw7Kb1SU5ERku
	prim6shv8G6p2CY3V6tZNsPThYI/LQk0GGPS3ImmjKm5vQ5NDPAgcZGP6AaG7cEP8agizL0g8bZ
	cMpaNC10Fdm35S1bmgS9Z6v3aVHlX/oa+ZazTSv/GKEYO71GX0g2QNQ==
X-Gm-Gg: ASbGncsUQ4QdPhwUSOZ47EPvZ7Zl3KkWjvbRaty2Pni/lCWfJvnbrPYVo2+U9iqrvvh
	ky4HYjVH4LxNNC2O0qf44lh+ELQVgghtIK87+gaNJVLEbuSsdtSwLKul91eKPRN/YvxG+DF+RQx
	m4pTonx+Jo5BHJmaU+D86ElUvnmmmsZGKLQ0qKIqoAzlf4aOq8cmnTYFMAqFb+lgEnUuEV+C8bn
	lV+o1CDd956HQb5zIhwEBFw39c7jgOGuXYLQ+QMdRBZtZZYPVwtdyI2pdvYi4mcKTY1XmuWAzj8
	JhJAFihQ6ust2g==
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:bb46 with SMTP id ffacd0b85a97d-39efba383d1mr15395532f8f.4.1745423595610;
        Wed, 23 Apr 2025 08:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Ev46g9NwPjawD8USomZKAsrAiFv9uPuXFN35OxT/qY5CZ5sbL5NV6EP3Ne7VxwIqM91Svg==
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:bb46 with SMTP id ffacd0b85a97d-39efba383d1mr15395506f8f.4.1745423595246;
        Wed, 23 Apr 2025 08:53:15 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493212sm19371776f8f.66.2025.04.23.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:53:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:53:12 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>

Hi Michal,

On Mon, Apr 21, 2025 at 11:50:41PM +0200, Michal Luczaj wrote:
>Currently vsock's lingering effectively boils down to waiting (or timing
>out) until packets are consumed or dropped by the peer; be it by receiving
>the data, closing or shutting down the connection.
>
>To align with the semantics described in the SO_LINGER section of man
>socket(7) and to mimic AF_INET's behaviour more closely, change the logic
>of a lingering close(): instead of waiting for all data to be handled,
>block until data is considered sent from the vsock's transport point of
>view. That is until worker picks the packets for processing and decrements
>virtio_vsock_sock::bytes_unsent down to 0.
>
>Note that such lingering is limited to transports that actually implement
>vsock_transport::unsent_bytes() callback. This excludes Hyper-V and VMCI,
>under which no lingering would be observed.
>
>The implementation does not adhere strictly to man page's interpretation of
>SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d8809655fe522749fbbc9025df71f071bd..aeb7f3794f7cfc251dde878cb44fdcc54814c89c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1196,12 +1196,21 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
> 	if (timeout) {
> 		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>+
>+		/* Some transports (Hyper-V, VMCI) do not implement
>+		 * unsent_bytes. For those, no lingering on close().
>+		 */
>+		unsent = vsk->transport->unsent_bytes;
>+		if (!unsent)
>+			return;

IIUC if `unsent_bytes` is not implemented, virtio_transport_wait_close 
basically does nothing. My concern is that we are breaking the userspace 
due to a change in the behavior: Before this patch, with a vmci/hyper-v 
transport, this function would wait for SOCK_DONE to be set, but not 
anymore.

>
> 		add_wait_queue(sk_sleep(sk), &wait);
>
> 		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), 
>&wait))
>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 
>0,
>+					  &wait))
> 				break;
> 		} while (!signal_pending(current) && timeout);
>
>
>-- 2.49.0
>

Thanks,
Luigi



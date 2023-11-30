Return-Path: <netdev+bounces-52520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9407FF02B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7576DB20FFB
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F547A72;
	Thu, 30 Nov 2023 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoJLfUli"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12406D48
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701351057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HkeH8z5wAG0EZn77C+wHu/pOq81k/PDtDdYozZlz3ds=;
	b=FoJLfUli24B+UVx+Rr5c4HrWVKU1i+dSPOI6zyYXxF+ZD4x2g8aj9paSCFhGgDFs9Co2W0
	Ui6IV1c96jRhnG3gOE5uYsKxUcW9gHJUSWGeu/lUQEjqakwhNn28dwC2CvyXFu3m47X59z
	eLDtWkWmfFVCKZwiV4S2NuoxAgcmmFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-R75bpdQGMKmyFYKgdqesRg-1; Thu, 30 Nov 2023 08:30:55 -0500
X-MC-Unique: R75bpdQGMKmyFYKgdqesRg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b4a837eb8so7983295e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351054; x=1701955854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkeH8z5wAG0EZn77C+wHu/pOq81k/PDtDdYozZlz3ds=;
        b=l6WTmEnDDKTgFoNFnm8Nep9uW5RpWik+YBtyL+BDLiclNyHadLEn5YKfN6DswuG2os
         uvusJgS1ZpxBnkc2xbsmqsj7YytnxSluo3VSjPllGHbnpRkY1w48QKGgMLgvRe6eL6iQ
         fAfO3BH1xEx/XuSpa/oZmfkHuab3R2B23QwCe3+lDpgFSbohfex7GkH92/SxP59EQJ/m
         d5Tg1ECGFbbCcBlAkwtIte8IA3MqIEMj7QZyo5EbpBPcJ4O4eA7L0Mpfy3Fb5HTa1cIW
         UW3K/qzxW0PW2b6yAu7rhzSwLOps4zHbMvRDQq1hbSf8M5rWqJWm0CllDIxEf3dQjRf8
         XUTw==
X-Gm-Message-State: AOJu0YwfCaNadbkHS0N+odQn8bt769pnwskdME2Dw5JvEHfA2JSv+jph
	cAVxy0C/xXGmw6Zy/Oyu+opDEk7uwYg7Ms6fMNtAkHkX/NWue8/fTE2i3JwdZY1X2f62jSTL/wI
	vvsXeP4GzSBTkDXd0
X-Received: by 2002:a05:600c:1ca8:b0:408:3707:b199 with SMTP id k40-20020a05600c1ca800b004083707b199mr13614657wms.3.1701351054634;
        Thu, 30 Nov 2023 05:30:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjpHM1+iZPRdl+e1FulWgEAYU2ZCw+mTBg3DwI47X+uCk0eqgQ6CIDEJNG/sHqcFb+FSGf9w==
X-Received: by 2002:a05:600c:1ca8:b0:408:3707:b199 with SMTP id k40-20020a05600c1ca800b004083707b199mr13614632wms.3.1701351054328;
        Thu, 30 Nov 2023 05:30:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm5528249wms.3.2023.11.30.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:30:53 -0800 (PST)
Date: Thu, 30 Nov 2023 14:30:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <u4vwlyg3v4lpz72hnovpkifr3jduen7kwnjn5gvgm3wvfthgpd@6ftqoqjxdim6>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231130130840.253733-3-avkrasnov@salutedevices.com>

On Thu, Nov 30, 2023 at 04:08:39PM +0300, Arseniy Krasnov wrote:
>Send credit update message when SO_RCVLOWAT is updated and it is bigger
>than number of bytes in rx queue. It is needed, because 'poll()' will
>wait until number of bytes in rx queue will be not smaller than
>SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>for tx/rx is possible: sender waits for free space and receiver is
>waiting data in 'poll()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Do not initialize 'send_update' variable - set it directly during
>    first usage.
> v3 -> v4:
>  * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> v4 -> v5:
>  * Do not change callbacks order in transport structures.
>
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  1 +
> 5 files changed, 31 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f75731396b7e..4146f80db8ac 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -451,6 +451,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat

As we discussed in chat, better the order of the previous version, but
leaving the line of `.read_skb` untouched (with the final comma).

With that fixed in all transports, feel free to add:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ebb3ce63d64d..c82089dee0c8 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> #endif /* _LINUX_VIRTIO_VSOCK_H */
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af5bab1acee1..8007593a3a93 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -539,6 +539,7 @@ static struct virtio_transport virtio_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> 	},
>
> 	.send_pkt = virtio_transport_send_pkt,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f6dc896bf44c..1cb556ad4597 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> }
> EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>
>+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
>+{
>+	struct virtio_vsock_sock *vvs = vsk->trans;
>+	bool send_update;
>+
>+	spin_lock_bh(&vvs->rx_lock);
>+
>+	/* If number of available bytes is less than new SO_RCVLOWAT value,
>+	 * kick sender to send more data, because sender may sleep in its
>+	 * 'send()' syscall waiting for enough space at our side.
>+	 */
>+	send_update = vvs->rx_bytes < val;
>+
>+	spin_unlock_bh(&vvs->rx_lock);
>+
>+	if (send_update) {
>+		int err;
>+
>+		err = virtio_transport_send_credit_update(vsk);
>+		if (err < 0)
>+			return err;
>+	}
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
>+
> MODULE_LICENSE("GPL v2");
> MODULE_AUTHOR("Asias He");
> MODULE_DESCRIPTION("common code for virtio vsock");
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 048640167411..9f4b814fbbc7 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -98,6 +98,7 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
>-- 
>2.25.1
>



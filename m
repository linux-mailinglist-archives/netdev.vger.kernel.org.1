Return-Path: <netdev+bounces-55862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72D80C90E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D565B20EB6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4E538FB0;
	Mon, 11 Dec 2023 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoDGDhK2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379FD8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702296593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iD7SbymiWWK9UIngr+OU7k+vj/QXuQMXgXungJy+RzE=;
	b=YoDGDhK2/KGbYdM+kusJCzq9Nw5hddHi5uOwzXMTd/V5aeCJupvSJqpMGb0GHwMyGww1Ep
	tWQHQZ15RHhlimRYqr12w41b7Xj81ZGhLViDF3+noSXjDAymSP5Fvt8hGslV/5Zyok1mkJ
	51HgbjRtqbzvRE4dBUdftovV5AQ6WrE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-OwlvZbAqMgy_5IEJaROKRw-1; Mon, 11 Dec 2023 07:09:52 -0500
X-MC-Unique: OwlvZbAqMgy_5IEJaROKRw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a696be34cso63079146d6.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296591; x=1702901391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD7SbymiWWK9UIngr+OU7k+vj/QXuQMXgXungJy+RzE=;
        b=B/SQTJ9PYIHpWW9OljhlUR+rLJc2p3PPLJMk2Iy3mO/O0fYtXpv55c3mPKTq3b4ryx
         O0+OA1TGVsW7+OfkiO10Ev4Vq9BMNrCxGXZeBq2llhmFYkmADP9TBrdVNrTBg+BBsRMN
         NceJ6Uur/2I0HQjBdShAI1VESfDgQTwCA3cbg14dfo23fEmx3Nh75dKiW1HVrtTH7zXc
         XyzgmPJ1IqAEEof+irRyvgqO3ea0xKguXdXtqn6XS3LwhMJ7ep9AR7xuE31sHSlS/RjO
         Nty7F1Eq+ipbgbqSXqBsMEGzS6Q0y3cSJnzwgl8oK5sqIiyvRfPjL6Eg13INHtX9Lubf
         N6UA==
X-Gm-Message-State: AOJu0YzW3Ekrt81I5hXpzrTnjupLKoQnFT3IhDxNTN8RSgLro+EK5jH2
	XrB5VMTFQFup+6/n1UTMEZ47kTvH3P/EUwmKqaLVgfV4B6EFUijQFkJeRsTGw2VnwFsp+A3ruid
	byn1vNmedDB6aRv2g
X-Received: by 2002:ac8:58c6:0:b0:425:a72b:9a69 with SMTP id u6-20020ac858c6000000b00425a72b9a69mr6644328qta.20.1702296591501;
        Mon, 11 Dec 2023 04:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqYA58QP3qDEB7bnQgzPbMS64tiKkcJRGjBqt/icJkzO6Y17Wlog3jW+8/G6rcL/w28bSfrA==
X-Received: by 2002:ac8:58c6:0:b0:425:a72b:9a69 with SMTP id u6-20020ac858c6000000b00425a72b9a69mr6644311qta.20.1702296591201;
        Mon, 11 Dec 2023 04:09:51 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id j25-20020ac874d9000000b004257e4c5e21sm3124366qtr.28.2023.12.11.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:09:50 -0800 (PST)
Date: Mon, 11 Dec 2023 13:09:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 2/4] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <5b6duib6nre43ak5kzjgtfrnov5ogd4clka2hgf2xlgpm4jmw7@wbm4jxxslrm6>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231206211849.2707151-3-avkrasnov@salutedevices.com>

On Thu, Dec 07, 2023 at 12:18:47AM +0300, Arseniy Krasnov wrote:
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
> v5 -> v6:
>  * Reorder callbacks in transport structures.
>  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>
> drivers/vhost/vsock.c                   |  1 +
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport.c        |  1 +
> net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
> net/vmw_vsock/vsock_loopback.c          |  1 +
> 5 files changed, 34 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f75731396b7e..ec20ecff85c7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -449,6 +449,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
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
>index af5bab1acee1..f495b9e5186b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -537,6 +537,7 @@ static struct virtio_transport virtio_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f6dc896bf44c..e137d740804e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1684,6 +1684,36 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
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
>+	 * 'send()' syscall waiting for enough space at our side. Also
>+	 * don't send credit update when peer already knows actual value -
>+	 * such transmission will be useless.
>+	 */
>+	send_update = (vvs->rx_bytes < val) &&
>+		      (vvs->fwd_cnt != vvs->last_fwd_cnt);
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
>index 048640167411..6dea6119f5b2 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -96,6 +96,7 @@ static struct virtio_transport loopback_transport = {
> 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>
> 		.read_skb = virtio_transport_read_skb,
> 	},
>-- 
>2.25.1
>



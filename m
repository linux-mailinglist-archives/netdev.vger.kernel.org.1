Return-Path: <netdev+bounces-238015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BCC52BBB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3B5000DB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9F2882D3;
	Wed, 12 Nov 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ/uAoZp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mgx8VefC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D32877CF
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957202; cv=none; b=g0/sLdnKQF8Ob+b3+6RMDEcgbsZqHENertXmo04OMcVAkurti+3HSn8OfVPfgm1OXgCghVK5Wh48lgQpOdRncsRb0lW/ijZ6HNl0njBibalXw5Y8POii3FZgOiPh51al8lpw2H16luV5Spl1JueEJrrbJyVtln5SJUZN1HfdQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957202; c=relaxed/simple;
	bh=PVntb2BSTfgxGvHXA7fBKjxKBk524fvSPNiMDc3Jeaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go7WxsKUXJk3Fe3gUbfLZ517U2awxzY43fiTQYu7ZX1ZOjXHNET1Au/a+PoO1OyAR9GdrabDZ1BdkbxDDPqpXc1lFzSuY8kXJ3jI2FbvNXH6yVSgvo0zg15nymbqvxrHzTtPAf2UuyFoy9KXPt0tgQtvML5NEOKnikpZCF4I6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZ/uAoZp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mgx8VefC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fvJ8DI8yzWgvipfLG1PvQUojZWITC98CP9M0AZNibU=;
	b=WZ/uAoZpHQ6Y2QCH3bV+MKmFwVJIgmaNd8qRa2Y4CKLbxJWqu9R9Jv2XRz+GdEnMRmc5F1
	uROEYoG1vEGWi8UmoRt3EnytqvyP3/Gc0t+YuV6l1fvnsXBgXsTP+fWOt48+Le596p4A5B
	to1lBbQrBCONulrnLhDy6tW3fdUJIXg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-KuXG7GGdPZKqpSFKgzI9fw-1; Wed, 12 Nov 2025 09:19:58 -0500
X-MC-Unique: KuXG7GGdPZKqpSFKgzI9fw-1
X-Mimecast-MFC-AGG-ID: KuXG7GGdPZKqpSFKgzI9fw_1762957198
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b234bae2a7so262040285a.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762957198; x=1763561998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fvJ8DI8yzWgvipfLG1PvQUojZWITC98CP9M0AZNibU=;
        b=Mgx8VefCFzKHvorVwWDthZTNGP7V14+atg60tx54t51pT5430arCn1CUSrWa5Tu4Dp
         Lok5iExfuSkwQh739dEaY/fEd8g8Lq4vbbrprmzrVtQGFUPM+v3On398AkyCU8TwqnaK
         S4hsR1xxjVoX4LVa4elEw4gchtx27bR82/xac2rdO0OVxQj5Uz5l7rH9+rb2ixeWrhMs
         Pv4T9GeYZDgrmIvWWxPzuS1LVEdgrrsu92NzK9PyGyEpFfR08b9xVoDSa0OvSR72zbbJ
         yj3oN7xrhRa57FHyXCdxIE8HrnHvOEgchDEe1SpgyDwOADo70v62S+tEzDh1pEWuyRPY
         5BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957198; x=1763561998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fvJ8DI8yzWgvipfLG1PvQUojZWITC98CP9M0AZNibU=;
        b=V7H56PO0iRyAV3fyhlCAhjoCY9xTgo+R4R5Skduubc1s1/moX6l8FJ4EvMyaHpR49J
         8XNjKWJiQ02egQm8TyicOh6+d0iZ/9vCDynNsOy/SIUNrBExaRuNzNiuVmSpPpSNxrui
         /NTrSu/H85KtCSlHJ6wiAfVHJXkWK+lwnNTbHmidk5WY2qgSpMi7kML6jY9LhT1MSU/W
         nCldMYQr5jE2/skoS5Vy3lv2TvkVN5NXjv1ue9Hrt8uE8QqXwOwnRJzZ3J3nrTi6lNEJ
         TLK60xJx4O1V8eut/6zJWL0jKxA+gBzJBSp9BS8mjQ49165i401UR8Fv+v6x/vD6A2jH
         kksw==
X-Forwarded-Encrypted: i=1; AJvYcCX1MfMm79R7Dju7TzPN9PTD/6d67MzrKuwMBJLQxbxp8IW8cFdYrp31hFyU/mPT9nyH1RfZkP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfgNC2pSgMLBSCef81kL7+8UaeBKsFBFq1ObmFwISjbIO+1Vpn
	Dhk7OSUlHoN7eP5OACbDOEY2Le/cbZ4Y8GwTuRk4fbmEh+HPsd3mq7T5Xckea6FuwXT/7nDRKkc
	0EtGG6tEs5ZNoGjF23WJhJ+lJw3D3mcMJ0L8qU1bpFsdKrwNCBG0Vt2da1w==
X-Gm-Gg: ASbGnctSSrEL1REabAylYIUNvuwUmye5zzaQdTPdDfSSpW3OjuJD7XyZPC264UA6fbP
	drjGVujKPXBFLt8/0cukACZADRG+a8ybXcbUfNhgydwGFbzWF2jvdY8g1zFBff+3H9KlCU4yezv
	Gt7R0sq4Qshr/JuRA9r2wxs+fiw1y9C69XJRLPr1FR/X1R96tEu0cLMkqTkE7+on13qyAm13mke
	+d3u7iUbViV0SDbq+3AeS+gKKvWt9jSkBJHrpipx5Ap5Y/mEQF7cOfNK/avY41vaZvpzDUVTO2E
	nB23ZH6i6KXkTXqZS4oX02NiPRGtLBulRmdZhqUo3O7SdyI2n16H1d48Q16j2tGT3tYVyNZXnDU
	wLdp6IvWVTnoXf2G/vU3oOsLZvaYynt8H8qXmdlT5ZH6vby46kBA=
X-Received: by 2002:a05:620a:2908:b0:7fd:50bd:193b with SMTP id af79cd13be357-8b29b7995e5mr359222085a.14.1762957198078;
        Wed, 12 Nov 2025 06:19:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGipP1i85s1TBBlHy52i8ksqPLt/jyXQBgKffbZLvZKkESyO508uVIZ0idiP4Cg09y9La+WwQ==
X-Received: by 2002:a05:620a:2908:b0:7fd:50bd:193b with SMTP id af79cd13be357-8b29b7995e5mr359214185a.14.1762957197396;
        Wed, 12 Nov 2025 06:19:57 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6c95sm199495685a.29.2025.11.12.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:19:56 -0800 (PST)
Date: Wed, 12 Nov 2025 15:19:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add NS support to vsock loopback. Sockets in a global mode netns
>communicate with each other, regardless of namespace. Sockets in a local
>mode netns may only communicate with other sockets within the same
>namespace.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- remove per-netns vsock_loopback and workqueues, just re-using
>  the net and net_mode in skb->cb achieved the same result in a simpler
>  way. Also removed need for pernet_subsys.
>- properly track net references
>
>Changes in v7:
>- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
>  handles this automatically and race-free
>- flush workqueue before destruction, purge pkt list
>- remember net_mode instead of current net mode
>- keep space after INIT_WORK()
>- change vsock_loopback in netns_vsock to ->priv void ptr
>- rename `orig_net_mode` to `net_mode`
>- remove useless comment
>- protect `register_pernet_subsys()` with `net_rwsem`
>- do cleanup before releasing `net_rwsem` when failure happens
>- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
>- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`
>
>Changes in v6:
>- init pernet ops for vsock_loopback module
>- vsock_loopback: add space in struct to clarify lock protection
>- do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net()
>
>Changes in v5:
>- add callbacks code to avoid reverse dependency
>- add logic for handling vsock_loopback setup for already existing
>  namespaces
>---
> net/vmw_vsock/vsock_loopback.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 40 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index d3ac056663ea..e62f6c516992 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -32,6 +32,9 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>
>+	virtio_vsock_skb_set_net(skb, net);
>+	virtio_vsock_skb_set_net_mode(skb, net_mode);
>+
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>
>@@ -116,8 +119,10 @@ static void vsock_loopback_work(struct work_struct *work)
> {
> 	struct vsock_loopback *vsock =
> 		container_of(work, struct vsock_loopback, pkt_work);
>+	enum vsock_net_mode net_mode;
> 	struct sk_buff_head pkts;
> 	struct sk_buff *skb;
>+	struct net *net;
>
> 	skb_queue_head_init(&pkts);
>
>@@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
> 		 */
> 		virtio_transport_consume_skb_sent(skb, false);
> 		virtio_transport_deliver_tap_pkt(skb);
>-		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
>+
>+		/* In the case of virtio_transport_reset_no_sock(), the skb
>+		 * does not hold a reference on the socket, and so does not
>+		 * transitively hold a reference on the net.
>+		 *
>+		 * There is an ABA race condition in this sequence:
>+		 * 1. the sender sends a packet
>+		 * 2. worker calls virtio_transport_recv_pkt(), using the
>+		 *    sender's net
>+		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
>+		 *    sender's net
>+		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
>+		 *    reference to the socket
>+		 * 5. the socket closes, frees its reference to the net
>+		 * 6. Finally, the worker for the second t->send_pkt() call
>+		 *    processes the skb, and uses the now stale net pointer for
>+		 *    socket lookups.
>+		 *
>+		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
>+		 * and hold it until virtio_transport_recv_pkt() completes.
>+		 *
>+		 * Additionally, we must grab a reference on the skb before
>+		 * calling virtio_transport_recv_pkt() to prevent it from
>+		 * freeing the skb before we have a chance to release the net.
>+		 */
>+		net_mode = virtio_vsock_skb_net_mode(skb);
>+		net = virtio_vsock_skb_net(skb);

Wait, we are adding those just for loopback (in theory used only for
testing/debugging)? And only to support virtio_transport_reset_no_sock() 
use case?

Honestly I don't like this, do we have any alternative?

I'll also try to think something else.

Stefano

>+
>+		skb_get(skb);
>+
>+		virtio_transport_recv_pkt(&loopback_transport, skb, net,
>+					  net_mode);
>+
>+		virtio_vsock_skb_clear_net(skb);
>+		kfree_skb(skb);
> 	}
> }
>
>
>-- 
>2.47.3
>



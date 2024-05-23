Return-Path: <netdev+bounces-97759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC158CD093
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643C71F22D59
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F11146013;
	Thu, 23 May 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrlmGANq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF42144300
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461070; cv=none; b=bUGTTUZ4OzIdU3jn4vowIbLPSU3eU6LHw79ChOwnvN934Vb/A6CEhr5LlEySRxwS9cWBL4rjJBtvrSUJXNhs3AEhaOVvpheMK2dyyNp9BIFkjtRh0/kE9UdeSqbl9HL2ZI/4Mc7GbYylD22LzX+D7CEFJD5OJubXDv3BXti8YMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461070; c=relaxed/simple;
	bh=5hx2fSiT2DY4uOpmEnaz0dH8rVhtHW/XCwPNtgDvYrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcHKXqPWg1SFNbdI9yxAK53/99gglgs/3lLHn5GsryUwDFRXBQfiGwTeSt5m3qQkTkSCNOVVzeqbfQ8uGM4vUyTNWbQmE0yc5idjzjOC1O8iw1XPsG8lKtWWE4NuRi8VNyWgZdKVolb/hucGZym5ip1ABBgg/6LBk/+4DrzuRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrlmGANq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+b8FaGjpy1m/+RszNBOW0Osd/3HyG6oUQQPlglChFwA=;
	b=ZrlmGANqUk02/p2DlxIAjjQkjsGLceI4MwBiV0opvzx00xQDl91hbefSiHd+edY92SBzLO
	hOt7Wm420QH6zOvVSu+ImmhZ4pu4/eiAP5Uwb2MUDVFmU0fkH3GA2DAvWpBd+KSYHBBuw2
	NO2GK+4mMxwPm3O/LSBqWjKz5gIvwv0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-I_dEhCXGMO2PgbqcGqVbGw-1; Thu, 23 May 2024 06:44:25 -0400
X-MC-Unique: I_dEhCXGMO2PgbqcGqVbGw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7fc4842b9d1so5498770241.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 03:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461065; x=1717065865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b8FaGjpy1m/+RszNBOW0Osd/3HyG6oUQQPlglChFwA=;
        b=c3nh5DXjIfugpOE6Scrs09ERkegDlStPG3CL8mO1hGu6EH6kAomUA+nLVY4vSsc6Ck
         flU8BdLri2xuuFw1HS2tCga/nsyIrwipsE+dpSkzBAVlWgEcWVtEhjVeO8Zyhad4vUt7
         NG82pgFe3ho/noAE+qEHyqDONSBXq7MFai/LAgq9JqfJSr1y9GWbvxyPXN/HWRjZIBpY
         pVGowRwUu/lkFkti1XskE7wGgw42fWJz/ln9/2+r0QQmxoPiNK3sr8ZMNHa66U+BttWu
         Ylx0jgr9qt0y/KOzvCenFVfOg5TCmBnncfvK7ARawmaMJfRgvDFo+OFlOgWchZO2VKs7
         PI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhDUYHTXpTKf1iMiiWYZseJPHW4xED7mkYKKaYI+arl27ZkrrbA5agjn3YS/xedqvv7eGOE8AWkAg5G7NC62HzW0qNepie
X-Gm-Message-State: AOJu0Yz3pxuUT+ryO5OwceSgALoDbMQgY00JYYxcVffw/w3EX4gLtnKv
	0puw6h8GlNfkIBUbEB8YNN+SRX+ylsUaTqiWF5vnb7Uf9hmSDYOZZEiazeufXN3tk0naVSF439H
	WXL7Vz4hPbd8F4HnxkqZucEbDfd4p9eYv0CiKloBzzieeTlA8iAbbrQ==
X-Received: by 2002:a05:6102:6ce:b0:47e:ee4d:8431 with SMTP id ada2fe7eead31-48900956d84mr4979033137.3.1716461065114;
        Thu, 23 May 2024 03:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdYH7eg5e7F0lmFvh+zqemu/wAXsYnj8cJrd8nRmIqAi48RSdPDX0vAHPDdTcHVnbmyC6Ojw==
X-Received: by 2002:a05:6102:6ce:b0:47e:ee4d:8431 with SMTP id ada2fe7eead31-48900956d84mr4979019137.3.1716461064769;
        Thu, 23 May 2024 03:44:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f991bb19dsm25568231cf.63.2024.05.23.03.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:44:24 -0700 (PDT)
Date: Thu, 23 May 2024 12:44:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 3/5] vsock/virtio: can_msgzerocopy adapts to
 multi-devices
Message-ID: <dv6zyjbcl7zlkyzxc5q67zyq6sef6a5dz2nslb4ezscruhvi4d@pxjvo5t7zftk>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240517144607.2595798-4-niuxuewei.nxw@antgroup.com>

On Fri, May 17, 2024 at 10:46:05PM GMT, Xuewei Niu wrote:
>Adds a new argument, named "cid", to let them know which `virtio_vsock` to
>be selected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/linux/virtio_vsock.h            | 2 +-
> net/vmw_vsock/virtio_transport.c        | 5 ++---
> net/vmw_vsock/virtio_transport_common.c | 6 +++---
> 3 files changed, 6 insertions(+), 7 deletions(-)

Every commit in linux must be working to support bisection. So these 
changes should be made before adding multi-device support.

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..21bfd5e0c2e7 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -168,7 +168,7 @@ struct virtio_transport {
> 	 * extra checks and can perform zerocopy transmission by
> 	 * default.
> 	 */
>-	bool (*can_msgzerocopy)(int bufs_num);
>+	bool (*can_msgzerocopy)(u32 cid, int bufs_num);
> };
>
> ssize_t
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 93d25aeafb83..998b22e5ce36 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -521,14 +521,13 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>-static bool virtio_transport_can_msgzerocopy(int bufs_num)
>+static bool virtio_transport_can_msgzerocopy(u32 cid, int bufs_num)
> {
> 	struct virtio_vsock *vsock;
> 	bool res = false;
>
> 	rcu_read_lock();
>-
>-	vsock = rcu_dereference(the_virtio_vsock);
>+	vsock = virtio_transport_get_virtio_vsock(cid);
> 	if (vsock) {
> 		struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index bed75a41419e..e7315d7b9af1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -39,7 +39,7 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
>
> static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 				       struct virtio_vsock_pkt_info *info,
>-				       size_t pkt_len)
>+				       size_t pkt_len, unsigned int cid)
> {
> 	struct iov_iter *iov_iter;
>
>@@ -62,7 +62,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>
> 		/* +1 is for packet header. */
>-		return t_ops->can_msgzerocopy(pages_to_send + 1);
>+		return t_ops->can_msgzerocopy(cid, pages_to_send + 1);
> 	}
>
> 	return true;
>@@ -375,7 +375,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>
> 		if (info->msg->msg_flags & MSG_ZEROCOPY)
>-			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len, src_cid);
>
> 		if (can_zcopy)
> 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>-- 
>2.34.1
>



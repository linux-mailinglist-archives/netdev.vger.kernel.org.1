Return-Path: <netdev+bounces-164818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3630A2F452
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD47A317E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51325290A;
	Mon, 10 Feb 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvlJLmSY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA662586EE
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206353; cv=none; b=uCEpULF7LQVM4sVfvnONrdawnmcsa/voNFIftcCgMQ7nCjbHASeWAKrddbUN+ySEXcuomSdtYiJMGYu7hatdhKtQL8sfRftD/ZyhW8hCXBxcpkVIjvuLlIjSz4W7W36G2RoU9LbG+V+kTU6hajqVAwCuvorvGyJ2kj2hT2AgDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206353; c=relaxed/simple;
	bh=0D7FejxdMSdNwq4d8Iw/FTH+8Vh58GxW2QYBqWIyCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADe+bh1gPgkQtbw2COWcQAnjahBxzuMSJ47u3xqIUeDLQu4UZyTISGhh+8xpNWojoyWW29kir7CCpa4SjqRRSI1xttf80An6bumJDRcNl0tD5VcG0t6KKrla163YBcw2cHyYisx9TTLZWDJXjZyQYRET50/q3b7cQkjHK7aVxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvlJLmSY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739206350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jobaAwA+Fk2dqvWn152x6BfQDd/w8Mf+7rUPoxAJHww=;
	b=gvlJLmSYOOvN0BcOAlILD4mv/+VhDydJ/G8VwTRXCqZUlkKNFKhTiT7wsljXyAsZ9O+iuj
	H8+ThSoNzST1P6Kjiqg4ouAOx1HJTzM3dzzlYsXbmBB2j80a/Gco47KFxsn3fU4taXjKD3
	V+iDj01+jtUiB6UuAzvGoimiATUOsVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-lh40rPwaN_uDqFa1SH_jmQ-1; Mon, 10 Feb 2025 11:52:28 -0500
X-MC-Unique: lh40rPwaN_uDqFa1SH_jmQ-1
X-Mimecast-MFC-AGG-ID: lh40rPwaN_uDqFa1SH_jmQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947979ce8so4925335e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206347; x=1739811147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jobaAwA+Fk2dqvWn152x6BfQDd/w8Mf+7rUPoxAJHww=;
        b=RZ41IvhTcMbtRUp/wZaOy0w3y0zTLKi3ONp2KNn0Tlr9KSDnvtondArNuYheTIQePJ
         mLNGEVgZ9/k4tWPiQceAFjiWuhyH64hZyrGTsJj8g275wxJ38OKLZXW2lbFFDhouCkxl
         6bLfdRAb3GcfrIFL8vvyrirVO9GA6Y1g1BX9YBwAjptwU7/I+iB2484Hy4EM7IP7EBHH
         ZgJH/dbd7B5GSjkVaSKXpqe5jrcFozAY2tXRQHUkD7zx8qiARq6cqlmaHM1uPitMJiuO
         CCyYI1u0ZPI1l2BA8G4t5NNYcBPn9eJwIDA6He35emIPQsupAJ+NZ+pJGum43V4rR2va
         zlnA==
X-Forwarded-Encrypted: i=1; AJvYcCVqgS6/LEJcBV8LSya8V1CA7HDt73nBHirMnEzCdvdrU9imoLp4RK8VcTEfx88QJ2g+rFyzugg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbo/J9fFnCrZ8DA9CXFaLT2eniIX7hvSK/9ONt8iwbSpjASim
	MzzID4wyn1oEJ1wqVHIOd9Ag5yR/5U0Spmm7DL6/cAK8jewaBsX1YIzZN0myTNvRn76pFdLGkKX
	AoilkBNnmJMR1S82bFriMmsAxuZsAa1bWLF7AzWquWeAcdjabe/aq4Q==
X-Gm-Gg: ASbGncsO75MKNLDmotPlFnn0kbPONqVNwuLz0JKrastuGSJPc68aNoOiCknFg+NkJeD
	Bk1hoFCk6BZjMnPCUurNJvMd2Ahj5UoEyKeZo11FNGE6muBIpm0Ch4JeOU8UDvGBaP+QIoCJbDR
	I60HTSuZ3weJzeYS2tx5gXjB6TkX1qpLyGbjEgJdzjPVr0Pxfw9yZ2FowUfSzmi0Ffizrnlx7nQ
	8WzVI8FFg1t+PrUEJgUgqVp/lAdk9XG6SJkT9H80G+pJM59FXmUXDfYzCFR1NW1AawA43jAFJCH
	Jq/05ZonPejuTDIEzCxFwLdUWzEqyNLYu5pj7eXR1ZL9fFy7m6LFDg==
X-Received: by 2002:a05:600c:4589:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-4394c808849mr5820125e9.4.1739206347629;
        Mon, 10 Feb 2025 08:52:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzQ/jMNKz482G2FvYPl7tsnY56iQpM2aodBvtMBbJOao7+wP//TbIwcCW+7o1f40GNOhLyTA==
X-Received: by 2002:a05:600c:4589:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-4394c808849mr5819735e9.4.1739206346931;
        Mon, 10 Feb 2025 08:52:26 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcb88d5e6sm9636306f8f.1.2025.02.10.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:52:26 -0800 (PST)
Date: Mon, 10 Feb 2025 17:52:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: leonardi@redhat.com, Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb>
References: <20250207052033.2222629-1-junnan01.wu@samsung.com>
 <CGME20250207051946epcas5p295a3f6455ad1dbd9658ed1bcf131ced5@epcas5p2.samsung.com>
 <20250207052033.2222629-2-junnan01.wu@samsung.com>
 <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>

On Mon, Feb 10, 2025 at 12:48:03PM +0100, leonardi@redhat.com wrote:
>Like for the other patch, some maintainers have not been CCd.

Yes, please use `scripts/get_maintainer.pl`.

>
>On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>>From: Ying Gao <ying01.gao@samsung.com>
>>
>>If suspend is executed during vsock communication and the
>>socket is reset, the original socket will be unusable after resume.

Why? (I mean for a good commit description)

>>
>>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>>only when the function is invoked by virtio_vsock_remove,
>>all vsock connections will be reset.
>>
>The second part of the commit message is not that clear, do you mind 
>rephrasing it?

+1 on that

Also in this case, why checking `vdev->priv` fixes the issue?

>
>>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Missing Co-developed-by?
>>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>
>
>>---
>>net/vmw_vsock/virtio_transport.c | 6 ++++--
>>1 file changed, 4 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>index 9eefd0fba92b..9df609581755 100644
>>--- a/net/vmw_vsock/virtio_transport.c
>>+++ b/net/vmw_vsock/virtio_transport.c
>>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>	struct sk_buff *skb;
>>
>>	/* Reset all connected sockets when the VQs disappear */
>>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>>-					virtio_vsock_reset_sock);
>I would add a comment explaining why you are adding this check.

Yes, please.

>>+	if (!vdev->priv) {
>>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>>+						virtio_vsock_reset_sock);
>>+	}

Okay, after looking at the code I understood why, but please write it 
into the commit next time!

virtio_vsock_vqs_del() is called in 2 cases:
1 - in virtio_vsock_remove() after setting `vdev->priv` to null since
     the drive is about to be unloaded because the device is for example
     removed (hot-unplug)

2 - in virtio_vsock_freeze() when suspending, but in this case
     `vdev->priv` is not touched.

I don't think is a good idea using that because in the future it could 
change. So better to add a parameter to virtio_vsock_vqs_del() to 
differentiate the 2 use cases.


That said, I think this patch is wrong:

We are deallocating virtqueues, so all packets that are "in flight" will 
be completely discarded. Our transport (virtqueues) has no mechanism to 
retransmit them, so those packets would be lost forever. So we cannot 
guarantee the reliability of SOCK_STREAM sockets for example.

In any case, after a suspension, many connections will be expired in the 
host anyway, so does it make sense to keep them open in the guest?

If you want to support this use case, you must first provide a way to 
keep those packets somewhere (e.g. avoiding to remove the virtqueues?), 
but I honestly don't understand the use case.

To be clear, this behavior is intended, and it's for example the same as 
when suspending the VM is the hypervisor directly, which after that, it 
sends an event to the guest, just to close all connections because it's 
complicated to keep them active.

Thanks,
Stefano

>>
>>	/* Stop all work handlers to make sure no one is accessing the device,
>>	 * so we can safely call virtio_reset_device().
>>-- 
>>2.34.1
>>
>
>I am not familiar with freeze/resume, but I don't see any problems 
>with this patch.
>
>Thank you,
>Luigi
>



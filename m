Return-Path: <netdev+bounces-164806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A29F9A2F2F2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56A218893EE
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08E2580C5;
	Mon, 10 Feb 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X90NPkgE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163F2580C7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204175; cv=none; b=tPsqF0XeJPLQuU+vc3jNj+8D+4NRlC75tyh0B/mNhJCvTDsrM/qmT3eF3k4nugCHzY2C/l9qBWzJCyGj8gpCjkxjEslwGsQ3ZgCrP02DIBQoygW6Ko40z1FFpCDU0knq40Bxz/lkC73diNoufykx6zYdEowX2KZtevAdMCxEXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204175; c=relaxed/simple;
	bh=1jcS+7FsjGMJ5ImWaUmKT2uzq8IjSodR7EIZMko9OZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfHsgCiL1YcqYB8dEK3NBiyA4IcidHEV0ImB4II1xV1MU8y9WYwHLocKNsaPJ0oyn/94ByC6qiEibmndtmie1Hsel7gxeSMBlr2IoX6G5FDobVtanF7BhQC7nxmPrxj2ZWzWxQ75QOUv0cG1Nv1+JU63eQbJF/JKr79GQICr+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X90NPkgE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739204172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNXSpIDMbsYdI6rFjnVldoS4vIPojHfA/xPTtZaSU8I=;
	b=X90NPkgEXVlCIsBD/ayM0MEEAaK0MxSJFiuF92UskLJ+fqyx2BMa4VWhk7XOTMTCeSH34+
	Mngb0JPsEVQ60Ntdb8G/ESGqqs9fLSlZbTvMrwTMGO/8qnLhwW0yIdHiVpoPeQl36QBzwV
	KdWYugcGSi7Z4cw+NDH524sg6mpnXD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-VZtJvyF6Ohu2r3tcC9AFfg-1; Mon, 10 Feb 2025 11:16:11 -0500
X-MC-Unique: VZtJvyF6Ohu2r3tcC9AFfg-1
X-Mimecast-MFC-AGG-ID: VZtJvyF6Ohu2r3tcC9AFfg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439385b08d1so13542895e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204170; x=1739808970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNXSpIDMbsYdI6rFjnVldoS4vIPojHfA/xPTtZaSU8I=;
        b=LEeMcskX0EtWlNJpiQo0ZWQ3lR/jORdOjb5p7snYQB1yQJvCwHuux4dhcKP2Yeen2C
         kI3K+3atIQDDfpCLC/hiGlqDqD6coNZUPnnLkMN4Cp7OmBbIHQUUzeOGbTo2xT1elfcn
         8soFgG0KsZZbagM92BhNvO34Cp3Ktb4VPjb+0be10w8U9YwwOeR6n9I0nVh0bSjyQ2TJ
         CMvBgeJOWY2SaEidZF14nbDMJdOr+gdePesS3Cu4aNN0/LENguaoMoyvVyfjsZg7aFP6
         mniukZ9N3I7V4dQK5lyxDLHYKb0pVKTN3xJAzawXkmTCObdNp1WsS9RHX9U3D7d7c6wO
         /qJg==
X-Forwarded-Encrypted: i=1; AJvYcCWsroCLDItjHqO50KqTvb/NwuEBT7fq2mUg/l15vkZVrwiTdFd8epY2wYmiXQ0BouE4uzLRdHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx847bde3ayKQM/0Gd7zayHHq+uxWtFeliCoAoJpcgXtikV1ozT
	kTNss/kFxWqCs6Hj5wKEDfLNWbU3dz6R97HetAAWRnDj0loV0gyr0jSrkYcsmC8f3hymn0JJ2rS
	8LDeFvzZc7D67ax9yNLji4wmWSpyjoqRmzQPNyWd1df0/aaXGwtag4Q==
X-Gm-Gg: ASbGnctsunqunwncz30KeZELUoc6GvvbWdzBzhaJNNZY7MhDYBuTSzzbdohsg0ughyf
	BSntBmn18ukOdsGqfKHsyNZPICds9nGsUS71zJVylSj+PrbRL6ROviSuqHCgA1GFtCbGiOzlcem
	b4YfZ2zxk7d2PpnQz+o37FARgAYnSi0TDva6XzzSVzwJZgQUvzb79KhTjCoyeFIXays6EhJQoWL
	j7hli+ivnuJsZuZvYzTMwP3ZMg0zv2aoprGD35muLcgOWlfcVrpP8g1IE9simzqrAw2W3TpCm12
	bKviqI4S96QwTabei4Kg6O1uNXYVbBel7FpxiZ8iJ4j52sOquXX/JA==
X-Received: by 2002:a05:600c:34c2:b0:439:4a9d:aeaf with SMTP id 5b1f17b1804b1-4394a9db1ebmr15085125e9.25.1739204170033;
        Mon, 10 Feb 2025 08:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4uH/9bRhvTIF3vEIfyT9myGFn94vbG/HM+aXMc6HM0Pb2tHDTL/kGHkjMrZlOrAunNmfsdA==
X-Received: by 2002:a05:600c:34c2:b0:439:4a9d:aeaf with SMTP id 5b1f17b1804b1-4394a9db1ebmr15084685e9.25.1739204169320;
        Mon, 10 Feb 2025 08:16:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43935d4bd5csm77423835e9.6.2025.02.10.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:16:08 -0800 (PST)
Date: Mon, 10 Feb 2025 17:16:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 1/2] vsock/virtio: Move rx_buf_nr and rx_buf_max_nr
 initialization position
Message-ID: <yvdbqfahgu76eczt5c4n76akbhh4h2ofemd46kv6kia4xipeqr@tfucpayw7cqg>
References: <CGME20250207051943epcas5p4b831a4f975232d67f5849c3a2ddbcb59@epcas5p4.samsung.com>
 <20250207052033.2222629-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207052033.2222629-1-junnan01.wu@samsung.com>

On Fri, Feb 07, 2025 at 01:20:32PM +0800, Junnan Wu wrote:
>From: Ying Gao <ying01.gao@samsung.com>
>
>In function virtio_vsock_probe, it initializes the variables
>"rx_buf_nr" and "rx_buf_max_nr",
>but in function virtio_vsock_restore it doesn't.
>
>Move the initizalition position into function virtio_vsock_vqs_start.
>
>Once executing s2r twice in a row without

s2r ? suspend 2 ram?

Please define the acronym, it was hard for me to understand (the code 
helped me).

>initializing rx_buf_nr and rx_buf_max_nr,
>the rx_buf_max_nr increased to three times vq->num_free,
>at this time, in function virtio_transport_rx_work,
>the conditions to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) can't be met.
>

Please add a Fixes tag, in this case I think it should be:

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")

but please, double check.

>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

I find the commit title/description a bit hard to understand, please 
take a look at: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

In this case I'd write something like this:

   vsock/virtio: initialize rx_buf_nr and rx_buf_max_nr when resuming

   [Describe the symptom]
   When executing suspend/resume twice in a row, ...

   [Describe the issue]
   `rx_buf_nr` and `rx_buf_max_nr` are initialized only in
   virtio_vsock_probe(), but they should be reset whenever virtqueues
   are recreated, like after a suspend/resume. ...

   [Desribe the fix, what this patch does]
   Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
   virtio_vsock_vqs_init(), so we are sure that they are properly
   initialized, every time we initialize the virtqueues, either when we
   load the driver or after a suspend/resume. ...

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..9eefd0fba92b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -688,6 +688,8 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)

I think it is better to move the initialization of those fields in 
virtio_vsock_vqs_init().

> 	mutex_unlock(&vsock->tx_lock);
>
> 	mutex_lock(&vsock->rx_lock);
>+	vsock->rx_buf_nr = 0;
>+	vsock->rx_buf_max_nr = 0;
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
> 	mutex_unlock(&vsock->rx_lock);
>@@ -779,8 +781,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	vsock->rx_buf_nr = 0;
>-	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);

Should we also move `queued_replies` ?

Thanks,
Stefano

>
> 	mutex_init(&vsock->tx_lock);
>-- 
>2.34.1
>
>



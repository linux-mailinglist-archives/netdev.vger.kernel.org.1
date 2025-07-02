Return-Path: <netdev+bounces-203436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1219AF5F25
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927691890D19
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A81DE2A5;
	Wed,  2 Jul 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7NH1sDR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A762F509A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475160; cv=none; b=qndLELSl2TI8hCYujO766bhsYCH6nE5e3kMUNy+drAEcjGYsoz0klj6AlOtZkbwyyAe7C6wGWj1feQgU2saeT/KN1mwYF1mcbJZfQOVbyHESmFX3fBpzlpN19KwLWH96zd12UmYbAkczDRnGVtRNSDtkgef90YJ3momwMvAKJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475160; c=relaxed/simple;
	bh=qVCMZTaISxLivTk7+kWrRgV2aF90WxiPZyvJQoVyT4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2/NdRbAfQeJVyYbofX8ASYcBwJAFtJQtgv5xz29tUzlJ0w0IACe8epK+JQLgNL6nNPpcsG6+bGnHHJ1KyYj0kAlGLNCpKaMSAByiL/E6dzbMpISZNk9jFPVep9ED8UNe0r3qGWdISxIxHDQJJ4DvGaZanWeFLMWo7IOIAe7AK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7NH1sDR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751475157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVmK+GBkVK6o0CyGzNkEe+iO0xXlQBKsvPUrRNPTdNY=;
	b=V7NH1sDR+QkxgtHJMONdsjP9e+E7wAn5lhrzt+DsP7PvqxbtE8Q9TXqD9k2lhGJm6jwday
	XcOEecVoYEaakYyMwmBcwWgq4zQ11nQ86Z2IMtROzg8jlznR7Ft2fvK15R8STWgT31w7H7
	CI4wAk2el8Wf2Oh6R7xydZsdstRoZBw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-OSVnFm2WOImuES2Dd6mGGQ-1; Wed, 02 Jul 2025 12:52:35 -0400
X-MC-Unique: OSVnFm2WOImuES2Dd6mGGQ-1
X-Mimecast-MFC-AGG-ID: OSVnFm2WOImuES2Dd6mGGQ_1751475154
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d5600a54so48356195e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475154; x=1752079954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVmK+GBkVK6o0CyGzNkEe+iO0xXlQBKsvPUrRNPTdNY=;
        b=hCap5yApQ90TmvdX+2FrzI1cRKvv8z+e8OfYpjJQLYzBP19TaRoyHhK1FTYx6+uSfs
         y4jYFs0OKJxnI2ira1/ms6hYN/0CgAK3tmFUvZQW8fYNSl5Pky8dQdrvgu76zZMhH1jz
         w8anwdirFSRTvOzr38jOqPu58AmKv5WnhoZrLOHzykBLJYfm2r0w6lqC5nW09xbB8EWG
         oC1iNiK5JtHgizg2oHsL1WQNPwoQ0hi3jjVdhuOTBKnb3y2e2uGtBp8cebyI7/hEZnim
         NB5f7q9izQSckyCgMRJ3FfA7yTPQcWpVBqgYv2yiLTP669S6KBQ4tSvugvg8mRR5NhNN
         Sc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVv7LSA0aVBGOwNMTSUoIR6pSkwEqUhGJdheUVaPmbcu1niVR0Dlp3v++1TyMH0sT4IhYnlkaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwC3HpHiTVEugKarQrEbrCHMO9/4yvtp48aocIn0QpNuOqeTN
	nprt705Bv8ANGWj04srN6ReeVV+ysNwVjsHHiavCpxnTEgTzl97S6TejGsNPnN/zapCRVuqUS16
	OMyLMPT2ivMFnyYy0qGG+WjD0vZN5dYE12JvwZfo+b/HQOvy08m77tLsAVw==
X-Gm-Gg: ASbGnctU0/I2EmOeci+gNnU3IlaA4ZxACPK6G3jiur2H14O8vFOKqzt+/HwxaERcy4r
	hcmW/XtISfWADqUBpyhZYB2HwNiu64dws5WviZ/E232H8L92JjpOrCcAL+sXj+8Z+ozCGoyQUUt
	DblsLrBYiPhG19/7XxF7FbxMZn44nezjQfOl0AjBSJOoVKJp/79qP6eH0KaKuW0VMVS8Eo+1OGp
	gHKZlc9EvHXncwWaJmcpMPgNqqbGPyWmw8nPLef5FHZ+Om+TdxzyrWcAJCBULgJPKTDwRVIzAzw
	AQAGxC1pUVvbD/Vy31RmRpwK5IU=
X-Received: by 2002:a05:600c:3504:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-454a36e6310mr46254885e9.10.1751475153819;
        Wed, 02 Jul 2025 09:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/iMFiOin+Y92R8cOiRVQwWoz7ykHbNXjulAxwXZzp4AivEVwBGwId8u9eEgfnW6G2MVF+CA==
X-Received: by 2002:a05:600c:3504:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-454a36e6310mr46254455e9.10.1751475153179;
        Wed, 02 Jul 2025 09:52:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9972011sm3013185e9.9.2025.07.02.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:52:32 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:52:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 8/8] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <7ff2lvfjrfyx4imh3yfhimiz76znfomnm73kcrlt4rxjciamkc@ddjo7isrx6vr>
References: <20250701164507.14883-1-will@kernel.org>
 <20250701164507.14883-9-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701164507.14883-9-will@kernel.org>

On Tue, Jul 01, 2025 at 05:45:07PM +0100, Will Deacon wrote:
>When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
>virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
>transmit data. Unfortunately, these are always linear allocations and
>can therefore result in significant pressure on kmalloc() considering
>that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the transmit data in the
>fragments. No that this affects both the vhost and virtio transports.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c9eb7f7ac00d..f74677c3511e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
> 		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
> 					       &info->msg->msg_iter, len, NULL);
>
>-	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
>+	virtio_vsock_skb_put(skb);
>+	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
> }
>
> static void virtio_transport_init_hdr(struct sk_buff *skb,
>@@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>



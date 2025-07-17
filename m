Return-Path: <netdev+bounces-207799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7005BB0897E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FF17AF69F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232F28C2A1;
	Thu, 17 Jul 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro/NMiji"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF428A414
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745166; cv=none; b=ONUEs0Wa54rfsY7afxF7ZUm7UlhrKshcVFt7i36l5A8T/APzOY/be4huP/XYFpcbwj7b0dUnB5Z8H2Wz13/4aMVRlXxGqtMdf194sGLbNuyVE2OAZeYlBGN2o6rfV8s+JG8oNSvZddIp54AQBvT9x9dc5fE4qXsA6Cp3NUajXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745166; c=relaxed/simple;
	bh=dXeJz3vwBSLIWWCWuP+elspZU7SI9LsUKQsf9/I2RiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS0OJS8MWW7ceKrpOQ6KqlsT3xvVKmGQHTxCN1GNLQ4NxBFD4y2bSnZRCd0lxMApGvfdsiWlV63bhOsgKLa1uaS8pJIc7mWRialF0wTmlG0IWwC1noozKJN/C0okiFOQ8+JKmYckfFQFtU8XTGpcyxYub24nMMXxfgSrYnHoB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ro/NMiji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752745163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
	b=Ro/NMijiX9eVge9zN5YWfB1dJn68jDbTT8KRkZ4Pw6EHHcG2RGSXWjSmBTp3ip/Az/fTMc
	QVFGF0nKFvqL/JmSImRO3svU7j126lOokInPWA7sPwQxBP5y6RPksUR9ByOvnDwToGA1N/
	pDbkNnCXi27X80st/PWNS5ySSFDxtJg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-AKcZDGC0OOC_FEErePjqhw-1; Thu, 17 Jul 2025 05:39:21 -0400
X-MC-Unique: AKcZDGC0OOC_FEErePjqhw-1
X-Mimecast-MFC-AGG-ID: AKcZDGC0OOC_FEErePjqhw_1752745161
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7da0850c9e5so116037685a.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745161; x=1753349961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
        b=woDgR7GoPSW9WxX5JU7XD3RNKstevXFn/IcP8t1lAvKrpXIJrznxd24lbHTmuA45wH
         8usyd8URdi7vdqzVaLBXG3bDMzN6kC3Ig7d7xLuX3ha3KmtwakFp0dGaVfSbk0VmbpI3
         /IXDJTTCDBjWmpibF2vPsmnMu+8N0yj3+0XvUNvAEwZ/q7dfZsEMcknR4Pj3NEebOKfs
         LNdiCObBthZVTI/3LfcWGR5OH8IY/5B4kGrVoEbHZ4+H0U7dJ2PKLbW2CQlT0L/+15Tg
         Iv3eGk+C+x8onlbUlxdxnhG7mtKq228xytk6xJ0m2Mpx6fu3JsAPiWYKBOBAWhQwXaci
         28Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWFBFtafJDZd1vFzbjmcX77esqAIN51Ti4B0msDB9AQsf+hB5p0ZHu+WTata+eTUdlpYvntuZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KTZlptLMUHaokZQBXc4wuX6GPwTRXKyfCvFsqUha31S4Lh2d
	w746d/F8LrUYZgJpZULWJEiYVZY/WFVy1zc/pyxTQj4jfeQmShZm3nG2lv2SoATcAZZFFZo64b3
	0+mxPXy8inNQrDiP5KVoX23WFhAJ6KjZUQdVMqoYFqjJzjolO9J5fa2s20g==
X-Gm-Gg: ASbGncu5hfq763ThRJDHWevhDfZgljlKGak3LRsZgLY99Eo74ulnOZcvacdIE2jBXCL
	braBlDrk1iCuNyfgDh00TI/qsTzX1l4lBpxvO+gSsBQ2k7b7xcLflfGPjEriDCavk1vPIxOKUs6
	e9uh0mQouH+Ps0XtPUHcfNI1UdaIVuBWSSuv4ohlRrVk/PqCmC5YjF+mOYdjNZ34W/bvBQx8Pyv
	E46GLtTl4VXXa4asVkyKRX6wg1UfeHmddL1gt8m8SqfXDU5N3eu1LUkqN3AkWPFbR2ztT6T6h4G
	HQ9978/ASaoF2TNQAUwnGaqvuWoBFdqG+yqixmiro6bInqT6atA4XLDzzjQJ6Lu7avSbjRzbUHY
	YLlH6Hh+0VP9QSG4=
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561235285a.60.1752745160467;
        Thu, 17 Jul 2025 02:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLjVGLBAruZTnyYcI3XjIk2LiSOrCmNEhnAfiMWz9ibsQjoRXzWcmxwJLI++dPE/3qhXbt3A==
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561231885a.60.1752745159997;
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2635b0b2fsm519799085a.0.2025.07.17.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:39:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <y6taqbyskzr4k7tetixgkhdo2z2dgrionsor3jriuo4bxlqdfc@fjnq7tig4bik>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250717090116.11987-3-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:09AM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..eb08a393413d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>



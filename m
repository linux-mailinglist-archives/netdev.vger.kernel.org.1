Return-Path: <netdev+bounces-201883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A76AEB562
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93E11BC448C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F3C29A31C;
	Fri, 27 Jun 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdogCZeF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363829CB40
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751021444; cv=none; b=fvdpC1WRguPFRBvj+hPHD2qV3biTRHh21HPRb8wp7iDSuItTO9WGdoujyZ9lW23Ptf6buJR3PAkHHCk+GxsWoF8fnqfcShhxc8QS1Km6mBS8aCrbBparVadQ4hj7hzh9veyhTauiZMI5QjrOwrDv+SnbSeXbP95kpesASLTZ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751021444; c=relaxed/simple;
	bh=BVHZXeFbpjqe+fGCkZrzN32CSukxqi5Z0bBDKpeU2bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbkPAo5VguVSbdgj+FFo57RiopOdl2nVgd0W88RJicxBux2rfqgnKR+oEZPBprMfcm4bvDve3p5dmQI3jt+d9k4ef8Iw7EmzW0Hf4Gg18rI2HWgnql/TQHpp5HGsj0sFN3evNXScIIVUWSTreg58s6ItOsxnoRcEVlSGOUNyrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdogCZeF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751021442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htlFXUXFpvLyLzYGnFDK9X72riSzVnaZycxspABjtgs=;
	b=QdogCZeFzJhiQjx3FQgakDknVK98TClmeTr3CI0JLy5OWKBP+9Jj7pNkYqNOQuwJOhSIL1
	Fh8E7aezkJ0a3sRiP+7FetJwS444OR3tgM8CAOuhNHpCQaVxBBvCk2qQYkDav34k0jQ/nr
	+spyuEOQhnNcQs6dn/1eT6R1k7AUy2s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-7xBseOI8PnCnmad_eS4llw-1; Fri, 27 Jun 2025 06:50:36 -0400
X-MC-Unique: 7xBseOI8PnCnmad_eS4llw-1
X-Mimecast-MFC-AGG-ID: 7xBseOI8PnCnmad_eS4llw_1751021436
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb3487d422so34769346d6.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751021436; x=1751626236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htlFXUXFpvLyLzYGnFDK9X72riSzVnaZycxspABjtgs=;
        b=PNzE2CngJ9xBoG33EzBtPDxOxgU2y9tcYEwg0sfAgvc4YSqCZ47Np+enTOrdOV2QEZ
         XVVCZ+gUPkPzHvKBGNJLrTeJr8l3CExnDFdH9brEl2FumXw2fQoh65CtKYTq1c9zMxUA
         CILotTZg7GkCls4flYYQIvmHTHMXCSx44v5ywAHQx/VsMJiQcWj/l7nWx9MxqB/Z9gJk
         P0nqveMwc0roGnS3xY0YZ5MRPkX3pXLv2O/4fYJPJk5S7iotFgypmq3p1qqRijNSIbsS
         sxcOVse2kSe0Qd5CWWSdHy4ZqGEs05qEWRh2ObehXNt/P8AuOcD2DS8VFPMqOg7dfemM
         wzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu9tWazOlMQXe5NtfErIR07AcNdkKhxPSImsf5xH0cB7Mju0heNU96rLqeSiphJi60ap1G0K8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TpC1DmoNMYDnD5mmFxF5unz0wMHTwuKM72QVluijyIW8iQy6
	Flaj15a/x0/iyC/7avz3aKQIMsNICZXraROX5KYbIx3rL7C8B/sI0dm2GAQMvSaHX7F+LBQ9mEh
	JUOJZiG5SR3fQDlI/5IYOXQtl8J6dQvIym9Fz8BqGonyZLW6PpNuHh8+TSg==
X-Gm-Gg: ASbGnctukRUfUpVbEg21Ipx7KmwyCtuxCItFai/Awfzp6mrGQo3ShbekMyAVnwKBlq6
	wr0fZWd0OovfIHEq5KkV2APEqdhn7pNWbc3BECKTZRoyPAwhSxSRAVkXBHmQQTpsA0JFC6Ry/Li
	i33eP0tWHg7I7v0/fAr30JcJlr1c8d3pbrnpkjy2n1HxGFzQiKDjsGjClpo0US1HBbi1QizHksS
	T4gecFkLhNuwVKFomdzg6ydv3El0vdQmrI7xNDm/coQ3uHuJDOatsLkjrQQ1FqgPRHcLT05ky5z
	Udl8m1BrBeg7OQZ7+jpu7zNQ5LuN
X-Received: by 2002:ad4:5e8f:0:b0:6fb:66f7:643a with SMTP id 6a1803df08f44-7000224847fmr46956076d6.23.1751021435672;
        Fri, 27 Jun 2025 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVOPpSbDXmObd1CmdrkOaPEYJK4J2y+x493SsV5Ja2/xhandwC2sZzDDh/UAk4qzxJ+GDUw==
X-Received: by 2002:ad4:5e8f:0:b0:6fb:66f7:643a with SMTP id 6a1803df08f44-7000224847fmr46955756d6.23.1751021435242;
        Fri, 27 Jun 2025 03:50:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f2dsm17866906d6.78.2025.06.27.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:50:34 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:50:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 5/5] vhost/vsock: Allocate nonlinear SKBs for handling
 large transmit buffers
Message-ID: <cuqzmhjjakvmbwvcyub75vvjxorjkmzxkuvwvwowhec6wuaghj@uyq6glnhxp5n>
References: <20250625131543.5155-1-will@kernel.org>
 <20250625131543.5155-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250625131543.5155-6-will@kernel.org>

nit: I'd use `vsock/virtio: ` prefix since we are touching the virtio 
transport common code. Maybe we can mention that this will affect both
virtio and vhost transports.

On Wed, Jun 25, 2025 at 02:15:43PM +0100, Will Deacon wrote:
>When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
>virtio_transport_alloc_skb() to allocate and fill SKBs with the transmit
>data. Unfortunately, these are always linear allocations and can
>therefore result in significant pressure on kmalloc() considering that
>the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
>VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
>allocation for each packet.
>
>Rework the vsock SKB allocation so that, for sizes with page order
>greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
>instead with the packet header in the SKB and the transmit data in the
>fragments.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1b5d9896edae..424eb69e84f9 100644
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
>@@ -261,7 +262,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	if (skb_len > SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
>+		skb = virtio_vsock_alloc_skb_with_frags(skb_len, GFP_KERNEL);
>+	else
>+		skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+

As I mentioned in the other patch, we may avoid this code duplication 
hiding this in virtio_vsock_alloc_skb() or adding a new function that
we can use when we want to allocate frags or not.

Thanks,
Stefano

> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.714.g196bf9f422-goog
>
>



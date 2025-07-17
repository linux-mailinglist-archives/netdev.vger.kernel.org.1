Return-Path: <netdev+bounces-207855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0219DB08CEB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36471563836
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487832C0307;
	Thu, 17 Jul 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx3V1iU7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4928641F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755502; cv=none; b=hkFxy5eH+IDaHSeM6ODkPZsgs4h2ePXLqP1mGKZU5FpsFfYITgRePspfTesOYsnvJjWKv9pV4I8EW7Xx/Kyug/lQi+HR8P26zlfV6N2s9rbQFJu/jLQ6KWFNMvRmPdaPH1Ru4MQlBZjSDYxiNS8DThzeclRz7hBong7k6y7weaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755502; c=relaxed/simple;
	bh=44t+/G34YxBgSaKHX9d+/SfEpoDPOQU0T/keIoBXs/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/zr17tUH8zidkzh300OK6CeNiLVsfNVDleL/s31uxsYcl8+lXG+UCi60o1A3TJe/mlO5jXDgRnFM2ELjIukFY9QeAE7+Wj00BF97wNo7iUCHIQGyocgCuRPkk4xwJmU+xwdDBA8LwvbS6mHvzlw+kWIRGURHy7pMB/H6DQMX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx3V1iU7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
	b=gx3V1iU7BElEZTzZ44Nw8glt3ZjB5CYOG9vlSBIKT1frAz4RBq2DN+aSgEyYFuxLbYb3eE
	dV8FL6bPKJPnjOrVg7xoODke80ce+WWhDoE6E9/yLdPeXPqHOcrETQFlVMpnM+BHAT2kY+
	vFBEfqJb7qoc3Zp4JxkGx4qSBShE47c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Y9dZ_ATBMXKLpEsb9UNH5Q-1; Thu, 17 Jul 2025 08:31:37 -0400
X-MC-Unique: Y9dZ_ATBMXKLpEsb9UNH5Q-1
X-Mimecast-MFC-AGG-ID: Y9dZ_ATBMXKLpEsb9UNH5Q_1752755497
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so4601635e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755496; x=1753360296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOwtSUDhtL3N1c9JqL5BfWYYoLfY40Sf4zRWujDHUOE=;
        b=FJQ51QUoRLDBi+4GWjYvpwxqereSC9x1m/bPuydZeN/2t92RMtm2lCQBm0zYQ4Nu4c
         GTKVe67nFET6D3zlBV9HJCDJs1KTWd6DYBps84W7DTucxMiFg1uyZF7K65Y7Bg09Vvj+
         G1eNYOfQu/VnuOa1FUuXAski+b3UKhg82xQMGZGfT9PLmdkg9nj47AN0oWbGeGn68dKl
         yxHIzMcHSXUX26M1xuomx5X1/uOpSOeW9xhrTrrhnQsV5BSBi9ttXx6+k4Dsi7i6dePa
         nD2Q6cMdAH461XRbmqJDClNhLhWOBMzPZgMIY+eI99Gx/5Sl7Vi/RnW/VIlw/GaKH3YM
         ohtw==
X-Forwarded-Encrypted: i=1; AJvYcCWWZsSiBwEs+DPjlKC4WEyMk+QdPZKNAKqFeL87S2KFxB38OfnAmKnHrsgF1JLnU69d5HNSWoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuntKV97uWzWtI9E0KsI8W4M4Z/Ctz1ZcqF+UquMNRFAGXDra
	N/BwQx5+kjb4vgO+vVP5CaL5qCgsBSqiQgcULhTu24LT/JH5ka2Hg3dkm1nM+mAVb1vZ4j3ckOp
	B9FK85m//HjxYZynKs4Qs+vrVW5lfTRHkmhtiZR55ThzucmG0Np0I3bdKuQ==
X-Gm-Gg: ASbGnctcEIAewIoDOuQu3Q9eVLpnha5nPRITOZziuZeSEdtNxrJWWTqbwcPqo8OuZWg
	03qBTsEgBr23+frJkcbfzQFJ/oKKYhJqUHCm5pR/2kX71njBB2L4OLRnRMhzFfndJQ8a9t3RfCI
	XKXp5BMN1lXmro302IsxnwqXl7bf3qRDHCpOiPXnNWJ1oCp6kg5V8xRaNlq+Ys2wtAoDHOeKUMf
	UhNkNIu1CZah65VWEyxToKojvT3G7vW3lYRJkMhx/9q/fkZfdpqvLm1vqB5JIvFmEYdoJ6jPsRU
	EDmm/cVCK/Ex/j0deLJV+OtdOiI6nyQS
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74472215e9.31.1752755496524;
        Thu, 17 Jul 2025 05:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElUNLRLQmETtxRLBXnwmbrI7MpDiljAY5jueDojwiosgbm0KlFcY6TQxSyKJFFVblPJMsaew==
X-Received: by 2002:a05:600c:310d:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-4562e2a59a6mr74471715e9.31.1752755495990;
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f6c007sm20924585e9.19.2025.07.17.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:31:35 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:31:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <20250717082741-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717090116.11987-1-will@kernel.org>

On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> Hi all,
> 
> Here is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> 
> There are only two minor changes since v3:
> 
>   * Use unlikely() in payload length check on the virtio rx path
> 
>   * Add R-b tags from Stefano
> 
> Cheers,
> 
> Will

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Who's applying them, me?


> Cc: Keir Fraser <keirf@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Cc: Frederick Mayle <fmayle@google.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: linux-kernel@vger.kernel.org 
> Cc: netdev@vger.kernel.org 
> Cc: virtualization@lists.linux.dev
> 
> --->8
> 
> Will Deacon (9):
>   vhost/vsock: Avoid allocating arbitrarily-sized SKBs
>   vsock/virtio: Validate length in packet header before skb_put()
>   vsock/virtio: Move length check to callers of
>     virtio_vsock_skb_rx_put()
>   vsock/virtio: Resize receive buffers so that each SKB fits in a 4K
>     page
>   vsock/virtio: Rename virtio_vsock_alloc_skb()
>   vsock/virtio: Move SKB allocation lower-bound check to callers
>   vhost/vsock: Allocate nonlinear SKBs for handling large receive
>     buffers
>   vsock/virtio: Rename virtio_vsock_skb_rx_put()
>   vsock/virtio: Allocate nonlinear SKBs for handling large transmit
>     buffers
> 
>  drivers/vhost/vsock.c                   | 15 ++++----
>  include/linux/virtio_vsock.h            | 46 +++++++++++++++++++------
>  net/vmw_vsock/virtio_transport.c        | 20 ++++++++---
>  net/vmw_vsock/virtio_transport_common.c |  3 +-
>  4 files changed, 60 insertions(+), 24 deletions(-)
> 
> -- 
> 2.50.0.727.gbf7dc18ff4-goog



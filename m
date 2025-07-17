Return-Path: <netdev+bounces-207858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BDB08D0B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510C91C22888
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C322D29D1;
	Thu, 17 Jul 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfrA5uAu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332472D0C7E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755720; cv=none; b=eW0JtULaCR78qFatOFpfXlO8qr8qh8nUwltIqvQ3X07V3cv0FmBXbtKCufR6J5IkhTdj3uWyshXEkMkbvMWvHoXabMgF75zD80ygslqS+JIFwcLBnArydKN+NSv7Pg5q1bSTYsjXzLlZb/+ueo61D8OuA0V1dImmjkrc7MTTN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755720; c=relaxed/simple;
	bh=I+W/ywICrQU8Jn6+qPAIsFEguyGDlREwLAb5GJXRNXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx8MBiTz4qKbvBUp1jck0IIQpCECJSVsv2g57+2CgGHsUGYgDSsx9F7IGa1mfT9OaU89kDJdhimMGW44ndEPLWc99so+JCYEVie0GDOpe8tN7G7LiDjQgdgFB30QTIev20dhkw39LvXIkgXCLOdhiEr9a6Scsathx6XmVuyIW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfrA5uAu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
	b=MfrA5uAuiDu9R2AuX5R/qUAFT2EXGVyTp7upCToje0J/1mu1QepnOL7U7oq8kjadF2kc1X
	bJC+8FurRvLjbzytmRGscWMQoiHkqxabVIfkGWKjnE0/SAGut5Cow0flk/Ba8yCdkIaW+2
	aTvHHxNErO83VULS6EemHB9C4wObkF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-GKsbYJYXMc6bBE0oywDcGQ-1; Thu, 17 Jul 2025 08:35:16 -0400
X-MC-Unique: GKsbYJYXMc6bBE0oywDcGQ-1
X-Mimecast-MFC-AGG-ID: GKsbYJYXMc6bBE0oywDcGQ_1752755716
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so5280105e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 05:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755715; x=1753360515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+kV9Hs/EhYObeNLmiJxBPerK7kpqdE6XzrtdRovEQ8=;
        b=XuJ7k7EIosvDzkQrxukdhurOr3BLUmDRP7+DIZf5GxTkK7/oMHcezrWc4hhOQJ7lBd
         IsDuNygdoCrcgs0EBP37e69DdtuTIXY5EAMlS1n6xPY4tmtkyMO1SIPx382/qyRFvaBe
         rmFdlvzIBfnSha5dZFXBPbogl58rSjgKbajDnSVbiHfupUj+0ENP/m+DURW93hF2kCiF
         kN1eLQ9aSzmbReOg3sb7XlXrc4b0AVSEXgvGTIPd3pMKre3sevK7P1ct8/KRLeNTJbox
         v6lo+szD5y0DyvLbTBqozJMRXxOckLvFlpfdNFID89vjQy10kewYEQUfGrDZppfZ4afK
         Kk4g==
X-Forwarded-Encrypted: i=1; AJvYcCVhtQp92wslCc7y5bifQL7T8uZ/UeqZxfp601JToaJK2raVVfJ7I+JCezxIYvwmN7KItT/1Rq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzET8qANy8eNelc7/lfWZe3h0aaidpMuoQHTGSE7+K5SsirEA/9
	DB3RgOoOQB8prAphCixho5erLrzO315/xrhtOoVPCMrCA9Zh33xcuvAa546QkPxO2SdoN01eQgu
	KV2nI8YBURT9vn1YkIWbpJsnsftlFq+RFMms3oD6LjYbvzJ1n6TQu506U7g==
X-Gm-Gg: ASbGnctx7ynzxi7CyFxr/eI97+DmAV6DlBFo1Rk6NtLXOeeo/GSLz3NSsAYngbePsq+
	UgXaG4cSyfMzxeY7iBcEoGheHPQhk/rSnYjEWOxeF5Fro5d9qKRhtqsr1OYJa8tAcYVcY14I0Xt
	N0L7Dts7mYsg9NCxxvpp1SH+eslSPC/F9UlTZNNf/Smi9NlaWXWUW3197mD1uLtMhdLd68QQohM
	8LBWffn62nNhKilVQ69gYl3ynpIAF3OcJZI/qa5zN6kMoPyFnryz/hA3ik6gp8evDspY1sQhHju
	lFhlGgbFC7EkmhO8e+ismKkQc2uaLGbN
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742695e9.4.1752755715605;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAuVmQfkjMs0IrNh0YbIZypcGXHZJRkbzaNBRv4xK0uzAkkQO25FKstUtNwbpNaIIw4E0tiw==
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-4562e330ff3mr60742385e9.4.1752755715182;
        Thu, 17 Jul 2025 05:35:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26938sm20503442f8f.89.2025.07.17.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:35:14 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:35:11 -0400
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
Message-ID: <20250717083457-mutt-send-email-mst@kernel.org>
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

in my tree now. Let's see how does it go.

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



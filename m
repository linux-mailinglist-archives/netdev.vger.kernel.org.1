Return-Path: <netdev+bounces-228677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD919BD1E3A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3384E553A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3D2EAD0A;
	Mon, 13 Oct 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmlpaA4q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589811E7C2E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342204; cv=none; b=L3QG+Qmdl5p1rPyry50RBBIoW/IWrz7hNjTN4NeLoBOR2jrXSiLrwwJ6UnQyaR/V8uCJWtyAtG/f8bpjm+V88giyxomAz6C3kUjldjpBbEjclkc5YJw9P0ki4SjNEfJR0meumo1yGWKUKJ0wZB8i9KoJ7K3Kk/PB8toNtXl6F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342204; c=relaxed/simple;
	bh=NpLaP+rsLewThnjQB4w1PUgdf62FT8lHd6eNEqewl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyrri2lIiEIp0AovUb4U/9fQ4615wzXYBLSi8KBJossVGWCgOX+Hx4FCeCbUTegao6p6sNaNZga1KQaNFQOywWjypC1lxuedXQkTTG5JT+9IsZPvItFgnsUoOAC/7xKcsKVv0tPBGxcTtxMvu3UNMK1PB6gziu8f9WkYx/oawwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmlpaA4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COB7VRuwmjnty8tx1CERez8NmWoPvxynkLju3lUiCLM=;
	b=LmlpaA4q+HRnThexAKfYY06mZh4I1I75uR+mpb2QiqJhds4niS6U3z0KD/q1B1D7i+B01m
	QOsT+wCzFWq/P9tYGaBuqo7M9nO4v7ioWIMCNTbfVJNh8RsRKDohLMbWTJtWCw1ASvB8aX
	kGHapUa+9youvmBBOHyKFWH1RVaplkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-oA0woLmJN9WAT9enH9Oo4A-1; Mon, 13 Oct 2025 03:56:40 -0400
X-MC-Unique: oA0woLmJN9WAT9enH9Oo4A-1
X-Mimecast-MFC-AGG-ID: oA0woLmJN9WAT9enH9Oo4A_1760342199
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46eee58d405so23471245e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 00:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342199; x=1760946999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COB7VRuwmjnty8tx1CERez8NmWoPvxynkLju3lUiCLM=;
        b=OdVPF/V7smcJUPlmuvWN9Xl3Zdinv8JCQ0RtxRxoy0J3TzleDwmPazCefLl4iftvWP
         0UUalbfkIuqRra0YwwStAaLtxApED2ZkHeZ1+WpZkLgBB7AEUjMsCfdOCR5wxtaNvZ+z
         tRcLdV4Tep3qoKsv5JxPd1Cyc6CcfZLGYBCzjZpQKMQrMSNpjChIHAomg1siDpWZRw35
         qr9d50t3772+W9CStm4R/QyZa5cNRznDsdjWj2LRPTScf8TXQsWypsE9gU/ccU0Pdgv4
         jNSBCmkNderxk8KE/0b5RaNPIm2jXPivgEhj8ElPRSQ08JypWUe+29c0stIi4/fIFU4I
         3P4g==
X-Gm-Message-State: AOJu0YwJvauOmMRVetR3UT5vA8KS4DkKbNvTVf+q6GNVLvGQ509kiWSz
	1A6F0HrVxokI7iyY4v59lsJAYVxMdMr/KzUDpvqG0jARv3URatPucpJ7HqksLRMQ060gIXjWu9e
	KGnGiw1UvJkH53KmRkfgnkQVRNk1BisfAVqcSBf0U++6+eggxhoOtKg/T5Q==
X-Gm-Gg: ASbGncu6Fo2Pb9wa1+Ddkk/lobYRfzGBcR75bXuXKSjR21djDX3TsSy1HGPRPZ89Yzr
	gWmcTjzqFxZBGYNRxH5FJHpRzkrU/rE7e89OpvjqSiWzIfZ6BXUDHZTXSMA6RRtniicgZMRJc3B
	IFsyWxxiu47yhpgnnA6NPmze2xmLYcDKc5P9SJIR/u8c6AglRYLBAlOP8dFZkdWE0qTu1dtek5w
	Uydhw/1lBUljkhXHv9T+mrvn2ekhm26kT3imVkHTI21i+7HJOF7dq9f57T5o39nT30LaC9TIwor
	QLKqoUHMfFUYtAEA26XM3n3AN9h4hA==
X-Received: by 2002:a05:600c:4586:b0:46e:45d3:82fd with SMTP id 5b1f17b1804b1-46fa9b086e1mr152062335e9.31.1760342199389;
        Mon, 13 Oct 2025 00:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mWHcHxbSz7cXD/T4m4MEkNzKAin9UCeRsZR4UXAfwmea+Xa32Gmelt4UQkO7u0wdOAsgNA==
X-Received: by 2002:a05:600c:4586:b0:46e:45d3:82fd with SMTP id 5b1f17b1804b1-46fa9b086e1mr152062125e9.31.1760342198918;
        Mon, 13 Oct 2025 00:56:38 -0700 (PDT)
Received: from redhat.com ([31.187.78.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982b25sm172918555e9.7.2025.10.13.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 00:56:38 -0700 (PDT)
Date: Mon, 13 Oct 2025 03:56:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Message-ID: <20251013035059-mutt-send-email-mst@kernel.org>
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>

On Mon, Oct 13, 2025 at 10:06:26AM +0800, Xuan Zhuo wrote:
> As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuanzhuo@linux.alibaba.com
> Commit #1 Move the flags into the existing if condition; the issue is that it introduces a
> small amount of code duplication.


How were commits 1 and 2 tested?


> Commit #3 is new to fix the hdr len in tunnel gso feature.
> 
> Hi @Paolo Abenchi,
> Could you please test commit #3? I don't have a suitable test environment, as
> QEMU doesn't currently support the tunnel GSO feature.
> 
> Thanks.


AFAIK host_tunnel and guest_tunnel flags enable exactly that.


> Xuan Zhuo (3):
>   virtio-net: fix incorrect flags recording in big mode
>   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
>   virtio-net: correct hdr_len handling for tunnel gso
> 
>  drivers/net/virtio_net.c   | 16 ++++++++-----
>  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
>  2 files changed, 50 insertions(+), 12 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f



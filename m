Return-Path: <netdev+bounces-207468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55984B07783
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D9C581361
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED031219315;
	Wed, 16 Jul 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkjeOPSF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95A217F27
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674432; cv=none; b=MCznJhxYT+eKoLyAHSwfujx1G5zDOi2o4/U2vRsWxxbM7HKlkazlAS7vchHWASUFTyO/Lip2f6QbW4K5P5FmcdPGBHMttwE24DuwOw/qRLsJ0psa8z0HSvtYRRcIbGvYZuuyLfUuI8oSLcB/bV85qPQlXSUbTi4pMpbtrXw8qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674432; c=relaxed/simple;
	bh=mf9IQWWYiLknSXAG6CS/Y5YdJTtwlua67aPZ8nlgXf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqEfJWcG+0nZGsadGD3t0niHH7khsqf9XUrl/CwSTkLISqpP16Exr+10i82JdnND32slcVN0zN4XTD6SoHeIU6dE7rA4qnts5ZgQb/Di7WtsY4aMAT6B8wJusdoLq3JqkdyE0mr09ilQS7debIMK/F3ljTU9nZfb+Ij5QN8WTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkjeOPSF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
	b=OkjeOPSF+BmyWt0Yd/mX5C0Y3BtJF+Z34W1ds7h/5avPb0ZaN2340W7m2nP382gTJvcPWt
	X7h9zGtyf076VU9nEM99V7+HLQvJTah8dDNRuUuD4nXbjObfw01M9vLkulWsRk1X4XXrfm
	EGS7soXFud2mS/+hpHi+ZdPxfMCACf0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-4fCdb16xMAm1HPU_7iJ-Tw-1; Wed, 16 Jul 2025 10:00:28 -0400
X-MC-Unique: 4fCdb16xMAm1HPU_7iJ-Tw-1
X-Mimecast-MFC-AGG-ID: 4fCdb16xMAm1HPU_7iJ-Tw_1752674427
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso17441535e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674427; x=1753279227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5j5G2VIMRjlOLTIkjP0GAmg7JUXwksgxowVtwvUlwWs=;
        b=mGAsr0PK1N596vgXZVLCISET4RpO74hDh2YksHAP3d9IsYRKbp/+OiT47KLWEQ25ZA
         XYTn4Xa1rP26oZ6rRmc+yQLLBdnVvezkkbNOJdfd7M03tQIHOk7plwOz4Bdl1xouzf3m
         xxV5QrdgeVnUEzK+dfS8fjbHfqidCTHfWaWwUEGLETv3kt7MoVZhlBX4pePv3EEgP/V7
         iH3/k12oWb/aI/89K7nKfHcz1z84LYWGW5HVNnU2U2m0A+oA6Nnv8o16GdFBh7rHto05
         kbTMfx4/TZG2BQ8T93RkmU+mcgG5fSt8NrU+Iz7ZvkdjjiYezT7qwWQ1nsABDy+n0eRC
         cSJg==
X-Forwarded-Encrypted: i=1; AJvYcCWY/YslDoJZ8K7jc3/4h/PQ6un/Tnpx91jTbagFoPFLQ+aWH3erRvwU5yf+BxQUNnXZpMOxvmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUXLFiQwcuI6zJx9bun+ip7/V00a8sfeD2/3s4BVzNmuRVS7u
	88TcnkNo8nHwX25a1bqgi3UIZOa1RFggA0/+e4NFkS7Mi0YoRxIUGWtR/um7rP3ZiL/SCKyhD+T
	2emlaB7juAtOA7x2Y12sjp1a87VIgDKbpn72tCgaHqlU8UtphMvbqEsTtEg==
X-Gm-Gg: ASbGncvAgze03XZ8Uo7x/5YNkrF8RO3hwfKfYPJr8kYHh/h38m0yKh1gCIwXYjclFCi
	APtQtxzRhrnUWgNByVRi6LeD/MvyMb9BoU/Z68JDt72R1spSp4gMy6Dkc6SQmLJz8AGaSEQTz6/
	YKc+m5/6mfLqdUX3F4+CAlqCviO7N6PUiWvGttzQD4+k5QquHnNliIzuruq628ieLMNA8/RuH8J
	eJOkVaMFoo/Q+sTMkDN7+kYuBctYvnL0z10Z864ogOFc8TVcAd4vWlx8f6hZYUY4IMQ48YgtSXH
	odXBl2s+/J8ebmC2ZIXt84llfxpU6Nrm
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30319485e9.15.1752674426877;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ThKDIOgNJf576TxSWHX/aHnNSPd5z55UpjJKfa775GEBVUvNHy2Nl9JKMWwdi7RBWKzSAg==
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr30318665e9.15.1752674426188;
        Wed, 16 Jul 2025 07:00:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2bb4sm21654635e9.8.2025.07.16.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:00:25 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:00:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
Message-ID: <20250716095928-mutt-send-email-mst@kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com>
 <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>

On Thu, Jul 10, 2025 at 06:44:03PM +0800, Jason Wang wrote:
> On Thu, Jul 10, 2025 at 5:57 PM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can lead
> > > to NULL page pointer dereference in the below while loop when erroneous
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Remove incorrect give_pages call
> > > ---
> > >  drivers/net/virtio_net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5d674eb9a0f2..3a7f435c95ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free = NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >= PAGE_SIZE);
> >
> > Minor nit (not intended to block this patch): since you are touching
> > this, you could consider replacing the BUG_ON() with a:
> >
> >  if (WARN_ON_ONCE()) <goto error path>.
> 
> I'm not sure I get this, but using BUG_ON() can help to prevent bugs
> from being explored.
> 
> Thanks


You mean exploited.

Paolo what's your thought here? Why do you want to work around this
one, specifically? I don't see how we can get offset >= PAGE_SIZE.


> >
> > /P
> >



Return-Path: <netdev+bounces-246435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B69CEC1C7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22F9A3004238
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B8277818;
	Wed, 31 Dec 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hiy1nehM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhOq0hUA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5825C80D
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192171; cv=none; b=d7b7e2U65FMCg1HE+Sdwd6dB9vG2iHdOMsxZhfBB3a0BjYgf9NZh1yIrC5KdzALsp74urrj7TixIGWgvpwRDAhbT7k6QdGoiDonqsXD6kxbSKV9XOgGFZY72u8sBnM+HZI5ZP7HfOu4eAtJp8tkMR3ppNVnPjbGqFah6B6ORakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192171; c=relaxed/simple;
	bh=7yEDDnq5O6nyMipRBT3oeW2l7NFO4JF7mnRHmsBSRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtdC/c7/fmvi+jBwiJLLkgZU9OIcrcvxBREIZgWtUI9S/vQUF5+AZnsVPyh1nA0OY9ErISTXUtn5eBRf7Dz2gyFh21jMI9a28q/a2vw18f7qw1VDp5hbnqUZmJUHxY0fqfE2xMofv5Hh3qXIGUbfRDcLjjLPN6QimdS71Od6+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hiy1nehM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhOq0hUA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767192169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4mmJIWspy2eeK4ehzqbWNIMKVXq0BnPvs75MDLcYu0=;
	b=Hiy1nehMQyFAupyVX6y6SeHjDgF2jPBYOR+Mr5lsqPmuTygZsNEOaLVb67PxafU/5pEH22
	VIK/8ZI38TZv6QGSPunjQgXZo4eZUl3nuUxHdHxsGOtXiUgrblz2WCo20Rux1COLLn5Ql7
	985ieuaI+3DyFaQAfyTaaK3lszml+Nc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-149I6mgnNtipf5bWr0deNw-1; Wed, 31 Dec 2025 09:42:47 -0500
X-MC-Unique: 149I6mgnNtipf5bWr0deNw-1
X-Mimecast-MFC-AGG-ID: 149I6mgnNtipf5bWr0deNw_1767192166
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-432586f2c82so5596279f8f.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 06:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767192166; x=1767796966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4mmJIWspy2eeK4ehzqbWNIMKVXq0BnPvs75MDLcYu0=;
        b=NhOq0hUAZmQSTLFVcSJwCjoeM/cV7ikzBF1n4eKFKunBwlAuDDh7nQkdS98fW1jyn/
         YUty9qdkQGqSzzIfsB4lgUlvbm62k3hHJ9h5Kq038uone/fp0iEl9RJp/qNZGC/2ymir
         QQL/vNADxP9eZ4GPx5bcRNoz65GtihR4xUPfM3Y55hcX6siLx0r2IQGnlsKaZ1rS7/G0
         PEG2pBMhe1rynbAA6pXsPB/ggvvj+8xaEzQ/mUyfNPvBDmDzE4zRfphhC3p5rM3R+soI
         miVqSE76vU302nEwNJFJVREoUFe2hmcM+30wB2jXvKj1BnWEKozkKLJeL356no2bLUIx
         J2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192166; x=1767796966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4mmJIWspy2eeK4ehzqbWNIMKVXq0BnPvs75MDLcYu0=;
        b=YFRsEkitFmP8SBgidTNNqvXDQzI1vJTs5wABn49xhJyMAc97F4OdO1pgroJeV7lFCN
         k6a1BrCNkBQAIG1ZuGuvwsua+m80dVhXg9qalr2LFrzwRPk3YY4KAK4rm1VESNAv36g7
         giSYDfXLwLZvDUkVkZBqtVcPyE12+PKp35ljr/0j9xgW/T8f4k9fRJpm5J/4UKBqAUGA
         nwkBLMAPzqjsBivxr9GCL9K7EVdEf11hczIf8oMK2kL5OPyIhIPw1LW2ah96hDiBm2Ec
         XNsYxbHZtDGt1QoJzLv7uiVeAKGVzjhewoRONojRkJU0usDsz9wxkvs3MC9G9Inh0xwr
         sfzA==
X-Forwarded-Encrypted: i=1; AJvYcCW7BqWlEtCjzWdydQ/e5dVegJu/iucNXGWNhQdCvtZy67fBiL3Op7YGLt3JLtzPJOn8L7nq7Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOylAuRjR3SUKoygSTfZgqFAaskNvXtNK1Kfl5Dy70YdxpdyDU
	SBxPZW8Qu7vj41d0oHXcs/1NNT1M6JsrLgmTJRNWEkrvo9EoM6T6hrikD1mtKPHWach7AFpK6I9
	PAZFzjEFtQRuSQhd/tCAE4KdsiwmDn5/yhtdWvFtrLzc8XqfA2/HpkBRPMg==
X-Gm-Gg: AY/fxX6Akwna6gO27Vsc3KzI8T8xApYTxEF6Enl/e7ZrZ5kftXEd64I1U5sJO5kMSnx
	1dBmTH6ijdrgOcMjzNgN/QLJA2IuFRv7/q/15Z9tLz5b+8JP4BejDNpZLX4I6tteOgQbqDy81S1
	tAuN0/kyE4vBnie05aCbhKhdy8z+1woSKw7wXZAEEl/K4t6AiIgkRz2hp08OMT2NVpwHXZkgkSf
	bVpv+69z+7Ty9XS7jCb9Ei1/VQaFQNQ9MyUtRgHYn0PewYIA8k6jsVt3WUL28iCh8W1JF4RUYKq
	bouKh+NoP80B7tAJIOqill4jxIlNFJF0cz/EoecmT53VQXlDH78Qa3aFqCh7xuu3weW684KRSHO
	rlwiNKbVEhk0LwsB5XRaYsS3vqNwrdXOmQA==
X-Received: by 2002:a05:6000:2005:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4324e42eb06mr50147706f8f.24.1767192166372;
        Wed, 31 Dec 2025 06:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF5p3yqPt+kPdPb7TGA5JeM+zegz4+9TsD6bOekShro6ixOnDhxT1ci9gV1aizVZntyxUQBg==
X-Received: by 2002:a05:6000:2005:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4324e42eb06mr50147651f8f.24.1767192165832;
        Wed, 31 Dec 2025 06:42:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm74610221f8f.35.2025.12.31.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:42:45 -0800 (PST)
Date: Wed, 31 Dec 2025 09:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <20251231094052-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <20251231141224.56d4ce56@mordecai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231141224.56d4ce56@mordecai>

On Wed, Dec 31, 2025 at 02:12:24PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:42 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Cong Wang reported dma debug warnings with virtio-vsock
> > and proposed a patch, see:
> > 
> > https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/
> > 
> > however, the issue is more widespread.
> > This is an attempt to fix it systematically.
> > Note: i2c and gio might also be affected, I am still looking
> > into it. Help from maintainers welcome.
> > 
> > Early RFC, compile tested only. Sending for early feedback/flames.
> > Cursor/claude used liberally mostly for refactoring, and english.
> > 
> > DMA maintainers, could you please confirm the DMA core changes
> > are ok with you?
> 
> Before anyone else runs into the same issue as I did: This patch series
> does not apply cleanly unless you first apply commit b148e85c918a
> ("virtio_ring: switch to use vring_virtqueue for virtqueue_add
> variants") from the mst/vhost/vhost branch.

Oh right sorry I forgot to mention it.  It's this one:

https://lore.kernel.org/all/20251230064649.55597-8-jasowang@redhat.com/

one can just do

b4 shazam 20251230064649.55597-8-jasowang@redhat.com


> But if you go to the trouble of adding the mst/vhost remote, then the
> above-mentioned branch also contains this patch series, and it's
> probably the best place to find the patched code...
> 
> Now, let me set out for review.
> 
> Petr T
> 
> > Thanks!
> > 
> > 
> > Michael S. Tsirkin (13):
> >   dma-mapping: add __dma_from_device_align_begin/end
> >   docs: dma-api: document __dma_align_begin/end
> >   dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
> >   docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
> >   dma-debug: track cache clean flag in entries
> >   virtio: add virtqueue_add_inbuf_cache_clean API
> >   vsock/virtio: fix DMA alignment for event_list
> >   vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
> >   virtio_input: fix DMA alignment for evts
> >   virtio_scsi: fix DMA cacheline issues for events
> >   virtio-rng: fix DMA alignment for data buffer
> >   virtio_input: use virtqueue_add_inbuf_cache_clean for events
> >   vsock/virtio: reorder fields to reduce struct padding
> > 
> >  Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
> >  Documentation/core-api/dma-attributes.rst |  9 +++
> >  drivers/char/hw_random/virtio-rng.c       |  2 +
> >  drivers/scsi/virtio_scsi.c                | 18 ++++--
> >  drivers/virtio/virtio_input.c             |  5 +-
> >  drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
> >  include/linux/dma-mapping.h               | 17 ++++++
> >  include/linux/virtio.h                    |  5 ++
> >  kernel/dma/debug.c                        | 26 ++++++--
> >  net/vmw_vsock/virtio_transport.c          |  8 ++-
> >  10 files changed, 172 insertions(+), 32 deletions(-)
> > 



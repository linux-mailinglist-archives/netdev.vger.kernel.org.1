Return-Path: <netdev+bounces-246324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CECE9554
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B429C301A702
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA62238178;
	Tue, 30 Dec 2025 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0yYMVW3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ/HbEYj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669934315F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089752; cv=none; b=L0dT6IYXS5MbFCtlYd6NpkC7XLzogMgH65pSoF6lhJKFejd2+rdEbHoJqXfJc610INdiP4KxnHWTk3wR2zmGobCAa49abPrgEkZLgAxegPkesszKlpU9pdH3JePNi+deiuNphVNRbtnjJlV6BJLXvyrCdqTrDkE70osws93DvHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089752; c=relaxed/simple;
	bh=LCt+6pV3SVXX+jVlhPofZ+B+PV2iA9I/7Ha5xrB3hCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=St36WZMtz/9pEpuo79Y2iDmEGsM7VnOB6T//K9X5fbLNq4xnCPdqXEbefTbMHin/jg2ssrNKcvdWHVvJZpC1wt+ITr19ip1t0PYFmBbUDaMqw1KzUbMvmICGZHalFeKvUWzyJ4Aqft78Sbd+fi+P/xo4Ws5Kg5J83PY1OCjg4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0yYMVW3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ/HbEYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
	b=P0yYMVW35jxYgBF3YWX+d5Ks1WvgEpHVbY7hSsHdHk78Zw0WyrCeBBSmS2yyK5oTbRjjF3
	I2ThzC+UAqPDYagw+qh9Y0x6x56cCzUJauXeqWrqndmgRCxf/08HSGzrcABR2iQB8QGVxM
	4lSXGaXGdADw9gUk4PbTfeYlI1of3DM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-OSuAPYwHMyG2bsst3TGy6Q-1; Tue, 30 Dec 2025 05:15:48 -0500
X-MC-Unique: OSuAPYwHMyG2bsst3TGy6Q-1
X-Mimecast-MFC-AGG-ID: OSuAPYwHMyG2bsst3TGy6Q_1767089747
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso7718806f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089747; x=1767694547; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
        b=bQ/HbEYjNkNw4GOqt29NjfpwNJkMUoztoEvr64Ppr8lbJ3224HO5X8wrOAe+mil+Pz
         Tz1I0PKlgmqhMtQFmBGBSCLC/Omr1qWBkrAkVME27WwwXQ/vtgA7j1IqAHRWqRWFRl2G
         /ns5g2z/FMVxRZEozM550fAkUewyL5nAUJj1T5/Z70GbdMjHTHLhG7+DiZfqEvKPctjV
         KVM6uHGAP0ULWx1FjNINl3cd7Gcx7vwi7I/xJ84jnZygb5VPe50x62PvVKLT60UjIM3v
         mGBb0I2g9F9gw0qbl+/IdaOhP4baFcH3/2DCOkfKmwfkVjObQk103KmD6GGz0GXvuTFS
         a/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089747; x=1767694547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
        b=KgjLkb6emIiBK/tB6857WouLSXrfumSllfY8VLGPL9ZjSMdNx0LZPztdDZeOfu1U0K
         SgO5p/NPGbUfaD4kvM8t9J64JMOH7HIW4WwHemijuvWshEwnwnCLbz4ZZ/BRdfAqYg9g
         /AGsDiiUYhqZv1TuSzjP+DpmeCu7VEZYYgZbA6PUWFcQlIZUcMLkM3JY5wJHVwV9rO8e
         x5p2oFevEKXpAVLy/viSKD3npQdzrxUDPiqy1GAydZ+0V2u/JrdaL0y4oOy38IBR13Oe
         Eplxq8JeYPpFM/dIx6T3Zt8tSCpPFCa1ai7NKOuKAXFqtkREdR6st1a6pNdyUdMkPGmx
         HaPA==
X-Forwarded-Encrypted: i=1; AJvYcCXUp54Ld2NkhUIajg8i+LB4A9a92EOTMEzpKQfNlLE6bGFHJ2UnBTa8q8UnozghNDJbS6x1X4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WiL9a5UkYOIDXYUsrjamydjmvpG9gEmcnKBInJOcgObOrMgX
	VuyULJm52Q+iwlIoIC58qIt8BdMHT/3riQliHDcOPcxb+ZTFqakTE1NpO0trhXhnN/PDZ2vCJXx
	TsLoFZGJJxNdxzy8UXkD0LiXtVjGp1kPpPfToHj/8AZOAmcQA7P/iFf/1fg==
X-Gm-Gg: AY/fxX7vt4hFyIw5dMdUJ9MTZu5+p5w62UJr4fe4x7Y5ptPeZQ0btf7CmsN4EQT5Ri9
	QCMzdx/Hc/FfYzwiqqkkV7KlO5DqzUF9hTV2pi7mdHeJpU5EUxuBt13sg2IWwAjJjgOCehhjI72
	Fg8yx9eM35SCxsoPqM2kSp+pz9hJj80oUZZklDFgrE8SwblvDGipq8l9E2Gc8Faag6MHiDh9P7a
	RHuG95m/dSydc/+0ivIDiTYF+Jca6lJ4pBceWVBA+OpwR/qk0jMnvsMDZ85kWN1Qo00j1E6BdMM
	m7IPkqFqfk2sKJCyuDndmSnemYGbixJngf+AeyKKow+bcbakkP6JsJ5GKY5XyLC2LxKx1KxChQw
	FlU7nuMxQRK9vFF9PI/C4cdo2LtAqTWQQfA==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005605f8f.8.1767089746609;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbvOFHJ91a0TKLxq+k7tMABBS8U1GQCYZPCELRU5Zsc1Gaj+GYCwYcD6RmChYOtX8+5x3fqQ==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005566f8f.8.1767089746108;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm67681523f8f.0.2025.12.30.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:45 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


Cong Wang reported dma debug warnings with virtio-vsock
and proposed a patch, see:

https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/

however, the issue is more widespread.
This is an attempt to fix it systematically.
Note: i2c and gio might also be affected, I am still looking
into it. Help from maintainers welcome.

Early RFC, compile tested only. Sending for early feedback/flames.
Cursor/claude used liberally mostly for refactoring, and english.

DMA maintainers, could you please confirm the DMA core changes
are ok with you?

Thanks!


Michael S. Tsirkin (13):
  dma-mapping: add __dma_from_device_align_begin/end
  docs: dma-api: document __dma_align_begin/end
  dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
  docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
  dma-debug: track cache clean flag in entries
  virtio: add virtqueue_add_inbuf_cache_clean API
  vsock/virtio: fix DMA alignment for event_list
  vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
  virtio_input: fix DMA alignment for evts
  virtio_scsi: fix DMA cacheline issues for events
  virtio-rng: fix DMA alignment for data buffer
  virtio_input: use virtqueue_add_inbuf_cache_clean for events
  vsock/virtio: reorder fields to reduce struct padding

 Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
 Documentation/core-api/dma-attributes.rst |  9 +++
 drivers/char/hw_random/virtio-rng.c       |  2 +
 drivers/scsi/virtio_scsi.c                | 18 ++++--
 drivers/virtio/virtio_input.c             |  5 +-
 drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
 include/linux/dma-mapping.h               | 17 ++++++
 include/linux/virtio.h                    |  5 ++
 kernel/dma/debug.c                        | 26 ++++++--
 net/vmw_vsock/virtio_transport.c          |  8 ++-
 10 files changed, 172 insertions(+), 32 deletions(-)

-- 
MST



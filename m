Return-Path: <netdev+bounces-246927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00322CF27E6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A99306BC4B
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3532AACB;
	Mon,  5 Jan 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr7DuHoY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyHqefgZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700A314B82
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601434; cv=none; b=VHV09gxEjBzpbRI9rTtece5HsVPB8MTomnYNd/iaykDgKA7AOSlTKS03h72GhNJY6A53B7H1rA1GxSVyun14B6jnVmvCR8qYle+R8pQRMIoK8XtTfNqi50HO3ZKvQBUIPtB0guOslkswUOXNn18j9MBkvUWpToH8HqSarfMsw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601434; c=relaxed/simple;
	bh=SZ7yoG8PLS6oSz/uClprybkzflRSWBjZBPmgt2pUyWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgDuS5y4nCkQUB//YK2aujDU39rHAppyXTK0Yc84+itM6TAoMAl6DlpbADzZ/6V8PGQja/1LVpypaoeTByGBhLDsIRVfQk2cUe3UZVQeDvcOKsudtnQ04Lyv1mta/6FecIfnvagaadea+VbHa1ECRkzKhLhaqVwnqccxK4rVW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gr7DuHoY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyHqefgZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UCCLeq+lwQP+R3LKzuvNuhkNhAmceABICngBBmDYRE8=;
	b=gr7DuHoYZ+yGPh+rhrCHiVgEklgAEHB/+ZvySqQw2fFZGZgWpK2yezZ7juHnaNcghpX8iv
	PZWemVi1UQKI/79HW1XNvIDsHGKsYycOUjn1AAyMDZsXM4ztBlx4ipn6/eXhnnwrtvVGbA
	0lKvHY5MVhOEdYZg3hlOl00pczvnuD8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Px_czHG5NySq2IwO9lM-Xg-1; Mon, 05 Jan 2026 03:23:49 -0500
X-MC-Unique: Px_czHG5NySq2IwO9lM-Xg-1
X-Mimecast-MFC-AGG-ID: Px_czHG5NySq2IwO9lM-Xg_1767601428
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso23272135e9.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601428; x=1768206228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCCLeq+lwQP+R3LKzuvNuhkNhAmceABICngBBmDYRE8=;
        b=SyHqefgZvMOLGeVZftmopH5fcZbmXOC0X3Vvs/dMnT5d8UoGbl/aSwlE5L4jLM6qx0
         A+ALG8Ap72Gv5XquzTQxW7GdAOa50hA7lfwGLUtia2NKSvtkxTVZwVylkqH8bVpTd0Df
         LZLbSAXRult+IGJZ4DOGgLjIee6d9WBY4dUuOLivDve9u1sadVvkqsuks4TQVhT02Ajz
         cVfEm0UemID6vRaQKAs2QPNxeHfdwiCPt3zzh3douD34+sYqmhbwV5/qIh+EbF7G+u4I
         QGc6RlXTDUD+KT+80QCttZpFA8tm0ykmCR/BPE0xqeCpVXtbthH6olV38p3CaplMmH3p
         WWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601428; x=1768206228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCCLeq+lwQP+R3LKzuvNuhkNhAmceABICngBBmDYRE8=;
        b=feTkjMPG78+PRtmjC5MUrzJhfuEF4+mAOkrQO+BeFsSyVs3Wb435xe34YbnxOBUgPX
         ohU36wNx3T0HFqcnqYVMelTl/zTvEXLsMxeZzUMlJH3viZgO8S02Ba+rVPKFnYwzfTnk
         Oxkb0dCt/jCmIbMzSVP5fsMZ1GTtFcXOvPt1WvJAMD9fmLT/dXb70amR0UydE7ZdxTHP
         SAifyJlPC7d53/CQ+WUOocCykIwtlcT1HsaJPgUf2LH+OrnYgWbQayGjZKkRE2aPtkhA
         30d6IdCJjPoz23VC9FEOWA4hIDM3VwnGPKPck+Xkyey78+IkbijF7v1xtbjewmIZloNe
         vZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXMnr2WFCNSI/4AI8osv7OhS2Dn1qxR5FeYrwg1+rbWWLeI7874vMj0Nip96uSxJq43LA12uV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01WJkuWGZhu/dcXsWDGHLcaAv1h5DNgcwlolDp+zW9pSjmmK1
	BI1PMj3bCgO/5l77O6llU5nj684EUqgNe9A+TxIoA0ow1GQdsfbuM56ZK52mC6lgXq0oR9v8+Hy
	6E2aRLPsBorgpqV5M6Pmh6jECo3Rk1aqWJuu7phejXF6F1ue+upnDawsX1w==
X-Gm-Gg: AY/fxX4ltrCv1UVGvzhd2qckFiYBrZz6yZEk27CzaGXLVMSBoJgN8BM7ATJjRt5tHn1
	IxupB2NGO4sBaxWReRsSt8xiSYf6A5SF2t6EhthYdBMLAPR8sXdoQFdHiKaaO1yxb0g+WtuSAxH
	mjK3GgTGeAsJb50t4T+L6EmYQUly9vFeb0iUEO+OcZzBC03oIsFfGa3eWojgKkypCTxTMxTkOBm
	G2brivNFPGWCFW7iLRM/ifbWdDDKiFtPgJQ3OElc7e1UKVtacyLrgBlb1JwGrfzKZTmj3xWUqOz
	6f3rO3DtMNRe7H0UlGvGn4DLg5tkl3OXW3HZj7cJ52EbRblmxqj5gQg8R9sKXkswWDClVuB6RLB
	0Y6RKRQLNq8FtQx0ouCOh3g4IigfSXm3EcQ==
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id 5b1f17b1804b1-47d5dae7628mr228846875e9.23.1767601427564;
        Mon, 05 Jan 2026 00:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF11RG7JP48/6nhX1x0r6bivcNnxiVBPQ+hub/0+kajaGoE0Knx7g5Xjp0dkxgQjwSwKtknIQ==
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id 5b1f17b1804b1-47d5dae7628mr228845285e9.23.1767601425245;
        Mon, 05 Jan 2026 00:23:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm100331450f8f.20.2026.01.05.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:44 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:41 -0500
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the padding from aligning the struct size on
ARCH_DMA_MINALIGN.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index ef983c36cb66..964d25e11858 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -60,9 +60,7 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
-	__dma_from_device_group_begin();
-	struct virtio_vsock_event event_list[8];
-	__dma_from_device_group_end();
+
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -76,6 +74,10 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	__dma_from_device_group_begin();
+	struct virtio_vsock_event event_list[8];
+	__dma_from_device_group_end();
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST



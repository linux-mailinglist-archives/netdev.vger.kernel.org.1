Return-Path: <netdev+bounces-246929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B3CF2792
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3955C3033697
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAA132D0D3;
	Mon,  5 Jan 2026 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0EJGw52";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jhuW0fAF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB231354A
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601445; cv=none; b=Iw9RfkWm3GWqraG+N+YhSeCGMexAxI6t37DRj1dz0HpkBDvd84mos2c1oW7b5VagOGggt7MnzCpaL/uRYbD1Yg+JFNFoQFZwWx+qIY6bEMsrQ2HXN2hQ1UuqO45PR0pb26VPIY/LI8MxiBW5+eU7N8DvDusYNxQ+6zczjQ8UbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601445; c=relaxed/simple;
	bh=jIFi+Zvcrqx5KM1Tn7Vx/X/Ro5vONbP7sNW0Mf3F+ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkAevp0YfZ0oPoyLUAKjYUuytrcd5fDihLiTzzsIEqf3WNfT+y9sH3sY1bbQ5PDwWR7obo2Ov6BnI0t+drImP46GanFRZsMeykKLb5WY6UhOoDo/fmTXxojE9F216RwoVJ82Tf5auMM9ju8Ja6yC0DppuC6uevqDwDQAT+xaG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=fail (0-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0EJGw52 reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jhuW0fAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
	b=U0EJGw525N36TsoWhwIOnHH1npKLZARnTZguj2NX/3prDCcmeRPQbwt+hNfC0WXAQ3xUXf
	72jxF5QIZDsJqNjXDrw/4uv/LyZg03zEUPojJb9o56hhsYdQgPliO9LIbaDzxu0dd7svGC
	fhwmZSYop0+2nnDzQJGqmS6QbD+QSn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-6Qq4pD8oPP2Qt5Oh4b8UIA-1; Mon, 05 Jan 2026 03:23:55 -0500
X-MC-Unique: 6Qq4pD8oPP2Qt5Oh4b8UIA-1
X-Mimecast-MFC-AGG-ID: 6Qq4pD8oPP2Qt5Oh4b8UIA_1767601434
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so88358755e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601434; x=1768206234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
        b=jhuW0fAFKWout8NvzOE75lr0thW/Bvte4Ikr3Ds2O8GTD5vrsS8ZXy/VT74UzpbAlc
         SkwWcLIGG2nOn2hJ3IOcZWexU19Ly66MFoocUxD3oz4K3yQnN35L6SydRy6k/+YyXyBd
         yPebtVj0mQhCIVAxVWRptftBXMGxBrm45coShq6icSkrazqS6YFoU488FT0ix7EZbdU0
         Tgt3MkO+ClKdAAuJSso08c1qe6N9IhusEsMZYkwbRWP4dwNmx37rNJr4j76KliGNlmwr
         zxVVw3FkCTqRZ/sC1v8j5gVlPYVLiP9gScBNQgEJyJqfnGaU0TgCBqXdJGQXno4Ef1MY
         fWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601434; x=1768206234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
        b=XbMqu/Ioiyja43hQ3WaEngntLH0+0XIwixmj/7KgeC73HqKCUDiElawbk11fXcIaT9
         eUko1wHPNjIYQgLnTfsf6KO68Pym6SYbCBdmqjQte7N7W0/oLe3fJFuO4Dy1J6ahZqOD
         B1AtxyRxd8k7lHeL+woxkKm1Kv/y2T+iV1BblNampHvnRdwgM4hFI+FcD4uGJcq28Ifc
         yFtpigC6VTxr/nn8IBDtfEovTuwlKmSbT39nmJI7B8RQxESBxjTqjwHvZiEuQNYvLaJ+
         xHfRakS0WnVByaFvguwQtXlntaFDdgD5hoWygw8mhNwAmgoGtjpNoIWrGXbFqsXbxHFY
         +8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXleWF1QN/7RQOG2AijwD72P2buy0rkE1COayV/6t0dB8Ia2uimGFwDP17e9SrzATJnfmyqchE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm78/QgT3QiNCfUuAvJlkIdE52uZi67YUHAVOFyl3fEQ+09rSL
	vEnxkDYiB5yZjTMGI/3sjdzK+Q/95oK3HLFCY/HzmrJlFzKhjRYri/YFlVLmgXxj1Dw0iKC7I8/
	Cec7nQlScXJ8ErX8gjWW5Sg0BWsVSbIyJZ/vYfQXSKPqo7lB2RWwhHNNfOg==
X-Gm-Gg: AY/fxX4qKt98T3Ou0bXX+a39dRhuw+9IYFSMhTZppkaAa9amlkH6srdpZe9z0wV8T+0
	f6HwW+ncbYV4Pk74fP6URIyk0aVCR8NNkLVNn5n9d45CVMlfM7O82sxX0K2y60jKzuNzVQJp2d2
	ttq/z/UZX9VV+adWlAhxNN5ObOrcDOV7x/8DcqXLdCEYpnQKf6ceipGZmb1QpLUQYF2MejMsT/Y
	Q7qYFACA4Atz56EW1Evbg8CzKXcmmvbiW1r1WC6AmL9IanaHys0F7aNj8OZq6xoZBCa6Ulyb52Z
	iO3mUxmbwEgbHLsovJhWXBLBuYGhw/FwZnF5/7gidKqnXF+o7ZI1ryAxpG/XmAA4OQh0rKDUBBG
	Sgmsk+wwE0KipAlC06V1+7exZwBWtPObE3g==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619222125e9.21.1767601433876;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMqr5RF3PmeKLntFlggNTcPo2ZIBIezL7tE6/J3AdeaKkIeEvwYa+UmsMabaObW/38gLAvfg==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619221495e9.21.1767601433387;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm99141541f8f.39.2026.01.05.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:52 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:49 -0500
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
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH v2 15/15] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
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

Reorder struct virtio_gpio_line fields to place the DMA buffers
(req/res) last.

This eliminates the padding from aligning struct size on
ARCH_DMA_MINALIGN.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index b70294626770..ed6e0e90fa8a 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,11 +26,12 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_group_begin();
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
 	__dma_from_device_group_end();
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST



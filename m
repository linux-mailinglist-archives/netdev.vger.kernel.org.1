Return-Path: <netdev+bounces-246328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E92CE959F
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3EA30341CE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354452E6CC0;
	Tue, 30 Dec 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig5ep5oQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7FQ8isQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2491E49F
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089766; cv=none; b=lWnXjzWx99Uvsn9LW+I+FCHvawIdaveQw3JzM4kfmNxescV0O7B/LCig05YXOPfbZhVPjozeRrw2Qi97aSaTYcqvRnW6paUefyRp0Xt4SeQ4VnI3hP3e9x1QjsVhymjKy950TqTAfmgIvlOJKSqcdNi73tdbXJ27Lt38Wj78M1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089766; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3+TxGQ4LBTyHDx+1Pmdpctw2Jsnz2KLAej85dHTlodzdOPJfmxwzJPCamMy302pbr/VLixAxjFfdkV2/UkFY7zmREwc8fmpvYfNHnmfKAl/lYMikQEg2+3dG2FJH37O+cFoA+qFK7VRGSojzNSvehHVnd53L30R3ynDDeDnJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig5ep5oQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7FQ8isQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=Ig5ep5oQfWTSijshrhmphh1kZkOF0/D3T4IO0PkmzcUJ9LMbjzNp+u6jZ10CCW4QVl+zOX
	Tya5yn+N8eUQwS6+O8S7fVAFMqh66YiNsMIbM3BzPQPZVUlRDLR/1xsJMoY6lRsszddlWC
	jG9Ke2bvMqJsbN/EmJMgf0wOxMckYuI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-6dpPTiGEPMKnm6onSqrshw-1; Tue, 30 Dec 2025 05:16:01 -0500
X-MC-Unique: 6dpPTiGEPMKnm6onSqrshw-1
X-Mimecast-MFC-AGG-ID: 6dpPTiGEPMKnm6onSqrshw_1767089761
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fc83f58dso5494102f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767089760; x=1767694560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=Z7FQ8isQq14I1KaSH1zw/UXjxfl4vbX2ZEFt82yb0xF9HrF5cGDa24nsifnCDpFx+d
         ZJVEGcAaQcquK7ruSxLov+mmtNZm6Z1cY1l5h155mMjVQFrApi3LDOd28jAvqGiPFSet
         LdpFwLkIn/ZjyF4pQkW4zmY53q3amnxzSS9IUxJai+v6NViiTMCFUhYnCxRcxm5uZESt
         Aw1V9bQXYW7Fl52Vl/JGM8eclURT8majQKzcf5P/SfKE9+ou1xx5sGSTMLsUXNKdhfjL
         R5z2Dr7EADU/6enDMzGahCI5t7S/9eDh/HfytF8+YyTZ1fvM3mPQmNW/lQt+yUskX7rr
         0rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089760; x=1767694560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=gVhWVYBLI6FxvZKsokydkUeOyLnz+uLEeIIyHMDNdMTb60KIMdKrKpkNZ8O7wIl5F9
         E2A6eSehD5UAjUn9GyCec0yBF6c9P5M4iUsNTyXLLKNCVKdwh8Cca3uVT8y5TSEsmpZq
         KqceSYwF9K4bkYljRqXmJ/MQWe/+GGPQHP/5GQTRwMqymCTod6x/gibMMd5Om/cDjwDM
         nXzq92AWI3Sa8OOek2pKS/umHsCA2Y3Yk3PJ3aCHr4ie5eCu3WRvJByGPzOqL7qmgHzZ
         FxXhpp/dlfU36i2l5AYoPBRcOvdNeRJhGsLiE+2PtiqvOzwVC8yWBrEm1OFEM25lUKm+
         cNaA==
X-Forwarded-Encrypted: i=1; AJvYcCWTqP8M/MPJj6ohO2oFrybopQ0LO1NjYpngrMB9PpVOr5zMiWrf7hZZ8s+XbSdmkk+eFlm4vv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjlazT7zVhtdEHhZ/hM2G/xUCG8EAag2Mgt4UzCcZ305iW/Ob
	9lLOZ80rrs14dpd3TiprHrqfTDIWr33ZAyVi2oLPvSmSnYBVtCQwcQ72u4pl6t8I6j0X3fntxnO
	jsnUM/S3zczqXQ48/P+tIzY8i2VkkRTyfo1VOinnWSO9WrnxtKAfDlKWkKA==
X-Gm-Gg: AY/fxX6qZessqbOFcoyEM6AkGlCc28LPehXy37aQvf7iCih98c5oEyUbq7Eym2NJARp
	b9dXb7RLHSniJ/NvEk6pNNkREpdE5H6z7risJI1nEvQJAzISLqzkF/+5rOIRAPzceQJzOQDNJzv
	EtxrJnqt1fZfPr9MDQ6yDZpUYPtTS8nXVXH7ZvCLe/FzYGOEvyXCMVzEXKVbqIQALGCbaxJiavE
	pkQVEwU08WbaLTUEPTvmFZcbanLEjJ3AYh/5Iel7AjMOmhGdFdrcizTWAaoqIkeqzRsK8k+kBZg
	S0aZqQX+5vIgZVqSoYVEPo0DGhXdEZzrbQIo0PxNsT3FRSm4oFirFeK0a8l846/SZopuRkI26zA
	923UcjKshKahgh42WyFZuxr3Bi/YavysydQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750124f8f.22.1767089760431;
        Tue, 30 Dec 2025 02:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHondA4WovcXdLOT45Lj3uVr7rduhIOKgQxT45AJwE7sF5CS5LqWM7ii/WKiPGqmcKK8QLbHQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750079f8f.22.1767089759925;
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm68448837f8f.20.2025.12.30.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:56 -0500
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
Subject: [PATCH RFC 04/13] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <818c7ea78e43b93d1bb3995738a217e5e414e208.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST



Return-Path: <netdev+bounces-228359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A038ABC8C74
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11E074FAA7E
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5A2E0B5C;
	Thu,  9 Oct 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH07n6OS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACB2E090C
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009061; cv=none; b=a6FZ7Ea/NsVDzR00LjWhx3/a2D7esaY8i29zHm5MR1DLtjIkGS9OTLx6iSXx1cuLD7cYccFNs5McW1HjzrBqzeQiMIahe7EEK4qtPpi11CD9J5QVShXjT9ka+ib6WXuZNQcGPnfj6n5xsBxbOcjAy3hbJRxurXsgjS8pIZEfMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009061; c=relaxed/simple;
	bh=79q/stfmKaMpC4fkL/3uhckYgC59HswnU0O9ncOSM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLIaPLtdcUlel/KVpvxFkrBL7Ud7etaU5Tv7JWQaTk6XqqiPOqBzpBw/0yZicpPzSExNY2quhZnaxld0faGXQkCNqGlF5Z03ySbUE8TE6EPSbTNzjJ/lDfIFgdkFVccC5IhWyaEkSk3zbd9rVO28tJs5iY1S+TBo5DOnoZCygkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH07n6OS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kmAH8BxjdJp2Pz1OPEFZHQJ5FGdMMYsLliyoe1z8SzI=;
	b=gH07n6OSziZ1nIrglc1f55tINC/Im1TOXJ3Fi0nEmM7K4ts0ZlasE/sawszn3X1vWwGkYu
	tXA/RmF9KQrSLKd49f+R/YT5lYjh2TYDiHY9LlAuPUEXFjYeSA91Z6l0UooF1kJFq1D2W9
	SYSmfJ6uIxQ7it6WxaBtLeWyI+kDC2U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-dzO1NXAgMMG_FHcZVpBKpQ-1; Thu, 09 Oct 2025 07:24:17 -0400
X-MC-Unique: dzO1NXAgMMG_FHcZVpBKpQ-1
X-Mimecast-MFC-AGG-ID: dzO1NXAgMMG_FHcZVpBKpQ_1760009057
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de53348322so49786081cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 04:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009057; x=1760613857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmAH8BxjdJp2Pz1OPEFZHQJ5FGdMMYsLliyoe1z8SzI=;
        b=StnzqGo3w5OHP3YPZpyER80oRbiGl2ZLranI5wmfrQcSuClwd+jesHiuBpzTBlDdH1
         wEiea8I8XkSyZlbUnn4gBIRtAQPZRbeXX1uJ/yC/l1jSFFi0E4DW7vGUW/6dGFEOvXmJ
         +p9gv0W2HELVJjxvBu0xFuY0umHjI1oFKnvp/4jLT+nt79Oo/Ki2mfox99yDCfGyA8HG
         HubnnNg+cuL6lDjwFHLddx4v3VoXeBoI8m7lFGIH+Ndk26miE7+PY4/h3KpplTQKkmZs
         oXIUYl9UAfAUbwZkG+FsPZzmHIf6qb4ooINlXTlUtM6DkZqQfL81xK4WwViXtMGqmXSj
         wWxQ==
X-Gm-Message-State: AOJu0Yy8G5qPjSpuoNRi0ysmwtTFtortBgw9tqRI6K0W2pD7ZKyCNbkL
	0r0NLLcNRbccl4igUPrMYqiU9xaFfbu/F8H3L8Qe1wCrqheh0bkXDrtcHsO3IWmKXRvP2Hf0KdZ
	3XWu7vShLI3CH0r3TjyMDFkU64CGZZHWytHGzuUl9zfm+ztKKOuDi5HrU3g==
X-Gm-Gg: ASbGncvUUVPnkm8of+kdKC9EXKyAFzQPIfNnr2KZo9SzRC9aAnj2qLzVs7lqJFIHcOH
	zZToDQ18iLeiAl2oVUl1kUK55/k+vy28DYtF5vGohhCCBIc+ODJ0K7DcpRvPBr8iL3xNkDTebcQ
	PUZwxku4Id01tODXr5CiiYcTDki3LuH6DKwPh0n6xSMRuyrgerV2ePea2UYH8FK7bdrVrzs4+r7
	Z3Blq+zonkXKYqXi+pk1ebZBS1tek3cNTNjKAuomtErj9gn6zAlOlMhLRlfqRcIrg9X9WGT7qDA
	hfDUoI/U44jNgvnNe/zrk+DyznKgLJZHrkk=
X-Received: by 2002:ac8:5712:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4e6ead147abmr98992221cf.27.1760009056619;
        Thu, 09 Oct 2025 04:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1nScydZf2w9Y/RF1KZ/toaL4XHDC73RNqYYmsC+Y4XlTLrKctFUYrWVrZX9qDmWKcvcV1Q==
X-Received: by 2002:ac8:5712:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4e6ead147abmr98991861cf.27.1760009056130;
        Thu, 09 Oct 2025 04:24:16 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cfd4334sm184991021cf.38.2025.10.09.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 2/3] virtio: words->dwords
Message-ID: <46f0fa4570b01988f9fe79b690cbeb93dcd52736.1760008798.git.mst@redhat.com>
References: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760008797.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

A "word" is 16 bit. 32 bit integers like virtio pci uses are not words,
they are actually dwords. Fix up the macro name accordingly.

Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 6 +++---
 include/linux/virtio_features.h        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9e503b7a58d8..4b619cc91bc7 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -401,7 +401,7 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->device_feature_select);
@@ -427,7 +427,7 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -448,7 +448,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index bf41d8ec50ef..f41acb035af9 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -6,7 +6,7 @@
 
 #define VIRTIO_FEATURES_QWORDS	2
 #define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_QWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_QWORDS * 2)
+#define VIRTIO_FEATURES_DWORDS	(VIRTIO_FEATURES_QWORDS * 2)
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_QWORD(b)		((b) >> 6)
 #define VIRTIO_DECLARE_FEATURES(name)			\
-- 
MST



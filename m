Return-Path: <netdev+bounces-125865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27296F057
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72A32847FB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE21CB318;
	Fri,  6 Sep 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4AMZsBg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9F1CB329
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616374; cv=none; b=o/ZSuDs7HB/zNqIyjL0H9C8xqvIVQnvl5+dlIVCFRcNb9slFGIq3oDzCpwF2XgbvJoVN/dgkEy0yCI06Wpbk8E6lTutNj+3HFHn6yfeKAOVOuC0hDsntLSckw7L5pI/L1n02aoGvaUV8aipK6NqFFNQfqm0hR5Y5XIGi7LzR1Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616374; c=relaxed/simple;
	bh=G0vuRwIZULx1awulz3TZccpUD9HBmx1Km+yJqugvR6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neLi/AO/O/Be5SUNUZEVeRTpskeY3ZK4RZucS67ZHZ3/3YYszkyaSS0eAOop9yvW6G3kWreSpxgMVWpkTHyvBxvicuRjuVSMmwg7T8c6fEZBxONHKdlMiUEroPofDXm963fny9xJeywP4FKos9KUzd6Ad2ECpjZeI9QO91r9yNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4AMZsBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BVAAiLX2YDT2AdtI4QtNJTs70zsl324iWlMmUL5ZGE=;
	b=c4AMZsBgBTcYlVtCsXNOIBoM43gGwqkNDY5Mg00r/ujfL1/TyId7lgjUeU7S2NAvPnlAi0
	Xl7luMWUej5FB9A+bL4YImFXTpBEScZa1pZzi15S7TwHIgmb+YsydizQ3bLTOTNp3p6cHo
	FDmbi90xP1cDNJfE2F+7XMC6E7F9+dE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-NBrs5pg5NoWYMWjUpWuNuA-1; Fri, 06 Sep 2024 05:52:50 -0400
X-MC-Unique: NBrs5pg5NoWYMWjUpWuNuA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so14755185e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616369; x=1726221169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BVAAiLX2YDT2AdtI4QtNJTs70zsl324iWlMmUL5ZGE=;
        b=f7mMik3W+eRmSvXU5GFa6zKyCRf3fAckakUrTsAMQIrqvP9wGsp2QORol69x/w++q8
         t8ASOjfg8lZlJ/XcEZChZ/zTazS0yww9txQFZpRaG75xF8BbulYdQZ1KZrJAj2dQR6nH
         Ya1iAgtmnhLeBFVdO6an0aOQ5efy/jCy2ZWv7OkrodbFCD9cTCNLnKpINExzpzvmFq1k
         Lrzib0Zv4L0fg99j9S9wyCY+3GAjvWD4hHCOWvdj77aEQfl9ojH2X5vDUXS6RDEqhFrR
         Xk4Ibv0KYzlDgAVz1PkYc7xW720s71A+VyoKCVDqOm4jK8v+gbq6D7nEY4aHeCev7j7i
         qFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVlGsrr5vZGTRb2mpE7kilsLtbDRTxBC0Xi9eZg29oLpuDz7bDqJVeVw93HGqaSP2Ta7YCxAY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4Fr8pvJuQ5b4ZpPdNGbTufTUz46hwsaU+P1MjmSal/+5GiB4
	Cs9EcbGhcyv/WTwk7nTBEke0II2WGxTpnaYPqZPO7P1zze/axvLgcMlEyrZZY/OiHCUoMhciElp
	wyjKauULGuTY3ZLZtvV0vSWE7s+SZ672xV/5zyIR8wT7jqLCI2cm2Cg==
X-Received: by 2002:a5d:5225:0:b0:36b:3384:40e5 with SMTP id ffacd0b85a97d-378895de480mr1326176f8f.24.1725616369305;
        Fri, 06 Sep 2024 02:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpPl6uh0wHWO+9rukppTUDX20dNZLFoJnMDp58PodNRcJ5IH3PPSXhUNF+FyNXmBHbr/zcog==
X-Received: by 2002:a5d:5225:0:b0:36b:3384:40e5 with SMTP id ffacd0b85a97d-378895de480mr1326157f8f.24.1725616368848;
        Fri, 06 Sep 2024 02:52:48 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c5ba7027sm14447997f8f.19.2024.09.06.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:48 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [RFC PATCH v2 7/7] Revert "virtio_ring: enable premapped mode
 whatever use_dma_api"
Message-ID: <e8a8f8c3a2d67b25dd261184da6684fda1813c6d.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit f9dac92ba9081062a6477ee015bd3b8c5914efc4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..06b5bdf0920e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
+ * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2798,6 +2798,11 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
+	if (!vq->use_dma_api) {
+		END_USE(vq);
+		return -EINVAL;
+	}
+
 	vq->premapped = true;
 	vq->do_unmap = false;
 
-- 
MST



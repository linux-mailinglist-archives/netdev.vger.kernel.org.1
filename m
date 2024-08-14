Return-Path: <netdev+bounces-118340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60259514E7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD15283F93
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CD13D635;
	Wed, 14 Aug 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2ecE9ap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8F13D529
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618783; cv=none; b=deWekLXvMyiqUy1GWA6RrnBeuxalJVuvDlXPXO6QwyCmp3IcBBi5ATw4pW56Mb6kMw0zXXexdGctB3qFgPVOwtiRMD8c+xr61MVPEWM7zsFLRmL+Rl2qkFOp2jVv5A3P3Ot0d8CvuH1llGyAB4hMGRuheXE/ZoTcusHw+uwJdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618783; c=relaxed/simple;
	bh=Pu3OGCo/CmwwpRnQchJJUnb7pVL/LRupMdZBjzDEC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdlJYBn2mcrbWpeV7K5UyYZLoD/6EP2QwyLu7BO9OCWGLD903ar1IjjZH6y4BeOaRQIZow6vatDJn/j8SrKkQKB0bwsnBxz7QH6Jo+TXoEvtejFMgmiUUsOfZNwBoCImX7YCyDpwZp4po8HT1eQPj1DbM5cpzBw7jSABEGenHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2ecE9ap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
	b=a2ecE9apV3NRZbgfrqlILZC7MIjOlPkPs/jgXb6sHxZF9sT1Loyp1IMARrUojuzvE9VYv6
	YO+O/h1bmAp0LriBbhpVETuzwgPWiEqtwsAMlnvmz1duggZ+J9rDIoh7AV42A3E4tE1xp1
	8W7wity2fKo2CAbPgj7RwmGdD1foyRk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-XpMnQ81EPzCPIQsddxmkQw-1; Wed, 14 Aug 2024 02:59:38 -0400
X-MC-Unique: XpMnQ81EPzCPIQsddxmkQw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7aa7e86b5eso516295966b.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618777; x=1724223577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zee9dlwcMuZCG921uf8SrLhdaia1L+j7thLeagByASs=;
        b=raUNHeWdvIqCPKJLmRbvOWAiMoRqw/PyhJ/LBySD7bli1mDL00e/SndTxZ5UXCEYKa
         KWy4OxUZwMIDPxXaViN6V8gpR4SbHQv07TvxTg2iy8TwvmIun86PKPFDPoiz8ZWOqMzs
         XUsfW2mHcedoL7SOrrqcFaN5P4/443hDBwRvfiORtKbTRuqBM5wfQaST62j7z3gLYAij
         hW/A5rK3BZ9qRyEDVloviIxDz679CP86NV+RCDh2zfVdgcKCAOJ70iVD5ogwQ3lxiNMp
         011yLHtp//uokq44N42ytHWV/v6WGlMpZv40e7ToO5MYIbIunFaEd/4iU1/2xCMyvLaq
         NGjA==
X-Forwarded-Encrypted: i=1; AJvYcCUdh5uGBJXCTx5k/3hkstKUozdyNTtr2pv4hjpMlRkdD4JAH6wvZ4fFOYzG1jE6kAiPvgB0O61+huUlLzbnNmkXZ9JdwhUN
X-Gm-Message-State: AOJu0Yyo7btZ9dOC0mHCneCluTYGBqfj5GX7gvEFCMPxR/68GLZ/9E4Z
	uK0ZFJCUUyHK8PckhkUF3UmRHXKxENRV6pK24ANYHEdn9r+RZob4+7BygzJvMdPwV08Hl1HBXxZ
	qISXbErsjOfCzBoOzYtXXGmFVDsGNttwDevqQOcwFCI6YAYYaz3XG6A==
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108210266b.11.1723618777539;
        Tue, 13 Aug 2024 23:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyMAjw3UY0D6+5QLVxInfDhyCUgtrNGyRp3D6mJIvUovvpU7E1koWdqS+NoKo4y/Bx+WFK7A==
X-Received: by 2002:a17:907:e248:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a8366c38ce8mr108207766b.11.1723618776638;
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm137019666b.144.2024.08.13.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:36 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 3/3] Revert "virtio_ring: enable premapped mode whatever
 use_dma_api"
Message-ID: <4937ef0c9389fd2031cd0be78ae791d3289b6e94.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This reverts commit f9dac92ba9081062a6477ee015bd3b8c5914efc4.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
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



Return-Path: <netdev+bounces-136206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B29A1094
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439651C21900
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B520FAA7;
	Wed, 16 Oct 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHy9yOHP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66B20C487
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099638; cv=none; b=JPhS3WV453iW1DdZrPrirk67o9ZO7HUtVnPegq/zJT/mlj1d+1TYA2jEhNmB7N8MN7ivMkwmT5rYmtNXagdPPuCQWk9D8X+hzRAZs4YxuWWUt0yEbiHEQv+UFSkfbEnZHW7oWkrprXMO+IMwkq6A4ULw3Os18E/pZmGWHjHOf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099638; c=relaxed/simple;
	bh=fzLmjTYv50o4SO1uhihHDhxEFGjJN+CktGLAz3N15Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A0DtGnVKq9j5uphvK6t7Z8GLM8hVLzF79xzN4a756ktc9j85mqswqUk+Ffg3keih9UibudOqN0V6oAn8Z6N+rRq0P7L/nPziuR/0dZat+5JR55U29ME19U6C9icKlBqONJSjO6yAG96M25R16cIi5BX3ePF8NVV0V1t/dFCk7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHy9yOHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729099636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
	b=XHy9yOHPLqIiocxvFjK6TfjEy8wBdj6JDs10vNRPgWxzPQoDA7tvjoLPGQlMHx+YU/Zd6e
	2THAD6/wZ06L/KOMUiz9PzIXA424vhQCfwawx9ulbKzgyAeTFfUpLGiHH+ml9h2ryBgxnH
	983M4vLbv/gjwHk1q59+kY3feESz+7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-H_ZyJT4YMwmlUk4xjKhoHQ-1; Wed, 16 Oct 2024 13:27:14 -0400
X-MC-Unique: H_ZyJT4YMwmlUk4xjKhoHQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so1245f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 10:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099633; x=1729704433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mm9TWMoNEKmC5/H75qa50GgVA8uFrq/T9r2miRc0UHg=;
        b=d+1gF2nxl4s+BnRxYweRBSZwRnuybFo42N9ZFcCLGuhyqcjK9P6wgeOuNZbrqco+tD
         d0nawz3wijZbPpKQosdhKseV/fqITqcskuqi5hWJUOAGlhY1Ka8yjQ9ooDw1ymfQlKzN
         mYytIcq+C8PQ0JLECJJBaEDaACrP8W2L+CGVHb3D5/NtPbHd37nZzr8wJbSEIw5rBYA/
         gk2PvY20FGwwSZQhRHNlLs1hN7UlzxtlMX/9eMyk5d8HDpOXSd762dXxnIZN2Ydvy24D
         b3WiTmp98ZVkRde9nMjzWeDxE+2MsrP55Uy9FuAFPr95cdjh8V66jmnLjDvHPznwvDQf
         Krrg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOZZl3xtgB28dnueZtyp0BRIjvpfC7I3c0fyQj/racdL18FShUaSv+zNXcn/c2PRfbIJlPrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXYYTVSBOKzhaFdQEpoxa1vYvicwk8djygedDum9OWrgGzcSz
	qFF2rsPajQHIiUdNbrUTfdmfaLxVxdZj2AaLu4NVqvH5gJtF/myEnGwbzsQPUSmaUjpH8UG4JvK
	h/Hq8RVJU5vNzUQyeGx1uSHysh7Ca28lPl8lLfMfkjSj+NQm5Nxr7Qw==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804132f8f.26.1729099633369;
        Wed, 16 Oct 2024 10:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2kqVFlb2DtsXVfaMvtF8YMmP+fSHaEOFSLeUgaj7tCoSNI0g7YeZxeafsJNPE7r4ODqUXg==
X-Received: by 2002:a5d:6703:0:b0:37d:4dd5:220f with SMTP id ffacd0b85a97d-37d551fba84mr12804117f8f.26.1729099632938;
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:b9f1:592:644a:6aa0:615c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4832875f8f.113.2024.10.16.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:27:12 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:27:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Colin King (gmail)" <colin.i.king@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH] virtio_net: fix integer overflow in stats
Message-ID: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
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

Static analysis on linux-next has detected the following issue
in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :

        if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
                queue_type = VIRTNET_Q_TYPE_CQ;
                ctx->bitmap[queue_type]   |= VIRTIO_NET_STATS_TYPE_CVQ;
                ctx->desc_num[queue_type] += ARRAY_SIZE(virtnet_stats_cvq_desc);
                ctx->size[queue_type]     += sizeof(struct virtio_net_stats_cvq);
        }

ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:

include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL << 32)

..and hence the bit-wise or operation won't set any bits in ctx->bitmap
because 1ULL < 32 is too wide for a u32.

In fact, the field is read into a u64:

       u64 offset, bitmap;
....
       bitmap = ctx->bitmap[queue_type];

so to fix, it is enough to make bitmap an array of u64.

Fixes: 941168f8b40e5 ("virtio_net: support device stats")
Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..b950d24b1ffa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4112,7 +4112,7 @@ struct virtnet_stats_ctx {
 	u32 desc_num[3];
 
 	/* The actual supported stat types. */
-	u32 bitmap[3];
+	u64 bitmap[3];
 
 	/* Used to calculate the reply buffer size. */
 	u32 size[3];
-- 
MST



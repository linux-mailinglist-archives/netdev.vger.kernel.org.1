Return-Path: <netdev+bounces-148806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187CE9E32E0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69BD0B25FAC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E71885A1;
	Wed,  4 Dec 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AwhOnM8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02618787F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288886; cv=none; b=BhlHTeeiknJzye6wIvTXu11lvKWGF/V7zkwphNb6OX2++mJxJj6cSqnJw6iTNRY+IYNsfgW3xS4o49z4AOKWstHLXngjDwAPJyyMoDB51E8PD0g538Ni3CvPxIYv+klDkM9xPGiuo04PsKKS5zYNU15ozJXSasPpkJJdQca/u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288886; c=relaxed/simple;
	bh=QyB99KR/E5dyuun3oXDM9y/WJ8QG5my98H0Do5AE/aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RySxPXt/UPeNpXb73qgawIbEY1GRZXVFzIx7CWYpc2axCfyRGRpr58SbYDTd2wJh3na2x8G25uuAv0jPO+g+HQOp1j0KYTZZ5zMzi2wY/K5mBbrLDLdAKgiBTuYYqk4WzO7Fnu1TlNE+UmOs65LiliNlSTPZ7aXlEDRwjhoNMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AwhOnM8K; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E33103F763
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288883;
	bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=AwhOnM8Kkfe0D69Kjh5oJnX/zXegdfKc5fWXWGPU1SOZjs/of9VZhyYHtOOi8MWOD
	 Fpt7tO/O62qlHN73+OjwtLILC/tOQUGQ3BrE/ZCoId18nbNOnE+3np/Tv80FArDaFk
	 8Mgg9xcgLJ5pkDbpmX7D7nZuq11qpHGTa5zqYXGtPkbDgAeyw+wmUS4H0RajFr5Gz1
	 YpRXyZRpWe8yHZx3UXnPZzNwDloxgOxjDHVdbFjMRWdoPMVxjo8NGaimqPfMzxAoVB
	 1eyEiuLJSouqekeKJ0gcJlvrqD3UjIkht04p6kmtwKdwQz6eXhiS6t2zJSRt3Ll4OZ
	 qctgxt8YPbRrw==
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71d40608b16so3890255a34.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 21:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288882; x=1733893682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pCx9eaXWcL4ixwAWHstQXvOGcUbbmljwAztWY9crP4=;
        b=PoI3h2cPiOuWArKdtuwLgddDz3fVVuh3Btx7qy5/SsKC03tfAuLPsbRMAKsYu1GD7Q
         6Qe92KMCiPHylF+6O13reeQxdv8GM2k2ojZJmh9mQg9VeJSy0vqBBdnAq2Nstz3aNO6I
         KY1GVtnjpV9IItX9TBbGdkVlKb9VYtR9N4LJUfoUYPiZRrMxhbFsxswKvLf49nEU7K+x
         RK4GJ9K7KYVPBhtAQBQq/uIEn2JIKl8zJrAD5lMH9uWPonFPWS4n5V5Of8fAtl1IxYmx
         y9HtlhCQUXO5nQS9VHhAsGdiXptEBJ1XSl6e+tRtvBhr79qhLXSKMkLswl+I/3XSm4l9
         DXcg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsGfbUs7sho1iRLJPOXnqytoZFKSk4ZeSpf6daWsq7fqtNgbVmI4KNTF7TF4eSM7mCjMMuY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbxOxF+Byuje8A8selYL4a/V3c4lsOl4Qs/4oPi+oS2Q4lX/J
	B/b61myqMr2RUp5QGxRoR8S2esi3NgGFbs50nd4WQvEKxyAG4+K9914qmVdI2OO442tkqN98G0Q
	uko2PBadeTTA/pQxRBIIP9KIMv5kVmpLqNBmogWN0vphwVBQlPmIjjSoLIh31FOwRQrghEQ==
X-Gm-Gg: ASbGncvEjZEv8r6FbP2e+OolPHzrLYTwHRmiRAel57iOPs/IyKXm2ZIMcO/Wwa6zgIN
	hHUblo1pxylPsLclkFDepW7T1+FgMCWjESuO/+kJia1ago/aG/1oZpK3iW7D2lB0lYho3OJwSTZ
	o4yOeow62Gi8mvbQtMUJudGJfiXkdlOG9QrZlsT8QhMDyt0YUsltrHYcZUU8+KZNxj6L2ZBdGwv
	boouQMruin8CcwBrzjOQOYlPXxI3aUVDtQng2mAhhQodKUlR3PYiJXm3xcztmDRqMqy
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503388355d.0.1733288882540;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs3DkY/VwOKGPPt8+iJ+sQPX2t2a1HIu9jL1g2fxiv2RrXsi55RCQsiq+IatRf8oAeRlGmPQ==
X-Received: by 2002:a05:6359:5f8b:b0:1c3:38a:2143 with SMTP id e5c5f4694b2df-1caea790375mr503387455d.0.1733288882234;
        Tue, 03 Dec 2024 21:08:02 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:01 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 2/7] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Wed,  4 Dec 2024 14:07:19 +0900
Message-ID: <20241204050724.307544-3-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 48ce8b3881b6..1b7a85e75e14 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct send_queue *sq;
-	int i = vq2rxq(vq);
+	int i = vq2txq(vq);
 
 	sq = &vi->sq[i];
 
-- 
2.43.0



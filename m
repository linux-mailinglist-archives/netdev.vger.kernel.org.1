Return-Path: <netdev+bounces-148809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17609E32EE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98133285512
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7C18E023;
	Wed,  4 Dec 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nDC+V+XV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115F18D65F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288899; cv=none; b=UIoY4JQJFaxINdsVgtijJRu4uUp1eIczmB+oyN14MYjQeUSKtR0SypGvb2V0uNYkomPTE13ufkeopIeYjpvAyB/I3YFMYAK3ggygQdc9PuXYHaMKamlVieS2UzICPhBYJRGrD9K0sev2BPDjC1xENyqFL/74B8K7vU2KYRSMdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288899; c=relaxed/simple;
	bh=gLYoI15BjmtBU7oAvSpTarPfyfyGSgvB72KHD0BKUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjcU7dj3TJFKXHF1FsYdvuFJhmlV/cMidML4B2Vug22bz3whk2B5PF2SN/oRfNt2z6QpwelS/DOg2g8yBeOJBBwlphb2E5t8DXtx9y9svZDQ0xONozWpu43lH45xbVvTG5F8AOWGZpZs7F/obsyZ5phFjiJfQM1uTKJfcS/68VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nDC+V+XV; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C5BCE40CD4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288895;
	bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=nDC+V+XVcAD7b1H+1pBB2uwhAywejnQ/hMRFp+/jG23uEQ8xcyCd7DNJrJB5NRwup
	 pvzi+glCd2gAoKxP0vu813xGDVgcIFujukFGUtEpnFIZKnW7Cy0vQITQoxXgl6btHo
	 4Sx585rAL4o+J0zI9xb34fZHydysrUaDjQ8VywfhtJAmfOXOlLaKYo7Ynlaj6bb4el
	 mczlFqveJECYWvEtov3SuxjDvDtmgt9NdFgRrloBTcWfYA5ey1YGTC4w5+CpsxJ+og
	 LJps9Cvx3XxGE4mN5wyK3zv2rmUcvxGqy278oTtB0KT82YJiU8kmNmGTNBaxQdEgLA
	 bDX+oXzAcSLOg==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fcd0eff40cso2399016a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 21:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288894; x=1733893694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObVc7Whi17Pu6UUwsCZaDHkuVEONGWJHt7EBpIl7aAs=;
        b=QIsu1zqdAeolmmPXzBZgwKftArRdRkkm6xpmBzojuo4i7JgZC/KlsxR18y+FbXsnyQ
         6rUDnvaWVnoifS2l01lB4RfscYjBWScTvux30LejJLSpHmAwYoeaGBlPHOYLWllvev7h
         PfLV0RtSQbOyL42hlTFFS4Z6HitOFDUiwjbvVtd7NJSNLJL025EGCtN+sRFsYPjI/k4h
         22xnBP5MU1Fzp+HLMQwOUN3Sib7/80QRV6/JHXbc68wVaJ9LOvR0Q9QWSd4DpajqoUdq
         ujzonTIxYyRCqBDxMWyO5r3b+tiLKUQ2R+3vAn3RcFTBeAE5Nhl1eq5RQJHfEE3rwJDd
         NwVA==
X-Forwarded-Encrypted: i=1; AJvYcCXFb3SIb3RuSply8mM2mmGLdfXdcsIoflTU+g/ZDepCz87auBXwMtFEo31XqbhhQMU/bJtqCEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gBMatB/+lZppWWAD5CQ2G9tDZWggj6G5gfiPc7DPZ78DFd3R
	dUdVTKhqRiH6P9YToZGMQcY+Ci2k4xdYFHS8tJ+chgL3GpUYprHzzHNfIzVio+xbNXH9lUpIpd+
	TUNeCfy4rV3c0QgFGQDlLu3ORCwYyFJnQ9zjx5BWXs68W6HzJatIdsaid7VGLwQ0ZO7YViA==
X-Gm-Gg: ASbGncv93uPcRwgYDPcHz8eVVxxqP+exFUuRwFAkhe/op/sgcRRxVAyiDBRC4sv8LAJ
	NhBo1qJbhdNjC2tg9DEYT7ZhglA5Wc64kdMDIKYDO374gF8Vo95G0jvLjd66rGcyr+283sYV9Ij
	dOrFV/mC7y5YoFuKpLx4auq093nqOzeaKMQNZCjgrhtnpsUiHO7vmlscUHOsr5pQHW+/yStgkK3
	/qHQ4VaqPPHUxrs7dMS/CtCShvJVc/yRriTLTnLWSBLk6NumVrijNma43fFG2r4Yhqo
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699739637.3.1733288894403;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj+uUlyY1C0BsWmALoxtojbbY8sLNjryjJ+hUDmswkw3F7P+vqgijj+KJpqRsQ36IWx1WReA==
X-Received: by 2002:a05:6a20:3948:b0:1e0:c7cf:bc2d with SMTP id adf61e73a8af0-1e16bdd328amr5699705637.3.1733288894118;
        Tue, 03 Dec 2024 21:08:14 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:13 -0800 (PST)
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
Subject: [PATCH net-next v3 5/7] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Wed,  4 Dec 2024 14:07:22 +0900
Message-ID: <20241204050724.307544-6-koichiro.den@canonical.com>
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

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2a90655cfa4f..d0cf29fd8255 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3395,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
-- 
2.43.0



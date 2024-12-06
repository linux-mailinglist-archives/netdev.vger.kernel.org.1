Return-Path: <netdev+bounces-149550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4449E631B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA902837B4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BEA14D2BD;
	Fri,  6 Dec 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pS47XYtL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECC1487F6
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447522; cv=none; b=cagCdc0KPvapd9bHY7t1uZWxpvySLLVwsOr6T3ikdF88lZtQ0HKOZ3UbOukfcHgKqSYBQTn0NiuHxdOShR2/+lh79GMRl/39r+SyPJS5KLPFp4CIrjtfe8MFIyBkLFgly4BEHsk3zA/LFKmaI5l80g/meRjq1j7BE+r50SoFaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447522; c=relaxed/simple;
	bh=RqlqljCEL65bX/4/99BjDeGnmkrxramPpNz4DWizEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H18R/K1pjy94iJBTuonSSxy0Bzy+P3VW1TJkXT0x8GQ2GHzanedQDlcroX7ETp6Ur3hX169AJRqMJuOkzDTreO5z/CxjQKehPe5P8McWDYrhrLCNQlN29w0MpmUf8wTMJ43I8Nl71VzfZJIH+B4xI8M9Dt8pYiMdzqzECmpMFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pS47XYtL; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCE0D40CEA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447516;
	bh=0DkRrRdtwcxltiw3a2XZYsY1oAxq6KLTi5TBwA0X+38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pS47XYtL+oAcOL1+shxEHUTnGs6ELQ1P/SUqrrl6TA7BFzQ9nel40X45fzVwRV/47
	 PlE5ngf+cglyM7PofZJSA3YKAB2rs2nkzqJy0/hIiVp4imyIYSLGGRUXCGQYUauiYE
	 Fd7x9pYQCejksjO+Q0wL8kDenFFP+XX/OlpTiTYTIfMmSGrHypxFHU7PsWCqu2akxh
	 Qo/Tw/seb7v0dTqvSRUWpeHr+pEkv3bI9K1mgzTIURcqzfctEahMJJccSchhJGlibq
	 f7mWbSX+SphkhS9xt/2kJoL0iZdqub7xZsnI3GwpaE51aLWAkV5CPWnR90OR5qYJqx
	 6BPZRiOEPtQrQ==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so1343611b3a.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 17:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447515; x=1734052315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DkRrRdtwcxltiw3a2XZYsY1oAxq6KLTi5TBwA0X+38=;
        b=JE137zMJZU9AFwJcTJQXVkYocxRFBeQgZjHtJ7GlTYFNVFxzlqRCw3Fm/YuHHFqVbC
         WU/c0n1gO2qRB3KlvNb9zmQGTbqdbpz/oHdJ2EkP43bGP7f6sjVA24KLfhKo//i0Imso
         M0fRtkg72c9wRUg58UKkBirHzdYTOw5kH8j1zyjVhelxPnJJmHrVBg4eGeONznpUdjFx
         2IBJf+Yu8Ey/UoMubKXjjhIuqYWhIMdcC3CTVAP3x5ItTYiRfgdeoxR8jn5IOWZzdsyp
         x0YOFIZSNsQJBwOaMT49NI3O0TbAwNyHMONvUgqneFhkpedZUDA9oQBiEzlQ4HY4iCVq
         rAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXECVCsPxS3iMIteCUAhwSuytpRVV20T1XHP/Kbou29VjDgseVYoTJs1c3cNOVwIMNt704/nrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfSj1N6eBGv/uk9LSeZSofvhIfmqnWBqIurpNnVjCmYidG4xe
	1rIvHruZiFucupBo2X1SXrPfOBARo/NtyGb3/w769/KzOOK1FtEXkvBlwXxKp7wQGaXVhXA43gM
	AsBiF0kDnR1t7zOn7hEzxS/sURQlh2r2gcPjdxSDOby6LKNbc2WFZw99clXGUv9ZTtuOigw==
X-Gm-Gg: ASbGncumIAxxJvSooLMekR5ziWQlxxTVERcGhNu541jnDKeZNDc+hjZ18MS2uMVNsIz
	sxZfkFfPmSqZ4X0oU98IGIAqmYac9jU1lwKCkAzC9cHrXMU4IeADsvNhxjBzF7MK53aowWFHpaD
	0Vu/aTEpLbrxa9ToZBT7yS9UCMPZmJ5z1NlRJodg9hfXI34Z5lANeC4IWB3YDtuLTqIPMQ+Cg5b
	G50Q0CKLgj1D0tw1VKT8/zLRxFXwV6dEMf+/4hqht3KJCoR1rM=
X-Received: by 2002:a17:903:24e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21614dc51d0mr16338885ad.38.1733447514877;
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiAxk12TLEAZVlXN3AMx9CBNnCG3b9Crg3EPVg0Vc1+/w62vhDV/vWjq+VCbS4eYtWIXUo4Q==
X-Received: by 2002:a17:903:24e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21614dc51d0mr16338465ad.38.1733447514451;
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
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
Subject: [PATCH net v4 3/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
Date: Fri,  6 Dec 2024 10:10:44 +0900
Message-ID: <20241206011047.923923-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_resize() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when the recycle really occurs.

Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fc89c5e1a207..e10bc9e6b072 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3331,7 +3331,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -3394,7 +3394,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 82a7d2cbc704..6af8cf6a619e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2772,6 +2772,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  * @_vq: the struct virtqueue we're talking about.
  * @num: new ring num
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * When it is really necessary to create a new vring, it will set the current vq
  * into the reset state. Then call the passed callback to recycle the buffer
@@ -2792,7 +2793,8 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2809,6 +2811,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		err = virtqueue_resize_packed(_vq, num);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 57cc4b07fd17..0aa7df4ed5ca 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -109,7 +109,8 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
 		    void (*recycle)(struct virtqueue *vq, void *buf));
 
-- 
2.43.0



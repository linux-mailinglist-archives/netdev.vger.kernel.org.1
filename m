Return-Path: <netdev+bounces-149552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A09E6321
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A5516741F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1952F855;
	Fri,  6 Dec 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XR7jBx98"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD0156236
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447528; cv=none; b=EHO6qOnZpoO/wlMJBIbvKPBdxFuOusoq3OvAnRLmrc0eIVMARAkw/2gOOBOBuzmYeoBOxVUrR+L75tQrzX70vP0fH5+HUq2rfkqrObflS5Zh30M6r9jBIYm0W4CpwHdOmZZfWqT60wno4P5nmPHSgfVfKjLb/cPdfvpGxC0XrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447528; c=relaxed/simple;
	bh=PA8/nHkFzKyb0DBtcvKTmZDujViTonA6IYtFxIJd3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUYrd9w/2HO1Rcxx4ww6bDqclTcFtBz6HQJ9ApZe8fdiP5PbiSjiWafU+60BtQO3BKduw+r6FbgQSAYpyYe0D3sWwfLQKpjLdbUbCI83lrdQwBRjpL0M7B5RmgLS2WWzjEI3P5zVKvMlRLqrv7lXSIHR/Jy+osmgCQ/+tpBBzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XR7jBx98; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 774D040CEB
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447524;
	bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=XR7jBx98txklshiqfsevz5ZWa16wTrmt92/8IpqgN7AAU8hLgNxRwFNr+LYbqEaWr
	 UUoujra0egQdqL/UOOC1guknawWo3dxB3QqEYLCnLZKZQy+hrBij/RyjgoQTWguGpv
	 SXWBIL0FSB+y/HYr/sAc9gQoSA4QmkiRUvIEeKJ393AJVwq8lsLlHzK8on8fNhVfPg
	 Mw803lVS13/4KiB0n9nmoxrC9Rj0QIut8h7zM1hvwjGDdD1KkUb+OEKxyt805P3du9
	 FtcdCke83US3UAbZ1gqIC25fY/rWvJk/GVha+X/v97vqdihWYI+MYnOyGDzDLnv9Ds
	 dCENIoX3p8RGQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-215576aca41so20874665ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 17:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447523; x=1734052323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
        b=bBmxfPT83wAWPh/y4QYdI1zdiwn3gpDotDPQIPR0SAMHn37Mv7/lTE1508wEQuVEJ8
         VgTye7+r3NIDTUX2U4SKDV3Y9LM8Yye29vkKbH1lD8gwQGp2ognS321jLeOXBHbpGH9q
         ZKCWwSD0PehcQWszOMAP5uGPHob94AoMkA5u0fEjG+sqCUPQrW7mzCusOc+6iOokcsEM
         E3zZPClMVQgCgP65qvRvz4J2AOYrjSpnb3i25zEeZAL6jdp0Om16ulDL285UqfG44+5w
         5jsmWdUnGqAN61mOcZWKJrG9mseEP+rWN1jC/7f05nFDaZnzZ1BwLmO7g3XRPDlVmfdq
         gqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb9jXxxA9F0Mlksfp+ICdpAs95gPbCXgcyU2t6ojJ4FIt/GYEz7mtEoWM7dS3tIwzram/O3HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YiL0kPht7w711ZWpnoP5M8jBZWJvYY1Gsx+twJMy3BS2g/fz
	pM3D3j0zm8/6mdHu0f+y4BMx6w9vXxnVQ305E1xxLoNjzix1W2w+S3+PDHlxJRBtnifW60KesOf
	Avo+P0vd1ewemealIJkyy5Rbc7d0y2nOqqyvPJcjnYwJyq+60DhA2VDWOnrG3j6XDUE/0fA==
X-Gm-Gg: ASbGncu5BL8L60ZGr4Yrilf+zm2dJPq7ROOw9p8JgTO/PInQ6rZfvVuPeQh3ZBeEIkx
	xZXCuOXmmhKnWNjjgz7MyHOkXhS8tLHpZyokV0S9Y39emBrJH2hMT/iISUTFvi60NnvFQxWnvXf
	bcwPON1PqH/M4CQApryFH11pIFwLm892CdH6JnjR2q6diMCflz1tQKFOKP7JG700eXg1QHdljn6
	DPJGFLbJItjaxuUO0ylwSkKqcULwX6i3xDPyBW5FdWZKjNBggo=
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81930325ad.20.1733447523058;
        Thu, 05 Dec 2024 17:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXqJiZIYbDQc+sRm11CP5WOXPhB8Q1WFXfqgl8yxVSWKPwnlYc7wDaqcK9TVVx9Gd1p79dsg==
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81929985ad.20.1733447522743;
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
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
Subject: [PATCH net v4 5/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Fri,  6 Dec 2024 10:10:46 +0900
Message-ID: <20241206011047.923923-6-koichiro.den@canonical.com>
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

When virtqueue_reset() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when it really occurs.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3a0341cc6085..5cf4b2b20431 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5711,7 +5711,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5740,7 +5740,7 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6af8cf6a619e..fdd2d2b07b5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2827,6 +2827,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2838,7 +2839,8 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2846,6 +2848,8 @@ int virtqueue_reset(struct virtqueue *_vq,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0aa7df4ed5ca..dd88682e27e3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,7 +112,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq));
 
 struct virtio_admin_cmd {
 	__le16 opcode;
-- 
2.43.0



Return-Path: <netdev+bounces-148810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570A9E32F2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CF3284F2A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715E18FC85;
	Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="e+Z/auLe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FE18FC70
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288903; cv=none; b=T84uncNJxaQP+aiyO1++HFhL0tY0IaX+G7iolSpJHv2ub9QJc4nSiIz7wS7iYepHPNJCx4yZPQ/oPPYFx9D11AQ8KWQv7DSs+tvSr4spH3M1EuGJJBlO9yEbxZMw1dX2/ospLM9ym+v8SJQcirS+uYkwTMUTXYVK8S+tHaQ4M74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288903; c=relaxed/simple;
	bh=/hxsPKXVZNwPj0FSFmTo2DxSrpBL+nEcvnadMx1VMr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/24ISbgyd+xQFXSr4VP3lZnZxmnjhLoaQxghpPVwOT+vdBJsaO9w94iyoS8NJzH0guQUftWHKQTzh29K3MEEAf5WR1kx5On/XwcfmUHpfA/IsurlNMl2Eu+7Uh/av3Jwvj1HlF55XQp8QoAm3OV+RkUTuAG5oSkhR9zVsv9+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=e+Z/auLe; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C4F7A3F763
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288899;
	bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=e+Z/auLe4VrP/HY06rKtp4J1/jkJ7IlDoYUNgfe9m6hcDPyfvAqUkpUh1MApIMp1x
	 B/xbSuhQvt5tDzT2mfCU1UzZ8vWgOukWp/G3D9C31OP5jf25txTbADO0R3R67EL4H0
	 kgveLAt9mbzvRdFWnVOvXH+RsDakydwksvuu75NjQaZOeyoFnPyWfTwy9vCMaTnB4c
	 dwJxaZmcxQqHEaJ9nmTnW16BrBvSVe/APU3EfiJyS6h8N7U0axEjJQCqSQ3nFisLrX
	 XPRWdT7QVUr6ggUahYlKmAXXMix0L8WwSNDhsG1K05bJg126qBncDQYAKQ5apNe13z
	 /ck584pR0Nkhw==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-724e57da443so8417940b3a.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 21:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288898; x=1733893698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
        b=ZEICPfRexC4wPfA6rgiPVKbAsqT3z4E1HNl9RDBR9+DkMdzTQ9/Xdp5b959jXfxCCc
         Bm4lJ7YQhHmoPTtCi6ZykzRS8aYQsX6JUuve35uhL+SznqVxHamIctOjb3sOFjyPM5p9
         Cex0Pz3NyYCmNjwsDG4w5j7Lny5tLHKjYFc4XA6Rc/Ovz8ODmqwkBo3m5Xao/8mxDOzY
         6iD0ywNz2SoJ1YeW+vFZroC6KS8QWC8LdB2fIlGLw9Oh8LRUoCQXRB3FZpRQ9cFrKeDD
         ucaLWwnBq+w9sHOmJBU5otLOAt+vGIou42d3sVxIIhjeEpSApBxVybJBYiGUmkowo2cM
         rcbg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LieSR8jj/wM5mwPcinH1seOFsrdIMv4kFVeD94BrHrx84JaiAaP2lnp3dR+SQp09Bq3YTyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCQBH7w7np4/it2H061CmZgLRBQ3moakLv/64+rxRqCzo9nAh
	rMKecMUGrJ7PApq1HdCqj6GXvC6hGCiHr2jbqinWz814wa+2PGfJgY6PS5W7MSgVI4G8L4gd7oo
	pSUaYyPxL/kldBzsaTMe+Sp3pmy9cVoOYhMlCIZfdcU1gFK4nnGbx5sUD+gCj5bBm8Bx4SA==
X-Gm-Gg: ASbGncs6e0OwHeKEwumNx0Rg+g3M+/Rj37CYjkXFsQov8Kv4gk/+wKhHSi4SwY0MiVA
	eurIzftVXXEJwFD3P09Tt6JUKovgC2Y31ciw3nfuKUVzscTdODU4C+enWyz7xugL9ctvXyEJyE5
	m2cHdb3Szkw9A15jCwXDD4S5heACfcrtaadwmiOQfPDxzxkGmJNMJeMMBRU9PCtxgyvFm5gjbMF
	p5xsWIDp3s3pzim+HmsVtqKLdfx4quD+bgLJ50Z8IgOlgmbox+hUttIpNNDAu+JeS1P
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730704b3a.2.1733288898387;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzK4BK1oktH3ckDZBRjHOokufY6SEBLhJ5DJ7e1vYZicOqoakq+cqHgepP7ZCNIOpN0Nx7ew==
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730677b3a.2.1733288898066;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:17 -0800 (PST)
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
Subject: [PATCH net-next v3 6/7] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Wed,  4 Dec 2024 14:07:23 +0900
Message-ID: <20241204050724.307544-7-koichiro.den@canonical.com>
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
index d0cf29fd8255..5eaa7a2884d5 100644
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



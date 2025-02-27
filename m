Return-Path: <netdev+bounces-170399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAAA4883D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AC7188F1C3
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8626E630;
	Thu, 27 Feb 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kvPpHehL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C426D5DB
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682245; cv=none; b=VC4JzTq//L2PwsgriFs++FAZhoflzGrgiaLyj3zoLMVyQ+PQ+G3QaHM17cD6RgL4T3QZxiOn1Z8/6oHOIlKn32D+cwCycm2nR7o6lI5tpMe2vhqP3WbBRyZFT5VYWfOyeWqBeZH6Y7E8owa/ZwikMHFwU0rOpIHUtokNdcDLj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682245; c=relaxed/simple;
	bh=oZEKZBNyzTFUQoyDm8VLIwp8l+Uss/+aDmlef+L4zKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMAMdaRa45fsysMata4eOprwVJggkrs6upGF9cQ8trPEmOr3RJROZS9cv8yrw3Yu2mi0C3pd1zvvuL8Qd9fiC+AdODKA1PU2KbJ0O1lX/BGPlHwNhSTcqVM7Ba6c19V6LVqTLy+ufwdWXcpWrWF9tSANqoZPeZsf5d5cCIJXXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kvPpHehL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234e5347e2so27346445ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682242; x=1741287042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=kvPpHehLh7QX0nSvKrLbXx4/cHGp+YLaVXCWWPUl+dxWThUR8cnF5fejruKOzNNypl
         BjGRw/eyAuIgj+H1GnV5NQN3nViT1UiCx9BATchjVOjwstU0eloQ6dyR2VeXyU6VvsaZ
         EdGR4zUNTPm8ddCO9zXkwZuYma+4ddcpXGsCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682242; x=1741287042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=Q2gOFv7k7vUhz1/AqQzRxIYSDBrMNaNb2jhKem859yF62D/YOZlx+nScTvZ7exO127
         Rp2fvMAcu6bIBlvJovLevvP2ItYTsHP70eirPBLPRLEoebFolWnYZWZZUCvXzSzBGzBS
         Z63vXhMP4CEDTLgrNlqPXv0FeH6g0hnmAydXGqK3TUOL9qyDN34jyzYHhMdh9USdObvU
         /wW87/5ShxoMTwDy5N8WUJrtNxHeyNHP+B1CHkOl9UcI5vzQZPtIaBVMpeXjZrGhK+um
         elsOCtm3XxDwFxb4rrgl8VT2GmNu1UBWysWaniRQGq9wo8bEZTDkAxPzogQLREyNBuOu
         R3WQ==
X-Gm-Message-State: AOJu0Yw8Rl1sSIGlnmv18kErDS+CvJ1Zbkf3C6dX4pkk2JNVoBN/TC9p
	yuuxqVEz6XzMNTEsD5M/nNKhLJsShtJxPlYzX0iH0MuoSy3UN/UYss2/uy3ABHxCaFrNtmX8v0W
	beUhPI9vSurtpiTjPU8c5QjvYY4jaEmhE4g7cX7IB5GYcv4yPQUIwBL3SFdDluFBNXK9rJinBbQ
	AjbRr9FwX5E4ghuGGpsYe07SLiEahl3D6NyVxoBg==
X-Gm-Gg: ASbGncsEUl9b0riw1mN0WR0wIV53x8fB4S4T481e25x0l2aWiFEe0LzCA6ueB1o+OxG
	AZFwJH40llnMP668RzzSy/wVL7c6HoHwGtDk52ji6fmeIKyVfKwgmZQlUeg45fdEuxzCOJEN7NM
	cNECp0ZoFvUcHE0Mqf3TyVrVxKh3LtbtjaNabZl4aM7oqWALR7aFHTnC59GVMKCItkPAJN0GUus
	K5b7d1A6QzAqMFGv3lGGHoWuGjlu82V63ZpAZmNehHu72zhDdJsvJ/SGA6sHEHYLs/U8vXmpqo5
	WuQfJP6ZVvDHcJczbZqGC1QKYKLZXC8PQg==
X-Google-Smtp-Source: AGHT+IGZcb+iC6eZQd5zAGhqgRUruIqyeQKBvaS/JmNMwuWmIIK9UyEnnF0UseSHFo77HzWGMN4JpA==
X-Received: by 2002:a17:902:fccf:b0:220:e63c:5b08 with SMTP id d9443c01a7336-22368f6a1b5mr3409305ad.11.1740682242112;
        Thu, 27 Feb 2025 10:50:42 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/4] virtio-net: Refactor napi_enable paths
Date: Thu, 27 Feb 2025 18:50:11 +0000
Message-ID: <20250227185017.206785-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
receive_queue. Create a helper, virtnet_napi_do_enable, which contains
the logic to enable a NAPI.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac26a6201c44..133b004c7a9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,7 +2807,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2820,10 +2821,16 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
-static void virtnet_napi_tx_enable(struct virtnet_info *vi,
-				   struct virtqueue *vq,
-				   struct napi_struct *napi)
+static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
+}
+
+static void virtnet_napi_tx_enable(struct send_queue *sq)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct napi_struct *napi = &sq->napi;
+
 	if (!napi->weight)
 		return;
 
@@ -2835,7 +2842,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(sq->vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
@@ -2856,7 +2863,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3073,8 +3080,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
-	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+	virtnet_napi_enable(&vi->rq[qp_index]);
+	virtnet_napi_tx_enable(&vi->sq[qp_index]);
 
 	return 0;
 
@@ -3339,7 +3346,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3402,7 +3409,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+		virtnet_napi_tx_enable(sq);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5983,9 +5990,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 
@@ -6000,9 +6006,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 	if (prog)
-- 
2.45.2



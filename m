Return-Path: <netdev+bounces-170400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E16A48840
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E703A7C76
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383326E94C;
	Thu, 27 Feb 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ij+Yj6ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9126E622
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682246; cv=none; b=U0HXrnbHp82PD9EjnIl0oaEwv/sXSew3LTT4H1BmxfreGeJcfXOCKDT0DNNspYHoPg5KiVuWveK9M6dHNwzE+q1qm9hj4nvYNzDVlGN7dAzz75AJ+TeT2cc6H4eRQw5IZ4YZdxREopEzcuVCJHPT+hk1p5ypMV4iCW+7OSirpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682246; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGzhMxRLNi8g0dCoTsx0dhQtEX42B6DamoCSthySMS2HP4XBXBxXe870FCnTMIJL01Gb3vQUwSFrPxz/G+qB9bcbBD8mZsAmAi9zZ+Qhc58Hd0tncRJb9dL00zaeRznLxVc5cy6w/nzux6x8SoXsGKIl0YiI6d3ZyRMrtrr89N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ij+Yj6ef; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso26518715ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682244; x=1741287044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=Ij+Yj6efCnaOTDAfh4AWIN1PMa8RpbRuEs92Zkmm0FOrPQSvSwoLXPD9Cg0v3WZG6j
         VM1bYerrqXtV4yYyazwsMl78/j4/Bs8f7CYVv5OH7jCqtWywgINzkFmcHzXU8fjoER7c
         Mx9QQd2pmoAHnAKnxrdOpsqvkLJGiHo/ih/30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682244; x=1741287044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=WvVU8m6djel65D/GSSuRPNMac7kUQRZbLaNL1Lx8wCIcZCppJTfEVmmKztIlOoHBmU
         0zaNA90+ffSvii7C94sk+fLwyqFuV+Wh1f/R8xAC7gVddek8LBuE/EEPywZhWrr8mq+6
         dIsVAYyuCBfFXx3ufSjMJ9Ej4MYgXbijPT3lviWTD3G6rmmSBIOL3cnKsn2m1x1KJoea
         kxzjHTu+IOYXQlu+Nh/jkKQ6IBDUUA9M+dNotbrwjOKm4edvV0JyIvG9l+4HGKHPPFmT
         fZu+NBY+mS2DGcV4cvfsjfkPhwlGl9YaG6s8Q8HBCwDxFk4J1A6XMGSTa2ONDanGYFx7
         2qIQ==
X-Gm-Message-State: AOJu0Yzw8dPW9ap1N5+YYMZH2WShJ6h/4ileQisnAaZt2/9UDGxQWR6c
	SdJjIjJ4u5n+uPqPt4j+H/WldMP021JmhHcCRXELqqKPkzWR1r/iYw0tiTzsleZv5Gqqn5jVArc
	acwq8xHAjmb0cP2FFzWjvCSK1scE1MNwFllVLLLSvUpxdkCqIXRcSy2iZAh0+VyI1IFYrbLah60
	241/9k+h80M/pNpvtr7pFeU0ODdYY2AM7Q/SwlPQ==
X-Gm-Gg: ASbGncu1sGOaAEamGlhzohwq+uFIAhuBB/z+5AYA7YRAsmuRm+V7Fo9eTJId6oROgKn
	2tkpHPKgwVVJolvnG5G0wBmcX/R00FeKDEHjGkwUFmDf3Sujhx9iFCUYmjcOoqgpI3S5hI2AhP6
	Q/DlUcYKlsWjmqTGy66iHHA+1sSJegB+I39+S6psYPAargD3MWXoW8FkgpTzfu3LSDFomY1T3bf
	X9XiJPZMc4pusW9arzBy4HusKwjVBHVQwsjyf+0iSpV7Iwcb4dBfgdZ4wDF7npZw7s+wpSJ+Gg4
	iGolzQfIRfX9TOUGqY3Qnt+3PvtPGG9Txg==
X-Google-Smtp-Source: AGHT+IG/mIbJ7+AwlpU7kzFyTXUYqGruYlMGaC/kiigMhtr+Deogz9sMy/ksGfgjZazdRJbKbvfNCw==
X-Received: by 2002:a17:902:cec1:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2236925558dmr3548155ad.32.1740682243894;
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
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
Subject: [PATCH net-next v5 2/4] virtio-net: Refactor napi_disable paths
Date: Thu, 27 Feb 2025 18:50:12 +0000
Message-ID: <20250227185017.206785-3-jdamato@fastly.com>
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

Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
to take a struct send_queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 133b004c7a9a..e578885c1093 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2845,12 +2845,21 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	virtnet_napi_do_enable(sq->vq, napi);
 }
 
-static void virtnet_napi_tx_disable(struct napi_struct *napi)
+static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct napi_struct *napi = &sq->napi;
+
 	if (napi->weight)
 		napi_disable(napi);
 }
 
+static void virtnet_napi_disable(struct receive_queue *rq)
+{
+	struct napi_struct *napi = &rq->napi;
+
+	napi_disable(napi);
+}
+
 static void refill_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2861,7 +2870,7 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq);
 
@@ -3060,8 +3069,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_tx_disable(&vi->sq[qp_index]);
+	virtnet_napi_disable(&vi->rq[qp_index]);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3333,7 +3342,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3375,7 +3384,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(&sq->napi);
+		virtnet_napi_tx_disable(sq);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -5952,8 +5961,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_napi_tx_disable(&vi->sq[i]);
 		}
 	}
 
-- 
2.45.2



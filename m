Return-Path: <netdev+bounces-169268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75430A432C8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEED189F3E2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E91494DD;
	Tue, 25 Feb 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bw9CQfWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAD2C9D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449114; cv=none; b=ObG40we0TPsU2U5mheUR4Wi4oUT4oHgAQ0vVI3z0dRCc89aZC7mqO6u+ufWFj9qihqjPHzjSX1Y0Z5OJLRfw1PuZtt4gXHq/nTtRmLZBqd7n+iBJRo5pxeXvdUmcbRW2X8kQY8jGRiHEFi+whKs5+ihy6ZCKd0okXg4xpM3r6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449114; c=relaxed/simple;
	bh=O1/087om4F0aQVS80+qWqW7HTYSlWzFCPffyQOL+39g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc15M0VJhIXOIVfDw4UiHKFr/7GHxorSDkirHj0rLlXZC7CpFOD+gKgZx+DmsB+dPty7O1g8VGEKbw6YcYn/2wwAlxkxsKJAtRS4dvoIgXQlug9tLQmK7WnTVpS2GDu3/+x7T7UxNjZhTLI0xhaZS3qfCWgBhmKT+vJm7GGocAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bw9CQfWv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220bfdfb3f4so226375ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449112; x=1741053912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=bw9CQfWvofOQK65sxBFINjA6c9lVhiKwonOMhooD1Cs6jODoHyx2Xe+8/E4s/4iZp+
         +qN7xbmetHDf9+oQpkHVR4n/uMPlhy8gtotmcrJdaFVK6aoameK+kkHdaAX1x1JNQLZH
         /9AkoZkTtsf9RnAP9v07Iapx+4qOZ6ndiHg/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449112; x=1741053912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=cNI2La8zZ4DYx04W9B2mPI/XECHAkC5eigTHniqmRV8dTGhw8lwDWk9pkYc/UBHwzl
         JitovVPjluyUpFje+Mo4hym30djDcf0m+VNQ7IwJW0aLGA0nYVb/oV8jNLP6Afdmj0KT
         jcdH0VjgHXPmltCP9Ceq/QxhBPCKrgbE1jbpM/KvjzJZqd7/9aLi6/cSiCnAl/M74egY
         ydXwGFUTvjvU+jJn+ITvQqO9J3luvYVA+HkQzHftCIUzcL4NtpzUUxj9IpwxwVHxvu8S
         +qd83pyqXtHhy9HezvCRWtP6xsZ7k37h1D5wU8E+VJu1DJQsr1r+43KDrayPrUBgy3o5
         lfgg==
X-Gm-Message-State: AOJu0YwCd6FRY61S0QX20GbSPsabXEzoqlQprQOvKGMlmrLcVK5h6a6j
	fHXxhtFmfHEtGIeiR/Diq01JpQpIaev5/gmZb36IXxwzFXEGdhyYry0rGezylCI2rpvIe2/3jK8
	fPhRDMcrSJlOC4BZHWsHqQuIXXRqbphraXNiRJeEZwMa04CQ+I6Y3ub1men/gpVDJ2cseKb/GiV
	ub6uj43oICJfMzRkB3Tz64YwOyFLMtIUs5Rn8E2g==
X-Gm-Gg: ASbGncsO8Gx2pCsFsW/XHFrFyt4GVJmRwWz/K3ouMOIzNyfzGTsLzdEgXyxsu1BNPJ1
	2+VTgL77BxJru2bJOTVS5na+7SeWEao+Dvedl5WsYqVuZQ6bhw3boIgG0V/AimSBnazLaX4iDBF
	Ye3bhYrNJvN1GskfxbwzKsmnw2WQuaHf7fJWdSLpGaRhLj3jWOKztgZVaem9q+hofHxc4FHEMY/
	gf1NbIGzFc7p50/8FZ3XvyvNOaLsxNxyGJoyWkVv5WlL5ywNpevj4HM8KyB4R1mrrFW0d4qYAwR
	xz4NBKXz4MY14QSiISij+MIg+fq00jI55Q==
X-Google-Smtp-Source: AGHT+IHY8lwN0JrUuvEAmWjnsdHLEwnDxmgRP+MXId726hvqxCaVfFz4XoQuZ4YlYhDmAgxBLFzirg==
X-Received: by 2002:a17:902:ced0:b0:220:e792:8456 with SMTP id d9443c01a7336-2219ff311c3mr267682865ad.11.1740449111274;
        Mon, 24 Feb 2025 18:05:11 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:10 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 1/4] virtio-net: Refactor napi_enable paths
Date: Tue, 25 Feb 2025 02:04:48 +0000
Message-ID: <20250225020455.212895-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
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



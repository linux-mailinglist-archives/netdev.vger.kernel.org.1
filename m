Return-Path: <netdev+bounces-172718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E1AA55CD1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8677116DDD0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594F117E45B;
	Fri,  7 Mar 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uXXbd7Ux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE41624E9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309946; cv=none; b=m6QTwhZovSEtYYnznOnGo5hGdsrnbxGQKNC1q1xltOwce2Z/YER+aE3gxbvLoi7CPdsjK2xMTzW9ihmrk7MIUaSgOYUfvHHHtZb/ovSA8z4kxzeWDRJ9+b6d+B6Lx1T9o7jA5GB8RyfZIFCaP5u99Oqk5fBBE6CebSC0hOKcBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309946; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFmuWWP2udkit743F6dAdF6jKgy/7wt9ejy4BlT/aQrbbt9DTWOcWYTGNowRCw9MsQa2aufSV2KE2zBGWR2kH31aRGmzDZvLdmiYjQYFsNTmVEkA2lheiAyijW27ZMOvQTwgxM9m+zMNg8nKvZE5bOwfPr56POyr8fB0uW0CSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uXXbd7Ux; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223cc017ef5so26498265ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 17:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309943; x=1741914743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=uXXbd7Uxc0itPUE7M83fbS3D+/GaNswUO4C3yB7UDqCf7Kmx09SJyAuDcJ2GXpFSPc
         hbN6f6CENPJEKIGrWjmZ9szhZ3NoFPqsawtTA5wbQ4qV5O279iQWCj1vHC1ssFqiWt/6
         SgjfyUhqjNhQE8sqBNMzVc4vXIu2lAlO0XJhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309943; x=1741914743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=f5AdH7D0j6f5HN/qLfbcjWhadh+5eTeqDW06g5dTIV/x5o0cAo+cMo3QICbH5alH61
         LQeDjByFrpy+tb2+TTgCtX6YhU7SbmNSLYgD23VARDHLC8/uSJTY/u0d5uVZwdIUhNu/
         XJqgZkOLuCEoJ9BUgqE50MNWagctEwc1Une6I+bieYBZa0ORiOBMz5sObfKjeMDwBXyC
         H/IB01NSc22E/MADJc3vf593qQafYk4FVOm0/qE8oangJ44Gtb4guhVezvHD7TeuPDer
         wZpuztfOIrx+dGAV7pGiRbVij4mrt+hr5yEo+A1C5RPo6haSXxu/1egFd081IEuN4ogy
         Cllw==
X-Gm-Message-State: AOJu0YyzeL+Pta4/0g1nykkSlWH1ttlzVOuqk/GXAtZCbE6nTOp04ych
	Ji2XmDE3xJonothPgx29hfWwZ6kFVHiiQREfU2a2rdPfsc5m6JBLYgOLOLapYghiL0TjKPY/en0
	1HGQTecUppOiv9SXrQzbVOfFH9T1dhd90bvQGdJ4UcbAqG+f0mKvsRwUoWIJHuy4kOPEkJ3lXXw
	jRrGQGVs9kzEObO8XNjUzHLFApI/7mVMjIyk8a1g==
X-Gm-Gg: ASbGncv+Jg9gbYvXiHn0Mv3bmd1cthvTlhm83ca0Q5CfXkymdTCxJb+LA3qoIhgrroh
	2BiU26Vr7YSwQ20YkHwjYj/SN/we0puNVsnKdslJ+EI1jsXoeQgbZ3Oe0az50aIBEnQB7sCVGcK
	iqLw4h95HIqdxapkwX3MnqzX0xw6awh2xZz8qAKLMxL97mMM+HRXjiBUQ629qDX79F5o2jpi8Zw
	Ez0W06z5G9SkZK4uC11s87SB37ybG6AQKkuAOAizuIW6N4THC3l/GsFvYWLSljloQowVCM1mgdd
	rByAF+Xr+X1X6SZLI9BHkzUP4LDJSLGbrmLP1dcEIfRuUeCc7RYe
X-Google-Smtp-Source: AGHT+IGoI+aPJvj7yY+4BLZ2+twYf/oT3+TiRwVbnShK0v7noTjCRMsILjhJFgqCavzprURMi0Wvnw==
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id d9443c01a7336-22428c07537mr25062635ad.42.1741309943342;
        Thu, 06 Mar 2025 17:12:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:22 -0800 (PST)
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
Subject: [PATCH net-next v6 2/4] virtio-net: Refactor napi_disable paths
Date: Fri,  7 Mar 2025 01:12:10 +0000
Message-ID: <20250307011215.266806-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
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



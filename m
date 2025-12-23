Return-Path: <netdev+bounces-245878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A6CD9D4B
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CAE313A083
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEDF34CFD6;
	Tue, 23 Dec 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mns/JyQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529B34CFBB
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503635; cv=none; b=Wr1thTvL0yFUm3pG9x6beKICuEZwvQXCyWHSS5KXuagRKQtxi85R17tfPctFBcEChjk8+bFKceLsQCddJQZS8F7CVoKGUSUoJOjPM33i7JKAOAXwoi5i0ux1T0YyWDBDPK/c6tB9FxsbQiF7VjUTfGRpjeCdGV3XYonzjZaQuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503635; c=relaxed/simple;
	bh=L0CtNZGdC7XEOtswvmiReCjZIo8GsOvQxUlegVLHBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roE26j/gRmKWoTnYZbFMtj5woaj7G4qL2ZLy9NRETJdQyNuP0HLGw7/+2sWJjB9wqG3RZCX246dkVyRCGCMDIVxQmcqrhGVIzFrF+v+4ZfM5UMY6X0UGJzlWlhwi7n7Vdg5fBwZ7MKfo0IebgMKQ4cWI4+9e4vzzg1fRicWSrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mns/JyQL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so5534203a91.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503633; x=1767108433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=Mns/JyQL3ZbTTxK31p0r18sp6DJ+Q+s97WF+rN1ST5Srksx87q+D55AAgtZy/O95iD
         nrLQPNeQ2HmIOwhbDJwcOx4d6jLHq2P42xCyqUwhZNTq9JiSV0Eu5Z8+hlkofdaAnPRD
         OzUyzgfIGEesEvqxIx3DYugm0STsrVfhPlS6Bg6BRK/rG6wF1jNKm7dnHz8AHZT/yiUD
         k1O6Bmdoh0uzin2fTFz+Y4h54Po88jj+PtrAneQO1opqjeMeBOyfo8gAhKTsFobreYHE
         XveNQv7bNKYtVd30uMyvWseOJq8wntTMIDVeGWoFcttADWyARXqaLe5Cj5UWCZGZl//L
         9oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503633; x=1767108433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+6D6PVRsFTnS4j3cktmLgH5az1adeAVQEKO6DToWSU=;
        b=qOY9zqvPVeuUbcLwTLrh1PIfPpG7RSGlQYJqO4zK2a+9gSOPY6zDQYtewa2zydi6Ah
         68AErAP2aK7w5EvpNoE2eq8WF+Ewgvbv49MZttYcZq6wwdt38zqSD3Pq5PfTXpKRBKMz
         Ajs8WrnR+R8sO9GVEmmcjfF7mXDDUz3BxaoEWnYGi9UG4sL6/GNpMtmpfRsagejal4Jr
         iGUrLAbeZTxwIbD/d3Fuj6paBU/KitroAGs8ZUpHIIx1+xIPTrLcijxuDcS4MWwF9gT9
         eATbIY2E/1w6S5Idwv3bw23cjWyh3pS+53Kfejlen0uSq1utzsTBBN4APXaK7U2AkgER
         x2Dw==
X-Gm-Message-State: AOJu0Ywlv8pYi8QeYlgUydocQ3XWh78ZuuyOFFF0pnP3iy7WNdLLDDl4
	JT6DZhEkcPbU+MmKpfLl8drPC1DskcYYpopIVMpx0e4ft+BB+esevwys/IWvs8c+
X-Gm-Gg: AY/fxX7PPo5iJp1HSS/CSl5TvJT84SoFJx9lRDaAAEjcTlmmY+muTpXumZkCeJxPqU9
	asEalF6YG8lECjrqCWLdGr+KnGlLXEUqVhED699E4qLEPB/ZtE+UqVBAmER65/kAOpE/8HvcwC2
	Op4TQWckga4f2J3fUoHkheZVgcTcbjpk2nyOx9pvsluH/+GmoxD+yPwhq3X91eXsKbZZLnO5Ikr
	nP9u2jo87RyFGJ2/6SlSqjjsrRNIx9lDJcONXO6gk+9j+mr9yqMiwhgWIxwhn1buikMqD7ALPU1
	bdVuE4CbkSmMw9GFcz6NrB8IoTEUGmf03QiFS3FOU/h5//2g5lAuub7QgVbKTZUjsub1LR+4w/q
	xYkgPsY1qYO2XoutEy9ZhMO/n+zPudLI0FfJQX2I0Kv8ZH0yTZT2P7XhUBKRD4y878vd7AfXhCz
	9BV4XWZ92xFzSCyX73IxrRw4244sCGg+FlUAc=
X-Google-Smtp-Source: AGHT+IHPZySRpyLioNlkGmfBeBlfCuPepN+ltwQg7UoU9dgxoY0VAt295aBDiCrvyeMv0Apodcz+Pg==
X-Received: by 2002:a17:90b:3c4d:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-34e91f6f93amr11885237a91.0.1766503632955;
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:12 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before enabling refill work
Date: Tue, 23 Dec 2025 22:25:32 +0700
Message-ID: <20251223152533.24364-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. Because the delayed refill work will call napi_disable(), we
must ensure that refill work is only enabled and scheduled after we have
enabled the rx queue's NAPI.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 63126e490bda..8016d2b378cf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
 	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		bool schedule_refill = false;
+
+		/* - We must call try_fill_recv before enabling napi of the same
+		 * receive queue so that it doesn't race with the call in
+		 * virtnet_receive.
+		 * - We must enable and schedule delayed refill work only when
+		 * we have enabled all the receive queue's napi. Otherwise, in
+		 * refill_work, we have a deadlock when calling napi_disable on
+		 * an already disabled napi.
+		 */
 		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->rq[i].refill, 0);
+				schedule_refill = true;
 		}
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
+
+		if (i < vi->curr_queue_pairs) {
+			enable_delayed_refill(&vi->rq[i]);
+			if (schedule_refill)
+				schedule_delayed_work(&vi->rq[i].refill, 0);
+		}
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
 
+	/* See the comment in virtnet_open for the ordering rule
+	 * of try_fill_recv, receive queue napi_enable and delayed
+	 * refill enable/schedule.
+	 */
 	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_refill = true;
 	if (running)
 		virtnet_napi_enable(rq);
 
+	enable_delayed_refill(rq);
 	if (schedule_refill)
 		schedule_delayed_work(&rq->refill, 0);
 }
@@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
+		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		} else {
+		else
 			__virtnet_rx_resume(vi, &vi->rq[i], false);
-		}
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(rq);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
-- 
2.43.0



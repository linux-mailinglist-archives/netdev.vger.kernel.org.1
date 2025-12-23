Return-Path: <netdev+bounces-245879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E36CD9D69
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17ED630B01D9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216A34D4ED;
	Tue, 23 Dec 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEEOpmP1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70834D4C0
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503640; cv=none; b=M10xD1GEwmcSScb1FjVmbPU/p8jbnP8FdYGvLPJdUNNWdXrKeEf4aDhtcUMhoqygos7LnX1tTkCNBZoJxR+ifnEumcaLYlYWJNYYJrmrn8js6hdPHr/68uT7M1tgWfVmmYrwWXaaMOdsGWEp+yqgLQ0jMZKGtCuZybjJ/I5gsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503640; c=relaxed/simple;
	bh=dqAVCd406spP927ct6RgvB4a8I1dOdU+v808mOA7XuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLO4dd/MTPMoLiI6HqJw3D82tyBWUICIRRqv0eb7EccfivGdhVSN2clG4sfURpFk8tdrRU9BRV3c5qrstX49ECNzv+p9ABH/87aCr4nPhFIUFSw8/6zipdUNHMu2NBvnL7B6lkVB5ayv8/bNYsTGcZTKRK651RZe4/ri74PJfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEEOpmP1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34a4078f669so5093902a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 07:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503638; x=1767108438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=dEEOpmP1FdgkOa3ktWP8RLJupssR+p8a0ID+w0AEfkGuW8t9R5zULSqd5pllEznehv
         eGj7xgm98JtQGTmKza/LZkAFZPDb+24cAJy1ubomu5FCY4xz113NQe/PVfsQBWWUJEFJ
         Rlr/PuHgHsP2/aAdgYQsr1/9OxCdN2OCEgp8hehA28jtPza3s5gDuJ8dnPJFjbqXsB9D
         PVyC2ufQqtWqe86Om883mdJIaHvf0dgwTTOg1dJssCdLoUiu5r2meFWox6zaG1PvIkLD
         iuEJms2dHp9YZPCO1ib/Ujhcgt9MXadBCN8TWkbdupyJ2BlEBQe/L0Urx31DCC7TUxPa
         DupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503638; x=1767108438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=eQPRsJO0NqJGdTk0oQTzSWIN0pj/kBTnsfASd6ngMdffYQJIrtSb1x4XIlz7qntG34
         U7KqlzoFek8Br5qKhuT8LnIbUZSrk/DLuJvNweMq20eLzK6kfFw9iKNBLQYUtWBPcvpv
         pplhXOSz01xRZ/c46Xt1E1RkXwDNLsbrnSQ2Ofw1pl2R6svpVoSP7NhsSpa+ZwwhCJ1G
         YlzvLCT0/VzMhAtqOjJcjipJXVQXlLifdxjbdIwHpYa5i+6iAV5IugdWTPbbUIgfthCT
         C6SHBmlAYI0c9Ujtsov1M4Fuv3Kd6DnZCniHE12/ZbUA0FrLNvmhx/8QNQE1Tnn4XXx+
         JD1A==
X-Gm-Message-State: AOJu0Yx/p56wk8UnSaQaw4ynvZLNtOaSIgCRdz0NT5BWP8VAk2GeHXHU
	c/5Aq43Ojsk12j5QeQjE71aismet5yT3s2qRH3ynBaq8QgeylIfsP9xEhtGBN5CF
X-Gm-Gg: AY/fxX4IhhMbDP8Qt770GEfOnhZ+MBpq7Tcey3JRz3cFtRVNsK9e6cZT2NW47nK1fMK
	oCeStjWMh5TZ8M5GYh/XTq17F4uy//ORv2j48ykO81aSvdXzJ3mNTQziugKFKHYDJ2v+sriTlAX
	7q2oemmmbSm9bF0OF85NXDwGvxnKlDLykCnUHlrCsMYGokH/5lQalLWQWOdCoOoiHvqiychQBfD
	UipTTc1rg8SDlChdVEaZSi1ieRSEzybX6MCYUOYsk8zQMDlaATMfIVerXv85Fz/zke85AojMdC0
	+RrZH9Cvr+FziWOL1UhemtgikaflWQCdLAIUF9H4NPIeq/3nCULwWcEysRtwXvmGaLloqbczsIM
	N5NA8ugyY0TuNd+GezGlAifWmQeOFfNdZSmJDNr/IJzOCa3j2H0LNYkpqq0lIDDSuxWqpJEMuTF
	PfbuMcswg/uFlY7BX86Y5Rs14p
X-Google-Smtp-Source: AGHT+IEk5kNaKT2vsTzXqOJuqMCa8BgC7mYYuynqk5le798li0SZVD/6VGOpORiTUPiHf0D9J/Vgsw==
X-Received: by 2002:a17:90b:3ccf:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-34e921f7eb0mr11071309a91.33.1766503638325;
        Tue, 23 Dec 2025 07:27:18 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:17 -0800 (PST)
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
Subject: [PATCH net 3/3] virtio-net: schedule the pending refill work after being enabled
Date: Tue, 23 Dec 2025 22:25:33 +0700
Message-ID: <20251223152533.24364-4-minhquangbui99@gmail.com>
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

As we need to move the enable_delayed_refill after napi_enable, it's
possible that a refill work needs to be scheduled in virtnet_receive but
it cannot. This can make the receive side stuck because if we don't have
any receive buffers, there will be nothing trigger the refill logic. So
in case it happens, in virtnet_receive, set the rx queue's
refill_pending, then when the refill work is enabled again, a refill
work will be scheduled.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8016d2b378cf..ddc62dab2f9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,9 @@ struct receive_queue {
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
+	/* A refill work needs to be scheduled when delayed refill is enabled */
+	bool refill_pending;
+
 	/* The lock to synchronize the access to refill_enabled */
 	spinlock_t refill_lock;
 
@@ -720,10 +723,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct receive_queue *rq)
+static void enable_delayed_refill(struct receive_queue *rq,
+				  bool schedule_refill)
 {
 	spin_lock_bh(&rq->refill_lock);
 	rq->refill_enabled = true;
+	if (rq->refill_pending || schedule_refill)
+		schedule_delayed_work(&rq->refill, 0);
 	spin_unlock_bh(&rq->refill_lock);
 }
 
@@ -3032,6 +3038,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 			spin_lock(&rq->refill_lock);
 			if (rq->refill_enabled)
 				schedule_delayed_work(&rq->refill, 0);
+			else
+				rq->refill_pending = true;
 			spin_unlock(&rq->refill_lock);
 		}
 	}
@@ -3228,11 +3236,8 @@ static int virtnet_open(struct net_device *dev)
 		if (err < 0)
 			goto err_enable_qp;
 
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
-			if (schedule_refill)
-				schedule_delayed_work(&vi->rq[i].refill, 0);
-		}
+		if (i < vi->curr_queue_pairs)
+			enable_delayed_refill(&vi->rq[i], schedule_refill);
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3480,9 +3485,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	if (running)
 		virtnet_napi_enable(rq);
 
-	enable_delayed_refill(rq);
-	if (schedule_refill)
-		schedule_delayed_work(&rq->refill, 0);
+	enable_delayed_refill(rq, schedule_refill);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
-- 
2.43.0



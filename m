Return-Path: <netdev+bounces-157267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CFA09C67
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B37D16B50F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1921CFF4;
	Fri, 10 Jan 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HdN1EntK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83F21B908
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540786; cv=none; b=CLJg6yxU7GUlDblUKedcG8pV9vb3x0SZfCIWlHR+Ym+1aOj9KFE1tV6CDozm+9YGy/FfIs5Y1I2bWYWJnkKkimVo3qmqVuKOxkR1BVxDlBOe6hld3RuZPYLQZ1ovI7q5v2VkmnTDXPxFCAOTSFywoOm5QPzdD9eV5puSUbYoZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540786; c=relaxed/simple;
	bh=nXNvmseKjVxOB/p5zaC6W1Bj1mcIQTUBPceRSuG8Qpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJoSgRXb45jEZGlwF4CmOEOJHM9/IZjo/SPFA08qEAIrD1Jt3sScZF/8g6yk+t/bJ9R6OXptmxnnHI6srW5Nx6FH04MHTiAkkwznhg4pewKxjl4lQNi72DLxXdn1m4h0ap14PUUrMzGczwD80OJ74N2hs/N+CpkkXRsNhwtwP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HdN1EntK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so3508948a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540783; x=1737145583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5Wc1BZX0qLlows6HUppLFsWMw9e/cDJxHu3IFsmtDc=;
        b=HdN1EntKBzkb1cXTgZAYrIJ6FR+5I3pTkOF5vWJK8noPEtwZbxc9hKaH52DqH5LfUI
         +loYiLY+Ok7H3vynSCZdMJL+nk+cBD7sFKBWChm2PtbTPej3/kukUmrg8NVBUQqbxCu1
         okIRvaLjWtNJK2s75UoBh710/F1qjILMOokIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540783; x=1737145583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Wc1BZX0qLlows6HUppLFsWMw9e/cDJxHu3IFsmtDc=;
        b=CXPo9Uio1orYt4WVwZ/5VY6RVxHGQ3w2fAvJrmJIKpVR57hU1FmF6QHTTngt639DbI
         WuLCffvrsUt8FdapCoZzbkrdO21vFV/kcnpGWsh1TLhZ+G2ahnY5JA6t6oN0GBJnoPyK
         w5GB7ZC0YpdGybdevX8ZJdk2wQctm+ZtHpeLQWaYvLVMBybnBsRa8RjpOatJupMe6gpG
         7TCihe/FmkQ5SzTTwtfuSUWM1S0jzWOP5kcRnWhxTA2uVqWlR7bVQWOtpDVmKC5njJQX
         Rl/SXLvqleB8Psrc+c7K+mRMciBMa1REe9TTstSdEUgcNeCV83C1wF5E2GsAykeKKMQs
         uaMA==
X-Gm-Message-State: AOJu0YyeZ+x4H1hM8s6UEf4uCM5X3nKYIP7XG1u6xmbj1NITI4yUxV+C
	/hvrF3PrAr3STL9Jij5gAHwt3zza7OI2jlawODfkdgfCy8YDEF+b4M8xfWkgoCDTgIR4u7MUJJ5
	JBnJiILo02HY/LN9z7qQoZZ+8LMWKZsz8D9ZaitnqQxVw9h8Jq97GfWAfcDFeigDfq+dnfcj071
	PBYwpNq9oz12TBP/nKUftHcZ1Zsg4KYTXA/us=
X-Gm-Gg: ASbGnctgjbGKavghhirH5TjG7yBzqBYDGvS7SaP5psgSYgHRxrClgIVQiFOL7wUfCAq
	luiiyfh4PPZxPUfd7LSFjXbWZKs3X6/DaMzfOlCC43e3a8VQ2wJM5QngX+LNP6+LqzzZpjSiHWf
	6ZJvwFMC7XtDIQV6ahuGUFxoOTWIZHY+GljRJGj6GRJrG8CrplhNvSOnmNu4WEVD5Xo4ko7CLt+
	+XxHkrZbkXbpkx6TS85BDT0arA6o1y6SoMt8ykOk+J5R4J6eCJWqPBfMxLhF9GL
X-Google-Smtp-Source: AGHT+IGIJhOnEc3zWaTR7ImuwsB7dqzjQabiuroM48+nisL8PT0O38c5xZ0k4VU0MQuusWD0teh7Jg==
X-Received: by 2002:a17:90b:520f:b0:2ee:db8a:29f0 with SMTP id 98e67ed59e1d1-2f548f1b7e6mr16773814a91.27.1736540783484;
        Fri, 10 Jan 2025 12:26:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:22 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/3] virtio_net: Map NAPIs to queues
Date: Fri, 10 Jan 2025 20:26:04 +0000
Message-Id: <20250110202605.429475-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4e88d352d3eb..8f0f26cc5a94 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2804,14 +2804,28 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 }
 
 static void virtnet_napi_enable_lock(struct virtqueue *vq,
-				     struct napi_struct *napi)
+				     struct napi_struct *napi,
+				     bool need_rtnl)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	int q = vq2rxq(vq);
+
 	virtnet_napi_do_enable(vq, napi);
+
+	if (q < vi->curr_queue_pairs) {
+		if (need_rtnl)
+			rtnl_lock();
+
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);
+
+		if (need_rtnl)
+			rtnl_unlock();
+	}
 }
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
-	virtnet_napi_enable_lock(vq, napi);
+	virtnet_napi_enable_lock(vq, napi, false);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
@@ -2848,9 +2862,13 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
+		rtnl_lock();
+		netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+		rtnl_unlock();
 		napi_disable(&rq->napi);
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable_lock(rq->vq, &rq->napi);
+		virtnet_napi_enable_lock(rq->vq, &rq->napi, true);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3048,6 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
+	netif_queue_set_napi(vi->dev, qp_index, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(&vi->rq[qp_index].napi);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
@@ -3317,8 +3336,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
+	int q = vq2rxq(rq->vq);
 
 	if (running) {
+		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->napi);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
@@ -5943,6 +5964,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
+			netif_queue_set_napi(vi->dev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
 			napi_disable(&vi->rq[i].napi);
 			virtnet_napi_tx_disable(&vi->sq[i].napi);
 		}
-- 
2.25.1



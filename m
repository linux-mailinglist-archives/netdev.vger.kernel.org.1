Return-Path: <netdev+bounces-148808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4299E32E8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31325B29736
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F618B475;
	Wed,  4 Dec 2024 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="X3v5EWDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEF17ADE1
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288894; cv=none; b=FsbfH1Lidtlfvda8YKHh9zJqBEHx5GUjKde52rTcIyUt/n6sD43/VcT9cQU4RJnQAXFR08EhnQfgNlAJ31Erpw4b/0xhU3xBqf5Ie0ZGr1JnET6TbmIo3oGPQX8SOqzJzQwm29vNBdjHN0H6OGVs0ceVzRVGB27ZO8H5MZPhnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288894; c=relaxed/simple;
	bh=2ASVmnmBrwinuHv7OjI+NZQNnMWFB6cMYc65eRQREgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2g8PyEkiWSTf3eaZhvR+xUQmy7+L/GnXkQ4WS7lIykduq13EP7HqfQ+5bdt6KS6lHZThyohrYp2QVAZPtRKmaziOZRf8kYbeLmxi7j+PFhEEnJHzoRpi0Mh9czTTC+pRitbukDWZxYVhLnHGuoJ98d+oBcp9dldLtlq4RQjTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=X3v5EWDA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 969203FDB1
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288891;
	bh=jXyAuQfUujhNr4ebdBlKeTENPgCp2kxqJe5b1p/AGHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=X3v5EWDAa0MwCpdWfDi+A14OMjFHEtYsPBMZYwZk6Z7wSHLeMiXIjUqkV3fjJtXlp
	 WAqcouuL4a9ScOFitUbx6dLEVI8dZFv8uqiMCws4WaSqvAP4TQhEP1gvdqMU4AJIUk
	 VOsA3RmQVAXqC56VJEqBFs/+3Ef1h4/Ju/Yb4uUlab/+Rq44tlnWzrRV3XhLRsx4Lp
	 1mhYrXymkWtWATfI7PgxtcqrcwkgWXW0itp0KZ8SxstwlOFsKrjJYQTbKrGOgdznrj
	 sh7PwdbJhvzQK4uBS6VH9u3Eg0rrjlGZJfvv3SNo+w4JPIFur+As7DcQ4rgzOxGP0x
	 ffFmjDDhWktCw==
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so57481375ab.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 21:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288890; x=1733893690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXyAuQfUujhNr4ebdBlKeTENPgCp2kxqJe5b1p/AGHc=;
        b=lnCJ84EEqpw5smj7mrSv/3WOjhQ+JroIiZIrZHySaQysVp+JkVpOMkKJC+6uSe80aq
         g/rfuplXTSHFo2kCdkAK/7bFyOc2tFS/pLYl3hptfjr83EGk1koGwfLh37S+TtDM0ZNN
         pc+VHp4w/rbafl+cYIsuqISMbwjHIeT/zAmbBDVmqxBYF2dUTDV6IPUj0Ak6ZstHYfTV
         bvMne8Jcz+YEOD4+9kN8QFDAHPuFiPHbFPqYrAIpBX71nS2pzIP7Y62Z9cRzGSlWUbFH
         oSSph7vDod2bgIeCb5KuXcFtP7AdmL65Ukgo5qKdxmWZdWqtGuTVL3xM3a4J1Z2PAUFd
         gS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUTrSHH9WB6cEeGIGEDumpFroQa9q6cJ1n5g45+Y24/QBaHG5IdGQwAVsN6uId7gVQ1pV6rW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zLkkpBsgLGOD29ei48HGZHK+wYMR54zvpPXp+fbOKvyB7ijD
	0t7D+A8RxM5QABxFpGDoKVfELO7qhbvOd+ZHVNsuUtZpUNA/p+Pj8czaM5AAyvtdefgLzV+fED0
	ecuiGcK9KvqpFm5nWyXt4tmI2P5MUP7jyT1U/jcg0cpHNyd7AmVMODBSO1PWCFneRqXidOg==
X-Gm-Gg: ASbGncuP2JwjZj1y/iiTDy4bzUkKumlsdZ7QQvLVrEkI23+r70kNU4CHY6y/LVH2W8O
	4neTWw6iOREJQOme9HyfrsjQKEyCGdgJxTBG9cj3OWSe9Lhdxv1YPL2297MdE6aRT7IyfUjaAZF
	4/zEX+FC0uZLukBbQveA59F2H8mc4CdCYKr9ykhGTW0MiORQv4HqCm0nuMswt4EzpAA1o3AUaFo
	q1fUJ2gqs5SzmElJSnst6oWXdHiLs9tRU3FZWhc59vD9T1q5Os5XhH85lKEDPs6/Wxe
X-Received: by 2002:a05:6e02:1a0f:b0:3a7:e147:812f with SMTP id e9e14a558f8ab-3a7f9a4df8fmr55453085ab.12.1733288890459;
        Tue, 03 Dec 2024 21:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSreo3edKtytlX2/z1lj+Ztcj1hPgmrTHi1doqfmXw3O4HnfIfLBPg3ea8ZceTG86gSX4Msg==
X-Received: by 2002:a05:6e02:1a0f:b0:3a7:e147:812f with SMTP id e9e14a558f8ab-3a7f9a4df8fmr55453005ab.12.1733288890200;
        Tue, 03 Dec 2024 21:08:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:09 -0800 (PST)
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
Subject: [PATCH net-next v3 4/7] virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
Date: Wed,  4 Dec 2024 14:07:21 +0900
Message-ID: <20241204050724.307544-5-koichiro.den@canonical.com>
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
index b3cbbd8052e4..2a90655cfa4f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3332,7 +3332,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -3395,7 +3395,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
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



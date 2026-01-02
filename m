Return-Path: <netdev+bounces-246596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAADECEEDB2
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109E6302A3A2
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E726A1B9;
	Fri,  2 Jan 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbAX9zBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DAB261B9C
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367258; cv=none; b=brsKp7pFaQc+YfjhqSJpYV8hLv35VA/sXTCi8+wXp7GCqOVXPTkmYwk71Gqr/xMfrGPnJ0ZIKrn/5DR4gworuy/APHtprOarQ2C4PKmzQTAJMLjIfXMHCf/DNtqsul2Sjk1i0L0E7X9Y2uAR3DHfR/ud6Lfk7lrkDugjkFInw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367258; c=relaxed/simple;
	bh=IhIOm/waVwb/Npd7naFhHnteaL1RMxK1LRiQGSxMRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQQP6kzOvcW9h/Q9D9JMb7OvJNFzY+n7MXCxtp0Hr1wWvxEB29cw+bMPWOB7QJTaq12aWzz50gEX7Nza+KoWONBzVGyD5U/mw6jDiKtUgoaQBMLCKo46obQGrFRDobk5KcoWyOLHgoT4Klp5qBiZiaVAf5XYk+bWSL4Jn6U6Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbAX9zBw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so13777100b3a.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 07:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367255; x=1767972055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p9926v+j8hRdiPJTHDEVVkAKp32Z3dkDYChWeFnkTc=;
        b=bbAX9zBw2ONdq3W1f+IIpkty+jiVkPi6HUJOuSvWcyDpDG6ag+uahKLobxHVzQETcu
         c3D/HZf/9pKSpiYlfqOYCuOQWg/MVEZilwJg6td/XSvDjCzPNIBpVLXT8UM4GVutawqq
         Hl+qgzpGxyGishWTGs1Vq1v0lAiTr0XsnlJXcfad89HcVL/Qk8tQosmu69rSLtu4PxIf
         bUKhFgfs5Q6Oi7hSG8qZHG5DRuSvl2cj0KVL7VhXQiZ7ul5Mo1RxASdCHQrUShWcP/es
         opsx+O7bWys9VhuGTf+7Vg0FPrfCRY9PFWDKOgHAiF0pAlJzEt7gDCJu3tAS4pQMwGgx
         SObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367255; x=1767972055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6p9926v+j8hRdiPJTHDEVVkAKp32Z3dkDYChWeFnkTc=;
        b=GbjmcJbpNXfRzIOMZgB7uVHf1dk/mDTaVDMjDcrqjiHv6CbvDd3w1ALMC2otr9jM01
         cThcFEH2JkoNi3cKoS/niEUXA3dgXnT4R0icGpyIVfAjEo+sDAi+/ldCLqsHWwWuliFv
         OBifknlyLYcrSWI27g0pRkwrPA3ccd8nwuE3zjFJOWG/cQImyTeXzoeXQyTc3m5ZE4G2
         Qpi9akhJuWcZVqSyhDdQStbgb/WjZTrIJyiZYjSmI/SW/5q5Dxrlag8ft9KcEDy8n/x+
         xxOTN1mYHksYH+AeZ2zpvlCNUnsz23puSE05u6KBRANjpLzU/rzAFGl69MSmDOd0v/0r
         p6Kw==
X-Gm-Message-State: AOJu0Yyf5kStn6bk2GPiC+JTtJdMUshSlWpCtZxXtqk99h35QfeNgqW4
	PxyV2MoBq4porLQuztbNXLEkMpanjbX/7P+BW89hV7w74YALRrpupOAPdnHndkRP
X-Gm-Gg: AY/fxX4EhHo8pRyo9TQSrHo307JD5RDcAzPbsVfTxDqBlaZJtlv2du4zTaoHElbpczN
	kSK1e4GSUV8nNGB78ilLbA1BhgXS9t82cTI0Brm3M7G3hRFEc/Pei+sdRNWFlmrCtiDY6y3qKuh
	o/J56iV7L8wDL+KJy9dW0r4RF7qEp1FXJ1P2nMQs2Wawl6OyKjixu6gouVjPrdFueNrVjFoQOuv
	Ew5EwsC4su3mghFjcm1ImEQHkWoa2As6VnvF0Pvbgx3GG1uh3VPScGsUcAGzHlkpcT+CySaM2s6
	QsnW4ApMv9WiPA7H4X2SCbtjOh1HQhmgYhuRmi/MDk7EcSSR1e+r4ij0pg3FeYmcJZo4GV/jgXU
	Qf4RautQ6XOj3UYPOTqJKu40mVNPbF0lOeSdfH4aw6P/+gV7NuWc5Z9zdTxuwcmN59YHiEhMtbD
	J4FDx9s0CENZzMVIywPHZSo/g=
X-Google-Smtp-Source: AGHT+IG6Z89asELtZL25bqp1wItzqCcfh/QFAyUyxW2i4m6A92FWF0k6z8ouT/hhDGRbNkmbOPf90w==
X-Received: by 2002:a05:6a20:431a:b0:35d:5d40:6d86 with SMTP id adf61e73a8af0-376a9de51cbmr41286930637.40.1767367254850;
        Fri, 02 Jan 2026 07:20:54 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:53 -0800 (PST)
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
Subject: [PATCH net v2 2/3] virtio-net: remove unused delayed refill worker
Date: Fri,  2 Jan 2026 22:20:22 +0700
Message-ID: <20260102152023.10773-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we change to retry refilling receive buffer in NAPI poll instead
of delayed worker, remove all unused delayed refill worker code.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 86 ----------------------------------------
 1 file changed, 86 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac514c9383ae..7e77a05b5662 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -441,9 +441,6 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
 	/* UDP tunnel support */
 	bool tx_tnl;
 
@@ -451,12 +448,6 @@ struct virtnet_info {
 
 	bool rx_tnl_csum;
 
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -720,20 +711,6 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = true;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
-static void disable_delayed_refill(struct virtnet_info *vi)
-{
-	spin_lock_bh(&vi->refill_lock);
-	vi->refill_enabled = false;
-	spin_unlock_bh(&vi->refill_lock);
-}
-
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2948,42 +2925,6 @@ static void virtnet_napi_disable(struct receive_queue *rq)
 	napi_disable(napi);
 }
 
-static void refill_work(struct work_struct *work)
-{
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, refill.work);
-	bool still_empty;
-	int i;
-
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
-
-		/*
-		 * When queue API support is added in the future and the call
-		 * below becomes napi_disable_locked, this driver will need to
-		 * be refactored.
-		 *
-		 * One possible solution would be to:
-		 *   - cancel refill_work with cancel_delayed_work (note:
-		 *     non-sync)
-		 *   - cancel refill_work with cancel_delayed_work_sync in
-		 *     virtnet_remove after the netdev is unregistered
-		 *   - wrap all of the work in a lock (perhaps the netdev
-		 *     instance lock)
-		 *   - check netif_running() and return early to avoid a race
-		 */
-		napi_disable(&rq->napi);
-		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_do_enable(rq->vq, &rq->napi);
-
-		/* In theory, this can happen: if we don't get any buffers in
-		 * we will *never* try to fill again.
-		 */
-		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
-	}
-}
-
 static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
 				    struct receive_queue *rq,
 				    int budget,
@@ -3222,8 +3163,6 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
-	enable_delayed_refill(vi);
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* If this fails, we will retry later in
@@ -3249,9 +3188,6 @@ static int virtnet_open(struct net_device *dev)
 	return 0;
 
 err_enable_qp:
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
-
 	for (i--; i >= 0; i--) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3445,24 +3381,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 {
 	int i;
 
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		__virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
 static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	/*
-	 * Make sure refill_work does not run concurrently to
-	 * avoid napi_disable race which leads to deadlock.
-	 */
-	disable_delayed_refill(vi);
-	cancel_delayed_work_sync(&vi->refill);
 	__virtnet_rx_pause(vi, rq);
 }
 
@@ -3486,7 +3410,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
 	int i;
 
-	enable_delayed_refill(vi);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			__virtnet_rx_resume(vi, &vi->rq[i], true);
@@ -3497,7 +3420,6 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
 	__virtnet_rx_resume(vi, rq, true);
 }
 
@@ -3848,10 +3770,6 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
-	/* Make sure NAPI doesn't schedule refill work */
-	disable_delayed_refill(vi);
-	/* Make sure refill_work doesn't re-enable napi! */
-	cancel_delayed_work_sync(&vi->refill);
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -5807,7 +5725,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	enable_delayed_refill(vi);
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
@@ -6564,7 +6481,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	if (!vi->rq)
 		goto err_rq;
 
-	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
@@ -6906,7 +6822,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
-	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
@@ -7170,7 +7085,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	net_failover_destroy(vi->failover);
 free_vqs:
 	virtio_reset_device(vdev);
-	cancel_delayed_work_sync(&vi->refill);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
-- 
2.43.0



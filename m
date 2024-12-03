Return-Path: <netdev+bounces-148388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1C9E1440
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0953A164A15
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4031D7989;
	Tue,  3 Dec 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LKpRDxmZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D001D5AC0
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211071; cv=none; b=F/Wrpe3/n5OT8bcAUmEY6YcGeM9auNVQdntyEUed3z7maqL1xBMmUkARAUyCTRW8K1VvNCflgKLTVW16S9ZzyeQSTiR4vDj12Y0HdEpY8zTv4LAcmBX4/Mf2VIdyzezHBFVIy9YfGTRwri3LvAXRpE07I4K1F+/H0ed0oDEpXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211071; c=relaxed/simple;
	bh=B35FJqtVrA6/g3cRJDtf6i8TWPwah/QahNofj7yw7FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIj1V2JZSuRwkfB8HjtOnY+I1VkH5FWcs9yL2fOdLPZoYRW4gV88kTWz848FvMZ/oB+mq149/toT2RfpC8PRIQTwSwggF5vR3OwZyDj3E9PFUACMLd3ZjVhy/akMUoGKVLtwOIkDdzSeol8dLZArtMRJffk3GroJZ0reH50M0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LKpRDxmZ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 78B543FD49
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211068;
	bh=0tIoR4M/e1hC8XWEPJavp463x0u2oxmCDdWZ8pN4UWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=LKpRDxmZRdRR+v13SSCn6JGZ2d/jh0meD7tb5qxZtwWBP8TX39Hi2RMvdSPIerkDq
	 eU9epCYO46m5JaKvRktGXooROdY+o2ukLXNSQYO/F8294xVruHxUotb8PpUjseYv+/
	 azkjBbBKVv1emvQRnH+xYOQzvZx/Qey0auKjDplpXwjjJ6d9ac6UkeHCAbrulYW+6Q
	 lluCdy/HCT8YfXWwV4rN2u1rwRPxK1jIOjnrUoom8hbYDRXVVClswsiI7yI6D4l3gA
	 NkiUnEys5eh2T1cloHRdz1cPuqboVTZMP5tpIkA31MVSFNKkHBuNFFTTYdl0bLrdbN
	 NhI6jbJJ+UNQw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2157b83f656so29821595ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 23:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211067; x=1733815867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tIoR4M/e1hC8XWEPJavp463x0u2oxmCDdWZ8pN4UWM=;
        b=I+wWH9RUG6YkBSyevvKQutVuqKXqKxPhipdsk4HdR28erJe97Os1gCU+Pb+UVsBMfN
         iSKmDOOCllnlatrFXJeCY7OJAPuVPSTgYJTgGCKYTz0FYveDO6/Ld4zrAMaFEeF5oUmq
         d2KzLio71m0m1d0m4U4B/15vh/R54QIH6fjwuQ0TCYmB/hoWZRo1RuR3JoJOlVDIkxxH
         gse/bxsWGjA0U1iBYXuRMpYdFKSq1xCWynQ67tI192I6D0o45ZJD/vekhnFlip2NSxmL
         6dQ0hMvRLrys132ouM3Sf3DnDucEVIgKcySkQssFnrFc9F3t/0iQWHiPDcHSQDdry9Mv
         F97Q==
X-Forwarded-Encrypted: i=1; AJvYcCVztm1SmSEUsKi8pzUqmPFRvcOJ6igyRx9xNJTrRCsfgWqKCDqrpGMwHDcrCWvGbOXgD1PkIrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysafCAq4i5bVdxEHKkv+t04RRFNDqF055+5QF84BhYGiN82nKz
	PEgQsEdQPrvvbt2mjcedztVGprTHngmLVV5YP1Qz3lefQ0CyLafr2ooys3LctrNSmUzo7dY9gMr
	9PDfMBb+rXDS2s3JMs493+DfX1IJEVrj3PiXbNxciG5lN18719FjNpbzhbYEe5LZuyo331g==
X-Gm-Gg: ASbGnctyWVjgHcHs6J3My+WzUyuGZlYcuq+pEdA08Gk5KCTkPgD40FzuBNUOkxLV/Wx
	dil3BtZ1e4cSjHfp332fRDTonaRjAqqy62c2s/cUMJJK6ZapjHX2FyWOVHYvaDCZO3Fr3lqOBvl
	lI4gZZ98u1wJh/MIZzvn0cG83MieZ9lOJyDIRjSfbaM9jcccw/NT82iEQXSiYn9IUGSfOKvXRsL
	81GpTbNvikaGR1tKgzSWe27gjCLzpjua/Q9mCITuj7hhvoF1DkrO/86Uqrs2Ycirlq8
X-Received: by 2002:a17:902:c945:b0:215:a57e:88e7 with SMTP id d9443c01a7336-215bd1b46b0mr13127565ad.3.1733211067089;
        Mon, 02 Dec 2024 23:31:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP4XjzXdT7YSH9p2iSEiXeF4vQERCA9UmM9iKOMdbRsv+ACtukLlabl71vKcQSJKNxhflm3g==
X-Received: by 2002:a17:902:c945:b0:215:a57e:88e7 with SMTP id d9443c01a7336-215bd1b46b0mr13127345ad.3.1733211066776;
        Mon, 02 Dec 2024 23:31:06 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:06 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an argument to virtqueue_reset()
Date: Tue,  3 Dec 2024 16:30:24 +0900
Message-ID: <20241203073025.67065-5-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_reset() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new argument 'flushed' to
explicitly indicate whether it has really occurred.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 6 ++++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0103d7990e44..d5240a03b7d6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 				    struct xsk_buff_pool *pool)
 {
 	int err, qindex;
+	bool flushed;
 
 	qindex = rq - vi->rq;
 
@@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flushed);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 				    struct xsk_buff_pool *pool)
 {
 	int err, qindex;
+	bool flushed;
 
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flushed);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 34a068d401ec..b522ef798946 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @flushed: whether or not unused buffers are all flushed
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    bool *flushed)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
 
+	*flushed = false;
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	*flushed = true;
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 878feda08af9..e5072d64a364 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,7 +112,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     bool *flushed);
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    bool *flushed);
 
 struct virtio_admin_cmd {
 	__le16 opcode;
-- 
2.43.0



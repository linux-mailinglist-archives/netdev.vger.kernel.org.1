Return-Path: <netdev+bounces-261884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3fJ860oWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:14:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF911B983C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DCDC30197D5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF16F436345;
	Fri, 27 Feb 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIguU5IR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8342B740
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205223; cv=none; b=XxbO9Zhi7qWtUJynnnJ7C7V0MVsxNY1wTlFSAGK+8rrUg8DQv38T0+bZ8JKNfQhWdoWPj88Tl/3o9DXeFUXF/Gs+6gudfQEuRXS1vJC0sUbsFUUtx2yxqJJW9OctPLkJddthuaoR0IEf8SkPS/3LFHRvPDD+FdAho86P/foAl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205223; c=relaxed/simple;
	bh=+pvLKOyDJeDYk8Ks51ufw2eQlUL8GJXsRvfZQAUcAhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0HRrp1Mj7b968Cnr4Gt9xRJ89iRjagDqXscZ0FUUZF+ZNvH2CLFD7q0tqKV/3wOSAhGPVRgvY5vTeE6AeJpSMAEz0buumlWIvKCPXY+z7Y0ORdnf/aLkI8dwRkQ+IJ8GO6aT30BEc+lyiqevXYPjGV5JKe6l+hFwLflEnqYYck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIguU5IR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so2261269b3a.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772205222; x=1772810022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wORT1SbE27ZIkrMMuUayvBmlw/YCk/ngCJoGzWhKHPo=;
        b=RIguU5IR+bGndBqcisKWURw9OmRwg+rrvnVpUdIPc/31oODUEu6n5inJjMX/Q9NHsy
         Ke4Dqbyoze3l61RT/LjM1b7yYch4EsarSJCdyoThf36XMmhNDbN3LAZ1D31Hdw8ySP0z
         avZe6PHS5QkgfQdPohRTWp10EeH1bAtUlPh8nLgRVSup1zdbFPUb+kE0K0GbMzyM3Ktv
         6wFmb9zIz2er9e7/gp1jmosIQgoJI76EHL2L3n203huLLKm7XVVIxJ5awuTxk36lg3cF
         TMs8jvRTpPUV7YzEWhrtD8Siry59l2ryckNwYEunPUb50j6/FO3vF/Ijv81OfkIfwvsE
         gCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772205222; x=1772810022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wORT1SbE27ZIkrMMuUayvBmlw/YCk/ngCJoGzWhKHPo=;
        b=OFxdguVLIuIAsLWr4gcK1iVs92CbT8faQ5ynBklYJtTm5L7CGeLviO+6if8PllhYdv
         XS3t1EcnoKJI4jZvQO4MKVRVsAFvkbX90IarIt6ylYVgUYObS4gHsADLuDou4bmN3wXR
         a5aVCAb8w2W/tdl3W584Wf7C3gscNhzogVatOvJ7GQhLbTTZQhjRWE+KB3wOIdQS29fa
         0QDW1YvlIl7GhYvHqoExj/SAeQQtnAngKFBUfGvS1ivl1KmjBqqEWdB0MZqhWpxcwRt/
         w8+KYa7TPQtnEJezmNMLie1PdQ4k461tlufJc4C6rIkh55Kat8PWoqsOPQE1MGNf9MIq
         9BqQ==
X-Gm-Message-State: AOJu0YyuXB/88lAmv46pMkVlyeH5TyD9TT7tm1tAPkQvgbl/WbK4LKB8
	sZ7SUzz2I6FnCadB7qjkN2cOZRYZGa02jtZ0E3izfkYPC1e/DTGfpRPj0tpaTw==
X-Gm-Gg: ATEYQzwDyaFCkjJGDE5Jaba5i/vkQtcssOJXATtKnLrbSETjvT5gmeI8jAUagAaGDRE
	0KN+sk1JImgbEOrdtBJukB0knyQL1EmwAZhY/8fK+NPn1TESwyXj4ymIJQ7blSI0y3fLIQlUiRN
	J7+947cu3my64f/fB5LfnzdaxFPyamVcbEKX1AIVZ4qr74u5rCkB8iOjG+T3GLwXKg9wCqJkWGM
	/kqDhU2ZhBMQGNj01HLPlw2OGJAor+/tCGySsPGTPCIdptqrgrUX4mDBdJEKfgbf76gpDN57nY0
	sX4iD02zjVv019rl7bwDB7anGRnQ8Kc97aEmPDkjVG1s9EXCS9gRzaijY5GRdqp+MplHpSMhqrA
	CKPq7KE46uTG++XMg6dDm++jv8GTZ6IhvjDI7LNidVB1xlEuehzdhTJ6c2TJZnPNaOWWjOsqUqj
	O9wu9zI7vbVsltZY0EtDwFZXYBw+doiDh+s1SRKquGRfbxHLU0EQ==
X-Received: by 2002:a05:6a20:d809:b0:38e:9acd:97d0 with SMTP id adf61e73a8af0-395c3ae8562mr3787342637.34.1772205221514;
        Fri, 27 Feb 2026 07:13:41 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f0f:b1d0:1fac:b09d:ba7c:fa17])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c70fa638dbcsm5034868a12.14.2026.02.27.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:13:41 -0800 (PST)
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
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
Date: Fri, 27 Feb 2026 22:09:49 +0700
Message-ID: <20260227150949.13089-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-261884-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADF911B983C
X-Rspamd-Action: no action

When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
is allocated on RX side, allow RX NAPI to be descheduled. This avoids
wasting CPU cycles on polling. Users will be notified and they need to
make a wakeup call after refilling the ring.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..494acc904b2c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 	xsk_buffs = rq->xsk_buffs;
 
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
-	if (!num)
+	if (!num) {
+		if (xsk_uses_need_wakeup(pool)) {
+			xsk_set_rx_need_wakeup(pool);
+			/* Return 0 instead of -ENOMEM so that NAPI is
+			 * descheduled.
+			 */
+			return 0;
+		}
+
 		return -ENOMEM;
+	} else {
+		xsk_clear_rx_need_wakeup(pool);
+	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
 
@@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent;
 }
 
-static void xsk_wakeup(struct send_queue *sq)
+static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
 {
-	if (napi_if_scheduled_mark_missed(&sq->napi))
+	if (napi_if_scheduled_mark_missed(napi))
 		return;
 
 	local_bh_disable();
-	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	virtqueue_napi_schedule(napi, vq);
 	local_bh_enable();
 }
 
 static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct send_queue *sq;
+	struct napi_struct *napi;
+	struct virtqueue *vq;
 
 	if (!netif_running(dev))
 		return -ENETDOWN;
@@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
-	sq = &vi->sq[qid];
+	if (flag == XDP_WAKEUP_TX) {
+		struct send_queue *sq = &vi->sq[qid];
+
+		napi = &sq->napi;
+		vq = sq->vq;
+	} else {
+		struct receive_queue *rq = &vi->rq[qid];
+
+		napi = &rq->napi;
+		vq = rq->vq;
+	}
 
-	xsk_wakeup(sq);
+	xsk_wakeup(napi, vq);
 	return 0;
 }
 
@@ -1623,7 +1645,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
 	 */
-	xsk_wakeup(sq);
+	xsk_wakeup(&sq->napi, sq->vq);
 }
 
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
-- 
2.43.0



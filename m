Return-Path: <netdev+bounces-297524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X4Z+LaweKWr8QwMAu9opvQ
	(envelope-from <netdev+bounces-297524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:22:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F971667197
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:22:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r90bTy1d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297524-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297524-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30F8A3050DC8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9F3A4F58;
	Wed, 10 Jun 2026 08:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92615746F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:17:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079429; cv=none; b=gK0O1QpAq9so6d+DCJC3JIfZrEWnxWrH/1R0jd1xCYwi9+ym3w3+MnKZkv2NKXDwgZxiBn1jMXFq8jrJuQlMLmy2476s3l5/+jTuPuY94mrFsTt7a9bgRmzrqnbMfS1t5Q6fp8v+GOWP6Z7q2xjac1xXe1VDKzx9HxhXKFQG9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079429; c=relaxed/simple;
	bh=eD6bS/8t0ZEWwpl1zMDjka9rvyv+ATYSkVg6tY4k5Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZSBTyL66NgVdtpi8mXkSsDHkGes5IiI1hnvL7ouV6WinLc/kuCNsBLgWAXjfhEbJ3c1c4vUWzOP4+oqmnTZurMCXgUQ8luwxwXIW9CZV8yj8LQszn6ToOvyZ3KLM16+XhDLkAYYaO0Mbr92/qz2ZuNZBIBipkWvOTJF7vGAXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r90bTy1d; arc=none smtp.client-ip=209.85.210.193
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-84229481d44so2638444b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079424; x=1781684224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1GzByE5mWAgP6oTg0byjBWbc8PVfX/Ft6v3MKkID9I=;
        b=r90bTy1dvAjNQG2EYneB9OaqPquDC95kbooMp932aAmrU94jrsAECdwIuQ89ZnFA5x
         ZbjDbjYNhf1YWpzlwrtZb7RO6gzcNLB3Bugl/4jtSYbGYqHEKjYfmRQrE91eGCocFfMK
         XCr6anP/MhSRNL9N728zpLdZOx7/3AiBwgnDj513MXmeOnrJb89IW84JFcwoh5r9+245
         xy0sqkx+TzqweS2HI6YLa/qc0JCbgpieHcPA3cuaxqaoBdmNHTpTjnBD2zSYoV6Kj03F
         fhT1jfQykA6gieDSV3zJ2JabG9pPf2Slr+8fIEZIFbzjmhVuHnpIsEAFmAhszFj4HSk8
         vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079424; x=1781684224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1GzByE5mWAgP6oTg0byjBWbc8PVfX/Ft6v3MKkID9I=;
        b=k2zMb/N2MOvLNxj00xY/TTe4nu7draKUDRqY2PuqkzMGJFnnY5Ey+ZJgmdfL8jocsj
         SRNooeJxAOhuUgRj/uP9BDfx50xnJZR22M45WP2dnePwiWzFS+eg6jpsIPJq5ry4xmM1
         0koOMvL2Bt9hiey8XoynuViqc3fONj6lvpwphwn1Hu2B35gzYjtbjATTWcQQnYZyMwqc
         KLIGm58ZRZd71GI0MRk6DHsnVc88UYifeqMnWrc5ux2a8FMcz9n9N+td8MKKZvQG9Wdc
         nxkopl70apM2cElb2clcsTEpZ3N7+g9W1TXQQ2viLKAlyqNXYYRfCudNwu7+S5s7wNQM
         nukw==
X-Forwarded-Encrypted: i=1; AFNElJ9dtRRCQF0x4GEE66+Vw4LwUCBaQmASOeCVnLgnrZXg4AIWoTCcmQNRQ4KYUQvmgdJMZfPAh3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzYvVoqDeKW8nYafhc62qr/1GiVgz9j5mEN/llcqdEifn4+hR/
	BaxBdFFBRdfHEcvt1ZRHlRCZliE2ZcwDvOCxh+DojvviL47Y4M0y1LBB
X-Gm-Gg: Acq92OGxat4ZB+n9i2kx1bPuyEjpDePVo+C7Gw7tyrUKO0xko94mHB+S19bD3ceplJ/
	Kpze/7VJSBqmfoI/s8mdfevnk1I66lH36zFVYALbcGADnNTuMNzi3KivA5cV/BVXk6DR9nbrUpP
	UJxYiyi15zAS4NSnS4Ml9OIZ4HQtWbs3hxldZklrYRGuRP3dE3stN/Cz7YpXytbHkYWnlejEbC2
	D/NRpzEUtZsu0YB/D0gi7HrsxQHv9SrLS4S97dTogqfkhdUrlgEDbRgVJlchcmVgSzoiziCGseT
	UPmeeUUY1oxA40uFcsjse6Z43u7oXm6J35lL5TXxTqpuMs0RU3Ap0k3AQZcufxgtzNP0QgxdySk
	uJGWkcHnh2yrO9zhVDMByk860HyilFkz6r/jU4d8dbPZrAyUMf08OykfKnmYsr/hid0g1GjYR4v
	c4rfgoUlK1RLsWrizP2LCKyS0WxOSqJGclcT3fdLpLcl0oikQxj+g=
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr24663991b3a.46.1781079423860;
        Wed, 10 Jun 2026 01:17:03 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e02f9sm23759546b3a.48.2026.06.10.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:17:03 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: xuanzhuo@linux.alibaba.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] virtio-net: support xsk wake up
Date: Wed, 10 Jun 2026 16:16:48 +0800
Message-ID: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297524-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F971667197

For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net.
Take the tx path for example, we set xsk_set_tx_need_wakeup() in
virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
anywhere, which means the user will call send() for every packet.

For the tx path, we will call xsk_set_tx_need_wakeup() after
virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by the
skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.

For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
buffers in rq->vq.

Race condition is considered for both rx and tx path.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b3da9f9786c..25e895b849a6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 				   struct xsk_buff_pool *pool, gfp_t gfp)
 {
 	struct xdp_buff **xsk_buffs;
+	bool need_wakeup;
 	dma_addr_t addr;
 	int err = 0;
 	u32 len, i;
 	int num;
 
+	need_wakeup = xsk_uses_need_wakeup(pool);
 	xsk_buffs = rq->xsk_buffs;
 
+	/* If both rq->vq and fill ring are empty, and then the user submit
+	 * all the chunks to the fill ring and check the wake up flag
+	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
+	 * we will lose the chance to wake up the rx napi, so we have to
+	 * set the need_wakeup flag here.
+	 */
+	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
+		xsk_set_rx_need_wakeup(pool);
+
 	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
 	if (!num) {
-		if (xsk_uses_need_wakeup(pool)) {
+		if (need_wakeup) {
 			xsk_set_rx_need_wakeup(pool);
 			/* Return 0 instead of -ENOMEM so that NAPI is
 			 * descheduled.
@@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 		}
 
 		return -ENOMEM;
-	} else {
-		xsk_clear_rx_need_wakeup(pool);
 	}
 
 	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
@@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
 			goto err;
 	}
 
+	if (need_wakeup) {
+		if (rq->vq->num_free)
+			/* We have free buffers, so we'd better wake up the
+			 * rx napi as soon as possible.
+			 */
+			xsk_set_rx_need_wakeup(pool);
+		else
+			xsk_clear_rx_need_wakeup(pool);
+	}
+
 	return num;
 
 err:
@@ -1440,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1451,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (stats.xsk)
 		xsk_tx_completed(sq->xsk_pool, stats.xsk);
 
+	vring_size = virtqueue_get_vring_size(sq->vq);
+	need_wakeup = xsk_uses_need_wakeup(pool);
+	/* If the sq->vq is empty, and the tx ring is empty, and the user
+	 * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
+	 * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
+	 * up the tx napi, so we have to set the need_wakeup flag here.
+	 */
+	if (need_wakeup && vring_size == sq->vq->num_free)
+		xsk_set_tx_need_wakeup(pool);
+
 	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
 
+	if (need_wakeup) {
+		if (vring_size == sq->vq->num_free)
+			/* we can't wake up by ourself, and it should be done
+			 * by the user.
+			 */
+			xsk_set_tx_need_wakeup(pool);
+		else
+			/* we can wake up from skb_xmit_done() */
+			xsk_clear_tx_need_wakeup(pool);
+	}
+
 	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, vi->dev, sq);
 
@@ -1470,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0



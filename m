Return-Path: <netdev+bounces-297906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9CCcMz0kKmrXjAMAu9opvQ
	(envelope-from <netdev+bounces-297906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:58:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EBD66DE74
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:58:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sk8cY3QC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297906-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297906-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAFD3302730B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19824314A60;
	Thu, 11 Jun 2026 02:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F68313293
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:57:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146633; cv=none; b=FtFlXRxKGaElyHC+1S2Z5KX5s6v0ho9V313nFZ9+d++yNdEZc8Ob+9Zphu8PqjfIuGd1gitC9Ql9eL7ZK3Az+jPuhoI7HBl+DGW8XJ+WuJ6BuHBkWPhhPWebKPuOamxnoGnddppZynPXmMVSVzOLJE+IbQPXLkBWvzjYVEGDm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146633; c=relaxed/simple;
	bh=RoRVrNiX+bgef/3jboe+9nL/6JI24Go7+Wl95RFBf3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVEs261z20HudnJM6Qv1mWaNlRPYOpeXb7a/P1NceiQy7qTq8wKcWDWwJ9jVgppk66gVrA5Gxf7J1mdjyolYRuNtuukWiclYXbuHPyiLzfksPqM10aafFIjDrjvUf6p/1S6aS/0fOSZgmNNafzpiXnwmavTPpoIFJRAxV3Zktvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk8cY3QC; arc=none smtp.client-ip=209.85.215.194
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c85d8615b09so4355451a12.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146631; x=1781751431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGuObVQF66WCHyv524cNB4gmmTWm0m/X8koQNLAf5D4=;
        b=Sk8cY3QCap4DO1jan6XEjLvGjgYK16jgyPkylkxLaHTjUtfsUfRzUGfxonA14zTUFF
         eAgNilZDSfvKiNLB5Pw2pHlPQBj5IHUjQb5RoQRAT9dTHRVVOFOb6dvXExmgEvKgpPR7
         +YRn5FpjAFpLcrM8p7bogCBxuzLxES8gaMBq7We38SwvDMJsyrdjA/EeZijFM9rBB3Rb
         QcDQhQ0CbE59AXO8/yilNxlAC0KJNr3bHpvNORYJeg7SH75DmnXqR4vBVl6Z3TRbZ/fS
         rTOBpqnYXwbFyMkPu9PdUVSbVivFBRAXnN5CHfgR1F5R1DSYiSzuQ7wuZjCbLsgnlQ8p
         pElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146631; x=1781751431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wGuObVQF66WCHyv524cNB4gmmTWm0m/X8koQNLAf5D4=;
        b=bdRmbIAWZzWAxEzgN32rIKheuBbKIM0iO/Paadfj5TMla4KpKSQpTIkUNDz/liZYlk
         zP+iusahovD1yRp9Vsqfui1qyXSmrgbcG6g2TFI627ZBei6sQrqZNsviYsyFkItN8EEC
         VTjxjp1YTUsDF+mTxYhPc2qovdNv7kQHz4q+1ipP15ZliDD1M9PUbrpdgiIFDlFUP9zc
         wtkqWF7u0mhC0QpNAq3DaWx7FTg5JLC6yYPbRkmHfn0v/y3qe7+FAIz+r6Lg1reQvUN5
         5q9Wrq/A2hribA2O8jbQbN5TcghBKAeXgADq+R6lqu6tA5w/BC0vDUMIDF/spU3F70jK
         b8oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZzvvGU4mkXTmK0Z+PQRaQFsgZPAu0Ic3klNM08ZgHHY7nLhRPDdXhpDa9aN4CyasUQCC8fek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSGDKogj6o8vAQmcrzbjQNsZ28xH5OSAYO0M5YQdi+szAj3vM
	oArGDBldV9/1QMeWmt4ckUUzt8scYbz0qw2EKaRMJBFHs+B/lb4a+C9O
X-Gm-Gg: Acq92OGaWNVFYEsF+pVHxPgcifx79exWCnEhrDEQCK+TMutXJNgmkGVCtuApyavaLpW
	rbPttYJy501aSXKxl3HhwXV4apIJt3hVR9EFioWJJzR59+f0WOgKd7ih+m5PjCUltQnqFgsKXUW
	YTiYmF2ot4TIIsivYZ5ucGf0Kbz5eQ+ESCjN0x/fVphJP1OWXjtskU7J5fMviB1bAbmCvXFSFWc
	t03U+SSl0e4S2R4HW3qmhLuwkxlOzQuSyXQ6ZG0CbyxsUnChYzthTsYgWZQzs6mpkak5OUYibyd
	KEBJku1WcD+kQ2X/P0sAu76+gaPq8qemlYwzjVoe+bRJ2EyKn/h24w1FsNiOB9/yLfwTmp/mUac
	wBuopq5sKkeSGvygLX7rlM3f37iM1ng59uW5YaND7Z8B2rqaQgzlxBQP+v1d488+OCqGIZlcBe5
	uhN1N7Onb02+4Ir7Q0f6jupdwpQga4bj+JbsKNYsEOXx372YOu57OiFuI7MlVlRQ==
X-Received: by 2002:a05:6a00:ccb:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-843367ea47cmr848637b3a.4.1781146631159;
        Wed, 10 Jun 2026 19:57:11 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:10 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	minhquangbui99@gmail.com,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] virtio-net: xsk: support tx wake up
Date: Thu, 11 Jun 2026 10:56:44 +0800
Message-ID: <20260611025644.2431148-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297906-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:minhquangbui99@gmail.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52EBD66DE74

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
in the tx path for example: we set xsk_set_tx_need_wakeup() in
virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
anywhere, which means the user will call send() for every packet.

We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
is empty, as we can't be wakeup by the skb_xmit_done() in this case.
Otherwise, we will clear the wakeup flag.

Race condition is considered for tx path.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4b5b3fa62008..86b5c1ca568c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1459,8 +1459,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1470,8 +1471,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
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
 
@@ -1489,9 +1511,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0



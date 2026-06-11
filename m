Return-Path: <netdev+bounces-297905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6s83KA0kKmrNjAMAu9opvQ
	(envelope-from <netdev+bounces-297905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:57:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7866DE69
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:57:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sV7yTngA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81A95301417D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DAD311C2A;
	Thu, 11 Jun 2026 02:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7425F7B9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:57:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146627; cv=none; b=U+aSjpDx0atFH1/Sx1Wa0ISKoNiJLFQOlju8VOuaskHTQ1gUPubiP2jnqn9Q5F2gJQTFszP+gX/UWAtnMQbQj46C3/S3Hl45ESGyaDtUkLcH4l5EK7J9wqDlEugWxRNugzjqxLH/B/sft/BQaIaOFGSAZVfcGXZMDKOxUwRLn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146627; c=relaxed/simple;
	bh=b/o18kh6Flqc7FfSc4cmM0rvw3m5Gzf1uhnBV5Z4EKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn+9/Utqk/S4RZ3kj5m/+2qc3ZGrqSfrF4uZcX5R/obHKu9xvKwaK8EvZaI0CzXgR47/mL9jHrGHzyo1BEHATdPZvsM7xxE7bswdKKKHFGsM59SP9Eprx6WsYfslNpHGpKPFHrEdMvlymY2EqgMWT+CtmleZKgSRDX/yw4d+3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sV7yTngA; arc=none smtp.client-ip=209.85.210.196
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8423f52af13so5189914b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781146626; x=1781751426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9re1bjpsG4J1aHkLAKyTTv5gQJj14gA4eTFrX1qtWI=;
        b=sV7yTngA3/2qQTT+xva54xnb5tD1bJKva5R70YUNxYDKjKbFSiFnXqMc4IdwKcsjTZ
         Rsgv0Sqo2Wq3qTo0gCWVzmYwEuHop5/Yn+tW2mMb42s5EhX9Y0uycnMR4IqZmQTO0odM
         oAGo3Rz4Apd+GzFtyaXW1WIVBx3gBaLRM36RH7GPjgjtE87tW0tZnRyg7si4dyzS/j16
         aKvHvVj1wTLRV+c+SUwAda46Ipaigw7/YoBOdZeVEEureoIWIV7lgLobtCsrswtFzQ/Q
         8sPwPofOs1tR/lN2xa9BOHbZnp6GNAu/DY0IYmd02BdbR2fREX4Anu0h3x+82XJCvvLk
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146626; x=1781751426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9re1bjpsG4J1aHkLAKyTTv5gQJj14gA4eTFrX1qtWI=;
        b=fZEX6c38GCUJEv6lT22KFt5tuX0Io2Jm51dyq8KwPiSUQLkF/K5N8kVgC/O3T80Dk9
         eFEtnzJukDnYgUOU/7qxAnKNiWNnBGnVo9QSsxmyNBVBULKbI5Sl7D3vCWshD9CACtES
         8oBVyRT1nSx/rTKw2HncUYn29Poa/ifHTLj/qr5/t6UQGcqpZSA7olrwYx/6LZT9km8S
         FqlHAYUS6Tw0zXd1By2907kAVYpuO6LoNrPpsgliJPbTPDEaQbQW7psGx6X+bj7EWI09
         00RRsMOZGcE89Wn2EObySUZTco0CCoKw0jtdZh2ebtnGoxjGx9sa/TRoJjU4ZyYAsDSf
         Rj9w==
X-Forwarded-Encrypted: i=1; AFNElJ+dvoBhn1sf/0Kmur0Ze1BNcaHyw2xDiFwJFzkzh0iqdjEi44L+IxFORM6hlvYqSi//LIMjgyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxgnmI/tFPRM4nI6dlUEULlktdIsMA4q3UvTEn5Q1PRBqat/z
	4qZfnz3vh/63ZGGZU9ul/3i1s95NNbHYDDZfjjITYZEpxMPCGqgMpwnG
X-Gm-Gg: Acq92OG8KPriHj1E0a6NA0V7iN9NbkAb1ZObWT+LB43Bo1uO7MxUY8FnbcML0i6z3Ux
	FT95IdmeyqX3uaLc1r37OS3g1mHJAFkcm7Lg7la4xP7dAn7KLy2zSecvfmi7dzyGahOm0qE4Rk+
	GdLYxjFvWZ2gfbeMUZhyLR34V23AQrK37J3u/KcjHo+mMUCKwvKTa+DPuhI4kDlLYn/Nxs1h8xO
	DXoihTk8W3UXAKYr8oWGRqeOxExoiKxaWx5ioGe32gYiLGW5ZwG0uUBrrSMehHhJF0KHzix0/FM
	Rp9XP5dZ9Cm4nXgnjgEpCTbZEp4Au00Et/KRuS+cH44Tt5NBi8sOM5lNrXo9gFs8vJzkL/iHVeT
	lwyj+hTrjMfOXTJNhIIqWpfsCsrNk+NgieMcER/6CSNTxVknA7Too2zew0n8TBxG0S3pzw8KNr/
	eemeW0VrMZMpZpLi6QJySE/K2lCaA26zCvX3RfUwP85jMeJrMdIT4=
X-Received: by 2002:a05:6a00:3391:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-84336a8cf92mr846580b3a.24.1781146626022;
        Wed, 10 Jun 2026 19:57:06 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338316f0fsm233006b3a.50.2026.06.10.19.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:57:05 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Thu, 11 Jun 2026 10:56:43 +0800
Message-ID: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297905-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40D7866DE69

From: Menglong Dong <dongml2@chinatelecom.cn>

During packet receiving in virtio-net, the rq can be empty, which means
"rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
can be empty too, which means we can't allocate anything from
xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.

However, if the user clean all the data in rx ring and fill the
"fill ring" and check the XDP_RING_NEED_WAKEUP flag after
xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
napi will never be scheduled: the rx ring is empty, which means we will
never receive a packet to trigger the further recv fill. The rx ring is
empty now, so the user will not check the flag too.

Fix this by set the XDP_RING_NEED_WAKEUP flag before
xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.

Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
rq->vq.

Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..4b5b3fa62008 100644
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
-- 
2.54.0



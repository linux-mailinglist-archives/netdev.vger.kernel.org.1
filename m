Return-Path: <netdev+bounces-299821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BJI6BJ87MWpDegUAu9opvQ
	(envelope-from <netdev+bounces-299821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:03:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB8D68F101
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iP8r0sP8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299821-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299821-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA3DF306DE81
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C9C44BC9F;
	Tue, 16 Jun 2026 11:59:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEB44BC93
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:59:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611161; cv=none; b=PsRdy4mwLUMY7NfqrRsCek6++8w6aJVfemCSQhki2AQhP2htVDOWAjGJYblzTID84wSNc6WeaGrphvI0VJOECjyZZ8hqLfYKDeoII/gPI0D/aupQ5ZsIalt6tXkzoeULwJqkLYCDckc5je3N82tlzwSuGKAm76WwrfIABvKRcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611161; c=relaxed/simple;
	bh=kQx7S1lN4paJYctsV2z4hkTK7SF/owMDbAW+qh6X9Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXwfn+GhvT/vnhlX4ndsa8HvjaTtyfxWwyeKPS2eiyeThlrvSMbBXsfEp2MHf0IN9Y6cSLph6ta/WCimDPL6bXXmhdkn1Bvbdz89EMiWz7pSj8qphRAAFvWX6ObUMNqQ0pt/lqJaoxr0dUyDmQaEzzqoDvXtukPdxBG07izm5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP8r0sP8; arc=none smtp.client-ip=74.125.82.195
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-30759632453so6787611eec.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611158; x=1782215958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4g6o7WznQqMD7DmuskukA26zlCv9hBZUO8oTLjiGHU=;
        b=iP8r0sP818trdAP/tqcvatBoQpNfVUH5TT2PBoCI7A4ThdzU9wz65WNjTWruCLAzXb
         M7LHSlrRZdrjCo1RKg04emYeulsKFxnUoblUaLtzMkT0IrnEGT9Xb5rb3H94arkUPHXy
         7u0OM86nVSGLh52s71dDCxUxNyi4DZ4onhTMBLxbdAeVZM2pkpmWEjP6r6GT01r5gu6P
         4X427gy2llmWebR5c4SPQR/4g1XBjOrSxEKZeL2cXM/DdlxaXaI+iXJntqWkXXqiKAT5
         hYxbdafKBKhENi2MijJg7CvG1K8uvtTjptyJ+mlkB896atafb4N2WjQ0qHv8VBsEFp8e
         DfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611158; x=1782215958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4g6o7WznQqMD7DmuskukA26zlCv9hBZUO8oTLjiGHU=;
        b=ZoeBc8QD2ke+V1ghDoXWvfH0Kc0+sy+R/259opvQRDfPansKEoIBORWaqRc510747e
         17xJPn6jhCqpjTrvCbbQzx7P/OyMfD1gKZLSHSGpz9fbGNvOFvkd/6AKqfdXoEbDOZ/I
         ws/4AzGab6WsChPAg2ng1ejBSSawIpo0Uh3X8juMQiHdGjgpb6YjPKQ01+6BiUtG+OGg
         8kp/rAVip3wqXhWEYf1/pZ0UPjO9nZMC4ThbdtAj/7u8F6c35IWIcpg4Ln2HNw1uce6h
         lYtnRDuDjUjlOViIGe/sQG/aAmWAQQ6TFeqA1DxsyBJI3kmaICdXuBcnOYw5pjGAprXg
         HbNg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ub5nQ00zPKGfH7kI7xJwrHMTezwWMSHnrMOQqtaW0qu6ukFmm64llx/AziDwOA80tTTEB+8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVEctDsdQ1JupO6SEAf/p8JHOe7POl5TfV14aKeFFXS/Na/4L
	VytjCQi2Hy6TgX9EkCJJyC9RNwOKNtjGQGjFaYPsnRJ8PRGDZ2QfxhWueruaWjDmZiI=
X-Gm-Gg: Acq92OFnVzfkXaYUF9cuAO0eIzwUB/xJWrp4LY70pFMQhxUTem8XFUDD+RM5vfOBLmq
	SZJRERwbJpHEJ2qwfQgbqmuOTxniVGD4xjBHSOUVhIzfBT8fExGq2RMtonazHJTHudl2WpJ7hCs
	n62bt87ZUc+gPBgH1Au5utHmBs9287npVWrFASe+XUp/wUROpQthL1mcPwv+NTwrwD9L5gyoXjg
	oFCXMfEpaQGyr3+rnERCok13XEiukd+2r3i2wcJmtJaWT/Xsg4EX0U0Yw4i89iwi9+lK3AkjYmJ
	wIMxennlvBB1Hwk6gMRVzDnB2Oy17I75QhqF1x7+Knak9o+5nmrvS/XlKBGljfj8dQj/k5W5pVb
	+QXzlxMH5b1XZ+CSccemSUegaNFdt3aSBjMCs6oEhZ31KpHyuajVSXmiU5oN8gT4vM41eBWixXL
	cAXk1Q/kwKfZiSR2FI1YKDacHdJT0q7YqTjJFMdh5e
X-Received: by 2002:a05:7301:9f0a:b0:304:dfae:68a with SMTP id 5a478bee46e88-30820213e52mr9174117eec.28.1781611157637;
        Tue, 16 Jun 2026 04:59:17 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea447b4sm17474328eec.23.2026.06.16.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:59:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: mst@redhat.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Tue, 16 Jun 2026 19:59:12 +0800
Message-ID: <20260616115912.513183-1-dongml2@chinatelecom.cn>
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
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299821-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BB8D68F101

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
v3:
- remove the confusing comment

v2:
- add the Fixes tag
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..6e099edef6e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1440,8 +1440,9 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtnet_sq_free_stats stats = {};
 	struct net_device *dev = vi->dev;
+	int sent, vring_size;
+	bool need_wakeup;
 	u64 kicks = 0;
-	int sent;
 
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
@@ -1451,8 +1452,25 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	if (stats.xsk)
 		xsk_tx_completed(sq->xsk_pool, stats.xsk);
 
+	vring_size = virtqueue_get_vring_size(sq->vq);
+	need_wakeup = xsk_uses_need_wakeup(pool);
+
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
 
@@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	u64_stats_add(&sq->stats.xdp_tx,  sent);
 	u64_stats_update_end(&sq->stats.syncp);
 
-	if (xsk_uses_need_wakeup(pool))
-		xsk_set_tx_need_wakeup(pool);
-
 	return sent;
 }
 
-- 
2.54.0



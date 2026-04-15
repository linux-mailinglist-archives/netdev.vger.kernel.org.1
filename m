Return-Path: <netdev+bounces-278713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BUKHDpM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664E401F6D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46A893034597
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70E3CF678;
	Wed, 15 Apr 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVflmWFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D33A5435
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241711; cv=none; b=m4yP1uCi9lT5EtrMMvkwDtBo5kKbb0sNQIU/vkLwC3AxPYy5sFCryXp5U0Tk6uFDV1GYgCL2++OiKTYNwYGZpoVlXR3X8c/fE+qZJEuZWkGoivecTSCEKo1ED3ZfPBZiqQolZylurQB4BOz8RblQ5dJVL0vP7xGcoD+pkQsiGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241711; c=relaxed/simple;
	bh=yKjoEqppyYmzufeDQqQZadeRBf6bIz2HEfWY/80KadI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Davxy86daOCcGdTmH3avB2MnzopZ4ntYdvFiuhHkrGRmoMKMZrBdvN04KE8jKgapi8ltSljfk1eCGLn/6G0qSwKh4bG+dwQMqcabl0zuq0XBlVAftKNayI4+IyjSOptUeIruAGkc2HGIVccGp3lb4k1TrD1MyupBbfVGIXvJ/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVflmWFG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b45cb89f7eso20803365ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241710; x=1776846510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBZ1nBfxkE7gobaFwOrpm+pnMw7cmpsG7NHvGmvrpYw=;
        b=aVflmWFGmaH/byY4swGrNnz7/9fSTyjV6Ca3VoZ0NDVPPbqcKSbe2/wl/FqQLM6qt3
         +Rp3QuJeDncMGV6fRK7YGPJb9TIbuXV4TRietsLgaABzzvhC2dsQbsZjRRxsPW3OrXd2
         1o8k4PVr0hkSyD1wwMCIrHV8mo6OqyYkI9RGIs+b5edRsowr3HzaKy8+noaGgibBQ6Df
         alHOpd/EAsOgHrh+UUdZsN1PVVWWqJANQgpWmsXIF+Q9Iof4OPZiIiagN412Lyx1LDKs
         8PORTX1uLJlsLU/a9tZzyM2CTuEF8VPMGRJdPuqJ2r3B6IQFKPQ7KCq8A8OZiJ/DR/37
         wb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241710; x=1776846510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TBZ1nBfxkE7gobaFwOrpm+pnMw7cmpsG7NHvGmvrpYw=;
        b=fnn2DhmhcEVhO1j6M/WaO4b/PX3Axr3V+m9NJCqp/R+pG2m5TAU3l09vxHK6T0CMBj
         Hzs00U0TIdZldM+jTU6Wv3ckyhpu2l9ZV10bWfaokVkhsRXVwaUBrCegUrAGYFcRzLum
         LwtK/LSgbh5C1/eyqPsXDJ9rx/VQEee/P0eSOUafPxuW2kC5Er3sETKzmOaj/WBMW1Xc
         gHhXErSngMuJSgrxpMGAyPjNjIkrshsUTftVSszgu+B87II7ZK5O7UJ7z180Y4PXfAC7
         iZAJz84FeN5TMrF+UjQkPLkZjDLvMogrHVgsnWMJIoVPrawJZ16ijwubI9zJ/MwLvStU
         PxHg==
X-Forwarded-Encrypted: i=1; AFNElJ+8+XnLvrFZRkHas+QdNutJfb25+KLIITpF/43C+sBcR5CEq6EnYqVWiMPl8ZoKH9cJZOI+pqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsLzcQEF52pRnyX3kVYvwlorqJQneu0fS+Mbvgy/mqcmwhZQs
	b7VeZmcQZPW2RFjKvg8eyH6aHkrNVdlBBTNSH8KbI2VhjKna/lStZgza
X-Gm-Gg: AeBDieuX35saXPBaeJ67FD1n9ZAhX6grHHA9z60z9LK7vtCC/7XOeIuCzN2ilVowess
	Vha8rj4t+heh9MsYfpTxUzZoW0DflcJ0M6gX5LaeQDjhPTTp0BBcPxT4FWkq+dESN3KnR6d7inq
	PsDnCxkRqoPkJzJx48J45wnfPOJjvvGAjYqBlojT0KJdVn+l+2A945UlH+0szKaukXz8wq0IRRZ
	yEpk5UOGhz58bVEwJkba/qwaUYSn2cP2Z/lFdgNz2rDVcxjHhDyHQtt3CqPFc0jIZ+NVm3sdGAO
	rNjCRtJg+3gJyriAUr17Cee8+QQNoTwrn7ZxllR0ScC6jjzZQlby27kFzeg7S2LggnqFWkHm6Y8
	xA4ND5uM74efUDGS8thmbkNVwga7QnYq81cnqyu57ml2AL9oocWph2ouH0theQblkkeOrzrryqh
	/tIo0Fr/EKzn2IH5op0lWZSU9fRgOCuGGlnvcd1tuvF90lOX8FyphDhwKN48+6+nkWbbNaS7Q7P
	29Ke62o
X-Received: by 2002:a17:903:240b:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b2d5a3be0emr216647015ad.35.1776241709619;
        Wed, 15 Apr 2026 01:28:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 13/14] xsk: retire old xmit path in copy mode
Date: Wed, 15 Apr 2026 16:26:53 +0800
Message-Id: <20260415082654.21026-14-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278713-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5664E401F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add a new helper xsk_init_batch() used in xsk_create() with the default
value 1.

Obsolete __xsk_generic_xmit.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 151 +++++++++++++-------------------------------------
 1 file changed, 37 insertions(+), 114 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e1ad2ac2b39a..be341290e42c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1036,101 +1036,14 @@ static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
 	return err;
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
-{
-	struct xdp_sock *xs = xdp_sk(sk);
-	bool sent_frame = false;
-	struct xdp_desc desc;
-	struct sk_buff *skb;
-	u32 max_batch;
-	int err = 0;
-
-	mutex_lock(&xs->mutex);
-
-	/* Since we dropped the RCU read lock, the socket state might have changed. */
-	if (unlikely(!xsk_is_bound(xs))) {
-		err = -ENXIO;
-		goto out;
-	}
-
-	if (xs->queue_id >= xs->dev->real_num_tx_queues)
-		goto out;
-
-	max_batch = READ_ONCE(xs->max_tx_budget);
-	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
-			err = -EAGAIN;
-			goto out;
-		}
-
-		/* This is the backpressure mechanism for the Tx path.
-		 * Reserve space in the completion queue and only proceed
-		 * if there is space in it. This avoids having to implement
-		 * any buffering in the Tx path.
-		 */
-		if (!xsk_cq_reserve_locked(xs->pool, 1)) {
-			err = -EAGAIN;
-			goto out;
-		}
-
-		skb = xsk_build_skb(xs, NULL, &desc);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			if (err != -EOVERFLOW)
-				goto out;
-			err = 0;
-			continue;
-		}
-
-		xskq_cons_release(xs->tx);
-
-		if (xp_mb_desc(&desc)) {
-			xs->skb = skb;
-			continue;
-		}
-
-		err = __dev_direct_xmit(skb, xs->queue_id);
-		if  (err == NETDEV_TX_BUSY) {
-			/* Tell user-space to retry the send */
-			xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
-			xsk_consume_skb(skb);
-			err = -EAGAIN;
-			goto out;
-		}
-
-		/* Ignore NET_XMIT_CN as packet might have been sent */
-		if (err == NET_XMIT_DROP) {
-			/* SKB completed but not sent */
-			err = -EBUSY;
-			xs->skb = NULL;
-			goto out;
-		}
-
-		sent_frame = true;
-		xs->skb = NULL;
-	}
-
-	if (xskq_has_descs(xs->tx)) {
-		if (xs->skb)
-			xsk_drop_skb(xs->skb);
-		xskq_cons_release(xs->tx);
-	}
-
-out:
-	if (sent_frame)
-		__xsk_tx_release(xs);
-
-	mutex_unlock(&xs->mutex);
-	return err;
-}
-
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	ret = __xsk_generic_xmit_batch(xs);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
@@ -1626,6 +1539,34 @@ struct xdp_umem_reg_v1 {
 	__u32 headroom;
 };
 
+static int xsk_init_batch(struct xsk_batch *batch, unsigned int size)
+{
+	struct xdp_desc *descs;
+	struct sk_buff **skbs;
+	void **data;
+
+	skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
+	if (!skbs)
+		return -ENOMEM;
+
+	data = kmalloc_array(size, sizeof(void *), GFP_KERNEL);
+	if (!data) {
+		kfree(skbs);
+		return -ENOMEM;
+	}
+
+	descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
+	if (!descs) {
+		kfree(data);
+		kfree(skbs);
+		return -ENOMEM;
+	}
+
+	xsk_batch_reset(batch, skbs, descs, data, size);
+
+	return 0;
+}
+
 static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			  sockptr_t optval, unsigned int optlen)
 {
@@ -1746,9 +1687,6 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 	{
 		struct xsk_buff_pool *pool = xs->pool;
 		struct xsk_batch *batch = &xs->batch;
-		struct xdp_desc *descs;
-		struct sk_buff **skbs;
-		void **data;
 		unsigned int size;
 		int ret = 0;
 
@@ -1762,27 +1700,7 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 			return -EACCES;
 
 		mutex_lock(&xs->mutex);
-		skbs = kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
-		if (!skbs) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		data = kmalloc_array(size, sizeof(void *), GFP_KERNEL);
-		if (!data) {
-			kfree(skbs);
-			ret = -ENOMEM;
-			goto out;
-		}
-		descs = kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
-		if (!descs) {
-			kfree(data);
-			kfree(skbs);
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		xsk_batch_reset(batch, skbs, descs, data, size);
-out:
+		ret = xsk_init_batch(batch, size);
 		mutex_unlock(&xs->mutex);
 		return ret;
 	}
@@ -2056,6 +1974,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 {
 	struct xdp_sock *xs;
 	struct sock *sk;
+	int ret;
 
 	if (!ns_capable(net->user_ns, CAP_NET_RAW))
 		return -EPERM;
@@ -2071,6 +1990,11 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	if (!sk)
 		return -ENOBUFS;
 
+	xs = xdp_sk(sk);
+	ret = xsk_init_batch(&xs->batch, 1);
+	if (ret)
+		return ret;
+
 	sock->ops = &xsk_proto_ops;
 
 	sock_init_data(sock, sk);
@@ -2081,7 +2005,6 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	sock_set_flag(sk, SOCK_RCU_FREE);
 
-	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
 	xs->max_tx_budget = TX_BATCH_SIZE;
 	mutex_init(&xs->mutex);
-- 
2.41.3



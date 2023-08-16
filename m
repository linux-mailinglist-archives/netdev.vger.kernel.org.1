Return-Path: <netdev+bounces-28164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02277E6C0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E951C2117A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DC414281;
	Wed, 16 Aug 2023 16:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA991773B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:24 +0000 (UTC)
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 09:40:22 PDT
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672D2721;
	Wed, 16 Aug 2023 09:40:21 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57D46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2D8F6FB5B6;
	Wed, 16 Aug 2023 18:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203602; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
	b=ZAJBcK1mkQD/h+RaS+rhNBlMEwe8FNtnH+Ubastim8RuMTx6CaaDXOPHk5NNAchmiruGYc
	DKjIHxgcNXxgpcxr/ebBkwXWxjA+EZHgyz7BOR+KFbKn6jtiPJcIkrqTwFU2dIpbgRqv1G
	UAhMPzStUg42dl9KH7b9gdXGU8x4EbZ1ZVlfW/noNGSn5Ha0FZshGuPYuSbBzw7KUbwAGm
	l//+YvOWQ4K4+WQvoUzzU4ypRApT4WeU4tkhwj4yo6AnGszMTu9W4gG8mogASlKfiPrMcQ
	0CQdrFSbTBuIeWs+ZwyMW8n5+XcwZcgWGspEL9HTE5FoWTd9TtyjcnnHHzD8OQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/5] batman-adv: Don't increase MTU when set by user
Date: Wed, 16 Aug 2023 18:33:15 +0200
Message-Id: <20230816163318.189996-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203602;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtU/tgx4L6o0Wop2AU1xgpmhIFIvDcIHteSPIJzJVzQ=;
	b=uvCyrT5yxTVLpvUL9j/Kbx1/jk6u2SafmN8gKg64X2WS8LKZe9IHDBRBi8q57WWWVuqmL2
	URpZJNg6tl/PpY32yK4EbhOw2bxXvZIoHiB+g33a6RGGGeO6b8RX7jPGW1n0EseCrS2x6P
	yRtN4t0OwxfbpADgqjFDd56aJy4T3aneT8rg1iFoHFMRVM4oscpMq9AZ5VkqAEd0CJPUiI
	UvRZyhChd41LsMU1Hvq09mWrtd1DlvF583mDjxznCCFaG46OFGZLq2eQ3tdy9jMy/rrd7W
	S53mE4KBxm1Ap6tvAL40bcYNG4De7Xq6u84Z+AGt8md4C7KAokdHEVIA74+icQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203602; a=rsa-sha256;
	cv=none;
	b=Kn4nsiW5NXDiE0JOpoekwcbtDknkwfoJ/zAw/H9KB2cBra8ZNhiCasi/5Rr/LxyLxe2AiJY4kfGfkyRrpOnlqMi39sc5dIoEHLGmw+Ds2jXbQwrvgvhh1le25hbsjXKwBuhh4B9YYk9BCILBRBqyqN33EiirjE6PQSFATq6ZnaSW4s9fwioBGU0KGq/jjJwwT/NTtU8I554TqYv+eCwhNZac71kLB/rfyWMCESrpqP4RhuButAHGdajAI+TXZ30q1ZszTR2RWhrJZILmK1YRG6lxtFtUuaStf7oSaMDRvPVzijY02TxvIVGpf5CpKj92Uds7Q4K3m6ATsBkDKOhTEA==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sven Eckelmann <sven@narfation.org>

If the user set an MTU value, it usually means that there are special
requirements for the MTU. But if an interface gots activated, the MTU was
always recalculated and then the user set value was overwritten.

The only reason why this user set value has to be overwritten, is when the
MTU has to be decreased because batman-adv is not able to transfer packets
with the user specified size.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 14 +++++++++++++-
 net/batman-adv/soft-interface.c |  3 +++
 net/batman-adv/types.h          |  6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ae5762af0146..24c9c0c3f316 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -630,7 +630,19 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index d3fdf82282af..85d00dc9ce32 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -153,11 +153,14 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ca9449ec9836..cf1a0eafe3ab 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1546,6 +1546,12 @@ struct batadv_priv {
 	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
 
+	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
 	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
-- 
2.39.2



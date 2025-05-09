Return-Path: <netdev+bounces-189167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC5AB0E53
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F172A1C245D7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6C276050;
	Fri,  9 May 2025 09:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F7275864
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781848; cv=none; b=hJ5wn28LYM2ZdM3sEIaEVe5l75q7AEKcR+YdoHluCHZEtBQ28VHX3m+v4NYHy21zR8fV9kx4t2W+dBFLzWqXhDFipazVIxeLe1Dp2Iv0juMS/AulkOeLmzACqY21yyS/MEmU4pkFwsQ/19rezZUP9HMZaSO73VLrG8KINhbGPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781848; c=relaxed/simple;
	bh=FuMhMo8L/kj4QC8lcUyKFr44Uj7ILmRJZhAbChAoOo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqO5XdQiduhgON339gcmYsB6eTGyOgj02qZHmH9uJYoQVnC0li+F7oRLoRTYknyNlqWcePWHWI98bbhkrkjkOdW3dIXxNJyrRrnyrIAL3jcOwUc6uRiJ4KrmKWiMGcIjpgzSF/aaaSynuIj8htMBybfTVtWi5YwXV24+2h5JPXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736C7d829705d90aB67a755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id CFD73FA362;
	Fri,  9 May 2025 11:10:44 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Antonio Quartulli <antonio@mandelbit.com>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 3/5] batman-adv: no need to start/stop queue on mesh-iface
Date: Fri,  9 May 2025 11:10:39 +0200
Message-Id: <20250509091041.108416-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Antonio Quartulli <antonio@mandelbit.com>

The batman-adv mesh-iface is flagged with IFF_NO_QUEUE,
therefore there is no reason to start/stop any queue in
ndo_open/close.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/mesh-interface.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 59e7b5aacbc9..e48b683a033f 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -77,18 +77,6 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static int batadv_interface_open(struct net_device *dev)
-{
-	netif_start_queue(dev);
-	return 0;
-}
-
-static int batadv_interface_release(struct net_device *dev)
-{
-	netif_stop_queue(dev);
-	return 0;
-}
-
 /**
  * batadv_sum_counter() - Sum the cpu-local counters for index 'idx'
  * @bat_priv: the bat priv with all the mesh interface information
@@ -890,8 +878,6 @@ static int batadv_meshif_slave_del(struct net_device *dev,
 
 static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_init = batadv_meshif_init_late,
-	.ndo_open = batadv_interface_open,
-	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
 	.ndo_vlan_rx_add_vid = batadv_interface_add_vid,
 	.ndo_vlan_rx_kill_vid = batadv_interface_kill_vid,
-- 
2.39.5



Return-Path: <netdev+bounces-67920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D9845608
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B705A1F2B708
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924915CD76;
	Thu,  1 Feb 2024 11:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1515CD40
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785827; cv=none; b=UXio9JTgv/kb5rljjAS8TxSZQdladvXJQZjCNU81lu+f2Je2ChSAKBlzKq+KyQjXTEhpst1qJwcu4O5WJO+VLTPISk7glSnCtrg067LJYQbn0IiL7lWgZGeH5rkAzs8Smh8sCQq2xnU/17em2J8osmYSwkDlUNE8N56i8UpCbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785827; c=relaxed/simple;
	bh=kFbi/GNT4AXtAgyd5PpS3csqGmzO3Bcwr3VIUhQvKm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHk7tnT6j2UfYgjs7qmeCZyPyCKWx2STsF0kLr6cdA5d+bAa0Vv828D8Mvbg8k0ihXUlCUeQXYq6Gmv5l5WraVad+VZfKSQ0h3eC7cO9v7INDNj+zQBKF/huO759xmCBJGNMseG88G25lvjWf2YUdAp20RU8a5WZA2Dgc9EtfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59712C7d8D89318FB9D63B559.dip0.t-ipconnect.de [IPv6:2003:c5:9712:c7d8:d893:18fb:9d63:b559])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 7A811FA9A1;
	Thu,  1 Feb 2024 12:01:15 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/2] batman-adv: mcast: fix mcast packet type counter on timeouted nodes
Date: Thu,  1 Feb 2024 12:01:09 +0100
Message-Id: <20240201110110.29129-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201110110.29129-1-sw@simonwunderlich.de>
References: <20240201110110.29129-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Linus Lüssing <linus.luessing@c0d3.blue>

When a node which does not have the new batman-adv multicast packet type
capability vanishes then the according, global counter erroneously would
not be reduced in response on other nodes. Which in turn leads to the mesh
never switching back to sending with the new multicast packet type.

Fix this by reducing the according counter when such a node times out.

Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index d982daea8329..b4f8b4af1722 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2198,6 +2198,8 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig)
 				      BATADV_MCAST_WANT_NO_RTR4);
 	batadv_mcast_want_rtr6_update(bat_priv, orig,
 				      BATADV_MCAST_WANT_NO_RTR6);
+	batadv_mcast_have_mc_ptype_update(bat_priv, orig,
+					  BATADV_MCAST_HAVE_MC_PTYPE_CAPA);
 
 	spin_unlock_bh(&orig->mcast_handler_lock);
 }
-- 
2.39.2



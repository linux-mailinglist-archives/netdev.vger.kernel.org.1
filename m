Return-Path: <netdev+bounces-189166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1BAB0E51
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D4B4C6EE9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB3274FF1;
	Fri,  9 May 2025 09:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080127584F
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781848; cv=none; b=ROCcESZgGeUUQFTnnwYh79ewAGStW8JBhJ1vvgGf2JdWCcegaonOFRsmQopXS/qtHqrE/TCPfupWAQ2VmbaYi26oOGjfbNk351Xw1uD7yL992/d7WpRe9rG1jWy+A/PT5Ld5hShgAxnPGp+HfcsL3u5PQAqAlv1IDNZrHY0kqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781848; c=relaxed/simple;
	bh=17dI59+Cx/qHVHElifs+lQi+BjCiFJKgJz3tms+UX+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3BNELG6GQ+fY7uwZ7cXePcBrNKU/wWA451+AJv93vbYEyy02tRB5OY49WIW9C13/QxyyBrEcmAjzWIctFgSXpZLyIO+p7D//k3MKYQcl1OitDX4qHMohNRYhsG3KgMBCeY91C1Lif4oAGsd6IqdnNcY9mnRvRH1rYzPy7cADVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736C7d829705d90aB67a755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0D414FA361;
	Fri,  9 May 2025 11:10:44 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Matthias Schiffer <mschiffer@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/5] batman-adv: constify and move broadcast addr definition
Date: Fri,  9 May 2025 11:10:38 +0200
Message-Id: <20250509091041.108416-3-sw@simonwunderlich.de>
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

The variable is used only once and is read-only. Make it a const local
variable.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 --
 net/batman-adv/main.h | 1 -
 net/batman-adv/send.c | 4 +++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index a08132888a3d..e41f816f0887 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -69,8 +69,6 @@ unsigned int batadv_hardif_generation;
 static int (*batadv_rx_handler[256])(struct sk_buff *skb,
 				     struct batadv_hard_iface *recv_if);
 
-unsigned char batadv_broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
 struct workqueue_struct *batadv_event_workqueue;
 
 static void batadv_recv_handler_init(void);
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 4b5ce8972848..692109be2210 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -235,7 +235,6 @@ static inline int batadv_print_vid(unsigned short vid)
 extern struct list_head batadv_hardif_list;
 extern unsigned int batadv_hardif_generation;
 
-extern unsigned char batadv_broadcast_addr[];
 extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *mesh_iface);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 735ac8077821..9d72f4f15b3d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -124,7 +124,9 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface)
 {
-	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+	static const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	return batadv_send_skb_packet(skb, hard_iface, broadcast_addr);
 }
 
 /**
-- 
2.39.5



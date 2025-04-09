Return-Path: <netdev+bounces-180914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA6A82E9C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB277B0089
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E567276040;
	Wed,  9 Apr 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b="gHnL2QjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail.universe-factory.net (osgiliath.universe-factory.net [141.95.161.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DD270EC0;
	Wed,  9 Apr 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.161.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223066; cv=none; b=my7cq00/UQfJ6Udy/qdUlLdTfSSbtIlH0CGCvsj4YdKA9wXdPEZ2G8PjPb9pPu9KxZbrx4TkBmedu2kzlTDgMNNUTRxajKra5QOL6LODpyYSYbuag7e+Y1jbPWlyMwPMauxjFaeR3ks3KlkaGn3KjNBZQtUcgoVw3sS3WOKtDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223066; c=relaxed/simple;
	bh=468+UBaD6t28hhNocqfcMwNQfTsnn9Th5wyxTz72HBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=On7LNxk7KA0aYCFFXrtoNXzNOGEJRVczJ2rrRi7XSiV/eiaXBOnXSASxdCroKhzylecyd8zxwaXSLrLZ5CRh+sLL1y+GmhDELcICmCwfYlUBgW3KXpAfOuQ5whd90vMJG6st6X4s0PIZtVMFM9b+Dj7+D1JLfrGf9aVykW5GXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; dkim=pass (2048-bit key) header.d=universe-factory.net header.i=@universe-factory.net header.b=gHnL2QjX; arc=none smtp.client-ip=141.95.161.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
From: Matthias Schiffer <mschiffer@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744223052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fmABFA67142xBv1sgjgdUjf2o65cAlIZeMq1xn621CA=;
	b=gHnL2QjXlUiba817MP99GgwvD+VqveXBMAXrETnNZpEuehC0mRFrsV/q69rIsfWZYtXNJU
	ZQkhkwweDwOeVqV+tSKqX/18qKwN0tY1doaBVF4MLDc0yrp1OPdcZ2RhqCOXijSzj7EZmG
	qFsg6ILROzJ7dZHUlQBXxsztYQuQ3chjBYqGJnP4GCUwkE/VdOlqcDfklmLeR3nBWGZeMy
	WSvPtCP/9mx15hg7Q4PhHireQPQowQ13HmYWg8NmDmPeUr4s9B+b3sVZk2uj9vXPwpsWF8
	k2IJOtm38ff6C+3T8eOEZXHcdQsE72z6RIWgw4gbQJfSdapRTjQH4vqlAMVr3A==
Authentication-Results: mail.universe-factory.net;
	auth=pass smtp.mailfrom=mschiffer@universe-factory.net
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next v2] batman-adv: constify and move broadcast addr definition
Date: Wed,  9 Apr 2025 20:23:37 +0200
Message-ID: <c9d8fd3735ffe10d199ee658703766bcc0d02341.1744222963.git.mschiffer@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

The variable is used only once and is read-only. Make it a const local
variable.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

v2:
- make variable static
- remove "net: " subject prefix to match other batman-adv commits


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
index 67af435ee04e..bfe90a888af4 100644
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
2.49.0



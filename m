Return-Path: <netdev+bounces-95142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C88C1800
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1464283830
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DE84FB1;
	Thu,  9 May 2024 20:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F384DEE;
	Thu,  9 May 2024 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288305; cv=none; b=YS4b8fSUtBSUGmQdgtLUlLpjpVgAlfC63I0aoZnrW8m8gKzY7XB8cM1nU+IBFtUEfEPNyWmOozo384UDJyrHWkbT9mOf5Tb5LcEV+LXJ1Z7rcKaKFYp2Z6NNPq7DicM9LplcqLj0aZoIHIRByn5ZI0POay6kp1eQCT+bZ5DFcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288305; c=relaxed/simple;
	bh=C67xdYWkBGECbhZb4PGQ2m356x1NuCq2vdcx75RdNeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5NHHXX+WsDoTo339JkTDyFMSxC1U9z2BhLRq4bD65B9YKZbhLXPzAnAhGnUzmQa5yRxjd3aMRm9IRTPziBFIGm+aWZNbG3sg4XUu/p8QS5cDrXxnIkA9kwWUsMec00r/lME1hKyN5f47J+VsMCsUdj/JDk97sXwKsRG23VnFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id D8533A0336;
	Thu,  9 May 2024 22:58:15 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xslR1qoH_xYw; Thu,  9 May 2024 22:58:15 +0200 (CEST)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id AB897A0332;
	Thu,  9 May 2024 22:58:15 +0200 (CEST)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1s5AqF-0000000H31a-0DdT;
	Thu, 09 May 2024 22:58:15 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org,
	tparkin@katalix.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	netdev@vger.kernel.org
Subject: [PATCH] l2tp: Support different protocol versions with same IP/port quadruple
Date: Thu,  9 May 2024 22:58:12 +0200
Message-ID: <20240509205812.4063198-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

628bc3e5a1be ("l2tp: Support several sockets with same IP/port quadruple")
added support for several L2TPv2 tunnels using the same IP/port quadruple,
but if an L2TPv3 socket exists it could eat all the trafic. We thus have to
first use the version from the packet to get the proper tunnel, and only
then check that the version matches.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/l2tp/l2tp_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 2ab45e3f48bf..7d519a46a844 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -820,13 +820,8 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	/* Get L2TP header flags */
 	hdrflags = ntohs(*(__be16 *)ptr);
 
-	/* Check protocol version */
+	/* Get protocol version */
 	version = hdrflags & L2TP_HDR_VER_MASK;
-	if (version != tunnel->version) {
-		pr_debug_ratelimited("%s: recv protocol version mismatch: got %d expected %d\n",
-				     tunnel->name, version, tunnel->version);
-		goto invalid;
-	}
 
 	/* Get length of L2TP packet */
 	length = skb->len;
@@ -838,7 +833,7 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	/* Skip flags */
 	ptr += 2;
 
-	if (tunnel->version == L2TP_HDR_VER_2) {
+	if (version == L2TP_HDR_VER_2) {
 		/* If length is present, skip it */
 		if (hdrflags & L2TP_HDRFLAG_L)
 			ptr += 2;
@@ -855,7 +850,7 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 			struct l2tp_tunnel *alt_tunnel;
 
 			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
-			if (!alt_tunnel || alt_tunnel->version != L2TP_HDR_VER_2)
+			if (!alt_tunnel)
 				goto pass;
 			tunnel = alt_tunnel;
 		}
@@ -869,6 +864,13 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 		ptr += 4;
 	}
 
+	/* Check protocol version */
+	if (version != tunnel->version) {
+		pr_debug_ratelimited("%s: recv protocol version mismatch: got %d expected %d\n",
+				     tunnel->name, version, tunnel->version);
+		goto invalid;
+	}
+
 	/* Find the session context */
 	session = l2tp_tunnel_get_session(tunnel, session_id);
 	if (!session || !session->recv_skb) {
-- 
2.43.0



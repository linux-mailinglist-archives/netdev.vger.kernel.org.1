Return-Path: <netdev+bounces-93872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37B18BD712
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2904B22F59
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073D15DBD6;
	Mon,  6 May 2024 21:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAF15D5B2;
	Mon,  6 May 2024 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032420; cv=none; b=t3NG3KGvkiAMq/7NHMQTIkc/+GU2HjWzaDbUDxa77cL3NhDCj9xJlkVBpQX5lPv2gId1Zt51wzr5Rf9mwM+aO9cqhKA/KcjiWEdS4Hc+/LlXmN1mVOqbTUOWB5yzmHLeUiSKNbToeFPtOaJIjRY7wO1lOtdD541kfV4SCAaSUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032420; c=relaxed/simple;
	bh=5xqcT/MJ1k3KNGL3OEgnotxtEh49wE6sTfZDKNY7miQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g142zy9gVJP0d6dwyFScVADRC3u9Yi2IvmdDBJPmWczfUlqT23wk09W9rO+I8aZeO26wvwO1t0wokMyEORDcY5TbaEB6MJVYrQ77hlt2isy1fMMmeuULql7tphiSAen6xsGf/I9CvmBAEElOMOWLpUZOwK8zQKb7kaEbJLuMKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id BE3D9A02C2;
	Mon,  6 May 2024 23:53:36 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U6r1Mwcz0gl0; Mon,  6 May 2024 23:53:36 +0200 (CEST)
Received: from begin.home (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 9CB1EA02A3;
	Mon,  6 May 2024 23:53:36 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1s46HA-00000006AQP-0N5S;
	Mon, 06 May 2024 23:53:36 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: tparkin@katalix.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCHv2] l2tp: Support several sockets with same IP/port quadruple
Date: Mon,  6 May 2024 23:53:35 +0200
Message-ID: <20240506215336.1470009-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some l2tp providers will use 1701 as origin port and open several
tunnels for the same origin and target. On the Linux side, this
may mean opening several sockets, but then trafic will go to only
one of them, losing the trafic for the tunnel of the other socket
(or leaving it up to userland, consuming a lot of cpu%).

This can also happen when the l2tp provider uses a cluster, and
load-balancing happens to migrate from one origin IP to another one,
for which a socket was already established. Managing reassigning
tunnels from one socket to another would be very hairy for userland.

Lastly, as documented in l2tpconfig(1), as client it may be necessary
to use 1701 as origin port for odd firewalls reasons, which could
prevent from establishing several tunnels to a l2tp server, for the
same reason: trafic would get only on one of the two sockets.

With the V2 protocol it is however easy to route trafic to the proper
tunnel, by looking up the tunnel number in the network namespace. This
fixes the three cases altogether.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---

Diff from v1:
- do not check for tunnel->l2tp_net != NULL, it cannot not be
- check for tunnel version

 net/l2tp/l2tp_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 8d21ff25f160..2ab45e3f48bf 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -794,6 +794,7 @@ static void l2tp_session_queue_purge(struct l2tp_session *session)
 static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 {
 	struct l2tp_session *session = NULL;
+	struct l2tp_tunnel *orig_tunnel = tunnel;
 	unsigned char *ptr, *optr;
 	u16 hdrflags;
 	u32 tunnel_id, session_id;
@@ -845,6 +846,20 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 		/* Extract tunnel and session ID */
 		tunnel_id = ntohs(*(__be16 *)ptr);
 		ptr += 2;
+
+		if (tunnel_id != tunnel->tunnel_id) {
+			/* We are receiving trafic for another tunnel, probably
+			 * because we have several tunnels between the same
+			 * IP/port quadruple, look it up.
+			 */
+			struct l2tp_tunnel *alt_tunnel;
+
+			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
+			if (!alt_tunnel || alt_tunnel->version != L2TP_HDR_VER_2)
+				goto pass;
+			tunnel = alt_tunnel;
+		}
+
 		session_id = ntohs(*(__be16 *)ptr);
 		ptr += 2;
 	} else {
@@ -875,6 +890,9 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
 	l2tp_session_dec_refcount(session);
 
+	if (tunnel != orig_tunnel)
+		l2tp_tunnel_dec_refcount(tunnel);
+
 	return 0;
 
 invalid:
@@ -884,6 +902,9 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	/* Put UDP header back */
 	__skb_push(skb, sizeof(struct udphdr));
 
+	if (tunnel != orig_tunnel)
+		l2tp_tunnel_dec_refcount(tunnel);
+
 	return 1;
 }
 
-- 
2.43.0



Return-Path: <netdev+bounces-303222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Ac3H8LPQ2r2iwoAu9opvQ
	(envelope-from <netdev+bounces-303222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:16:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBD6E54E4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:16:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F1SjhFgo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303222-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE1B8319B3EB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95DD423A6A;
	Tue, 30 Jun 2026 14:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C6242315B
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828395; cv=none; b=Q8a7XgoQGbuGcNYcUM/acFJPM6iZBZuGBChs/e+E9rHpR9mHsc4EH+LSYi6wlm+goXZVpUOWIqDGPeQO67GorXVWHlFnFEZXS9XeLh96OccyuNa9qzBydQPl+tQI0aar3UyY9Y5JZVnD3SttFBjT1oQxRw+3qtjVJEPF1+Mc+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828395; c=relaxed/simple;
	bh=14QvQuPU3r/Pnnir66JlCfeCcZnK0TLCee/Ktbgfd5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKMhDq5PIjyjo/eStBPCukH7RcarpYOEFhOe+eGxa41Zu4qbZoS/W/MVJlPuQqIl9vxyaUj2sO9qbgTcMsld9dXrlI+/xoqFRfX709OClyhXgG1OmbWC4xGEQnh2EAlLgC1ckRyPLl+t8BCYnl9XpKACwHdtiAe9cJ5BCYRgOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=F1SjhFgo; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3ZGFfO0pQVo955cy4QHxZ8eqU7mZNLw3Z/Xfs0q5Gs=;
	b=F1SjhFgorajQuLw1hBE/7t6k8QR1AH1GMD1zBCegXqAddqVw20wPiQ0s1cZENV+mdzuavJ
	pzFCBWFAJtgNnk+aZJcXzHHMFW+/QiX4VMlYsTiGLrv6V0wwBqsoqJMtrFxazHOcRU8Med
	41WHxV6P+Lcb9hV6HK0Bx6OL4TG1cxfzeO/T1cHDQxzBkjSSAUd7LT1JmqnY6lSs5QAOtk
	PKPQ23+dDEKx4VZVGGnDqc0dZpk5EVJ6J3ShD41t7dEZLa61Orrsaiy2vSYIqdKfr7KOlK
	6lqYEMnpqcLPYXbJFU8Tuh38IfgaCtLobqMDICvH0TCJ06QXNQa2v2VTyC9Fhg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/15] batman-adv: tvlv: extract tvlv header iterator
Date: Tue, 30 Jun 2026 16:06:18 +0200
Message-ID: <20260630140623.88431-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303222-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2EBD6E54E4

From: Sven Eckelmann <sven@narfation.org>

batadv_tvlv_containers_contain() and batadv_tvlv_containers_process() are
using the same code to iterate through the TVLV containers. To simplify the
code, extract the shared portions of both functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tvlv.c | 86 +++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6a..49bf2ed9ecdc3 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -442,6 +442,54 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * batadv_tvlv_hdr_next() - move a tvlv buffer cursor to the next container
+ * @tvlv_value: cursor into the tvlv buffer, advanced past the returned
+ *  container's content on success
+ * @tvlv_value_len: remaining length of the tvlv buffer, reduced by the returned
+ *  container's size on success
+ *
+ * Parses a single container header at the current cursor position and, if a
+ * complete container is available, advances the cursor and remaining length
+ * past it. The returned header stays valid; its content is located at
+ * (returned header + 1) and is ntohs(hdr->len) bytes long.
+ *
+ * Return: pointer to the next tvlv container header, or NULL if no further
+ * complete container is present in the buffer.
+ */
+static struct batadv_tvlv_hdr *batadv_tvlv_hdr_next(void **tvlv_value, u16 *tvlv_value_len)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	u16 tvlv_value_cont_len;
+	void *tvlv_value_cont;
+	u16 tvlv_len;
+
+	tvlv_value_cont = *tvlv_value;
+	tvlv_len = *tvlv_value_len;
+
+	if (tvlv_len < sizeof(*tvlv_hdr))
+		return NULL;
+
+	tvlv_hdr = tvlv_value_cont;
+	tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+	tvlv_value_cont = tvlv_hdr + 1;
+	tvlv_len -= sizeof(*tvlv_hdr);
+
+	if (tvlv_value_cont_len > tvlv_len)
+		return NULL;
+
+	/* the next tvlv header is accessed assuming (at least) 2-byte
+	 * alignment, so it must start at an even offset.
+	 */
+	if (tvlv_value_cont_len & 1)
+		return NULL;
+
+	*tvlv_value = (u8 *)tvlv_value_cont + tvlv_value_cont_len;
+	*tvlv_value_len = tvlv_len - tvlv_value_cont_len;
+
+	return tvlv_hdr;
+}
+
 /**
  * batadv_tvlv_containers_contain() - check if a tvlv buffer holds a container
  * @tvlv_value: tvlv content
@@ -457,28 +505,10 @@ static bool batadv_tvlv_containers_contain(void *tvlv_value,
 					   u8 version)
 {
 	struct batadv_tvlv_hdr *tvlv_hdr;
-	u16 tvlv_value_cont_len;
-
-	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
-		tvlv_hdr = tvlv_value;
-		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
-		tvlv_value = tvlv_hdr + 1;
-		tvlv_value_len -= sizeof(*tvlv_hdr);
-
-		if (tvlv_value_cont_len > tvlv_value_len)
-			break;
-
-		/* the next tvlv header is accessed assuming (at least) 2-byte
-		 * alignment, so it must start at an even offset.
-		 */
-		if (tvlv_value_cont_len & 1)
-			break;
 
+	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		if (tvlv_hdr->type == type && tvlv_hdr->version == version)
 			return true;
-
-		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
-		tvlv_value_len -= tvlv_value_cont_len;
 	}
 
 	return false;
@@ -511,20 +541,8 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	u8 cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
 	int ret = NET_RX_SUCCESS;
 
-	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
-		tvlv_hdr = tvlv_value;
+	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
-		tvlv_value = tvlv_hdr + 1;
-		tvlv_value_len -= sizeof(*tvlv_hdr);
-
-		if (tvlv_value_cont_len > tvlv_value_len)
-			break;
-
-		/* the next tvlv header is accessed assuming (at least) 2-byte
-		 * alignment, so it must start at an even offset.
-		 */
-		if (tvlv_value_cont_len & 1)
-			break;
 
 		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
 						       tvlv_hdr->type,
@@ -532,11 +550,9 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 
 		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
 						packet_type, orig_node, skb,
-						tvlv_value,
+						tvlv_hdr + 1,
 						tvlv_value_cont_len);
 		batadv_tvlv_handler_put(tvlv_handler);
-		tvlv_value = (u8 *)tvlv_value + tvlv_value_cont_len;
-		tvlv_value_len -= tvlv_value_cont_len;
 	}
 
 	if (packet_type != BATADV_IV_OGM &&
-- 
2.47.3



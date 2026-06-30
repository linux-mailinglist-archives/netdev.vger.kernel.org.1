Return-Path: <netdev+bounces-303221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAdtGynOQ2rgigoAu9opvQ
	(envelope-from <netdev+bounces-303221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 328076E53F0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:09:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=hh07csOy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303221-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A713C302379C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E88E423A62;
	Tue, 30 Jun 2026 14:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12D373C1A
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828395; cv=none; b=uVjKsRb6QcWn8OPZgGWMFStkBzErK0Z8EI9rKnuurlY1eHEB3tx2MtBCVdKJ3ydr5HR/nVXKlLGsDh0O1e22LxXFc7q4R7eG1Rpt23Wot1Yz2UdYhXUaStHpTjnMAUgZN0yoHRRe9n1engN879bJTHv2LRpnt6V29qQzcnUruVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828395; c=relaxed/simple;
	bh=7cKpNlxq64MPmBveT5IAw9hWYkp/ummsEPYyySbVBg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR1WsJuEkWMqiEe0CExDoSfoanqgwDWhu8mH6CpYwjJcr6Fh3OsAQYVRa/UtaDMWf75gN4Ry4L4Y8mwJM2nmBRkhV4MrfePRiDz4pnizkrYWu3kEkvImXykIrNauq4i30sD5zlyZ54N4LUKsI3QCVPIM/5486aefBb4tNYqSRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=hh07csOy; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1ZELRoiRhncnhMIWdvQ7ngTvJlPWJEpZajpuDkFiYU=;
	b=hh07csOy2nL3ivGlk8Cxf30CmRD5xdl9Myk6ogk3v8NH5VfkV4y2XzOb1MdYisv1GKzcuB
	Ksb14e7qx5yvtwGK0oyeqgQ3FsZmWgq5bS+47z6n0sDornW56XIU8j8jUOASgjA/gRlVCh
	Bgo8UfdT9tOAEWV1hYK6vHF+GG55+Vd67w+SrJoCWaDSBJ39k7mwGwyo+Url3UDUawj9V0
	U443fjMywviDg74jB2QxnwgVqc+swxFeUWUempr5EPyVCF9XezWiRkMDlnMgLoaLotpSFN
	ivn/sZMh4FXmwSBqsYHqG78s5VaeN63nFexCYhQyEJ0+aYZzbr0Ppr5xrL57gg==
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
Subject: [PATCH net-next 09/15] batman-adv: iv: drop migration check for batadv_hard_iface
Date: Tue, 30 Jun 2026 16:06:17 +0200
Message-ID: <20260630140623.88431-10-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303221-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,vger.kernel.org:from_smtp,narfation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328076E53F0

From: Sven Eckelmann <sven@narfation.org>

With the immutability guarantee of batadv_hard_iface->mesh_iface, the check
for "changed" (or NULL) mesh_iface is no longer necessary because a
batadv_hard_iface can no longer migrate from one batadv_mesh_iface to
another one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4514c51bba777..22622283f59b0 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -404,23 +404,14 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct net_device *mesh_iface;
-
 	if (!forw_packet->if_incoming) {
 		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
-	mesh_iface = forw_packet->if_incoming->mesh_iface;
-
 	if (WARN_ON(!forw_packet->if_outgoing))
 		return;
 
-	if (forw_packet->if_outgoing->mesh_iface != mesh_iface) {
-		pr_warn("%s: mesh interface switch for queued OGM\n", __func__);
-		return;
-	}
-
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		return;
 
-- 
2.47.3



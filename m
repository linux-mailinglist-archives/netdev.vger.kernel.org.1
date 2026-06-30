Return-Path: <netdev+bounces-303218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bMysJZvPQ2raiwoAu9opvQ
	(envelope-from <netdev+bounces-303218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECB6E54C6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:15:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=sdBbiJyr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303218-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4D1B3118E28
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6883A83AC;
	Tue, 30 Jun 2026 14:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF75380FE7
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828392; cv=none; b=aTlROdIfnHDTHl8/9ZfkWVusA637hjKic8I4cZs7dSF4H+neTg6vjSM2c1MmXAGx9ymr3LXf8nQi+YWhII3DzNGcJLhx2mlMMkg7DSZILEa9ypmL4MroB21G4zu6LSEZf7TSmKbhfvJjbVw4fAFbp9c2XUQapco3eQKIOpkVI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828392; c=relaxed/simple;
	bh=PGAr+LJEmMFIRYpY52dT0hChiVSybAqArtpF2GeY1jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXUOortS8Iehy9rf5cwDEhQZ1126JaZ4ueSikAoKUGF9sJUuInN7U9r+Cjx6u20+BnFIyuzPP4cx21z2RhmEIsNxkH8kSDKvk1CGKUKx5Ai1aaRz27O/A+6I0sgJfQ1s2pen7w/zmbVKo6HPRcbq+qDzvK9yU4XY8eWQNtA6EOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=sdBbiJyr; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/E75sGSrVhdcsTOLdjoZhA5gMYxGIzTgWx95/1byPA=;
	b=sdBbiJyrt0jRH8fPwdgBr5dJvLJW/9xy/3mzcxiXsVYj3Gc2NpJehao5UBCA/AelTEp49O
	ny/OgMsqjqpc05P92FK+mU9yaKMSteL+VfTVyWgT9AkGbgN4g0ec+8qduD2hlLVnKiPIhL
	vna+q24WW5nXME84s+4/mss7e+XfYPaa1tI/ZtO/I4HW6RM+13yK4VkcDpSpWY5ktSFSsR
	Ivlw13S8qeXA9VPr4y1filaTy8xGFWfO4tFTio2tFTK5M2oPdVPkRKpwe53kK9SBBf/FAJ
	HxNS/e0Hr379ezxynxdriGd0jUAia+ItxufgTTWkgnngiFSoPANqTd9YgjTGDA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Nora Schiffer <neocturne@universe-factory.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 06/15] batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()
Date: Tue, 30 Jun 2026 16:06:14 +0200
Message-ID: <20260630140623.88431-7-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303218-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:neocturne@universe-factory.net,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,narfation.org:email,vger.kernel.org:from_smtp,universe-factory.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54ECB6E54C6

From: Nora Schiffer <neocturne@universe-factory.net>

The only use of the label was too early for primary_if to be set
anyways.

Also move the put of primary_if further up to hold the reference only as
long as necessary, hopefully avoiding the need to re-introduce the goto
label with future code changes.

Signed-off-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 9b8108d464dbc..6fc49ad47fd87 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -835,14 +835,14 @@ int batadv_hardif_enable_interface(struct net_device *net_dev,
 void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 
 	ASSERT_RTNL();
 
 	batadv_hardif_deactivate_interface(hard_iface);
 
 	if (hard_iface->if_status != BATADV_IF_INACTIVE)
-		goto out;
+		return;
 
 	batadv_info(hard_iface->mesh_iface, "Removing interface: %s\n",
 		    hard_iface->net_dev->name);
@@ -857,6 +857,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 
 		batadv_hardif_put(new_if);
 	}
+	batadv_hardif_put(primary_if);
 
 	bat_priv->algo_ops->iface.disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_TO_BE_REMOVED;
@@ -874,9 +875,6 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 		batadv_gw_check_client_stop(bat_priv);
 
 	batadv_hardif_put(hard_iface);
-
-out:
-	batadv_hardif_put(primary_if);
 }
 
 /**
-- 
2.47.3



Return-Path: <netdev+bounces-289924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPQcGcmhDWq10QUAu9opvQ
	(envelope-from <netdev+bounces-289924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7B58D1B8
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31DE830A5BA4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889C3DC4A0;
	Wed, 20 May 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="WmlK1rmA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C123DC4C1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278094; cv=none; b=VOkENG3GTO+w594nKFbAgyhyDIzpoEmNxMJPWS5ekR038QH45tLPx107Ms8hqAsE8VZd7C159MSjaXb6Ymbr46780+Pu3Lgn+WjZebGriOCS8kCiAwULwidnWGSxJYDUFxp8OTNt4+KYIcxykrnvnzrv/TmJhbodGJqkeHwrjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278094; c=relaxed/simple;
	bh=p93uAh13v6U3h1/B2rQjokz9RIcGq6Fy5RFgUl9VKGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFGG0JBlFQufKGbkTnwgs+fgw9myAlcJSyggpSLab9tekVpHTH+TM8t+Da26pjvCr3iuUCbCWZtAIJI2r+xxq+YI75UgC9qZtpD6Ep+5Hd5rXqQWAE06QvJTPsVF0abO2WnRS63LDxrMX2U360sQfezV9SVnw/R9/MnLve8DfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=WmlK1rmA; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMSBQ8vty5KjvQRWobUPtXD4d+KsnwJfeTiOE5MDdw4=;
	b=WmlK1rmAnMvhqs2bx78u4Dhvw8v6D2tlP3X/UNXu8ET8l13eZFRWzc15kEtWCn4DBbLSt+
	1WsyNqT0r/f2rArZpvQR5Qgm81/wqApw0r4wDaWE5zM/nntmewaqID1Fs8WtFr8bLRm7mB
	/Iqv4JhvN812Hgsv7Q71+Q5rpWY3lK5prACqHcGc3Ht/YQTy4pgI6+PDPeUxtKapJzEGqG
	Fjp4SX/qjvRtFle3lRoxKodEz9pxSap472+m7Oeb7t6QQyk4OTeD7B7PIjXz73aMCbb4Eo
	Qa4ModJBAKQhwqmd3V/KUxLXyYj227y368mhn1zEXSQ+hwdByzy5pWqplhOfiw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 11/11] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
Date: Wed, 20 May 2026 13:54:22 +0200
Message-ID: <20260520115422.53552-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-289924-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9fdcc9f05a98a540b816];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,narfation.org:email,appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: CDA7B58D1B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sven Eckelmann <sven@narfation.org>

Without rtnl_lock held, a hardif might be retrieved as primary interface of
a meshif, but then (while operating on this interface) getting decoupled
from the mesh interface. In this case, the meshif still exists but the
pointer from the primary hardif to the meshif is set to NULL.

The mesh_iface must be checked first to be non-NULL before continuing to
send an ARP request using meshif.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 1bef12e659cb2..ffe854018bd3a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -356,12 +356,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	mesh_iface = primary_if->mesh_iface;
+	mesh_iface = READ_ONCE(primary_if->mesh_iface);
+	if (!mesh_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->mesh_iface,
+			 mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
-- 
2.47.3



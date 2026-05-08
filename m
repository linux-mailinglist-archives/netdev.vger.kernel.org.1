Return-Path: <netdev+bounces-285913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDbFLNAF/mnumAAAu9opvQ
	(envelope-from <netdev+bounces-285913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AEC4F8F95
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68715306DDA3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1E3FD122;
	Fri,  8 May 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="v/+GCSlx"
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85A3F23A3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255019; cv=none; b=nJ9orggTAdSeWsVpXpXSWQfIOkdsyLwy4ubNBo1x2DoX7EPRp7naIHDuhNOKDxnGwiCnzA2LlD/sdQ2oMP2jW/DczQs2J2NjZY733+9G+MnFYgvrJA74HMda2W+KHanf78Dqye2FQecE1VBDtlvMlQ9cCTIjQJh+FXeLKrNpBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255019; c=relaxed/simple;
	bh=g18DOxyTZtZ2JF9jGtFI09lwdjz82kuvR3W5ytMwUoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPRH4yA0aAr2SlO+mfrSl56JDATOBE2xJ56DexPf2topNf/u8MGdHficcvATad3M8pvv4W12FLCnbR0dTw3Amjt1Q0EvfrG1xGJiMhGTTkVK8Qfzo3+J9qlP7z9Zt8/YuaPFlcLIVWkPnQBeaIrtvj0/Dh2nfuRQXZWTiZp/RZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=v/+GCSlx; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKkYdkKDVA6gC80Vrr+hLi2juPjpTi5IVGhvcsqIlUU=;
	b=v/+GCSlxpizvDw965L+ZXXx+0bNpP5FzqyVAiNCADni4gXVh0xStkeJrCChaRphD2jIxPS
	fUiRhAaIDeOhSn8XqfULs5ENFRYxPMr1XMpzJv2XlFJYTjgD0660SXTvQn4SWV7J9C0lSk
	PcQpTz9hzRmeoiyUv4Kp6F4bg3k2Er//Ow59Cyd+2Svhb0LjtfEAwL8JTpUnYcVCQbYxTI
	RewF1G6z1ww5+L0v5YeZFHN+bioQBBje1O9Evo/NGKrDfXFdSAGvqrufpe77yGdf+I1VI+
	/ozebiq7NTjWSDsZnT2+vAj3ywb5+M+ryTjnrghoxyeWuaVBTUjPJFHklKWgpw==
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
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 7/8] batman-adv: bla: only purge non-released claims
Date: Fri,  8 May 2026 17:43:13 +0200
Message-ID: <20260508154314.12817-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55AEC4F8F95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285913-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,narfation.org:email]
X-Rspamd-Action: no action

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_purge_claims() goes through the list of claims, it is only
traversing the hash list with an rcu_read_lock(). Due to a potential
parallel batadv_claim_put(), it can happen that it encounters a claim which
was actually in the process of being released+freed by
batadv_claim_release(). In this case, backbone_gw is set to NULL before the
delayed RCU kfree is started. Calling batadv_bla_claim_get_backbone_gw() is
then no longer allowed because it would cause a NULL-ptr derefence.

To avoid this, only claims with a valid reference counter must be purged.
All others are already taken care of.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8b77dd2ecfa41..879ab043d57a9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1288,6 +1288,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr backbone_gw set because
+			 * they already went through batadv_claim_release()
+			 */
+			if (!kref_get_unless_zero(&claim->refcount))
+				continue;
+
 			backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 			if (now)
 				goto purge_now;
@@ -1313,6 +1320,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 					      claim->addr, claim->vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
+			batadv_claim_put(claim);
 		}
 		rcu_read_unlock();
 	}
-- 
2.47.3



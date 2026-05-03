Return-Path: <netdev+bounces-283599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFTKIaQ+92k2dwIAu9opvQ
	(envelope-from <netdev+bounces-283599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD254B5B94
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AF43028024
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C33B19C0;
	Sun,  3 May 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="annmE/JN"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC83081D7;
	Sun,  3 May 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811004; cv=none; b=pPHupyVt/lJmJ5T925XIX729myEW2X0+g5yLohw/FSWlyMC20TrnnFb2MRvm59Lm3/wHiYOv9McbArT/uFksqip4tZDdO+0IwpP3126so2DDoRU2WkxAlt6OtuYi//Dyx+rZreKqi+ipwY6fhwgq0xF+bY/Wj8RXUtjD/gRe3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811004; c=relaxed/simple;
	bh=SaBIHQebZmPSOsHqoC9WHlKONhBUR74hrhjtN1QSiSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCs2btHQfXNAdWg4Hw4oc9+LFNUpOBzNoIVlAkcVTk+M4IZreU9wGrV6uhrV4rQeJQHce6mX2TlGmDpVp5xvQdS3njx8wFppWZVpA9fAXRkkaKANvPWDQ4AAIC+RbOUQJndizUfgM9e9UHKO7tSp3WpCRBpQEbes5GBz+CNPwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=annmE/JN; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id DE3C5218AF;
	Sun, 03 May 2026 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZMsjjixoBsE2+ugudq2Uz5c0QObLk7hKXWMZ1j7bG0=;
	b=annmE/JN1gSr0LcIWCVd72EKrO3mhWspBzsWeq8fEoAkUxKEUNYC6HbyKm3BTBNASbVvnp
	bUy/jDsDogRFZHFOmwd9aRW/YqKU2YXE1sSKOxafOKJQ3lDq+mkbG1dffytbE3b2fHaVMN
	fS4XNk4kIw00maLf5QX6CMg/oE0lAtA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:36 +0200
Subject: [PATCH batadv 3/8] batman-adv: bla: only purge non-released claims
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-3-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=sven@narfation.org;
 h=from:subject:message-id; bh=SaBIHQebZmPSOsHqoC9WHlKONhBUR74hrhjtN1QSiSA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WTvJMe73+q9vDu5eP2c/x/nr+D5tFPbZ8EeoTvqv
 5pCS8PlO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATObSV4b9L1FbJaWHCGxrz
 okSSd+8XnuR/8JK90XTmrrehOzVNTy9kZJhS/9JlnpXOpOrWTQ9Wn+5XuR+0evX8cGGetBkWT+Z
 NimIAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: DFD254B5B94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,lzu.edu.cn,gmail.com,narfation.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,narfation.org:dkim,narfation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8b77dd2ecfa4..9dbf945b4922 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1288,6 +1288,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr* backbone_gw set because
+			 * they already went through batadv_handle_unclaim()
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



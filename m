Return-Path: <netdev+bounces-283597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMm/Lzc+92k2dwIAu9opvQ
	(envelope-from <netdev+bounces-283597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:23:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2824B5B3B
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38773004C2F
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9E3B19D8;
	Sun,  3 May 2026 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="DXqGjAM8"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F063AE6FA;
	Sun,  3 May 2026 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810997; cv=none; b=ssEGBTIvDOJ706mUSJq2gXK6GCaxUmgHTxgpZ+uS55Gqce9xIOExprNoXlSXmBW7jCjgGbKsGAUZEJeeiCla3e6cRfpglkepHswHSOjjD14KWTED+W7ClG+UUaJ1h5cPu0fZ835U0Ni9+j1EVD7iTV5J7rVfXP1INJjKXIx/Lok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810997; c=relaxed/simple;
	bh=y3CLfUvdtFr/SVbGgj6OpkFHV0+uLxKRC+dYOR1+iy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUYTqfP56mFwYtGbJc43voZYkN/bMGKcCHa5f3VlpCIsJbT/D/jj9qiNNsdTd6xiNDMkDll/h/p4za1OmhuPCbhTWCQTSbC2TIbr/ybcNTK+5NEmYoIGoIB4xtkU9w5SZGTiF8BZmiA2RUR9XYujwYirfhozbj0tRTNyG7vfSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=DXqGjAM8; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id CC9761FF1D;
	Sun, 03 May 2026 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y82pMc95b72vf7aTpAvphzIev+8YN2RLW8o9k4UIYKs=;
	b=DXqGjAM8z0h1bwQnGQNcCLZ33/eaku8CFDYL5nKpyxxqbYiOhJMtLb8/jV1cVMXfTteORj
	aCezlvA8//kf5td9UG1bUzNzLop+4eGv97twkIt4XYGIF85yXowQe5wPpxBSc54GOAE3JY
	H7hl2D70DYyMXlRJuIRKxTTYqVSjdgI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:34 +0200
Subject: [PATCH batadv 1/8] batman-adv: tp_meter: fix tp_num leak on
 kmalloc failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-1-4313278918d3@narfation.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=sven@narfation.org;
 h=from:subject:message-id; bh=y3CLfUvdtFr/SVbGgj6OpkFHV0+uLxKRC+dYOR1+iy8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WTW/rpkaPqv78Teg5Feqkn5LVoTC4xLlc2/3lRN5
 0tQadXqKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAEwk5zsjQ/eeRYJz5zack/Xs
 dfm4X/RPtPQvI7anXAEHJq9v6llSKcrI8KPzZMPGCN6TpnVazT4y+VECTGECp3f79+eJfBO83/i
 CFwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: 3D2824B5B3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283597-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When batadv_tp_start() or batadv_tp_init_recv() fail to allocate a new
tp_vars object, the previously incremented bat_priv->tp_num counter is
never decremented. This causes tp_num to drift upward on each allocation
failure. Since only BATADV_TP_MAX_NUM sessions can be started and the count
is never reduced for these failed allocations, it causes to an exhaustion
of throughput meter sessions. In worst case, no new throughput meter
session can be started until the mesh interface is removed.

The error handling must decrement tp_num releasing the lock and aborting
the creation of an throughput meter session

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 58ca59a2799e..066c76113fc4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -994,6 +994,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1366,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;

-- 
2.47.3



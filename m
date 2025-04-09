Return-Path: <netdev+bounces-180623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D1A81E5A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4C3189CC3A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BEA1DE3A5;
	Wed,  9 Apr 2025 07:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535D1D6DBC
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183998; cv=none; b=ai8qB6uzspg3/MdDI6slpfRO7eW+AowB0vfFqjx2cSZzxts+3+xh+kz7Qi7Q/o9gILjoOF5I5Fjsxx2uS+sUpF9k0vf9hQd1F+xsoFEWqieXbvJ5eSG/KCkRV5EJ7OObbVN5CvskGWNiKkh8aIEWxtxFkWlItDDA2BnT5Z/FS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183998; c=relaxed/simple;
	bh=jTqGxaPwV8nekMCJlfr4pUb1YP4PNb0hsd2zh0pwJa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHNcLduWJ9u/cpb9WQp9PMA8PTMzkSMjAvMBxTY5bowaVtwCIN1+XanE0Sf/ebXgcIGG+N1s2ONLvMTMaTULgMdj4NxPg5Gf0iXrp2sZvpWA/C6KfwcCW33FAjUH220nl4wXCgiFw4leDgoimdeNhJoS2PuabO8cILhk4GyyWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=narfation.org; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net v2] batman-adv: Fix double-hold of meshif when getting enabled
Date: Wed,  9 Apr 2025 09:33:04 +0200
Message-Id: <20250409073304.556841-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in this place and thus there was an imbalance when trying to
remove the interfaces.

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f9662653..7cd4bdcee439 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);
-- 
2.39.5



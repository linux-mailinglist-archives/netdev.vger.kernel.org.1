Return-Path: <netdev+bounces-181397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C05A84C87
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF394C2839
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8828CF63;
	Thu, 10 Apr 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="USdCPw8h"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B31EFF9F;
	Thu, 10 Apr 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311599; cv=none; b=ruWDKTBaMDHmAYdd9K2Dpkq0XnQ8SxXQJXBQfsicxJHmSs5gGwGD05HppWvKVmK1zQntBJPfCIp5bqoqEz79tdVppzTaydIlUqDSJNZDtD4pKZFDd+ZJJ4O9RsIpGn94+6R6SCfr9mr1x2G+wOa4qV9GFO5PJpU/XcKmv4Eyz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311599; c=relaxed/simple;
	bh=FOhVsMUz8Lp5Kj9QrzKl6yXio9mXHudXG/T2oelAxWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIx5n97NfhNWXRggkkCiCHTSoeODl9jYBb1zhLLeoRF4tFEbLrS1miasi4wO2wSXMu3d2gRYWxFr9p5vfmjO21+BbhEHe2jltuBizIuNxe1dvI3l8oTdBl/YQdyoJXp8V9QAueDWfAlvhuWcH57bvzaSt2gqpeqQqosbxXdF0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=USdCPw8h; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: from sven-desktop.home.narfation.org (unknown [IPv6:2a00:1ca0:1d86:99fc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 91E7B20380;
	Thu, 10 Apr 2025 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744311594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1vg3rWY75JJY4ec4wQ7CE1NNZAlolqmH7TapGgVLLek=;
	b=USdCPw8hpaRcxdIOlovRYyIzmOqZPsFMzPu/Tw1qIg4OUX23hh9CsEgfsxPgjPw4VFhaPw
	6J7R45X67/7oEu9Gntkx8ShV1wntamz5OsTq46V+JRDU5Lt+gLbSfpgaSzo2yMDzpsaRo1
	iIg8bwuSDeoGDF68IYcK8DHY8y7M/+Q=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Apr 2025 20:58:51 +0200
Subject: [PATCH net v4] batman-adv: Fix double-hold of meshif when getting
 enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org>
X-B4-Tracking: v=1; b=H4sIAOoU+GcC/02OQQrCMBBFr1Jm7ZQ0NiR15T1ESjSTNlCTMolFK
 L27wZXL9+A//g6ZOFCGS7MD0xZySLFCf2rgOds4EQZXGaSQSvSdQJfej4XGOS1u9OGDxgtrtNf
 SugHqamWq+le8QaQC9yo9pxeWmcn+xcQg9FnJvlVKd2bADvNG8Rote1vqjTbxBMfxBf5BhvmjA
 AAA
X-Change-ID: 20250410-double_hold_fix-8f0a87f72ad9
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=sven@narfation.org;
 h=from:subject:message-id; bh=FOhVsMUz8Lp5Kj9QrzKl6yXio9mXHudXG/T2oelAxWQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOk/RJV7pnUb7ouxVF6S+17MQnpvT6pe1Z8ZztekdY9wn
 FtaYejVUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIEB8jwyrPELWXZ6QWCV6W
 T2nfJLzpgHHeS26JzNe7GXU5VF91ijD8Zpt1Y3X/waKc+T/0P9WYPl6xf1GQDsd5BbtzrycumLL
 bkh8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in batadv_hardif_enable_interface(). As result, there was an
imbalance and a hang when trying to remove the mesh-interface with
(previously) active hard-interfaces:

  unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is skipping Simon's normal PR submission to get this problem
fixed faster in Linus' tree. This currently creates quite a lot of wrong
bisect results for syzkaller and it would be better to have this fixed
sooner than later.
---
Changes in v4:
- added Suggested-by: Eric Dumazet <edumazet@google.com>
- added Reported-by: of various syzkaller reports which were affected (during
  bisecting) by this problem
- resubmission after 24h cooldown time
- added kernel message during hang to commit message
- Link to v3: https://lore.kernel.org/r/20250409073524.557189-1-sven@narfation.org
Changes in v3:
- fix submitter address
- Link to v2: https://lore.kernel.org/r/20250409073304.556841-1-sw@simonwunderlich.de
Changes in v2:
- add missing commit message
- Link to v1: https://lore.kernel.org/r/20250409073000.556263-1-sven@narfation.org
---
 net/batman-adv/hard-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index f145f96626531053bbf8f58a31f28f625a9d80f9..7cd4bdcee43935b9e5fb7d1696430909b7af67b4 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -725,7 +725,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	kref_get(&hard_iface->refcount);
 
-	dev_hold(mesh_iface);
 	netdev_hold(mesh_iface, &hard_iface->meshif_dev_tracker, GFP_ATOMIC);
 	hard_iface->mesh_iface = mesh_iface;
 	bat_priv = netdev_priv(hard_iface->mesh_iface);

---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250410-double_hold_fix-8f0a87f72ad9

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>



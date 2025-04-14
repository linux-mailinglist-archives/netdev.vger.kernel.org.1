Return-Path: <netdev+bounces-182397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27BAA88AB0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DA87A8358
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0E28A1FB;
	Mon, 14 Apr 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="vSMFu7i0"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D0280A4D;
	Mon, 14 Apr 2025 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653965; cv=none; b=nlgN/nWa/N091xetyvUsoXi/Tsb0KCtZdQJ3hEWF200nyl9jb75Wi0q1LewOKPEelOjLMXI3gKUBmtAxZ+3r7SzzBl7cA+GLLqcOHuM5fKCO1yLxEwrpQ8oaVgi0QqWWOyUR0RCnnRrlakjHQoO1LKg0LnG4zry2whpDQcEp3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653965; c=relaxed/simple;
	bh=Bf2kK2Vw4Tc37/Kz4l3ukL8jF1/nrr/RnuXgsQDbdLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eDJWnRYpctJnkmoQNSwZyGv0iYS888xUx2Y7LZpIyayLANsBSvIXcv656OGq4OcX0E2j8r15bSBr9bEP0EjnBXEuiYomXNHaWn3G4EVWtsYd11AUF7QEkY4b1coJhF0KnUtGszInjW3Z5wBKecH2UDFsDl0wj4/rvjVSIwjlUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=vSMFu7i0; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: from sven-desktop.home.narfation.org (unknown [IPv6:2a00:1ca0:1d86:99fc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 255F2202C6;
	Mon, 14 Apr 2025 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744653953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EOcHNaKvVT/0mARZxcxaig61vSP0GsRncJz7Dz1LbTQ=;
	b=vSMFu7i02yBYutbzGc4yaiiv848nkAprKsfWC59Cm0HKIA6pep/onmXU+uxnVS2Ki16pMs
	Hu1zg6PYkolTC/JkAezLlNPSuolL8+I9VKBl6B9phFqiCc5JAGgiHVOGaZzxg4cj0ylOyw
	tfIiAzFkwhcpfqToOu7NcFI9ZM0l6j0=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Apr 2025 20:05:37 +0200
Subject: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting
 enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHFO/WcC/3XO0QrCIBgF4FcZXudwpnPrqveIMWz+TmFpqEkx9
 u7ZriLo8hw4H2dFEYKFiE7VigJkG613JfBDhSYj3QzYqpIRJZQT1hCs/OO6wGj8okZtn7jTRHZ
 CCypVj8rqHqDUu3hBDhIaSqmDv+FkAsgvjPREHDllNeei6Xrc4JjBnZ0MWqZyo/Zh/ojGxuTDa
 7+Y2e7+fZNZYahuSauhmyhhP9ywbdsbojOGnfQAAAA=
X-Change-ID: 20250410-double_hold_fix-8f0a87f72ad9
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com, 
 syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com, 
 syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com, 
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com, 
 syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com, 
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668; i=sven@narfation.org;
 h=from:subject:message-id; bh=Bf2kK2Vw4Tc37/Kz4l3ukL8jF1/nrr/RnuXgsQDbdLs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOl//apd1TRu/bi/dqudDOvvmMppzPUSNf1VsTduprE3h
 7Kcyz3TUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIQCvDX7FNwhP/1qwsSJNa
 W1/2Omxx+KslTe4d2w4mNhzw2M6w8BjDX/EHS6N6JzV9XJnaGp7y8rLpsj11/PMKbpRkctif9eD
 pZgIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

It was originally meant to replace the dev_hold with netdev_hold. But this
was missed in batadv_hardif_enable_interface(). As result, there was an
imbalance and a hang when trying to remove the mesh-interface with
(previously) active hard-interfaces:

  unregister_netdevice: waiting for batadv0 to become free. Usage count = 3

Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com
Reported-by: syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com
Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Reported-by: syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is skipping Simon's normal PR submission to get this problem
fixed faster in Linus' tree. This currently creates quite a lot of wrong
bisect results for syzkaller and it would be better to have this fixed
sooner than later.
---
Changes in v5:
- added Suggested-by: Eric Dumazet <edumazet@google.com>
- added Reported-by: of various syzkaller reports which were affected (during
  bisecting) by this problem
- Link to v4: https://lore.kernel.org/r/20250410-double_hold_fix-v4-1-2f606fe8c204@narfation.org

Changes in v4:
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



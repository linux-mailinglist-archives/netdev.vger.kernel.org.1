Return-Path: <netdev+bounces-112122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FA935215
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC01C2169B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789D145348;
	Thu, 18 Jul 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="barPSbsd"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C26144D3B
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330434; cv=none; b=YfLNR4zSOdQfrEY2ce+czefqIW/9uQ0Cy6yhbEqBJY0jFuTViBsl69SZZx0U4oVxjQZJHcR2ElkRwne2BTUahY01L++xxUIzWoS6m3qPvB3FE5h5PxPTL23C+p/VzfremkyO6uvhqwlRVpfNmL+wZN6N267R6cbQ2R6sRxIe+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330434; c=relaxed/simple;
	bh=FHg5jkF0WmpAMwAZ7Zp4f2g86gaKY2iBhFAZ3r54W5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9LM+ORkQUURbeuvEDNQfdk3BGxb62WLCmiRjUiNKAsyj8a3Xvu/f3I7QG2tj4JyhsABXxAUpD9fWak29jrqvxIPmopZUKJoX04CAYUfQQ9ohCV+EJolFe/Izq2yL8BUKEAcoIQXKx0fvkcExzKku00USu9HRHbI6pHu+5pcTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=barPSbsd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=43rn6dlHtU7x5UlCAY2hiDYDE4/LG/qewXYFMSF9APU=; t=1721330432; x=1722540032; 
	b=barPSbsdu2DVPmD1ahEJitAacxmLrCHz84WV/e58PVQgjvZGGfAxbdV8sXm/GQP0Eyl23GDulZv
	caXlAY2euEcc6IvCXHucN5sM/e0bUHFz4THThuFF3PTqSfYRD+sAeVVi/3/gqVRrD7OwR5qcn9V8C
	WryLVQxl1mBwmNs1QKwr/bZYh9SlQElfN0iLF0GfLB4U7mm0B62dkTV7WjBD2zlQETMRNA0CaU4CE
	UUSv4AfYRlJ0huZNtFHhr2MaOSeYt4iXdsXWtGb7kkxhgDmXm3T5rXcTQGVoNeA6qPTMU4AmPAddY
	5ewZ1qqJS8lUhxjkkmR6gE3nI0WsAVJo19Kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUWfx-00000001wv4-3LfF;
	Thu, 18 Jul 2024 21:20:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/2] net: bonding: correctly annotate RCU in bond_should_notify_peers()
Date: Thu, 18 Jul 2024 12:20:16 -0700
Message-ID: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

RCU use in bond_should_notify_peers() looks wrong, since it does
rcu_dereference(), leaves the critical section, and uses the
pointer after that.

Luckily, it's called either inside a nested RCU critical section
or with the RTNL held.

Annotate it with rcu_dereference_rtnl() instead, and remove the
inner RCU critical section.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/bonding/bond_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d19aabf5d4fb..2ed0da068490 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1121,13 +1121,10 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
 	return bestslave;
 }
 
+/* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct slave *slave;
-
-	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	rcu_read_unlock();
+	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
 
 	if (!slave || !bond->send_peer_notif ||
 	    bond->send_peer_notif %
-- 
2.45.2



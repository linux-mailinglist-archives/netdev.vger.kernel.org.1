Return-Path: <netdev+bounces-112251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB2937B30
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 18:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAB51F21A07
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB34145FF4;
	Fri, 19 Jul 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f5Xlm/k4"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97241B86D9
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407292; cv=none; b=BCPvpcRrmkwOgfcPPEit3MjplxmagMm4bi5i3xInXox9Eq8QZ4OxCPEr1OzN/rtaU6P/JFE6Vn+QFzuVGTxsgCiAOXhO4CqA+W4EYHQkNlPkSpSjEMHm4L/GgVt5YLIEdnQjBY2ojHsWvhyL8qASrGUt5VBv2pepE2ywMDrWZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407292; c=relaxed/simple;
	bh=gVzlquc7yqsllfmVK8HfvNyX4tRueHA8YKXVQO57PWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVDJRV83azf+KJBB8AKWHOT3ng3RMes8dWv1wHbGh8G5PCx8g2XqgVoxYRYDY+0+RInK3c+TePOfYXoeYW2fq+rUx92bXWUGxIFfo572ayj1cQCMgv/KVuXTYJEwEiaeiYyzD5V6h6N2PxL0fsz6tEjevk7T0CkFVrreukrSSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f5Xlm/k4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ommmEuRA9XNndHoQVhGCbrBL/ZUe6zM2AR0ErdyGE9k=; t=1721407290; x=1722616890; 
	b=f5Xlm/k4iTvjI4x/l3KG1yiQfv7yyyUI5lTAkAmccMro2vUob1rR0psJEZqVhijvXN00KfdUCZk
	DeDFXFTPRxVnksrjdFe89FcR9PtSimqm6DWkrQf8i+LSBB2SkS2usbRJSyN9ny0kahxHgtE9i+hAC
	pogGzTm/flMwRZ13+8wZMedyfjqfOShTSh+zAxuaUmxutdy8B+DAI+hltPCMgz8zefSiHoxsMmSDF
	2fMm9YO6oe6wIleLMP6iTe8WjU9oZQlJlLyrNmQwgNkoqlO63gKs5D5d/jXPyeQo3Mb65VzKxVFIV
	ouNiKnrCyy8zpMUYRhlM5R9Q2E3tdUZUnhVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUqff-000000042SP-0M7s;
	Fri, 19 Jul 2024 18:41:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next] net: bonding: correctly annotate RCU in bond_should_notify_peers()
Date: Fri, 19 Jul 2024 09:41:18 -0700
Message-ID: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
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

Fixes: 4cb4f97b7e36 ("bonding: rebuild the lock use for bond_mii_monitor()")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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



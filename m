Return-Path: <netdev+bounces-54497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858578074D2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADE31F2112D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EE46558;
	Wed,  6 Dec 2023 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NacfPxEs"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919312F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=iK7M+ghmwzgB++t5LQX5y/beLqJXnKTdLCVNYj9kq2w=; t=1701879687; x=1703089287; 
	b=NacfPxEsG+UMIOOZESPv4w3QkkLe0dHeEaD1jftWuIpm8tFKC6RaycBzvtae3NeX/O3Iydac+Mb
	Qgq/m1vdHQ0pS2CV4m7Z/GvB1sF8ECVCOaw0SHjv4uwP1GkZ/uL/OHyJWF1U+Y7X7CIElpji4lUUG
	heUIpH2qUrx7wdz46ZP2LeAga4PtR2Fi1n/imK4vxt7+ZTs2g52d8H9g1S9Tc9ROjCVQIxyjlu170
	6zFywmSMif5xO4BfcbPnlZcmTKzJbLtBljpZZfIyuI5l0tMMRIWLLg9IgKi6QBtF78uz5nyT4C/Kq
	ABO9R5XQsbSn/6y/pPNXVI+OLYsmopDfGHBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAueK-000000009ol-02Tr;
	Wed, 06 Dec 2023 17:21:24 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next] net: sysfs: fix locking in carrier read
Date: Wed,  6 Dec 2023 17:21:23 +0100
Message-ID: <20231206172122.859df6ba937f.I9c80608bcfbab171943ff4942b52dbd5e97fe06e@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

My previous patch added a call to linkwatch_sync_dev(),
but that of course needs to be called under RTNL, which
I missed earlier, but now saw RCU warnings from.

Fix that by acquiring the RTNL in a similar fashion to
how other files do it here.

Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/core/net-sysfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index d9b33e923b18..a09d507c5b03 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -193,6 +193,10 @@ static ssize_t carrier_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	int ret = -EINVAL;
+
+	if (!rtnl_trylock())
+		return restart_syscall();
 
 	if (netif_running(netdev)) {
 		/* Synchronize carrier state with link watch,
@@ -200,10 +204,11 @@ static ssize_t carrier_show(struct device *dev,
 		 */
 		linkwatch_sync_dev(netdev);
 
-		return sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netdev));
+		ret = sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netdev));
 	}
+	rtnl_unlock();
 
-	return -EINVAL;
+	return ret;
 }
 static DEVICE_ATTR_RW(carrier);
 
-- 
2.43.0



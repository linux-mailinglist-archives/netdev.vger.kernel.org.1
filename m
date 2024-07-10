Return-Path: <netdev+bounces-110619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7B92D7A9
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E7C1F218B2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B45C1991A3;
	Wed, 10 Jul 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAZF7qov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0961990DB
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633253; cv=none; b=HtAqzv1rHShoSsTYdw3xdSdRY6O/GqOZRrzoT+OSlPgI+LPTvIJXSEOmTkQ36PA0xgMzubL8aKVUsapWI+bJHtw4lHjN14EKaFFD74OE+pd/SZYjEkLlBR9NsKYZxlgZxP5X9e1GWUxIYi5F6Vm0n4HAAjK6mZTMtyDz2sYVAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633253; c=relaxed/simple;
	bh=FByotsB4EhGv7jO3iVkaOrq+d4ZysbVGS/Vb/0xFNfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z00rK6yQkXgIV0fFNKPoDDbIo9todigoQNn+UI/qBuU5XErg3Oj3BrUDpUPVp6bq5LtKPf+7e3PSGmnGy1Nt6BXfF7td8leK9RKHqWbd2tGTnPDYWxZezeljHBiWvk9HKWVPFLmPWnuQpDk1afYgrmHYcl6rmAx7RMimrwO481A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAZF7qov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C515C4AF0A;
	Wed, 10 Jul 2024 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720633252;
	bh=FByotsB4EhGv7jO3iVkaOrq+d4ZysbVGS/Vb/0xFNfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAZF7qovA7qvWxEDo7y1JdI0ZNAO7VbAKahrvBVNNz5zPHfhXOURM+HXp1/iQ9vw2
	 tdQnQZsDTgINwI8I2J2GsYKv6gHxjdyfDoPKhN8AQ2LRC0UjyFTYfqN8G2uNhFizW0
	 BvAqPDytRk1clrgNA/QxX3OMyM0NGmwXIO8qgkVyRD28ommTJ+Q+JvxRopiVHnzaPx
	 Zmv3MFgDYACQn9Mc4qEblGR+PK60jfURD/sIJhpJW4PwzxDrRlbiRYh8An3kttOb3S
	 QYlt7QBga8+Sje/Q8K5W3YCjRBT/ct76XQ+ivQlPOO+/c5AWFr+kKlTK1ao77nLzz8
	 pDaI1oTEYPraQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] ethtool: use the rss context XArray in ring deactivation safety-check
Date: Wed, 10 Jul 2024 10:40:43 -0700
Message-ID: <20240710174043.754664-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710174043.754664-1-kuba@kernel.org>
References: <20240710174043.754664-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool_get_max_rxfh_channel() gets called when user requests
deactivating Rx channels. Check the additional RSS contexts, too.

While we do track whether RSS context has an indirection
table explicitly set by the user, no driver looks at that bit.
Assume drivers won't auto-regenerate the additional tables,
to be safe.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/common.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 8a62375ebd1f..7bda9600efcf 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -587,21 +587,47 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 	return err;
 }
 
+static u32 ethtool_get_max_rss_ctx_channel(struct net_device *dev)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+	u32 max_ring = 0;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		u32 i, *tbl;
+
+		tbl = ethtool_rxfh_context_indir(ctx);
+		for (i = 0; i < ctx->indir_size; i++)
+			max_ring = max(max_ring, tbl[i]);
+	}
+	mutex_unlock(&dev->ethtool->rss_lock);
+
+	return max_ring;
+}
+
 u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 {
 	struct ethtool_rxfh_param rxfh = {};
 	u32 dev_size, current_max;
 	int ret;
 
+	/* While we do track whether RSS context has an indirection
+	 * table explicitly set by the user, no driver looks at that bit.
+	 * Assume drivers won't auto-regenerate the additional tables,
+	 * to be safe.
+	 */
+	current_max = ethtool_get_max_rss_ctx_channel(dev);
+
 	if (!netif_is_rxfh_configured(dev))
-		return 0;
+		return current_max;
 
 	if (!dev->ethtool_ops->get_rxfh_indir_size ||
 	    !dev->ethtool_ops->get_rxfh)
-		return 0;
+		return current_max;
 	dev_size = dev->ethtool_ops->get_rxfh_indir_size(dev);
 	if (dev_size == 0)
-		return 0;
+		return current_max;
 
 	rxfh.indir = kcalloc(dev_size, sizeof(rxfh.indir[0]), GFP_USER);
 	if (!rxfh.indir)
@@ -613,7 +639,6 @@ u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 		goto out_free;
 	}
 
-	current_max = 0;
 	while (dev_size--)
 		current_max = max(current_max, rxfh.indir[dev_size]);
 
-- 
2.45.2



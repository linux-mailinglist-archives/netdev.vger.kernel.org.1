Return-Path: <netdev+bounces-201675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAEAEA839
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33190561CDA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C092EF66D;
	Thu, 26 Jun 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1ZLttOk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441F2EF646
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969731; cv=none; b=dXuZoB7/Neo740NIraETcY4oLgEf3J+TTsaSvcRQqgZesyZPxTpXycQG5qUPUZbifaI7hLmzp4kQJ/3I7U5pPHsrocX2XAUEN/5WXWenJGtp8sXLb+mWzn5Sb9QV4Okb6wSgZb0if1TDnOSvlA5TRYXuY3+wumOjSjsENLRMxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969731; c=relaxed/simple;
	bh=PUL0Ro8DIAK9R303aqNDeCrBxfCVEJtaEUeC8fyu6cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvKgdoHCjbt4AtQ4z+MCMF2Q5Cdyp0H731GX7xJCJfa22pvIOKB+2yuctWfc6ekCU5ZaFpQs4qNgiyLhZdpUM3LKRFgRU8lho6nZUE/Bpu5e5q9CjNr8hSoH1AN2MCzP6cDz0nqrPI6bNcupGe3rfDxgbNzTglhEo2tqqr8189U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1ZLttOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5323C4CEF0;
	Thu, 26 Jun 2025 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750969731;
	bh=PUL0Ro8DIAK9R303aqNDeCrBxfCVEJtaEUeC8fyu6cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1ZLttOkDMpnplG1rJ8ZGGcpVI9FLwPn7A9vQDBBPbPB7+BMfRosM4u117DsXyXsa
	 cI5mQ4Xf05Frf7r67e7YG8a7imGY3quW9k1u6oIuUcVSRl3wgsg71QTuBmlGN+XgeW
	 vr9Jlz4KXIZidonsmRSUBZMcG4nB0q2YUFLrQdBvb7cj8QVJdI7q1sxG1pGdgZ59xy
	 cQ6cS4cSwewgfQFJlSTxu4NDQ/wsVZi/i6ibkhuoBdev6gUTVpgHOVlYVBrjQOkB36
	 rsiSMXwmvPx7+ZTpIFvQQyJr7fa7tewgVT9tb9LO8tVx6AqiMUvgufbu0vYjnZxcth
	 PSYAjESPgn5IQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] net: ethtool: move rxfh_fields callbacks under the rss_lock
Date: Thu, 26 Jun 2025 13:28:47 -0700
Message-ID: <20250626202848.104457-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250626202848.104457-1-kuba@kernel.org>
References: <20250626202848.104457-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink code will want to perform the RSS_SET operation atomically
under the rss_lock. sfc wants to hold the rss_lock in rxfh_fields_get,
which makes that difficult. Lets move the locking up to the core
so that for all driver-facing callbacks rss_lock is taken consistently
by the core.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/sfc/ethtool_common.c |  9 ++-------
 net/ethtool/ioctl.c                       | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 823263969f92..fa303e171d98 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -810,13 +810,10 @@ int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
 
 	ctx = &efx->rss_context.priv;
 
-	mutex_lock(&net_dev->ethtool->rss_lock);
 	if (info->rss_context) {
 		ctx = efx_find_rss_context_entry(efx, info->rss_context);
-		if (!ctx) {
-			rc = -ENOENT;
-			goto out_unlock;
-		}
+		if (!ctx)
+			return -ENOENT;
 	}
 
 	data = 0;
@@ -850,8 +847,6 @@ int efx_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	}
 out_setdata_unlock:
 	info->data = data;
-out_unlock:
-	mutex_unlock(&net_dev->ethtool->rss_lock);
 	return rc;
 }
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ce7d720b3c79..df376628ba19 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1096,7 +1096,10 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (info.flow_type & FLOW_RSS)
 		fields.rss_context = info.rss_context;
 
-	return ops->set_rxfh_fields(dev, &fields, NULL);
+	mutex_lock(&dev->ethtool->rss_lock);
+	rc = ops->set_rxfh_fields(dev, &fields, NULL);
+	mutex_unlock(&dev->ethtool->rss_lock);
+	return rc;
 }
 
 static noinline_for_stack int
@@ -1123,7 +1126,9 @@ ethtool_get_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	if (info.flow_type & FLOW_RSS)
 		fields.rss_context = info.rss_context;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	ret = ops->get_rxfh_fields(dev, &fields);
+	mutex_unlock(&dev->ethtool->rss_lock);
 	if (ret < 0)
 		return ret;
 
@@ -1553,10 +1558,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
 		return -EINVAL;
 
-	ret = ethtool_check_flow_types(dev, rxfh.input_xfrm);
-	if (ret)
-		return ret;
-
 	indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
 
 	/* Check settings which may be global rather than per RSS-context */
@@ -1617,6 +1618,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	mutex_lock(&dev->ethtool->rss_lock);
 
+	ret = ethtool_check_flow_types(dev, rxfh.input_xfrm);
+	if (ret)
+		goto out_unlock;
+
 	if (rxfh.rss_context && rxfh_dev.rss_delete) {
 		ret = ethtool_check_rss_ctx_busy(dev, rxfh.rss_context);
 		if (ret)
-- 
2.50.0



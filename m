Return-Path: <netdev+bounces-201674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19708AEA838
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E740561C4C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443A2E7642;
	Thu, 26 Jun 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqEtAZPQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED9E27510C
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969731; cv=none; b=cy4XqTvtdAyEwXPb4+b4aFCZMDLocuKpPysohG97JiL2POLsVBNAylxSZ5T4SDfRRkQi4DN7jaaTNCTqhBOP19hpuXIPwlI4rh9OpOtbin8o5b7QYSIoYExZxaKXyN/DL6m1dg0T6Nl78wBy4J8T/xBvnqP9W+hoGHaABvTLgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969731; c=relaxed/simple;
	bh=5rVuJmwCQvO8juQ177BrTytRAtDP8HVL97WR0Ybvj68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6ItMh8CZUbWcLvMbygUt8MBQ+4hIWxxQCg5+y0pXX2HKac3RexmchCPEbBzIGkcySFXEPqIGHFxzZbkTsA5SGFSJsgvj9pSeiUhBv+4esD/ixcwmIaN15rtRixHsTWppgHstYwJfNtxPPPoWRuPlxB9upM2vd1BW84Z4aCYbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqEtAZPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F87C4CEEF;
	Thu, 26 Jun 2025 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750969730;
	bh=5rVuJmwCQvO8juQ177BrTytRAtDP8HVL97WR0Ybvj68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqEtAZPQetyS7nuX36IZ8eJzcCkbYekZ917m2cmzPh+yllwMJVUuI8mwtpQQxov2b
	 NR76nYizVaj6ygVVEoEh40Rjd9jYec6vFoupt+Ht/wXMLLoJVR2uQZK1PttCBa6wIm
	 gFMgd9awsbmhE3qBN4i3AB6DXwkAQ2nmadSZ2Gm0xzlJivkHLrGZD/qrnDpZFdb6aS
	 Y5S7sv9rJVu2S+t+ewp8QBiD7qTPQARTDpMTGj3pSCwfBcnjqy6Ym+tzfNGXXDBwgi
	 OCBh+1nbztk0pv/ydTgxYao1W8eiuKJG2+IXoWFFTAeVvYgwZnyMIvnd+VUGEVVlvO
	 PE/Wn78zvoiYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] net: ethtool: take rss_lock for all rxfh changes
Date: Thu, 26 Jun 2025 13:28:46 -0700
Message-ID: <20250626202848.104457-2-kuba@kernel.org>
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

Always take the rss_lock in ethtool_set_rxfh(). We will want to
make a similar change in ethtool_set_rxfh_fields() and some
drivers lock that callback regardless of rss context ID being set.
Having some callbacks locked unconditionally and some only if
context ID is set would be very confusing.

ethtool handling is under rtnl_lock, so rss_lock is very unlikely
to ever be congested.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index c34bac7bffd8..ce7d720b3c79 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1334,9 +1334,11 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	}
 
 	rxfh_dev.hfunc = ETH_RSS_HASH_NO_CHANGE;
+
+	mutex_lock(&dev->ethtool->rss_lock);
 	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	if (ret)
-		goto out;
+		goto out_unlock;
 
 	/* indicate whether rxfh was set to default */
 	if (user_size == 0)
@@ -1344,6 +1346,8 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	else
 		dev->priv_flags |= IFF_RXFH_CONFIGURED;
 
+out_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
 out:
 	kfree(rxfh_dev.indir);
 	return ret;
@@ -1500,7 +1504,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct netlink_ext_ack *extack = NULL;
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
-	bool locked = false; /* dev->ethtool->rss_lock taken */
 	bool create = false;
 	bool mod = false;
 	u8 *rss_config;
@@ -1570,7 +1573,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rx_rings.cmd = ETHTOOL_GRXRINGS;
 	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
 	if (ret)
-		goto out;
+		goto out_free;
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1586,7 +1589,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 						  &rx_rings,
 						  rxfh.indir_size);
 		if (ret)
-			goto out;
+			goto out_free;
 	} else if (rxfh.indir_size == 0) {
 		if (rxfh.rss_context == 0) {
 			u32 *indir;
@@ -1608,30 +1611,27 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 				   useraddr + rss_cfg_offset + user_indir_len,
 				   rxfh.key_size)) {
 			ret = -EFAULT;
-			goto out;
+			goto out_free;
 		}
 	}
 
-	if (rxfh.rss_context) {
-		mutex_lock(&dev->ethtool->rss_lock);
-		locked = true;
-	}
+	mutex_lock(&dev->ethtool->rss_lock);
 
 	if (rxfh.rss_context && rxfh_dev.rss_delete) {
 		ret = ethtool_check_rss_ctx_busy(dev, rxfh.rss_context);
 		if (ret)
-			goto out;
+			goto out_unlock;
 	}
 
 	if (create) {
 		if (rxfh_dev.rss_delete) {
 			ret = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 		ctx = ethtool_rxfh_ctx_alloc(ops, dev_indir_size, dev_key_size);
 		if (!ctx) {
 			ret = -ENOMEM;
-			goto out;
+			goto out_unlock;
 		}
 
 		if (ops->create_rxfh_context) {
@@ -1644,7 +1644,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 				       GFP_KERNEL_ACCOUNT);
 			if (ret < 0) {
 				kfree(ctx);
-				goto out;
+				goto out_unlock;
 			}
 			WARN_ON(!ctx_id); /* can't happen */
 			rxfh.rss_context = ctx_id;
@@ -1653,7 +1653,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
 			ret = -ENOENT;
-			goto out;
+			goto out_unlock;
 		}
 	}
 	rxfh_dev.hfunc = rxfh.hfunc;
@@ -1687,7 +1687,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
 		}
-		goto out;
+		goto out_unlock;
 	}
 	mod = !create && !rxfh_dev.rss_delete;
 
@@ -1708,13 +1708,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh_dev.rss_context))) {
 			/* context ID reused, our tracking is screwed */
 			kfree(ctx);
-			goto out;
+			goto out_unlock;
 		}
 		/* Allocate the exact ID the driver gave us */
 		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh_dev.rss_context,
 				       ctx, GFP_KERNEL))) {
 			kfree(ctx);
-			goto out;
+			goto out_unlock;
 		}
 
 		/* Fetch the defaults for the old API, in the new API drivers
@@ -1730,7 +1730,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		if (WARN_ON(ret)) {
 			xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
-			goto out;
+			goto out_unlock;
 		}
 	}
 	if (rxfh_dev.rss_delete) {
@@ -1755,9 +1755,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			ctx->input_xfrm = rxfh_dev.input_xfrm;
 	}
 
-out:
-	if (locked)
-		mutex_unlock(&dev->ethtool->rss_lock);
+out_unlock:
+	mutex_unlock(&dev->ethtool->rss_lock);
+out_free:
 	kfree(rss_config);
 	if (mod)
 		ethtool_rss_notify(dev, rxfh.rss_context);
-- 
2.50.0



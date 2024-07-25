Return-Path: <netdev+bounces-113119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD293CAD7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91E91F22A30
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCF1494D5;
	Thu, 25 Jul 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+RHnzWh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DED1494CB
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946247; cv=none; b=rdQF69AQWE7yz3IHsC9mYMP/TOtLTA3T/1pfyd3niT5Wee5aTPAvaCVciFWnxh7EFAQ+Goafw6D6UeC3uzM7C0BmjcIHU8fe8+qgw+vD8CQTBL8yM/5DUla4Q7Do7E8oGLFyAe2TJ3BAp4VLlfTfELzrYeeRfPYJpQjgK4l3IbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946247; c=relaxed/simple;
	bh=EL82RGxzOGRnUmC9jRPxvgwiL0cwbKM03Js9y/jrqIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDZwILlpaicVTdR+/kj7KUqtppd/cxhO1wTpcPRnx1BiLsHeHzPf55j5bRvAAKHlHrPBis9yJsQW00aWfWUNzX+PJv7j8rQ6ksHmOsYo1RlhScOa5Nkc3uj0Ag6QED43dBFAjTuwUIhbDvM29PKFcs9yx8N9jezg31SpyVjo4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+RHnzWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B4C4AF0E;
	Thu, 25 Jul 2024 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946247;
	bh=EL82RGxzOGRnUmC9jRPxvgwiL0cwbKM03Js9y/jrqIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+RHnzWhc2vjMy09E9PdEF/lsg7tZUqhz032Gqe5+tQpfjdbvk/iEaXn6tdrG5wCW
	 wzoOCHfYpvR4vbi6/BqSdwUVOJbbXpPTCPRBAGkC01VWyB9eYUpnM1u09m2guZlQTg
	 i8r4Vr4/87rfxd2fIiW131rR/5vjB5QnJx3o+JlED3ZXVdYFfyHwd3UuW368KL76GD
	 07rAVZ+DjSdCpYhgXVym9nv8mIDjfZ2fPxkT2pvXTkMRMa3oexrGRc0SbCr2b3O74K
	 iyw6AdinOot0HEHX+DTYRB8sFGQ3sPGBByjkkkvCmGnL1ef5FQmq7zoo/ZZwtVru28
	 0jJOsYujD8/HQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 4/5] ethtool: fix the state of additional contexts with old API
Date: Thu, 25 Jul 2024 15:23:52 -0700
Message-ID: <20240725222353.2993687-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
References: <20240725222353.2993687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We expect drivers implementing the new create/modify/destroy
API to populate the defaults in struct ethtool_rxfh_context.
In legacy API ctx isn't even passed, and rxfh.indir / rxfh.key
are NULL so drivers can't give us defaults even if they want to.
Call get_rxfh() to fetch the values. We can reuse rxfh_dev
for the get_rxfh(), rxfh stores the input from the user.

This fixes IOCTL reporting 0s instead of the default key /
indir table for drivers using legacy API.

Add a check to try to catch drivers using the new API
but not populating the key.

Fixes: 7964e7884643 ("net: ethtool: use the tracking array for get_rxfh on custom RSS contexts")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a37ba113610a..8ca13208d240 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1382,10 +1382,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
 		return -EINVAL;
 
-	if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
-		indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
+	indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
 
-	rss_config = kzalloc(indir_bytes + rxfh.key_size, GFP_USER);
+	rss_config = kzalloc(indir_bytes + dev_key_size, GFP_USER);
 	if (!rss_config)
 		return -ENOMEM;
 
@@ -1475,16 +1474,21 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
 	if (rxfh.rss_context && ops->create_rxfh_context) {
-		if (create)
+		if (create) {
 			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
 						       extack);
-		else if (rxfh_dev.rss_delete)
+			/* Make sure driver populates defaults */
+			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
+				     !memchr_inv(ethtool_rxfh_context_key(ctx),
+						 0, ctx->key_size));
+		} else if (rxfh_dev.rss_delete) {
 			ret = ops->remove_rxfh_context(dev, ctx,
 						       rxfh.rss_context,
 						       extack);
-		else
+		} else {
 			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev,
 						       extack);
+		}
 	} else {
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	}
@@ -1523,6 +1527,22 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			kfree(ctx);
 			goto out;
 		}
+
+		/* Fetch the defaults for the old API, in the new API drivers
+		 * should write defaults into ctx themselves.
+		 */
+		rxfh_dev.indir = (u32 *)rss_config;
+		rxfh_dev.indir_size = dev_indir_size;
+
+		rxfh_dev.key = rss_config + indir_bytes;
+		rxfh_dev.key_size = dev_key_size;
+
+		ret = ops->get_rxfh(dev, &rxfh_dev);
+		if (WARN_ON(ret)) {
+			xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
+			kfree(ctx);
+			goto out;
+		}
 	}
 	if (rxfh_dev.rss_delete) {
 		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
@@ -1531,12 +1551,14 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		if (rxfh_dev.indir) {
 			for (i = 0; i < dev_indir_size; i++)
 				ethtool_rxfh_context_indir(ctx)[i] = rxfh_dev.indir[i];
-			ctx->indir_configured = 1;
+			ctx->indir_configured =
+				rxfh.indir_size &&
+				rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
 		}
 		if (rxfh_dev.key) {
 			memcpy(ethtool_rxfh_context_key(ctx), rxfh_dev.key,
 			       dev_key_size);
-			ctx->key_configured = 1;
+			ctx->key_configured = !!rxfh.key_size;
 		}
 		if (rxfh_dev.hfunc != ETH_RSS_HASH_NO_CHANGE)
 			ctx->hfunc = rxfh_dev.hfunc;
-- 
2.45.2



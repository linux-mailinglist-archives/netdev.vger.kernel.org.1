Return-Path: <netdev+bounces-204674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7EAFBAED
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7EE188D9D2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB62265CCB;
	Mon,  7 Jul 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HazklmSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A4265CAD
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913685; cv=none; b=TqfjBDGwGIbkT49gwS2npDa+eSbexXmnwMJsqAlTnZYsJQg9lqjJzHNA9P8KDYfpoENF+2i/KpY/ND7tJ+A1MIPuRP0HTY1eU1iXGpiyG3T8mS34FRdvv3wzh8I0olBogQFFHxodCLizGkXeDimk5+e1XWxIbjHRAnD8qnocSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913685; c=relaxed/simple;
	bh=qm1dBFNtPRjaNrcXHXdnwF5NZKSAJr0WvL4iEgYzlls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvrGieOn04YNVnylY15lcyDeqNbTlu8YAQITMcUF7+Mi6ojspjs6sjQNGWs0bx7EUNzGpIV65CupAPjYOJM42Q+YmbfFvOa+uFI1oYA7A7U2RI5PpFVRoXPL90Mg7712LcD8Uo+CaCDiRBbTf4HfrZAwmtk40VZOh2sSj1yG0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HazklmSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885CEC4CEF8;
	Mon,  7 Jul 2025 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913685;
	bh=qm1dBFNtPRjaNrcXHXdnwF5NZKSAJr0WvL4iEgYzlls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HazklmSwyBkNV8tyhqqi6ilM1f2uWMArV0129OxhRJr8hn1xHBpKg1BLof+PaV5sa
	 GDmC6kyGE46Na5XPYGE2q7GF4smDO3ri+JxTiDG4xIGY37Ys9GytZ0j+IZr7sqQbF4
	 U7AJkB0NGS9hEGWTU60n/9p3iaDGz33Xed00bE41Ee7AsklutH29jBJOkZjNeDbyfR
	 MtdhA7vGAeN5Fif3wvI524nStDpQY0JU/skoPOZT6qcfV/2j3X65/i75MwW9wu2sGa
	 cTU3ezbQjvvudvvB77+zOWlUMAvbtXLysIt6gDuFAgvM7iZySDsFXyDlub3atriU53
	 UpB3XWqPrCjcQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 5/5] net: ethtool: reduce indent for _rxfh_context ops
Date: Mon,  7 Jul 2025 11:41:15 -0700
Message-ID: <20250707184115.2285277-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707184115.2285277-1-kuba@kernel.org>
References: <20250707184115.2285277-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't have the compat code we can reduce the indent
a little. No functional changes.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - unsplit one more line
v2: https://lore.kernel.org/20250702030606.1776293-6-kuba@kernel.org
---
 net/ethtool/ioctl.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d8a17350d3e8..139f95620cdd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1664,25 +1664,19 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
-	if (rxfh.rss_context) {
-		if (create) {
-			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
-						       extack);
-			/* Make sure driver populates defaults */
-			WARN_ON_ONCE(!ret && !rxfh_dev.key &&
-				     ops->rxfh_per_ctx_key &&
-				     !memchr_inv(ethtool_rxfh_context_key(ctx),
-						 0, ctx->key_size));
-		} else if (rxfh_dev.rss_delete) {
-			ret = ops->remove_rxfh_context(dev, ctx,
-						       rxfh.rss_context,
-						       extack);
-		} else {
-			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev,
-						       extack);
-		}
-	} else {
+	if (!rxfh.rss_context) {
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
+	} else if (create) {
+		ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev, extack);
+		/* Make sure driver populates defaults */
+		WARN_ON_ONCE(!ret && !rxfh_dev.key && ops->rxfh_per_ctx_key &&
+			     !memchr_inv(ethtool_rxfh_context_key(ctx), 0,
+					 ctx->key_size));
+	} else if (rxfh_dev.rss_delete) {
+		ret = ops->remove_rxfh_context(dev, ctx, rxfh.rss_context,
+					       extack);
+	} else {
+		ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev, extack);
 	}
 	if (ret) {
 		if (create) {
-- 
2.50.0



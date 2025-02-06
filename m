Return-Path: <netdev+bounces-163711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9986A2B6D5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D862B7A376D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4264E23AE68;
	Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHAV6GJ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB723AE65
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886020; cv=none; b=O3hAC6qKHDOAr1gwWBU4pvFgSRufK59fwNkxR7hZXJr1V9hlCM6ha7wnyoLA8qD/ob9VrQadhE7c6YqwDYknJeRR52LPkHtxMLT9RymSbAdNRCA+UghhVltWwBaJYViDn2tqFRhhYT00CJ1pISnfoD+oU0k+ZBE7AhaK8C5N9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886020; c=relaxed/simple;
	bh=gatDp0gBWNfEYCbBfHMPMCnSfvhRvkvEEbYGNqOdcIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3b5kh68dyKUpvPQy/E49XxDGoAY5IG7TrS98HlOZ70baW25mxRvv+Gq2Hi3j93oVFrCfT+W9xWDZNmi5GDrYIMeoUjSsEmIJz6whSz7MuWa92+VbreiizM1/g1cPFftmuhZM0yieMiU230yUI6GyymhMS1AhPQURdVUnAxxDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHAV6GJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB6C4CEDF;
	Thu,  6 Feb 2025 23:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886019;
	bh=gatDp0gBWNfEYCbBfHMPMCnSfvhRvkvEEbYGNqOdcIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHAV6GJ+WpoIDK42AjDs8nFjfAD9kW1oxGSVF4zAf9SGCzcCuG2RIJ0Wh1ozXh8qC
	 5JD/OCpfzXjSZn7EIGlB1Bk+uF2m3n8QpU9reIwXTLOqKofDSGJXDM8rxY2zMYFPTL
	 R+ZvKJBwawbfKnngR0P1MCVjMB6Q/PQiwkQMyRHG4mXkoHZtw+MxPVXyWu/UJri9yv
	 ebuT6YbKlH5U0IslWOlPeJcgu01nHxpzKCyT9xQ/6FJ/SgLN9OwBqu1BGnZu/eOsE0
	 UWixQgCheOrZkZ7FrWxbITfMnX6H6raJ+FRHF8TMcvoJ24aQUCk8SlUd7RvByejT84
	 KjE2mSq2Ppbeg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ecree.xilinx@gmail.com,
	gal@nvidia.com
Subject: [PATCH net-next 1/7] net: ethtool: prevent flow steering to RSS contexts which don't exist
Date: Thu,  6 Feb 2025 15:53:28 -0800
Message-ID: <20250206235334.1425329-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 42dc431f5d0e ("ethtool: rss: prevent rss ctx deletion
when in use") we prevent removal of RSS contexts pointed to by
existing flow rules. Core should also prevent creation of rules
which point to RSS context which don't exist in the first place.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ecree.xilinx@gmail.com
CC: gal@nvidia.com
---
 net/ethtool/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7609ce2b2c5e..98b7dcea207a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -993,10 +993,14 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		return rc;
 
 	/* Nonzero ring with RSS only makes sense if NIC adds them together */
-	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
-	    !ops->cap_rss_rxnfc_adds &&
-	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
-		return -EINVAL;
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS) {
+		if (!ops->cap_rss_rxnfc_adds &&
+		    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
+			return -EINVAL;
+
+		if (!xa_load(&dev->ethtool->rss_ctx, info.rss_context))
+			return -EINVAL;
+	}
 
 	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
 		struct ethtool_rxfh_param rxfh = {};
-- 
2.48.1



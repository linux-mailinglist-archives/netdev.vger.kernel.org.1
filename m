Return-Path: <netdev+bounces-56839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A827810F72
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BE0281BC3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1023758;
	Wed, 13 Dec 2023 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1QYrjSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DC23755
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221EC433C8;
	Wed, 13 Dec 2023 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702465692;
	bh=zLuO6/75uYDIjN5N3SM8Ia80Qf1C89jN/8CZR3SxV6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1QYrjSVWVs98vp3dGJAOcfh1QmVxz2E+XOIHpC/0jUmxirlpTOhCMuE643wDu4J7
	 HEMgMFpFDtP23AdUMaGNUqBgtKaheprkR0PQfxKsrJlz1o6IJj8TuSqZov/64rxqPJ
	 aOwPzWWX1kXCeLscvxaPpGjFCYqTQC2KzUuZ3ODHirnAUP2U5QyCv+D2p8RVsa44tI
	 hI5i8lEwQ30x0p8jBFMsrVYrpNfu+VkrNwmYacfz5IT2RnwWZ3TeBf3NlfDnI3EVxz
	 4j73V/cgoXbntKfjzl4faw0U6yfpqG56NRylkHJZ1rJ5OkNGrCeg009YptFoSJJKTX
	 ASKKHIwY1xsWg==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH v8 net-next 11/11] net: ethernet: ti: am65-cpsw: Fix get_eth_mac_stats
Date: Wed, 13 Dec 2023 13:07:21 +0200
Message-Id: <20231213110721.69154-12-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213110721.69154-1-rogerq@kernel.org>
References: <20231213110721.69154-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not support individual stats for PMAC and EMAC so
report only aggregate stats.

Fixes: 67372d7a85fc ("net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

Changelog:

v8: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index d2baffb05d55..35e318458b0c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -671,6 +671,9 @@ static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
 
 	stats = port->stat_base;
 
+	if (s->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
+		return;
+
 	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
 	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
 	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
-- 
2.34.1



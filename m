Return-Path: <netdev+bounces-116223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDF949859
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4802D280A8B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221D154C05;
	Tue,  6 Aug 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPJ257ha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A6154C03
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972821; cv=none; b=AOZHwnOzsMtHPOZT41yD6akEsCH27GF+XF/zKYjHTTi0hur/i1yuwW3l9IyW6o3s2C9R4Tv14QhKB0BaB2JYlMlPrd7c/hZRtZBbFBK+c3PFtXdlYJCSC9MDnc+xLefacMB8y6nJRPj58iSP2rSi8bc8EZLvnFK7rR6X7DXjOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972821; c=relaxed/simple;
	bh=ySWkduIsUYX42MGHqm/WphfoDV9ovzfyI6PB3ZCriwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzEalGeYWFHaMRQyYBoYrbdQLiS3LFKqc96Tsq19ppGbO32BjuKbz4jHdY4TOPrkkQ8TI2XNoxcJX0T+4Krtw+0S6dZZ/OdkcdM5vrxqC2t7Qn2F/gAN50OH7PYOgNxRIDc4OlN37d+O5bJj/ZZSrVGjGJ7mTveRNf6XQyF3EZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPJ257ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30383C4AF0C;
	Tue,  6 Aug 2024 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972820;
	bh=ySWkduIsUYX42MGHqm/WphfoDV9ovzfyI6PB3ZCriwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPJ257haghXpVvSt/dBGWRnKdvPTO52rRM3nD1pKcHZlj56jVfUzw5Hi05iZkLquO
	 J6RWOzEGX+Wh+7HwFcnDbf7XKIFvPVeQt9QIPmXA9SXEsS1M59Henb96i//EIu4eHR
	 +d/jASaGq3f0M2i60aDTP6INRZDbKDH/6anOBc8DbIsAg6X/oTubJT8IU6xJPEXRnQ
	 1bser4XZjZ//9pL/0neintOwsEOhKXbKdVGsQcWP7wt5dqMf8ZY+PnwZ3Zpp3vIo+K
	 d5rJiUFpRGzi/6Dorm3VZYjjDp/wqTeJjJL89UywoQ9Wr+foqBnsOBmmQi6+vZSyAd
	 2OakkEy7+EWXw==
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
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 05/12] eth: remove .cap_rss_ctx_supported from updated drivers
Date: Tue,  6 Aug 2024 12:33:10 -0700
Message-ID: <20240806193317.1491822-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .cap_rss_ctx_supported from drivers which moved to the new API.
This makes it easy to grep for drivers which still need to be converted.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 -
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c   | 1 -
 drivers/net/ethernet/sfc/ef100_ethtool.c          | 1 -
 drivers/net/ethernet/sfc/ethtool.c                | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ab8e3f197e7b..33e8cf0a3764 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5289,7 +5289,6 @@ void bnxt_ethtool_free(struct bnxt *bp)
 
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
-	.cap_rss_ctx_supported		= 1,
 	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
 	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
 	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b70aca33b928..98500b70f994 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5791,7 +5791,6 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES - 1,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
index 896ffca4aee2..746b5314acb5 100644
--- a/drivers/net/ethernet/sfc/ef100_ethtool.c
+++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
@@ -37,7 +37,6 @@ ef100_ethtool_get_ringparam(struct net_device *net_dev,
 /*	Ethtool options available
  */
 const struct ethtool_ops ef100_ethtool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.get_drvinfo		= efx_ethtool_get_drvinfo,
 	.get_msglevel		= efx_ethtool_get_msglevel,
 	.set_msglevel		= efx_ethtool_set_msglevel,
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 7c887160e2ef..15245720c949 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -240,7 +240,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 }
 
 const struct ethtool_ops efx_ethtool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USECS_IRQ |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
-- 
2.45.2



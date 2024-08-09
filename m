Return-Path: <netdev+bounces-117067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16AC94C8CB
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1DF1F2240D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755C1CD37;
	Fri,  9 Aug 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOfsaw6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEF1CA94
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173515; cv=none; b=jTu6bwSxhd0+kGOSsmyrxhzUV/DS8g34/rPZUTB0d2hdabhMX8WH5Md96TmSCZ1ziLQ5iWVJhW8RS54t+pPBs9hV2grJVlt8XPOx4fIHpr6HZPl1sMi59uLAYITzJiCW+Yman7ZlMMdzUw7w1gBsYpmCsyCil+TrUXdkSc1f8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173515; c=relaxed/simple;
	bh=O7nyJTny+UWPRvpLglBcB5JWe9aR4TO0v7BMKR9Mv1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csk1KjubroCo0ibMYA9Sew2+1UtWM0PwbP3qQMbnKmAz/M/5otN65B+HqtB9jaOIjTtC24xed+xnJZ9mviWHXyAfmmBJp0k5GmRO7Z9zzpVI9LNbLy8Py1BrFP12NWQEo1VjHyP5TlRDsD5qLRJ1ofk6h9h5b1/b5CB0eOqVSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOfsaw6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713F8C4AF0C;
	Fri,  9 Aug 2024 03:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173515;
	bh=O7nyJTny+UWPRvpLglBcB5JWe9aR4TO0v7BMKR9Mv1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOfsaw6TE3SWLaVHAVopKDG/M64rJC/l8a2StzB5bbtHlpuvpQPyvUDCT+cLSqkPd
	 SMJLpMlN6CPSYSb4VeJ4ItosD72ubcDz2fLrrKGa4ca+CMnuPkPdNWThdJsq2mYbnk
	 wKFQVgOZrQjGJi1iR/MBCwIZcyPCl8dhWysfPiWvMQrNkBctdWAwMPjTWCnz94l9uF
	 bvU0wEEuysLeIZp9lMaci0m09ngO1h/PQJRlXcpIhdrQ2ymu+/PYuL7AEH+wHokvlP
	 pyc6X2SxoYR8LcRZ9LdXB68Pyv5U+/xgUymzJicIHi1NB7bvJRhyIkhODwikMm4gBA
	 v9qn6XV31Gs5g==
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
Subject: [PATCH net-next v4 05/12] eth: remove .cap_rss_ctx_supported from updated drivers
Date: Thu,  8 Aug 2024 20:18:20 -0700
Message-ID: <20240809031827.2373341-6-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
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
index 9dadc89378f0..44076e4ebf1a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -5289,7 +5289,6 @@ void bnxt_ethtool_free(struct bnxt *bp)
 
 const struct ethtool_ops bnxt_ethtool_ops = {
 	.cap_link_lanes_supported	= 1,
-	.cap_rss_ctx_supported		= 1,
 	.rxfh_max_num_contexts		= BNXT_MAX_ETH_RSS_CTX + 1,
 	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
 	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 90182f6fd9a1..5d5ad8d47e46 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5791,7 +5791,6 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,
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
2.46.0



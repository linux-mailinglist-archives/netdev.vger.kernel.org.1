Return-Path: <netdev+bounces-115472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76923946764
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E8F1F21B71
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA913959D;
	Sat,  3 Aug 2024 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/oP7CC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1241386D1
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659214; cv=none; b=TYcWoW9+6C6UzohnLX/ZLeebF2OwRzK//2DMnlgUKvuBxpyOw/AKxVSburN/L5nl3GJnYHg7lcE9hJJzzoFNhApVCMgap//P7tHYupBG5tzoP2I+PPWseCRgx2y1GWv5qHiTc/sWS8Z9tZsFrboSix+fhIR+8IvRQcF8dG/MzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659214; c=relaxed/simple;
	bh=b6C+TXmsKYJsM7SRrfnQqPhEHtccDjBWI+WEuGIioqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/TFOIqEf2p2TXec/jlIpyD+7TVgPymD7R0JeynnyuHRDG7NIA4QiyuMiRMRUO5PyYnXA3Q3dHqhhfEQAypFQxUA9HutjIQlk9FSedAuilGct+0VyFY1rfU9NeMSAF7Ej7eajeNaMuL37Wzs9pJOuf/g8D6EcMNwEtEpzwI5Q1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/oP7CC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62001C4AF0C;
	Sat,  3 Aug 2024 04:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659214;
	bh=b6C+TXmsKYJsM7SRrfnQqPhEHtccDjBWI+WEuGIioqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/oP7CC7Or4k26omD3U9Q4kU7+TJxRkkQDxnUi/GLyfgR+iv/rHJ82t8LKhQEUKHy
	 iLfGjtwW03ngzxOV8e7IaBa11N7s825ebkP1HCh688nSjw2A1i6JpiMwUpCxOlgvTF
	 5gFyLTqMNsTdbGiElmTp7xLP9GwEdEy1SmzVEOlYBe+RY/K1DWgZFYPgrZup/KX/Gi
	 uVu0sxupnPZn12YyX47pKPrmr8e+y3pmCJ/7rv0L161CHS49XCiUjaWmL7tz9oMV8H
	 wFfLpExiU3T4vygEvntKd9l/PyS0647f+X4S4CMRUew6lcGY0ZnUOEvOrAhNfpzKus
	 qEs9td3mehy6A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 05/12] eth: remove .cap_rss_ctx_supported from updated drivers
Date: Fri,  2 Aug 2024 21:26:17 -0700
Message-ID: <20240803042624.970352-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .cap_rss_ctx_supported from drivers which moved to the new API.
This makes it easy to grep for drivers which still need to be converted.

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
2.45.2



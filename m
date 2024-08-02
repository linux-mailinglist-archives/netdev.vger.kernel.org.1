Return-Path: <netdev+bounces-115158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA942945533
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760C8B226C8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315FF10A24;
	Fri,  2 Aug 2024 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La8STfNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C341F4FB
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557891; cv=none; b=F8c2TyWbaAFzL3n/tH6o1cwrrjAlXz1znfyMHar1Xh8S56rCx/aZ2FTXDvxBCfBU7WG9v2v2Zy04L61MC6Qam/382Knp4O/uT4yfaMu/l2pp6w9PhuZRoJ2T226smGgyic0s1VCfGFPTN4S4wHAeQ5gyao1TveHpPAv6tgHGtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557891; c=relaxed/simple;
	bh=Shg5DFkznLBRrWXEUN0302xR+zdDkYH3SsE4tFaUVY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMEVaf0fUbp+Z/2Y670414TKxrmzevTGZV1uEQfd1rDp8EEah4dyX6S/wgx8/3aV8qJBI/RN3Nds+VefGYWVbMaPuQal24fiCSBAw/r5ye+Og5Ozmy9fskcLcHjXx+wDkmX4CXAlK1mc0Y3KFb4cTsasi+K0Qpzx/UMwhozWo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La8STfNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544DC4AF0C;
	Fri,  2 Aug 2024 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557890;
	bh=Shg5DFkznLBRrWXEUN0302xR+zdDkYH3SsE4tFaUVY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=La8STfNiBuzW+3hiLyQ/CcxuodE4P9gf/T3Q6aRWpmJ3RIynBsGe4/9ZO1mpQfy1h
	 IXzXcmfF1s/7GV8VRE0WK9iIUTOjq4PLFiRphBZXUadQgWHVQ5A7zls6B7A/ezborC
	 SmIJahGp4gLXU/laR49sHIaT7X5hwtLbMTw6vmIIn92fA+9pW9oxZbKyawSYA5XRtR
	 Hu5V+X845SriyQMdKKJGelTg0XzCn0Yn6958yoAG7+bj0T+92CgDPzuxuEYZKIEPfc
	 fdOsnZMySug3Sta6Qo4N1b1kiRcgDIvhGk7nCh2VDECaqO+Mw4KdSiXYPZuKUORyB7
	 I0nx2Izj+O+aQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/12] eth: remove .cap_rss_ctx_supported from updated drivers
Date: Thu,  1 Aug 2024 17:17:54 -0700
Message-ID: <20240802001801.565176-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove .cap_rss_ctx_supported from drivers which moved to the new API.
This makes it easy to grep for drivers which still need to be converted.

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
index e962959676ac..ceafac832f45 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5786,7 +5786,6 @@ static const struct net_device_ops mvpp2_netdev_ops = {
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



Return-Path: <netdev+bounces-117373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0894DAF2
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB53B215C3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A813C672;
	Sat, 10 Aug 2024 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUeSwqQ3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F913BC0B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268488; cv=none; b=L4BxNNMRjeW9xMpS3iV3pL6E7NR3J5As3GKQvvj5XWBz8+mz9RauI5bGmbONEd2/UZq50gCsbJ4gRonXWYEg8rj0Zl65xEa+vx2owoajfHDpizxod6c81RJqyqQMd2UKkCSIcYwTtIH08pxXUp5+6VtFTVdPT9gLDe3/Uay3sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268488; c=relaxed/simple;
	bh=PavcYLDEPFVndeodLW/ZVWWbX5SVKLZCKmjP6iibtak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EluRySSgZBhNbZkTlUtcFqR0NQM193Gw9r8Zvour9so+i8yz5A+hELPQ0oAPv5/BKjwpY7CZHZ15dSj5JjFyezG3muRT3TNIkHaVqAtSMzXabXShYmqKHlcR63/9VP/uR9WtI16bmIUcWh/MXfp7SXBgQsdY1ZAB4dky+xNLFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUeSwqQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346AAC4AF0E;
	Sat, 10 Aug 2024 05:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268487;
	bh=PavcYLDEPFVndeodLW/ZVWWbX5SVKLZCKmjP6iibtak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUeSwqQ3xOEOi6g82UFYOK8YT8ibJ4GI51QRmk9tCPCBrm8zIY2ZpkWoh+RI6TZ80
	 40sJ1aZv/wAWD0TtbEuhc+pheAfYjnsy3obTm/gOIgVjvktml5cmF2bPyfD8cSiJbF
	 Kk4ASCdzjl0FS2q6vfSPWquhO5wbmM4Qh7IjSUiRM/g3jwnfh06DWv6auTacczOgxG
	 9MDdH1Tmtd6LWGRfQi1jzErbT8EPzsTvYhl5m74ccrsQnYFiR6c96ZM/vohdQINzEf
	 qt5femz60HDPyUDy15k93VbeEan9DLmK9auTogXBDxpPmmTbGi7FW7N9uuGK/XG9FJ
	 tCUiP4zHX11Xw==
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
Subject: [PATCH net-next v5 05/12] eth: remove .cap_rss_ctx_supported from updated drivers
Date: Fri,  9 Aug 2024 22:37:21 -0700
Message-ID: <20240810053728.2757709-6-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
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
index 1d472316e7a7..303427599c1c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5791,7 +5791,6 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-	.cap_rss_ctx_supported	= true,
 	.rxfh_max_num_contexts	= MVPP22_N_RSS_TABLES,
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



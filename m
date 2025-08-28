Return-Path: <netdev+bounces-217855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D546BB3A289
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307BE3B69D6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85331E0E0;
	Thu, 28 Aug 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWS6Hd9a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465DD31DD9B;
	Thu, 28 Aug 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392090; cv=none; b=PBkUKCaXX9HnWoZsdWuHCpZ9MJZFQM6OcU9u+EmPQSbHszOFcmcmOTBylskIgi3q52Kbjc7IR4fWotMiPbANqVajUBtnvtVEzo3tgpGD9zK5S6pm56gdX1xLrFzfmMTaboir6i8X6Z6T58qk9xebQ2mTQB0fsHprxIDz2MMKTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392090; c=relaxed/simple;
	bh=jzrymZop5dhCQXUJp9duw8ynZq28kq5moo1G3LEpFJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkJDGTqxLqJVPeu2UvBeEqpyBg4dekEZZnr3lNf7rV6vRNfKO2g+W45f+gtNXZM0MYACv06UMyMu1/ikrbTAlGmfX14DLlOItsMzMf3RK39TzDqTnOZdUb2HvgVJQ0RQR3sWjUs3OkmwK2dd68ii71cS2PV+MnnET41n/bGuqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWS6Hd9a; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756392089; x=1787928089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jzrymZop5dhCQXUJp9duw8ynZq28kq5moo1G3LEpFJ8=;
  b=YWS6Hd9a1Gi6LlBYFLi9t9R7b8MJF+bTVdA/xSU3k7Zm+uzEZMNSaOkL
   b+Oo90e2aSRZ1GbzvnHhSr28yHQ5C4qEjhSszgOAJBnqMFAg6CLAi7arH
   Uuiu/aceLaw8VZvTHTW332k0fsZTARKnFJyDcUbmaufCpKhth7D5zj8od
   kQh12vgouPKDuvtDLGmhDoRsrtsIAg42qtywWWRwrseElCOYP/nDyveFi
   yMX6dRt0tBKm1je6GWewUyo+TEEvq2sbkCDEI71T3eov9he4VoGA2KA2B
   fcM0NTP2KWyZbspy6QC3XS2KaRC/ZpXlGnFCJP67PVO3txv1rSv+8rVf0
   A==;
X-CSE-ConnectionGUID: cuEeN80PSPCZ3JD/MEwuXA==
X-CSE-MsgGUID: +IAZE0kjSneIHouGLE4OFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58515410"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58515410"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 07:41:28 -0700
X-CSE-ConnectionGUID: QJlq1e/NTMaawHVw0fMRYQ==
X-CSE-MsgGUID: qd2A5lylSKyHiyZEW3L2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207276104"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2025 07:41:24 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Karol Jurczenia <karol.jurczenia@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net-next 4/4] net: stmmac: add TC flower filter support for IP EtherType
Date: Thu, 28 Aug 2025 16:45:58 +0200
Message-Id: <20250828144558.304304-5-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828144558.304304-1-konrad.leszczynski@intel.com>
References: <20250828144558.304304-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Jurczenia <karol.jurczenia@intel.com>

Add missing Traffic Control (TC) offload for flower filters matching the
IP EtherType (ETH_P_IP).

Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 78d6b3737a26..77f900a328aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -206,6 +206,7 @@ enum stmmac_rfs_type {
 	STMMAC_RFS_T_VLAN,
 	STMMAC_RFS_T_LLDP,
 	STMMAC_RFS_T_1588,
+	STMMAC_RFS_T_IP,
 	STMMAC_RFS_T_MAX,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 694d6ee14381..c5577652d6ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -239,6 +239,7 @@ static int tc_rfs_init(struct stmmac_priv *priv)
 	priv->rfs_entries_max[STMMAC_RFS_T_VLAN] = 8;
 	priv->rfs_entries_max[STMMAC_RFS_T_LLDP] = 1;
 	priv->rfs_entries_max[STMMAC_RFS_T_1588] = 1;
+	priv->rfs_entries_max[STMMAC_RFS_T_IP] = 32;
 
 	for (i = 0; i < STMMAC_RFS_T_MAX; i++)
 		priv->rfs_entries_total += priv->rfs_entries_max[i];
@@ -777,6 +778,17 @@ static int tc_add_ethtype_flow(struct stmmac_priv *priv,
 			stmmac_rx_queue_routing(priv, priv->hw,
 						PACKET_PTPQ, tc);
 			break;
+		case ETH_P_IP:
+			if (priv->rfs_entries_cnt[STMMAC_RFS_T_IP] >=
+			    priv->rfs_entries_max[STMMAC_RFS_T_IP])
+				return -ENOENT;
+
+			entry->type = STMMAC_RFS_T_IP;
+			priv->rfs_entries_cnt[STMMAC_RFS_T_IP]++;
+
+			stmmac_rx_queue_routing(priv, priv->hw,
+						PACKET_UPQ, tc);
+			break;
 		default:
 			netdev_err(priv->dev, "EthType(0x%x) is not supported", etype);
 			return -EINVAL;
@@ -800,7 +812,7 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 
 	if (!entry || !entry->in_use ||
 	    entry->type < STMMAC_RFS_T_LLDP ||
-	    entry->type > STMMAC_RFS_T_1588)
+	    entry->type > STMMAC_RFS_T_IP)
 		return -ENOENT;
 
 	switch (entry->etype) {
@@ -814,6 +826,11 @@ static int tc_del_ethtype_flow(struct stmmac_priv *priv,
 					PACKET_PTPQ, 0);
 		priv->rfs_entries_cnt[STMMAC_RFS_T_1588]--;
 		break;
+	case ETH_P_IP:
+		stmmac_rx_queue_routing(priv, priv->hw,
+					PACKET_UPQ, 0);
+		priv->rfs_entries_cnt[STMMAC_RFS_T_IP]--;
+		break;
 	default:
 		netdev_err(priv->dev, "EthType(0x%x) is not supported",
 			   entry->etype);
-- 
2.34.1



Return-Path: <netdev+bounces-216897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAAB35C26
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35057C49C0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782E34DCFB;
	Tue, 26 Aug 2025 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dw5S2KUm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BA34DCE8;
	Tue, 26 Aug 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207711; cv=none; b=cJhBGWuAQd7SDZTRn58uILgVyDZbqzk8SHSQNI90O2GALluVw6Nzv0tx8vHCyLA7R4C5bD/uuyQogaOkpFQDut3uSZoQQ4Z/nDdCyx5d/jtA36BRrCHTt78OsttdN9gC0LzCZoN1PYX2yUr/UeSWLGd1ILGs9hLG2KJ1mIkOa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207711; c=relaxed/simple;
	bh=7p5bPq0tooQv9SqVVvAnbRbgQhjadctsfaQ/sIlg3bM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7nUkySd6Ox/IHPeETLFJgfeJ7sqW1r37HflGRdaiKfeY4eALWtFuPZ+q3UJG7thkIBT8D67euC6sEJusab4AegPEoSA/RjmLjLnEVNTuoewBjovj6paauY51mBT0YFNQAGZ3JFNB1ZyhualquenUNLW6vt0rmVhtsrmEEHyfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dw5S2KUm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756207710; x=1787743710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7p5bPq0tooQv9SqVVvAnbRbgQhjadctsfaQ/sIlg3bM=;
  b=Dw5S2KUmiI/pZlvhmZRkOYH955FwoLeU32XupIywIuENHsuxk/bJyFdb
   pg9D2hLI8/yt8llU1YAnOM/K7C5MKI7swKQqIx62PUg15qByp3nE7K4gi
   htBT9o0hwhHjgkRyGdds1SspKgAtWBQm3F45aS3UhG9vwr7rLn4OYKR/u
   qr5KwzLgL7h24HN+rfOiTqZhTJQjwSKBC8HibzyCiFb8fxYm6uHL41pRT
   dmpudiv9RwVpsXq1S04J5rJm69XYAUy2DAd6eDV94LlF87/pbbKQj/mEq
   PzyqyMsgCy4hlpwjHuEF1ZWvYJUgw8Sx4Cuwo6/bwdvEZGxW6VY49POkS
   A==;
X-CSE-ConnectionGUID: DTnxAgiJT6G+opSVjJn1Bg==
X-CSE-MsgGUID: X/mEDFTHRXiabv+VyyvrEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62269307"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62269307"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 04:28:30 -0700
X-CSE-ConnectionGUID: v9baOqRNQ0OkTebPyYsI4Q==
X-CSE-MsgGUID: 8L0rUU45QRWsH/0SeuqWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="173725846"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2025 04:28:27 -0700
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
Subject: [PATCH net-next 7/7] net: stmmac: add TC flower filter support for IP EtherType
Date: Tue, 26 Aug 2025 13:32:47 +0200
Message-Id: <20250826113247.3481273-8-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
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

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index cda09cf5dcca..8397f2ac63fc 100644
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



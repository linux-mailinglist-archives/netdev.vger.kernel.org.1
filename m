Return-Path: <netdev+bounces-212661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12496B2197E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AFD7B53E3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD4246BD2;
	Mon, 11 Aug 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0mPL2Nv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE1244665
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955766; cv=none; b=TnOB5/gJXa/bBw0apMexKxuZA+UJR2M+u9TVamTLLF8QebWc6hzQv46OC7dJFPukbWDRV2I7aNuA87cNHjDkAkjUY/udr6sb1mPeXL+g9gy86v5UA2nSiHcd07USgdc18D8iu1TjLuHl9qJF+f2RMLKbN8/ReAUMq3bg6CrsHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955766; c=relaxed/simple;
	bh=BOVE2tkveLy63cSdB72dm+OnhMImZvdcdZGn6nvP8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkmQx+ZLU978MIvN0U/fWYMSiY/CIrMu1MacMmYRxENQM1PgDa5hIeHb1cx5q9hJQYO8VdYPxW02fGOzZ2XA1RWkPqFZOvE/aZsBEO9SJoWNpSRcWglyGyGjXhA78qJKskEmV5zXm35RKglqQ0Ig1sH0LRKRRzS4D/dryGW/iY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0mPL2Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1661C4CEED;
	Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955766;
	bh=BOVE2tkveLy63cSdB72dm+OnhMImZvdcdZGn6nvP8ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0mPL2NvEkxiEGaC6NJWiY3Rypxz8mnOoNCp9fGo7y/h+DOS3tPgvqlRa6gfJmoBf
	 vstuQ0noPnV9TnDBYvabjDrF9i3IvT21MrMAivJ7dVD0LmwlZreE8Hux/N1tz2G/pT
	 Tj4upIYqZdZpWy7jXE/mCMksOX7LcXV+iJCecM1/hE/orqpb/SGA+ju3G7bcQYw6sN
	 GfF4xls+XS1CCMMosiYRYfLMxMlyqlQ8JifHLmP+In76dwVdow1vdxxxk7OZuDOSMg
	 MFq9kZSU93QlJdgyfFR2fxBbr2gaOmbWbeloqdcDJ2SjwAD/uJvKwOuhwUt4cvusWH
	 lrzGYOfP81fbA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v4 3/4] eth: bnxt: support RSS on IPv6 Flow Label
Date: Mon, 11 Aug 2025 16:42:11 -0700
Message-ID: <20250811234212.580748-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>
References: <20250811234212.580748-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that the bnxt FW API has the relevant bit for Flow Label
hashing. Plumb in the support. Obey the capability bit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v4:
 - only set IP if tuple=2
v2: https://lore.kernel.org/20250724015101.186608-4-kuba@kernel.org
 - update the logic to pick the 2 tuple *OR* the FL bit
v1: https://lore.kernel.org/20250722014915.3365370-4-kuba@kernel.org

CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 ++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 20 +++++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..40ae34923511 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2407,6 +2407,7 @@ struct bnxt {
 #define BNXT_RSS_CAP_ESP_V4_RSS_CAP		BIT(6)
 #define BNXT_RSS_CAP_ESP_V6_RSS_CAP		BIT(7)
 #define BNXT_RSS_CAP_MULTI_RSS_CTX		BIT(8)
+#define BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP	BIT(9)
 
 	u8			rss_hash_key[HW_HASH_KEY_SIZE];
 	u8			rss_hash_key_valid:1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..ab74c71c4557 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6957,6 +6957,8 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V4_RSS_CAP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V6_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPV6_FLOW_LABEL_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP)
 			bp->fw_cap |= BNXT_FW_CAP_VNIC_RE_FLUSH;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1b37612b1c01..68a4ee9f69b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1584,6 +1584,8 @@ static u64 get_ethtool_ipv6_rss(struct bnxt *bp)
 {
 	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
 		return RXH_IP_SRC | RXH_IP_DST;
+	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL)
+		return RXH_IP_SRC | RXH_IP_DST | RXH_IP6_FL;
 	return 0;
 }
 
@@ -1662,13 +1664,18 @@ static int bnxt_set_rxfh_fields(struct net_device *dev,
 
 	if (cmd->data == RXH_4TUPLE)
 		tuple = 4;
-	else if (cmd->data == RXH_2TUPLE)
+	else if (cmd->data == RXH_2TUPLE ||
+		 cmd->data == (RXH_2TUPLE | RXH_IP6_FL))
 		tuple = 2;
 	else if (!cmd->data)
 		tuple = 0;
 	else
 		return -EINVAL;
 
+	if (cmd->data & RXH_IP6_FL &&
+	    !(bp->rss_cap & BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP))
+		return -EINVAL;
+
 	if (cmd->flow_type == TCP_V4_FLOW) {
 		rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_TCP_IPV4;
 		if (tuple == 4)
@@ -1732,10 +1739,15 @@ static int bnxt_set_rxfh_fields(struct net_device *dev,
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
 	case IPV6_FLOW:
-		if (tuple == 2)
+		rss_hash_cfg &= ~(VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 |
+				  VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL);
+		if (!tuple)
+			break;
+		if (cmd->data & RXH_IP6_FL)
+			rss_hash_cfg |=
+				VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
+		else if (tuple == 2)
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
-		else if (!tuple)
-			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
 		break;
 	}
 
-- 
2.50.1



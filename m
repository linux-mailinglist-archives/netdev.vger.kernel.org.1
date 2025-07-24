Return-Path: <netdev+bounces-209580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AAB0FE78
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599FCAA0928
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674319DF4A;
	Thu, 24 Jul 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgcrHS91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CD19CC3E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321883; cv=none; b=MjLAw7El4i+UUBf1tTU4TTQR252vJQkBK+rSqVqz2FBfyOQOp5soQvEgnHQIRUxfFI1Df9DKS/upO/5cYGXGbsfFxBtt7JhKbSuXRzaZFwRBQgNLCEHnRszC+qs6kh78SrABvXrdlcqrXIHrBHkX2EDbF/3WD3pzUF+KTBCFLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321883; c=relaxed/simple;
	bh=6uzpWLrN3n61C+YMdzikN89SIpYL0GeYXd2yim31NLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQmAs+1I4nm41DFSB7wPrwSg2cgmV+fk/whcpZoWzX34v0CuuzicWx35gR2ta1SiDGkd/AphL5v/u1AtF9Yv4Zbss/2p801y0kccGTxVNuXU8onTMaJALJCKH/qbOJ6/28Dhi2OY3NJte/NestDNZwBIlug6/ZKge1TiPXy+t9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgcrHS91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC3C4CEFB;
	Thu, 24 Jul 2025 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753321882;
	bh=6uzpWLrN3n61C+YMdzikN89SIpYL0GeYXd2yim31NLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgcrHS91XojFdIkEV9VUpRgpwBPIyN/4I9gOngwJF41bSVusC6Wchka7jc6GOmOJW
	 ap24CsI8ERAYoK9KWMbOx5kFW4A8KXqbSRhFIce2XEwb2nJqXgLaGLcZu4MWhSpbIi
	 j40dFNT79824GUsxmhlR1Amv6hEBKYDgf6gSIh0hq/TeO5jjlQ4lh1HLqC6YB/75ZR
	 KzbVqGRt3yVNx2OdPDzCcvQUmKZNZSRuHYUYTEvrcZwcME6DnEiH8p0CyOUOIVrbdF
	 GKyt08oNmN0QAmx3mV9swwfJORT8+hi/na2dvFD72DYh61geQh3j6qWq6uHmWJGYhp
	 jcAQwRZM6HbTw==
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
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/4] eth: bnxt: support RSS on IPv6 Flow Label
Date: Wed, 23 Jul 2025 18:51:00 -0700
Message-ID: <20250724015101.186608-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724015101.186608-1-kuba@kernel.org>
References: <20250724015101.186608-1-kuba@kernel.org>
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
v2:
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
index de8080df69a8..6425955c06d6 100644
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
index 1b37612b1c01..0a7a5d14451d 100644
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
+		else
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
-		else if (!tuple)
-			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
 		break;
 	}
 
-- 
2.50.1



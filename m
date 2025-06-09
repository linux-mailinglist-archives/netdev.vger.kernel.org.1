Return-Path: <netdev+bounces-195808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09AAD250A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BB16F0BA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E733721CC57;
	Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3JmpyZE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2B21CC4A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490496; cv=none; b=TLRux3y74lGq9T5FW5bi6HLxSqhfI48k/3PUfVOcd/5etHTzYe+HB+jCcT6C4Z4ZmoU9uLikKRL20kFvsmd9etDDroXXu1m6CNkkG5jEngOUh+F37a1e0sP9lfdbGmwGNSbzg17FPTpRQ2MQirS0LEp/XSFitfqHfHbUpNz0O8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490496; c=relaxed/simple;
	bh=391SrMseOpHZQ5yxXTsuaVVxLpWrf/Pp9lpPIzveyh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMwagxWpWA+UB67iDDc/lO0AjVlENGY0oK69Rd5aynr6Cg3c1RN1kOIyUR2MxvsHOYf1IJEMY+S6vNLXnELMhfqp69foMaoFqPHvvVu8QH9FdpVQRXZBe/ttYZO6RuwIaN4r9mdJEuCJdU00wfi7BBCWBitcOA9Jp+kW8D6f0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3JmpyZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD44C4CEF7;
	Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490496;
	bh=391SrMseOpHZQ5yxXTsuaVVxLpWrf/Pp9lpPIzveyh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3JmpyZELJSbCU8Y9Y6hvQPfZzruJzcIsYQhnCjqJVV4JPWxWARWlekznc2qGv70g
	 e1HBhD2JeaSIZL7R60Ux8Eul5AH/qUhFNp9PzJw9yFumXaAYLkTjtELnVOckFRfCJj
	 pYzpfBRD3FISuIlbFKrqPUGC+2/55m4/cgqgR+Cieu8PHlqPWMfxO+AY8Gk8P7manw
	 ks/on1clxAnQHrGbhT2mdiPZL4wlHj9dCUg6aDJ8agiYdkH0/hcBjw2yzxdnJiDWwr
	 xND/B0Z6lDNAJNJ+EucUZi0FWU9OVLAhILAmL4u5crNjn/WGpZYgh8Ycg29T8cYBo6
	 ce65U7F0N0cPg==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 4/6] eth: bnxt: support RSS on IPv6 Flow Label
Date: Mon,  9 Jun 2025 10:34:40 -0700
Message-ID: <20250609173442.1745856-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609173442.1745856-1-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
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
CC: michael.chan@broadcom.com
CC: pavan.chebbi@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 ++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 26 ++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

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
index d5495762c945..ae09158db8dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6945,6 +6945,8 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V4_RSS_CAP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V6_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPV6_FLOW_LABEL_CAP)
+			bp->rss_cap |= BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP)
 			bp->fw_cap |= BNXT_FW_CAP_VNIC_RE_FLUSH;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f5d490bf997e..fd9405cadad1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1652,13 +1652,24 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 	u32 rss_hash_cfg = bp->rss_hash_cfg;
 	int tuple, rc = 0;
 
-	if (cmd->data == RXH_4TUPLE)
+	switch (cmd->data) {
+	case RXH_4TUPLE | RXH_IP6_FL:
+	case RXH_4TUPLE:
 		tuple = 4;
-	else if (cmd->data == RXH_2TUPLE)
+		break;
+	case RXH_2TUPLE | RXH_IP6_FL:
+	case RXH_2TUPLE:
 		tuple = 2;
-	else if (!cmd->data)
+		break;
+	case 0:
 		tuple = 0;
-	else
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (cmd->data & RXH_IP6_FL &&
+	    !(bp->rss_cap & BNXT_RSS_CAP_IPV6_FLOW_LABEL_RSS_CAP))
 		return -EINVAL;
 
 	if (cmd->flow_type == TCP_V4_FLOW) {
@@ -1728,6 +1739,13 @@ static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
 		else if (!tuple)
 			rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
+
+		if (cmd->data & RXH_IP6_FL)
+			rss_hash_cfg |=
+				VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
+		else
+			rss_hash_cfg &=
+				~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
 		break;
 	}
 
-- 
2.49.0



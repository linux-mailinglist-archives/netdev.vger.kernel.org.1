Return-Path: <netdev+bounces-208757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A607EB0CF4D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8EF3B51DD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFC1DB377;
	Tue, 22 Jul 2025 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl73LZ2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CC1D90DF
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148974; cv=none; b=Z20bZA5Ps6mO0ruM0ZrZa8GyLiSgDfRSTI/iMq9waQlviJQ8ex7kz+q7trq6AXjOnm9kRLG2/R6q0PJzB4d88VcfJZso6yna7h/4lAlK3HwxLswcpIx1/ZrmFZ704SwO7HpQ7q6iwQIBauijjnhF2xH6j32ZRNFOh/N3UUYCkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148974; c=relaxed/simple;
	bh=1dPRQzI9HIlzlh2l0ZM6UeRNyHUvhmKvsj0ivhE7RuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKeK++lakVm+QQWfcUF2kjR0J6zcJS24hegTEyugkssvTxuO6pAObRvRKORLr0R1L/RXeshEhV/8/ZHSzOgXkGOp+ZVN4S8q2+U1ezHvE4tPtpKje5g7tS32ulZuyspjL5rBX7yajS3L5F2ThNJYj07MajcwbEXN2hnrYwebKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl73LZ2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B65C4CEF9;
	Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148973;
	bh=1dPRQzI9HIlzlh2l0ZM6UeRNyHUvhmKvsj0ivhE7RuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zl73LZ2c1kSil81OCMcvZV6Zcunqtpws6BNvhpgXq/xH9zyJ1GrkrjGc+vlDDCRB/
	 6pMYcCPlXtDqOnw579w8NdBsvEICJvd5GkpIhlESLJuTbv6rigitxvyxUAu6abWRY2
	 mFs5yJMBJVeCQdSheiJG/Fsk589/3r8wLJxx/j3BRRnv5+02HZjDR3cW466nVceQ4J
	 y+dSUsU5/VUxcwfP1KCAm1J0i7qTzfrftCP1h2l3Ceko4xolNb8Irh50d6Qm9w7juz
	 rTNT8kRcbq1xFmALmv4v05jgWj4j8yUd7e/Z4Z0/qaoWD1GI9e9vU7q3earL1upBql
	 N/WSbaP2bjdwg==
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
	gal@nvidia.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/4] eth: bnxt: support RSS on IPv6 Flow Label
Date: Mon, 21 Jul 2025 18:49:14 -0700
Message-ID: <20250722014915.3365370-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014915.3365370-1-kuba@kernel.org>
References: <20250722014915.3365370-1-kuba@kernel.org>
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
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 23 ++++++++++++++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

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
index 1b37612b1c01..4b7213908b76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1582,9 +1582,14 @@ static u64 get_ethtool_ipv4_rss(struct bnxt *bp)
 
 static u64 get_ethtool_ipv6_rss(struct bnxt *bp)
 {
+	u64 rss = 0;
+
 	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6)
-		return RXH_IP_SRC | RXH_IP_DST;
-	return 0;
+		rss |= RXH_IP_SRC | RXH_IP_DST;
+	if (bp->rss_hash_cfg & VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL)
+		rss |= RXH_IP6_FL;
+
+	return rss;
 }
 
 static int bnxt_get_rxfh_fields(struct net_device *dev,
@@ -1662,13 +1667,18 @@ static int bnxt_set_rxfh_fields(struct net_device *dev,
 
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
@@ -1736,6 +1746,13 @@ static int bnxt_set_rxfh_fields(struct net_device *dev,
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
2.50.1



Return-Path: <netdev+bounces-198384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E6ADBECA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3581893C65
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB31B043A;
	Tue, 17 Jun 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3R1xOgB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87741ADC97
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124762; cv=none; b=XQRYGJO498E2rMVBN2y/pGY96bitrMPU+Bwi8RLuRff+uKPfH1f5Ag4XTZEA+UzpfYNMRaqxlso3O5f8NFoZu2ktwNsH/OLBmlOjdmUd0wNTzo6yWmJfF5PCpYSOlLmpeZNqauY0jhMi5ENm27HqIWqTJztcV2QEdBRuP4K4AvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124762; c=relaxed/simple;
	bh=pphlTfM+P17ZVhunIeVh6sUJ8It6mtSWKEfrfpc1bd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GunlA/wIv3gwcnv7o9ze5BqVK2s8zhIhbpOSRHcajk21dK2D89Y3U1mZWIeOqqRNDAYJ/+eXCDBDl3Jqmz6bVkn0H7dwOPC82IlpZTEz8jQaavlfKUHbh1maBurqnhhe+/YZIJGdhXIYvnxX37GtfbqoMzqvHR9iLz1ApY4OksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3R1xOgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C81C4CEF1;
	Tue, 17 Jun 2025 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124762;
	bh=pphlTfM+P17ZVhunIeVh6sUJ8It6mtSWKEfrfpc1bd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3R1xOgBSI2PoXzRl7VsytWwNZayQiDm7+0B9SRWkPOBLsFquihCFkhSukrESWFmF
	 ZUymlk07Jj8G3KD6RycMM6EWdGdgZ/BsEW5hhJmR7oX8ZylfpUvxW/HzmmBEQqpOs5
	 9smM7WV5q3JZ2PtMoHCXX8Ued32sHL+4/OXN4Go2Jqn2yPORVW4XniySPSQIJlG/IV
	 5W3LXfEC149ngTG0eMaKxDzje9SER8yIQ0wo2y/3y69a63ug4TXOZlFbKbrPhrpn1H
	 tKXmGg/QCdTmROxFJwslEOL3wkWIM/sO0Zpu9rfuQpKB24f17ZbEkLt0gEysH3cgL1
	 F672ufTruEUJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] eth: bnxt: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:52 -0700
Message-ID: <20250617014555.434790-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014555.434790-1-kuba@kernel.org>
References: <20250617014555.434790-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f5d490bf997e..4c10373abffd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1587,8 +1587,11 @@ static u64 get_ethtool_ipv6_rss(struct bnxt *bp)
 	return 0;
 }
 
-static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
+static int bnxt_get_rxfh_fields(struct net_device *dev,
+				struct ethtool_rxfh_fields *cmd)
 {
+	struct bnxt *bp = netdev_priv(dev);
+
 	cmd->data = 0;
 	switch (cmd->flow_type) {
 	case TCP_V4_FLOW:
@@ -1647,10 +1650,15 @@ static int bnxt_grxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 #define RXH_4TUPLE (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)
 #define RXH_2TUPLE (RXH_IP_SRC | RXH_IP_DST)
 
-static int bnxt_srxfh(struct bnxt *bp, struct ethtool_rxnfc *cmd)
+static int bnxt_set_rxfh_fields(struct net_device *dev,
+				const struct ethtool_rxfh_fields *cmd,
+				struct netlink_ext_ack *extack)
 {
-	u32 rss_hash_cfg = bp->rss_hash_cfg;
+	struct bnxt *bp = netdev_priv(dev);
 	int tuple, rc = 0;
+	u32 rss_hash_cfg;
+
+	rss_hash_cfg = bp->rss_hash_cfg;
 
 	if (cmd->data == RXH_4TUPLE)
 		tuple = 4;
@@ -1768,10 +1776,6 @@ static int bnxt_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		rc = bnxt_grxclsrule(bp, cmd);
 		break;
 
-	case ETHTOOL_GRXFH:
-		rc = bnxt_grxfh(bp, cmd);
-		break;
-
 	default:
 		rc = -EOPNOTSUPP;
 		break;
@@ -1786,10 +1790,6 @@ static int bnxt_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	int rc;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		rc = bnxt_srxfh(bp, cmd);
-		break;
-
 	case ETHTOOL_SRXCLSRLINS:
 		rc = bnxt_srxclsrlins(bp, cmd);
 		break;
@@ -5521,6 +5521,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 	.get_rxfh_key_size      = bnxt_get_rxfh_key_size,
 	.get_rxfh               = bnxt_get_rxfh,
 	.set_rxfh		= bnxt_set_rxfh,
+	.get_rxfh_fields        = bnxt_get_rxfh_fields,
+	.set_rxfh_fields        = bnxt_set_rxfh_fields,
 	.create_rxfh_context	= bnxt_create_rxfh_context,
 	.modify_rxfh_context	= bnxt_modify_rxfh_context,
 	.remove_rxfh_context	= bnxt_remove_rxfh_context,
-- 
2.49.0


